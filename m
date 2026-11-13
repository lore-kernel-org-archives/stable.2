Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555246;
	b=W1vCyJsDOUdyLAiBFNDlclpwrI4E6UKxBMQ8CNP3Ibut1RANgujtFu7o0BRpvVqXd0vN
	 L147UH3ocQaUfJ0kxaMOId8jGVvYCxu+xRsH5CvWSq8Qyd/CN8UP1xzU6AD1IslBJVC0Z
	 Kr4ROhTo51C+qlGs3Zzo2dpKOvbcWoRO0QTflxjX6uyqkkmULxfDCi/RiaxQF/JgEHUab
	 KYTbQM4AqyyCQA+qT/s/u1VnFyFjTNolvvzWcXeZeIt9rYtftGqEL/Si+htLREuVIyoFx
	 xFAQHkrkOMyYFvXBJAlGss0O6OpsH8x8CquCEBZTasA2J7LqwTC+Sl5KIKS7JZNZTyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555246;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BWopIb+RX1nT2wLoMblTDLqAHrxPUctNz/knG0fkEXk=;
	b=XavYxzcPSdN1ClvZVQbJMd+fMmgIfrUgHcbFT29pPNyvmB2ArmHHHO0I2J7V8EPk1uyH
	 PsbJE8JrtNG3I5GzvPEs7vj1ZlrKC/gByPN6jPzZMEOjlpZg5+mSvwDT3/mxeIkQQfBf6
	 Tpg4WZJqyQfzfB2clWcC+9TYK67yfVigNJbPTCjiqvdzW1A7LYjjJWlU6OZU0OaP909S5
	 Uhwzy0OpiHfebKq24dV/kvKCHI1bYjG7XLx1Ym9/NF9YNEUyDQXZkuF/asM9iEkHFNIEB
	 jGuIMmdlJvZzzsxCJ3vf7zDVQWqVguLabhBHzYcvS/5WYWnzwJfq53iTddlogyuu2fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=M7iQg5bl;
	arc=none smtp.remote-ip=79.135.106.26
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45915606A31C;
	Fri, 13 Nov 2026 07:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45915606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=M7iQg5bl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794555241; x=1794814441;
	bh=BWopIb+RX1nT2wLoMblTDLqAHrxPUctNz/knG0fkEXk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=M7iQg5blFrHJYQE8ecrVsusSY1YKy5xIOnl6DvCGDWhNdIHrA8ySVtJjSyzjY9sZX
	 bSwp0v6UtS6lR0vLHA3T5bl22ZDfrU3d9yVjIH8dH2W9LrCVNdZBF29Hdv3WKOMk+F
	 Q/T9H6i0RZTBnmSg5Od/zgnJxEw86j+tWiQHUCm1yqcDYoahVLkchJFz4GGAfpTErR
	 TRiUL0x1rQDDUWwoVHq45lHi3+93OSLBxUE1ilr/vO50oGmBJGve/Jhc62MbL6f2JB
	 LV1lOo1dGNIhX5udJvW2KpFl5DPgAWGULEoRp43tiYnyk/uOg6xI50K3TN8MBLvO26
	 +GKm1JJQMK/tA==
Date: Fri, 13 Nov 2026 07:33:58 +0000
To: Dan Callaghan <dcallagh@chromium.org>, Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: =?utf-8?Q?Sami_Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>, chrome-platform@lists.linux.dev, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] platform/chrome: cros_hps_i2c: fix use-after-free in release() after unbind
Message-ID: <20261113073351.805165-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 46a50cc48e1df18c33adfa8f70fa9899685ece0e
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hps_release() finds struct hps_drvdata through file->private_data and
calls pm_runtime_put() on hps->client->dev. hps comes from
devm_kzalloc(), so it is freed when the driver is unbound, and a later
close() of a file opened before the unbind reads freed memory. If the
client was removed with delete_device, the i2c_client may have been
freed as well, and pm_runtime_put() runs on it.

