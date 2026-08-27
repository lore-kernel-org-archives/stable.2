Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AF3E835E;
	Thu, 27 Aug 2026 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821726; cv=none; b=lpzUiYw4VbRVVqMuLfZNwpTfOE2mfnnozz4E6IYSemwWpCDbLa6il6h2Zzn7avqAYkuh+SIQruY3StmiQs1Bh41nOOLwpV/T3cUsGwtIszWW6tYxHnd8hiYRWgB7vtBLrxMaaK25sZAl+we+OpGJHakiqGLyRF0tChZIXD7TP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821726; c=relaxed/simple;
	bh=4787ZnHZ6YTIRSvWSls19SZyHGiiVuZ7+8lwIGiAPrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLf0gp5BeSNECtCxCm1CTwBBMoJeBM6nxsl3uufaC2dJtaHJ8fK3mU/t0IuePAa5b0KyiNcaSXuZAvw+SYpNHUvnnUiDvGtIiBH23p5hCsZZYiZQ6dxFr1B5MJ8a5LOcwIike2FszI5XkFvnHteYPhiLp7s/dJnTHd8tbjrd3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5x9DIpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5x9DIpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C111F00A3A;
	Thu, 27 Aug 2026 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787821722;
	bh=uMuQFE4jZ84ox+X7P6Q1JZqLqanxrdsEZvNGyQngblQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N5x9DIprcsYiYO4FPi6WR3MV6s6vR1SA7mH4S+8xtCB70v+Esztdh+PIoa3x4Npfw
	 OwgFxxzRFbNY4AS1jGm0QILtYR7qiPec+EjZQ4TFH7DgA2wQpC8o30O0MtvNf44VWj
	 MEyzP3sk9SfHxy+TscEgOqnF9YfLWWwX7DPqhKeky3wIjk2hT4sAz/RNsKFLjQdRKv
	 BTusmhkGvFmpPYamYgbP0NBlCiqdjNrSosyXd+SKOM+X4yrsaPHT0knSUCwvZr3i/k
	 BYb5VHjVepM+pO2zBcEWzOik9hy2s9hxmQRXLqQ4lG4E+0pLgyMvEpZ7NL7OycD3Vm
	 5PBdttd7Ztopg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzW6C-00000002g8F-0qh4;
	Thu, 27 Aug 2026 11:08:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] i2c: dev: fix blocked adapter deregistration
Date: Thu, 27 Aug 2026 11:08:02 +0200
Message-ID: <20260827090804.638565-2-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827090804.638565-1-johan@kernel.org>
References: <20260827090804.638565-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i2c subsystem allows controllers to be used by non-child devices
that may remain registered after an adapter goes away.

To handle this, adapter deregistration blocks until the last reference
to the adapter is released. Albeit unorthodox, this is mostly fine for
the vast majority of controllers but can cause some trouble when
controllers reside on hotpluggable buses.

Specifically, userspace can prevent an adapter from being deregistered
indefinitely by holding an i2c-dev character device file open. And with
USB attached controllers this prevents further hub events from being
processed by the parent hub until the file is closed.

Fix the i2c-dev implementation by dropping the additional reference
taken at open() and using an rwsem to make sure the adapter is only
accessed while registered.

Note that before commit 611e12ea0f12 ("i2c: core: manage i2c bus device
refcount in i2c_[get|put]_adapter") an adapter going away would instead
have resulted in a use-after-free.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-dev.c | 97 +++++++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ccaac5e29f90..05616249f61b 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -41,11 +42,17 @@
  */
 struct i2c_dev {
 	struct list_head list;
+	struct rw_semaphore rwsem;
 	struct i2c_adapter *adap;
 	struct device dev;
 	struct cdev cdev;
 };
 
+struct i2c_dev_data {
+	struct i2c_dev *i2c_dev;
+	struct i2c_client client;
+};
+
 #define I2C_MINORS	(MINORMASK + 1)
 static LIST_HEAD(i2c_dev_list);
 static DEFINE_SPINLOCK(i2c_dev_list_lock);
@@ -90,8 +97,14 @@ static void put_i2c_dev(struct i2c_dev *i2c_dev, bool del_cdev)
 	spin_lock(&i2c_dev_list_lock);
 	list_del(&i2c_dev->list);
 	spin_unlock(&i2c_dev_list_lock);
-	if (del_cdev)
+	if (del_cdev) {
 		cdev_device_del(&i2c_dev->cdev, &i2c_dev->dev);
+
+		scoped_guard(rwsem_write, &i2c_dev->rwsem) {
+			i2c_dev->adap = NULL;
+		}
+	}
+
 	put_device(&i2c_dev->dev);
 }
 
