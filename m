Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA578248B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.150.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641461; cv=none; b=ZheVovn9NNjJJm9miw/X79AHbyZ6LAIx163Z7PXJmtFDtgIR1LQOm2wJioxLWs7ebm1flHjpMYIaZU9DpZm6D0H8pNEg0eFcI7nbJMoEbtymUu1Tkek60lB3DhowwWNZ+/sFD1ypUfUSCuCGvPzTp0gLfm8UaEWCaddWFTaYhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641461; c=relaxed/simple;
	bh=Sc6B/LNjsW2P4eo1apjanbcfJFhHR1I9fnaSFJ77sbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gu/nH9dyso6LgZydKvVERx61TOpePjjE26jD1ui9Nr88KT6m8wWVOych8cg9/ByIGtI0Q591qzt+hMDYayGxFHjd/kaelCUmquSzCjIgBQNpQJhAmXVMhlzUZ3qf+J59JuZRrvxME+mCSXXn1dNvnyGht94D/s5Zt3jXSBpaxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=poJoXiiP; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=L+CpYa3J; arc=none smtp.client-ip=148.163.150.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="poJoXiiP";
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="L+CpYa3J"
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SLfNL4294214
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=Y5kiEK+5yijCN+GrhEmUOii6QxUi1ESRYSOq
	TD/Fb60=; b=poJoXiiPqy+J/el0cYDyqK8Ze2Cum7LNM4/g7VG7bXAp0Yr1hxi7
	c8D8EncRNEIusvz2X23KFc7NGNgCIQX+zvlC5WKZaqvI3tbva7GlsncBz/ea9L7Q
	UBt2Sh99RRdhPsoSfyRACCSh8be0r8wLHbcB2DCTK8tXrE1OwKGSVLkf31URCxH4
	wCkZ6ewkaR1IITHFKnmEd8szTbfrnGIZM0hnV5dTGEzWwODX1z1LmU7TmqPm/dxQ
	NtXj5025iY+gFtD37sQ8IyV+IEnb+au6vInEdI9KDzst00rVs2C8g1mceBlUYn1H
	imi+EZb9P+cucHiKg6iTDP9BCSV8T3hM0Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4h00ccsvbq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:19:20 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so773559185a.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1790641159; x=1791245959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5kiEK+5yijCN+GrhEmUOii6QxUi1ESRYSOqTD/Fb60=;
        b=L+CpYa3JiDfksyp6gdoHqeA53Y6qqWGZ0ciHegEmuLi1wbyUcONEv3urexHEPBn8jU
         h4O5bp9e3a9JYwsxLTc+vFPvD2eOK0ylf3QBAVj3lOvk6u2I88izMrHzq/T0pGiT3Jhz
         DvvhP834LLUDVefhxxSkX3u8cRRebhfdQYp+yix9yYXLv3moHMTfjf1PJUXHbHi+DOjQ
         tdeP95Z0OP9d2Cb+wV4cBw2tqB/KYH8+mVlVeg5vPoYqu5H5kSetmldMZFSCiBreOIkZ
         CMDfS1Fs/aJouhlEX/MMNMcLwMiaRYRhheRwNQqo3tg482Ia+nFycEVWRyT1nkmfU6aW
         TMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790641159; x=1791245959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5kiEK+5yijCN+GrhEmUOii6QxUi1ESRYSOqTD/Fb60=;
        b=onvmA4/JG48I95bRC/ApIxVqOMg3Oc45msgyFlBwCcABruVzrQg1bUcRwiF+gEm241
         42kOgRguI40FFctK1ViyKKtlKFrl2JPCOWx/bt/Ih/fSRjIjvWDaJf5gyo6sjhL1AwZc
         WxvQM33+kSYSuX2GdQymkmCdK3OG13RCe+0Soy9a+VlYBhiUH4Cvwg4F5m0eXdJMW1pZ
         ZrxeEXFsegOna7IGtrYEq3kWMpz1iK2x/Jw8idKcA8latri42yLbhHWmeG3njJGx2zEz
         Y+L+Poo+uWIdmkmrWfblFXhAVKHNxN4fnDDl3txYe4FKPofuggJDdwoXjMLoO2kZAXh7
         0UAg==
