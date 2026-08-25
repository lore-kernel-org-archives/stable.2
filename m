Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304D304BDF
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653885; cv=none; b=Fd/IIFtlE/xF9w0+EYeC+WVhmdR2Ow3XZ+fH1hS1Q27b7HxIKaf7bfSQcxoUTYE2rfs6hEdtss/LNZSx8JNdNy5m7QrMrC5uu760pmumo9suyYd/Rap3GpOBw3nA2LFOb4EuZL/nRryg27iMnV9GkhFUtsYL7dF54+RwP0PJvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653885; c=relaxed/simple;
	bh=nvjooO43zXpts8Ji2M7D5Tj2Cvj0vVHZk86uprfYJZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyIxIg4hwBR22USe5/kw6YOUYcq/yrhhfA0TUSZVRaZaEMIlIbW3XoftflXqKPYcclxPN9eJyZAP/f4L6h7JDotHz5mECLfrBOn6NgewlWrPsSBqWV89YhO50CWZ2wNJh/VB6D5NE3OxzrCOWIX3Rowz0dYY20UlEi5VUR5E334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i67SyIKk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i67SyIKk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbee3777e1cso2831633a12.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653883; x=1788258683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M6b1vXe+iRYUgub3Iw8OEOiDkvR3DiJo6qrAorSELFs=;
        b=i67SyIKkcc4ihHejadIbD8eLl0TKqlNMMLrpipb6r/cGfi5Y54Dce7y8wujg6oTV16
         Zt+sSXDawIupCSB1L8Ne774UJwQsgt9HrcWUq1dD1dJW3fhmNfa9wFOboDFWp8039+lB
         7cW5xdOhgiXtPG6ZBUp3B8iOjnC4kt/jsQuYuESrZTmMoGtS0uKB5YMvWsDUt8YzLAM5
         3f2jI33M5pCeMgaRjkGX3ZFbOdSnxur+Q9fPousO15ONRbDxDsLDR9sxB2TdI6WEZOj9
         GmPP2cV+/1z9HFhYa7rp1cOKwfL7yC2AU3VU1/yeYhd8NNZbFFYKksUStILjFX6Yvw1I
         3nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653883; x=1788258683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6b1vXe+iRYUgub3Iw8OEOiDkvR3DiJo6qrAorSELFs=;
        b=UmB/5ZREJvb/SVh71l6EsS+Kodosu/ZB71nrIZmU9NBJ3Jpv6bE+Owjfw/p6Cp87/C
         6cnhlzWvYg43zMs5RnkigQOzlbGcAYZan7rWKJFvXwMjSv2PclvcSAy4g2Hk1hOehXSP
         482qw+ArYk6obti7bT4Xy3MY6/1GDOiya3Xx/jQ5uWGkXBDFpqxxdaMTR5s4GR8DRfpX
         NY+j91hkIucWnYMmMD08iRYLhESvYlgssTXm8of1nRMy9Ye+xSPo3MQqEpxQSPRnd9H/
         Cu1K449E3h2Wf9O+iQZ6P2OlT0FzQL3VxoB6hcbn73Aftte+gHZCiBcE00CafYNf7VwD
         ht6w==
X-Forwarded-Encrypted: i=1; AHgh+RpFvbURY/JwGSBETnWqVRhnkTpBKK/qvMu2UMMxBCkMujyc9BNthW9gg8100XCbdDwNfLo6i4s=@vger.kernel.org
X-Gm-Message-State: AFuF++li80CR+YfVq4i3jtX8PM4gmWhOYCtZ+vJKySGCji48JD+qN8z3
	eT8t92lGoiEStqm0I1B57O1znzg2ecM++qC1+NZv49LHtFyNsb7gCNI6ykNNEygLHHc=
