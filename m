Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEF3B27F3
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638202; cv=none; b=dp+OEfiLFL40UCwFJXSlZrGWITdw/F0PbCR1HdGT4IKHmDw9j51aVOLk6h0sMzLI14cyx31V5oVkk8Ud0Ef2cvURezhExktry+32WBCo5kYFJOhv7zH1N3tJVCHyZCLuAeY6H3HjC8Wx2XO+wYHpeh+cO+DFm7b+hnPez/HwPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638202; c=relaxed/simple;
	bh=x0+ZpzsSttFEbFmqCmNfstId4qqniJPbHy0vo40wx4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOjNpf8kZr9VYP9fgtgxrVQ5ZSXhr+/vRLwPe24uqRoVN9R8avEIiVR1NHgT3VyQszRuempBNnHtteNTDyQTsBEa4poQRvR7pgWDWax1qrE6Ywv7OZ0COTDIma4fSuraLBhKyhXbi/SJmmDMZ5enLqkg+UZNeoMQeMl3NGIAlf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw2bAY6V; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw2bAY6V"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso4820092a91.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787638200; x=1788243000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EE4Vl1NctbIluaGBA9Cuijm9WfnFqFtEMJ9pq3gCTzE=;
        b=Mw2bAY6VSQnOR9vx6VKIS8V+Q8ZICoIYO/QmWmzH2cNlA7DiU7Ugp0C49/Qo2HRusw
         +xk09tNFy+jt3cgenznwoeGQl03dCHMYwzwpLo6iL+zH4wlKEMXlwbMWBS4fbgu7yQ2F
         ceK+WzkEt49/i4A+miQWS7/vPW7lnoS5dW19AT//IUDq5/X4F4NBjMf25pligg0eLTEV
         yBVNyidblV/xB8ZKWGdzPj+fzvPmE+GUWa8KkgLVlyIqJkboWUrHBaJLEQR8ll376MGT
         +sKU10EVf8EUeMvO4mp/AHOXvzQ6lsef/7t+lv41G2yOSOiYg4mZKJ8lMBx2H0+TAT+4
         32fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787638200; x=1788243000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EE4Vl1NctbIluaGBA9Cuijm9WfnFqFtEMJ9pq3gCTzE=;
        b=TtQhXq9NvRwSHefCbp8lCrQBDZ2MEdvpqVvJaxHgBJ3ou08jbw6/tiafz1IcC95UIG
         MsZksEcxq5X4qGTZUKBlycRzMYnT9TQS2etrIZqQ7y/do8NBDm9IQRhEthQu+09scgt9
         mYQgFyxr5iCYd40K5NsFnpmNCaA4QNC65O/tiDZiCElLr5jGT3L7yYLrtwzqZXnyBJnb
         c52kog4f6GiP6F/RONP/7pik88yCZMC9BSWc/sdISJ6c7eArL4HortCNyUiLkH1/rUiK
         6Ydm57CxdGgtrazqmaHnYANJHqg2+l0tPXzJMcSe/Wqf1j/48sasmVOkWlHu64VNM7KX
         lgPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLJCL5BJeILfxBQX/4C+9jywxsYlnd5kQoGjEGpwMPBstFo4b3ORGR/G1e3MtnG0LsKdXAfK8=@vger.kernel.org
X-Gm-Message-State: AFuF++lMIFkL7BRC8CSUD2UWwKbeS3IEbq7rJC0/mr/XIa/k2udACLTa
	jpr/cggnKfj5uF+Hf/gxPpHULdInmcgMp26535o4+7HfLyvU0ZyJwMe2
X-Gm-Gg: AR+sD11B3j9QO9tgMEN60LAXCUprHuCitZnNavOmJ+j6GgF7YrcN4Qm8MtwnfcUDiZ2
	g3nbsXp6gPaefaAqgXoFI6yvaPDVkdzN7mkuZTIAd85k7nAWQ1tyU1Mn2taVTHB0bZdt7DfqUm7
	LepaiWw4w9liWaQSzha0Y5HI6R1dsBK7CFObadIRB+Zz4H2Ftl0ontsTNgYHMXourlGUsyDkSF5
	5tyWwr4/f7IcpbY/H1sImgoV60IYn0BGdME99cJZQOoQPNNxwNlNfi3xWPMK6P+JMA5r9uU/ATA
	2az8tuWoL/0paVk9wCPrqhWlBkrGRXK1lVxwFwKd5E70LawmNXkbZFD2GZNOFtRjkCFM1e49FEl
	8BKRlIU7LXUIIRI81aUy/CJoLNnqdQ2vZuyvPGn4Bmiz3e4SqUNw1y81yVLzxs4k8hLa0+Sdz47
	O5HqB5lk81FyolrqEiK5kYi8R8PRKlrH/PrC8lt9mJc/4hWdO3GMpcsTDjeVwL6E3tc6PLUZIc5
	z+mp2vhO/c97I1fSKLxMeRjWLAOGx+IUO8AN2XlkpUkEerg/avsPDME4PTdymq1oTP2q2PFBusY
	4IfMvIyKIi58qHWy3ejKgiGKxBGNFiwCmo8=
X-Received: by 2002:a17:90b:3a4b:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-39646308515mr9301533a91.1.1787638199545;
        Mon, 24 Aug 2026 23:09:59 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e74sm2436624a91.11.2026.08.24.23.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 23:09:59 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Wei Jie Law <98lawweijie@gmail.com>,
	Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] HID: rmi: fix OOB access with undersized RMI reports
