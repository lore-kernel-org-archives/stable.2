Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069613;
	b=wt1umCaJ9XsugMPFx9TNEve5wYVAGGQxAjqjUYHA9G7+3Wwli/4aJGWxty37vybMsbwV
	 Yud68a4gJuBCIP8YSb3KVtQSu0kDf94ym8O6E7ronOqQePBXStqAxwwWzHtF/YdussrIS
	 SVubOTEbSPVOjm9Nj14IJ/lX459XLz9fXd/Sci1V9IFEUkeS3ZaFajBODl4RJ7L6zYa7J
	 ytD/0q34LclOq/5Cg6jTRFMLjIp63FtdP8lCixZdYKGrVIjcnlPVHHFM33FhrhhYcsX7j
	 41fHSlMvE2ROYOGaOx/PolrkGiQsNJq36L7hQymc3aBveGkdF9ysyHCQmMnVJTh/wAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eANz6TxlfIefza3dEAFXrv5EtYoHJKoB5jG0laNfxhM=;
	b=aCOgqscmmGvYwnY5oVUplXuQ6YcMaAwLsc+Q0AwMX7IyOPxX5/SszqPmAWepbBeENcc7
	 mNoYCwQu4R6MXBZ3YpfiOfM8GARp0CE9xzVHpsXlelf52a8ii8nU7juUfyK2I1Kq0RExP
	 IWfI+XpoDx789PAx3TRUcXjZ5RTi+5wmvgOxie2aOBQtUOQ06VVarVjvc/hDRiddtHsxX
	 f1yWrwlCfbidgPKQy15tpk2XMD/KfDJX7M1KR53FZTxJlG9Cfimrmvdlv2/ObF+U7927U
	 ySzEe7hHi/IGI03Zrgob+6QzyCbWP+OrdrcVP0nPH24deQW4eKkwB1a2M3fBlyHCXWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tn0O3HHY;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C44B606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 02:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C44B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Tn0O3HHY
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e942864693so19170735ad.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 19:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793069612; x=1793674412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eANz6TxlfIefza3dEAFXrv5EtYoHJKoB5jG0laNfxhM=;
        b=Tn0O3HHYIF1+ZfJmwl6m2ZLfVwiu9AaVwwAf9P/buaKYIuLsrryCp8gZj5a5vpNAGc
         aiCQq9gB14QdZTDdvABdCKgOFqeTYSBhqQFfh6GvOaAljW4rjdOowcUMh9ZySrXJ9NdW
         OnxqyiAwTPqQy7LTTaxdMS6UYIpTTSpxfpuYDzEJygFdj7XpBYKZqoShcdQG99d/3hUW
         a5741df0ILndRCksQmx/ah0q5LS8Dj6dcB2KJ7NPZk9xCI+vIxTM8R6wV5B5bAbjc+or
         hJUeIj9sQSHpUkQZv1dE+UX8aELf+6Np+dTsjW9JyDVvtyty2+MzQDBNJE+pQtTAfpTT
         CapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069612; x=1793674412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eANz6TxlfIefza3dEAFXrv5EtYoHJKoB5jG0laNfxhM=;
        b=uv/T3OvXLlsDP+F1QGtHp0vOkx3l9691axN5lvMIgzxu54U08kvxxMurKfoPT9fC8/
         VnllvbmbIQTOMs0yRK2QQqLzQmIrmGgXYOm8XRjuKhQTIUfwdm/e+p+24wYIPlGPPjex
         Z0g2df1O20UHTBsvKt01Ll48NuEZunXw1vQWzl7OWG8WJPP4QkEaAaTXWcn0XHJeOyP8
         hnLmC8MGoZvYzFPeDExrzaRj0yfVuv5crn3ClvQEgHNvSQ6sdj5zSmBBkX/d8DFMBGOc
         9r2CTMNhm7ondD9qivO8EFHiLun3gQcerscP7e2PzorNVieBiDocvkIZ1dCT4Htf+iw9
         j9ag==
X-Forwarded-Encrypted: i=1; AKwUvBzHvGT6ylGaJZI366U76ED5ChHgTmQBTp4Rgac1x4ML1oK5lrSXpNoGIUUoz9QynNKSSUGxu0s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLe09Rye7LOgCI5doLacQR6H7UXA0qLXfS2vEWeDOTp1SYhWBB5
	LkO2/OK1eH/bywAHNi8a+kxyRqbAecoujaKYMukGC7Ia74n5GbIc3i8n
X-Gm-Gg: AYBFou2xR4qsP6rNLKtPHpkPD7poC9UYktCgaMVtbK/qDB9RcopCCoPQjtd1O+Pijl3
	NApGhCw90KDhSKdBULhnBkXQQgtI9h9lt0sudUC1FgaWfuOwEjCP3PPjbfq3C0O6rJ8iyqn/Uvl
	tqrrVuZsLUlI5TmXLiuSfnBoALwpef5oCCCNP9SlhRf5e/qSpiEWbArMUe4jpzhL4Htk8RWjSUv
	19E5UET8KXoPGaHMoa+R8vr+b9JOIzlnkd243sgmTpbLM0/WdLjkzpkQNlzUTzFCpAs6Cdk3str
	o3Y3RQwitjUrb1zyG5rjjvhOHjZqL1Fuge1eorRvf3E60VR9owloB3V0EvyRiK9pjPcSChlHJ2a
	CCLiql2vSNnVgXxc0ak2O8hCecBrQbpplU5sjCerixC8R3wvTWZbCvQbuEdsLMtcsEdzitM6cPY
	8fBYidnCLgd4c04IrHAc9bTNry++Jn019YMPg+rgl+3hV9IGuRoj2dVFDm+CWRyYJBV6ZTNWsJl
	ALYjMDhfj+bIZlJxuS4D7edqe9KDQA2r3ntPGtL62dGGBbFU5I=
