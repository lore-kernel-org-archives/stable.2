Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD252BEFE8
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787627607; cv=none; b=EYuw2aL18BOEc8i0kba/LMHE/8Y+MVtYYAYeuXwJMyAmYOXuT6UBzHESVxGx9Ov89mNp3fssHe2eMcAQGPjN6x8FbYW7zZGuEnbzt8AtNstkBFvfnW5p3Y/1Kvf20W7i54R4lKmbFm8ixz/GowlWdyk0723GwEO+dlZ4Ds2an8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787627607; c=relaxed/simple;
	bh=2FG4VSNlriZzq0sRBZUYXW1ETfdvWmGFvhJSmbFSe6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyEOhYuMufQNLk1LdbVdQZmBDcsvvgbEXnCHPvn4UrVx95VIQePbac5WDa5dUZb39WlOxbsUXrlFrzfp//UFIWYJQ8Y2cn5Zpgq0dKXqFsrs+Plr7efQm7WgmRgViUUe98UVQijTYQGhlzN2oMnv8eUdVXMvgOTiySZVsana3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T66ofBwH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T66ofBwH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so3807107a91.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 20:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787627606; x=1788232406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5rcS3VvqecExKBxgTW3DxuIW6wOmPXi4Xwjd2qsZ9Sk=;
        b=T66ofBwHpBTscLvuIHvdRM8vU2x9ApNw1pZpSO+Wu2Gy8rETOsHAbH3YDhJXc46lFy
         esKVmUHV7eaHyqVEFzkRmiTdRAEWsdvyH8qkN7kxKI9nbQpq0SiHGMCXMVY6bb+Db+g8
         ecXyJ9ahv7Xe8WCzCFCO7h2lya/CVLsalo5VB79J7697arpHf45aTMjbP6q3A9lx4u3+
         9ACkH3Lsn68ZClKWbSbjc8j0l8E8YJ5El07SFx8vj30O4wxj8ZV6YRVUsjbmy0PKz0xW
         MUqxaq9JY0efKLvX1znxSg4Xls55nvQQYDpfoVw1O7sGHQ7y5pN45oYJbTL3XlmpBBxq
         voQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787627606; x=1788232406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5rcS3VvqecExKBxgTW3DxuIW6wOmPXi4Xwjd2qsZ9Sk=;
        b=j54GwHriVWW+4qmLRBImPkCWqJjrSL+8GnB036oB9KOjfe3+BW+cO+OLeyyzKykLe4
         JAT2hZPu+GiQ5GHo6rYd7tqVgn4O3bXiFNdu3SCmzicUg2un5jFITtT9g7R5HACvcHwl
         4WH76+b+mAG8tlQrY1DKEDrIvYKcVEiJBhsHtCwk3WPXpWO8/mnWyN2OoSPoLB/FWST7
         whdRkD1kzMDsxCChMZibjMjGjl5f752cR1QJRItj7MRt6jffGRjAsbcoTj6iujtNLnHH
         rUuOQ5YirSqUc4JKSG6WcRvqP9VGXKehW4EdZksjM8C1r2eiu76DDAd7tYtlx6Uy2X49
         N3tw==
X-Forwarded-Encrypted: i=1; AHgh+RpGphr1zK+JHY2MWrXpHkX1DXHojqlChhnAqkDsCt9MyAReYvWbgQEPaiqqSliAsvwBBbukgv4=@vger.kernel.org
X-Gm-Message-State: AFuF++m4WSmoX8kmOSL97qQw02RrTJ9FIiiKhav2bF/RkDqdM3wisgS3
	8GmqjGqLfdyKa2fH3+Ij3ODJj6smpPL5P/Bqi+56rObLitTOttvSsNrB