X-Gm-Gg: AR+sD11P6HOO3M9zLgjhJGssAmNE6my3uMej0hYx2jhVyvOXh9CfbNlboW4m+6m73Jx
	miZ7Tn0maG93a5VAaKYYR4/RqMOzx6raTNoJm7bUv8rDPe3gsyX6ytO4IWgpiJSAqujjkjPVL7M
	CWJuyz8q5Mpr3X3wA0F6xx62zzPOw+xW5SZa8LuDH191aJ9KNfHGN/XbzlW1LP53heAgLrYQdAO
	8qtxoTB91AjH3vobe/4PsGrXTDWznpNFHK6BY6I8ueMi/boJFNr4pMSGepIH7tpMnUR1WgjtZ/3
	wTQ7nv9Y0odC6jvwJ9pyLVJ6IfhZvLHvGsAApG7UyN6yJlihjWsXgZ+QG3VPGlKrf1WfMyi59Ap
	TY9Dq0cAE7PEyQjaR/05QuKo0ORjuNmpAGv7+A8b/8p9hRQl4rjiU0leU0LLaD7oa7frJIqrdXQ
	pnTM3D/xtEtL1WeoIS1bBd1hFXVQoVnmNQRFnnQKzOenpL8Y8lqHVP9yoJ0+jdr7FpBIDNKlj4d
	NmGBZKRpIZj018eNEaFQFxRSYU/1ElD374lpD7gIPLrOyX/i3KY9M+uwKGb2wr2ZlPU+P+3SN+F
	pNLLWrMkdCdiCV3dse82nTc1+A==
X-Received: by 2002:a05:6a21:9218:b0:3cb:8280:71f8 with SMTP id adf61e73a8af0-3cd913c326amr11295931637.18.1787653882698;
        Tue, 25 Aug 2026 03:31:22 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e4b125sm1760492a12.20.2026.08.25.03.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:22 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5] HID: rmi: fix OOB access with undersized RMI reports
Date: Tue, 25 Aug 2026 18:31:17 +0800
Message-ID: <20260825103117.12180-1-98lawweijie@gmail.com>
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
	data->readReport = data->writeReport + data->output_report_size;

but then reads and writes fixed offsets into it.  A device declaring a
1-byte output and a 1-byte input report makes hid_report_len() return 2
for each, so alloc_size is 4, while rmi_set_page() -- reached
unconditionally at probe time through rmi_input_configured() -- stores
writeReport[4] and rmi_hid_read_block() stores writeReport[0..5].  Since
readReport lives at writeReport + output_report_size, those stores also
corrupt the window the next reply is parsed out of.

The read path is worse: the copy length comes from readReport[1], which
the device fills in and can be up to 255, and the copy starts at
&readReport[2] with no regard for input_report_size, so it runs past the
end of the allocation into adjacent slab objects.  This does not even
need a lying device -- rmi_f01_probe() issues a fixed 21-byte register
read, so any device declaring an input report smaller than 23 bytes
reads out of bounds even when it answers truthfully.  Those bytes become
the register values the RMI core acts on: rmi_f01_probe() prints them to
the kernel log as the product id and exports them through the mode 0444
sysfs attribute of the same name, and rmi_driver_set_irq_bits() sends
them back to the device as the interrupt mask, so an undersized report
descriptor leaks heap contents both to unprivileged userspace and to the
device itself.

The write path has no bound either: rmi_hid_write_block() copies an
unbounded len to &writeReport[4], and the largest caller a device can
drive at probe time is rmi_driver_set_irq_bits(), whose length is
derived from the interrupt source counts the device declares in its Page
Description Table.

Finally, the read loop cannot terminate on a zero-length reply: such a
reply copies nothing and advances neither bytes_read nor bytes_needed,
and because a reply did arrive the one second wait_event_timeout() does
not fire either, so a device answering 0 forever keeps the loop running
inside the probe worker with page_mutex held.  khungtaskd does not
notice, because every reply wakes the task.

Reject reports too small for what the driver builds -- 6 output bytes
for the write reports and 3 input bytes for the read handshake -- at
probe time, clamp the write and the read copy to the report sizes the
device declared, and treat a zero-length reply as an error.  A device
refused this way is started as an ordinary HID device, like one that
does not carry the RMI report ids at all.

RMI_DEVICE must not be left set in device_flags on that path, because
rmi_input_configured() would then run the RMI setup and reach
rmi_set_page(), which writes the writeReport buffer the refusal just
skipped allocating.  The bit can arrive set: rmi_probe() copies
id->driver_data into device_flags before the report checks, and a bind
through the new_id sysfs attribute can supply driver_data with
RMI_DEVICE (BIT(0)) set.  Strip the bit where driver_data is copied, so
RMI_DEVICE keeps meaning exactly "this probe validated the reports"; the
three jumps to start that predate this patch are covered as well.

