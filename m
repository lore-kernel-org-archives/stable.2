Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522ED495030;
	Wed,  2 Sep 2026 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352904; cv=none; b=HCmoZ9QFbA12UojsrSgPn5Y9T37pqufhIreUkseEJ2X6J1shxtJ97lWge+CUXQRmqU55V33C55djc/mjWpR1S55ctRRPm2FuKhd8mM0KWBeBrfezoSRtqDim6LGW8g9wQwdCiQiW9zND/vcUPH5MqjRrqnkSKc10yYnwFEYEo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352904; c=relaxed/simple;
	bh=L2XOugFmehfCXXOVe5SF36+3dTj1nrqm0+6U3umaPdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJNbpkPE6Fk9UheCyRwdH0GaFJkYRXbcJ43oSeHjqmf546H3qKe27QJF4ywh0LpiITk979aXLE4II2hcsptpklC7BqEGpK9HUzJG28Jw+4vvtvzz1L16zqwfQ0xqs9UBjfftymWz/xpYqjA3fbnRCh64N1yy/QSAoWPg3WTRp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cYrUW4eJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cYrUW4eJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E8A1F000E9;
	Wed,  2 Sep 2026 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788352900;
	bh=4k095I+VW3ypszh85JRTbqS+tTNnfdtS59gtwhzbrLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cYrUW4eJMqQ6MawdTQYjXdMGA/qCcJl4OvMaktRyPL+F79x1xwwF7jSBABtMEoUez
	 paYMtz4AwlSMg1wgJqMhtXlnYSp1nBw20nG8OauFbLHEM+q0hPxoDJ+MKaduSHct8Z
	 VZdvek0FLJbkMxhhFwHOmh+KaT6ReDYiFxgeZTjc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.269
Date: Wed,  2 Sep 2026 14:41:26 +0200
Message-ID: <2026090226-justly-fool-e34f@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090226-cornbread-subsiding-eb84@gregkh>
References: <2026090226-cornbread-subsiding-eb84@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 936fae06db77..9fc429443d07 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1068,6 +1068,10 @@ astute users may notice some differences in behavior:
   give the length of the ciphertext, which will be slightly longer
   than the plaintext due to NUL-padding and an extra 2-byte overhead.
 
+- Encrypted files cannot be used directly as swap files.  To swap to
+  an encrypted file, set up a loopback device on top of it.
+  Alternatively, encrypted swap can use a dm-crypt device.
+
 - The maximum length of an encrypted symlink is 2 bytes shorter than
   the maximum length of an unencrypted symlink.  For example, on an
   EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
diff --git a/Makefile b/Makefile
index 0aadd120b6f6..60aa2a5e2c60 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 268
+SUBLEVEL = 269
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 309a925c2e7a..528229636c63 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1209,6 +1209,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_GET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
 		if (kvm_arm_vcpu_get_events(vcpu, &events))
 			return -EINVAL;
 
@@ -1220,6 +1223,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
 		if (copy_from_user(&events, argp, sizeof(events)))
 			return -EFAULT;
 
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 94071c4a54c4..d75bce83ddfa 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -144,6 +144,7 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
 	if (read_guest_real(vcpu, apcb_o, &tmp, sizeof(struct kvm_s390_apcb0)))
 		return -EFAULT;
 
+	memset(apcb_s, 0, sizeof(*apcb_s));
 	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
 	apcb_s->aqm[0] = apcb_h->aqm[0] & tmp.aqm[0] & 0xffff000000000000UL;
 	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 60c059c74fb6..2c664ef4c101 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -2432,6 +2432,7 @@ static int __init speakup_init(void)
 	mutex_lock(&spk_mutex);
 	synth_release();
 	mutex_unlock(&spk_mutex);
+	spk_ttyio_unregister_ldisc();
 	speakup_kobj_exit();
 
 error_kobjects:
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 24a7e280e300..964573e30d69 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -102,7 +102,7 @@ void device_pm_sleep_init(struct device *dev)
 	dev->power.is_noirq_suspended = false;
 	dev->power.is_late_suspended = false;
 	init_completion(&dev->power.completion);
-	complete(&dev->power.completion);
+	complete_all(&dev->power.completion);
 	dev->power.wakeup = NULL;
 	INIT_LIST_HEAD(&dev->power.entry);
 }
@@ -242,10 +242,6 @@ static void dpm_wait(struct device *dev, bool async)
 	if (!dev)
 		return;
 
-	/* Devices with no PM support don't use the completion. */
-	if (dev->power.no_pm)
-		return;
-
 	if (async || (pm_async_enabled && dev->power.async_suspend))
 		wait_for_completion(&dev->power.completion);
 }
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 6745562aebda..f1d7097cf72d 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -509,14 +509,13 @@ static int atmel_tdes_crypt_start(struct atmel_tdes_dev *dd)
 			IS_ALIGNED(dd->out_sg->length, dd->ctx->block_size);
 		fast = in && out;
 
