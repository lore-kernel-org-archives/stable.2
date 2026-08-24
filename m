Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41A3783C1
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550210; cv=none; b=CznByKXt1YxSx32H2A7DiSW/W/eREEqouMscYEy4kijjxxWuFKVr6ytDUKxO40m/QXGY4Puw7lIwZisTco1coWEOwK/idYHSplGLKu/8DIjMVhXFZUC5gtSDqyMwIFF8hRuT+MMlprqtZ8Plm57U8Otgvdj0dtmVbWz88NbVOhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550210; c=relaxed/simple;
	bh=ogQCv3+3wqqaYOtQp1aWDd4JE4HVFN/GSBqJnHUSBuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDnWzc8xZ2VZwmBXqKgfJLHsFFDYlnBb2Rj3TdWCYb/G8imhNjbzgwnlu5Q0VHjmb222dFQWL2QKkG/MUVr0b9ZF61Y9Kd9TW4Z7DzeIhessospROaBziVLfqmP8wRe8G1j2zoZhGi0xVZxcPnej/AfYpiRIahJaxyqRHeuThrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRxxkwWu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRxxkwWu"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so3733627a12.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 22:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787550207; x=1788155007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nPnuHejh0rMF+UFuDDlIW37heLcy2pKr2E/rEhLQwE4=;
        b=YRxxkwWudb1zP0DLCoYnwV+wL5s/BzHmO6iwSl6h7A32YK0JdRAdliXjeeCmgEY3Av
         VH3fNy4CKTdEDQGkFgBGHG4w7l36kZyzu2VSvtoKtb6ceu6cl3KFHl+Ub9MsApAFqhtq
         9fu13fHBhrkUBR5QpWNYyNPsoiO0bDD00T7GgDO2/KBHnwRK9bEt/lqbZcV163iXsiBB
         YTdTXH1Tdoixwwc7W8CroUQW5ttiO1wTcglWueazdJt++unjoSyf54Lbi2Qrpfk7e3Id
         krfFLbLKD5Nf8vempFrfwaKzQPNPKC1/TZUJUm+Vwad6LDWnoyRDhPMo6y9dlu9IJV5W
         pHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787550207; x=1788155007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nPnuHejh0rMF+UFuDDlIW37heLcy2pKr2E/rEhLQwE4=;
        b=lr2IoAnKXEXE9ThT3I/gzIZuyq/KdwLvOkLhh9HJgXSzFngITj4vCJKH2aYVCqB8ti
         1kOANnC9j4elP0SQnOMy2Lsl/HpN6u1bTLVpvbN/QHf3fVweOhBy7s/N8dKv9ixAsDfi
         e5RCjqr664v7wOr5hqZ4ACepxGgcDIWYwsY+jy4qx5q8SIByT9G0xQhR8MgkONv6h61z
         vSm6cTlyulYCE/QZcH47t0VugfluFJoeX1szq7L+g7Jn8IM1jn21b+Yzo7Cbqg71wfNv
         2xBa1qBwCARIFny8duJxoVKGk/G+z3fSHvEccCgMazj0MyQgRjspjzIOB24xZz28PTOa
         ovsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSQSW3V5xqghE4X2JMd92DzBKeYQIW4T/hyt1BPIuGk/Es1irn4j7x8/26DdQspbT81gTBvsI=@vger.kernel.org
X-Gm-Message-State: AFuF++mq2aOhXalnhgEpU3ERGNkZcxk3jPin/Rf64xbrN59OnP/GxiLh
	MUHVEuBIsM913zdeu4VF581532zHbmEXAocO0/Z3XhQvKXMGfO2t5TY15HFqG3tv
X-Gm-Gg: AR+sD11rr1VbzEY7H2JuG+D+eulls9nZc7f7hJwB0fme71eahJeMGcppKmldWzzbwhM
	s8LRbwWrwE6Ll0h+Bf0sDVxfSF4gMFrvHu60jVaX9Mz44E13mGGT+k4NSwUsOB34pU3OVZ4cEGT
	tk7HH9F8yMlw+SrRZyRofjBfuIfknsn/7qe5B+bkSw+J3x6zJjArI6WbhIYUGQjGLYtpauBKjT/
	mlgxe/cDWwEYsWED4gRXcz50ZqJrmwDyC7ZAcDcJ1whGk8esOiMgEb/MB1HmTAdyy5nzpU98PKp
	TPqNSDeMl3GHUUpT0MfYiInWxzSjXnLzgS04Erj8jMOvicOlvgo+2iptExud4rvFpmdcIGfo8WN
	CyRb4sIR5K3boqmfHyNio46HBxd5s9frrJUecmYaP9kXFqCS8FI5ACF5RMPfORnbktt3rEzy463
	OI8LklYOaz2KwYKYzXBXBLl1w/0ufU6BfEPGWXFP25oSzV2d2FFvS3gpseknw2adMaAGsqh7BUH
	9md/eATRgjYZ9ui71dHDHbbLOXPAz0zZ0UB2CqNcOJvOK77vpPDPfUAYqHKawdys4Gk4Z54H6KF
	YK6Vc/RJ74rffdkywjK6DYrk