X-Gm-Gg: AR+sD13lAmA5Mq/sqLx4GAnv9OU5C7mLCjwdB6FOzVSPyzxsTONhTvT3wqBotHr2ZKo
	QowTjQda4Dn4doppdeL49z8/Pkr6A1tgvQd15Suhe84kbBOGwdMl98mjOPPsXBMD8kFTQHyv2Hc
	kILcJdsiLd5v6wh/7focwqY1vVMesQMdnT4niZpMt5sJSQxQ67I3HTjbZAgjjkFVKV1tosGDjGq
	KPdEir+3SKVWdjUdNAr4af88N8iO9QHXe3FCy8/sPcmg7AoOhA5rRXxxrqRcaYkpCZ8tkItbsBB
	9EuVpVlnAiuVfvlCxy2aOmFwmDT+CAZ33+FWhDsOpFkZknOWyYJBXNocpu8XGvC1TbYBXc/TLpZ
	aUpyVHjW6UG3U6T3cRluPI6HxhsbBoeheEuhYsgrl/oQGeh+1fwSRVt8FxVm1wlbPLAdPfHHZQl
	Vj4yWJvp2SinhMEGEl1gdhr4FkUMp37b0K8ixI7hmHJbv9Csq3M04WNRjULsz/kcnz83mrCUXMO
	TvXVhHf/RC5eIKVGEqPRaGCqXfmZ61CkSpk9na/SOQ8sKV+qAcuD1XvedxgAYqEWNiWvpChrD2i
	xXbr0UqVs9dhNfGTcHPICQqs
X-Received: by 2002:a17:90b:3d47:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-396462feb46mr6907050a91.2.1787627605537;
        Mon, 24 Aug 2026 20:13:25 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b0723esm1926097a91.1.2026.08.24.20.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 20:13:25 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Christopher Heiny <cheiny@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: synaptics-rmi4 - fix input_dev->name use-after-free on unplug