-		if (sg_dma_len(dd->in_sg) != sg_dma_len(dd->out_sg))
+		if (dd->in_sg->length != dd->out_sg->length)
 			fast = 0;
 	}
 
 
 	if (fast)  {
-		count = min_t(size_t, dd->total, sg_dma_len(dd->in_sg));
-		count = min_t(size_t, count, sg_dma_len(dd->out_sg));
+		count = min_t(size_t, dd->total, dd->in_sg->length);
 
 		err = dma_map_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
 		if (!err) {
diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index a9d3e675f7ff..5867fb3e6723 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -332,7 +332,7 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 
 	for_each_sg(req->src, src, sg_nents(req->src), i) {
 		src_buf = sg_virt(src);
-		len = sg_dma_len(src);
+		len = src->length;
 		tlen += len;
 		limit_hit = tlen > req->cryptlen;
 
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 329b03244fd2..c7fecd63736c 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 				PERF_PMU_CAP_NO_EXCLUDE;
 
 	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
+	if (!name)
+		return -ENOMEM;
 
 	ret = perf_pmu_register(pmu, name, -1);
 	if (ret)
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 1c41a6297d3b..8a48efe132d2 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -358,19 +358,27 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
 {
 	u8 *buf;
 	int ret;
+	/*
+	 * The capacity field may not be the first field in the report: some
+	 * devices (e.g. the Apple Magic Trackpad 2 over Bluetooth) precede it
+	 * with status flags. Read it from its actual byte offset in the report
+	 * (report_offset is in bits; the leading byte is the report id).
+	 */
+	int offset = 1 + dev->battery_report_offset / 8;
+	int len = offset + 1;
 
-	buf = kmalloc(4, GFP_KERNEL);
+	buf = kmalloc(max(len, 4), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
+	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, max(len, 4),
 				 dev->battery_report_type, HID_REQ_GET_REPORT);
-	if (ret < 2) {
+	if (ret < len) {
 		kfree(buf);
 		return -ENODATA;
 	}
 
-	ret = hidinput_scale_battery_capacity(dev, buf[1]);
+	ret = hidinput_scale_battery_capacity(dev, buf[offset]);
 	kfree(buf);
 	return ret;
 }
@@ -487,6 +495,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_max = max;
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
+	dev->battery_report_offset = field->report_offset;
 
 	/*
 	 * Stylus is normally not connected to the device and thus we
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 13bb9e040d33..b3f8d8b878a5 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -643,6 +643,16 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
+	/*
+	 * When hidinput_connect() fails it frees every input device it
+	 * created, but that does not fail hid_hw_start(): the core simply
+	 * does not claim an input. msc->input, cached in ->input_mapping
+	 * while the report descriptor was parsed, would then be a dangling
+	 * pointer that passes every NULL check. Trust the core's claim.
+	 */
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		msc->input = NULL;
+
 	if (!msc->input) {
 		hid_err(hdev, "magicmouse input not registered\n");
 		ret = -ENOMEM;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 4c938d841f76..f4f55b23f0c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -580,10 +580,9 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		int max_dest_rd_atomic = attr->max_dest_rd_atomic ?
 			roundup_pow_of_two(attr->max_dest_rd_atomic) : 0;
 
-		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
-
 		free_rd_atomic_resources(qp);
 
+		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
 		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
 		if (err)
 			return err;
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index ad10f7887dfa..f96a165fccc7 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -610,7 +610,7 @@ static int vmu_connect(struct maple_device *mdev)
 
 	basic_flash_data = be32_to_cpu(mdev->devinfo.function_data[c - 1]);
 
-	card = kzalloc_obj(struct memcard);
+	card = kmalloc(sizeof(struct memcard), GFP_KERNEL);
 	if (!card) {
 		error = -ENOMEM;
 		goto fail_nomem;
@@ -628,13 +628,15 @@ static int vmu_connect(struct maple_device *mdev)
 	* Not sure there are actually any multi-partition devices in the
 	* real world, but the hardware supports them, so, so will we
 	*/
-	card->parts = kzalloc_objs(struct vmupart, card->partitions);
+	card->parts = kmalloc_array(card->partitions, sizeof(struct vmupart),
+				    GFP_KERNEL);
 	if (!card->parts) {
 		error = -ENOMEM;
 		goto fail_partitions;
 	}
 
-	card->mtd = kzalloc_objs(struct mtd_info, card->partitions);
+	card->mtd = kmalloc_array(card->partitions, sizeof(struct mtd_info),
+				  GFP_KERNEL);
 	if (!card->mtd) {
 		error = -ENOMEM;
 		goto fail_mtd_info;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 425381eff72a..1045573c0a40 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -382,6 +382,19 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	if (!len)
 		return 0;
 
+	/*
+	 * inline_data_size only bounds the in-capsule (type 0x01) SGL
+	 * descriptor below. A non-inline transport SGL data-block
+	 * descriptor skips that check entirely and would otherwise reach
+	 * sgl_alloc() with an attacker-controlled len of up to 4 GiB,
+	 * pinning that much kernel memory for a command that may never
+	 * complete. Bound every descriptor type here, before allocating
+	 * anything, using the same ceiling this file already applies to
+	 * per-PDU H2C data.
+	 */
+	if (len > NVMET_TCP_MAXH2CDATA)
+		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+
 	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
 			  NVME_SGL_FMT_OFFSET)) {
 		if (!nvme_is_write(cmd->req.cmd))
diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
index ee85602213f7..11fc66724f8c 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -689,6 +689,14 @@ static void target_fabric_port_unlink(
 	}
 
 	core_dev_del_lun(se_tpg, lun);
+
+	if (tf->tf_ops->fabric_post_unlink) {
+		/*
+		 * Allow fabrics to release state that must remain valid until
+		 * core_dev_del_lun() has drained all active LUN references.
+		 */
+		tf->tf_ops->fabric_post_unlink(se_tpg, lun);
+	}
 }
 
 static void target_fabric_port_release(struct config_item *item)
diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index e65f1a0ae80b..899650028829 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -761,13 +761,13 @@ static int c67x00_add_iso_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 				ret);
 			urb->iso_frame_desc[urbp->cnt].actual_length = 0;
 			urb->iso_frame_desc[urbp->cnt].status = ret;
-			if (urbp->cnt + 1 == urb->number_of_packets)
-				c67x00_giveback_urb(c67x00, urb, 0);
 		}
 
 		urbp->ep_data->next_frame =
 		    frame_add(urbp->ep_data->next_frame, urb->interval);
 		urbp->cnt++;
+		if (ret && urbp->cnt == urb->number_of_packets)
+			c67x00_giveback_urb(c67x00, urb, 0);
 	}
 	return 0;
 }
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 1b95035d179f..ecf0d4020e84 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1098,7 +1098,6 @@ static int usbdev_release(struct inode *inode, struct file *file)
 	if (!ps->suspend_allowed)
 		usb_autosuspend_device(dev);
 	usb_unlock_device(dev);
-	usb_put_dev(dev);
 	put_pid(ps->disc_pid);
 	put_cred(ps->cred);
 
@@ -1107,6 +1106,7 @@ static int usbdev_release(struct inode *inode, struct file *file)
 		free_async(as);
 		as = async_getcompleted(ps);
 	}
