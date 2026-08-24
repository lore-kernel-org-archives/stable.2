Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7EF4156C6
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574438; cv=none; b=khsWtE/2tIApDC4mU6FI9+C9zfj1DikFe/H9P+I7Obef2JVud6KHEpwOwdNW8eV+xmyXNlmVF5S0utR5L+LmcJtxbfkII7wLKB97hG91hl2nurIVHZBQ57VvVUTypmPNY1WRVKWtdTsWfVUo/SVUOUGAC4v14t4KU9DD2OXB7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574438; c=relaxed/simple;
	bh=3WuNISEfhFDmUKJ0wokuPgLxSVeHFRPC7NUNrq88Adc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSKeQIcUOEgH51tMJ2UQHF2Ho+zqOcF+xX0Ags2bvtO/KhVSYGiz0i2D0XXVJSZOmhNkmh9Ytt8u1RPN5C1CSXW4pBZ/KQPwHYN4/zAh6mN0Hd7CWlYZ2TQi7YsAHl5IBLoHFD/3Gj/UrNidah078p5nsxRW8PDzEni6II/Wcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsSA3H2A; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsSA3H2A"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52b3934af3fso38550841cf.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574435; x=1788179235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZCT/ZeYxr3v/wFXbl9Q44bB/wJ58YYeH3EZi26pMCmA=;
        b=SsSA3H2Awp0RTpBtRJ/QS8aQf4NlsByOrl3UhCS+WKjzm7ogtsVpCo8Si34S8GsJxN
         uUeycBgNY2v20lqXA+RObN3f92+6D2BjZFfNkehnwc+mKe5Yst5STz457zPVZuWnIBi8
         awWz12AFk5nAxnOmh047ypQ8da64amSie5T+329Ljmy4algFX5nK97aIHmj7n+fGvse9
         CvKvFjvWLbtFnJYcCVVFStmlwWyutwVz60ty4oJB2QgD31CAlpnSS+mKoJeNn3m94iU2
         e3x49CXcBej5cd4Izq/M2gE+wrsZSN5FI05flScHZDVRTannzyNjM9jhWESG/c69W4XQ
         8ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574435; x=1788179235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZCT/ZeYxr3v/wFXbl9Q44bB/wJ58YYeH3EZi26pMCmA=;
        b=qog0xjhqh9wITibLV/pc+w7RbCziGYAqYshi3oOiC+kEI58UnukXbsNFsrJzppkuHq
         XjRog3uLtVsY0baswgH6+Bl6cWsOVr/S87KAYlmXgJktV5qxHaarn3XgT5ErcqTKc9Nc
         EFMbSVnSmQTCvR7iMCmCmJaJY6kjLMoBA4VdpmkhPhfsqb0RsN/XBwfYjhwXvVUiXHat
         Uz3/E1yOZeO5GI2Q0xxlhLek+Mzu9X9C+Z0NGxIQ/WaUjTKKwEzHe8DrtKMUoG+t4Ulz
         pTMWZ+44E2wtZ4l/10saumwxyLl/le1tp7WWubiRgmvd6IuD0So9jr3AikySsEz2Wbzk
         QibA==
X-Forwarded-Encrypted: i=1; AHgh+RocKyZiPlv7g2gf/2QX3q4mGA5jmxxzDDlzCRXsESK7PtvM1tOOGUBnmgq09C/Ct9H6IG37iqg=@vger.kernel.org
X-Gm-Message-State: AFuF++mIR52alh9nNaY2j9plQYaQnCAcMz7VKC92oaIObs7OsG6H+pab
	W3Q1JY4g4AFABjlnhkuG6KlD8Z55O1CBIAMTLQXm/NpI4MG+qQvp7Q3apaP0bXBuCjM=
X-Gm-Gg: AR+sD10iAuDQO4I6DGYVQhq9iiY2jc9laZAQ5f7fsBcHFuiyBQ/gH392x+++x2rT9M+
	mU1/18wXe/bxrQiT99wbJXGZ6hDbrHCxAAkubwr4R9SqF8jPu5m8+Ky+pVtiJXeDvLIjdcrfJF7
	rnUW/FMlOCdrbNkoX7+OTLoMZ4cBfQhaKprX1g0r/yeLkrSX8u3ItSVJP2lAXh96rJDmvHDSTE1
	AWQpN0Noio7vAs6TknBEE+a9521ezq35Fc88OX52OKmx+v4TUlhDo7z8O3ryUmb+a8hq/QMSe2O
	XzpCLBkiMoetfPnAHpT4QYgIrjfV4wJ1h80nWZ4z/Zv24FlPMSH5q6fVs4silvnqqaQNPKaHuCZ
	/j1tftsMZqxlHAvS5/uU0sPEhwxhHTHcHzTxTLAT7gwIbZ4zyG70aMBDQDGrqVcsOlJ/6dgmEpT
	tZB+NigPCLIFuythoFlWe5NWu4FPs2MwLW+Jmkdjcjdz2JusmOh/hWzUN0FhxwDl0WNH5eXQBin
	vxj5GJCHo3kcwKdHMADE/hYuqiYFjPI8N1VF9znR+/gcfZDX6QWVjLoNs3I13Ztm2Six88CK8sB
	SqSDORg0stzR5n1pmWP4TjH3i48RWXV1rLM=
X-Received: by 2002:a05:622a:5c05:b0:52d:70b4:2e1a with SMTP id d75a77b69052e-52df5637a93mr290822501cf.1.1787574434730;
        Mon, 24 Aug 2026 05:27:14 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e09975f74sm46150551cf.5.2026.08.24.05.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:27:14 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] HID: rmi: fix OOB access with undersized RMI reports
Date: Mon, 24 Aug 2026 20:27:08 +0800
Message-ID: <20260824122708.76168-1-98lawweijie@gmail.com>
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
the device declared, and treat a zero-length reply as an error.  The
error path has to clear RMI_READ_DATA_PENDING on its way out, because
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
probes normally and reports its real product id.

Link: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweijie@gmail.com/
Link: https://lore.kernel.org/linux-input/00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com/
Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpads")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
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

 drivers/hid/hid-rmi.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index d4af17fdba46..cfbd5a245283 100644
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
@@ -696,6 +717,17 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
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

