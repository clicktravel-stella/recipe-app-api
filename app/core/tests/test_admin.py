from django.test import TestCase, Client
from django.contrib.auth import get_user_model
from django.urls import reverse


class AdminSiteTests(TestCase):

    def setUp(self):
        self.client = Client()
        self.admin_user = get_user_model().objects.create_superuser(
            email='admin@hotmail.com',
            password='test1234'
        )
# force login is helper function from Client which users django authentication
# Means we don't have to manually log users in
        self.client.force_login(self.admin_user)
        self.user = get_user_model().objects.create_user(
            email='admin@hotmail.com',
            password='test1234',
            name='Test user full name'
        )

    def test_users_listed(self):
        """Test that users are listed on user page"""
        url = reverse('admin:core_user_changeList')
        res = self.client.get(url)

        self.assertContains(res, self.user.name)
        self.assertContains(res, self.user.email)