+	usb_put_dev(dev);
 
 	kfree(ps);
 	return 0;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 667ab60a18db..ef699092b610 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -714,10 +714,12 @@ void usb_wakeup_notification(struct usb_device *hdev,
 {
 	struct usb_hub *hub;
 	struct usb_port *port_dev;
+	unsigned long flags;
 
 	if (!hdev)
 		return;
 
+	spin_lock_irqsave(&device_state_lock, flags);
 	hub = usb_hub_to_struct_hub(hdev);
 	if (hub) {
 		port_dev = hub->ports[portnum - 1];
@@ -727,6 +729,7 @@ void usb_wakeup_notification(struct usb_device *hdev,
 		set_bit(portnum, hub->wakeup_bits);
 		kick_hub_wq(hub);
 	}
+	spin_unlock_irqrestore(&device_state_lock, flags);
 }
 EXPORT_SYMBOL_GPL(usb_wakeup_notification);
 
@@ -952,10 +955,12 @@ static int hub_hub_status(struct usb_hub *hub,
 
 	mutex_lock(&hub->status_mutex);
 	ret = get_hub_status(hub->hdev, &hub->status->hub);
-	if (ret < 0) {
+	if (ret < (int)sizeof(hub->status->hub)) {
 		if (ret != -ENODEV)
 			dev_err(hub->intfdev,
 				"%s failed (err = %d)\n", __func__, ret);
+		if (ret >= 0)
+			ret = -EIO;
 	} else {
 		*status = le16_to_cpu(hub->status->hub.wHubStatus);
 		*change = le16_to_cpu(hub->status->hub.wHubChange);
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 0db98fc40b15..7e6e397f077c 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1732,7 +1732,7 @@ static const struct target_core_fabric_ops usbg_ops = {
 	.fabric_make_tpg		= usbg_make_tpg,
 	.fabric_drop_tpg		= usbg_drop_tpg,
 	.fabric_post_link		= usbg_port_link,
-	.fabric_pre_unlink		= usbg_port_unlink,
+	.fabric_post_unlink		= usbg_port_unlink,
 	.fabric_init_nodeacl		= usbg_init_nodeacl,
 
 	.tfc_wwn_attrs			= usbg_wwn_attrs,
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 150090ee4ec1..1b3e4718cfca 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -3053,6 +3053,7 @@ static struct usb_driver usbtest_driver = {
 	.disconnect =	usbtest_disconnect,
 	.suspend =	usbtest_suspend,
 	.resume =	usbtest_resume,
+	.no_dynamic_id = 1,
 };
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index b924504dbdb3..6a94785f86ad 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2693,12 +2693,26 @@ static void option_instat_callback(struct urb *urb)
 			dev_dbg(dev, "%s: NULL req_pkt\n", __func__);
 			return;
 		}
+
+		if (urb->actual_length < sizeof(*req_pkt)) {
+			dev_err(dev, "%s: short packet: %u bytes\n", __func__,
+				urb->actual_length);
+			return;
+		}
+
 		if ((req_pkt->bRequestType == 0xA1) &&
 				(req_pkt->bRequest == 0x20)) {
+			unsigned char signals;
 			int old_dcd_state;
-			unsigned char signals = *((unsigned char *)
-					urb->transfer_buffer +
-					sizeof(struct usb_ctrlrequest));
+
+			if (urb->actual_length < sizeof(*req_pkt) + 1) {
+				dev_err(dev, "%s: short interrupt transfer: %u bytes\n",
+					__func__, urb->actual_length);
+				return;
+			}
+
+			signals = *((unsigned char *)urb->transfer_buffer +
+					sizeof(*req_pkt));
 
 			dev_dbg(dev, "%s: signal x%x\n", __func__, signals);
 
diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index 3bac55bd9bd9..477d12cd5360 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -249,18 +249,6 @@ static void spcp8x5_set_work_mode(struct usb_serial_port *port, u16 value,
 		dev_err(&port->dev, "failed to set work mode: %d\n", ret);
 }
 
-static int spcp8x5_carrier_raised(struct usb_serial_port *port)
-{
-	u8 msr;
-	int ret;
-
-	ret = spcp8x5_get_msr(port, &msr);
-	if (ret || msr & MSR_STATUS_LINE_DCD)
-		return 1;
-
-	return 0;
-}
-
 static void spcp8x5_dtr_rts(struct usb_serial_port *port, int on)
 {
 	struct spcp8x5_private *priv = usb_get_serial_port_data(port);
@@ -472,7 +460,6 @@ static struct usb_serial_driver spcp8x5_device = {
 	.num_bulk_out		= 1,
 	.open			= spcp8x5_open,
 	.dtr_rts		= spcp8x5_dtr_rts,
-	.carrier_raised		= spcp8x5_carrier_raised,
 	.set_termios		= spcp8x5_set_termios,
 	.init_termios		= spcp8x5_init_termios,
 	.tiocmget		= spcp8x5_tiocmget,
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index a520e90adf3e..51f8ea0c8906 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3568,7 +3568,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	if (rc)
 		goto out;
 
-	buf = kvzalloc(1024 * 1024, GFP_KERNEL);
+	buf = kzalloc(1024 * 1024, GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
 		goto out;
@@ -3635,7 +3635,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 
  out:
 	kfree(out_data);
-	kvfree(buf);
+	kfree(buf);
 	return rc;
 }
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 26b7782b03f4..4f73f0ad6c85 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1678,8 +1678,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, NULL, 0);
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
 				goto out;
+			}
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
@@ -1741,9 +1743,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	}
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 /* Replay DEL_RANGE tag */
@@ -1804,9 +1807,10 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 static inline const char *tag2str(u16 tag)
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 98bd01483afb..cb69fb7b7b82 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -994,6 +994,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 		err = fscrypt_prepare_new_inode(dir, inode, &encrypt);
 		if (err)
 			goto out;
+		if (encrypt)
+			i_flags |= EXT4_ENCRYPT_FL;
 	}
 
 	err = dquot_initialize(inode);
@@ -1307,6 +1309,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	ei->i_extra_isize = sbi->s_want_extra_isize;
 	ei->i_inline_off = 0;
 	if (ext4_has_feature_inline_data(sb) &&
+	    /* Encrypted inodes cannot have inline data */
+	    !(ei->i_flags & EXT4_ENCRYPT_FL) &&
 	    (!(ei->i_flags & EXT4_DAX_FL) || S_ISDIR(mode)))
 		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	ret = inode;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c698dd5816c3..c1538e61022c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1494,7 +1494,13 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	if (inode->i_ino == EXT4_ROOT_INO)
 		return -EPERM;
 
-	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
+	/*
+	 * For new encrypted inodes, S_DAX is never set in the first place.
+	 *
+	 * For existing inodes, this is called only on empty directories.  ext4
+	 * never sets S_DAX on directories.
+	 */
+	if (WARN_ON_ONCE(IS_DAX(inode)))
 		return -EINVAL;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX))
@@ -1513,21 +1519,18 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	 */
 
 	if (handle) {
-		res = ext4_xattr_set_handle(handle, inode,
-					    EXT4_XATTR_INDEX_ENCRYPTION,
-					    EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
-					    ctx, len, 0);
-		if (!res) {
-			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-			ext4_clear_inode_state(inode,
-					EXT4_STATE_MAY_INLINE_DATA);
-			/*
-			 * Update inode->i_flags - S_ENCRYPTED will be enabled,
-			 * S_DAX may be disabled
-			 */
-			ext4_set_inode_flags(inode, false);
-		}
-		return res;
+		/*
+		 * __ext4_new_inode() should have already set the encrypt flag
+		 * on the inode and avoided enabling inline data.
+		 */
+		if (WARN_ON_ONCE(!IS_ENCRYPTED(inode)))
+			return -EINVAL;
+		if (WARN_ON_ONCE(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)))
+			return -EINVAL;
+		return ext4_xattr_set_handle(handle, inode,
+					     EXT4_XATTR_INDEX_ENCRYPTION,
+					     EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
+					     ctx, len, 0);
 	}
 
 	res = dquot_initialize(inode);
@@ -1548,10 +1551,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 				    ctx, len, 0);
 	if (!res) {
 		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-		/*
-		 * Update inode->i_flags - S_ENCRYPTED will be enabled,
-		 * S_DAX may be disabled
-		 */
+		/* Update inode->i_flags to set S_ENCRYPTED. */
 		ext4_set_inode_flags(inode, false);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 01f55fac31cf..4066d263e9e1 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -385,7 +385,7 @@ void jfs_truncate_nolock(struct inode *ip, loff_t length)
 
 	ASSERT(length >= 0);
 
-	if (test_cflag(COMMIT_Nolink, ip)) {
+	if (test_cflag(COMMIT_Nolink, ip) || isReadOnly(ip)) {
 		xtTruncate(0, ip, length, COMMIT_WMAP);
 		return;
 	}
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index d4e063dbb9a0..d695157df567 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -77,6 +77,11 @@ extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, bool abnr)
 	int rc;
 	int xflag;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EIO;
+	}
+
 	/* This blocks if we are low on resources */
 	txBeginAnon(ip->i_sb);
 
