Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0334192EF
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574480; cv=none; b=gInn24VVwLq8GZjf+B8Js1P00FX8z8Wv8F0ssE0f3PiNGtVRI13SwyOrcKwrtpm9yq8LDcWLwAHC25AwOHPne7WnqFk+IiBV0mo8loLE7fs2rNPiWzoyAZq1sCS3z2vuKOwe0UyLn3S+TZD706dKXW1gdah+pYahKTZaXH+G6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574480; c=relaxed/simple;
	bh=ETROJDsxEGHCNly6BqUeDGahKOR2T6ekhSuAfmym0TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDElTd+S33vZktIv0LAFwWIQZLxV45MJIGSiCWaRaTFkqDMfIEMpmfFR8/sMqlCd2zRYR15A5Bm1M4rxtZ+c9TV9pkv6+4/9EtY6B2l3MjkLjeN52c7Kd1c8EU4hYLStGvqku2qQuzcGWN5/4nOSI57dQu5fsJooAOvWTu1C8n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th7fNvuF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th7fNvuF"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-937681c4bf9so21106885a.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574477; x=1788179277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmihAs/QGjMhC6/wKUWvWaxgALVzhT8oi+LyRJ/OtTY=;
        b=Th7fNvuFyi1yHl3liuzGE3iuuDuedKPhHUPhZzvhf4UIJpC1dwi6Mlm01506aYoDq3
         c/jw2O6BfSW/mjH1kkGPLCQ25C7j1LPEP8U1pZXUBJsyppHucNZcDCwL8D9H8IUhlmCB
         GpCXW0wUb5V9Hlp1v2FYNqx8SB5QPQq0sui+rc/kwq3Y2TgW7J/MQ5Uu8gvVQHPJAbVv
         Ja1+iJuvhD9X9gqj2pKNHImKI3Zp4AgHjMBwpx88QKbk7yXmSJHFMNTYJtadsOqcQyFN
         EGMfQJQgQDR67p8PwUT60ss8SoFXsa1wf4RkXl+2xfwfxy4uvUvUoE5F5NaZ9KqdIloM
         47IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574477; x=1788179277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmihAs/QGjMhC6/wKUWvWaxgALVzhT8oi+LyRJ/OtTY=;
        b=VTYh1vx/RQBAOap2dh3FCGqdsCPP7PTTwkyjQhNWuRlOETKq4xIFz5Jfe9BbrTfvcV
         7YQ3bcYN4xp1Y3ILgJGL56fYklUG4Vddzh7+VoorKyRtlj1qY2p90gj9XAfmee9ovjQw
         T5FKzsoiGbqnYIJ91tqNjE2rm70pdMIy5kSXmSl1c50InsJEuWLl+x4/Ec2xSzpnYkZe
         +UGu6cHZ702L+sraPvxXnOU3eyjNeKYozySuWunDK4NR0gNaj1XdLqk8lSq1rXXRIV13
         iNpJLvD45z2C0H5XRpzpZYMKSKBOPFOmNnSG33S8G9TAIFG9hosjZNrW+gvlNusw9+5j
         d1Tw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4RoF3j8gIuq7TwXDgN/JQ2Rj8GZFh3C82YlFcCS0xJNx12Un4H0gIWMipUiy9+3GzpxOk3pI=@vger.kernel.org
X-Gm-Message-State: AFuF++lY7/xjGLKPDbhiUjxwymjztaG5ptmCoUcg2QunJnMrUhi47YzI
	LobjB1WoCk94D07LEYSGxtbTFUawS7DZW//qedmuImiKHO9epUdksT3a
X-Gm-Gg: AR+sD100USAyuJYBN+cZkl324jpp7TBEE34tyFAAHG9Y0Zhzdm9l1WMx20HZWYrxIow
	BVt03HGsIxIUGg1irRBWIH7XT8aw+H+UwjPTr+BPKhYXP05WxDclV1D+OcnFCSPqDbySuQ7m5Q1
	3L9wmeJTD5whF54N9RxXhtL3+KbIfNIOQqif2TJPCX78qEIqIfmzVSL/My8OmeVu9anLVtm+zJ2
	kcaqbOhrSIOW/sOFZ83/N33m6x6B7PJ4FBSy4d7mYCnjTQab/SFzbCkG7fBN4pONB6juYM3zMmw
	lrvcps5mxk+sDjDAzD+w9Fxbv/pFA9lKsOo0feArtA74aRgPj6OivhyprVy3BkPFiJwaNv70qyy
	kEop+ZDQ2mUz+GYVnAb+TWPMM0pKtKpkzIUpRo7L4Z7wGhoVqoNYKAGxdQj7RBqKiaZQ2el6/R3
	7hG8OP2QOtlJLSP0p+tMxnZnn2x33tDk6IUILbL4OvawX2UheV3jLWcAEkf3sQge4P4praH3aeZ
	YLnxadfZbCqFVdOHnLmc3wGF4PKbuDhf3LHXG2X5919d64WyNjxVL9fHvDPFgs8197zG37BRRTB
	IKunxO7Dt26hdJcCQWuTAm5h
