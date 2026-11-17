Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943999;
	b=g9VFEEh0Yi8WFApzDLpxamrYqb/sE3txQGFBUe12JpLJOy/2gy4na+Q0GR4BDWltL2HC
	 oje2eN7vax6FAREoBjPceBytjijlE2b2hlByj9KDQWI4UEJtPQ6UJNzdYfamVGawbEd0U
	 sPH+O0bxSLZmIXQzZUReGZkcvG1ArbV2fVxfy3dE6FOK3jFMCz98pO/GyfiqrAyXv6Ts8
	 hzTQBxPU7buiiiafjEVNT7yacx5wUim4jCWQvNpcCuAQqOnks0+71pteJEA6h6LlUmnBG
	 UcPeQKNY5UFskEBLxcQSndAIYIAuNkoSe6f8kR8Hxg3XAEopHk5PciDVmQsmjpto1mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iZlOAQRkN5G2+tOZzeiNY9AHm7pHtMPCmdAEzClHGyQ=;
	b=0Trjvn0lhP0lVxb/TMqu0dO0fAsxs7G430C3Y/bmt4cuUqmKvCwyFdTR0/4sZ5NaV+yg
	 rYFgkdzrDxHb/SjuVBeAGRkxsUow6YlKklywS5PzytSntqEvGDYY631NxWDnEecgCi6C9
	 +BXgjl/t/NnQWuEUfIGYp1H1vHx8X7/uVLX49ltMAV7azvc3hWYWjkGWk0MoK7Inq+Ixx
	 39Vkkk6RBpSFr7pX6AZ832Csk965HvO/RKpWtVuf6gZ1ZKbBVJGy2fyChnMQkWYb93/Pz
	 P1PN4fVexqEQWLVsxGMBQ536yhA1i9XSrr60uASYDvkwpYD7wAc6zxt+zIVL+bvv63w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8YPwaBe;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E4606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 19:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2E4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8YPwaBe
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb684859cbso134304a12.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794943998; x=1795548798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iZlOAQRkN5G2+tOZzeiNY9AHm7pHtMPCmdAEzClHGyQ=;
        b=L8YPwaBe5vXOgdwYhFGtgeWAt5sTw9fVNeZFWBpGg9dZJDIOEUnpY/KvST5P1iDbIE
         LxHY4rsA5h2UTiUCcNHm0VxKEiMQKYkHu7Ld5wEMqFgvnz0j95dY9qTebLkhplufnZ1n
         FJeI3dm556n3zshgIFGAv7YJODx/MSs3tNLEAW0GuixCVfZjTMC7rkqCDH5YaLTKW8Gl
         CWYPDtw76QyjqOXxTpVQ+gu06WAuMNwT53aE+SNPTB7kgAISXubNvgxaSeTFFGvwfCa/
         dlHPaaAtzhJUn363UBoiUmsJzuqxsogFMPukQNzHvWTvZvIaxupR+kAdQM3ZRUkketSY
         M4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943998; x=1795548798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZlOAQRkN5G2+tOZzeiNY9AHm7pHtMPCmdAEzClHGyQ=;
        b=fIObMJBz82v7YZZl9XL+bflcc7OS0bvQg1KHKrjB6FTt955aonH5euMboHB4Y9siAD
         62EUVyMAi6m93tjKhR9nJSFaj/Hs/ARpJGc+NWWGKi8pSEFdMPeju5XzmBKlDnpQ7U88
         4Pp2ofaC6sIDR8iJOeMLhmYQj07rxeXg1EQLF+jCCrgQy+FvNuB29LciZGo+fm+cK6p5
         eRA93zS0OS4fdM3CdKk6fOYO85EWRVB6s7dj567TirC8MNAyUKMEoXTuVV3ZMzRF6IOu
         wEy9RbrQfSQTBkDOh1seFwmZvL1WdZP3L80aIXmvYsdZnwwdTXZhnYwSmKpA8Jc16g2g
         btXA==
X-Forwarded-Encrypted: i=1; AL+hErG1V6n4fK6Mh6vvvXmddRVpzP5+10Hg5Qu6xc80xx0k1PsVe4Zl3yH/uhwp9SgoA8yrar6Urg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2e+YjHFtyoi8t2HnJzlpjM0D3H9yUUNIj/U6lLizmTwMxCk46
	Eblnz2aBmUMk88Kdj/oyaCETdiVi/ycecXNgpqSKH8YVxFsSdBmjS2BQ
