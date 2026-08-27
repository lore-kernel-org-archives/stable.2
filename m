Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419144C658;
	Thu, 27 Aug 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835445; cv=none; b=uzyczNRs7Fh5DI/vQX5bzdtu3sdth5brvg8uM2PL/TStFWhF8yJlSt6tq6Z4l760sM0HU+q4jsNvEm2ndwwBUwVNxARkKuwPuwmkt/bGY8nOboOsEe79jf2P4x7+7aHG2Wpj0j7WVM/R4hpUgvGdMvS6f6hZR/VEvaHKExPFeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835445; c=relaxed/simple;
	bh=xOLeDDRbZ6ekH/0wvl4PG/+wnkBXhVvJ0R/mDSW765w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D37OtUDm8NPg4vq103wdcYaqSEwE1a4o8c0Qo/3xHygW8nLjiDS9iCVTlKFU1WEFdoXqVGAxH2RMWiqoaS5dy8n525bqwB9bGlnUu/qnNOrVw7H4ZzYF3AmTRQhLo3JqncacfsN8/NtCMCMEtsfVHzHW5e/Lc4l8F2wol2OdJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PhEo0+x3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PhEo0+x3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8261F000E9;
	Thu, 27 Aug 2026 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835406;
	bh=K9HkBinWQ/ZoE76UhPQoGKHZsGdaEakJ9K4NlYp5aFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PhEo0+x33ePwe5LJPrEH1/clH4cUpNKW3nVzOKCMFKWOh5C15GxXGYMjJysnPhHf6
	 JbwYph/zkMvrFNrxFg9PuToa+KNbbA+/vJn8rYx0hM3fnOVVrhBbhDXDuGtSOpc6wj
	 06fXy040jL7nDvhDvGY3/9wlxUHU05IItcNvtlKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.267
Date: Thu, 27 Aug 2026 14:56:37 +0200
Message-ID: <2026082737-cache-remote-5d1f@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082737-chaos-crabbing-187d@gregkh>
References: <2026082737-chaos-crabbing-187d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 8a3a5b5ffbdf..3e1b204d5291 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 266
+SUBLEVEL = 267
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 26068456ec0f..2cda74acada2 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -769,6 +769,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
+	/*
+	 * Permission faults just need to update the existing leaf entry,
+	 * and so normally don't require allocations from the memcache. The
+	 * only exception to this is when dirty logging is enabled at runtime
+	 * and a write fault needs to collapse a block entry into a table.
+	 */
+	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
+		ret = kvm_mmu_topup_memory_cache(memcache,
+						 kvm_mmu_cache_min_pages(kvm));
+		if (ret)
+			return ret;
+	}
+
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	mmap_read_lock(current->mm);
 	vma = find_vma_intersection(current->mm, hva, hva + 1);
@@ -818,32 +831,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		fault_ipa &= ~(vma_pagesize - 1);
 
 	gfn = fault_ipa >> PAGE_SHIFT;
-	mmap_read_unlock(current->mm);
 
 	/*
-	 * Permission faults just need to update the existing leaf entry,
-	 * and so normally don't require allocations from the memcache. The
-	 * only exception to this is when dirty logging is enabled at runtime
-	 * and a write fault needs to collapse a block entry into a table.
+	 * Read mmu_notifier_seq so that KVM can detect if the results of
+	 * find_vma_intersection() or gfn_to_pfn_prot() become stale prior to
+	 * acquiring kvm->mmu_lock.
+	 *
+	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
+	 * with the smp_wmb() in kvm_mmu_notifier_invalidate_range_end().
 	 */
-	if (fault_status != FSC_PERM || (logging_active && write_fault)) {
-		ret = kvm_mmu_topup_memory_cache(memcache,
-						 kvm_mmu_cache_min_pages(kvm));
-		if (ret)
-			return ret;
-	}
-
 	mmu_seq = vcpu->kvm->mmu_notifier_seq;
-	/*
-	 * Ensure the read of mmu_notifier_seq happens before we call
-	 * gfn_to_pfn_prot (which calls get_user_pages), so that we don't risk
-	 * the page we just got a reference to gets unmapped before we have a
-	 * chance to grab the mmu_lock, which ensure that if the page gets
-	 * unmapped afterwards, the call to kvm_unmap_hva will take it away
-	 * from us again properly. This smp_rmb() interacts with the smp_wmb()
-	 * in kvm_mmu_notifier_invalidate_<page|range_end>.
-	 */
-	smp_rmb();
+	mmap_read_unlock(current->mm);
 
 	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writable);
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 53d4abefa6ff..d98c761b0d70 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -84,7 +84,7 @@ struct ioh_gpio {
 	u32 gpio_use_sel;
 	int ch;
 	int irq_base;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 };
 
 static const int num_ports[] = {6, 12, 16, 16, 15, 16, 16, 12};
@@ -95,7 +95,7 @@ static void ioh_gpio_set(struct gpio_chip *gpio, unsigned nr, int val)
 	struct ioh_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->regs[chip->ch].po);
 	if (val)
 		reg_val |= (1 << nr);
@@ -103,7 +103,7 @@ static void ioh_gpio_set(struct gpio_chip *gpio, unsigned nr, int val)
 		reg_val &= ~(1 << nr);
 
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static int ioh_gpio_get(struct gpio_chip *gpio, unsigned nr)
@@ -121,7 +121,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm) &
 					((1 << num_ports[chip->ch]) - 1);
 	pm |= (1 << nr);
@@ -134,7 +134,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 		reg_val &= ~(1 << nr);
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -145,12 +145,12 @@ static int ioh_gpio_direction_input(struct gpio_chip *gpio, unsigned nr)
 	u32 pm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm) &
 				((1 << num_ports[chip->ch]) - 1);
 	pm &= ~(1 << nr);
 	iowrite32(pm, &chip->reg->regs[chip->ch].pm);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -256,7 +256,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	dev_dbg(chip->dev, "%s:irq=%d type=%d ch=%d pos=%d type=%d\n",
 		__func__, irq, type, ch, im_pos, type);
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -296,7 +296,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	iowrite32(ien | BIT(ch), &chip->reg->regs[chip->ch].ien);
 end:
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
@@ -326,11 +326,11 @@ static void ioh_irq_disable(struct irq_data *d)
 	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	ien &= ~(1 << (d->irq - chip->irq_base));
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static void ioh_irq_enable(struct irq_data *d)
@@ -340,11 +340,11 @@ static void ioh_irq_enable(struct irq_data *d)
 	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	ien |= 1 << (d->irq - chip->irq_base);
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 }
 
 static irqreturn_t ioh_gpio_handler(int irq, void *dev_id)
@@ -441,7 +441,7 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		chip->base = base;
 		chip->reg = chip->base;
 		chip->ch = i;
-		spin_lock_init(&chip->spinlock);
+		raw_spin_lock_init(&chip->spinlock);
 		ioh_gpio_setup(chip, num_ports[i]);
 		ret = gpiochip_add_data(&chip->gpio, chip);
 		if (ret) {
@@ -529,9 +529,9 @@ static int ioh_gpio_suspend(struct pci_dev *pdev, pm_message_t state)
 	struct ioh_gpio *chip = pci_get_drvdata(pdev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	ioh_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	ret = pci_save_state(pdev);
 	if (ret) {
@@ -563,11 +563,11 @@ static int ioh_gpio_resume(struct pci_dev *pdev)
 	}
 	pci_restore_state(pdev);
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&chip->spinlock, flags);
 	iowrite32(0x01, &chip->reg->srst);
 	iowrite32(0x00, &chip->reg->srst);
 	ioh_gpio_restore_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
 
 	return 0;
 }
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5acb893ecff6..f5e9ac4e6007 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -346,6 +346,9 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 
 static u32 item_udata(struct hid_item *item)
 {
+	if (item->format != HID_ITEM_FORMAT_SHORT)
+		return 0;
+
 	switch (item->size) {
 	case 1: return item->data.u8;
 	case 2: return item->data.u16;
@@ -356,6 +359,9 @@ static u32 item_udata(struct hid_item *item)
 
 static s32 item_sdata(struct hid_item *item)
 {
+	if (item->format != HID_ITEM_FORMAT_SHORT)
+		return 0;
+
 	switch (item->size) {
 	case 1: return item->data.s8;
 	case 2: return item->data.s16;
@@ -1696,13 +1702,14 @@ int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
 
 	size = field->report_size;
 
-	hid_dump_input(field->report->device, field->usage + offset, value);
-
 	if (offset >= field->report_count) {
 		hid_err(field->report->device, "offset (%d) exceeds report_count (%d)\n",
 				offset, field->report_count);
 		return -1;
 	}
+
+	hid_dump_input(field->report->device, field->usage + offset, value);
+
 	if (field->logical_minimum < 0) {
 		if (value != snto32(s32ton(value, size), size)) {
 			hid_err(field->report->device, "value %d is out of range\n", value);
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index bf77cfb723d5..b9f64e374488 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -179,18 +179,32 @@ static void mousevsc_free_device(struct mousevsc_dev *device)
 }
 
 static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
-				struct synthhid_device_info *device_info)
+					    struct synthhid_device_info *device_info,
+					    u32 device_info_size)
 {
 	int ret = 0;
 	struct hid_descriptor *desc;
 	struct mousevsc_prt_msg ack;
+	size_t desc_offset;
+	size_t desc_size;
 
 	input_device->dev_info_status = -ENOMEM;
 
+	if (device_info_size < sizeof(*device_info)) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
+
 	input_device->hid_dev_info = device_info->hid_dev_info;
 	desc = &device_info->hid_descriptor;
+	desc_offset = offsetof(struct synthhid_device_info, hid_descriptor);
+	desc_size = device_info_size - desc_offset;
 	if (desc->bLength == 0)
 		goto cleanup;
+	if (desc->bLength < sizeof(*desc) || desc->bLength > desc_size) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->hid_desc);
@@ -205,6 +219,10 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
 	}
+	if (input_device->report_desc_size > desc_size - desc->bLength) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->report_desc);
@@ -285,14 +303,17 @@ static void mousevsc_on_receive(struct hv_device *device,
 		break;
 
 	case SYNTH_HID_INITIAL_DEVICE_INFO:
-		WARN_ON(pipe_msg->size < sizeof(struct hv_input_dev_info));
+		if (WARN_ON_ONCE(pipe_msg->size <
+				 sizeof(struct synthhid_device_info)))
+			break;
 
 		/*
 		 * Parse out the device info into device attr,
 		 * hid desc and report desc
 		 */
 		mousevsc_on_receive_device_info(input_dev,
-			(struct synthhid_device_info *)pipe_msg->data);
+						(struct synthhid_device_info *)pipe_msg->data,
+						pipe_msg->size);
 		break;
 	case SYNTH_HID_INPUT_REPORT:
 		input_report =
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index afde78319b99..13bb9e040d33 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -312,6 +312,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	struct input_dev *input = msc->input;
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
+	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
+	if (size < 1)
+		return 0;
+
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
@@ -384,6 +388,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		/* Sometimes the trackpad sends two touch reports in one
 		 * packet.
 		 */
+
+		/* Ensure that we have at least 2 elements (report type and size) */
+		if (size < 2)
+			return 0;
+
+		if (size < data[1] + 2) {
+			hid_warn(hdev,
+				 "received report length (%d) was smaller than specified (%d)",
+				 size, data[1] + 2);
+			return 0;
+		}
+
 		magicmouse_raw_event(hdev, report, data + 2, data[1]);
 		magicmouse_raw_event(hdev, report, data + 2 + data[1],
 			size - 2 - data[1]);
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 971600a6397a..12e1afcb1b74 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -771,26 +771,26 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
-				 &enable_sensor_attr_group);
+	ret = hid_sensor_custom_add_attributes(sensor_inst);
 	if (ret)
 		goto err_remove_callback;
 
-	ret = hid_sensor_custom_add_attributes(sensor_inst);
+	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
+				 &enable_sensor_attr_group);
 	if (ret)
-		goto err_remove_group;
+		goto err_remove_attributes;
 
 	ret = hid_sensor_custom_dev_if_add(sensor_inst);
 	if (ret)
-		goto err_remove_attributes;
+		goto err_remove_group;
 
 	return 0;
 
-err_remove_attributes:
-	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_group:
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+err_remove_attributes:
+	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 
@@ -803,9 +803,10 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
 	hid_sensor_custom_dev_if_remove(sensor_inst);
-	hid_sensor_custom_remove_attributes(sensor_inst);
+	/* Remove enable_sensor first as it uses fields via power_state/report_state. */
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+	hid_sensor_custom_remove_attributes(sensor_inst);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 
 	return 0;
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 1df5e773a1f3..5d2d1797ee20 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1192,8 +1192,6 @@ static ssize_t ims_pcu_reset_device(struct device *dev,
 
 	dev_info(pcu->dev, "Attempting to reset device\n");
 
-	guard(mutex)(&pcu->cmd_mutex);
-
 	error = ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
 	if (error) {
 		dev_info(pcu->dev,
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a42be2356672..6f1787e83b65 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -78,7 +78,7 @@
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
-#define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
+#define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
@@ -212,9 +212,14 @@ struct fastrpc_channel_ctx {
 	spinlock_t lock;
 	struct idr ctx_idr;
 	struct list_head users;
-	struct miscdevice miscdev;
 	struct kref refcount;
 	u64 dma_mask;
+	struct fastrpc_device *fdevice;
+};
+
+struct fastrpc_device {
+	struct fastrpc_channel_ctx *cctx;
+	struct miscdevice miscdev;
 };
 
 struct fastrpc_user {
@@ -1248,10 +1253,14 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 
 static int fastrpc_device_open(struct inode *inode, struct file *filp)
 {
-	struct fastrpc_channel_ctx *cctx = miscdev_to_cctx(filp->private_data);
+	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_device *fdevice;
 	struct fastrpc_user *fl = NULL;
 	unsigned long flags;
 
+	fdevice = miscdev_to_fdevice(filp->private_data);
+	cctx = fdevice->cctx;
+
 	fl = kzalloc(sizeof(*fl), GFP_KERNEL);
 	if (!fl)
 		return -ENOMEM;
@@ -1378,30 +1387,14 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
-static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
-				   struct fastrpc_req_munmap *req)
+static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
 {
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
-	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_munmap_req_msg req_msg;
 	struct device *dev = fl->sctx->dev;
 	int err;
 	u32 sc;
 
-	spin_lock(&fl->lock);
-	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
-		if ((iter->raddr == req->vaddrout) && (iter->size == req->size)) {
-			buf = iter;
-			break;
-		}
-	}
-	spin_unlock(&fl->lock);
-
-	if (!buf) {
-		dev_err(dev, "mmap not in list\n");
-		return -EINVAL;
-	}
-
 	req_msg.pgid = fl->tgid;
 	req_msg.size = buf->size;
 	req_msg.vaddr = buf->raddr;
@@ -1414,9 +1407,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
 				      &args[0]);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
-		spin_lock(&fl->lock);
-		list_del(&buf->node);
-		spin_unlock(&fl->lock);
 		fastrpc_buf_free(buf);
 	} else {
 		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
@@ -1427,12 +1417,38 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
 
 static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 {
+	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
+	struct device *dev = fl->sctx->dev;
+	int err;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	return fastrpc_req_munmap_impl(fl, &req);
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
+		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			list_del(&iter->node);
+			buf = iter;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+
+	if (!buf) {
+		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
+			req.vaddrout, req.size);
+		return -EINVAL;
+	}
+
+	err = fastrpc_req_munmap_impl(fl, buf);
+	if (err) {
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &fl->mmaps);
+		spin_unlock(&fl->lock);
+	}
+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
@@ -1441,7 +1457,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_mmap_req_msg req_msg;
 	struct fastrpc_mmap_rsp_msg rsp_msg;
-	struct fastrpc_req_munmap req_unmap;
 	struct fastrpc_phy_page pages;
 	struct fastrpc_req_mmap req;
 	struct device *dev = fl->sctx->dev;
@@ -1489,7 +1504,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 				      &args[0]);
 	if (err) {
 		dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
-		goto err_invoke;
+		fastrpc_buf_free(buf);
+		return err;
 	}
 
 	/* update the buffer to be able to deallocate the memory on the DSP */
@@ -1503,11 +1519,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	spin_unlock(&fl->lock);
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
-		/* unmap the memory and release the buffer */
-		req_unmap.vaddrout = buf->raddr;
-		req_unmap.size = buf->size;
-		fastrpc_req_munmap_impl(fl, &req_unmap);
-		return -EFAULT;
+		err = -EFAULT;
+		goto err_assign;
 	}
 
 	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