X-Received: by 2002:a17:902:db07:b0:2e5:a355:56d8 with SMTP id d9443c01a7336-2ea9c87704dmr79704695ad.42.1793069611711;
        Mon, 26 Oct 2026 19:53:31 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c8f24esm2216125ad.57.2026.10.26.19.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 19:53:31 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2/cluster: cancel peer work synchronously on listener shutdown
Date: Tue, 27 Oct 2026 10:53:24 +0800
Message-Id: <pm-ocfs2-objects-candidate-0090-v6-127847d463212a41b773@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Listener shutdown must cancel delayed peer work before destroying the
o2net workqueue. destroy_workqueue() drains the work that is queued,
but delayed work whose timer has not expired is invisible to it and is
queued onto the freed workqueue when the timer fires.

o2net_stop_listening() currently only disconnects peers that can still
be found in the node table, and o2net_disconnect_node() cancels the
delayed work without waiting for a running instance. Two paths leave
armed timers behind.

Node removal disconnects a peer before taking it out of the table. A
heartbeat-up callback sees the persistent error and rearms the connect
and expiry work in between, and the listener shutdown then skips the
peer because it is no longer in the table:

  Peer removal                       Heartbeat / listener shutdown
  ------------                       -----------------------------
  disconnect peer; cancel work
                                     heartbeat-up: rearm delayed work
  remove peer from node table
                                     stop listener
                                       synchronize heartbeat callbacks
                                       skip peer absent from node table
                                       destroy o2net workqueue
                                     delayed-work timer expires
                                       queue on freed workqueue

For a peer that is still in the table, o2net_connect_expired() may be
running while o2net_disconnect_node() cancels: once the disconnect
drops nn_lock, the expiry handler requeues itself and the connect work,
and the flush does not wait for those timers either.

Cancel the connect-expiry, connect and still-up work synchronously for
every peer slot after the disconnect. Expiry can queue connect work, so
cancel it first. Heartbeat callbacks are already disabled and drained
at this point, a removed peer cannot hold a socket container because
that pins the configfs item, and connect work for a removed peer stops
once its node lookup fails, so nothing rearms after the cancellations.

KASAN report, only the relevant frames are kept:

BUG: KASAN: slab-use-after-free in __queue_work+0x1189/0x1600
Read of size 4 at addr ffff8881169069c0 by task swapper/2/0

Call Trace:
 <IRQ>
 __queue_work+0x1189/0x1600
 call_timer_fn+0x176/0x540
 </IRQ>

Allocated by task 486:
 __kmalloc_noprof+0x2de/0x780
 __alloc_workqueue+0x61/0x17a0
 alloc_workqueue_noprof+0xcc/0x130
 o2net_start_listening+0x139/0x7c0
 o2nm_node_local_store+0x4c0/0x810
 configfs_write_iter+0x2f9/0x4f0
 vfs_write+0x639/0x1010
 ksys_write+0x111/0x200

Freed by task 485:
 kfree+0x308/0x580
 rcu_core+0x6be/0x1ed0

Last potentially related work creation:
 __call_rcu_common.constprop.0+0x80/0x280
 pwq_release_workfn+0x740/0xe10

The buggy address belongs to the object at ffff888116906800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 448 bytes inside of
 freed 1024-byte region [ffff888116906800, ffff888116906c00)

Fixes: 98211489d414 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/ocfs2/cluster/tcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 8b3830b601ba..b0cafda827bc 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -2200,10 +2200,24 @@ void o2net_stop_listening(struct o2nm_node *node)
 
 	for (i = 0; i < ARRAY_SIZE(o2net_nodes); i++) {
 		struct o2nm_node *node = o2nm_get_node_by_num(i);
+		struct o2net_node *nn = o2net_nn_from_num(i);
+
 		if (node) {
 			o2net_disconnect_node(node);
 			o2nm_node_put(node);
 		}
+
+		/*
+		 * Delayed work can be rearmed after a disconnect: a heartbeat
+		 * callback requeues it for a node that was disconnected but
+		 * not yet removed, and a running expiry handler requeues
+		 * itself and the connect work. Work waiting on its timer is
+		 * invisible to the flush below, so cancel it synchronously.
+		 * Expiry can queue connect work, so cancel it first.
+		 */
+		cancel_delayed_work_sync(&nn->nn_connect_expired);
+		cancel_delayed_work_sync(&nn->nn_connect_work);
+		cancel_delayed_work_sync(&nn->nn_still_up);
 	}
 
 	/* finish all work and tear down the work queue */
