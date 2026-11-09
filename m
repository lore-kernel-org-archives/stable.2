Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227018;
	b=CJAou1qTPSp4YXOPhLKM4J7QrcKX71rYq08jMYN7sBWQon6gyKqyFurg78khBSub0TGy
	 kVaXweDHDadLtIN2E9w3W/ZHCfZaI3SUJiHb70B2kUBml8Q+yzCaaRY5U/KQkYfYP/vd0
	 uqlnDysM42rJNGlvBQmujv1In4p+DRCqDZN7CdCAJWR3RRn9G9U0N5Pg31XCGKQpNsfEC
	 CgXeL9i2lEmw6SK3OOVfjvfoyhbcnnLprXpcYTeoMO3r8YDU0FFcr5rDSzgu+W8FN3iW/
	 8/ZLIgYc/NifAp7+dR+LabHzSXT+yfFaN4Ojm/GAnltpug0b5GTQobPinyPE2RxsxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1vcgV08xYKH0g5nt/nWVsU3QDB7VewTUh+uDf63N1EY=;
	b=rQz9z8U0DtAzZJ9u7yUzBisMXYMAvy19KSzRx9HW1+nkvup/g1iri4p53n8eF+ivdhA1
	 vSxSReqAgN2gctkf2ew4NMI8PmKdaMuedR9sJ0dKxq+8vBi8XYPDd7RJbrs38uvTtNa6h
	 oHmQkGN9owSMDyTUOqGECRPr/XKQKck6QQJ+RhTwJAl5v9m9N0qKH1ywx0Z5Uno9hSz55
	 DQc4zltci3lryqQYCDLekcOROfgvPkhY36E7vVkobbF2SzXEpTBBJ39H1jv5chpu21yay
	 9ded4vdU/UeoYQkm2vnabqYHgHSXW1ckQWO6wwb2V/s/6b2a44JfUt/GumbgoIRsHJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HMtX0kqP;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAE606EE95
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46AAE606EE95
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HMtX0kqP
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdd4dafdce9so253206a12.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794227016; x=1794831816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1vcgV08xYKH0g5nt/nWVsU3QDB7VewTUh+uDf63N1EY=;
        b=HMtX0kqPqMoObLm9xbSY5r+aq9P0sgd+ui3pyyjnbdQ1j9/nRh1x+eDWY3EToJih0K
         BiFAvv02SNpv1Wp764o8vLlkwQwXNRmkdj5qj2fOTgFJPV86UIkD98sCBYAN17vmfxDX
         pXBde7BbgysjYt/JYSKHegqG9MkBlQpB/KqtSpo4U6UQYLK13KaIf/Oa23XjzrZQSG5r
         N0jyAPJnOpBX1ZwugQAdgnEKKDLMoawu16dsMlnyUotTErp2d65cXj9f1AAAhh0ghpOO
         ocrjKFoajYJymt8iIo9UDvXjzx2dWgW0b2uFebTukhI5PShE7LAtlLqCD0g2fTfJSOlm
         nNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227016; x=1794831816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1vcgV08xYKH0g5nt/nWVsU3QDB7VewTUh+uDf63N1EY=;
        b=ng0h3e1KTgs066rynsw3qotgPDe3iFZ0/GpnwCmYx06XJHvj9eel7lD1lJO3jho2c4
         3q8lEQ2Lk1swbI+R8RetxpGApwAWLfPeSw8jsUnt36DWCWLHcaUaBur8v7j8jre7FGUM
         rWnPN/FHhgfHO7pUuQkYo7hLCL1HUtYeNO1Pt/YnjuyxT8NRSJLHiQKE3MybKFAoBAKZ
         55tI+QLTLdc8d9G6fRFjzueFxwxDE1sRs+8hJ4DDBtBLWtAiQs5AwWN7Db8U9l3GnUEA
         b39P9s2Zqls904L9nMUdt7YUEF9jtojUg4dat8ETPd5199rn1cicRxg6c7LLjEY3eeGh
         jCSg==
X-Forwarded-Encrypted: i=1; AL+hErHXg5UKpRatWFQAgNpWXxl5Q5xLqbKoNCJejVkKUIHOlA1P5eIcOJHznh4vaSKVa3gIi77FrV4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZMuPq1P1i/WUBmmDk3e/da/ZKD+wB8727cDz0T76hV9axvCpI
	qZO4aQSlCGeqBs1/vkgIEbJYzD0NEmHAaqTjh8cnzV8Tqy4ISo7OqlXJRSFpOMx1J20=