Date: Tue, 25 Aug 2026 11:13:15 +0800
Message-ID: <20260825031315.51860-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_driver_probe() reuses the transport driver's input device when it has
one, and then renames it out of memory owned by the RMI device:

	if (rmi_dev->xport->input) {
		data->input = rmi_dev->xport->input;
	...
	name = devm_kasprintf(&rmi_dev->dev, GFP_KERNEL,
			      "Synaptics %s", device_name);
	if (!name)
		return;

	input->name = name;

In the borrowed case the name outlives its allocation.  hid-rmi is the
transport that hits it: rmi_input_configured() hands us its hidinput
device, and rmi_remove() then tears the RMI device down first:

	rmi_unregister_transport_device(&hdata->xport);
	hid_hw_stop(hdev);

The first line unbinds this driver, so devres frees the name.  The second
reaches input_unregister_device(), whose device_del() emits the
KOBJ_REMOVE uevent, and input_dev_uevent() does

	if (dev->name)
		INPUT_ADD_HOTPLUG_VAR("NAME=\"%s\"", dev->name);

so vsnprintf() walks the freed string and copies it into the uevent that
is broadcast to userspace.  With slub_debug=FZPU the remove event carries

  NAME="kkkkkkkkkkkkkkkkkkkkkkk\xa5\xbb\xbb\xbb\xbb\xbb\xbb\xbb\xbb..."

i.e. POISON_FREE, POISON_END, the redzone and the SLUB tracking metadata
past the end of the object - the read runs to the first NUL, so it leaves
the object as well.

  BUG: KASAN: slab-use-after-free in string+0x2a9/0x330
  Read of size 1 at addr ffff88810a379d31 by task name/8056
  [...]
   string+0x2a9/0x330
   vsnprintf+0x5ec/0x1680
   add_uevent_var+0x165/0x390
   input_dev_uevent+0x14c/0x750
   dev_uevent+0x26e/0x6e0
   kobject_uevent_env+0x4ed/0x11b0
   device_del+0x5ac/0x940
   input_unregister_device+0x88/0xc0
   hidinput_disconnect+0x144/0x3e0
   hid_disconnect+0xf7/0x160
   hid_hw_stop+0x13/0x70
   hid_device_remove+0xc4/0x220
  [...]
  Allocated by task 7810:
   devm_kasprintf+0xb0/0xe0
   rmi_driver_probe+0x3e0/0xbf0 [rmi_core]
   rmi_register_transport_device+0x19e/0x3e0 [rmi_core]
   rmi_input_configured+0x184/0x2e0 [hid_rmi]
  Freed by task 8056:
   release_nodes+0xf0/0x260
   devres_release_all+0x106/0x170
   device_unbind_cleanup+0x16/0x1a0
   device_release_driver_internal+0x3f9/0x550
   rmi_unregister_transport_device+0x34/0x50 [rmi_core]
   rmi_remove+0xd0/0x100 [hid_rmi]

This is not limited to the RMI_DEVICE_HAS_PHYS_BUTTONS models: any RMI4
sensor reaches it, because rmi_init_functions() runs inside
rmi_input_configured() and F11/F12/F30 call input_set_capability() on the
borrowed device, so hidinput_connect() finds it populated and registers
it.  11 to 14 reports per three unplugs here.

The same string is read on the add side too.
rmi_register_transport_device() returns 0 whenever device_add() succeeded,
so a probe failure of this driver - rmi_enable_sensor() failing on a
register read is enough, and a HID device that stops answering can arrange
that - does not stop the transport: devres frees the name, and
hidinput_connect() then goes on to call input_register_device(), which
prints the name and emits KOBJ_ADD.

  BUG: KASAN: slab-use-after-free in string+0x2a9/0x330
  [...]
   input_register_device+0x710/0xe10
   hidinput_connect+0x1466/0x2a50
  [...]
  Freed by task 4394:
   release_nodes+0xf0/0x260
   devres_release_all+0x106/0x170
   device_unbind_cleanup+0x16/0x1a0
   really_probe+0x388/0x930

Moving the allocation onto the input device does not help - device_del()
releases devres before it emits the uevent - so put the name back to a
string with static storage duration when this driver lets go of an input
device it does not own, both on remove and on the probe error paths.

That means writing to the borrowed device after hidinput_connect() may
already have thrown it away: if none of the RMI functions populated it,
hidinput_connect() calls hidinput_cleanup_hidinput() and frees it while
data->input still points there.  Take a reference for as long as we keep
the pointer, which also stops rmi_process_interrupt_requests() from
input_sync()ing a freed device.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..8696a6aa0fa9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -369,6 +369,24 @@ static void rmi_driver_set_input_name(struct rmi_device *rmi_dev,
 	input->name = name;
 }
 
+/*
+ * Let go of an input device that belongs to the transport driver.  It outlives
+ * us, but rmi_driver_set_input_name() pointed its name at devres memory of
+ * ours that is freed as soon as we are done - input_register_device() and both
+ * the add and the remove uevent print that name - so put the name back to a
+ * string with static storage duration before dropping the reference.
+ */
+static void rmi_driver_put_input(struct rmi_device *rmi_dev,
+				 struct rmi_driver_data *data)
+{
+	if (!data->input || data->input != rmi_dev->xport->input)
+		return;
+
+	data->input->name = SYNAPTICS_INPUT_DEVICE_NAME;
+	input_put_device(data->input);
+	data->input = NULL;
+}
+
 static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
 				   unsigned long *mask)
 {
@@ -1026,6 +1044,8 @@ static int rmi_driver_remove(struct device *dev)
 	rmi_f34_remove_sysfs(rmi_dev);
 	rmi_free_function_list(rmi_dev);
 
+	rmi_driver_put_input(rmi_dev, data);
+
 	irq_domain_remove(data->irqdomain);
 	data->irqdomain = NULL;
 
@@ -1231,7 +1251,7 @@ static int rmi_driver_probe(struct device *dev)
 		 * One example is some HID touchpads report "pass-through"
 		 * button events are not reported by rmi registers.
 		 */
-		data->input = rmi_dev->xport->input;
+		data->input = input_get_device(rmi_dev->xport->input);
 	} else {
 		data->input = devm_input_allocate_device(dev);
 		if (!data->input) {
@@ -1287,6 +1307,7 @@ static int rmi_driver_probe(struct device *dev)
 err_destroy_functions:
 	rmi_free_function_list(rmi_dev);
 err:
+	rmi_driver_put_input(rmi_dev, data);
 	return retval;
 }
 
-- 
2.43.0

