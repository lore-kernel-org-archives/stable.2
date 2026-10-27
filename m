Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103303;
	b=PQIRI5R2zMrvLNZsoEYzqC+22ydwhfVmAV1MVV1gHoIEsEekhdJzToB59x+KAhH7+Obe
	 +qVy/F1aWpVHMknD3K99IJjp04g1+U30n8b5Co08xO+6MUtz/zOdIfZhhltAgJBTPAa2j
	 BvwCvlvvEvjEz2I6Rje4rrY1a/5MqrIN4WvFsGo9O+eBjeWZFjd9HpnEq4kKbS67R2nP6
	 Uemgqnyk/7s/vMgGjes66af/A5pkQ9gzVvzvSOr6sLy66dp549SHTB9GebpuLVo4HagYq
	 jTULgKHFV3u8Pa10mQTol9hvbmVeGlpvHwD/tSeDyMGl+TZ9ZVDnGJc4mTiyiQO/39A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1s6Zqp4u3sfnKK/Y6nM0BOKcsidnRWEc87L5yFDAZSw=;
	b=fbAnq9h42Ic67e0fL4rF48aEN5+dJyKA5S5TW9Qf27GfEuVXwWzGcGUhQr8FD/QwYAB3
	 AU7Xd6KzrqXzK5UWAZWOfatW5Dc0Uk8JqeC1b5xzqmVWQ5nhxGGS70THxgG+AI233OZWs
	 MwVrf5daULz8uJoG6WsnhW5vOLAmzi1bmoBRv3W5aEQR7RfrmOcd3ROA4CaMe4gM+iExA
	 UmkrGJnU2cayTM6VMEzZuAPkjysD9SyCqrz6OjUKYhN/rGB+OOFhAFwecEbMUeZEBHdbl
	 Tw7fTgvgc9OrDN+4Qv+YqAtDrlypPGfpQD9hczMqle5+t3hiyh/PiLXNnFSCyeavCBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=C0vzaMxq;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E360A5BE1
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A3E360A5BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=C0vzaMxq
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3acc96a256dso2287479a91.3
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1793103301; x=1793708101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1s6Zqp4u3sfnKK/Y6nM0BOKcsidnRWEc87L5yFDAZSw=;
        b=C0vzaMxqxSK8fpj2syJ2HgC1sW12ay+XWjFPSmUtvO4vNbQ1bfEjzqmrjbJrnNUNlF
         2MQrzc7f0t72RrGTgF7k/r8p0fXopt2zqnO5OJh3GAnrwt0ibhyvtQLxhN8N04NiUXL8
         Czrxzc8wAH2aDHVy9h0PVyB1noGwjb98h2VSxShOQCx2GguRe6Vvh7SDSwzjj09nXjbH
         KQf8sQu8Dbt7mt3dvKV7mw1mUCF1u/pYFqjaqVwT+Sc/owBNU4lxoTVJHBi3VIFkz3BB
         GpYnwIz3rUfjkM3tenLX52w+Imes08nJ+QWj9py/2M3dx6m018ootzc33D4fwDVVFbNA
         jOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103301; x=1793708101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1s6Zqp4u3sfnKK/Y6nM0BOKcsidnRWEc87L5yFDAZSw=;
        b=MkDDEGPPdWjzY7LFVerygBXWj4z9skG2LhmYVnu/vSm6gL0BzpQJ+yk30GRoGY5C9p
         5k5CbhhOdyhkgNr1acRhy349OBSpc0BNFqCL04D1fs8kh3beNNFunBssH3/RL6Cp+I+R
         VRuFfs6lhBRBYNN9O+tVhj/oHS/2oYbzaOW3ygrULsL3akyZZNZGTr4Umben2JZqBX4I
         Q74M9G7dVF6ad/layuyNoUUk+rC1vgb1eNljPBrpAh19HtH6b26QNBh/zn9wWQ+yfUqu
         o2ZO11MBbK27KKYXy+YCDeFT4azH1qqZ6eHlTWvnEO9KXIs/cY7ZjPFVEVW3MY+0mspg
         lLOA==
X-Forwarded-Encrypted: i=1; AKwUvBxlr1EOgrzrYCot+9Tg8XcUoBKKOlk5tLX0z1Wv5hp0BmY/MHFFaoHYr0t+gGefhlXxmi3+xN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJs2XDSHULceGS9zMk0VTeBYGr9F6zw+AfJmFf6PHYDdLvQ8Za
	tcbreep7OPSL+W8+m5PNErIejr3/eTxmVkml/lTkpttJ7bFNsgGyEXLIsiOF02/XXG0=
