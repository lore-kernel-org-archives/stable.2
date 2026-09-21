Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C547148EC97
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983197; cv=none; b=tRmpSztplgoZpgLk6DPQdmWxQHJ3TGi1ujLcDq2Q7t4tdcZImO054enqBdf3ZTT0jmY76U7vEiWU33bI27Oi6FchYrxlVcTnuhg2ylif4/m8ZFJJt9rJNffn/o5t2xoLBjQdDOiqvumP2HA6WkjxzeEtM8VP5HjUUZUD2o7Qsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983197; c=relaxed/simple;
	bh=SusWxfWm0euycUw5XJOnFl9NQy9l6pf5PbijN25AIMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8BFAYfSL38zlrne3NZJeigEV/hNSD+jfguYYbxNoBXkCl6iZuvm6GHEdYSaT4oiQ1fApfJ496h366MZgo1dJDsziSFXhgqum4S5jRP3o4LiA97W04mztHr+lfBL+1VirwefYjK/X7V3R8yX0/vhM4Sx+u9knVyBzv/Wl5k9zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=DY8PSS5y; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="DY8PSS5y"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260921093301a6635b791b0002072a
        for <stable@vger.kernel.org>;
        Mon, 21 Sep 2026 11:33:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z9qU8at1gteUv+EZTN60L+eBKKac7xQWHAVXF6jkTQc=;
 b=DY8PSS5yui0ZfGGqnnfBSSN2vSJMCh3l+jWuL0iLQLIlmj2xAuDbDZq8ROOQtzueVRgfNJ
 il4rHjsPQ8gvnYGVE4cvG5qEPE+29Tlr70RD2Bk4B1NSlc1yewQgN+gpuXBOpFOsPbde1C++
 wV4leIqhrAPcvr07PonQeZOjNHJkpHsWakCy9wepWYIGWoO3wVIieJPAIjrMU7A7o1Lolnju
 aX+Q995cleNQDG3Zz0p8GGYeLdVKrbfX8rJlFPqk+EhHwv0LGKHfrp9W6vzmu6SxdBr+dZOb
 nvM4mmm9ND8utOHfnh9WVI13boInVEfolNjqrNIX+qBb3ys0mDnW/tFA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-leds@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] leds: trigger: netdev: Fix sysfs_update_group() races
Date: Mon, 21 Sep 2026 11:32:45 +0200
Message-ID: <20260921093249.3481413-4-alexander.sverdlin@siemens.com>
In-Reply-To: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
References: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The link_speed attribute group was listed in netdev_led_trigger.groups,
so the LED core creates and destroys it via device_add_groups() /
device_remove_groups() in led_trigger_set() (under trigger_lock), while
the trigger also refreshes it with sysfs_update_group() from
netdev_trig_notify() and device_name writes.  With no shared lock this was
observed as a sysfs splat when the trigger is re-armed during PHY link-up:

  sysfs: cannot create duplicate filename '...green:lan/link_10'

    CPU 0 (led_trigger_set)        CPU 1 (linkwatch workqueue)
    -----------------------        ---------------------------
    activate():
      register_netdevice_notifier()
    .                              netdev_trig_notify(NETDEV_CHANGE):
    .                                sysfs_update_group() creates "link_10"
    device_add_groups()
      creates "link_10"  <- EEXIST!

The mirror case (device_remove_groups() racing the notifier) leaves an
orphaned sysfs file pointing at freed trigger_data, i.e. a UAF.

Manage the group in the trigger: drop it from netdev_led_trigger.groups
and create/destroy it in activate()/deactivate(), so the LED core never
touches it.  The two remaining refreshers, netdev_trig_notify() and
device_name_store(), are serialized against each other by a dedicated
attr_lock, and the is_visible callback takes trigger_data->lock for its
supported_link_modes read.  sysfs_update_group() is never called under
trigger_data->lock, so it cannot deadlock against a concurrent link_*
store that takes that lock.