X-Received: by 2002:a05:6a00:a8c:b0:84e:d5e6:a085 with SMTP id d2e1a72fcca58-851f969b7a9mr37541153b3a.0.1787550207230;
        Sun, 23 Aug 2026 22:43:27 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b211sm1542292b3a.28.2026.08.23.22.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:43:26 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] HID: rmi: fix OOB access with undersized RMI reports
Date: Mon, 24 Aug 2026 13:43:20 +0800
Message-ID: <00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hid-rmi driver sizes its writeReport/readReport buffer purely from
the report descriptor supplied by the device, with no minimum bound:

	data->input_report_size  = hid_report_len(input_report);
	data->output_report_size = hid_report_len(output_report);
	alloc_size = data->output_report_size + data->input_report_size;
	data->writeReport = devm_kzalloc(&hdev->dev, alloc_size, GFP_KERNEL);

but then reads and writes fixed offsets into that buffer without
validating the sizes, and readReport is placed inside the same
allocation:

	data->readReport = data->writeReport + data->output_report_size;

A device declaring a 1-byte output report (0x09) and a 1-byte input
report (0x0c) makes hid_report_len() return 2 for each, so alloc_size is
4, while rmi_set_page() -- reached unconditionally at probe time through
rmi_input_configured() -- stores writeReport[4] and rmi_hid_read_block()
stores writeReport[0..5].  Since readReport is writeReport +
output_report_size, those stores land on top of the read buffer and
corrupt the window the next reply is parsed out of.

The read path is worse: the copy length comes from readReport[1], which
is filled in from the device's response and can be up to 255, and the
copy starts at &readReport[2] without any regard for
input_report_size, so it runs past the end of the allocation and into
adjacent slab objects.  This does not even need a lying device --
rmi_f01_probe() issues a fixed 21-byte register read, so any device
declaring an input report smaller than 23 bytes makes the driver read
out of bounds even when the device answers truthfully.  Those bytes
become the register values the RMI core acts on; they are printed to the
kernel log as the product id by rmi_f01_probe() and exported through the
mode 0444 sysfs attribute of the same name, and they are sent back to
the device as the interrupt mask by rmi_driver_set_irq_bits(), so an
undersized report descriptor leaks heap contents both to unprivileged
userspace and to the device itself.

The write path has no bound either: rmi_hid_write_block() copies an
unbounded len to &writeReport[4], and the largest caller a device can
drive at probe time is rmi_driver_set_irq_bits(), which passes
data->num_of_irq_regs -- derived from the interrupt source counts the
device declares in its Page Description Table, 39 entries per page over
as many pages as it likes.

Finally, the read loop cannot terminate on a zero-length reply: such a
reply copies nothing and advances neither bytes_read nor bytes_needed,
and because a reply did arrive the one second wait_event_timeout() does
not fire either, so a device answering 0 forever keeps the loop running
forever inside the probe worker with page_mutex held.  khungtaskd does
not notice, because every reply wakes the task and bumps its context
switch count.

Reject reports that are too small at probe time, where the driver needs
6 output bytes for the write reports it builds and 3 input bytes for the
read handshake, clamp the write and the read copy to the report sizes
the device declared, and treat a zero-length reply as an error.
Clamping the read count does not regress working hardware: the RMI read
loop already handles a reply carrying fewer bytes than requested, it
just goes round again.  A write longer than the output report was
overrunning the buffer already, so rejecting it cannot regress a device
that used to work.

