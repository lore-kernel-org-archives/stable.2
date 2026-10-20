Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792473294;
	b=f3G9xOUP9uT2GK8Mv6fD49suaJjOyJpX72+U/Ox1SCTo/193qBW8uHG3gjjQwWFiV3jl
	 kcBYJ/WBq/nE9Qn/pLjdY4Mjxl4ELM3Gy+e7KYfqw8asNFMIq1uVUIVBXC0RlK1bC/yLk
	 a0TRN+wNHZvBqbWlHJl4T2+Uj1BCXC6wjoOqEmv8QCX3edzQGtNa+Gy6aoFstuiHWV5s0
	 jZ78qLy+HPJiISTHE8X6l4ikwFwqzryrK+BDmUFiHux+RsOzkEArCPUS/dytC/z+n+F/8
	 rxRgdasId85BZNr5CER8+BUNdVCv6n234gZaTbyQBuCHsxkZA4BTahBQkQ4kSR1uoRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TrZLjxuUWkEymBh2PSVn3/lyI3kENtzx2QTXaKgS9MY=;
	b=5CA0jNnrMBno0yAPnF+wQJODW7VIGNU9AHi3Uy8VH3UG1hd3MjovSr73JvYyBKar7N4v
	 bdAjBQ7XlJrq0hhsWUo8pjCQWXQL7y0oyFV6Oh1AGKCKi+E4O4zEzPpsVg+qPyeTmx4uf
	 DkwA4uYxz8ND0h35pvvC3TvoRz9HFvVl08lt40w6XPSd1/0ud6Vkyzj9d5fOkQbFm+DY/
	 PKYnRbYgtYk0JQhdqQw6BgqIsWB9olwRG7qTTvxTH37zoXZohA1PbLp7oQbzP20q/06YC
	 g9M2B9xsqLSCGQDEwIfNDVYIv3iLhY3l4zCLtgHMou/fpzDu3fQE+d0vR/nq5nV2WAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="pj/U+8sT";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE7606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1CE7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pj/U+8sT
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1325250a91.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 22:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792473293; x=1793078093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TrZLjxuUWkEymBh2PSVn3/lyI3kENtzx2QTXaKgS9MY=;
        b=pj/U+8sT7PblrBdJkCpGeL6ASX2udgplnUPFcQFKQG3BPcwrOXWHzlHAFPQOJcZJZI
         uNRbdtAb2pIPDl2pyRPQVH9WQLhw91c6oE2QvhkPt7a3ToJmcaSFeZNPwzcaqYE0BT4X
         2CKHmJTb3voGDHNfKyWPzvb+diIMoXnbmzA5ovxp5ESExbdEqQeu1ZL9gnI1qYRTD+dN
         VD4TZm4wJGbuzZpWJA9Vh8lwPexwq5w/2UEBytdfr6ommumrhGiBbFy2XpEwc8DLsnem
         5T5MNWq4sz32gXflMK+dJ0NHSkx9CoocrkMrgA6bVN+ceyTVrC1+giRjTHG4vPZBBc7I
         qBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792473293; x=1793078093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TrZLjxuUWkEymBh2PSVn3/lyI3kENtzx2QTXaKgS9MY=;
        b=jkyShSePO5GitxZecCCqwCsLbFnY9uPInLGm8271E+0U/+A+y1xn70M+Y2I0WWT17f
         570gjxAJyTxhq7tCiyS21q959rkD9pWjL5KGZ0Kr77wzSKkn/r0GKDzqGfQzVdhpYIv3
         0NfQT7Mj88IArcVru0+Q2xgaF2nx7OF9mTbpSx6RxlI2dKSN2lJjhfSVM7uXCYJ0viLK
         Y0ki4FPscetLMejPcEs67RX3+frldM33PamuFjpDnrm+lHmXY1BpPdyCv83g5Ut7eCbp
         VDkFjdqOJqMFYn4b4fAhmkrnQOmPlvIhOO2sJvr5CSoFk054vJkbffjCR3Kj6GHG/nyZ
         qhGw==
X-Forwarded-Encrypted: i=1; AKwUvBwhJmCjMwA522lw5E1Gde+7fnPPX8S89E5e0KMGOaxK7kmfHLNrAA+FVYd384yPbFPfaB0NQwg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKM7U7OE/nGt3dCOBOW289JhK922nNa4N0m4qVxOog78SsuxwIK
	T+50SrvXbkad+rYbU/cXPde9pqhEeYAYyS+hVKM4Vw7Pu6XxZPF+IMvD