@@ -1515,8 +1528,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	return 0;
 
-err_invoke:
-	fastrpc_buf_free(buf);
+err_assign:
+	fastrpc_req_munmap_impl(fl, buf);
 
 	return err;
 }
@@ -1649,6 +1662,27 @@ static struct platform_driver fastrpc_cb_driver = {
 	},
 };
 
+static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
+				   const char *domain)
+{
+	struct fastrpc_device *fdev;
+	int err;
+
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return -ENOMEM;
+
+	fdev->cctx = cctx;
+	fdev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	fdev->miscdev.fops = &fastrpc_fops;
+	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s", domain);
+	err = misc_register(&fdev->miscdev);
+	if (!err)
+		cctx->fdevice = fdev;
+
+	return err;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -1678,11 +1712,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->miscdev.minor = MISC_DYNAMIC_MINOR;
-	data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s",
-					    domains[domain_id]);
-	data->miscdev.fops = &fastrpc_fops;
-	err = misc_register(&data->miscdev);
+	err = fastrpc_device_register(rdev, data, domains[domain_id]);
 	if (err) {
 		kfree(data);
 		return err;
@@ -1727,7 +1757,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	misc_deregister(&cctx->miscdev);
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index b5e79d63d59b..50fd5befa6f5 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -694,7 +694,6 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
@@ -722,7 +721,6 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
 
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 6471a71c2ee6..972827db819a 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -213,7 +213,6 @@ static void slc_bump(struct slcan *sl)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, &cf, sizeof(struct can_frame));
 
diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index b701ee83e64a..7e562751d6dd 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -100,7 +100,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
 	struct net_device *ndev = qp_data;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *new_skb;
 	int rc;
 
 	skb = data;
@@ -115,6 +115,12 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
+	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+	if (!new_skb) {
+		ndev->stats.rx_dropped++;
+		goto enqueue_again;
+	}
+
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -127,12 +133,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.rx_bytes += len;
 	}
 
-	skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-	if (!skb) {
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_frame_errors++;
-		return;
-	}
+	skb = new_skb;
 
 enqueue_again:
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index a244796fcaa4..0d359ee94e1e 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -14,6 +14,7 @@
 #include <linux/usb/cdc.h>
 #include <linux/usb/usbnet.h>
 #include <linux/usb/rndis_host.h>
+#include <linux/overflow.h>
 
 
 /*
@@ -495,6 +496,7 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		struct rndis_data_hdr	*hdr = (void *)skb->data;
 		struct sk_buff		*skb2;
 		u32			msg_type, msg_len, data_offset, data_len;
+		u32			overflow_check;
 
 		msg_type = le32_to_cpu(hdr->msg_type);
 		msg_len = le32_to_cpu(hdr->msg_len);
@@ -503,7 +505,9 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
 		/* don't choke if we see oob, per-packet data, etc */
 		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len
-				|| (data_offset + data_len + 8) > msg_len)) {
+				|| (data_offset + data_len + 8) > msg_len
+				|| check_add_overflow(data_offset, data_len, &overflow_check)
+				|| check_add_overflow(overflow_check, 8, &overflow_check))) {
 			dev->net->stats.rx_frame_errors++;
 			netdev_dbg(dev->net, "bad rndis message %d/%d/%d/%d, len %d\n",
 				   le32_to_cpu(hdr->msg_type),
diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index 808d73050afd..1ef9ca16ef84 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -166,9 +166,36 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+
+			/*
+			 * next_read_size is taken from the device and is used
+			 * as the i2c_master_recv() count for the next packet
+			 * and as the data skb size. A value above the receive
+			 * buffer overflows tmp[]; one below the minimum frame
+			 * size runs the header/LRC strip and the length-field
+			 * read past a short receive. Either way the packet is
+			 * corrupt: drop it and force resynchronization.
+			 */
+			if (phy->next_read_size < FDP_NCI_I2C_MIN_PAYLOAD ||
+			    phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "%s: corrupted packet\n",
+					__func__);
+				phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 
+			/*
+			 * Only one data packet is delivered per call; if the
+			 * device sends another, do not overwrite and leak the
+			 * skb allocated for the previous one.
+			 */
+			if (*skb) {
+				kfree_skb(*skb);
+				*skb = NULL;
+			}
+
 			*skb = alloc_skb(len, GFP_KERNEL);
 			if (*skb == NULL) {
 				r = -ENOMEM;
diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 8d3988457c58..6de0f26c5fc5 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -485,13 +485,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 
 	switch (gate) {
 	case MICROREAD_GATE_ID_MREAD_ISO_A:
+		if (skb->len <= MICROREAD_EMCF_A_LEN) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    targets->nfcid1_len > skb->len - MICROREAD_EMCF_A_UID) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -499,13 +505,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_A_3:
+		if (skb->len <= MICROREAD_EMCF_A3_LEN) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A3_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A3_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A3_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A3_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    targets->nfcid1_len > skb->len - MICROREAD_EMCF_A3_UID) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -513,11 +525,21 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_B:
+		if (skb->len < MICROREAD_EMCF_B_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_ISO14443_B_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_B_UID], 4);
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T1:
+		if (skb->len < MICROREAD_EMCF_T1_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_JEWEL_MASK;
 		targets->sens_res =
 			le16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_T1_ATQA]);
@@ -525,6 +547,11 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T3:
+		if (skb->len < MICROREAD_EMCF_T3_UID + 8) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_FELICA_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_T3_UID], 8);
 		targets->nfcid1_len = 8;
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index 4de5205d9d61..8c555497220d 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2860,6 +2860,7 @@ void pn53x_common_clean(struct pn533 *priv)
 	destroy_workqueue(priv->wq);
 
 	skb_queue_purge(&priv->resp_q);
+	skb_queue_purge(&priv->fragment_skb);
 
 	list_for_each_entry_safe(cmd, n, &priv->cmd_queue, queue) {
 		list_del(&cmd->queue);
diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index 8874d605b14f..52715cc225c1 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -213,6 +213,9 @@ static int st21nfca_tm_recv_atr_req(struct nfc_hci_dev *hdev,
 		goto exit;
 	}
 
+	if (atr_req->length > skb->len)
+		return -EPROTO;
+
 	r = st21nfca_tm_send_atr_res(hdev, atr_req);
 	if (r)
 		goto exit;
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 321859753ae8..b13c37bd385d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -560,7 +560,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 		list_del(&iod->ls_rcv_list);
 	}
 
-	kfree(iod);
+	kfree(tgtport->iod);
 
 	return -EFAULT;
 }
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 27d001fd8821..425381eff72a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -393,14 +393,15 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	}
 	cmd->req.transfer_len += len;
 
-	cmd->req.sg = sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);
+	cmd->req.sg = sgl_alloc(len, GFP_KERNEL | __GFP_NOWARN,
+				&cmd->req.sg_cnt);
 	if (!cmd->req.sg)
 		return NVME_SC_INTERNAL;
 	cmd->cur_sg = cmd->req.sg;
 
 	if (nvmet_tcp_has_data_in(cmd)) {
 		cmd->iov = kmalloc_array(cmd->req.sg_cnt,
-				sizeof(*cmd->iov), GFP_KERNEL);
+				sizeof(*cmd->iov), GFP_KERNEL | __GFP_NOWARN);
 		if (!cmd->iov)
 			goto err;
 	}
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 4da85df9f781..1b6d0be12a7a 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -446,9 +446,6 @@ static int ccwchain_handle_ccw(u32 cda, struct channel_program *cp)
 	/* Loop for tics on this new chain. */
 	ret = ccwchain_loop_tic(chain, cp);
 
-	if (ret)
-		ccwchain_free(chain);
-
 	return ret;
 }
 
@@ -477,6 +474,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 	return 0;
 }
 
+static int ccwchain_build_ccws(u32 cda, struct channel_program *cp)
+{
+	struct ccwchain *chain, *temp;
+	int ret;
+
+	ret = ccwchain_handle_ccw(cda, cp);
+
+	if (ret) {
+		/* Cleanup if an error occurred */
+		list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+			ccwchain_free(chain);
+		}
+	}
+
+	return ret;
+}
+
 static int ccwchain_fetch_tic(struct ccwchain *chain,
 			      int idx,
 			      struct channel_program *cp)
@@ -650,7 +664,7 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	cp->mdev = mdev;
 
 	/* Build a ccwchain for the first CCW segment */
-	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
+	ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
 
 	if (!ret) {
 		cp->initialized = true;
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index e3c1060b6056..2f080e7281f5 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -241,6 +241,13 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 	vfio_ccw_sch_quiesce(sch);
 
+	/*
+	 * Ensure these work items are fully drained, so none can
+	 * fire after being released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 2280f51dd679..0d9ac3293fe3 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -204,6 +204,14 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 	}
 
 	cp_free(&private->cp);
+
+	/*
+	 * Ensure these work items are drained, in the event the
+	 * device is re-opened instead of released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 7db28f585380..4881adf930ab 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -771,6 +771,9 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 		return false;
 	}
 
+	if (pIE->Length != WLAN_WMM_LEN)
+		return false;
+
 	if (!memcmp(&(pmlmeinfo->WMM_param), (pIE->data + 6), sizeof(struct WMM_para_element)))
 		return false;
 	else
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index ab68892a8b1c..500f46bb06c8 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1196,7 +1196,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
-		dmaengine_terminate_all(uap->dmatx.chan);
+		dmaengine_terminate_sync(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
 			dma_unmap_single(uap->dmatx.chan->device->dev,
 					 uap->dmatx.dma, uap->dmatx.len,
@@ -1209,12 +1209,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	}
 
 	if (uap->using_rx_dma) {
-		dmaengine_terminate_all(uap->dmarx.chan);
+		if (uap->dmarx.poll_rate)
+			timer_delete_sync(&uap->dmarx.timer);
+		dmaengine_terminate_sync(uap->dmarx.chan);
 		/* Clean up the RX DMA */
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a, DMA_FROM_DEVICE);
 		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_b, DMA_FROM_DEVICE);
-		if (uap->dmarx.poll_rate)
-			del_timer_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;
 	}
 }
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 07f1ea3d7707..03d256bf5d6b 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2041,12 +2041,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				 * stable so we can check the additional
 				 * reference fits.
 				 */
