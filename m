Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C3F375ACB
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205020; cv=none; b=GkjH8Wzpz2ul83TMwM0/ZTeTIPnP6WT7luog9zbUlgi+OTLLrARziUnFdJH1C9hcnfEoD5GrZ0LiW7r0ZAEln5vliUlNiIjmR7D1c1C5RV2yqXzw0dpUbCl4JmCk0kk/fywhQ9AVof5CWon74U+2U0harLKB6sgphKtuuiat1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205020; c=relaxed/simple;
	bh=HI9Ca2Fo2tkQcb4WshVMmwmxrgJVc/dv7UEoTbCUW/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7ecIapR7pfXuLsOg4LJgU02WaOixR9UH5d1O7zPn0SfKDTItbkfV7NGQgrO47u1pAOgjZHZN7Nh6yp/dY0xWUYVzfVxciDBer70XRJBktQnzkoTh2TnWBRwaYE1nxvGdoQpU065nUbYw3Y0VNUQJHdZ9zvU7b798A2o48vxk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=FE4x+P20; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="FE4x+P20"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so869523a91.2
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791205018; x=1791809818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4pdPpjclY/Qu2NFmchOm2ms5jkg4XhM0PjITCIKS9/s=;
        b=FE4x+P20FB0vWAbnKqkpUmFCRwZM18clW1RxQVNZUOzNHjj5VpqFP65/TqeIwi6/MR
         90PIQJ+DO+5ExKnTLTBdaFTp5PSiVV32C4BVQld0N7qQNI25CQQqK2rsTtek11TwES8T
         KPRLB+duK9xpnIzW8113PlV5rz/SbAphMuE/Cphsz8TcpkJtBXPcu7MupYmxJPhPzCR2
         abZSrpSSQJcTp+dVawm0DCZ2Ry4qvO422AWxv3yuexR8sBn8r44FpLbd6woleWZidGN8
         AUf2rZ2loCXV/EvPMidFZ2TDVQyam06EZJSzsPduH348nsJpjjy/JBTb+GyxNG9slPLu
         6G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791205018; x=1791809818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pdPpjclY/Qu2NFmchOm2ms5jkg4XhM0PjITCIKS9/s=;
        b=BF8jO8CdQ8LKUtkkobD6M4Oj1SyIawOVR7FD4JwU74l7RhDhrOjQx8/ND+tpPFNngQ
         RPZksBQ6YwW/5AX+Is1wUE8g3mYVJiDOqCwCUOsdng0DbyZaPklCUEeqDBwrmDRrxZOh
         h2oo2/4wqjQABlYqRvFV1qyp8QPQ7rgwkQJ3mW3urG5bt/AUaM7zyw5WRA1qSlvlY2B7
         lF60K61vy3NivLGSG/pJr9l7vGJ9L6mlTLzrtMlW4l29Wc2sxK41egBQOWVeEhkeibsi
         NxIrmm7ZKa5VYdWuqHg6bdC6sb5lCWRGhfgaNhzQpFCPalQ61NIPs7JXnAWGlw4H50g0
         0+QQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtPgnKjbjIFZ5AxNkb2B1cTc2PBpOgyNMnPoDzldGWyzs0JiVK/bAYNYDSh41RjuOes1i1GYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKCZnv53Fm1f1vZg3cEMXQMG7DqgpSS/rXQRnP7GVDx4AnoGDA
	PuF4+pFOu9ZWW6k3t15740PFo35HMsLqNlSn20YvnFBs0EwW+yTTJfGEbf0Hp8odUZ2tFkQrEPn
	fubZe
X-Gm-Gg: AYBFou2Ca0X1qggTDeRbdoHuUsMV2N40Q8yUbYvKAmQjGk821kcSeKu0FGVfeeU0xyl
	unj3kC5FESIaMhWpprR+gGkPA9WtoQSUo1Ox94qQPXHRbZwH3GjVIYESjVS8m8WlcFxwflnN+IK
	DJFIKHfNPr1hTwmiXWCTcLPpVgsi9zfN/wtTZ+nHGT2lM1fRJMzJm4w2ofpilKMvib0QINqtsJU
	0EnZkcaflWwHZpxbFbqF6X+wCh4NfQDACIQmj/iMWicQ9WANW8RrDbT/DHp9hrw8XPnenqWIDR5
	uLnWge8FCzzRZ3Vpnu5TxL3i1WnQ1AT46MfKsq6mUga/lt4OpFYIVQFq5QSdPq8g93AtWHqDwFu
	dHa08aMY+tJaokLajjky+WYkc3r/joK4NXoaPqIJAYDPgPSsfqWQeY75xqI60XFAN2SX+tW0c2n
	0HW4+IePhKh4VkNzz7I/cnYsZDK0+nPrAc+I5HqZn1Qr1Qnom6RL/aFliTcaf5n109Gn78NbTcf
	j6Cg/CIEcIJdTif1IsSWA==