Verified on v6.12.69 and on v6.12.105 built with CONFIG_KASAN=y and
booted kasan_multi_shot (generic KASAN otherwise reports only the first
error per boot), whose hid-rmi.c is identical to mainline here.  An
emulated RMI4 device driven over /dev/uhid, and the same device again
over dummy_hcd plus raw-gadget, give identical results:

  BUG: KASAN: slab-out-of-bounds in rmi_hid_read_block+0x409/0x750 [hid_rmi]
  Read of size 21 at addr ffff88800bf33bba by task kworker/0:3/285
  Workqueue: events uhid_device_add_worker
   kasan_report+0xc6/0x100
   kasan_check_range+0x105/0x1b0
   __asan_memcpy+0x23/0x60
   rmi_hid_read_block+0x409/0x750 [hid_rmi]
   rmi_f01_probe+0x5dd/0x1dc0 [rmi_core]

  BUG: KASAN: slab-out-of-bounds in rmi_hid_write_block+0x1a9/0x350 [hid_rmi]
  Write of size 35 at addr ffff88810a2b24ac by task kworker/1:10/666
   __asan_memcpy+0x3c/0x60
   rmi_hid_write_block+0x1a9/0x350 [hid_rmi]
   rmi_driver_set_irq_bits+0x1f6/0x4d0 [rmi_core]
   rmi_f30_config+0x27a/0x4d0 [rmi_core]
   rmi_driver_process_config_requests+0xe7/0x150 [rmi_core]
   rmi_driver_probe+0x636/0xbf0 [rmi_core]
   rmi_register_transport_device+0x19e/0x3e0 [rmi_core]
   rmi_input_configured+0x184/0x2e0 [hid_rmi]
   hidinput_connect+0x13e3/0x2a50
   hid_hw_start+0x89/0x120
   rmi_probe+0x952/0xcf0 [hid_rmi]

and for the zero-length reply, after 225 replies at 200 ms intervals:

  kworker/1:0+events  state=D
   rmi_hid_read_block+0x5cc/0x750 [hid_rmi]
   rmi_scan_pdt+0x211/0x3f0 [rmi_core]
   rmi_driver_probe+0x1c0/0xbf0 [rmi_core]
   really_probe+0x1e3/0x930

After this change the undersized descriptor is refused at probe with
"rmi reports too small (out=2 in=2)", the oversized read and write are
both rejected, the zero-length reply fails the read with -EIO and the
worker returns, and a device declaring reports large enough for a
21-byte register read still probes normally and reports its real product
id.

Link: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweijie@gmail.com/
Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v2:
 - Corrected the claim in the v1 commit message that rmi_set_page()
   writes one byte past the allocation.  That has not been true since
   commit 6fcd7e702d3d ("devres: Use kmalloc_size_roundup() to match
   ksize() usage"), which makes check_dr_size() round the devres
   allocation up to the whole kmalloc bucket, so devm_kzalloc(4) is a
   64-byte kmalloc and the store at offset 44 is in bounds -- KASAN
   stays silent on it, correctly.  What that store does do is land on
   top of readReport, since readReport is writeReport +
   output_report_size.  The out-of-bounds accesses are the read and the
   unbounded write, and the KASAN reports for both are now quoted.
 - Reject a zero-length READ_DATA reply.  Such a reply advances neither
   bytes_read nor bytes_needed, and because a reply did arrive the
   wait_event_timeout() does not fire either, so a device answering 0
   forever spins in rmi_hid_read_block() indefinitely inside the probe
   worker with page_mutex held.  The v1 clamp does not help, since
   min_t(int, 0, input_report_size - 2) is still 0.  khungtaskd does not
   notice because every reply wakes the task.
 - No functional change to the three checks already in v1.

v1: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweijie@gmail.com/

 drivers/hid/hid-rmi.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d4af17fdba46..98fafa7499a7 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -235,7 +235,22 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
 				break;
 			}
 
-			read_input_count = data->readReport[1];
+			read_input_count = min_t(int, data->readReport[1],
+						 data->input_report_size - 2);
+			if (!read_input_count) {
+				/*
+				 * A zero length reply advances neither
+				 * bytes_read nor bytes_needed, and because a
+				 * reply did arrive the wait above does not
+				 * time out either, so a device answering 0
+				 * forever would spin here indefinitely with
+				 * page_mutex held.
+				 */
+				hid_warn(hdev, "%s: zero-length read reply\n",
+					 __func__);
+				ret = -EIO;
+				break;
+			}
 			memcpy(buf + bytes_read, &data->readReport[2],
 				min(read_input_count, bytes_needed));
 
@@ -271,6 +286,11 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 			goto exit;
 	}
 
+	if (len > data->output_report_size - 4) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	data->writeReport[0] = RMI_WRITE_REPORT_ID;
 	data->writeReport[1] = len;
 	data->writeReport[2] = addr & 0xFF;
@@ -696,6 +716,17 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	data->output_report_size = hid_report_len(output_report);
 
+	/*
+	 * The write reports built by this driver occupy 6 bytes and the read
+	 * handshake looks at the first 3 bytes of an input report, so refuse
+	 * to drive a device whose reports cannot hold them.
+	 */
+	if (data->output_report_size < 6 || data->input_report_size < 3) {
+		hid_err(hdev, "rmi reports too small (out=%u in=%u)\n",
+			data->output_report_size, data->input_report_size);
+		goto start;
+	}
+
 	data->device_flags |= RMI_DEVICE;
 	alloc_size = data->output_report_size + data->input_report_size;
 
-- 
2.43.0