-				ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
-				if (ref > EXT4_XATTR_REFCOUNT_MAX) {
+				ref = le32_to_cpu(BHDR(new_bh)->h_refcount);
+				if (ref >= EXT4_XATTR_REFCOUNT_MAX) {
 					/*
 					 * Undo everything and check mbcache
 					 * again.
 					 */
+					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
 					unlock_buffer(new_bh);
 					dquot_free_block(inode,
 							 EXT4_C2B(EXT4_SB(sb),
@@ -2057,6 +2058,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 					new_bh = NULL;
 					goto inserted;
 				}
+				ref++;
 				BHDR(new_bh)->h_refcount = cpu_to_le32(ref);
 				if (ref == EXT4_XATTR_REFCOUNT_MAX)
 					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
@@ -2778,6 +2780,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 		    s_min_extra_isize) {
 			tried_min_extra_isize++;
 			new_extra_isize = s_min_extra_isize;
+			error = 0;
 			goto retry;
 		}
 		goto cleanup;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 219f9e1a2643..5ad3bf906b35 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -103,17 +103,24 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	 * to avoid reading in already uptodate ranges.
 	 */
 	if (iop) {
-		unsigned int i;
+		unsigned int i, blocks_skipped;
 
 		/* move forward for each leading block marked uptodate */
-		for (i = first; i <= last; i++) {
+		for (i = first; i <= last; i++)
 			if (!test_bit(i, iop->uptodate))
 				break;
-			*pos += block_size;
-			poff += block_size;
-			plen -= block_size;
-			first++;
+
+		blocks_skipped = i - first;
+		if (blocks_skipped) {
+			unsigned long block_offset = *pos & (block_size - 1);
+			unsigned bytes_skipped =
+				(blocks_skipped << block_bits) - block_offset;
+
+			*pos += bytes_skipped;
+			poff += bytes_skipped;
+			plen -= bytes_skipped;
 		}
+		first = i;
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		for ( ; i <= last; i++) {
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index be982b727fac..3d9353b232ed 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -742,12 +742,10 @@ static int ocfs2_xattr_extend_allocation(struct inode *inode,
 					 prev_clusters;
 
 		if (why != RESTART_NONE && clusters_to_add) {
-			/*
-			 * We can only fail in case the alloc file doesn't give
-			 * up enough clusters.
-			 */
-			BUG_ON(why == RESTART_META);
-
+			if (why == RESTART_META) {
+				status = -ENOSPC;
+				break;
+			}
 			credits = ocfs2_calc_extend_credits(inode->i_sb,
 							    &vb->vb_xv->xr_list);
 			status = ocfs2_extend_trans(handle, credits);
@@ -3216,6 +3214,14 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 		} else
 			credits += OCFS2_SUBALLOC_ALLOC + 1;
 
+		/*
+		 * Reserve metadata for the new xattr's value extent tree.
+		 * The not_found path above adds credits for this tree but
+		 * omits meta_add, leaving meta_ac NULL for large values.
+		 */
+		if (xi->xi_value_len > OCFS2_XATTR_INLINE_SIZE)
+			meta_add += ocfs2_extend_meta_needed(&def_xv.xv.xr_list);
+
 		/*
 		 * This cluster will be used either for new bucket or for
 		 * new xattr block.
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 3c1b95108343..7dabda22e3ff 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -265,6 +265,13 @@ xfs_attr3_leaf_verify_entry(
 	 */
 	if (ent->flags & XFS_ATTR_LOCAL) {
 		lentry = xfs_attr3_leaf_name_local(leaf, idx);
+
+		/* Validate lentry pointer is within bounds before field access */
+		if ((char *)lentry >= buf_end)
+			return __this_address;
+		if ((char *)lentry + offsetof(struct xfs_attr_leaf_name_local, nameval) > buf_end)
+			return __this_address;
+
 		namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
 				be16_to_cpu(lentry->valuelen));
 		name_end = (char *)lentry + namesize;
@@ -272,6 +279,13 @@ xfs_attr3_leaf_verify_entry(
 			return __this_address;
 	} else {
 		rentry = xfs_attr3_leaf_name_remote(leaf, idx);
+
+		/* Validate rentry pointer is within bounds before field access */
+		if ((char *)rentry >= buf_end)
+			return __this_address;
+		if ((char *)rentry + offsetof(struct xfs_attr_leaf_name_remote, name) > buf_end)
+			return __this_address;
+
 		namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
 		name_end = (char *)rentry + namesize;
 		if (rentry->namelen == 0)
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index a053b0bf7930..eddef2f99467 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -432,7 +432,7 @@ xlog_recover_validate_buf_type(
  * given buffer.  The bitmap in the buf log format structure indicates
  * where to place the logged data.
  */
-STATIC void
+STATIC int
 xlog_recover_do_reg_buffer(
 	struct xfs_mount		*mp,
 	struct xlog_recover_item	*item,
@@ -460,8 +460,24 @@ xlog_recover_do_reg_buffer(
 		ASSERT(nbits > 0);
 		ASSERT(item->ri_buf[i].i_addr != NULL);
 		ASSERT(item->ri_buf[i].i_len % XFS_BLF_CHUNK == 0);
-		ASSERT(BBTOB(bp->b_length) >=
-		       ((uint)bit << XFS_BLF_SHIFT) + (nbits << XFS_BLF_SHIFT));
+		/*
+		 * The bitmap is only trustworthy to the extent that it
+		 * describes a region that actually fits inside the buffer we
+		 * read in based on the (attacker-controlled) blf_len.  Do not
+		 * rely on an ASSERT() for this -- it compiles away entirely on
+		 * non-DEBUG kernels, which is exactly where this matters, so
+		 * validate it for real and abort recovery of this buffer rather
+		 * than copying past the end of it.
+		 */
+		if (XFS_IS_CORRUPT(mp, BBTOB(bp->b_length) <
+				((uint)bit << XFS_BLF_SHIFT) +
+				(nbits << XFS_BLF_SHIFT))) {
+			xfs_alert(mp,
+	"Bad buffer log item dirty bitmap (bit %d, nbits %d) for %d-byte buffer at daddr 0x%llx.",
+				bit, nbits, BBTOB(bp->b_length),
+				bp->b_bn);
+			return -EFSCORRUPTED;
+		}
 
 		/*
 		 * The dirty regions logged in the buffer, even though
@@ -515,6 +531,7 @@ xlog_recover_do_reg_buffer(
 	ASSERT(i == item->ri_total);
 
 	xlog_recover_validate_buf_type(mp, bp, buf_f, current_lsn);
+	return 0;
 }
 
 /*
@@ -523,10 +540,10 @@ xlog_recover_do_reg_buffer(
  * (ie. USR or GRP), then just toss this buffer away; don't recover it.
  * Else, treat it as a regular buffer and do recovery.
  *
- * Return false if the buffer was tossed and true if we recovered the buffer to
- * indicate to the caller if the buffer needs writing.
+ * Return 0 if the buffer was not recovered (tossed), 1 if it was recovered and
+ * needs writing, or a negative errno if recovery of the buffer failed.
  */
-STATIC bool
+STATIC int
 xlog_recover_do_dquot_buffer(
 	struct xfs_mount		*mp,
 	struct xlog			*log,
@@ -535,6 +552,7 @@ xlog_recover_do_dquot_buffer(
 	struct xfs_buf_log_format	*buf_f)
 {
 	uint			type;
+	int			error;
 
 	trace_xfs_log_recover_buf_dquot_buf(log, buf_f);
 
@@ -542,7 +560,7 @@ xlog_recover_do_dquot_buffer(
 	 * Filesystems are required to send in quota flags at mount time.
 	 */
 	if (!mp->m_qflags)
-		return false;
+		return 0;
 
 	type = 0;
 	if (buf_f->blf_flags & XFS_BLF_UDQUOT_BUF)
@@ -555,10 +573,12 @@ xlog_recover_do_dquot_buffer(
 	 * This type of quotas was turned off, so ignore this buffer
 	 */
 	if (log->l_quotaoffs_flag & type)
-		return false;
+		return 0;
 
-	xlog_recover_do_reg_buffer(mp, item, bp, buf_f, NULLCOMMITLSN);
-	return true;
+	error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f, NULLCOMMITLSN);
+	if (error)
+		return error;
+	return 1;
 }
 
 /*
@@ -943,13 +963,16 @@ xlog_recover_buf_commit_pass2(
 			goto out_release;
 	} else if (buf_f->blf_flags &
 		  (XFS_BLF_UDQUOT_BUF|XFS_BLF_PDQUOT_BUF|XFS_BLF_GDQUOT_BUF)) {
-		bool	dirty;
-
-		dirty = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
-		if (!dirty)
+		error = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
+		if (error <= 0)
 			goto out_release;
+		/* write dirty buffer */
+		error = 0;
 	} else {
-		xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+		error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f,
+						   current_lsn);
+		if (error)
+			goto out_release;
 	}
 
 	/*
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index fe00ad64c395..c2bd74263f78 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -745,7 +745,7 @@ xfs_dq_get_next_id(
 	if (!(quotip->i_df.if_flags & XFS_IFEXTENTS)) {
 		error = xfs_iread_extents(NULL, quotip, XFS_DATA_FORK);
 		if (error)
-			return error;
+			goto out_unlock;
 	}
 
 	if (xfs_iext_lookup_extent(quotip, &quotip->i_df, start, &cur, &got)) {
@@ -757,6 +757,7 @@ xfs_dq_get_next_id(
 		error = -ENOENT;
 	}
 
+out_unlock:
 	xfs_iunlock(quotip, lock_flags);
 
 	return error;
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 5fb8d0e3f9c1..3287232e3cad 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -58,6 +58,7 @@ extern void can_rx_unregister(struct net *net, struct net_device *dev,
 			      void *data);
 
 extern int can_send(struct sk_buff *skb, int loop);
+void can_set_skb_uid(struct sk_buff *skb);
 void can_sock_destruct(struct sock *sk);
 
 #endif /* !_CAN_CORE_H */
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 41ff31795320..83bcb1b8fa5b 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -119,7 +119,6 @@ static inline bool can_skb_headroom_valid(struct net_device *dev,
 	if (skb->ip_summed == CHECKSUM_NONE) {
 		/* init headroom */
 		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index ce7393d397e1..6399318832cb 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -28,12 +28,10 @@
 /**
  * struct can_skb_priv - private additional data inside CAN sk_buffs
  * @ifindex:	ifindex of the first interface the CAN frame appeared on
- * @skbcnt:	atomic counter to have an unique id together with skb pointer
  * @cf:		align to the following CAN frame at skb->data
  */
 struct can_skb_priv {
 	int ifindex;
-	int skbcnt;
 	struct can_frame cf[];
 };
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b847c45c45c8..d3a2234c736c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -269,9 +269,11 @@ struct hh_cache {
  * We could use other alignment values, but we must maintain the
  * relationship HH alignment <= LL alignment.
  */
-#define LL_RESERVED_SPACE(dev) \
-	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom)) \
+#define LL_RESERVED_SPACE_EX(dev, hlen) \
+	((((hlen) + READ_ONCE((dev)->needed_headroom)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
+#define LL_RESERVED_SPACE(dev) \
+	LL_RESERVED_SPACE_EX(dev, (dev)->hard_header_len)
 #define LL_RESERVED_SPACE_EXTRA(dev,extra) \
 	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom) + (extra)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index a4c670ad8c4a..b46a70602da4 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -86,6 +86,7 @@ struct Qdisc {
 	struct hlist_node       hash;
 	u32			handle;
 	u32			parent;
+	int			depth;
 
 	struct netdev_queue	*dev_queue;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9cd1f622a1f..68df0d569f4c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2117,18 +2117,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
-	/*
-	 * If event was in error state, then keep it
-	 * that way, otherwise bogus counts will be
-	 * returned on read(). The only way to get out
-	 * of error state is by explicit re-enabling
-	 * of the event
-	 */
-	if (event->state > PERF_EVENT_STATE_OFF) {
-		perf_cgroup_event_disable(event, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	}
-
 	ctx->generation++;
 }
 
@@ -2145,14 +2133,13 @@ perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
 }
 
 static void put_event(struct perf_event *event);
-static void event_sched_out(struct perf_event *event,
-			    struct perf_cpu_context *cpuctx,
-			    struct perf_event_context *ctx);
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct perf_event *iter;
 
 	/*
@@ -2181,8 +2168,7 @@ static void perf_put_aux_event(struct perf_event *event)
 		 * state so that we don't try to schedule it again. Note
 		 * that perf_event_enable() will clear the ERROR status.
 		 */
-		event_sched_out(iter, cpuctx, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		__event_disable(iter, ctx, PERF_EVENT_STATE_ERROR);
 	}
 }
 
@@ -2236,19 +2222,32 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 	return event->attr.pinned ? &ctx->pinned_active : &ctx->flexible_active;
 }
 
-/*
- * Events that have PERF_EV_CAP_SIBLING require being part of a group and
- * cannot exist on their own, schedule them out and move them into the ERROR
- * state. Also see _perf_event_enable(), it will not be able to recover
- * this ERROR state.
- */
-static inline void perf_remove_sibling_event(struct perf_event *event)
+/* @sibling must already be unlinked from its old leader's sibling_list. */
+static void perf_promote_sibling_to_leader(struct perf_event *sibling,
+					   struct perf_event_context *ctx,
+					   int group_caps)
 {
-	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	/*
+	 * Events that have PERF_EV_CAP_SIBLING require being part of
+	 * a group and cannot exist on their own, schedule them out
+	 * and move them into the ERROR state. Also see
+	 * _perf_event_enable(), it will not be able to recover this
+	 * ERROR state.
+	 */
+	if (sibling->event_caps & PERF_EV_CAP_SIBLING)
+		__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
+
+	sibling->group_leader = sibling;
+	sibling->group_caps = group_caps;
 
-	event_sched_out(event, cpuctx, ctx);
-	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
+		add_event_to_groups(sibling, ctx);
+
+		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
+			list_add_tail(&sibling->active_list, get_event_list(sibling));
+	}
+
+	perf_event__header_size(sibling);
 }
 
 static void perf_group_detach(struct perf_event *event)
@@ -2274,8 +2273,9 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	if (leader != event) {
 		list_del_init(&event->sibling_list);
-		event->group_leader->nr_siblings--;
-		event->group_leader->group_generation++;
+		leader->nr_siblings--;
+		leader->group_generation++;
+		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
 		goto out;
 	}
 
@@ -2285,25 +2285,14 @@ static void perf_group_detach(struct perf_event *event)
 	 * to whatever list we are on.
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
-
-		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			perf_remove_sibling_event(sibling);
-
-		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
 
 		/* Inherit group flags from the previous leader */
-		sibling->group_caps = event->group_caps;
-
-		if (!RB_EMPTY_NODE(&event->group_node)) {
-			add_event_to_groups(sibling, event->ctx);
-
-			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
-				list_add_tail(&sibling->active_list, get_event_list(sibling));
-		}
+		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
 
 		WARN_ON_ONCE(sibling->ctx != event->ctx);
 	}
+	event->nr_siblings = 0;
 
 out:
 	for_each_sibling_event(tmp, leader)
@@ -2432,6 +2421,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   struct perf_event_context *ctx,
 			   void *info)
 {
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	if (ctx->is_active & EVENT_TIME) {
@@ -2439,7 +2429,8 @@ __perf_remove_from_context(struct perf_event *event,
 		update_cgrp_time_from_cpuctx(cpuctx, false);
 	}
 
-	event_sched_out(event, cpuctx, ctx);
+	__event_disable(event, ctx, state);
+
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	list_del_event(event, ctx);
@@ -2494,6 +2485,16 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	}
 }
 
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state)
+{
+	event_sched_out(event, __get_cpu_context(ctx), ctx);
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
+}
+
 /*
  * Cross CPU call to disable a performance event
  */
@@ -2510,13 +2511,18 @@ static void __perf_event_disable(struct perf_event *event,
 		update_cgrp_time_from_event(event);
 	}
 
+	/*
+	 * When disabling a group leader, the whole group becomes ineligible
+	 * to run, so schedule out the full group.
+	 */
 	if (event == event->group_leader)
 		group_sched_out(event, cpuctx, ctx);
-	else
-		event_sched_out(event, cpuctx, ctx);
 
-	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	perf_cgroup_event_disable(event, ctx);
+	/*
+	 * But only mark the leader OFF; the siblings will remain
+	 * INACTIVE.
+	 */
+	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
 }
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f620861d0099..ecbd84a4a97b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -60,6 +60,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
 static struct shrinker deferred_split_shrinker;
 
 static atomic_t huge_zero_refcount;
+static DEFINE_SPINLOCK(huge_zero_lock);
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
@@ -90,7 +91,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
 static struct page *get_huge_zero_page(void)
 {
 	struct page *zero_page;
-retry:
+
+	/* Paired with atomic_set_release(). */
 	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
 		return READ_ONCE(huge_zero_page);
 
@@ -101,17 +103,22 @@ static struct page *get_huge_zero_page(void)
 		return NULL;
 	}
 	count_vm_event(THP_ZERO_PAGE_ALLOC);
-	preempt_disable();
-	if (cmpxchg(&huge_zero_page, NULL, zero_page)) {
-		preempt_enable();
+
+	/* Paired with critical section in shrink_huge_zero_page_scan(). */
+	spin_lock(&huge_zero_lock);
+	if (huge_zero_page) {
+		/* Somebody else already installed it. */
+		atomic_inc(&huge_zero_refcount);
+		spin_unlock(&huge_zero_lock);
 		__free_pages(zero_page, compound_order(zero_page));
-		goto retry;
+		return READ_ONCE(huge_zero_page);
 	}
+	WRITE_ONCE(huge_zero_page, zero_page);
 	WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
+	/* Paired with atomic_inc_not_zero(). +1 for shrinker pin. */
+	atomic_set_release(&huge_zero_refcount, 2);
+	spin_unlock(&huge_zero_lock);
 
-	/* We take additional reference here. It will be put back by shrinker */
-	atomic_set(&huge_zero_refcount, 2);
-	preempt_enable();
 	return READ_ONCE(huge_zero_page);
 }
 
@@ -154,15 +161,24 @@ static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
 static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
-	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct page *zero_page = xchg(&huge_zero_page, NULL);
-		BUG_ON(zero_page == NULL);
-		WRITE_ONCE(huge_zero_pfn, ~0UL);
-		__free_pages(zero_page, compound_order(zero_page));
-		return HPAGE_PMD_NR;
+	struct page *zero_page;
+
+	/* Paired with critical section in get_huge_zero_page(). */
+	spin_lock(&huge_zero_lock);
+	/* Paired with atomic_inc_not_zero() in get_huge_zero_page(). */
+	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) != 1) {
+		spin_unlock(&huge_zero_lock);
+		return 0;
 	}
 
-	return 0;
+	zero_page = huge_zero_page;
+	VM_WARN_ON_ONCE(!zero_page);
+	WRITE_ONCE(huge_zero_page, NULL);
+	WRITE_ONCE(huge_zero_pfn, ~0UL);
+	spin_unlock(&huge_zero_lock);
+
+	__free_pages(zero_page, compound_order(zero_page));
+	return HPAGE_PMD_NR;
 }
 
 static struct shrinker huge_zero_page_shrinker = {
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4543f536c127..c458ea8832c7 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1330,7 +1330,10 @@ static struct rfcomm_session *rfcomm_recv_disc(struct rfcomm_session *s,
 	return s;
 }
 
-void rfcomm_dlc_accept(struct rfcomm_dlc *d)
+/* Must be called with rfcomm_mutex held, so that the session cannot be
+ * unlinked from under us.
+ */
+static void __rfcomm_dlc_accept(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
@@ -1352,6 +1355,21 @@ void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 	rfcomm_send_msc(d->session, 1, d->dlci, d->v24_sig);
 }
 
+void rfcomm_dlc_accept(struct rfcomm_dlc *d)
+{
+	rfcomm_lock();
+
+	/* rfcomm_recv_disc() sets the dlc state to BT_CLOSED before calling
+	 * __rfcomm_dlc_close(), so the RFCOMM_DEFER_SETUP handshake there is
+	 * skipped and the session can already be unlinked by the time the
+	 * deferred accept runs from rfcomm_sock_recvmsg().
+	 */
+	if (d->session)
+		__rfcomm_dlc_accept(d);
+
+	rfcomm_unlock();
+}
+
 static void rfcomm_check_accept(struct rfcomm_dlc *d)
 {
 	if (rfcomm_check_security(d)) {
@@ -1364,7 +1382,7 @@ static void rfcomm_check_accept(struct rfcomm_dlc *d)
 			d->state_change(d, 0);
 			rfcomm_dlc_unlock(d);
 		} else
-			rfcomm_dlc_accept(d);
+			__rfcomm_dlc_accept(d);
 	} else {
 		set_bit(RFCOMM_AUTH_PENDING, &d->flags);
 		rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
@@ -1918,7 +1936,7 @@ static void rfcomm_process_dlcs(struct rfcomm_session *s)
 					d->state_change(d, 0);
 					rfcomm_dlc_unlock(d);
 				} else
-					rfcomm_dlc_accept(d);
+					__rfcomm_dlc_accept(d);
 			}
 			continue;
 		} else if (test_and_clear_bit(RFCOMM_AUTH_REJECT, &d->flags)) {
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 97c48f350ce0..5d6022d8c715 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -641,6 +641,16 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	return matches;
 }
 
+void can_set_skb_uid(struct sk_buff *skb)
+{
+	/* create non-zero unique skb identifier together with *skb */
+	while (!(skb->hash))
+		skb->hash = atomic_inc_return(&skbcounter);
+
+	skb->sw_hash = 1;
+}
+EXPORT_SYMBOL(can_set_skb_uid);
+
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
 	struct can_dev_rcv_lists *dev_rcv_lists;
@@ -652,9 +662,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	atomic_long_inc(&pkg_stats->rx_frames);
 	atomic_long_inc(&pkg_stats->rx_frames_delta);
 
-	/* create non-zero unique skb identifier together with *skb */
-	while (!(can_skb_prv(skb)->skbcnt))
-		can_skb_prv(skb)->skbcnt = atomic_inc_return(&skbcounter);
+	can_set_skb_uid(skb);
 
 	rcu_read_lock();
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index f655764aae83..df81d97e693f 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -338,7 +338,6 @@ static void bcm_can_tx(struct bcm_op *op, struct canfd_frame *cf)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	skb_put_data(skb, cf, op->cfsiz);
 
@@ -1577,7 +1576,6 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 	}
 
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 	err = can_send(skb, 1); /* send with loopback */
diff --git a/net/can/isotp.c b/net/can/isotp.c
index f23862b465ca..b79ba8c22b1a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -114,6 +114,15 @@ MODULE_ALIAS("can-proto-6");
 #define ISOTP_FC_TIMEOUT 1	/* 1 sec */
 #define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
 
+/* so->tx_result[so->tx_gen % ISOTP_TX_RESULT_SLOTS] holds the packed value
+ * (err << ISOTP_TX_RESULT_GEN_BITS | gen) for each tx generation slot, so it
+ * can be handled with a single READ_ONCE()/WRITE_ONCE() access.
+ */
+#define ISOTP_TX_RESULT_SLOTS 4
+#define ISOTP_TX_RESULT_GEN_BITS 24
+#define ISOTP_TX_RESULT_GEN_MASK ((1U << ISOTP_TX_RESULT_GEN_BITS) - 1)
+#define ISOTP_TX_RESULT_ERR_MASK 0xFF
+
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
@@ -150,7 +159,8 @@ struct isotp_sock {
 	u32 force_tx_stmin;
 	u32 force_rx_stmin;
 	u32 cfecho; /* consecutive frame echo tag */
-	u32 tx_gen; /* generation, bumped per new tx transfer */
+	u32 tx_gen; /* transfer generation, increased per new tx transfer */
+	u32 tx_result[ISOTP_TX_RESULT_SLOTS]; /* per-generation result slots */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
@@ -161,6 +171,65 @@ static LIST_HEAD(isotp_notifier_list);
 static DEFINE_SPINLOCK(isotp_notifier_lock);
 static struct isotp_sock *isotp_busy_notifier;
 
+/* increase (24 bit) tx generation value */
+static u32 isotp_inc_tx_gen(u32 gen)
+{
+	return (gen + 1) & ISOTP_TX_RESULT_GEN_MASK;
+}
+
+/* store 8 bit error and 24 bit tx generation values in packed u32 element */
+static u32 isotp_pack_tx_result(u32 gen, int err)
+{
+	return gen | ((u32)err << ISOTP_TX_RESULT_GEN_BITS);
+}
+
+/* get the 24 bit tx generation value from the tx result */
+static u32 isotp_get_tx_gen(u32 gen_err)
+{
+	return gen_err & ISOTP_TX_RESULT_GEN_MASK;
+}
+
+/* get the 8 bit error value from the tx result */
+static u32 isotp_get_tx_err(u32 gen_err)
+{
+	return (gen_err >> ISOTP_TX_RESULT_GEN_BITS) & ISOTP_TX_RESULT_ERR_MASK;
+}
+
+/* store transfer result in per-generation%4 so->tx_result[] slot */
+static void isotp_set_tx_result(struct isotp_sock *so, u32 gen, int err)
+{
+	WRITE_ONCE(so->tx_result[gen % ISOTP_TX_RESULT_SLOTS],
+		   isotp_pack_tx_result(gen, err));
+}
+
+/* fetch the result recorded for 'gen', as a (negative) errno (0 for success) */
+static int isotp_get_tx_result(struct isotp_sock *so, u32 gen)
+{
+	u32 result = READ_ONCE(so->tx_result[gen % ISOTP_TX_RESULT_SLOTS]);
+
+	if (isotp_get_tx_gen(result) != gen) {
+		pr_notice_once("can-isotp: tx_result[] slot reused before read\n");
+
+		/* report failure rather than risk a false success */
+		return -ECOMM;
+	}
+
+	return -(isotp_get_tx_err(result));
+}
+
+/* true if done, shut down or superseded ('gen' is no longer the active
+ * transfer). Reads tx.state first (acquire) so tx_gen/tx_result reads
+ * below see at least what that state write published (common sequence).
+ */
+static bool isotp_tx_gen_done(struct isotp_sock *so, u32 gen)
+{
+	/* read tx.state first for the common sequence */
+	u32 state = smp_load_acquire(&so->tx.state);
+
+	return state == ISOTP_IDLE || state == ISOTP_SHUTDOWN ||
+	       READ_ONCE(so->tx_gen) != gen;
+}
+
 static inline struct isotp_sock *isotp_sk(const struct sock *sk)
 {
 	return (struct isotp_sock *)sk;
@@ -183,7 +252,7 @@ static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 					     rxtimer);
 	struct sock *sk = &so->sk;
 
-	if (so->rx.state == ISOTP_WAIT_DATA) {
+	if (READ_ONCE(so->rx.state) == ISOTP_WAIT_DATA) {
 		/* we did not get new data frames in time */
 
 		/* report 'connection timed out' */
@@ -192,7 +261,7 @@ static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 			sk->sk_error_report(sk);
 
 		/* reset rx state */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 	}
 
 	return HRTIMER_NORESTART;
@@ -218,7 +287,6 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	can_skb_reserve(nskb);
 	can_skb_prv(nskb)->ifindex = dev->ifindex;
-	can_skb_prv(nskb)->skbcnt = 0;
 
 	nskb->dev = dev;
 	can_skb_set_owner(nskb, sk);
@@ -350,20 +418,19 @@ static void isotp_send_cframe(struct isotp_sock *so);
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 {
 	struct sock *sk = &so->sk;
+	int tx_err = EBADMSG; /* default for unknown FC status */
 
-	if (so->tx.state != ISOTP_WAIT_FC &&
-	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+	if (READ_ONCE(so->tx.state) != ISOTP_WAIT_FC &&
+	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
 		return 0;
 
 	hrtimer_cancel(&so->txtimer);
 
 	/* isotp_tx_timeout() may have given up on this job while
-	 * hrtimer_cancel() above waited for it to finish; so->rx_lock
-	 * (held by our caller isotp_rcv()) rules out a concurrent claim,
-	 * so a plain recheck is enough here.
+	 * hrtimer_cancel() above waited for it to finish => recheck
 	 */
-	if (so->tx.state != ISOTP_WAIT_FC &&
-	    so->tx.state != ISOTP_WAIT_FIRST_FC)
+	if (READ_ONCE(so->tx.state) != ISOTP_WAIT_FC &&
+	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
 		return 1;
 
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
@@ -374,13 +441,15 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk->sk_error_report(sk);
 
-		so->tx.state = ISOTP_IDLE;
+		isotp_set_tx_result(so, so->tx_gen, EBADMSG);
+		/* set to IDLE after publishing tx_result */
+		smp_store_release(&so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 		return 1;
 	}
 
 	/* get communication parameters only from the first FC frame */
-	if (so->tx.state == ISOTP_WAIT_FIRST_FC) {
+	if (READ_ONCE(so->tx.state) == ISOTP_WAIT_FIRST_FC) {
 		so->txfc.bs = cf->data[ae + 1];
 		so->txfc.stmin = cf->data[ae + 2];
 
@@ -403,13 +472,13 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 			so->tx_gap = ktime_add_ns(so->tx_gap,
 						  (so->txfc.stmin - 0xF0)
 						  * 100000);
-		so->tx.state = ISOTP_WAIT_FC;
+		WRITE_ONCE(so->tx.state, ISOTP_WAIT_FC);
 	}
 
 	switch (cf->data[ae] & 0x0F) {
 	case ISOTP_FC_CTS:
 		so->tx.bs = 0;
-		so->tx.state = ISOTP_SENDING;
+		WRITE_ONCE(so->tx.state, ISOTP_SENDING);
 		/* send CF frame and enable echo timeout handling */
 		hrtimer_start(&so->echotimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
@@ -424,14 +493,19 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 
 	case ISOTP_FC_OVFLW:
 		/* overflow on receiver side - report 'message too long' */
-		sk->sk_err = EMSGSIZE;
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk->sk_error_report(sk);
+		tx_err = EMSGSIZE;
 		fallthrough;
 
 	default:
-		/* stop this tx job */
-		so->tx.state = ISOTP_IDLE;
+		/* reserved/unknown flow status (tx_err defaults to EBADMSG) */
+
+		sk->sk_err = tx_err;
+		if (!sock_flag(sk, SOCK_DEAD))
+			sk->sk_error_report(sk);
+
+		isotp_set_tx_result(so, so->tx_gen, tx_err);
+		/* set to IDLE after publishing tx_result */
+		smp_store_release(&so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 	}
 	return 0;
@@ -444,7 +518,7 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 	struct sk_buff *nskb;
 
 	hrtimer_cancel(&so->rxtimer);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 	if (!len || len > cf->len - pcilen)
 		return 1;
@@ -478,7 +552,7 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 	int ff_pci_sz;
 
 	hrtimer_cancel(&so->rxtimer);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 	/* get the used sender LL_DL from the (first) CAN frame data length */
 	so->rx.ll_dl = padlen(cf->len);
@@ -522,7 +596,7 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 
 	/* initial setup for this pdu reception */
 	so->rx.sn = 1;
-	so->rx.state = ISOTP_WAIT_DATA;
+	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);
 
 	/* no creation of flow control frames */
 	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
@@ -540,7 +614,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	struct sk_buff *nskb;
 	int i;
 
-	if (so->rx.state != ISOTP_WAIT_DATA)
+	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 0;
 
 	/* drop if timestamp gap is less than force_rx_stmin nano secs */
@@ -555,11 +629,9 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	hrtimer_cancel(&so->rxtimer);
 
 	/* isotp_rx_timer_handler() may have raced us for so->rx.state
-	 * while hrtimer_cancel() above waited for it to finish, already
-	 * reporting ETIMEDOUT and resetting the reception; don't process
-	 * this CF into a reassembly that has already been given up on.
+	 * while hrtimer_cancel() above waited for it to finish => recheck
 	 */
-	if (so->rx.state != ISOTP_WAIT_DATA)
+	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 1;
 
 	/* CFs are never longer than the FF */
@@ -580,7 +652,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 			sk->sk_error_report(sk);
 
 		/* reset rx state */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 		return 1;
 	}
 	so->rx.sn++;
@@ -594,7 +666,7 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 
 	if (so->rx.idx >= so->rx.len) {
 		/* we are done */
-		so->rx.state = ISOTP_IDLE;
+		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 		if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 		    check_pad(so, cf, i + 1, so->opt.rxpad_content)) {
@@ -665,8 +737,10 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 
 	if (so->opt.flags & CAN_ISOTP_HALF_DUPLEX) {
 		/* check rx/tx path half duplex expectations */
-		if ((so->tx.state != ISOTP_IDLE && n_pci_type != N_PCI_FC) ||
-		    (so->rx.state != ISOTP_IDLE && n_pci_type == N_PCI_FC))
+		if ((READ_ONCE(so->tx.state) != ISOTP_IDLE &&
+		     n_pci_type != N_PCI_FC) ||
+		    (READ_ONCE(so->rx.state) != ISOTP_IDLE &&
+		     n_pci_type == N_PCI_FC))
 			goto out_unlock;
 	}
 
@@ -760,6 +834,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	struct canfd_frame *cf;
 	int can_send_ret;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+	u32 old_cfecho;
 
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev)
@@ -773,7 +848,9 @@ static void isotp_send_cframe(struct isotp_sock *so)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
+
+	/* set uid in tx skb to identify CF echo frames */
+	can_set_skb_uid(skb);
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
@@ -791,12 +868,15 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	skb->dev = dev;
 	can_skb_set_owner(skb, sk);
 
-	/* cfecho should have been zero'ed by init/isotp_rcv_echo() */
-	if (so->cfecho)
-		pr_notice_once("can-isotp: cfecho is %08X != 0\n", so->cfecho);
+	/* zero'ed by init/isotp_rcv_echo(); reached lock-free via
+	 * isotp_txfr_timer_handler() too, so use READ_ONCE()/WRITE_ONCE()
+	 */
+	old_cfecho = READ_ONCE(so->cfecho);
+	if (old_cfecho)
+		pr_notice_once("can-isotp: cfecho is %08X != 0\n", old_cfecho);
 
 	/* set consecutive frame echo tag */
-	so->cfecho = *(u32 *)cf->data;
+	WRITE_ONCE(so->cfecho, skb->hash);
 
 	/* send frame with local echo enabled */
 	can_send_ret = can_send(skb, 1);
@@ -848,7 +928,6 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 {
 	struct sock *sk = (struct sock *)data;
 	struct isotp_sock *so = isotp_sk(sk);
-	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 
 	/* only handle my own local echo CF/SF skb's (no FF!) */
 	if (skb->sk != sk)
@@ -860,32 +939,35 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	spin_lock(&so->rx_lock);
 
 	/* so->cfecho may since belong to a new transfer; recheck under lock */
-	if (so->cfecho != *(u32 *)cf->data)
+	if (READ_ONCE(so->cfecho) != skb->hash)
 		goto out_unlock;
 
 	/* cancel local echo timeout */
 	hrtimer_cancel(&so->echotimer);
 
 	/* local echo skb with consecutive frame has been consumed */
-	so->cfecho = 0;
+	WRITE_ONCE(so->cfecho, 0);
 
 	/* claiming a transfer also takes so->rx_lock, so a plain recheck
 	 * is enough: so->tx.state can't have flipped to ISOTP_SENDING for
 	 * a new claim while we're still in here
 	 */
-	if (so->tx.state != ISOTP_SENDING)
+	if (READ_ONCE(so->tx.state) != ISOTP_SENDING)
 		goto out_unlock;
 
 	if (so->tx.idx >= so->tx.len) {
 		/* we are done */
-		so->tx.state = ISOTP_IDLE;
+
+		isotp_set_tx_result(so, so->tx_gen, 0);
+		/* set to IDLE after publishing tx_result */
+		smp_store_release(&so->tx.state, ISOTP_IDLE);
 		wake_up_interruptible(&so->wait);
 		goto out_unlock;
 	}
 
 	if (so->txfc.bs && so->tx.bs >= so->txfc.bs) {
 		/* stop and wait for FC with timeout */
-		so->tx.state = ISOTP_WAIT_FC;
+		WRITE_ONCE(so->tx.state, ISOTP_WAIT_FC);
 		hrtimer_start(&so->txtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
 			      HRTIMER_MODE_REL_SOFT);
 		goto out_unlock;
@@ -907,16 +989,20 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 	spin_unlock(&so->rx_lock);
 }
 
-/* shared by so->txtimer's and so->echotimer's callbacks. Both timers get
- * cancelled under so->rx_lock elsewhere, so this must stay lock-free to
- * avoid deadlocking with that; uses so->tx_gen instead to avoid tainting
- * a new transfer with an error from the one that just timed out.
+/* isotp_tx_timeout: we did not get any flow control or echo frame in time
+ *
+ * Shared by so->txtimer's and so->echotimer's callbacks. Both timers get
+ * cancelled under so->rx_lock elsewhere, so this must stay lock-free.
+ *
+ * tx.state is acquired before tx_gen. Common sequence in isotp_tx_gen_done().
+ * cmpxchg() only orders itself, not the two preceding loads.
  */
 static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 {
 	struct sock *sk = &so->sk;
+	/* read tx.state first for the common sequence */
+	u32 old_state = smp_load_acquire(&so->tx.state);
 	u32 gen = READ_ONCE(so->tx_gen);
-	u32 old_state = READ_ONCE(so->tx.state);
 
 	/* don't handle timeouts in IDLE or SHUTDOWN state */
 	if (old_state == ISOTP_IDLE || old_state == ISOTP_SHUTDOWN)
@@ -926,14 +1012,14 @@ static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
 	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
 		return HRTIMER_NORESTART;
 
-	/* we did not get any flow control or echo frame in time */
+	/* detected timeout: report 'communication error on send' */
 
-	if (READ_ONCE(so->tx_gen) == gen) {
-		/* report 'communication error on send' */
-		sk->sk_err = ECOMM;
-		if (!sock_flag(sk, SOCK_DEAD))
-			sk->sk_error_report(sk);
-	}
+	/* a stale read of this slot by a waiter still falls back to ECOMM */
+	isotp_set_tx_result(so, gen, ECOMM);
+
+	sk->sk_err = ECOMM;
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk->sk_error_report(sk);
 
 	wake_up_interruptible(&so->wait);
 
@@ -968,7 +1054,7 @@ static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
 		      HRTIMER_MODE_REL_SOFT);
 
 	/* cfecho should be consumed by isotp_rcv_echo() here */
-	if (so->tx.state == ISOTP_SENDING && !so->cfecho)
+	if (READ_ONCE(so->tx.state) == ISOTP_SENDING && !READ_ONCE(so->cfecho))
 		isotp_send_cframe(so);
 
 	return HRTIMER_NORESTART;
@@ -986,10 +1072,12 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	struct hrtimer *tx_hrt = &so->echotimer;
 	u32 new_state = ISOTP_SENDING;
+	u32 my_gen;
+	u32 old_cfecho;
 	int off;
 	int err;
 
-	if (!so->bound || so->tx.state == ISOTP_SHUTDOWN)
+	if (!so->bound || READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 		return -EADDRNOTAVAIL;
 
 	/* claim the socket under so->rx_lock: this serializes the claim
@@ -1006,29 +1094,33 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		if (msg->msg_flags & MSG_DONTWAIT)
 			return -EAGAIN;
 
-		if (so->tx.state == ISOTP_SHUTDOWN)
+		if (READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait,
-					       so->tx.state == ISOTP_IDLE);
+					       READ_ONCE(so->tx.state) == ISOTP_IDLE ||
+					       READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN);
 		if (err)
 			return err;
 	}
 
-	/* new transfer: bump so->tx_gen and drain the old one's timers,
-	 * still under the so->rx_lock we just claimed the socket with
-	 */
-	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
-	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
+	/* txfrtimer's callback re-arms echotimer lock-free: drain it first */
+	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->echotimer);
-	hrtimer_cancel(&so->txfrtimer);
-	so->cfecho = 0;
+
+	/* new transfer: increment so->tx_gen and set tx.state after barrier */
+	my_gen = isotp_inc_tx_gen(READ_ONCE(so->tx_gen));
+	isotp_set_tx_result(so, my_gen, ECOMM); /* prevent stale slot matching */
+	WRITE_ONCE(so->tx_gen, my_gen);
+	smp_wmb(); /* see smp_load_acquire() in isotp_tx_[timeout|gen_done] */
+	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
+	WRITE_ONCE(so->cfecho, 0);
 	spin_unlock_bh(&so->rx_lock);
 
 	/* so->bound is only checked once above - a wakeup may have
-	 * unbound/rebound the socket meanwhile, so re-validate it
+	 * unbound/rebound the socket meanwhile => recheck
 	 */
 	if (!so->bound) {
 		err = -EADDRNOTAVAIL;
@@ -1069,7 +1161,9 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
+
+	/* set uid in tx skb to identify CF echo frames */
+	can_set_skb_uid(skb);
 
 	so->tx.len = size;
 	so->tx.idx = 0;
@@ -1078,8 +1172,9 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb_put_zero(skb, so->ll.mtu);
 
 	/* cfecho should have been zero'ed by init / former isotp_rcv_echo() */
-	if (so->cfecho)
-		pr_notice_once("can-isotp: uninit cfecho %08X\n", so->cfecho);
+	old_cfecho = READ_ONCE(so->cfecho);
+	if (old_cfecho)
+		pr_notice_once("can-isotp: uninit cfecho %08X\n", old_cfecho);
 
 	/* check for single frame transmission depending on TX_DL */
 	if (size <= so->tx.ll_dl - SF_PCI_SZ4 - ae - off) {
@@ -1107,7 +1202,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			cf->data[ae] |= size;
 
 		/* set CF echo tag for isotp_rcv_echo() (SF-mode) */
-		so->cfecho = *(u32 *)cf->data;
+		WRITE_ONCE(so->cfecho, skb->hash);
 	} else {
 		/* send first frame */
 
@@ -1124,7 +1219,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			so->txfc.bs = 0;
 
 			/* set CF echo tag for isotp_rcv_echo() (CF-mode) */
-			so->cfecho = *(u32 *)cf->data;
+			WRITE_ONCE(so->cfecho, skb->hash);
 		} else {
 			/* standard flow control check */
 			new_state = ISOTP_WAIT_FIRST_FC;
@@ -1134,12 +1229,12 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			tx_hrt = &so->txtimer;
 
 			/* no CF echo tag for isotp_rcv_echo() (FF-mode) */
-			so->cfecho = 0;
+			WRITE_ONCE(so->cfecho, 0);
 		}
 	}
 
 	spin_lock_bh(&so->rx_lock);
-	if (so->tx.state == ISOTP_SHUTDOWN) {
+	if (READ_ONCE(so->tx.state) == ISOTP_SHUTDOWN) {
 		/* isotp_release() has since taken over and already drained
 		 * our timers - don't send into a socket that's going away
 		 */
@@ -1150,7 +1245,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		return -EADDRNOTAVAIL;
 	}
 	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
-	so->tx.state = new_state;
+	WRITE_ONCE(so->tx.state, new_state);
 	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
 		      HRTIMER_MODE_REL_SOFT);
 	spin_unlock_bh(&so->rx_lock);
@@ -1167,20 +1262,49 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			       __func__, ERR_PTR(err));
 
 		spin_lock_bh(&so->rx_lock);
+
+		/* new transfer already claimed by a concurrent completion,
+		 * timeout or sendmsg() while we were stuck in can_send()?
+		 */
+		if (READ_ONCE(so->tx_gen) != my_gen) {
+			/* don't touch timers and state of the new transfer */
+			spin_unlock_bh(&so->rx_lock);
+			return err;
+		}
+
 		/* no transmission -> no timeout monitoring */
 		hrtimer_cancel(tx_hrt);
 		goto err_out_drop_locked;
 	}
 
 	if (wait_tx_done) {
-		/* wait for complete transmission of current pdu */
-		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+		/* wake up for:
+		 * - concurrent sendmsg() claiming a new transfer
+		 * - complete transmission of current PDU
+		 * - shutdown state change in isotp_release()
+		 * isotp_tx_gen_done() uses common tx.state/tx_gen read sequence
+		 */
+		err = wait_event_interruptible(so->wait,
+					       isotp_tx_gen_done(so, my_gen));
 		if (err)
 			goto err_event_drop;
 
-		err = sock_error(sk);
-		if (err)
-			return err;
+		/* still our claim, but isotp_release() force-shut it down */
+		if (smp_load_acquire(&so->tx.state) == ISOTP_SHUTDOWN &&
+		    READ_ONCE(so->tx_gen) == my_gen) {
+			err = -EADDRNOTAVAIL;
+			goto err_event_drop;
+		}
+
+		/* own completion, or tx_gen moved on - either way this is
+		 * what isotp_get_tx_result() recorded for my_gen
+		 */
+		err = isotp_get_tx_result(so, my_gen);
+
+		/* drain to avoid stale error for a later poll()/SO_ERROR */
+		sock_error(sk);
+
+		return err ? err : size;
 	}
 
 	return size;
@@ -1190,15 +1314,26 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	spin_lock_bh(&so->rx_lock);
 	goto err_out_drop_locked;
 err_event_drop:
-	/* interrupted waiting on our own transfer - drain its timers */
+	/* interrupted or shut down while waiting on our own transfer */
 	spin_lock_bh(&so->rx_lock);
+
+	/* new transfer already started by concurrent sendmsg()? */
+	if (READ_ONCE(so->tx_gen) != my_gen) {
+		/* don't touch timers and states of the new transfer */
+		spin_unlock_bh(&so->rx_lock);
+		return err;
+	}
+
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->echotimer);
 err_out_drop_locked:
 	/* release the claim; so->rx_lock still held from above */
-	so->cfecho = 0;
-	so->tx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->cfecho, 0);
+
+	/* only claim to IDLE if isotp_release() has not taken over */
+	if (READ_ONCE(so->tx.state) != ISOTP_SHUTDOWN)
+		WRITE_ONCE(so->tx.state, ISOTP_IDLE);
 	spin_unlock_bh(&so->rx_lock);
 	wake_up_interruptible(&so->wait);
 
@@ -1266,8 +1401,9 @@ static int isotp_release(struct socket *sock)
 	/* best-effort: wait for a running pdu to finish, but don't block on
 	 * it forever - give up after the first signal
 	 */
-	while (so->tx.state != ISOTP_IDLE &&
-	       wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE) == 0)
+	while (READ_ONCE(so->tx.state) != ISOTP_IDLE &&
+	       wait_event_interruptible(so->wait,
+					READ_ONCE(so->tx.state) == ISOTP_IDLE) == 0)
 		;
 
 	/* claim the socket under so->rx_lock like sendmsg() does, so its
@@ -1275,9 +1411,12 @@ static int isotp_release(struct socket *sock)
 	 * unconditionally, even when a signal cut the wait above short
 	 */
 	spin_lock_bh(&so->rx_lock);
-	so->tx.state = ISOTP_SHUTDOWN;
+	WRITE_ONCE(so->tx.state, ISOTP_SHUTDOWN);
 	spin_unlock_bh(&so->rx_lock);
-	so->rx.state = ISOTP_IDLE;
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
+
+	/* forced SHUTDOWN may have skipped IDLE (gave up on a signal) */
+	wake_up_interruptible(&so->wait);
 
 	spin_lock(&isotp_notifier_lock);
 	while (isotp_busy_notifier == so) {
@@ -1392,7 +1531,8 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	 * with so->bound in the same lock_sock() section above, so there is
 	 * no window in which a concurrent isotp_notify() could be missed.
 	 */
-	if (so->tx.state != ISOTP_IDLE || so->rx.state != ISOTP_IDLE) {
+	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
+	    READ_ONCE(so->rx.state) != ISOTP_IDLE) {
 		err = -EAGAIN;
 		goto out;
 	}
@@ -1426,7 +1566,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 				isotp_rcv, sk, "isotp", sk);
 
 	/* no consecutive frame echo skb in flight */
-	so->cfecho = 0;
+	WRITE_ONCE(so->cfecho, 0);
 
 	/* register for echo skb's */
 	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
@@ -1769,7 +1909,7 @@ static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *w
 	poll_wait(file, &so->wait, wait);
 
 	/* Check for false positives due to TX state */
-	if ((mask & EPOLLWRNORM) && (so->tx.state != ISOTP_IDLE))
+	if ((mask & EPOLLWRNORM) && (READ_ONCE(so->tx.state) != ISOTP_IDLE))
 		mask &= ~(EPOLLOUT | EPOLLWRNORM);
 
 	return mask;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 34cd4792d5d4..551617b761ba 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -889,7 +889,6 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4116b5150526..ff1a5fee7b0e 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -608,7 +608,6 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
 
@@ -1535,7 +1534,6 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
 
diff --git a/net/can/raw.c b/net/can/raw.c
index 7bcbcea60b1d..db10c8758391 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -74,8 +74,8 @@ MODULE_ALIAS("can-proto-1");
  */
 
 struct uniqframe {
-	int skbcnt;
 	const struct sk_buff *skb;
+	u32 hash;
 	unsigned int join_rx_count;
 };
 
@@ -135,7 +135,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 
 	/* eliminate multiple filter matches for the same skb */
 	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
-	    this_cpu_ptr(ro->uniq)->skbcnt == can_skb_prv(oskb)->skbcnt) {
+	    this_cpu_ptr(ro->uniq)->hash == oskb->hash) {
 		if (ro->join_filters) {
 			this_cpu_inc(ro->uniq->join_rx_count);
 			/* drop frame until all enabled filters matched */
@@ -146,7 +146,7 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 		}
 	} else {
 		this_cpu_ptr(ro->uniq)->skb = oskb;
-		this_cpu_ptr(ro->uniq)->skbcnt = can_skb_prv(oskb)->skbcnt;
+		this_cpu_ptr(ro->uniq)->hash = oskb->hash;
 		this_cpu_ptr(ro->uniq)->join_rx_count = 1;
 		/* drop first frame to check all enabled filters? */
 		if (ro->join_filters && ro->count > 1)
@@ -812,7 +812,6 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
 
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
 	if (err < 0)
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 89b02b8baca3..92d379c60da5 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4993,7 +4993,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kcalloc(*num_watchers, sizeof(**watchers), GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5007,6 +5007,9 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 /*
diff --git a/net/ipv4/fib_lookup.h b/net/ipv4/fib_lookup.h
index f8fe0da3d9af..becc52d9f3ac 100644
--- a/net/ipv4/fib_lookup.h
+++ b/net/ipv4/fib_lookup.h
@@ -44,6 +44,7 @@ int fib_dump_info(struct sk_buff *skb, u32 pid, u32 seq, int event,
 		  struct fib_rt_info *fri, unsigned int flags);
 void rtmsg_fib(int event, __be32 key, struct fib_alias *fa, int dst_len,
 	       u32 tb_id, const struct nl_info *info, unsigned int nlm_flags);
+size_t fib_nlmsg_size(struct fib_info *fi);
 
 static inline void fib_result_assign(struct fib_result *res,
 				     struct fib_info *fi)
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index e0370462293c..bf722eb5efac 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -460,7 +460,35 @@ int ip_fib_check_default(__be32 gw, struct net_device *dev)
 	return -1;
 }
 
-static inline size_t fib_nlmsg_size(struct fib_info *fi)
+static size_t fib_nexthop_nlmsg_size(const struct fib_nh_common *nhc,
+				     bool skip_oif)
+{
+	size_t nhsize = 0;
+
+	switch (nhc->nhc_gw_family) {
+	case AF_INET:
+		nhsize += nla_total_size(4); /* RTA_GATEWAY */
+		break;
+	case AF_INET6:
+		nhsize += nla_total_size(sizeof(struct rtvia) +
+					 sizeof(struct in6_addr));
+		break;
+	}
+
+	if (!skip_oif && nhc->nhc_dev)
+		nhsize += nla_total_size(4); /* RTA_OIF */
+
+	if (nhc->nhc_lwtstate) {
+		/* RTA_ENCAP */
+		nhsize += lwtunnel_get_encap_size(nhc->nhc_lwtstate);
+		/* RTA_ENCAP_TYPE */
+		nhsize += nla_total_size(2);
+	}
+
+	return nhsize;
+}
+
+size_t fib_nlmsg_size(struct fib_info *fi)
 {
 	size_t payload = NLMSG_ALIGN(sizeof(struct rtmsg))
 			 + nla_total_size(4) /* RTA_TABLE */
@@ -477,32 +505,35 @@ static inline size_t fib_nlmsg_size(struct fib_info *fi)
 		payload += nla_total_size(4); /* RTA_NH_ID */
 
 	if (nhs) {
-		size_t nh_encapsize = 0;
-		/* Also handles the special case nhs == 1 */
-
-		/* each nexthop is packed in an attribute */
-		size_t nhsize = nla_total_size(sizeof(struct rtnexthop));
+		size_t mpsize = 0;
 		unsigned int i;
 
-		/* may contain flow and gateway attribute */
-		nhsize += 2 * nla_total_size(4);
-
-		/* grab encap info */
 		for (i = 0; i < fib_info_num_path(fi); i++) {
 			struct fib_nh_common *nhc = fib_info_nhc(fi, i);
+			size_t nhsize;
+
+			nhsize = fib_nexthop_nlmsg_size(nhc, nhs != 1);
 
-			if (nhc->nhc_lwtstate) {
-				/* RTA_ENCAP_TYPE */
-				nh_encapsize += lwtunnel_get_encap_size(
-						nhc->nhc_lwtstate);
-				/* RTA_ENCAP */
-				nh_encapsize +=  nla_total_size(2);
+			if (nhs != 1)
+				nhsize += NLA_ALIGN(sizeof(struct rtnexthop));
+
+#ifdef CONFIG_IP_ROUTE_CLASSID
+			if (nhc->nhc_family == AF_INET) {
+				struct fib_nh *nh;
+
+				nh = container_of(nhc, struct fib_nh, nh_common);
+				if (nh->nh_tclassid)
+					nhsize += nla_total_size(4);
 			}
+#endif
+			if (nhs == 1)
+				payload += nhsize;
+			else
+				mpsize += nhsize;
 		}
 
-		/* all nexthops are packed in a nested attribute */
-		payload += nla_total_size((nhs * nhsize) + nh_encapsize);
-
+		if (nhs != 1)
+			payload += nla_total_size(mpsize);
 	}
 
 	return payload;
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 12ef3cb26676..016b224a17e5 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -308,16 +308,18 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 		*prev = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
-	mod_timer(&q->timer, jiffies + fqdir->timeout);
 
+	spin_lock_bh(&q->lock);
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
 		q->flags |= INET_FRAG_COMPLETE;
-		inet_frag_kill(q);
+		spin_unlock_bh(&q->lock);
 		inet_frag_destroy(q);
 		return NULL;
 	}
+	mod_timer(&q->timer, jiffies + fqdir->timeout);
+	spin_unlock_bh(&q->lock);
 	return q;
 }
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index bb94c032a373..89120dcc9060 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -798,6 +798,10 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 */
 
 	hlen = iph->ihl * 4;
+	if (mtu < hlen + 8) {
+		err = -EMSGSIZE;
+		goto fail;
+	}
 	mtu = mtu - hlen;	/* Size of data space */
 	IPCB(skb)->flags |= IPSKB_FRAG_COMPLETE;
 	ll_rs = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 764c003f9824..c8d975749c2b 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -118,6 +118,8 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
+		hdr = ipv6_hdr(skb);
+		daddr = &hdr->daddr;
 	}
 
 	rcu_read_lock_bh();
diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index e29dd10f280e..3c2d225d694a 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -778,6 +778,8 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
 
+	resp->len = min_t(unsigned int, resp->len, NFC_SENSF_RES_MAXSIZE);
+
 	memcpy(target.sensf_res, sensf_res, resp->len);
 	target.sensf_res_len = resp->len;
 
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 706da71c5f29..48d02c968601 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -201,9 +202,15 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -243,7 +250,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +259,15 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index c7de44637e01..c5971ccd33ea 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -856,13 +856,16 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
 	u8 type, length;
-	const u8 *tlv = &skb->data[2];
-	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
+	const u8 *tlv = &skb->data[LLCP_HEADER_SIZE];
+	const u8 *tlv_end = skb_tail_pointer(skb);
 
-	while (offset < tlv_array_len) {
+	while (tlv + 2 < tlv_end) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (tlv + 2 + length > tlv_end)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		if (type == LLCP_TLV_SN) {
@@ -870,7 +873,6 @@ static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 			return &tlv[2];
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
@@ -1559,6 +1561,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
 
 static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
+	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	local->rx_pending = skb;
 	del_timer(&local->link_timer);
 	schedule_work(&local->rx_work);
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index f8b20cddd5c9..fd0ef696ea71 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -448,6 +448,12 @@ static void nci_target_auto_activated(struct nci_dev *ndev,
 	struct nfc_target *target;
 	int rc;
 
+	/* This is a new target, check if we've enough room */
+	if (ndev->n_targets == NCI_MAX_DISCOVERED_TARGETS) {
+		pr_debug("not enough room, ignoring new target...\n");
+		return;
+	}
+
 	target = &ndev->targets[ndev->n_targets];
 
 	rc = nci_add_new_protocol(ndev, target, ntf->rf_protocol,
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index b0ed2b47ac43..60a68e29cb70 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -279,6 +279,7 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 			list_del(&conn_info->list);
 			if (conn_info == ndev->rf_conn_info)
 				ndev->rf_conn_info = NULL;
+			devm_kfree(&ndev->nfc_dev->dev, conn_info->dest_params);
 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 		}
 	}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b040b20b5e92..d756ecc75a41 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1330,13 +1330,25 @@ static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
 	return ret;
 }
 
-static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+static void __packet_rcv_try_clear_pressure(struct packet_sock *po)
 {
 	if (READ_ONCE(po->pressure) &&
 	    __packet_rcv_has_room(po, NULL) == ROOM_NORMAL)
 		WRITE_ONCE(po->pressure,  0);
 }
 
+static void packet_rcv_try_clear_pressure(struct packet_sock *po)
+{
+	struct sock *sk = &po->sk;
+
+	if (!READ_ONCE(po->pressure))
+		return;
+
+	spin_lock_bh(&sk->sk_receive_queue.lock);
+	__packet_rcv_try_clear_pressure(po);
+	spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 static void packet_sock_destruct(struct sock *sk)
 {
 	skb_queue_purge(&sk->sk_error_queue);
@@ -1968,8 +1980,9 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 	struct net_device *dev;
 	struct sockcm_cookie sockc;
 	__be16 proto = 0;
-	int err;
+	int hard_header_len;
 	int extra_len = 0;
+	int err;
 
 	/*
 	 *	Get and verify the address.
@@ -2012,14 +2025,18 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		extra_len = 4; /* We're doing our own CRC */
 	}
 
+	/* Keep the allocation-time header length across retry. */
+	if (!skb)
+		hard_header_len = READ_ONCE(dev->hard_header_len);
+
 	err = -EMSGSIZE;
-	if (len > dev->mtu + dev->hard_header_len + VLAN_HLEN + extra_len)
+	if (len > dev->mtu + hard_header_len + VLAN_HLEN + extra_len)
 		goto out_unlock;
 
 	if (!skb) {
-		size_t reserved = LL_RESERVED_SPACE(dev);
+		size_t reserved = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		int tlen = dev->needed_tailroom;
-		unsigned int hhlen = dev->header_ops ? dev->hard_header_len : 0;
+		unsigned int hhlen = dev->header_ops ? hard_header_len : 0;
 
 		rcu_read_unlock();
 		skb = sock_wmalloc(sk, len + reserved + tlen, 0, GFP_KERNEL);
@@ -2049,7 +2066,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	if (len > (dev->mtu + dev->hard_header_len + extra_len) &&
+	if (len > (dev->mtu + hard_header_len + extra_len) &&
 	    !packet_extra_vlan_len_allowed(dev, skb)) {
 		err = -EMSGSIZE;
 		goto out_unlock;
@@ -2577,6 +2594,7 @@ static int packet_snd_vnet_parse(struct msghdr *msg, size_t *len,
 static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		void *frame, struct net_device *dev, void *data, int tp_len,
 		__be16 proto, unsigned char *addr, int hlen, int copylen,
+		int hard_header_len,
 		const struct sockcm_cookie *sockc)
 {
 	union tpacket_uhdr ph;
@@ -2608,8 +2626,8 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	} else if (copylen) {
 		int hdrlen = min_t(int, copylen, tp_len);
 
-		skb_push(skb, dev->hard_header_len);
-		skb_put(skb, copylen - dev->hard_header_len);
+		skb_push(skb, hard_header_len);
+		skb_put(skb, copylen - hard_header_len);
 		err = skb_store_bits(skb, 0, data, hdrlen);
 		if (unlikely(err))
 			return err;
@@ -2742,7 +2760,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	void *data;
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
-	int hlen, tlen, copylen = 0;
+	int hard_header_len, hlen, tlen, copylen = 0;
 	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
@@ -2789,8 +2807,9 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_put;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (po->sk.sk_socket->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	size_max = po->tx_ring.frame_size
 		- (po->tp_hdrlen - sizeof(struct sockaddr_ll));
 
@@ -2827,7 +2846,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE(dev);
+		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (po->has_vnet_hdr) {
 			data += sizeof(vnet_hdr);
@@ -2845,10 +2864,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 						    vnet_hdr.hdr_len);
 			has_vnet_hdr = true;
 		}
-		copylen = max_t(int, copylen, dev->hard_header_len);
+		copylen = max_t(int, copylen, hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
 				hlen + tlen + sizeof(struct sockaddr_ll) +
-				(copylen - dev->hard_header_len),
+				(copylen - hard_header_len),
 				!need_wait, &err);
 
 		if (unlikely(skb == NULL)) {
@@ -2858,7 +2877,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto out_status;
 		}
 		tp_len = tpacket_fill_skb(po, skb, ph, dev, data, tp_len, proto,
-					  addr, hlen, copylen, &sockc);
+					  addr, hlen, copylen, hard_header_len,
+					  &sockc);
 		if (likely(tp_len >= 0) &&
 		    tp_len > dev->mtu + reserve &&
 		    !po->has_vnet_hdr &&
@@ -2965,7 +2985,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	int offset = 0;
 	struct packet_sock *po = pkt_sk(sk);
 	bool has_vnet_hdr = false;
-	int hlen, tlen, linear;
+	int hard_header_len, hlen, tlen, linear;
 	int extra_len = 0;
 
 	/*
@@ -3006,8 +3026,9 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 			goto out_unlock;
 	}
 
+	hard_header_len = READ_ONCE(dev->hard_header_len);
 	if (sock->type == SOCK_RAW)
-		reserve = dev->hard_header_len;
+		reserve = hard_header_len;
 	if (po->has_vnet_hdr) {
 		err = packet_snd_vnet_parse(msg, &len, &vnet_hdr);
 		if (err)
@@ -3029,10 +3050,10 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE(dev);
+	hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
-	linear = max(linear, min_t(int, len, dev->hard_header_len));
+	linear = max(linear, min_t(int, len, hard_header_len));
 	skb = packet_alloc_skb(sk, hlen + tlen, hlen, len, linear,
 			       msg->msg_flags & MSG_DONTWAIT, &err);
 	if (skb == NULL)
@@ -3048,7 +3069,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	} else if (reserve) {
 		skb_reserve(skb, -reserve);
 		if (len < reserve + sizeof(struct ipv6hdr) &&
-		    dev->min_header_len != dev->hard_header_len)
+		    dev->min_header_len != hard_header_len)
 			skb_reset_network_header(skb);
 	}
 
@@ -4298,7 +4319,7 @@ static __poll_t packet_poll(struct file *file, struct socket *sock,
 			TP_STATUS_KERNEL))
 			mask |= EPOLLIN | EPOLLRDNORM;
 	}
-	packet_rcv_try_clear_pressure(po);
+	__packet_rcv_try_clear_pressure(po);
 	spin_unlock_bh(&sk->sk_receive_queue.lock);
 	spin_lock_bh(&sk->sk_write_queue.lock);
 	if (po->tx_ring.pg_vec) {
@@ -4538,14 +4559,14 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		rb->frame_max = (req->tp_frame_nr - 1);
 		rb->head = 0;
 		rb->frame_size = req->tp_frame_size;
+		po->prot_hook.func = (po->rx_ring.pg_vec) ?
+						tpacket_rcv : packet_rcv;
 		spin_unlock_bh(&rb_queue->lock);
 
 		swap(rb->pg_vec_order, order);
 		swap(rb->pg_vec_len, req->tp_block_nr);
 
 		rb->pg_vec_pages = req->tp_block_size/PAGE_SIZE;
-		po->prot_hook.func = (po->rx_ring.pg_vec) ?
-						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
 		if (atomic_long_read(&po->mapped))
 			pr_err("packet_mmap: vma is busy: %ld\n",
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 34229be42c47..8c1e7d2d6737 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1045,6 +1045,9 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		unsigned int i, num_q, ingress;
 		struct netdev_queue *dev_queue;
 
+		if (new)
+			new->depth = 0;
+
 		ingress = 0;
 		num_q = dev->num_tx_queues;
 		if ((q && q->flags & TCQ_F_INGRESS) ||
@@ -1124,9 +1127,15 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 			NL_SET_ERR_MSG(extack, "STAB not supported on a non root");
 			return -EINVAL;
 		}
+		if (new && parent->depth >= 7) {
+			NL_SET_ERR_MSG(extack, "Qdisc hierarchy is too deep");
+			return -E2BIG;
+		}
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
+		if (new)
+			new->depth = parent->depth + 1;
 		notify_and_destroy(net, skb, n, classid, old, new);
 	}
 	return 0;
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 3dbbf52e2f9b..dad4daca3990 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -372,6 +372,7 @@ static void x25_destroy_timer(struct timer_list *t)
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
 	x25_destroy_socket_from_timer(sk);
+	sock_put(sk);
 }
 
 /*
@@ -407,9 +408,8 @@ static void __x25_destroy_socket(struct sock *sk)
 
 	if (sk_has_allocations(sk)) {
 		/* Defer: outstanding buffers */
-		sk->sk_timer.expires  = jiffies + 10 * HZ;
 		sk->sk_timer.function = x25_destroy_timer;
-		add_timer(&sk->sk_timer);
+		sk_reset_timer(sk, &sk->sk_timer, jiffies + 10 * HZ);
 	} else {
 		/* drop last reference so sock_put will free */
 		__sock_put(sk);
diff --git a/net/x25/x25_timer.c b/net/x25/x25_timer.c
index 9376365cdcc9..2afa8ecaf509 100644
--- a/net/x25/x25_timer.c
+++ b/net/x25/x25_timer.c
@@ -36,45 +36,45 @@ void x25_init_timers(struct sock *sk)
 
 void x25_start_heartbeat(struct sock *sk)
 {
-	mod_timer(&sk->sk_timer, jiffies + 5 * HZ);
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + 5 * HZ);
 }
 
 void x25_stop_heartbeat(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
 }
 
 void x25_start_t2timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t2);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t2);
 }
 
 void x25_start_t21timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t21);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t21);
 }
 
 void x25_start_t22timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t22);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t22);
 }
 
 void x25_start_t23timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t23);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t23);
 }
 
 void x25_stop_timer(struct sock *sk)
 {
-	del_timer(&x25_sk(sk)->timer);
+	sk_stop_timer(sk, &x25_sk(sk)->timer);
 }
 
 unsigned long x25_display_timer(struct sock *sk)