Date: Tue, 25 Aug 2026 14:09:54 +0800
Message-ID: <20260825060954.104890-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

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
become the register values the RMI core acts on; they are printed to
the kernel log as the product id by rmi_f01_probe() and exported through
the mode 0444 sysfs attribute of the same name, and they are sent back
to the device as the interrupt mask by rmi_driver_set_irq_bits(), so an
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
the device declared, and treat a zero-length reply as an error.  The
device refused this way is then started as an ordinary HID device, like
a device that does not carry the RMI report ids at all.  RMI_DEVICE must
not be left set in device_flags on that path, because
rmi_input_configured() would then run the RMI setup and reach
rmi_set_page(), which writes the writeReport buffer the refusal just
skipped allocating.  The bit can arrive set: rmi_probe() copies
id->driver_data into device_flags before the report checks, and a bind
through the new_id sysfs attribute can supply driver_data with RMI_DEVICE
(BIT(0)) set.  Strip the bit where driver_data is copied, so RMI_DEVICE
keeps meaning exactly "this probe validated the reports"; the three
jumps to start that predate this patch are covered as well.

The error path has to clear RMI_READ_DATA_PENDING on its way out, because
that flag is what the wait at the top of the loop tests: leaving it set
would make every later wait_event_timeout() return immediately on the
stale reply and kill the read path for the rest of the device's life.
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
   kasan_report+0xc6/0x100
   kasan_check_range+0x105/0x1b0
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
worker returns while later reads on the same device keep working, and a
device declaring reports large enough for a 21-byte register read still
probes normally and reports its real product id.  A device bound through
new_id with RMI_DEVICE in its driver_data no longer reaches
rmi_set_page() with an unallocated writeReport either: it is driven as
an ordinary HID device, the same as any other device with undersized
reports.

Link: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweijie@gmail.com/
Link: https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com/
Link: https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweijie@gmail.com/
Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v4:
 - Strip RMI_DEVICE from the driver_data copied into device_flags in
   rmi_probe().  A bind through the new_id sysfs attribute can supply
   driver_data with the bit set (hid_match_device() tries dynamic ids
   before the static table), and on the undersized-report refusal path
   that left rmi_input_configured() running the RMI setup and reaching
   rmi_set_page() with the writeReport buffer the refusal had just
   skipped allocating:

     Oops: general protection fault, probably for non-canonical address
     RIP: 0010:rmi_set_page+0x76/0x280 [hid_rmi]
      rmi_input_configured+0x170/0x2e0 [hid_rmi]

   reproduced with an undersized device rebound through
   "echo 3 17ef 6085 1 > /sys/bus/hid/drivers/hid-rmi/new_id".
   RMI_DEVICE now keeps meaning exactly "this probe validated the
   reports", which covers the three jumps to start that predate this
   patch as well.  No other functional change.

Changes in v3:
 - Clear RMI_READ_DATA_PENDING before bailing out of the read loop on a
   zero-length reply.  v2 left the flag set, and that flag is what the
   wait at the top of the loop tests, so every later
   wait_event_timeout() returned immediately on the stale reply: the
   four remaining retries of that call, and every subsequent
   rmi_hid_read_block(), failed instantly with -EIO without ever waiting
   for the device again.  One zero-length reply from an otherwise honest
   device was enough to kill the read path for the rest of the device's
   life.  Against a device that went silent after the zero-length reply,
   v2 still finished all five retries in 54 us.
 - Express the output-report bound as "len + 4 > output_report_size"
   instead of "len > output_report_size - 4".  Both report sizes are
   u32, so the subtraction form is only safe because of the probe-time
   minimum this patch also adds; this form does not lean on it.
 - No other functional change; the three checks from v1 are as they were.

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
v2: https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com/
v3: https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweijie@gmail.com/

 drivers/hid/hid-rmi.c | 46 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d4af17fdba46..d55a0388895f 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -235,7 +235,23 @@ static int rmi_hid_read_block(struct rmi_transport_dev *xport, u16 addr,
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
+				clear_bit(RMI_READ_DATA_PENDING, &data->flags);
+				ret = -EIO;
+				break;
+			}
 			memcpy(buf + bytes_read, &data->readReport[2],
 				min(read_input_count, bytes_needed));
 
@@ -271,6 +287,11 @@ static int rmi_hid_write_block(struct rmi_transport_dev *xport, u16 addr,
 			goto exit;
 	}
 
+	if (len + 4 > data->output_report_size) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	data->writeReport[0] = RMI_WRITE_REPORT_ID;
 	data->writeReport[1] = len;
 	data->writeReport[2] = addr & 0xFF;
@@ -666,8 +687,16 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (id->driver_data)
-		data->device_flags = id->driver_data;
+	/*
+	 * RMI_DEVICE can only mean "this probe validated the RMI reports and
+	 * allocated writeReport": every bail-out to start below skips that
+	 * allocation, and device_flags left carrying RMI_DEVICE from
+	 * driver_data would send rmi_input_configured() into rmi_set_page()
+	 * with writeReport still NULL.  A bind through the new_id sysfs
+	 * attribute can supply driver_data with the bit set, so do not let
+	 * driver_data grant it.
+	 */
+	data->device_flags = id->driver_data & ~RMI_DEVICE;
 
 	/*
 	 * Check for the RMI specific report ids. If they are misisng
@@ -696,6 +725,17 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
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