X-Received: by 2002:a17:90b:35c8:b0:3a8:2046:7e5f with SMTP id 98e67ed59e1d1-3a82046834amr1284780a91.12.1791205017933;
        Mon, 05 Oct 2026 05:56:57 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:5364:bba9:2adf:d611])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6e3a7470sm761661a12.30.2026.10.05.05.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:56:57 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2] 9p/xen: validate the response size from the backend
Date: Mon,  5 Oct 2026 21:56:38 +0900
Message-ID: <20261005125640.274054-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

p9_xen_response() takes the length of an incoming response from the ring
-- the first field of the 9p header, which the Xen transport reuses as
its framing header -- and uses it to advance the consumer index, but
never checks that it is at least the header size or no larger than the
number of bytes the backend has actually produced.

A malicious or buggy backend can post a response whose size is smaller
than the header (for example 0). The consumer index then never advances,
so the response work re-reads the same ring contents instead of making
progress. In testing this raced with the teardown that the malformed
reply triggers and dereferenced a freed p9_client:

  9pfs 9pfs-0: Wrong req tag=ffff
  BUG: kernel NULL pointer dereference, address: 0000000000000060
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.2.0-rc5 #6 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
  Workqueue: events p9_xen_response
  RIP: 0010:idr_find+0x4/0x10
  RSP: 0018:ffffbf5d80063de8 EFLAGS: 00010202
  RAX: 0000000000000001 RBX: ffffa229c21195a0 RCX: ffffa229c2400000
  RDX: ffffa229c11c2200 RSI: 000000000000ffff RDI: 0000000000000050
  RBP: 000000000000ffff R08: 3fffffffffffdfff R09: ffffffffffffffff
  R10: 3fffffffffffdfff R11: ffffffff87a60e80 R12: 0000000000000050
  R13: 0000000000000000 R14: 000000000000ffff R15: 0000000000100000
  FS:  0000000000000000(0000) GS:ffffa22a7661c000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000060 CR3: 000000003ac34002 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   p9_tag_lookup+0x2b/0x90
   p9_xen_response+0x17c/0x2e0
   process_one_work+0x16a/0x3a0
   worker_thread+0x172/0x2e0
   kthread+0xdd/0x110
   ret_from_fork+0x18b/0x240
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  Modules linked in:
  CR2: 0000000000000060
  ---[ end trace 0000000000000000 ]---

Reject a response whose size is outside [sizeof(header), queued] before
using it, matching the validation the backend already applies to
incoming requests.

Fixes: f66c72bea129 ("xen/9pfs: receive responses")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: use dev_warn_ratelimited() so a backend that keeps re-triggering the
    event channel cannot flood the log.
v1: https://lore.kernel.org/all/20261005021157.207947-1-yhlee@isslab.korea.ac.kr/

 net/9p/trans_xen.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index f9fb2db7a0663..0ea8e17725c24 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -200,6 +200,14 @@ static void p9_xen_response(struct work_struct *work)
 				     masked_prod, &masked_cons,
 				     XEN_9PFS_RING_SIZE(ring));
 
+		if (h.size < sizeof(h) ||
+		    h.size > xen_9pfs_queued(prod, cons,
+					     XEN_9PFS_RING_SIZE(ring))) {
+			dev_warn_ratelimited(&priv->dev->dev,
+					     "bad response size %u from backend\n", h.size);
+			break;
+		}
+
 		req = p9_tag_lookup(priv->client, h.tag);
 		if (!req || req->status != REQ_STATUS_SENT) {
 			dev_warn(&priv->dev->dev, "Wrong req tag=%x\n", h.tag);
-- 
2.43.0