@@ -108,7 +108,7 @@ static void x25_heartbeat_expiry(struct timer_list *t)
 			     sock_flag(sk, SOCK_DEAD))) {
 				bh_unlock_sock(sk);
 				x25_destroy_socket_from_timer(sk);
-				return;
+				goto out;
 			}
 			break;
 
@@ -120,8 +120,14 @@ static void x25_heartbeat_expiry(struct timer_list *t)
 			break;
 	}
 restart_heartbeat:
-	x25_start_heartbeat(sk);
+	/* Do not rearm once __x25_destroy_socket() has unlinked the socket:
+	 * it is past its cancel point and owns the teardown from there on.
+	 */
+	if (sk_hashed(sk))
+		x25_start_heartbeat(sk);
 	bh_unlock_sock(sk);
+out:
+	sock_put(sk);
 }
 
 /*
@@ -166,4 +172,5 @@ static void x25_timer_expiry(struct timer_list *t)
 	} else
 		x25_do_timer_expiry(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 10f974d5ebee..c5412f2e3b20 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2399,7 +2399,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (sockptr_is_null(optval) && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		return 0;
 	}
 
@@ -2439,7 +2439,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (err >= 0) {
 		xfrm_sk_policy_insert(sk, err, pol);
 		xfrm_pol_put(pol);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		err = 0;
 	}
 
diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index c544bf85d25c..12028b3e2eee 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -121,9 +121,10 @@ static int onyx_snd_vol_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	s8 l, r;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, &l);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, &r);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = l + VOLUME_RANGE_SHIFT;
 	ucontrol->value.integer.value[1] = r + VOLUME_RANGE_SHIFT;
@@ -144,13 +145,15 @@ static int onyx_snd_vol_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[1] > -1 + VOLUME_RANGE_SHIFT)
 		return -EINVAL;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_LEFT, &l);
 	onyx_read_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT, &r);
 
 	if (l + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[0] &&
-	    r + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[1])
+	    r + VOLUME_RANGE_SHIFT == ucontrol->value.integer.value[1]) {
+		mutex_unlock(&onyx->mutex);
 		return 0;
+	}
 
 	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_LEFT,
 			    ucontrol->value.integer.value[0]
@@ -158,6 +161,7 @@ static int onyx_snd_vol_put(struct snd_kcontrol *kcontrol,
 	onyx_write_register(onyx, ONYX_REG_DAC_ATTEN_RIGHT,
 			    ucontrol->value.integer.value[1]
 			     - VOLUME_RANGE_SHIFT);
+	mutex_unlock(&onyx->mutex);
 
 	return 1;
 }
@@ -193,8 +197,9 @@ static int onyx_snd_inputgain_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 ig;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &ig);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] =
 		(ig & ONYX_ADC_PGA_GAIN_MASK) + INPUTGAIN_RANGE_SHIFT;
@@ -211,13 +216,14 @@ static int onyx_snd_inputgain_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < 3 + INPUTGAIN_RANGE_SHIFT ||
 	    ucontrol->value.integer.value[0] > 28 + INPUTGAIN_RANGE_SHIFT)
 		return -EINVAL;
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
 	n = v;
 	n &= ~ONYX_ADC_PGA_GAIN_MASK;
 	n |= (ucontrol->value.integer.value[0] - INPUTGAIN_RANGE_SHIFT)
 		& ONYX_ADC_PGA_GAIN_MASK;
 	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, n);
+	mutex_unlock(&onyx->mutex);
 
 	return n != v;
 }
@@ -245,8 +251,9 @@ static int onyx_snd_capture_source_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	s8 v;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.enumerated.item[0] = !!(v&ONYX_ADC_INPUT_MIC);
 
@@ -257,12 +264,13 @@ static void onyx_set_capture_source(struct onyx *onyx, int mic)
 {
 	s8 v;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_ADC_CONTROL, &v);
 	v &= ~ONYX_ADC_INPUT_MIC;
 	if (mic)
 		v |= ONYX_ADC_INPUT_MIC;
 	onyx_write_register(onyx, ONYX_REG_ADC_CONTROL, v);
+	mutex_unlock(&onyx->mutex);
 }
 
 static int onyx_snd_capture_source_put(struct snd_kcontrol *kcontrol,
@@ -303,8 +311,9 @@ static int onyx_snd_mute_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 c;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &c);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = !(c & ONYX_MUTE_LEFT);
 	ucontrol->value.integer.value[1] = !(c & ONYX_MUTE_RIGHT);
@@ -319,9 +328,9 @@ static int onyx_snd_mute_put(struct snd_kcontrol *kcontrol,
 	u8 v = 0, c = 0;
 	int err = -EBUSY;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	if (onyx->analog_locked)
-		return -EBUSY;
+		goto out_unlock;
 
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &v);
 	c = v;
@@ -332,6 +341,9 @@ static int onyx_snd_mute_put(struct snd_kcontrol *kcontrol,
 		c |= ONYX_MUTE_RIGHT;
 	err = onyx_write_register(onyx, ONYX_REG_DAC_CONTROL, c);
 
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
 	return !err ? (v != c) : err;
 }
 
@@ -360,8 +372,9 @@ static int onyx_snd_single_bit_get(struct snd_kcontrol *kcontrol,
 	u8 address = (pv >> 8) & 0xff;
 	u8 mask = pv & 0xff;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, address, &c);
+	mutex_unlock(&onyx->mutex);
 
 	ucontrol->value.integer.value[0] = !!(c & mask) ^ polarity;
 
@@ -380,10 +393,11 @@ static int onyx_snd_single_bit_put(struct snd_kcontrol *kcontrol,
 	u8 address = (pv >> 8) & 0xff;
 	u8 mask = pv & 0xff;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	if (spdiflock && onyx->spdif_locked) {
 		/* even if alsamixer doesn't care.. */
