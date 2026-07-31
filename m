Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2444160C
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511850; cv=none; b=CLkiyuicgyEPO8dZ/oRs9t+tto1OSsDATLUptrGanDYxMlfA/8vNloNDzgciSxSreJu62G1ij7KVvmsGI6GLm/WBzOdYJ6/0blXELoSMjpj1W1FYHPQTdwg3KFYIwTKurXcVB6q47UE5OY47vVuEYmmWXfmU5759fzpvlzCm3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511850; c=relaxed/simple;
	bh=KQaPfDFPUnQM6P7cSv/JwJhXqHxEuSND+QAM9yLYYAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lcUL8LjtQeFUATSUUhpOJqDeIMYQDC+dKXa/wi952eX8Tv68YXqQ58V4qqj/QqX7yKu8MsI6hfBw0dDjp8dSmURlJR+y0U1xBGU+PWg7u+aiHTqBkgIcKPqS0y9wMWt6Z24cBQEJZAIUPYmKo67do/JiUrT9e6nZ14VI5lV8Fns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2Tn+0X2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2Tn+0X2"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384c94c9423so165641a91.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511841; x=1786116641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OyGbAT6GrMWswBzUxCW6VevBbGRS26+rZq5jcU/ga0=;
        b=Y2Tn+0X2D6QZl5J6EvtKJjFZ11uW8gFFVVA5A9ZzpK/aXKtW7/LBtp4Q1Jz3IACgOA
         BpQbDs0N2RyWU3s3Ihv+R5eJl8RPhcgnXxYg8qqeXR6+gUAlingPOKa13BUoCsiuDscr
         rlRENONBEyiiWtP3haQSqCdA8sa53kCINeTP923zgA4udSj/ZpMHtmidXdBsEV5TgWIq
         2sQ3nMHGhuGnR8VNOLOmSIYWzUZxVvtw0ZAe1X0tN5rA3XFhJDEywyh3oxtpXxXT5r0b
         5wJ9WwtcwWp21sdy9noa2n03Vqod3G4ti0sWDe5wbuqQS5+ezDzkxawDlbBGRgx/Zocd
         Sp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511841; x=1786116641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OyGbAT6GrMWswBzUxCW6VevBbGRS26+rZq5jcU/ga0=;
        b=c/Y2RehIBCAgjLbHmZlzmfyNMOLYI1R2+y+Q3wgsjyfDA1XnY7s/QsVE41+oftn92O
         nnCBi1zq+ZbGG9aAKyjjJzR3Ia6hxwlx8FmCydwWvy8IDxAuKdpTkXigI/yTzobXvyKX
         ltGdoewdN97QOSSrdDaBzCnisCA4GyuhR3zkEwcmdfaFLj2QTjfqKS4jUmpkCwn/yqPL
         A/CyzNaXbk0YxEnzuOB6C16tvfro1kats5wc7yGFAwczFaFl2MAs1dtgVikD0ntR9f8U
         gym+LA8Qos9QjsFghnRTSnrBo6JbHoFlTuy6KOiFfPp209z+L+9tZwp8gkYUDzOwT3SW
         YdaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrv0zR/Qca2dzaXaghJNOsg7pB8whZVD5LJ+XIjto2nzTajIisdpgvUn+dkvPfYQ9MJrfTes1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6sth7DCxOhMzwsBXxA2pYZGLGfd/97agvR1pHqXIZuTOuKgZP
	j/4VU4vcIbz565dXSgsB84GCBFlePcTv+5rQYtdCzBRiq4qPvCsW1RRl
X-Gm-Gg: AR+sD11m27i/m6i0mjKI6Kh0NmjFSrSPx0o9wCht1A3j+lw0MaG5zkL2I24Y95r+K4E
	HDKZhjq294Lq0ps4+dVaaZEOBaLX5Yy3rHMUsTc9t5o8cjJq4On0hDNBfVbumboA/yJRevK2FqQ
	OE6uhqR322bQbk9jRqZcs+WLQNwYJf91vHLw7Sccj9bkFKcfcDrHj3FpAkdr8NQpnwXmS88Ajgs
	mmA97WpAOCrlSQvcjjOSBj/ddi+Rkv9hLmDb+elnLQ7sxE3ralajCM96uBl5t0mnf16mb69lZ8L
	4XRwAOOTP49NudP99UvKwekjj9OoI2kPwtPpFruMLP0R2WPt0DQ+uAeGZBt+KruOjwNYasImNr1
	fducErLhibF6O06XrzECb7/ef82Ows1IvRigXIDbxr/HOQs80Bz3fom7ZtsWsdwxbPnQ+avPtRa
	WpNArkOKwgeNmcAXodAhaTsb9EARcEHlsfgjr7X7fDVwPnJAi7M3mDRfRBIVDCWutd1et45SIZC
	XgMr3NaA/6V7RvUk80zWuoaOyF4CQEoVAmujznzpgVbdS/iEHA380Y=
