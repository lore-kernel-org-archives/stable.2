Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792857363;
	b=TeHSQ3dBfm6uONfNVG7XdfFnNpzwZEXefnqO8h8Qk5uR4x29JpuIUoZ3qUgTs07LZuwm
	 Qq9cM/rJrcjqHHLyll7L0+trWhENhppukzd3ixM5PpEn48h8gSWgo6NBh2hhikE4YG6/Y
	 SeCC8XYZBFzAZsrYDVFVPvUn7PZQEDGRtuF0cRiLZSFNmGdAYkW1iD0F+M9vhAjHVfYN4
	 LGooS7HtX5eEEv6ReYvhKCHjjC9URQUcQcepkDGXb7FKlT9REYwqAYO6CY5w1thH25eg1
	 FCRKsmD+5yZ8DEl8UIzmKDfqGbeSwZfIR71onkGmM72YETdPqbNosKQmKgtVTWnvVYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792857363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xwpMYDYcOgRgHbSKUixXR2QDd4uBp9abfLMB5Scqs14=;
	b=t3kjUJL6bRsl6e0Ik6y2iPa0S9R9jN0yknGVvX2XjBt/JtjrNbMBTOnJjl2VpWnq04rG
	 ds6ZAQthe8ZCCDjXNDqITLBQuEZPYIHF7TuQWncglTzaOm+sQKUSDaN47Srp42slGkAdD
	 WoE4pzIt/cjv9Hq5r7vdP6jgebOnO83bCZ9Gs6sXLSrlps2+9PQYvMbqkUhbDJNiyg3BF
	 75dk67ZvkPQCc0wosu0pkqdgspv3hOXUse8Cl2iHc6jDABurlZ9QLuHnTt3/qJI9Duutf
	 rAd7KHu9i8rJaS6pR1M1weB3n/bfkZZHwuJM4be6axcxa8ksqklr4dv+/kOupuv4bnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=iIJNe01a;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FE606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 15:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 886FE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=iIJNe01a
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36661f953e4so3207486eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792857361; x=1793462161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xwpMYDYcOgRgHbSKUixXR2QDd4uBp9abfLMB5Scqs14=;
        b=iIJNe01aE7cAImpH3BDqEPFBUyCMjosDYRuFKuqUo19KbM3T325lRYH7QmpcZtH5hL
         iOlqpcMwnghpKm1YJIkZRX9Nrki2724SJhri66r4fv+c6rfgvLPH+DoQK6dVsS1VtVdg
         lfSmRzH4+2bSCgDd8VjzbCheYEXcFZFlFZlh2W8aCqbTBY+BBq5hWvEundD1xEoKU1np
         PNJvhyVMrM4PMyENq/P4Ub4fEN+KrLVWM008BZ5xHKIsVIpPBVTLqOZ7kwllBAUQ/OFU
         VlfPJzYs5lA/ndpxFjeXgj2mcs7gx45PFvk/Fqx1z+PaxHRCq4DKcDnvMQnW5KgEOAXR
         RrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792857361; x=1793462161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwpMYDYcOgRgHbSKUixXR2QDd4uBp9abfLMB5Scqs14=;
        b=x02G3TLGGK/0rY6rkgXLecWsedAHx5phuhKuwlazS+HXqN3CFj9Qksh1wuvDh9wj39
         f7QB4P94MmWB8JhLNswhyG1aH78uKyJu5iTTnl+2CzGbPBaPkhEDMT7jBgXfEIP92rUs
         pdGhDMz/wBBNvM0o7MQnbD7dzNbYV7shxLur9FZd/TgOiVGBruz2X3m9yXsWDREuf9QP
         mHSVs2Z04iYjP+wKA1ryV6793i7wAug2ZPK1SAQJFu5axOSa2s2nmIWqbaW7R4Kw52dJ
         mhYUUZnBEkZkEhwbn5fmYS/iHanU2wimbqP8pSMP5FdMhG7M+xpkWaDZabNjjGQ6Sch/
         Ra+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzPisbBjD64BSxxZ1Pfwmpj8xPdw7xSbUUg6qy9TcG36lCmrQpvEIBNDcKrkaT/Vu7z0LlWB+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/1R99fAGSKCObEVNsZy6T324uWr/sVQ71PpjqVuVBf/BD0jXk
	v24lQxXyY/W/HqIqOOyWYHkedI3ynFM8TNxsqOnVAmoJfpsiqtQn/nLUPhjGCCBfzrw=