X-Received: by 2002:a05:620a:ac13:b0:936:af9f:4c30 with SMTP id af79cd13be357-93739652c16mr2068104785a.25.1787574476700;
        Mon, 24 Aug 2026 05:27:56 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749af9384sm488132985a.20.2026.08.24.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:27:56 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - remove the F34 sysfs group when probe fails
Date: Mon, 24 Aug 2026 20:27:51 +0800
Message-ID: <20260824122751.76415-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_driver_probe() creates the F34 firmware attribute group directly on
the rmi_device's kobject:

	retval = rmi_f34_create_sysfs(rmi_dev);
	if (retval)
		goto err;

but rmi_f34_remove_sysfs() is only ever called from
rmi_driver_remove(), which does not run when probe fails.  Every error
path taken after that point -- input_register_device(), rmi_irq_init(),
rmi_enable_sensor() -- therefore leaves the group in place on a device
that never finished binding.

The driver core clears the device's driver data when probe fails, so
what is left behind is a set of world-readable attributes whose show()
handlers dereference that now-NULL pointer:

	static ssize_t rmi_driver_bootloader_id_show(struct device *dev, ...)
	{
		struct rmi_driver_data *data = dev_get_drvdata(dev);
		struct rmi_function *fn;

		fn = data->f34_container;

bootloader_id, configuration_id and update_fw_status are all mode 0444,
so any local user can dereference it.  Reaching the failure does not
need privileges either: a device that simply stops answering a register
read makes rmi_enable_sensor() fail, which is past the group creation.

An emulated RMI4 touchpad over /dev/uhid that leaves the second read of
the F01 interrupt-status register unanswered, on v6.12.105 with
CONFIG_KASAN=y:

  rmi4_physical rmi4-00: Failed to read irqs, code=-11
  rmi4_physical rmi4-00: probe with driver rmi4_physical failed with error -11

and then, from an ordinary user:

  $ cat /sys/bus/rmi4/devices/rmi4-00/bootloader_id

  Oops: general protection fault, probably for non-canonical address
        0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
  CPU: 0 UID: 1000 PID: 1851 Comm: cat Tainted: G            E
  RIP: 0010:rmi_driver_bootloader_id_show+0x4d/0x1b0 [rmi_core]
   dev_attr_show+0x46/0xc0
   sysfs_kf_seq_show+0x1f1/0x3c0
   seq_read_iter+0x2f8/0x1150
   vfs_read+0x699/0xa00

one oops per attribute.

Add an err_remove_sysfs label that drops the group, and route the error
paths below rmi_f34_create_sysfs() through it.  rmi_f34_create_sysfs()
failing on its own account goes to err_destroy_functions instead, which
also repairs a second leak on that path: it used to "goto err" and skip
rmi_free_function_list() entirely, leaving the function devices
registered on the RMI bus with a parent whose driver data is gone.  The
resulting order matches rmi_driver_remove().

After this change the same device leaves no attributes behind, the reads
fail with -ENOENT, and no oops is reported; a well-behaved device still
probes and keeps its F34 group.

Fixes: 29fd0ec2bdbe ("Input: synaptics-rmi4 - add support for F34 device reflash")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..144b203e636a 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1255,7 +1255,7 @@ static int rmi_driver_probe(struct device *dev)
 
 	retval = rmi_f34_create_sysfs(rmi_dev);
 	if (retval)
-		goto err;
+		goto err_destroy_functions;
 
 	if (data->input) {
 		rmi_driver_set_input_name(rmi_dev, data->input);
@@ -1264,14 +1264,14 @@ static int rmi_driver_probe(struct device *dev)
 			if (retval) {
 				dev_err(dev, "%s: Failed to register input device.\n",
 					__func__);
-				goto err_destroy_functions;
+				goto err_remove_sysfs;
 			}
 		}
 	}
 
 	retval = rmi_irq_init(rmi_dev);
 	if (retval < 0)
-		goto err_destroy_functions;
+		goto err_remove_sysfs;
 
 	if (data->f01_container->dev.driver) {
 		/* Driver already bound, so enable ATTN now. */
@@ -1284,6 +1284,8 @@ static int rmi_driver_probe(struct device *dev)
 
 err_disable_irq:
 	rmi_disable_irq(rmi_dev, false);
+err_remove_sysfs:
+	rmi_f34_remove_sysfs(rmi_dev);
 err_destroy_functions:
 	rmi_free_function_list(rmi_dev);
 err:
-- 
2.43.0