X-Received: by 2002:a17:90b:4b90:b0:381:28e0:6248 with SMTP id 98e67ed59e1d1-38fbc3f0737mr481201a91.1.1785511841320;
        Fri, 31 Jul 2026 08:30:41 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4f83c3sm3296821c88.14.2026.07.31.08.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:30:40 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Buslov <vladbu@mellanox.com>,
	Stefano Brivio <sbrivio@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: keep tcf block alive during offload unbind
Date: Fri, 31 Jul 2026 23:30:31 +0800
Message-ID: <20260731153031.3201165-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An RTNL-unlocked filter request can race with qdisc teardown on a shared
tcf block.  The filter request takes a temporary block reference before
teardown drops the qdisc owner's reference.  Teardown then enters
tcf_block_offload_unbind() without retaining a reference of its own.

The following interleaving can occur:

  filter request                   qdisc teardown
  tcf_block_refcnt_get(): 1 -> 2
                                   __tcf_block_put(): 2 -> 1
                                   tcf_block_offload_unbind()
  tcf_block_refcnt_put(): 1 -> 0
  tcf_block_destroy()
                                   access block->nooffloaddevcnt

The unbind path may sleep in flow_indr_dev_setup_offload(), allowing the
RCU grace period to expire and the block to be reclaimed.  It then
continues using block->cb_lock and block->nooffloaddevcnt.

KASAN reported:

  BUG: KASAN: slab-use-after-free in tcf_block_offload_unbind
  Read of size 4 at addr ffff88811ae590a4
  Call Trace:
   tcf_block_offload_unbind+0x158/0x190
   clsact_destroy+0xd6/0x690
   __qdisc_destroy+0xdf/0x290
   qdisc_graft+0x5d7/0x1560
   tc_get_qdisc+0x415/0xd50
   rtnetlink_rcv_msg+0x367/0xa40
  Allocated by task 85:
   tcf_block_get_ext+0x803/0x1570
   clsact_init+0x1ff/0xb50
   qdisc_create+0x392/0xde0
  Freed by task 88:
   __kasan_slab_free+0x43/0x70
   __rcu_free_sheaf_prepare+0x5c/0x220
   rcu_free_sheaf+0x1a/0x100

Keep the qdisc owner's reference until offload unbind completes by moving
the unbind before the refcount decrement.  A concurrent temporary
reference release can no longer destroy the block while unbind uses it.

Fixes: 92149190067d ("net: sched: flower: set unlocked flag for flower proto ops")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/sched/cls_api.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index fee4524adc98..d3b2506d87cf 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1312,6 +1312,9 @@ static struct tcf_block *__tcf_block_find(struct net *net, struct Qdisc *q,
 static void __tcf_block_put(struct tcf_block *block, struct Qdisc *q,
 			    struct tcf_block_ext_info *ei, bool rtnl_held)
 {
+	if (q)
+		tcf_block_offload_unbind(block, q, ei);
+
 	if (refcount_dec_and_mutex_lock(&block->refcnt, &block->lock)) {
 		/* Flushing/putting all chains will cause the block to be
 		 * deallocated when last chain is freed. However, if chain_list
@@ -1325,15 +1328,10 @@ static void __tcf_block_put(struct tcf_block *block, struct Qdisc *q,
 		if (tcf_block_shared(block))
 			tcf_block_remove(block, block->net);
 
-		if (q)
-			tcf_block_offload_unbind(block, q, ei);
-
 		if (free_block)
 			tcf_block_destroy(block);
 		else
 			tcf_block_flush_all_chains(block, rtnl_held);
-	} else if (q) {
-		tcf_block_offload_unbind(block, q, ei);
 	}
 }
 
-- 
2.43.0