X-Gm-Gg: AYBFou3tbdVmFSi37X8fJDGmXLp+EpIg/4XAxPm4quwR0VNnLAvQbvJmX6Kimp5HIDj
	vgGwFZRaP0vodR7qIXQEyd/SApx8510RMR2uDydRJvgwsToo2jqsMqS1GaqNvl8ScRrWE10v+sC
	WmMlFzm4/QmIIY6NaDZdwrOLEtHreWStGOMT+MjG7G0JR//V9Ny9NHHQeoymHvZUXLJe7PjIx+0
	ZxjbTcjykXdiBvEz/r+VrCpTlsKO6vdzjYNzoUgQsUFzvBK9tJlHOyHYF8ZrXdSKEKa6lKwwsY5
	JMzvV/j3pqr+Zmo/Bxa1qRo7SburDQkbUvGufgnaRQ5fiP5G+MrgtyegqjxiO9jKCVwRVSs0RVS
	fOfwEDxrV0IH4tVzGbwmUafvB/hcoxp/NhCBFNyGtSNmurBy6nUR1+5UJc5r/Q/Z6Dp+mJvjY5v
	4TkqH4Av6/iUpE5X8oDnQVEgktOaUaGel4TUriZ2F+bIzwxrSk48tEhcrvA7pisGUeyIw7y+SLl
	TFVQp4T4RSdRTaftLiD5r2AGjBWTQte+PQM7BeNjq18N92imJMF/DJc/Vk1y4dQqfirB3XUJoiG
	/tqzVoMMOuFfMhaO7VyxDt5Fs8oKrJ0YdC2WVuEyCkRl0G1EanADlosaf6RL2Tf8
X-Received: by 2002:a05:7301:a2d:b0:368:6e2a:af3b with SMTP id 5a478bee46e88-369e84ba94cmr3652224eec.16.1792857361288;
        Sat, 24 Oct 2026 08:56:01 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:dba3:be57:a674:a67f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d812d6sm8641532eec.10.2026.10.24.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:56:00 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Sean Hefty <shefty@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH] IB/cm: hold a cm_id reference across the send error callback
Date: Sun, 25 Oct 2026 00:55:07 +0900
Message-ID: <20261024155507.3418345-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
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

cm_process_send_error() lets cm_free_priv_msg() release the reference the
message held on the cm_id and then keeps using cm_id_priv, dropping
cm_id_priv->lock and calling the consumer's cm_handler() callback. If that
was the last reference, a concurrent ib_destroy_cm_id() takes the count to
zero and returns while the callback is still running, so the consumer frees
its context underneath it. For an RDMA CM consumer that context is the
rdma_id_private which _destroy_id() kfree()s once ib_destroy_cm_id() has
returned, and the callback reads it through cm_id->context before any state
check.

Reaching this needs a send that expects a response, so a REQ, REP, DREQ or
SIDR_REQ, to complete with a real error rather than a flush, and the
consumer to destroy the id while that error is being processed.