Allocate hps with kzalloc_obj() and reference-count it: the binding
holds one reference and each open file another. remove() drops the
runtime PM references that open files still hold and sets hps->client to
NULL, before it disables runtime PM, so a release() after that only
drops its reference to hps. A file opened before an unbind then no
longer affects the device, including after the driver is bound again.

remove() now calls misc_deregister() first: misc_open() calls
hps_open() with misc_mtx held, and misc_deregister() takes misc_mtx and
unlists the device, so once it returns no open() is in progress and
none can start. The open count that remove() then drains cannot grow
again.

Fixes: 5f9952548d91 ("platform/chrome: add a driver for HPS")
Cc: stable@vger.kernel.org
Suggested-by: Tzung-Bi Shih <tzungbi@kernel.org>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
v3:
- Use hps->client, set to NULL in remove(), to tell release() that the
  device has gone, in place of the removed flag (Tzung-Bi).
- Based on chrome-platform for-next (71c3b4fe7391). In mainline,
  4dd10fbbeb9c ("treewide: Convert devm_kmalloc() family to the
  devm_kmalloc_obj() family") changes the line this patch replaces to
  devm_kzalloc_obj(&client->dev, *hps); the result is kzalloc_obj()
  either way.
v2: https://lore.kernel.org/r/20261110123230.1251547-2-ca@modelmiser.com
- Follow Tzung-Bi's suggestion: reference-count hps and have remove()
  drop the runtime PM references of files that are still open, instead
  of holding the client device for each open file.
- One mutex in place of the rwsem and atomic_t in the suggestion.
- Not converted to revocable, which is not in mainline yet; this
  version can go to stable.
v1: https://lore.kernel.org/r/20261107185258.4115770-2-ca@modelmiser.com

Tested in QEMU 10.2.4 (q35, KASAN, lockdep) with the reproducer from v2:
a file is held open across an unbind of the client, across a
delete_device, and across an unbind and bind, and in a fourth run it is
closed before the client is deleted. There are no KASAN reports, lockdep
reports or warnings in any of the four, and across the unbind and bind
runtime_usage reads 1, 0 and 0, as with v2. With the line that sets
hps->client to NULL removed, the delete_device run reports
use-after-free in __pm_runtime_idle() and the unbind run a runtime PM
usage count underflow. Not tested on HPS hardware, and a release()
racing remove() was not exercised. Unbinding or deleting the client
needs root.

For stable, before v7.0 hps_release() ends in
"return pm_runtime_put(dev);", so the release() hunk conflicts, and
there is no kzalloc_obj(), so probe() needs kzalloc(sizeof(*hps),
GFP_KERNEL) to build.

The code, changelog and reproducer were written with an AI assistant
(Claude Opus 5.5), and the assistant ran the tests above. I ran the
final version myself and got the same results.

 drivers/platform/chrome/cros_hps_i2c.c | 74 ++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/chro=
me/cros_hps_i2c.c
index 3b9485627831..436afc4f50d3 100644
--- a/drivers/platform/chrome/cros_hps_i2c.c
+++ b/drivers/platform/chrome/cros_hps_i2c.c
@@ -14,9 +14,12 @@
 #include <linux/fs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
=20
 #define HPS_ACPI_ID=09=09"GOOG0020"
=20
@@ -24,8 +27,26 @@ struct hps_drvdata {
 =09struct i2c_client *client;
 =09struct miscdevice misc_device;
 =09struct gpio_desc *enable_gpio;
+
+=09/* hps outlives the driver binding while files are open. */
+=09struct kref kref;
+=09/*
+=09 * Protects open_count, and client against remove(). remove() sets
+=09 * client to NULL after dropping the files' runtime PM references;
+=09 * release() then leaves the device alone.
+=09 */
+=09struct mutex lock;
+=09unsigned int open_count;
 };
=20
+static void hps_free(struct kref *kref)
+{
+=09struct hps_drvdata *hps =3D container_of(kref, struct hps_drvdata, kref=
);
+
+=09mutex_destroy(&hps->lock);
+=09kfree(hps);
+}
+
 static void hps_set_power(struct hps_drvdata *hps, bool state)
 {
 =09gpiod_set_value_cansleep(hps->enable_gpio, state);
@@ -36,18 +57,33 @@ static int hps_open(struct inode *inode, struct file *f=
ile)
 =09struct hps_drvdata *hps =3D container_of(file->private_data,
 =09=09=09=09=09       struct hps_drvdata, misc_device);
 =09struct device *dev =3D &hps->client->dev;
+=09int ret;
+
+=09ret =3D pm_runtime_resume_and_get(dev);
+=09if (ret)
+=09=09return ret;
=20
-=09return pm_runtime_resume_and_get(dev);
+=09mutex_lock(&hps->lock);
+=09hps->open_count++;
+=09mutex_unlock(&hps->lock);
+
+=09kref_get(&hps->kref);
+=09file->private_data =3D hps;
+=09return 0;
 }
=20
 static int hps_release(struct inode *inode, struct file *file)
 {
-=09struct hps_drvdata *hps =3D container_of(file->private_data,
-=09=09=09=09=09       struct hps_drvdata, misc_device);
-=09struct device *dev =3D &hps->client->dev;
+=09struct hps_drvdata *hps =3D file->private_data;
=20
-=09pm_runtime_put(dev);
+=09mutex_lock(&hps->lock);
+=09if (hps->client) {
+=09=09hps->open_count--;
+=09=09pm_runtime_put(&hps->client->dev);
+=09}
+=09mutex_unlock(&hps->lock);
=20
+=09kref_put(&hps->kref, hps_free);
 =09return 0;
 }
=20
@@ -62,10 +98,13 @@ static int hps_i2c_probe(struct i2c_client *client)
 =09struct hps_drvdata *hps;
 =09int ret;
=20
-=09hps =3D devm_kzalloc(&client->dev, sizeof(*hps), GFP_KERNEL);
+=09hps =3D kzalloc_obj(*hps);
 =09if (!hps)
 =09=09return -ENOMEM;
=20
+=09kref_init(&hps->kref);
+=09mutex_init(&hps->lock);
+
 =09hps->misc_device.parent =3D &client->dev;
 =09hps->misc_device.minor =3D MISC_DYNAMIC_MINOR;
 =09hps->misc_device.name =3D "cros-hps";
@@ -83,32 +122,49 @@ static int hps_i2c_probe(struct i2c_client *client)
 =09if (IS_ERR(hps->enable_gpio)) {
 =09=09ret =3D PTR_ERR(hps->enable_gpio);
 =09=09dev_err(&client->dev, "failed to get enable gpio: %d\n", ret);
-=09=09return ret;
+=09=09goto err_put;
 =09}
=20
 =09ret =3D misc_register(&hps->misc_device);
 =09if (ret) {
 =09=09dev_err(&client->dev, "failed to initialize misc device: %d\n", ret)=
;
-=09=09return ret;
+=09=09goto err_put;
 =09}
=20
 =09hps_set_power(hps, false);
 =09pm_runtime_enable(&client->dev);
 =09return 0;
+
+err_put:
+=09kref_put(&hps->kref, hps_free);
+=09return ret;
 }
=20
 static void hps_i2c_remove(struct i2c_client *client)
 {
 =09struct hps_drvdata *hps =3D i2c_get_clientdata(client);
=20
-=09pm_runtime_disable(&client->dev);
+=09/* After misc_deregister(), no open() is running or can start. */
 =09misc_deregister(&hps->misc_device);
=20
+=09/* Drop the runtime PM references of files that are still open. */
+=09mutex_lock(&hps->lock);
+=09while (hps->open_count) {
+=09=09hps->open_count--;
+=09=09pm_runtime_put_noidle(&client->dev);
+=09}
+=09hps->client =3D NULL;
+=09mutex_unlock(&hps->lock);
+
+=09pm_runtime_disable(&client->dev);
+
 =09/*
 =09 * Re-enable HPS, in order to return it to its default state
 =09 * (i.e. powered on).
 =09 */
 =09hps_set_power(hps, true);
+
+=09kref_put(&hps->kref, hps_free);
 }
=20
 static int hps_suspend(struct device *dev)
--=20
2.43.0