X-Gm-Gg: AYBFou0c1Em0Gk98diPBNXfd8fHuR5Zrde2UTAJ25NFcDihhOTx2YuwqXmt8DbOxxVi
	DUXgP3Tq4ptrbB89capPL9iJGTbg4Qk8+MiZ37BB5OXsH/4on0MlefBPEa6uuDDdxeuqjyHSahH
	nHgiqS6TeKR58VPzBenuE4JLF7nLg31anINWc1nH0EDHELWFhR7xUvSy0IgCBEN9bogQx1FgFfI
	QLwbNTE9kZmotAmRMLNB7BoYib2UhFNMioXI9dVfYcOMBpNFuhHX5VOxdNFXckPqHxNAMWa7pV7
	SJYUkEN+oJ1OxXjiGWEx15cJUAdITnWxHqFSAfoeOs0pur98isnUwy8NLlrySeIH+0I/pi8/36L
	Jwsu2D9tYa05ZDOo7KZZudVatZyV5s/ZPSBVA35BtS9xXgoOdiNAvhTU3IbIMBd2X4+G5ovdYOF
	+BCdf8hqv0CI7BtLTRb6hOd5ixNvOBVa13cwpEMhltOASCTdXReUWtPu8bsbjkLDAvJngIh+JgA
	llmBD/oQoCOF0WfFiP4w87M4NVILK4XNmHi8czEgELsvYnA9Q6t4N3bQ6svM0ijN9O1o2uslEXP
	zzNhYV6Sle8NHb/DkESTrwYQdyOYC3R5FpTowr80KELLWd3EmhHbV/pytKcDcSMQPDvLJtqiywQ
	1+kO3eU6e+j8lRmwlZvZPPj23+JciHst8D+f4Tg==
X-Received: by 2002:a17:90b:5285:b0:3ac:7c52:fb04 with SMTP id 98e67ed59e1d1-3b12d43b32dmr3413278a91.44.1794227016472;
        Mon, 09 Nov 2026 04:23:36 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:3d70:1891:1a66:b169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127912d62sm6836905a91.11.2026.11.09.04.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:23:36 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jgross@suse.com,
	sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com,
	boris.ostrovsky@oracle.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] xen/pvcalls: unwind pvcalls_new_active_socket() step by step
Date: Mon,  9 Nov 2026 21:23:23 +0900
Message-ID: <20261109122324.30134-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109122324.30134-1-yhlee@isslab.korea.ac.kr>
References: <20261109122324.30134-1-yhlee@isslab.korea.ac.kr>
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

Every error path in pvcalls_new_active_socket() jumps to one shared label
that does list_del(&map->list) and then hands map to
pvcalls_back_release_active().  But map comes from kzalloc() and its
list_head is only published at the very end of the function, after the last
of those jumps:

	down(&fedata->socket_lock);
	list_add_tail(&map->list, &fedata->socket_mappings);
	up(&fedata->socket_lock);

so on the error path map->list is still {NULL, NULL} and __list_del()
writes through a NULL pointer.

A frontend gets there with one value it owns: the ring_order field of the
page it granted.  Anything above MAX_RING_ORDER takes the second goto, and
nothing else in the function has run by then.

The result is an oops in whichever context handled the request - the
pvcalls-back threaded IRQ handler for PVCALLS_CONNECT, mappass->wq for
PVCALLS_ACCEPT - and because it happens after down(&fedata->socket_lock)
that semaphore is never released, so every later operation on the frontend
blocks on it and the backend never completes backend_disconnect().  (With
CONFIG_DEBUG_LIST the list_del() only reports and returns, and
pvcalls_back_release_active() then runs on a map whose irq is still 0 and
whose bytes, ioworker.wq and saved_data_ready are all NULL.)

A frontend asking for ring_order 5, on a dom0 built with KASAN
(the request was issued by a test-only change to the frontend):