X-Forwarded-Encrypted: i=1; AKwUvBwhxkBtVMs4nGlKBwvcb9qe9QSZt5PLWnB6gNx2A0byYwKsua+FRFrnVnCKboJbR/ejFQXrqqc=@vger.kernel.org
X-Gm-Message-State: AFuF++lne8kHLvb472Ea9ELSRU2TOWafKJl6vdfiJ/bThiq7TYkMp0Nm
	PTH+Js5aVdcm4hYl+m1ve30F/5oIA0hAzCsfvAzqOU0T8OSBCfzcl8+F3WQx+9ANZK9bJ+WuWki
	nkOkaglm9smyH+VxZ8qbl7MwoS2TKFSEmZEA0Eliuj8wJmZDROcyPRGc=
X-Gm-Gg: AYBFou2iEodPMOmLLUor/8SZj6NtTd+JOYY1q9F5k5/HRhf/zMsgUDY14Qm9YmC048A
	lezxiDTSWErQv8H2Dx9y7Ibgx5nQvRFZwuK9TUgMyAkkX/H5PgQwPpws2RjxIPhKK2UI50q2PHT
	mWu3fJM3Gq2EnpMHoGIQUFpIqr4L9K2ZW7UKepkqQy0RB+e9KE5tZ2zLbG9LxjuuwKfTloTeZiB
	rJg6VqA1C76WbH2aPNWQQ50UOnnVPmoO1E4s02DFDhcJ+PHNlIekZUAoYG27nLWEKPjFyf1bRD9
	dzpcXIY7n98y/ltJHZyyuPy1y2/+gcJEXzBY25RKpVL8MGOG9d2Il6fWYKKfd7dW9gCSt7B8exP
	XgRriXZaRe1nVLQgK4+aRJunSMGtlNCnbRac=
X-Received: by 2002:a05:620a:6c0d:b0:939:de6c:cb45 with SMTP id af79cd13be357-93c43d159a1mr2514690185a.47.1790641159284;
        Mon, 28 Sep 2026 17:19:19 -0700 (PDT)
X-Received: by 2002:a05:620a:6c0d:b0:939:de6c:cb45 with SMTP id af79cd13be357-93c43d159a1mr2514686685a.47.1790641158775;
        Mon, 28 Sep 2026 17:19:18 -0700 (PDT)