The report below comes from an out-of-tree KUnit test. The race is a few
instructions wide, so the test blocks after the spin_unlock_irq() until the
racing destroy has finished and KASAN can observe the access. The cm_kt_
frames stand in for a consumer and its destroy path, and the test is not
part of this patch.

  BUG: KASAN: slab-use-after-free in cm_kt_handler+0xaa/0xd0
  Read of size 4 at addr ffff8880029582c0 by task kunit_try_catch/39

  CPU: 0 UID: 0 PID: 39 Comm: kunit_try_catch Tainted: G                 N   7.3.0-07363-g734bef548a96-dirty #1 PREEMPT(full)
  Tainted: [N]=TEST
  Call Trace:
   <TASK>
   print_report+0xcd/0x620
   ? cm_kt_handler+0xaa/0xd0
   ? __virt_addr_valid+0x208/0x3f0
   ? cm_kt_handler+0xaa/0xd0
   kasan_report+0xfb/0x130
   ? cm_kt_handler+0xaa/0xd0
   cm_kt_handler+0xaa/0xd0
   cm_process_send_error+0x2d9/0x560
   ? __pfx_cm_process_send_error+0x10/0x10
   ? __lock_acquire+0x57d/0x24a0
   ? trace_hardirqs_on+0x17/0x100
   cm_kt_destroy_returns_during_callback+0x1e8/0x700
   ? __pfx_cm_kt_destroy_returns_during_callback+0x10/0x10
   ? kunit_try_run_case+0x1a4/0x4c0
   ? lock_release+0xc3/0x250
   ? lockdep_hardirqs_on_prepare+0xd5/0x180
   ? ktime_get_ts64+0x1e5/0x2e0
   ? trace_hardirqs_on+0x17/0x100
   ? __pfx_read_tsc+0x10/0x10
   ? ktime_get_ts64+0x242/0x2e0
   ? __init_swait_queue_head+0xca/0x150
   kunit_try_run_case+0x1ca/0x4c0
   ? __pfx_kunit_try_run_case+0x10/0x10
   ? lock_release+0xc3/0x250
   ? lockdep_hardirqs_on_prepare+0xd5/0x180
   ? _raw_spin_unlock_irqrestore+0x3f/0x50
   ? trace_hardirqs_on+0x17/0x100
   ? __pfx_kunit_try_run_case+0x10/0x10
   ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x3aa/0x550
   ? _raw_spin_unlock_irq+0x23/0x40
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x493/0x940
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x22/0xdb0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x19/0x30
   </TASK>

  Allocated by task 39:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x8f/0xa0
   __kmalloc_cache_noprof+0x201/0x4a0
   cm_kt_make_id.constprop.0+0xa0/0x470
   cm_kt_destroy_returns_during_callback+0x84/0x700
   kunit_try_run_case+0x1ca/0x4c0
   kunit_generic_run_threadfn_adapter+0x7b/0xe0
   kthread+0x3aa/0x550
   ret_from_fork+0x493/0x940
   ret_from_fork_asm+0x19/0x30

  Freed by task 40:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kfree+0x119/0x490
   cm_kt_destroyer+0x31/0x50
   kthread+0x3aa/0x550
   ret_from_fork+0x493/0x940
   ret_from_fork_asm+0x19/0x30

  The buggy address belongs to the object at ffff8880029582c0
   which belongs to the cache kmalloc-8 of size 8
  The buggy address is located 0 bytes inside of
   freed 8-byte region [ffff8880029582c0, ffff8880029582c8)

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888002958900 pfn:0x2958
  flags: 0x4000000000000200(workingset|zone=1)
  page_type: f5(slab)
  raw: 4000000000000200 ffff888001041500 ffff888001040348 ffff888001040348
  raw: ffff888002958900 0000000000800048 00000000f5000000 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888002958180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff888002958200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  >ffff888002958280: fc fc fc fc 00 fc fc fc fa fc fc fc 00 fc fc fc
                                             ^
   ffff888002958300: 02 fc fc fc 02 fc fc fc 02 fc fc fc 02 fc fc fc
   ffff888002958380: 02 fc fc fc 02 fc fc fc 02 fc fc fc 02 fc fc fc

This reference used to be released after the callback, which kept the cm_id
alive for its duration. Restore that ordering and drop it on every return
path.

Fixes: c1cf6d9f743aa ("IB/cm: Call the correct message free functions in cm_send_handler()")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/core/cm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1a2c2775b14d5..67efb70ba58d1 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3768,6 +3768,13 @@ static void cm_process_send_error(struct cm_id_private *cm_id_priv,
 		cm_deref_id(cm_id_priv);
 		return;
 	}
+
+	/*
+	 * cm_free_priv_msg() drops the reference the message held, so hold one
+	 * across the callback below or a concurrent ib_destroy_cm_id() can free
+	 * the id underneath it.
+	 */
+	refcount_inc(&cm_id_priv->refcount);
 	cm_free_priv_msg(msg);
 
 	if (state != cm_id_priv->id.state || wc_status == IB_WC_SUCCESS ||
@@ -3802,11 +3809,13 @@ static void cm_process_send_error(struct cm_id_private *cm_id_priv,
 
 	/* No other events can occur on the cm_id at this point. */
 	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, &cm_event);
+	cm_deref_id(cm_id_priv);
 	if (ret)
 		ib_destroy_cm_id(&cm_id_priv->id);
 	return;
 out_unlock:
 	spin_unlock_irq(&cm_id_priv->lock);
+	cm_deref_id(cm_id_priv);
 }
 
 static void cm_send_handler(struct ib_mad_agent *mad_agent,
-- 
2.43.0