[  133.728877] pvcalls_new_active_socket frontend requested ring_order 5, which is > MAX (4)
[  133.732868] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
[  133.737910] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[  133.741666] CPU: 0 UID: 0 PID: 133 Comm: irq/39-pvcalls- Not tainted 7.3.0-kCTLblk2-15482-g21a7f44fd076-dirty #1 PREEMPT(full)
[  133.746986] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  133.751512] RIP: 0010:pvcalls_new_active_socket+0x821/0xb90
[  133.754237] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f6 01 00 00 48 8d 79 08 4c 8b 6b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 14 02 00 00 4c 89 ea 4c 89 69 08 48 b8 00 00 00
[  133.763126] RSP: 0018:ffffc900004afb38 EFLAGS: 00010202
[  133.765861] RAX: dffffc0000000000 RBX: ffff88810886c900 RCX: 0000000000000000
[  133.769348] RDX: 0000000000000001 RSI: 0000000000000246 RDI: 0000000000000008
[  133.772787] RBP: 1ffff92000095f6b R08: 0000000000000001 R09: fffff52000095f58
[  133.776260] R10: 0000000000000003 R11: ffff888100077320 R12: ffff88810858b410
[  133.779823] R13: 0000000000000000 R14: ffff88810858b460 R15: ffff88810858b400
[  133.783382] FS:  0000000000000000(0000) GS:ffff8881b034c000(0000) knlGS:0000000000000000
[  133.787351] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  133.790308] CR2: 00000000006042c0 CR3: 0000000108400001 CR4: 0000000000770ef0
[  133.793822] PKRU: 55555554
[  133.795347] Call Trace:
[  133.796778]  <TASK>
[  133.798082]  ? __pfx_pvcalls_new_active_socket+0x10/0x10
[  133.800801]  ? security_socket_post_create+0x4d/0x60
[  133.803275]  ? release_sock+0x1a/0x1d0
[  133.805182]  pvcalls_back_event+0x1b09/0x23e0
[  133.807431]  ? __pfx_pvcalls_back_event+0x10/0x10
[  133.809814]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  133.812251]  ? __pfx_pvcalls_back_event+0x10/0x10
[  133.814554]  irq_thread_fn+0x86/0x150
[  133.816468]  irq_thread+0x2da/0x580
[  133.818363]  ? __pfx_irq_thread_fn+0x10/0x10
[  133.820586]  ? __pfx_irq_thread+0x10/0x10
[  133.822670]  ? __kthread_parkme+0x88/0x170
[  133.824803]  ? __pfx_irq_thread+0x10/0x10
[  133.827153]  ? __pfx_irq_thread+0x10/0x10
[  133.829304]  kthread+0x2c8/0x3b0
[  133.831176]  ? recalc_sigpending+0x15c/0x1e0
[  133.833570]  ? __pfx_kthread+0x10/0x10
[  133.835572]  ret_from_fork+0x373/0x5b0
[  133.837581]  ? __pfx_ret_from_fork+0x10/0x10
[  133.839978]  ? __switch_to+0x3c4/0xb40
[  133.841984]  ? __pfx_kthread+0x10/0x10
[  133.843970]  ret_from_fork_asm+0x1a/0x30
[  133.846031]  </TASK>
[  133.847420] Modules linked in:
[  133.849240] ---[ end trace 0000000000000000 ]---

Give each failure its own label, so that only resources that were actually
acquired are released and the list the map was never added to is left
alone.  The map is not published anywhere at that point, so the error path
needs no socket_lock at all.  sock_release() stays in the callee on every
error path, the way
commit 8fafac202d18 ("xen/pvcalls-back: fix double frees with pvcalls_new_active_socket()")
arranged it.

Fixes: 5db4d286a8ef ("xen/pvcalls: implement connect command")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/xen/pvcalls-back.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index ba62651a7f338b..dcefa91a40cd05 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -337,7 +337,7 @@ static struct sock_mapping *pvcalls_new_active_socket(
 
 	ret = xenbus_map_ring_valloc(fedata->dev, &ref, 1, &page);
 	if (ret < 0)
-		goto out;
+		goto out_map;
 	map->ring = page;
 	map->ring_order = map->ring->ring_order;
 	/* first read the order, then map the data ring */
@@ -345,19 +345,19 @@ static struct sock_mapping *pvcalls_new_active_socket(
 	if (map->ring_order > MAX_RING_ORDER) {
 		pr_warn("%s frontend requested ring_order %u, which is > MAX (%u)\n",
 				__func__, map->ring_order, MAX_RING_ORDER);
-		goto out;
+		goto out_unmap_ring;
 	}
 	ret = xenbus_map_ring_valloc(fedata->dev, map->ring->ref,
 				     (1 << map->ring_order), &page);
 	if (ret < 0)
-		goto out;
+		goto out_unmap_ring;
 	map->bytes = page;
 
 	ret = bind_interdomain_evtchn_to_irqhandler_lateeoi(
 			fedata->dev, evtchn,
 			pvcalls_back_conn_event, 0, "pvcalls-backend", map);
 	if (ret < 0)
-		goto out;
+		goto out_unmap_bytes;
 	map->irq = ret;
 
 	map->data.in = map->bytes;
@@ -365,7 +365,7 @@ static struct sock_mapping *pvcalls_new_active_socket(
 
 	map->ioworker.wq = alloc_ordered_workqueue("pvcalls_io", 0);
 	if (!map->ioworker.wq)
-		goto out;
+		goto out_unbind;
 	atomic_set(&map->io, 1);
 	INIT_WORK(&map->ioworker.register_work,	pvcalls_back_ioworker);
 
@@ -381,11 +381,16 @@ static struct sock_mapping *pvcalls_new_active_socket(
 	write_unlock_bh(&map->sock->sk->sk_callback_lock);
 
 	return map;
-out:
-	down(&fedata->socket_lock);
-	list_del(&map->list);
-	pvcalls_back_release_active(fedata->dev, fedata, map);
-	up(&fedata->socket_lock);
+
+out_unbind:
+	unbind_from_irqhandler(map->irq, map);
+out_unmap_bytes:
+	xenbus_unmap_ring_vfree(fedata->dev, map->bytes);
+out_unmap_ring:
+	xenbus_unmap_ring_vfree(fedata->dev, (void *)map->ring);
+out_map:
+	sock_release(sock);
+	kfree(map);
 	return NULL;
 }
 
-- 
2.43.0