X-Gm-Gg: AZFdTZcaJU23ojqUrLtpofX6yuIjvYz08pUEf20aIXK5OJY/Yr4X1lz/Jm+OYh3u+Bt
	tTjN/n4nsEVeGET5oaPg3Tdmj/ywN7g7GSrxGBG6TpjOXHV/a3PE0CdbpgW7/Eq1LSWbWWVVd8m
	z/vS9Bv6Sbt3gTyaOek+LnH2/dTNuJgU0MJLUunUvtLZ/ztC6kn0IJWmWXHkiTti+/aRm5oe9l9
	eeTgKzk2NgoaydnMgIoy3FbqiqOiLXFIy82HkwmpvoCIPQKKIViu12/opWWOfgPuKM5/Ai84XYA
	fMPJle59zYBXI+CK8aHUFxx5ULSx45mk2DkK2w4m+WmmY7+xWcYkKIvsK/bXhYhyyZCRkxaPJiD
	Q5bosboGszFgXKup8McD7bfeXHIjMBVaCb3fN6s1ov5asv0tTo9+X04WJNZp40kfX8nHzh3zNZ2
	7Jqa3Mcx3gTn+zshbWUIgfCD6F+yoPvPeDARfnwo7DB0bFRTtk0v1rPQWjLIIgsXlx8CUEGgRa+
	pz48rPB6TA+EKC4e0//+P1ax4fp8oP+pQAT8qW+mG4yy1ns15ykWZ+gwhgo0N9pPqcArH1Wmj3Y
	5KhZFd0N50rJLEIippED2Z0P0WWFOyb/rCvrq/NFdqruJqGxf0/B1/o=
X-Received: by 2002:a17:90b:48:b0:3ac:86a0:5766 with SMTP id 98e67ed59e1d1-3b3d07d29e9mr369689a91.63.1794943997974;
        Tue, 17 Nov 2026 11:33:17 -0800 (PST)
Received: from r-desktop.tail1ce325.ts.net ([2601:600:cb87:4c27::6a99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d19b6e18sm359163a91.10.2026.11.17.11.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:33:17 -0800 (PST)
From: Riley Wagner <riwiwa00@gmail.com>
To: mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Riley Wagner <riwiwa00@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: xhci: pci: do not perform Soft Retry on AMD 500 series chipset host
Date: Tue, 17 Nov 2026 11:33:00 -0800
Message-ID: <20261117193300.25897-1-riwiwa00@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Full-speed HID devices hot-plugged into a root port of the AMD 500
series chipset xHCI host (1022:43ee) enumerate and bind, but never
deliver any input. The device then resets itself after ~10 seconds,
re-enumerates, and the cycle repeats. Devices present at boot are not
affected.

With xhci_hcd dynamic debug enabled, the first poll of the interrupt IN
endpoint fails with a transaction error, the driver performs a Soft
Retry, and the endpoint never completes another transfer:

  [ 6658.313453] xhci_hcd 0000:02:00.0: Successful Endpoint Configure command
  [ 6658.352348] input: ELECOM TrackBall Mouse HUGE TrackBall as ...
  [ 6659.424165] xhci_hcd 0000:02:00.0: Transfer error for slot 29 ep 2 on endpoint
  [ 6659.424170] xhci_hcd 0000:02:00.0: Soft-reset ep 2, slot 29
  [ 6659.424290] xhci_hcd 0000:02:00.0: Ignoring reset ep completion code of 1
  [ 6667.989369] usb 1-9: USB disconnect, device number 30

usbmon shows the interrupt URB submitted at enumeration and only given
back by the disconnect, 9.6 seconds later:

  2562187476 S Ii:1:030:1 -115:1 8 <
  2571824873 C Ii:1:030:1 -108:1 0

No further transfer events or errors are reported for the endpoint after
the soft reset completes and the doorbell is rung, so the TD is never
retried or failed.

This matches commit a4a251f8c235 ("usb: xhci: do not perform Soft Retry
for some xHCI hosts"), which disabled Soft Retry on the AMD Promontory A
hosts (43b9, 43bb) for the same class of failure. Booting with
xhci_hcd.quirks=0x10000000000 (XHCI_NO_SOFT_RETRY) makes the device work
reliably after hot-plug on the chipset root ports tested (1-3, 1-9); the
same device also works after hot-plug on the CPU's xHCI host (1022:149c)
without the quirk.

Tested on an ASUS ROG STRIX B550-F GAMING (BIOS 3621) with an ELECOM
HUGE trackball (056e:010c) and a PFU HHKB Professional HYBRID Type-S
(04fe:0021), on 7.3.4 with commit 6895dbdc19d9 ("xhci: give back TDs
and clean up ep0 after disconnect") applied. The trackball showed the
same behaviour on 7.2.x.

Add the AMD 500 series chipset xHCI to the hosts that do not perform
Soft Retry.

Fixes: f8f80be501aa ("xhci: Use soft retry to recover faster from transaction errors")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=202541
Cc: stable@vger.kernel.org
Signed-off-by: Riley Wagner <riwiwa00@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -88,6 +88,7 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
+#define PCI_DEVICE_ID_AMD_500_SERIES_XHCI		0x43ee
 
 #define PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI		0x7316
 
@@ -493,7 +494,8 @@
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
 	    (pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_2 ||
-	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
+	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4 ||
+	     pdev->device == PCI_DEVICE_ID_AMD_500_SERIES_XHCI))
 		xhci->quirks |= XHCI_NO_SOFT_RETRY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ZHAOXIN) {
-- 
2.56.0