X-Gm-Gg: AYBFou22WbzJxqVqoGpnpg8VK7Zamwb0T5QyAKlob/mXWZ3NYwm419DhXZciCsLKBqc
	AFKHOT9BDsEGxyuqJZz1Xi+WDHqfX6/AK03En63mV+t6ESD3m7GIcDI4juH+O45Y/CNqcYEztIz
	EzVMI7OrCf+GcgJ00rlQflvoPw8erQ2CF8rhbFOZiwgPSzWt+c5bu1HDzbiJ2bwVfw+W8a6SplK
	P1l6XPO+m7b0JSqxu5iCH7EefJbUWDKX4XhtdWBMVyAgIdpTrkGcU4y6HC04Enl4ambKgFZ3u3y
	3V7+q9Hx5y0GkEPPKEub/Xwf1N59oZPceTk0NRcJdRjrCwZTEGI13gdXRia2ohAlqESwJUOykOq
	YHHakknQ6UJ7mpK/mnfIT7dOw3sCN4VoxcA9JFnm64FCbpQX2XfXucCdqd6binL9ERsF4cBJM95
	Ph+IV94cXy1GiuGHkZjCT8SPddGZcRrRRNgIV878kbd/h7NJ3LZA70TkoHUCfjJdpevUhqf1NZy
	crSD+o0iSMnJV9B36s/LVwYoDk39ASV3WEyHd4NLD0NJo8Lqf5url8FKqC9ODgumf3FLSfaw8/r
	yOvS0BxVAIk3rrrFzRz2nQZWsCsVmGoa/+fVCO9HvyroTUHS
X-Received: by 2002:a17:90b:5448:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3acee98db60mr7985189a91.6.1792473292926;
        Mon, 19 Oct 2026 22:14:52 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad64273f6csm1843353a91.15.2026.10.19.22.14.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 22:14:52 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_hid: avoid copy_from_user() under get_report_spinlock
Date: Tue, 20 Oct 2026 15:14:46 +1000
Message-ID: <20261020051446.92179-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

f_hidg_get_report() copies the userspace report into a freshly allocated
'entry' before taking get_report_spinlock.  When the report id is already
present in the list it then copies the same userspace buffer a second
time into the existing entry, this time while holding get_report_spinlock
(acquired with spin_lock_irqsave()):

	spin_lock_irqsave(&hidg->get_report_spinlock, flags);
	ptr = f_hidg_search_for_report(hidg, report_id);
	if (ptr) {
		if (copy_from_user(&ptr->report_data, buffer,
				sizeof(struct usb_hidg_report))) {

copy_from_user() may fault and sleep, which is not allowed while holding
a spinlock with interrupts disabled:

	BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
	in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 3481, name: hidg_getreport
	 __might_fault+0x4d/0x60
	 f_hidg_get_report+0x155/0x310
	 f_hidg_ioctl+0xbd/0xe0
	 __x64_sys_ioctl+0x120/0x170
	 do_syscall_64+0xf9/0x540

This is reached by issuing GADGET_HID_WRITE_GET_REPORT twice for the same
report id (the first call inserts the entry, the second takes the update
path).  On a non-debug kernel a userspace buffer crafted to fault (e.g.
via userfaultfd) would sleep with the spinlock held and interrupts
disabled.

The data has already been copied into 'entry' before the lock is taken,
so reuse it instead of copying from userspace again under the lock.  This
also drops a redundant second read of the user buffer.

Fixes: a139c98f760e ("USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 3c6b43d..520892b 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -668,13 +668,7 @@ static int f_hidg_get_report(struct file *file, struct usb_hidg_report __user *b
 
 	if (ptr) {
 		/* Report already exists in list - update it */
-		if (copy_from_user(&ptr->report_data, buffer,
-				sizeof(struct usb_hidg_report))) {
-			spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
-			ERROR(cdev, "copy_from_user error\n");
-			kfree(entry);
-			return -EINVAL;
-		}
+		ptr->report_data = entry->report_data;
 		kfree(entry);
 	} else {
 		/* Report does not exist in list - add it */
-- 
2.43.0