The error path also clears RMI_READ_DATA_PENDING on its way out, because
that flag is what the wait at the top of the loop tests: leaving it set
would make every later wait_event_timeout() return immediately on the
stale reply and kill the read path for the rest of the device's life.

Clamping does not regress working hardware: the read loop already
handles a reply carrying fewer bytes than requested, and a write longer
than the output report was overrunning the buffer already.

Verified on v6.12.69 and on v6.12.105 built with CONFIG_KASAN=y and
booted kasan_multi_shot, whose hid-rmi.c is identical to mainline here.
An emulated RMI4 device driven over /dev/uhid, and the same device again
over dummy_hcd plus raw-gadget, give identical results:

  BUG: KASAN: slab-out-of-bounds in rmi_hid_read_block+0x409/0x750 [hid_rmi]
  Read of size 21 at addr ffff88800bf33bba by task kworker/0:3/285
   __asan_memcpy+0x23/0x60
   rmi_hid_read_block+0x409/0x750 [hid_rmi]
   rmi_f01_probe+0x5dd/0x1dc0 [rmi_core]

  BUG: KASAN: slab-out-of-bounds in rmi_hid_write_block+0x1a9/0x350 [hid_rmi]
  Write of size 35 at addr ffff88810a2b24ac by task kworker/1:10/666
   __asan_memcpy+0x3c/0x60
   rmi_hid_write_block+0x1a9/0x350 [hid_rmi]
   rmi_driver_set_irq_bits+0x1f6/0x4d0 [rmi_core]
   rmi_driver_probe+0x636/0xbf0 [rmi_core]
   rmi_input_configured+0x184/0x2e0 [hid_rmi]
   rmi_probe+0x952/0xcf0 [hid_rmi]

and, for the zero-length reply, a probe worker left in D state in
rmi_hid_read_block() after 225 replies at 200 ms intervals.

After this change the undersized descriptor is refused at probe with
"rmi reports too small (out=2 in=2)", the oversized read and write are
both rejected, the zero-length reply fails the read with -EIO while
later reads on the same device keep working, and a device declaring
reports large enough for a 21-byte register read still probes normally
and reports its real product id.  A device bound through new_id with
RMI_DEVICE in its driver_data no longer reaches rmi_set_page() with an
unallocated writeReport either.

Link: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweijie@gmail.com/
Link: https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com/
Link: https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweijie@gmail.com/
Link: https://lore.kernel.org/linux-input/20260825060954.104890-1-98lawweijie@gmail.com/
Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v5:
 - No code change: the diff is identical to v4.  Adds the Assisted-by
   tags required by Documentation/process/coding-assistants.rst.
 - Commit message trimmed; the two KASAN reports are quoted in short
   form and the zero-length-reply stall is summarised rather than dumped.

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
   wait_event_timeout() returned immediately on the stale reply: one
   zero-length reply from an otherwise honest device was enough to kill
   the read path for the rest of the device's life.
 - Express the output-report bound as "len + 4 > output_report_size"
   instead of "len > output_report_size - 4".  Both report sizes are
   u32, so the subtraction form is only safe because of the probe-time
   minimum this patch also adds; this form does not lean on it.
 - No other functional change; the three checks from v1 are as they were.

Changes in v2:
 - Corrected the v1 claim that rmi_set_page() writes one byte past the
   allocation.  That has not been true since commit 6fcd7e702d3d
   ("devres: Use kmalloc_size_roundup() to match ksize() usage"), which
   makes check_dr_size() round the devres allocation up to the whole
   kmalloc bucket, so the store is in bounds -- KASAN stays silent on
   it, correctly.  What it does do is land on top of readReport.  The
   out-of-bounds accesses are the read and the unbounded write.
 - Reject a zero-length READ_DATA reply.  Such a reply advances neither
   bytes_read nor bytes_needed, and because a reply did arrive the
   wait_event_timeout() does not fire either, so a device answering 0
   forever spins in rmi_hid_read_block() inside the probe worker with
   page_mutex held.  The v1 clamp does not help, since
   min_t(int, 0, input_report_size - 2) is still 0.
 - No functional change to the three checks already in v1.

v1: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweijie@gmail.com/
v2: https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com/
v3: https://lore.kernel.org/linux-input/20260824122708.76168-1-98lawweijie@gmail.com/
v4: https://lore.kernel.org/linux-input/20260825060954.104890-1-98lawweijie@gmail.com/

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