@@ -412,6 +417,11 @@ int extRecord(struct inode *ip, xad_t * xp)
 {
 	int rc;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EIO;
+	}
+
 	txBeginAnon(ip->i_sb);
 
 	mutex_lock(&JFS_IP(ip)->commit_mutex);
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index e56e87192741..9f10a9cec3e0 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -544,6 +544,8 @@ static int nilfs_ioctl_get_bdescs(struct inode *inode, struct file *filp,
  * Return Value: On success, 0 is returned. On error, one of the following
  * negative error codes is returned.
  *
+ * %-EINVAL - Invalid virtual block descriptor.
+ *
  * %-EIO - I/O error.
  *
  * %-ENOMEM - Insufficient amount of memory available.
@@ -557,15 +559,30 @@ static int nilfs_ioctl_move_inode_block(struct inode *inode,
 					struct list_head *buffers)
 {
 	struct buffer_head *bh;
+	__u64 limit_blkidx = (__u64)inode->i_sb->s_maxbytes >> inode->i_blkbits;
 	int ret;
 
-	if (vdesc->vd_flags == 0)
+	/*
+	 * vblocknr 0 is reserved as an invalid pointer.  Also, limit_blkidx
+	 * ensures that the page index converted from vd_vblocknr never
+	 * overflows the page cache limit and respects the architecture's bmap
+	 * key width.
+	 */
+	if (unlikely(vdesc->vd_vblocknr == 0 ||
+			vdesc->vd_vblocknr >= limit_blkidx))
+		return -EINVAL;
+
+	if (vdesc->vd_flags == 0) {
+		if (unlikely(vdesc->vd_offset >= limit_blkidx))
+			return -EINVAL;
+
 		ret = nilfs_gccache_submit_read_data(
 			inode, vdesc->vd_offset, vdesc->vd_blocknr,
 			vdesc->vd_vblocknr, &bh);
-	else
+	} else {
 		ret = nilfs_gccache_submit_read_node(
 			inode, vdesc->vd_blocknr, vdesc->vd_vblocknr, &bh);
+	}
 
 	if (unlikely(ret < 0)) {
 		if (ret == -ENOENT)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8a105caf6bcb..68fec22033a5 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -616,6 +616,7 @@ struct hid_device {							/* device report descriptor */
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
+	__s32 battery_report_offset;					/* bit offset of the capacity field within its report */
 	enum hid_battery_status battery_status;
 	bool battery_avoid_query;
 #endif
diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index 3088d94684c1..6174930ae654 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -277,6 +277,11 @@ static inline void in_dev_put(struct in_device *idev)
 #define __in_dev_put(idev)  refcount_dec(&(idev)->refcnt)
 #define in_dev_hold(idev)   refcount_inc(&(idev)->refcnt)
 
+static inline bool in_dev_hold_safe(struct in_device *idev)
+{
+	return refcount_inc_not_zero(&idev->refcnt);
+}
+
 #endif /* __KERNEL__ */
 
 static __inline__ __be32 inet_make_mask(int logmask)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 540431e31681..1c5bd595f560 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1295,6 +1295,14 @@ struct task_struct {
 
 	/* Collect coverage from softirq context: */
 	unsigned int			kcov_softirq;
+
+	/* Temporary storage for preempting remote coverage collection: */
+	unsigned int			kcov_saved_mode;
+	unsigned int			kcov_saved_size;
+	void				*kcov_saved_area;
+	struct kcov			*kcov_saved_kcov;
+	int				kcov_saved_sequence;
+
 #endif
 
 #ifdef CONFIG_MEMCG
diff --git a/include/target/target_core_fabric.h b/include/target/target_core_fabric.h
index 6adf4d71acf6..8a490a0b2b66 100644
--- a/include/target/target_core_fabric.h
+++ b/include/target/target_core_fabric.h
@@ -94,6 +94,8 @@ struct target_core_fabric_ops {
 				struct se_lun *);
 	void (*fabric_pre_unlink)(struct se_portal_group *,
 				struct se_lun *);
+	void (*fabric_post_unlink)(struct se_portal_group *se_tpg,
+				   struct se_lun *lun);
 	struct se_tpg_np *(*fabric_make_np)(struct se_portal_group *,
 				struct config_group *, const char *);
 	void (*fabric_drop_np)(struct se_tpg_np *);
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index edcb5af514b5..f57743d911b4 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -195,9 +195,12 @@ static void io_worker_cancel_cb(struct io_worker *worker)
 	struct io_wq *wq = wqe->wq;
 
 	atomic_dec(&acct->nr_running);
-	raw_spin_lock(&worker->wqe->lock);
-	acct->nr_workers--;
-	raw_spin_unlock(&worker->wqe->lock);
+	/* create_worker_cb() has not reserved a worker slot yet. */
+	if (worker->create_work.func != create_worker_cb) {
+		raw_spin_lock(&worker->wqe->lock);
+		acct->nr_workers--;
+		raw_spin_unlock(&worker->wqe->lock);
+	}
 	io_worker_ref_put(wq);
 	clear_bit_unlock(0, &worker->create_state);
 	io_worker_release(worker);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index bd09290e3648..bfd2ce673369 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -277,9 +277,8 @@ static struct ns_common *bpf_prog_offload_info_fill_ns(void *private_data)
 
 	if (aux->offload) {
 		args->info->ifindex = aux->offload->netdev->ifindex;
-		net = dev_net(aux->offload->netdev);
-		get_net(net);
-		ns = &net->ns;
+		net = maybe_get_net(dev_net(aux->offload->netdev));
+		ns = net ? &net->ns : NULL;
 	} else {
 		args->info->ifindex = 0;
 		ns = NULL;
@@ -504,9 +503,8 @@ static struct ns_common *bpf_map_offload_info_fill_ns(void *private_data)
 
 	if (args->offmap->netdev) {
 		args->info->ifindex = args->offmap->netdev->ifindex;
-		net = dev_net(args->offmap->netdev);
-		get_net(net);
-		ns = &net->ns;
+		net = maybe_get_net(dev_net(args->offmap->netdev));
+		ns = net ? &net->ns : NULL;
 	} else {
 		args->info->ifindex = 0;
 		ns = NULL;
diff --git a/kernel/kcov.c b/kernel/kcov.c
index ec2fd698ebf5..5fad12c0745a 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -84,20 +84,10 @@ struct kcov_remote {
 
 static DEFINE_SPINLOCK(kcov_remote_lock);
 static DEFINE_HASHTABLE(kcov_remote_map, 4);
-static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
-
-struct kcov_percpu_data {
-	void			*irq_area;
-
-	unsigned int		saved_mode;
-	unsigned int		saved_size;
-	void			*saved_area;
-	struct kcov		*saved_kcov;
-	int			saved_sequence;
+static struct list_head kcov_remote_areas[2] = {
+	LIST_HEAD_INIT(kcov_remote_areas[0]), LIST_HEAD_INIT(kcov_remote_areas[1])
 };
 
-static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
-
 /* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_find(u64 handle)
 {
@@ -127,12 +117,13 @@ static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
 }
 
 /* Must be called with kcov_remote_lock locked. */
-static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
+static struct kcov_remote_area *kcov_remote_area_get(unsigned int size, bool irq)
 {
 	struct kcov_remote_area *area;
 	struct list_head *pos;
+	struct list_head *list = &kcov_remote_areas[irq];
 
-	list_for_each(pos, &kcov_remote_areas) {
+	list_for_each(pos, list) {
 		area = list_entry(pos, struct kcov_remote_area, list);
 		if (area->size == size) {
 			list_del(&area->list);
@@ -144,11 +135,11 @@ static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 
 /* Must be called with kcov_remote_lock locked. */
 static void kcov_remote_area_put(struct kcov_remote_area *area,
-					unsigned int size)
+				 unsigned int size, bool irq)
 {
 	INIT_LIST_HEAD(&area->list);
 	area->size = size;
-	list_add(&area->list, &kcov_remote_areas);
+	list_add(&area->list, &kcov_remote_areas[irq]);
 }
 
 static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
@@ -357,6 +348,12 @@ void kcov_task_init(struct task_struct *t)
 {
 	kcov_task_reset(t);
 	t->kcov_handle = current->kcov_handle;
+	t->kcov_softirq = 0;
+	t->kcov_saved_mode = 0;
+	t->kcov_saved_size = 0;
+	t->kcov_saved_area = NULL;
+	t->kcov_saved_kcov = NULL;
+	t->kcov_saved_sequence = 0;
 }
 
 static void kcov_reset(struct kcov *kcov)
@@ -778,34 +775,31 @@ static inline bool kcov_mode_enabled(unsigned int mode)
 
 static void kcov_remote_softirq_start(struct task_struct *t)
 {
-	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
 	unsigned int mode;
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
 	if (kcov_mode_enabled(mode)) {
-		data->saved_mode = mode;
-		data->saved_size = t->kcov_size;
-		data->saved_area = t->kcov_area;
-		data->saved_sequence = t->kcov_sequence;
-		data->saved_kcov = t->kcov;
+		t->kcov_saved_mode = mode;
+		t->kcov_saved_size = t->kcov_size;
+		t->kcov_saved_area = t->kcov_area;
+		t->kcov_saved_sequence = t->kcov_sequence;
+		t->kcov_saved_kcov = t->kcov;
 		kcov_stop(t);
 	}
 }
 
 static void kcov_remote_softirq_stop(struct task_struct *t)
 {
-	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
-
-	if (data->saved_kcov) {
-		kcov_start(t, data->saved_kcov, data->saved_size,
-				data->saved_area, data->saved_mode,
-				data->saved_sequence);
-		data->saved_mode = 0;
-		data->saved_size = 0;
-		data->saved_area = NULL;
-		data->saved_sequence = 0;
-		data->saved_kcov = NULL;
+	if (t->kcov_saved_kcov) {
+		kcov_start(t, t->kcov_saved_kcov, t->kcov_saved_size,
+			   t->kcov_saved_area, t->kcov_saved_mode,
+			   t->kcov_saved_sequence);
+		t->kcov_saved_mode = 0;
+		t->kcov_saved_size = 0;
+		t->kcov_saved_area = NULL;
+		t->kcov_saved_sequence = 0;
+		t->kcov_saved_kcov = NULL;
 	}
 }
 
@@ -865,16 +859,16 @@ void kcov_remote_start(u64 handle)
 	sequence = kcov->sequence;
 	if (in_task()) {
 		size = kcov->remote_size;
-		area = kcov_remote_area_get(size);
+		area = kcov_remote_area_get(size, false);
 	} else {
 		size = CONFIG_KCOV_IRQ_AREA_SIZE;
-		area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
+		area = kcov_remote_area_get(size, true);
 	}
 	spin_unlock_irqrestore(&kcov_remote_lock, flags);
 
-	/* Can only happen when in_task(). */
+	/* Allocate new buffer if we can sleep. */
 	if (!area) {
-		area = vmalloc(size * sizeof(unsigned long));
+		area = in_task() ? vmalloc(size * sizeof(unsigned long)) : NULL;
 		if (!area) {
 			kcov_put(kcov);
 			return;
@@ -1008,11 +1002,9 @@ void kcov_remote_stop(void)
 		kcov_move_area(kcov->mode, kcov->area, kcov->size, area);
 	spin_unlock(&kcov->lock);
 
-	if (in_task()) {
-		spin_lock(&kcov_remote_lock);
-		kcov_remote_area_put(area, size);
-		spin_unlock(&kcov_remote_lock);
-	}
+	spin_lock(&kcov_remote_lock);
+	kcov_remote_area_put(area, size, !in_task());
+	spin_unlock(&kcov_remote_lock);
 
 	local_irq_restore(flags);
 
@@ -1030,14 +1022,21 @@ EXPORT_SYMBOL(kcov_common_handle);
 
 static int __init kcov_init(void)
 {
-	int cpu;
+	int cpu = num_possible_cpus();
+
+#ifdef CONFIG_PREEMPT_RT
+	/* Allocate some extra buffers in order to prepare for softirq preemption. */
+	cpu = cpu >= 4 ? cpu * 2 : cpu + 4;
+#endif
+	while (cpu--) {
+		void *area = vmalloc(CONFIG_KCOV_IRQ_AREA_SIZE * sizeof(unsigned long));
+		unsigned long flags;
 
-	for_each_possible_cpu(cpu) {
-		void *area = vmalloc(CONFIG_KCOV_IRQ_AREA_SIZE *
-				sizeof(unsigned long));
 		if (!area)
 			return -ENOMEM;
-		per_cpu_ptr(&kcov_percpu_data, cpu)->irq_area = area;
+		spin_lock_irqsave(&kcov_remote_lock, flags);
+		kcov_remote_area_put(area, CONFIG_KCOV_IRQ_AREA_SIZE, true);
+		spin_unlock_irqrestore(&kcov_remote_lock, flags);
 	}
 
 	/*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c20729cd67b1..ee630c7fcd64 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1952,10 +1952,11 @@ config KCOV_INSTRUMENT_ALL
 config KCOV_IRQ_AREA_SIZE
 	hex "Size of interrupt coverage collection area in words"
 	depends on KCOV
+	range 0x80 0x1000000
 	default 0x40000
 	help
-	  KCOV uses preallocated per-cpu areas to collect coverage from
-	  soft interrupts. This specifies the size of those areas in the
+	  KCOV uses preallocated areas to collect coverage from soft
+	  interrupts. This specifies the size of those areas in the
 	  number of unsigned long words.
 
 menuconfig RUNTIME_TESTING_MENU
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 914f599fb49f..9c32c0055cbb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3234,6 +3234,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		error = -EBUSY;
 		goto bad_swap_unlock_inode;
 	}
+	if (IS_ENCRYPTED(inode)) {
+		pr_warn_once(
+			"Filesystem-level encrypted swapfile '%s' is unsupported. Create a loop device over it, or use dm-crypt\n",
+			name->name);
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
 
 	/*
 	 * Read the swap header.
diff --git a/net/core/filter.c b/net/core/filter.c
index 18d8094d8759..8ec5b4d868ab 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9920,7 +9920,6 @@ const struct bpf_verifier_ops lwt_seg6local_verifier_ops = {
 };
 
 const struct bpf_prog_ops lwt_seg6local_prog_ops = {
-	.test_run		= bpf_prog_test_run_skb,
 };
 
 const struct bpf_verifier_ops cg_sock_verifier_ops = {
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index d2ea0d8e7a2f..5d87e912e1f2 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -232,16 +232,20 @@ static void igmp_gq_start_timer(struct in_device *in_dev)
 		return;
 
 	in_dev->mr_gq_running = 1;
-	if (!mod_timer(&in_dev->mr_gq_timer, exp))
-		in_dev_hold(in_dev);
+	if (in_dev_hold_safe(in_dev)) {
+		if (mod_timer(&in_dev->mr_gq_timer, exp))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
 {
-	int tv = prandom_u32() % delay;
+	if (in_dev_hold_safe(in_dev)) {
+		int tv = prandom_u32() % delay;
 
-	if (!mod_timer(&in_dev->mr_ifc_timer, jiffies+tv+2))
-		in_dev_hold(in_dev);
+		if (mod_timer(&in_dev->mr_ifc_timer, jiffies + tv + 2))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index aa34a07271c8..ac7f4001b24f 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -238,26 +238,28 @@ static void ipv6_rearrange_destopt(struct ipv6hdr *iph, struct ipv6_opt_hdr *des
  *	Rearrange the destination address in @iph and the addresses in @rthdr
  *	so that they appear in the order they will at the final destination.
  *	See Appendix A2 of RFC 2402 for details.
+ *
+ * Return: 0 on success, -EINVAL if segments_left exceeds the number of
+ * addresses described by hdrlen.
  */
-static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
+static int ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
 {
-	int segments, segments_left;
+	unsigned int segments, segments_left;
 	struct in6_addr *addrs;
 	struct in6_addr final_addr;
 
 	segments_left = rthdr->segments_left;
 	if (segments_left == 0)
-		return;
-	rthdr->segments_left = 0;
+		return 0;
 
-	/* The value of rthdr->hdrlen has been verified either by the system
-	 * call if it is locally generated, or by ipv6_rthdr_rcv() for incoming
-	 * packets.  So we can assume that it is even and that segments is
-	 * greater than or equal to segments_left.
-	 *
-	 * For the same reason we can assume that this option is of type 0.
+	/* Raw locally generated packets can reach AH6 without the invariant
+	 * required by the rt0-style address rearrangement below.
 	 */
 	segments = rthdr->hdrlen >> 1;
+	if (segments_left > segments)
+		return -EINVAL;
+
+	rthdr->segments_left = 0;
 
 	addrs = ((struct rt0_hdr *)rthdr)->addr;
 	final_addr = addrs[segments - 1];
@@ -267,6 +269,8 @@ static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
 
 	addrs[0] = iph->daddr;
 	iph->daddr = final_addr;
+
+	return 0;
 }
 
 static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
@@ -279,6 +283,7 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
 	} exthdr = { .iph = iph };
 	char *end = exthdr.raw + len;
 	int nexthdr = iph->nexthdr;
+	int err;
 
 	exthdr.iph++;
 
@@ -298,7 +303,9 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
 			break;
 
 		case NEXTHDR_ROUTING:
-			ipv6_rearrange_rthdr(iph, exthdr.rth);
+			err = ipv6_rearrange_rthdr(iph, exthdr.rth);
+			if (err)
+				return err;
 			break;
 
 		default:
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index e15c3e2318d7..c4a9866ea45b 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1414,9 +1414,9 @@ void igmp6_event_query(struct sk_buff *skb)
 static void __mld_query_work(struct sk_buff *skb)
 {
 	struct mld2_query *mlh2 = NULL;
-	const struct in6_addr *group;
 	unsigned long max_delay;
 	struct inet6_dev *idev;
+	struct in6_addr group;
 	struct ifmcaddr6 *ma;
 	struct mld_msg *mld;
 	int group_type;
@@ -1448,8 +1448,8 @@ static void __mld_query_work(struct sk_buff *skb)
 		goto kfree_skb;
 
 	mld = (struct mld_msg *)icmp6_hdr(skb);
-	group = &mld->mld_mca;
-	group_type = ipv6_addr_type(group);
+	group = mld->mld_mca;
+	group_type = ipv6_addr_type(&group);
 
 	if (group_type != IPV6_ADDR_ANY &&
 	    !(group_type&IPV6_ADDR_MULTICAST))
@@ -1501,7 +1501,7 @@ static void __mld_query_work(struct sk_buff *skb)
 		}
 	} else {
 		for_each_mc_mclock(idev, ma) {
-			if (!ipv6_addr_equal(group, &ma->mca_addr))
+			if (!ipv6_addr_equal(&group, &ma->mca_addr))
 				continue;
 			if (ma->mca_flags & MAF_TIMER_RUNNING) {
 				/* gsquery <- gsquery && mark */
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index de0b20cd09f0..05db19b7ad8b 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -139,6 +139,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 	if (iptunnel_pull_offloads(skb))
 		return false;
 
+	if (proto == IPPROTO_IPIP) {
+		int iif = IP6CB(skb)->iif;
+
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = iif;
+	}
+
 	return true;
 }
 
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 9e199f00eea7..40a1d31b4054 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -718,15 +718,13 @@ int
 ip_vs_bypass_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 		  struct ip_vs_protocol *pp, struct ip_vs_iphdr *ipvsh)
 {
-	struct iphdr  *iph = ip_hdr(skb);
-
 	EnterFunction(10);
 
-	if (__ip_vs_get_out_rt(cp->ipvs, cp->af, skb, NULL, iph->daddr,
+	if (__ip_vs_get_out_rt(cp->ipvs, cp->af, skb, NULL, ip_hdr(skb)->daddr,
 			       IP_VS_RT_MODE_NON_LOCAL, NULL, ipvsh) < 0)
 		goto tx_error;
 
-	ip_send_check(iph);
+	ip_send_check(ip_hdr(skb));
 
 	/* Another hack: avoid icmp_send in ip_fragment */
 	skb->ignore_df = 1;
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index fd0ef696ea71..cedad2618b65 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -310,7 +310,7 @@ void nci_clear_target_list(struct nci_dev *ndev)
 static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 				       struct sk_buff *skb)
 {
-	struct nci_rf_discover_ntf ntf;
+	struct nci_rf_discover_ntf ntf = {};
 	__u8 *data = skb->data;
 	bool add_target = true;
 
@@ -371,15 +371,20 @@ static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 }
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
-			struct nci_rf_intf_activated_ntf *ntf, __u8 *data)
+			struct nci_rf_intf_activated_ntf *ntf, __u8 *data,
+			__u8 data_len)
 {
 	struct activation_params_nfca_poll_iso_dep *nfca_poll;
 	struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
 
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfca_poll = &ntf->activation_params.nfca_poll_iso_dep;
 		nfca_poll->rats_res_len = min_t(__u8, *data++, 20);
+		data_len--;
+		nfca_poll->rats_res_len = min_t(__u8, nfca_poll->rats_res_len, data_len);
 		pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 		if (nfca_poll->rats_res_len > 0) {
 			memcpy(nfca_poll->rats_res,
@@ -388,8 +393,12 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 		break;
 
 	case NCI_NFC_B_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfcb_poll = &ntf->activation_params.nfcb_poll_iso_dep;
 		nfcb_poll->attrib_res_len = min_t(__u8, *data++, 50);
+		data_len--;
+		nfcb_poll->attrib_res_len = min_t(__u8, nfcb_poll->attrib_res_len, data_len);
 		pr_debug("attrib_res_len %d\n", nfcb_poll->attrib_res_len);
 		if (nfcb_poll->attrib_res_len > 0) {
 			memcpy(nfcb_poll->attrib_res,
@@ -407,7 +416,8 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 }
 
 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
-			struct nci_rf_intf_activated_ntf *ntf, __u8 *data)
+			struct nci_rf_intf_activated_ntf *ntf, __u8 *data,
+			__u8 data_len)
 {
 	struct activation_params_poll_nfc_dep *poll;
 	struct activation_params_listen_nfc_dep *listen;
@@ -415,9 +425,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		poll = &ntf->activation_params.poll_nfc_dep;
 		poll->atr_res_len = min_t(__u8, *data++,
 					  NFC_ATR_RES_MAXSIZE - 2);
+		data_len--;
+		poll->atr_res_len = min_t(__u8, poll->atr_res_len, data_len);
 		pr_debug("atr_res_len %d\n", poll->atr_res_len);
 		if (poll->atr_res_len > 0)
 			memcpy(poll->atr_res, data, poll->atr_res_len);
@@ -425,9 +439,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		listen = &ntf->activation_params.listen_nfc_dep;
 		listen->atr_req_len = min_t(__u8, *data++,
 					    NFC_ATR_REQ_MAXSIZE - 2);
+		data_len--;
+		listen->atr_req_len = min_t(__u8, listen->atr_req_len, data_len);
 		pr_debug("atr_req_len %d\n", listen->atr_req_len);
 		if (listen->atr_req_len > 0)
 			memcpy(listen->atr_req, data, listen->atr_req_len);
@@ -517,7 +535,7 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					     struct sk_buff *skb)
 {
 	struct nci_conn_info    *conn_info;
-	struct nci_rf_intf_activated_ntf ntf;
+	struct nci_rf_intf_activated_ntf ntf = {};
 	__u8 *data = skb->data;
 	int err = NCI_STATUS_OK;
 
@@ -603,12 +621,14 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		switch (ntf.rf_interface) {
 		case NCI_RF_INTERFACE_ISO_DEP:
 			err = nci_extract_activation_params_iso_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_NFC_DEP:
 			err = nci_extract_activation_params_nfc_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_FRAME:
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 6fb89a83d363..c929bef82368 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -38,6 +38,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 
 	rcu_read_lock();
 	skb->dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
+	if (!skb->dev) {
+		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		goto out;
+	}
 	local_bh_disable();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6)
@@ -46,6 +51,7 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 #endif
 		xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
 	local_bh_enable();
+out:
 	rcu_read_unlock();
 }
 
@@ -506,7 +512,8 @@ static void espintcp_close(struct sock *sk, long timeout)
 	strp_stop(&ctx->strp);
 
 	sk->sk_prot = &tcp_prot;
-	barrier();
+
+	synchronize_rcu();
 
 	cancel_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index f4515229e78d..27c5ad0e3d6c 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -614,7 +614,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	if ((err = attach_auth_trunc(&x->aalg, &x->props.aalgo,
 				     attrs[XFRMA_ALG_AUTH_TRUNC])))
 		goto error;
-	if (!x->props.aalgo) {
+	if (!x->aalg) {
 		if ((err = attach_auth(&x->aalg, &x->props.aalgo,
 				       attrs[XFRMA_ALG_AUTH])))
 			goto error;
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 865611127357..240b350f2327 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -166,9 +166,9 @@ void cond_policydb_destroy(struct policydb *p)
 int cond_init_bool_indexes(struct policydb *p)
 {
 	kfree(p->bool_val_to_struct);
-	p->bool_val_to_struct = kmalloc_array(p->p_bools.nprim,
-					      sizeof(*p->bool_val_to_struct),
-					      GFP_KERNEL);
+	p->bool_val_to_struct = kcalloc(p->p_bools.nprim,
+					sizeof(*p->bool_val_to_struct),
+					GFP_KERNEL);
 	if (!p->bool_val_to_struct)
 		return -ENOMEM;
 	return 0;
@@ -714,9 +714,9 @@ static int duplicate_policydb_bools(struct policydb *newdb,
 	struct cond_bool_datum **cond_bool_array;
 	int rc;
 
-	cond_bool_array = kmalloc_array(orig->p_bools.nprim,
-					sizeof(*orig->bool_val_to_struct),
-					GFP_KERNEL);
+	cond_bool_array = kcalloc(orig->p_bools.nprim,
+				  sizeof(*orig->bool_val_to_struct),
+				  GFP_KERNEL);
 	if (!cond_bool_array)
 		return -ENOMEM;
 
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 6b491bfe852b..1f2267e9d5ed 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -894,6 +894,8 @@ static void snd_usbmidi_novation_output(struct snd_usb_midi_out_endpoint *ep,
 
 	if (!ep->ports[0].active)
 		return;
+	if (ep->max_transfer < 3)
+		return;
 	transfer_buffer = urb->transfer_buffer;
 	count = snd_rawmidi_transmit(ep->ports[0].substream,
 				     &transfer_buffer[2],