Received: from jerrythepro.nyu.edu (216-165-95-162.natpool.nyu.edu. [216.165.95.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813fee09sm270338085a.24.2026.09.28.17.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 17:19:18 -0700 (PDT)
From: kj2864@nyu.edu
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+6a04efcebe0fc0ce@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH] media: em28xx: fix double free in em28xx_alloc_urbs
Date: Mon, 28 Sep 2026 20:19:04 -0400
Message-ID: <20260929001903.158767-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAwMCBTYWx0ZWRfX6DSye0tm/Ej4
 YiB5KOM5WhHL3zAQu3rbJ9y4rTc7EAbARCaBTql06WoeoKRPRA0nFK4iuQVCTVu+UB0A71LSvTX
 BTs/MIfdhaozNYXRZDw48w4nrZP3RjE=
X-Proofpoint-GUID: d-8DCnzJqEOXlBosuZyfPGeJOEIRnId-
X-Proofpoint-ORIG-GUID: d-8DCnzJqEOXlBosuZyfPGeJOEIRnId-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAwMCBTYWx0ZWRfX6nAAgw3vElJ4
 HpbxUaMZ/i+9/fEnzQJlYMFONSaFcV+P3C66R+xB6vtUbpLhfMrj3Ja7eaZjPQCl163MSPr9fcK
 BepYI92pGV34Rr26UaXpxxZEC94pEejBae3m1PHLRy/al+qAYLUTpaAIU3H6rcgLJpq+w4Zx89X
 glUdVsVf99pcLHVsJM2GXkq52GU2x1zIJNFGPQq/I2xGM/sm8ZwC3F4CX3qQmMpG4R8eda5L4UJ
 vqv7yWTUriynQRBdTAJXvLx5PHL9kzuX9P/YfuEtyh0mERlbwI08FWveS181JUGYi93pGE1v55Y
 odFvwvCgKOrvmsCDROvALQkfR18CGZo9etEMtCy81rs7zPU1kQFkOKWd8cRNn4+DoZPVrheQkZV
 gNzBB1CWvVosf6rf2Hf+8rH9R9fSxZ3SjWp414rVqUHLj3IZRXMeAwR7VqPBnTYwfWB2fzGw0TT
 tWG31C+EsXTy7xucLQQ==
X-Authority-Analysis: v=2.4 cv=OcUNnRTY c=1 sm=1 tr=0 ts=6abb0408 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=QttKoHjxDjZciDcJ6FphuQ==:17
 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22
 a=VwQbUJbxAAAA:8 a=kj-zqgMp3CcBJFKlVqoA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Orig-IP: 209.85.222.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290000

From: Kaho Jiang <kj2864@nyu.edu>

When allocation of usb_bufs->buf[i] fails, em28xx_alloc_urbs()
explicitly frees all items within usb_bufs->buf before calling
em28xx_uninit_usb_xfer(), which also frees these items, causing them to be
freed twice.

BUG: KASAN: double-free in usb_free_urb.part.0 (drivers/usb/core/urb.c:25 ./include/linux/kref.h:65 drivers/usb/core/urb.c:96)
Free of addr ffff88802fd37c00 by task kworker/1:2/1182
Workqueue: events request_module_async
Call Trace:
  kasan_report_invalid_free (mm/kasan/report.c:557)
  check_slab_allocation (mm/kasan/common.c:235)
  kfree (./include/linux/kasan.h:199 (discriminator 1) mm/slub.c:2693 (discriminator 1) mm/slub.c:6508 (discriminator 1) mm/slub.c:6801 (discriminator 1))
  usb_free_urb.part.0 (drivers/usb/core/urb.c:25 ./include/linux/kref.h:65 drivers/usb/core/urb.c:96)
  usb_free_urb (drivers/usb/core/urb.c:95)
  em28xx_uninit_usb_xfer (drivers/media/usb/em28xx/em28xx-core.c:964)
  em28xx_alloc_urbs (drivers/media/usb/em28xx/em28xx-core.c:1076)
  em28xx_dvb_init (drivers/media/usb/em28xx/em28xx-dvb.c:1734 drivers/media/usb/em28xx/em28xx-dvb.c:1698)
  em28xx_init_extension (drivers/media/usb/em28xx/em28xx-core.c:1248)
  request_module_async (drivers/media/usb/em28xx/em28xx-cards.c:3685)
  process_one_work (kernel/workqueue.c:3396)
  worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  Allocated by task 1182:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_save_track (mm/kasan/common.c:78)
  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
  __kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5414 mm/slub.c:5439)
  em28xx_alloc_urbs (./include/linux/slab.h:995 ./include/linux/slab.h:1312 drivers/media/usb/em28xx/em28xx-core.c:1081)
  em28xx_dvb_init (drivers/media/usb/em28xx/em28xx-dvb.c:1734 drivers/media/usb/em28xx/em28xx-dvb.c:1698)
  em28xx_init_extension (drivers/media/usb/em28xx/em28xx-core.c:1248)
  request_module_async (drivers/media/usb/em28xx/em28xx-cards.c:3685)
  process_one_work (kernel/workqueue.c:3396)
  worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  Freed by task 1182:
  kasan_save_stack (mm/kasan/common.c:57)
  kasan_save_track (mm/kasan/common.c:78)
  kasan_save_free_info (mm/kasan/generic.c:584)
  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
  kfree (./include/linux/kasan.h:235 mm/slub.c:2748 mm/slub.c:6508 mm/slub.c:6801)
  em28xx_alloc_urbs (drivers/media/usb/em28xx/em28xx-core.c:1084)
  em28xx_dvb_init (drivers/media/usb/em28xx/em28xx-dvb.c:1734 drivers/media/usb/em28xx/em28xx-dvb.c:1698)
  em28xx_init_extension (drivers/media/usb/em28xx/em28xx-core.c:1248)
  request_module_async (drivers/media/usb/em28xx/em28xx-cards.c:3685)
  process_one_work (kernel/workqueue.c:3396)
  worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

Remove the explicit cleanup loop and let em28xx_uninit_usb_xfer()
handle the cleanup.

Fixes: d571b592c6206 ("media: em28xx: don't use coherent buffer for DMA transfers")
Cc: stable@vger.kernel.org
Reported-by: co+6a04efcebe0fc0ce@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 drivers/media/usb/em28xx/em28xx-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em28xx/em28xx-core.c
index 5bbb082dbed9..86c74c55908c 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -1080,9 +1080,6 @@ int em28xx_alloc_urbs(struct em28xx *dev, enum em28xx_mode mode, int xfer_bulk,
 
 		usb_bufs->buf[i] = kzalloc(sb_size, GFP_KERNEL);
 		if (!usb_bufs->buf[i]) {
-			for (i--; i >= 0; i--)
-				kfree(usb_bufs->buf[i]);
-
 			em28xx_uninit_usb_xfer(dev, mode);
 			return -ENOMEM;
 		}
-- 
2.43.0