X-Gm-Gg: AYBFou1k6xb5JMMG4nN3E4l25JwHi/rIoHZxy/tJ48LHSKThbKuPjaz0s40uOv6/DYW
	VQf34f6oSDg9OOvgx2emT7bWXhWcK10VVXYNXpprhZJPuKjhOtHimnCnPZkoY/gCR1HidKER8bs
	C5c6rv68bm9FsdbPZLSKPc2D0Cx0yK//H1PP3ZkaFoOaH/pIR2EBkG3KSgCh7tihuA1WVYSdfjT
	mGL7Bgp1uJcQ6iOFsrjlEzUecjNFKM3gATqoUHakQkk6YMFMhgbRxz80myngYW2kByt1jKha5J/
	QNijTRIbvyu7hA0GPXnsWmrSz5nBAnqTzyD6Yo3PCyOvpC7Az8Tt/SOx7vS0FAsmUJE8kXe1T8G
	PEHkTZaPcG2EyHnu1Ahk+iHL4FmJbLzHn1bFctp3ne6R0hbd5g/3/WDhACf/Lj2ysi2RD4IH9S/
	yiJ3Nz+0STGgQmMDNrfOaMiYWuuf1gkGBcQiy6PpaL+GjTMqL73Q4miYnM62pTMkpEYWPUr2arr
	G+lLdFKWVI5YLBHGvgU+OHZW7tiR3eNlKEnbUY9uUQel0/gOOeIKL/bRVvMmNrrN0hr3tGu67E6
	R6RvXK/7+VgyJQi3f9bU7JMPl9MFWXGVhb3O9zFaal5dmEx3OzovHKnBQwB7Y8MlkA==
X-Received: by 2002:a17:90b:2542:b0:3ac:adce:60a8 with SMTP id 98e67ed59e1d1-3ade9b2cf27mr7977855a91.5.1793103301318;
        Tue, 27 Oct 2026 05:15:01 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:df24:cbdb:a2dc:d464])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cc9073c2sm2915176a12.0.2026.10.27.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:15:00 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH] xen-netback: wait for RCU readers before freeing queues on error
Date: Tue, 27 Oct 2026 21:14:38 +0900
Message-ID: <20261027121438.1266207-1-yhlee@isslab.korea.ac.kr>
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

The connect() error path frees vif->queues without first waiting for
RCU readers, unlike backend_disconnect() which publishes num_queues = 0,
calls synchronize_net() and only then frees the array.

The net device is registered in xenvif_alloc() during probe, so it is
already live when connect() runs. xenvif_get_stats64() and
xenvif_get_ethtool_stats() read it through the usual stats paths, taking
rcu_read_lock(), sampling num_queues with READ_ONCE() and then
dereferencing vif->queues[i].

A guest can drive connect() into the error path by handing the backend a
bad ring reference or event channel for one of its queues, which makes
connect_data_rings() fail and connect() jump to err: with num_queues
still counting the queues already set up. The error path calls
vfree(vif->queues) without a preceding synchronize_net(), so a reader
that has already sampled a non-zero num_queues and loaded the vif->queues
pointer goes on to dereference the freed vmalloc array.