Cc: stable@vger.kernel.org
Fixes: 06cdca014eca ("leds: trigger: netdev: Display only supported link speed attribute")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2:
- this patch is a combined rework of patches 1&2 from v1

 drivers/leds/trigger/ledtrig-netdev.c | 42 ++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 8b807451b642d..54c6913f3afe3 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -57,6 +57,8 @@
 
 struct led_netdev_data {
 	struct mutex lock;
+	/* Serializes link_speed group refreshes; never taken by attr stores */
+	struct mutex attr_lock;
 
 	struct delayed_work work;
 	struct notifier_block notifier;
@@ -336,8 +338,9 @@ static ssize_t device_name_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	/* Refresh link_speed visibility */
-	sysfs_update_group(&dev->kobj, &netdev_trig_link_speed_attrs_group);
+	/* Serialize the link_speed visibility refresh against netdev_trig_notify() */
+	scoped_guard(mutex, &trigger_data->attr_lock)
+		sysfs_update_group(&dev->kobj, &netdev_trig_link_speed_attrs_group);
 
 	return size;
 }
@@ -547,6 +550,7 @@ static umode_t netdev_trig_link_speed_visible(struct kobject *kobj,
 	 * Stop at the first matching entry as we care only to check if a particular
 	 * speed is supported and not the kind.
 	 */
+	guard(mutex)(&trigger_data->lock);
 	for_each_set_bit(mode, supported_link_modes, __ETHTOOL_LINK_MODE_MASK_NBITS) {
 		struct ethtool_link_ksettings link_ksettings;
 
@@ -606,7 +610,6 @@ static const struct attribute_group netdev_trig_attrs_group = {
 
 static const struct attribute_group *netdev_trig_groups[] = {
 	&netdev_trig_attrs_group,
-	&netdev_trig_link_speed_attrs_group,
 	NULL,
 };
 
@@ -654,10 +657,6 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		fallthrough;
 	case NETDEV_CHANGE:
 		get_device_state(trigger_data);
-		/* Refresh link_speed visibility */
-		if (evt == NETDEV_CHANGE)
-			sysfs_update_group(&led_cdev->dev->kobj,
-					   &netdev_trig_link_speed_attrs_group);
 		break;
 	}
 
@@ -665,6 +664,12 @@ static int netdev_trig_notify(struct notifier_block *nb,
 
 	mutex_unlock(&trigger_data->lock);
 
+	if (evt == NETDEV_CHANGE) {
+		guard(mutex)(&trigger_data->attr_lock);
+		sysfs_update_group(&led_cdev->dev->kobj,
+				   &netdev_trig_link_speed_attrs_group);
+	}
+
 	return NOTIFY_DONE;
 }
 
@@ -747,6 +752,7 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 		return -ENOMEM;
 
 	mutex_init(&trigger_data->lock);
+	mutex_init(&trigger_data->attr_lock);
 
 	trigger_data->notifier.notifier_call = netdev_trig_notify;
 	trigger_data->notifier.priority = 10;
@@ -780,12 +786,23 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 
 	led_set_trigger_data(led_cdev, trigger_data);
 
+	rc = sysfs_create_group(&led_cdev->dev->kobj,
+				&netdev_trig_link_speed_attrs_group);
+	if (rc)
+		goto err_free;
+
 	rc = register_netdevice_notifier(&trigger_data->notifier);
-	if (rc) {
-		dev_put(trigger_data->net_dev);
-		kfree(trigger_data);
-	}
+	if (rc)
+		goto err_remove_group;
 
+	return 0;
+
+err_remove_group:
+	sysfs_remove_group(&led_cdev->dev->kobj,
+			   &netdev_trig_link_speed_attrs_group);
+err_free:
+	dev_put(trigger_data->net_dev);
+	kfree(trigger_data);
 	return rc;
 }
 
@@ -795,6 +812,9 @@ static void netdev_trig_deactivate(struct led_classdev *led_cdev)
 
 	unregister_netdevice_notifier(&trigger_data->notifier);
 
+	sysfs_remove_group(&led_cdev->dev->kobj,
+			   &netdev_trig_link_speed_attrs_group);
+
 	cancel_delayed_work_sync(&trigger_data->work);
 
 	dev_put(trigger_data->net_dev);
-- 
2.55.0