-		return -EBUSY;
+		err = -EBUSY;
+		goto out_unlock;
 	}
 	onyx_read_register(onyx, address, &v);
 	c = v;
@@ -392,6 +406,9 @@ static int onyx_snd_single_bit_put(struct snd_kcontrol *kcontrol,
 		c |= mask;
 	err = onyx_write_register(onyx, address, c);
 
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
 	return !err ? (v != c) : err;
 }
 
@@ -472,7 +489,7 @@ static int onyx_spdif_get(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 v;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO1, &v);
 	ucontrol->value.iec958.status[0] = v & 0x3e;
 
@@ -484,6 +501,7 @@ static int onyx_spdif_get(struct snd_kcontrol *kcontrol,
 
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	ucontrol->value.iec958.status[4] = v & 0x0f;
+	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -494,7 +512,7 @@ static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
 	struct onyx *onyx = snd_kcontrol_chip(kcontrol);
 	u8 v;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO1, &v);
 	v = (v & ~0x3e) | (ucontrol->value.iec958.status[0] & 0x3e);
 	onyx_write_register(onyx, ONYX_REG_DIG_INFO1, v);
@@ -509,6 +527,7 @@ static int onyx_spdif_put(struct snd_kcontrol *kcontrol,
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	v = (v & ~0x0f) | (ucontrol->value.iec958.status[4] & 0x0f);
 	onyx_write_register(onyx, ONYX_REG_DIG_INFO4, v);
+	mutex_unlock(&onyx->mutex);
 
 	return 1;
 }