KASAN catches the read of the freed queue array in xenvif_get_stats()
while a guest repeatedly forces the error path and dom0 reads
/proc/net/dev. Generic KASAN labels a freed vmalloc region
vmalloc-out-of-bounds, since the use-after-free label is reserved for
slab and page objects:

  [  160.524029] ==================================================================
  [  160.527557] BUG: KASAN: vmalloc-out-of-bounds in xenvif_get_stats+0x28f/0x390
  [  160.530848] Read of size 8 at addr ffffc90005de06a8 by task cat/10519
  [  160.533831]
  [  160.534844] CPU: 1 UID: 0 PID: 10519 Comm: cat Not tainted 7.3.0-kCTLwide2-15482-g21a7f44fd076-dirty #2 PREEMPT(full)
  [  160.534849] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  [  160.534855] Call Trace:
  [  160.534868]  <TASK>
  [  160.534870]  dump_stack_lvl+0x64/0x80
  [  160.534885]  print_report+0xd0/0x630
  [  160.534918]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  [  160.534933]  ? xenvif_get_stats+0x28f/0x390
  [  160.534938]  kasan_report+0xce/0x100
  [  160.534943]  ? xenvif_get_stats+0x28f/0x390
  [  160.534947]  xenvif_get_stats+0x28f/0x390
  [  160.534952]  dev_get_stats+0x2db/0xb50
  [  160.534961]  ? dev_seq_printf_stats+0x446/0x7b0
  [  160.534979]  dev_seq_printf_stats+0x9e/0x7b0
  [  160.534982]  ? __pfx_dev_seq_printf_stats+0x10/0x10
  [  160.534987]  ? dev_seq_next+0xe0/0x1b0
  [  160.534990]  ? __pfx_dev_seq_next+0x10/0x10
  [  160.534993]  ? __asan_memcpy+0x3c/0x60
  [  160.534997]  dev_seq_show+0xf/0x30
  [  160.535000]  seq_read_iter+0x8f3/0x1190
  [  160.535018]  ? alloc_pipe_info+0x2c2/0x430
  [  160.535030]  seq_read+0x267/0x3d0
  [  160.535033]  ? __pfx_seq_read+0x10/0x10
  [  160.535038]  ? __pfx_do_mmap+0x10/0x10
  [  160.535054]  proc_reg_read+0x1ab/0x270
  [  160.535077]  vfs_read+0x177/0xa20
  [  160.535085]  ? __pfx_vfs_read+0x10/0x10
  [  160.535089]  ? vm_mmap_pgoff+0x24b/0x310
  [  160.535108]  ? __pfx_vm_mmap_pgoff+0x10/0x10
  [  160.535116]  ? fdget_pos+0x1ca/0x4b0
  [  160.535124]  ksys_read+0xf7/0x1c0
  [  160.535128]  ? __pfx_ksys_read+0x10/0x10
  [  160.535132]  do_syscall_64+0xe2/0x4b0
  [  160.535141]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [  160.535149] RIP: 0033:0x463aa1
  [  160.535156] Code: 00 4c 89 d2 4c 89 c6 e9 fd fd ff ff 0f 1f 44 00 00 31 c0 c3 0f 1f 44 00 00 f3 0f 1e fa 80 3d ec 22 1a 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
  [  160.535168] RSP: 002b:00007fff303dbeb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  [  160.535176] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000463aa1
  [  160.535178] RDX: 0000000000010000 RSI: 00007f9becf9f000 RDI: 0000000000000003
  [  160.535180] RBP: 00007fff303dbee0 R08: ffffffffffffffff R09: 0000000000000000
  [  160.535182] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f9becf9f000
  [  160.535183] R13: 0000000000010000 R14: 0000000000000001 R15: 0000000000000000
  [  160.535186]  </TASK>
  [  160.535188]
  [  160.636633] The buggy address belongs to a vmalloc virtual mapping
  [  160.639416] Memory state around the buggy address:
  [  160.641738]  ffffc90005de0580: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.662534]  ffffc90005de0600: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.665865] >ffffc90005de0680: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.669222]                                   ^
  [  160.671430]  ffffc90005de0700: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.674771]  ffffc90005de0780: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
  [  160.678102] ==================================================================

Mirror the teardown that backend_disconnect() already performs. Snapshot
num_queues, publish num_queues = 0, call synchronize_net() to wait for
in-flight readers, and only then deinit and free the array using the
snapshot.

Fixes: b17075d5c198 ("xen-netback: fix race condition on XenBus disconnect")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/xen-netback/xenbus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index e020f44ac2c717..d1c9e38cfb8ef2 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -835,10 +835,21 @@ static void connect(struct backend_info *be)
 	return;
 
 err:
-	if (be->vif->num_queues > 0)
+	if (be->vif->num_queues > 0) {
+		unsigned int num_queues = be->vif->num_queues;
+
 		xenvif_disconnect_data(be->vif); /* Clean up existing queues */
-	for (queue_index = 0; queue_index < be->vif->num_queues; ++queue_index)
-		xenvif_deinit_queue(&be->vif->queues[queue_index]);
+
+		/*
+		 * Mirror backend_disconnect(): publish num_queues == 0 and
+		 * synchronize_net() so RCU stats readers finish before the free.
+		 */
+		be->vif->num_queues = 0;
+		synchronize_net();
+
+		for (queue_index = 0; queue_index < num_queues; ++queue_index)
+			xenvif_deinit_queue(&be->vif->queues[queue_index]);
+	}
 	vfree(be->vif->queues);
 	be->vif->queues = NULL;
 	be->vif->num_queues = 0;
-- 
2.43.0

