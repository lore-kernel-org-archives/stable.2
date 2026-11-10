Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313969;
	b=kvUUZQok86M67LfSj5VBasL0+NooPoB2UfDs6celPjL8qD9nyiB1yx556wl4bWQbFtJs
	 /dchnBJbF8c6dWpAXRsxVlumnkc1ErSOEcVe9K5x2vqYo0mmU7LAwjSHajgh+wL1JJIq9
	 5jOp9Bw/ciScIOqDOYgYaFaBtEh/+QCXn6m9IJO6qKsnZrrjlgh8reteKEN1zb3tPwit0
	 pPnwU/HnXhzEhqIMKfiBCLg1416EGYbEth8yZ2Ulh/WoTohy7ZH2KVWGyanM/uVcCxnRY
	 OPX5IM9BN3esLlL90RyqIOBipiL8sHdkmQXVBIT09Eslyt5SiuNv3uBNYO/ipYpVMLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313969;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sQXSsT4WBF/N08WgnvFzvS+W6m23Oj2zYeyAcujIwH0=;
	b=n6DJrc5ZEc48mI0GRurfc1fIkVKccMm83ppYhfVQwEMoFapF850+62Ydt9/Z3gWzboDy
	 KF2MLge2HJT9bzSvVgnP+jlvvuHf3HkVFQdPz+nkMbl+ar+8+TAWWkEBM3vFWNLVVOqGr
	 SMztT9JZXV+uWUE4wKzuyZM6CR6Lg+ArSbTYge+KPM0LJtVSWK+w4TMMQMf5W5A3ZrEE4
	 siT7sS3RwB9JOQCES0FFYpecDXiXVkgHQUNBg3iP7xlu8f68TKW6FnYZbOAv6f7iKfBzo
	 tSF051OqbkaTjgKfFrcCuOkptZTY8vUcDE3YEjuPcm2qKvK0hyLkciy3WgwH9Qv4x5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=ksJ3yT1f;
	arc=none smtp.remote-ip=79.135.106.25
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCA606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55FCA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=ksJ3yT1f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794313964; x=1794573164;
	bh=sQXSsT4WBF/N08WgnvFzvS+W6m23Oj2zYeyAcujIwH0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ksJ3yT1fLilfN6G4cP3Z1mUT/U4CAyLtCPRbI00qouKkaqKQOg6loCx/h+rCfpHSu
	 PRFulT/qtaZ08D1tXTJtB8G76Rb5HvFdr3KVN3hZEWIEXI0hbeT4B07rtFwO1KeNeY
	 8Lxw6+rs3RrPYsoNn3xHCst/WdBsAxEz1iE2p091q320XkyDOgFa7+d0SrdBlchC/a
	 oQwUjMU1IscP18RYssueQM2zMYIhfxg0WnfTJdYWC4wm83SKzb9GhGWDsjq1q7fcpU
	 6g6++IufcRe4SfmyQ9x/MOX0TbJ4i8Kgq0iEL/L7p5lz8SARQEJprPOzC+gstDEk4E
	 21Hf8cqre/MOw==
Date: Tue, 10 Nov 2026 12:32:40 +0000
To: Dan Callaghan <dcallagh@chromium.org>, Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: =?utf-8?Q?Sami_Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>, chrome-platform@lists.linux.dev, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/chrome: cros_hps_i2c: fix use-after-free in release() after unbind
Message-ID: <20261110123230.1251547-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 886e3cea0d8b9aeaf3fc366b4c2ef5f025234e47
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
holds one reference and each open file another. remove() marks hps
removed and drops the runtime PM references that open files still hold,
before it disables runtime PM, so a release() after that only drops its
reference to hps. A file opened before an unbind then no longer affects
the device, including after the driver is bound again.

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
v2:
- Follow Tzung-Bi's suggestion: reference-count hps and have remove()
  drop the runtime PM references of files that are still open, instead
  of holding the client device for each open file. A file left open
  across an unbind and rebind no longer affects the new binding.
- One mutex protects open_count and removed, in place of the rwsem and
  atomic_t in the suggestion. open() cannot run concurrently with
  remove() (see the changelog), so the lock only orders release()
  against remove() and against other opens and releases, which are
  rare.
- Not converted to revocable, which is not in mainline yet; this
  version can go to stable.
- Subject changed to name the bug.
v1: https://lore.kernel.org/r/20261107185258.4115770-2-ca@modelmiser.com

Reproduced in QEMU 10.2.4 (q35, KASAN) as for v1: the driver binds to a
client created with new_device on the i801 SMBus adapter, with the
"enable" GPIO supplied by gpio-mockup through a test-only lookup
module. A process opens /dev/cros-hps, the client is unbound or deleted
through sysfs, and the process then closes the file. Without this patch
KASAN reports one use-after-free after an unbind and six after
delete_device; with it there are none, also with lockdep enabled. A
test-only print in the free path showed hps freed at the last close
after an unbind or delete_device, and in remove() when no file was
open. With a file left open across an unbind and bind, runtime_usage
reads 1 with both files open, 0 after closing the new file and 0 after
closing the old one (2, 1 and 0 without the patch). Not tested on HPS
hardware, and a release() racing remove() was not exercised. Unbinding
or deleting the client needs root.

For stable, before v7.0 this conflicts in two places: there is no
kzalloc_obj(), so probe should use kzalloc(sizeof(*hps), GFP_KERNEL),
and hps_release() ends in "return pm_runtime_put(dev);", which the new
release() body replaces.

The code, changelog and reproducer were written with an AI assistant
(Claude Opus 5.5), working from Tzung-Bi's suggested structure, and
the assistant ran the tests above. I ran the final version myself and
got the same results.

 drivers/platform/chrome/cros_hps_i2c.c | 75 ++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/chro=
me/cros_hps_i2c.c
index 3b9485627831..bff063f58777 100644
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
@@ -24,8 +27,27 @@ struct hps_drvdata {
 =09struct i2c_client *client;
 =09struct miscdevice misc_device;
 =09struct gpio_desc *enable_gpio;
+
+=09/* hps outlives the driver binding while files are open. */
+=09struct kref kref;
+=09/*
+=09 * Protects open_count and removed. Once removed is set, release()
+=09 * leaves the device alone: remove() has dropped the files' runtime PM
+=09 * references.
+=09 */
+=09struct mutex lock;
+=09unsigned int open_count;
+=09bool removed;
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
@@ -36,18 +58,33 @@ static int hps_open(struct inode *inode, struct file *f=
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
+=09if (!hps->removed) {
+=09=09hps->open_count--;
+=09=09pm_runtime_put(&hps->client->dev);
+=09}
+=09mutex_unlock(&hps->lock);
=20
+=09kref_put(&hps->kref, hps_free);
 =09return 0;
 }
=20
@@ -62,10 +99,13 @@ static int hps_i2c_probe(struct i2c_client *client)
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
@@ -83,32 +123,49 @@ static int hps_i2c_probe(struct i2c_client *client)
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
+=09hps->removed =3D true;
+=09while (hps->open_count) {
+=09=09hps->open_count--;
+=09=09pm_runtime_put_noidle(&client->dev);
+=09}
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