@@ -134,10 +147,16 @@ ATTRIBUTE_GROUPS(i2c);
 static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
 		loff_t *offset)
 {
+	struct i2c_dev_data *data = file->private_data;
+	struct i2c_client *client = &data->client;
+	struct i2c_dev *i2c_dev = data->i2c_dev;
 	char *tmp;
 	int ret;
 
-	struct i2c_client *client = file->private_data;
+	guard(rwsem_read)(&i2c_dev->rwsem);
+
+	if (!i2c_dev->adap)
+		return -ENODEV;
 
 	/* Adapter must support I2C transfers */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -163,9 +182,16 @@ static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
 static ssize_t i2cdev_write(struct file *file, const char __user *buf,
 		size_t count, loff_t *offset)
 {
+	struct i2c_dev_data *data = file->private_data;
+	struct i2c_client *client = &data->client;
+	struct i2c_dev *i2c_dev = data->i2c_dev;
 	int ret;
 	char *tmp;
-	struct i2c_client *client = file->private_data;
+
+	guard(rwsem_read)(&i2c_dev->rwsem);
+
+	if (!i2c_dev->adap)
+		return -ENODEV;
 
 	/* Adapter must support I2C transfers */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -397,11 +423,15 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
 	return res;
 }
 
-static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long i2cdev_ioctl_locked(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct i2c_client *client = file->private_data;
+	struct i2c_dev_data *data = file->private_data;
+	struct i2c_client *client = &data->client;
+	struct i2c_dev *i2c_dev = data->i2c_dev;
 	unsigned long funcs;
 
+	lockdep_assert_held(&i2c_dev->rwsem);
+
 	dev_dbg(&client->adapter->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n",
 		cmd, arg);
 
@@ -507,6 +537,19 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
+static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct i2c_dev_data *data = file->private_data;
+	struct i2c_dev *i2c_dev = data->i2c_dev;
+
+	guard(rwsem_read)(&i2c_dev->rwsem);
+
+	if (!i2c_dev->adap)
+		return -ENODEV;
+
+	return i2cdev_ioctl_locked(file, cmd, arg);
+}
+
 #ifdef CONFIG_COMPAT
 
 struct i2c_smbus_ioctl_data32 {
@@ -530,8 +573,16 @@ struct i2c_rdwr_ioctl_data32 {
 
 static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct i2c_client *client = file->private_data;
+	struct i2c_dev_data *data = file->private_data;
+	struct i2c_client *client = &data->client;
+	struct i2c_dev *i2c_dev = data->i2c_dev;
 	unsigned long funcs;
+
+	guard(rwsem_read)(&i2c_dev->rwsem);
+
+	if (!i2c_dev->adap)
+		return -ENODEV;
+
 	switch (cmd) {
 	case I2C_FUNCS:
 		funcs = i2c_get_functionality(client->adapter);
@@ -588,7 +639,7 @@ static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned lo
 					  compat_ptr(data32.data));
 	}
 	default:
-		return i2cdev_ioctl(file, cmd, arg);
+		return i2cdev_ioctl_locked(file, cmd, arg);
 	}
 }
 #else
@@ -597,13 +648,10 @@ static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned lo
 
 static int i2cdev_open(struct inode *inode, struct file *file)
 {
-	unsigned int minor = iminor(inode);
+	struct i2c_dev *i2c_dev = container_of(inode->i_cdev, struct i2c_dev, cdev);
+	struct i2c_adapter *adap = i2c_dev->adap;
+	struct i2c_dev_data *data;
 	struct i2c_client *client;
-	struct i2c_adapter *adap;
-
-	adap = i2c_get_adapter(minor);
-	if (!adap)
-		return -ENODEV;
 
 	/* This creates an anonymous i2c_client, which may later be
 	 * pointed to some address using I2C_SLAVE or I2C_SLAVE_FORCE.
@@ -612,26 +660,27 @@ static int i2cdev_open(struct inode *inode, struct file *file)
 	 * or I2C core code!!  It just holds private copies of addressing
 	 * information and maybe a PEC flag.
 	 */
-	client = kzalloc_obj(*client);
-	if (!client) {
-		i2c_put_adapter(adap);
+	data = kzalloc_obj(*data);
+	if (!data)
 		return -ENOMEM;
-	}
+
+	data->i2c_dev = i2c_dev;
+
+	client = &data->client;
+
 	snprintf(client->name, I2C_NAME_SIZE, "i2c-dev %d", adap->nr);
 
 	client->adapter = adap;
-	file->private_data = client;
+	file->private_data = data;
 
 	return 0;
 }
 
 static int i2cdev_release(struct inode *inode, struct file *file)
 {
-	struct i2c_client *client = file->private_data;
+	struct i2c_dev_data *data = file->private_data;
 
-	i2c_put_adapter(client->adapter);
-	kfree(client);
-	file->private_data = NULL;
+	kfree(data);
 
 	return 0;
 }
@@ -675,8 +724,10 @@ static int i2cdev_attach_adapter(struct device *dev)
 	if (IS_ERR(i2c_dev))
 		return NOTIFY_DONE;
 
+	init_rwsem(&i2c_dev->rwsem);
+
 	cdev_init(&i2c_dev->cdev, &i2cdev_fops);
-	i2c_dev->cdev.owner = THIS_MODULE;
+	i2c_dev->cdev.owner = adap->owner;
 
 	device_initialize(&i2c_dev->dev);
 	i2c_dev->dev.devt = MKDEV(I2C_MAJOR, adap->nr);
-- 
2.54.0