@@ -653,13 +672,14 @@ static int onyx_usable(struct codec_info_item *cii,
 	struct onyx *onyx = cii->codec_data;
 	int spdif_enabled, analog_enabled;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx_read_register(onyx, ONYX_REG_DIG_INFO4, &v);
 	spdif_enabled = !!(v & ONYX_SPDIF_ENABLE);
 	onyx_read_register(onyx, ONYX_REG_DAC_CONTROL, &v);
 	analog_enabled =
 		(v & (ONYX_MUTE_RIGHT|ONYX_MUTE_LEFT))
 		 != (ONYX_MUTE_RIGHT|ONYX_MUTE_LEFT);
+	mutex_unlock(&onyx->mutex);
 
 	switch (ti->tag) {
 	case 0: return 1;
@@ -675,8 +695,9 @@ static int onyx_prepare(struct codec_info_item *cii,
 {
 	u8 v;
 	struct onyx *onyx = cii->codec_data;
+	int err = -EBUSY;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 
 #ifdef SNDRV_PCM_FMTBIT_COMPRESSED_16BE
 	if (substream->runtime->format == SNDRV_PCM_FMTBIT_COMPRESSED_16BE) {
@@ -685,9 +706,10 @@ static int onyx_prepare(struct codec_info_item *cii,
 		if (onyx_write_register(onyx,
 					ONYX_REG_DAC_CONTROL,
 					v | ONYX_MUTE_RIGHT | ONYX_MUTE_LEFT))
-			return -EBUSY;
+			goto out_unlock;
 		onyx->analog_locked = 1;
-		return 0;
+		err = 0;
+		goto out_unlock;
 	}
 #endif
 	switch (substream->runtime->rate) {
@@ -697,7 +719,8 @@ static int onyx_prepare(struct codec_info_item *cii,
 		/* these rates are ok for all outputs */
 		/* FIXME: program spdif channel control bits here so that
 		 *	  userspace doesn't have to if it only plays pcm! */
-		return 0;
+		err = 0;
+		goto out_unlock;
 	default:
 		/* got some rate that the digital output can't do,
 		 * so disable and lock it */
@@ -705,12 +728,16 @@ static int onyx_prepare(struct codec_info_item *cii,
 		if (onyx_write_register(onyx,
 					ONYX_REG_DIG_INFO4,
 					v & ~ONYX_SPDIF_ENABLE))
-			return -EBUSY;
+			goto out_unlock;
 		onyx->spdif_locked = 1;
-		return 0;
+		err = 0;
+		goto out_unlock;
 	}
 
-	return -EBUSY;
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
 }
 
 static int onyx_open(struct codec_info_item *cii,
@@ -718,8 +745,9 @@ static int onyx_open(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx->open_count++;
+	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -729,10 +757,11 @@ static int onyx_close(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	onyx->open_count--;
 	if (!onyx->open_count)
 		onyx->spdif_locked = onyx->analog_locked = 0;
+	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -742,7 +771,7 @@ static int onyx_switch_clock(struct codec_info_item *cii,
 {
 	struct onyx *onyx = cii->codec_data;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	/* this *MUST* be more elaborate later... */
 	switch (what) {
 	case CLOCK_SWITCH_PREPARE_SLAVE:
@@ -754,6 +783,7 @@ static int onyx_switch_clock(struct codec_info_item *cii,
 	default: /* silence warning */
 		break;
 	}
+	mutex_unlock(&onyx->mutex);
 
 	return 0;
 }
@@ -764,21 +794,27 @@ static int onyx_suspend(struct codec_info_item *cii, pm_message_t state)
 {
 	struct onyx *onyx = cii->codec_data;
 	u8 v;
+	int err = -ENXIO;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
-		return -ENXIO;
+		goto out_unlock;
 	onyx_write_register(onyx, ONYX_REG_CONTROL, v | ONYX_ADPSV | ONYX_DAPSV);
 	/* Apple does a sleep here but the datasheet says to do it on resume */
-	return 0;
+	err = 0;
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
 }
 
 static int onyx_resume(struct codec_info_item *cii)
 {
 	struct onyx *onyx = cii->codec_data;
 	u8 v;
+	int err = -ENXIO;
 
-	guard(mutex)(&onyx->mutex);
+	mutex_lock(&onyx->mutex);
 
 	/* reset codec */
 	onyx->codec.gpio->methods->set_hw_reset(onyx->codec.gpio, 0);
@@ -790,13 +826,17 @@ static int onyx_resume(struct codec_info_item *cii)
 
 	/* take codec out of suspend (if it still is after reset) */
 	if (onyx_read_register(onyx, ONYX_REG_CONTROL, &v))
-		return -ENXIO;
+		goto out_unlock;
 	onyx_write_register(onyx, ONYX_REG_CONTROL, v & ~(ONYX_ADPSV | ONYX_DAPSV));
 	/* FIXME: should divide by sample rate, but 8k is the lowest we go */
 	msleep(2205000/8000);
 	/* reset all values */
 	onyx_register_init(onyx);
-	return 0;
+	err = 0;
+ out_unlock:
+	mutex_unlock(&onyx->mutex);
+
+	return err;
 }
 
 #endif /* CONFIG_PM */
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index 04a6635f1eb1..d3e37577b529 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -236,9 +236,10 @@ static int tas_snd_vol_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->cached_volume_l;
 	ucontrol->value.integer.value[1] = tas->cached_volume_r;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -254,15 +255,18 @@ static int tas_snd_vol_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[1] > 177)
 		return -EINVAL;
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	if (tas->cached_volume_l == ucontrol->value.integer.value[0]
-	 && tas->cached_volume_r == ucontrol->value.integer.value[1])
+	 && tas->cached_volume_r == ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->cached_volume_l = ucontrol->value.integer.value[0];
 	tas->cached_volume_r = ucontrol->value.integer.value[1];
 	if (tas->hw_enabled)
 		tas_set_volume(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -282,9 +286,10 @@ static int tas_snd_mute_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = !tas->mute_l;
 	ucontrol->value.integer.value[1] = !tas->mute_r;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -293,15 +298,18 @@ static int tas_snd_mute_put(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	if (tas->mute_l == !ucontrol->value.integer.value[0]
-	 && tas->mute_r == !ucontrol->value.integer.value[1])
+	 && tas->mute_r == !ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->mute_l = !ucontrol->value.integer.value[0];
 	tas->mute_r = !ucontrol->value.integer.value[1];
 	if (tas->hw_enabled)
 		tas_set_volume(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -330,9 +338,10 @@ static int tas_snd_mixer_get(struct snd_kcontrol *kcontrol,
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->mixer_l[idx];
 	ucontrol->value.integer.value[1] = tas->mixer_r[idx];
+	mutex_unlock(&tas->mtx);
 
 	return 0;
 }
@@ -343,16 +352,19 @@ static int tas_snd_mixer_put(struct snd_kcontrol *kcontrol,
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 	int idx = kcontrol->private_value;
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	if (tas->mixer_l[idx] == ucontrol->value.integer.value[0]
-	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1])
+	 && tas->mixer_r[idx] == ucontrol->value.integer.value[1]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->mixer_l[idx] = ucontrol->value.integer.value[0];
 	tas->mixer_r[idx] = ucontrol->value.integer.value[1];
 
 	if (tas->hw_enabled)
 		tas_set_mixer(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -385,8 +397,9 @@ static int tas_snd_drc_range_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->drc_range;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -399,13 +412,16 @@ static int tas_snd_drc_range_put(struct snd_kcontrol *kcontrol,
 	    ucontrol->value.integer.value[0] > TAS3004_DRC_MAX)
 		return -EINVAL;
 
-	guard(mutex)(&tas->mtx);
-	if (tas->drc_range == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->drc_range == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->drc_range = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas3004_set_drc(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -425,8 +441,9 @@ static int tas_snd_drc_switch_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->drc_enabled;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -435,13 +452,16 @@ static int tas_snd_drc_switch_put(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
-	if (tas->drc_enabled == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->drc_enabled == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->drc_enabled = !!ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas3004_set_drc(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -467,8 +487,9 @@ static int tas_snd_capture_source_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.enumerated.item[0] = !!(tas->acr & TAS_ACR_INPUT_B);
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -480,7 +501,7 @@ static int tas_snd_capture_source_put(struct snd_kcontrol *kcontrol,
 
 	if (ucontrol->value.enumerated.item[0] > 1)
 		return -EINVAL;
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	oldacr = tas->acr;
 
 	/*
@@ -492,10 +513,13 @@ static int tas_snd_capture_source_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.enumerated.item[0])
 		tas->acr |= TAS_ACR_INPUT_B | TAS_ACR_B_MONAUREAL |
 		      TAS_ACR_B_MON_SEL_RIGHT;
-	if (oldacr == tas->acr)
+	if (oldacr == tas->acr) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 	if (tas->hw_enabled)
 		tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -534,8 +558,9 @@ static int tas_snd_treble_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->treble;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -547,13 +572,16 @@ static int tas_snd_treble_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < TAS3004_TREBLE_MIN ||
 	    ucontrol->value.integer.value[0] > TAS3004_TREBLE_MAX)
 		return -EINVAL;
-	guard(mutex)(&tas->mtx);
-	if (tas->treble == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->treble == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->treble = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas_set_treble(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -581,8 +609,9 @@ static int tas_snd_bass_get(struct snd_kcontrol *kcontrol,
 {
 	struct tas *tas = snd_kcontrol_chip(kcontrol);
 
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	ucontrol->value.integer.value[0] = tas->bass;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -594,13 +623,16 @@ static int tas_snd_bass_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] < TAS3004_BASS_MIN ||
 	    ucontrol->value.integer.value[0] > TAS3004_BASS_MAX)
 		return -EINVAL;
-	guard(mutex)(&tas->mtx);
-	if (tas->bass == ucontrol->value.integer.value[0])
+	mutex_lock(&tas->mtx);
+	if (tas->bass == ucontrol->value.integer.value[0]) {
+		mutex_unlock(&tas->mtx);
 		return 0;
+	}
 
 	tas->bass = ucontrol->value.integer.value[0];
 	if (tas->hw_enabled)
 		tas_set_bass(tas);
+	mutex_unlock(&tas->mtx);
 	return 1;
 }
 
@@ -691,13 +723,13 @@ static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock
 		break;
 	case CLOCK_SWITCH_SLAVE:
 		/* Clocks are back, re-init the codec */
-		scoped_guard(mutex, &tas->mtx) {
-			tas_reset_init(tas);
-			tas_set_volume(tas);
-			tas_set_mixer(tas);
-			tas->hw_enabled = 1;
-			tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
-		}
+		mutex_lock(&tas->mtx);
+		tas_reset_init(tas);
+		tas_set_volume(tas);
+		tas_set_mixer(tas);
+		tas->hw_enabled = 1;
+		tas->codec.gpio->methods->all_amps_restore(tas->codec.gpio);
+		mutex_unlock(&tas->mtx);
 		break;
 	default:
 		/* doesn't happen as of now */
@@ -712,21 +744,23 @@ static int tas_switch_clock(struct codec_info_item *cii, enum clock_switch clock
  * our i2c device is suspended, and then take note of that! */
 static int tas_suspend(struct tas *tas)
 {
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	tas->hw_enabled = 0;
 	tas->acr |= TAS_ACR_ANALOG_PDOWN;
 	tas_write_reg(tas, TAS_REG_ACR, 1, &tas->acr);
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
 static int tas_resume(struct tas *tas)
 {
 	/* reset codec */
-	guard(mutex)(&tas->mtx);
+	mutex_lock(&tas->mtx);
 	tas_reset_init(tas);
 	tas_set_volume(tas);
 	tas_set_mixer(tas);
 	tas->hw_enabled = 1;
+	mutex_unlock(&tas->mtx);
 	return 0;
 }
 
@@ -769,13 +803,14 @@ static int tas_init_codec(struct aoa_codec *codec)
 		return -EINVAL;
 	}
 
-	scoped_guard(mutex, &tas->mtx) {
-		if (tas_reset_init(tas)) {
-			printk(KERN_ERR PFX "tas failed to initialise\n");
-			return -ENXIO;
-		}
-		tas->hw_enabled = 1;
+	mutex_lock(&tas->mtx);
+	if (tas_reset_init(tas)) {
+		printk(KERN_ERR PFX "tas failed to initialise\n");
+		mutex_unlock(&tas->mtx);
+		return -ENXIO;
 	}
+	tas->hw_enabled = 1;
+	mutex_unlock(&tas->mtx);
 
 	if (tas->codec.soundbus_dev->attach_codec(tas->codec.soundbus_dev,
 						   aoa_get_card(),
diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 19ed0e6907da..39bb409b27f6 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -212,9 +212,10 @@ static void ftr_handle_notify(struct work_struct *work)
 	struct gpio_notification *notif =
 		container_of(work, struct gpio_notification, work.work);
 
-	guard(mutex)(&notif->mutex);
+	mutex_lock(&notif->mutex);
 	if (notif->notify)
 		notif->notify(notif->data);
+	mutex_unlock(&notif->mutex);
 }
 
 static void gpio_enable_dual_edge(int gpio)
@@ -340,17 +341,19 @@ static int ftr_set_notify(struct gpio_runtime *rt,
 	if (!irq)
 		return -ENODEV;
 
-	guard(mutex)(&notif->mutex);
+	mutex_lock(&notif->mutex);
 
 	old = notif->notify;
 
-	if (!old && !notify)
-		return 0;
+	if (!old && !notify) {
+		err = 0;
+		goto out_unlock;
+	}
 
 	if (old && notify) {
 		if (old == notify && notif->data == data)
 			err = 0;
-		return err;
+		goto out_unlock;
 	}
 
 	if (old && !notify)
@@ -359,13 +362,16 @@ static int ftr_set_notify(struct gpio_runtime *rt,
 	if (!old && notify) {
 		err = request_irq(irq, ftr_handle_notify_irq, 0, name, notif);
 		if (err)
-			return err;
+			goto out_unlock;
 	}
 
 	notif->notify = notify;
 	notif->data = data;
 
-	return 0;
+	err = 0;
+ out_unlock:
+	mutex_unlock(&notif->mutex);
+	return err;
 }
 
 static int ftr_get_detect(struct gpio_runtime *rt,
diff --git a/sound/aoa/core/gpio-pmf.c b/sound/aoa/core/gpio-pmf.c
index e76bde25e41a..37866039d1ea 100644
--- a/sound/aoa/core/gpio-pmf.c
+++ b/sound/aoa/core/gpio-pmf.c
@@ -74,9 +74,10 @@ static void pmf_handle_notify(struct work_struct *work)
 	struct gpio_notification *notif =
 		container_of(work, struct gpio_notification, work.work);
 
-	guard(mutex)(&notif->mutex);
+	mutex_lock(&notif->mutex);
 	if (notif->notify)
 		notif->notify(notif->data);
+	mutex_unlock(&notif->mutex);
 }
 
 static void pmf_gpio_init(struct gpio_runtime *rt)
@@ -153,17 +154,19 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 		return -EINVAL;
 	}
 
-	guard(mutex)(&notif->mutex);
+	mutex_lock(&notif->mutex);
 
 	old = notif->notify;
 
-	if (!old && !notify)
-		return 0;
+	if (!old && !notify) {
+		err = 0;
+		goto out_unlock;
+	}
 
 	if (old && notify) {
 		if (old == notify && notif->data == data)
 			err = 0;
-		return err;
+		goto out_unlock;
 	}
 
 	if (old && !notify) {
@@ -175,8 +178,10 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 	if (!old && notify) {
 		irq_client = kzalloc(sizeof(struct pmf_irq_client),
 				     GFP_KERNEL);
-		if (!irq_client)
-			return -ENOMEM;
+		if (!irq_client) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
 		irq_client->data = notif;
 		irq_client->handler = pmf_handle_notify_irq;
 		irq_client->owner = THIS_MODULE;
@@ -187,14 +192,17 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 			printk(KERN_ERR "snd-aoa: gpio layer failed to"
 					" register %s irq (%d)\n", name, err);
 			kfree(irq_client);
-			return err;
+			goto out_unlock;
 		}
 		notif->gpio_private = irq_client;
 	}
 	notif->notify = notify;
 	notif->data = data;
 
-	return 0;
+	err = 0;
+ out_unlock:
+	mutex_unlock(&notif->mutex);
+	return err;
 }
 
 static int pmf_get_detect(struct gpio_runtime *rt,
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index ffe2ffbd0e4f..99cb1acbfdb8 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -79,10 +79,11 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	u64 formats = 0;
 	unsigned int rates = 0;
 	struct transfer_info v;
+	int result = 0;
 	int bus_factor = 0, sysclock_factor = 0;
 	int found_this;
 
-	guard(mutex)(&i2sdev->lock);
+	mutex_lock(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, &other);
 
@@ -91,7 +92,8 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 
 	if (pi->active) {
 		/* alsa messed up */
-		return -EBUSY;
+		result = -EBUSY;
+		goto out_unlock;
 	}
 
 	/* we now need to assign the hw */
@@ -115,8 +117,10 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 			ti++;
 		}
 	}
-	if (!masks_inited || !bus_factor || !sysclock_factor)
-		return -ENODEV;
+	if (!masks_inited || !bus_factor || !sysclock_factor) {
+		result = -ENODEV;
+		goto out_unlock;
+	}
 	/* bus dependent stuff */
 	hw->info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		   SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_RESUME |
@@ -189,12 +193,15 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 	hw->periods_max = MAX_DBDMA_COMMANDS;
 	err = snd_pcm_hw_constraint_integer(pi->substream->runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
-	if (err < 0)
-		return err;
+	if (err < 0) {
+		result = err;
+		goto out_unlock;
+	}
 	list_for_each_entry(cii, &sdev->codec_list, list) {
 		if (cii->codec->open) {
 			err = cii->codec->open(cii, pi->substream);
 			if (err) {
+				result = err;
 				/* unwind */
 				found_this = 0;
 				list_for_each_entry_reverse(rev,
@@ -206,12 +213,14 @@ static int i2sbus_pcm_open(struct i2sbus_dev *i2sdev, int in)
 					if (rev == cii)
 						found_this = 1;
 				}
-				return err;
+				goto out_unlock;
 			}
 		}
 	}
 
-	return 0;
+ out_unlock:
+	mutex_unlock(&i2sdev->lock);
+	return result;
 }
 
 #undef CHECK_RATE
@@ -222,7 +231,7 @@ static int i2sbus_pcm_close(struct i2sbus_dev *i2sdev, int in)
 	struct pcm_info *pi;
 	int err = 0, tmp;
 
-	guard(mutex)(&i2sdev->lock);
+	mutex_lock(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, NULL);
 
@@ -236,6 +245,7 @@ static int i2sbus_pcm_close(struct i2sbus_dev *i2sdev, int in)
 
 	pi->substream = NULL;
 	pi->active = 0;
+	mutex_unlock(&i2sdev->lock);
 	return err;
 }
 
@@ -286,10 +296,10 @@ static void i2sbus_pcm_clear_active(struct i2sbus_dev *i2sdev, int in)
 {
 	struct pcm_info *pi;
 
-	guard(mutex)(&i2sdev->lock);
-
+	mutex_lock(&i2sdev->lock);
 	get_pcm_info(i2sdev, in, &pi, NULL);
 	pi->active = 0;
+	mutex_unlock(&i2sdev->lock);
 }
 
 static inline int i2sbus_hw_params(struct snd_pcm_substream *substream,
@@ -349,25 +359,32 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	int input_16bit;
 	struct pcm_info *pi, *other;
 	int cnt;
+	int result = 0;
 	unsigned int cmd, stopaddr;
 
-	guard(mutex)(&i2sdev->lock);
+	mutex_lock(&i2sdev->lock);
 
 	get_pcm_info(i2sdev, in, &pi, &other);
 
-	if (pi->dbdma_ring.running)
-		return -EBUSY;
+	if (pi->dbdma_ring.running) {
+		result = -EBUSY;
+		goto out_unlock;
+	}
 	if (pi->dbdma_ring.stopping)
 		i2sbus_wait_for_stop(i2sdev, pi);
 
-	if (!pi->substream || !pi->substream->runtime)
-		return -EINVAL;
+	if (!pi->substream || !pi->substream->runtime) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
 
 	runtime = pi->substream->runtime;
 	if (other->active &&
 	    ((i2sdev->format != runtime->format)
-	     || (i2sdev->rate != runtime->rate)))
-		return -EINVAL;
+	     || (i2sdev->rate != runtime->rate))) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
 
 	i2sdev->format = runtime->format;
 	i2sdev->rate = runtime->rate;
@@ -432,7 +449,8 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		input_16bit = 0;
 		break;
 	default:
-		return -EINVAL;
+		result = -EINVAL;
+		goto out_unlock;
 	}
 	/* we assume all sysclocks are the same! */
 	bi.sysclock_factor = cii->codec->sysclock_factor;
@@ -440,8 +458,10 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	if (clock_and_divisors(bi.sysclock_factor,
 			       bi.bus_factor,
 			       runtime->rate,
-			       &sfr) < 0)
-		return -EINVAL;
+			       &sfr) < 0) {
+		result = -EINVAL;
+		goto out_unlock;
+	}
 	switch (bi.bus_factor) {
 	case 32:
 		sfr |= I2S_SF_SERIAL_FORMAT_I2S_32X;
@@ -457,8 +477,10 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 		int err = 0;
 		if (cii->codec->prepare)
 			err = cii->codec->prepare(cii, &bi, pi->substream);
-		if (err)
-			return err;
+		if (err) {
+			result = err;
+			goto out_unlock;
+		}
 	}
 	/* codecs are fine with it, so set our clocks */
 	if (input_16bit)
@@ -475,7 +497,7 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 	if (in_le32(&i2sdev->intfregs->serial_format) == sfr &&
 	    in_le32(&i2sdev->intfregs->data_word_sizes) == dws) {
 		pi->active = 1;
-		return 0;
+		goto out_unlock;
 	}
 
 	/* let's notify the codecs about clocks going away.
@@ -515,7 +537,10 @@ static int i2sbus_pcm_prepare(struct i2sbus_dev *i2sdev, int in)
 			cii->codec->switch_clock(cii, CLOCK_SWITCH_SLAVE);
 
 	pi->active = 1;
-	return 0;
+
+ out_unlock:
+	mutex_unlock(&i2sdev->lock);
+	return result;
 }
 
 #ifdef CONFIG_PM
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4c6902c7bdff..e826557c45f3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4554,6 +4554,8 @@ static int bpf_core_parse_spec(const struct btf *btf,
 			++spec_str;
 		if (sscanf(spec_str, "%d%n", &access_idx, &parsed_len) != 1)
 			return -EINVAL;
+		if (access_idx < 0)
+			return -EINVAL;
 		if (spec->raw_len == BPF_CORE_SPEC_MAX_LEN)
 			return -E2BIG;
 		spec_str += parsed_len;
