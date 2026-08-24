Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B8411FB8
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572721; cv=none; b=R5Z2i4lQDZKMIv/j1pQ1QI6MSBYblPOLdxDlFMBr9Y1jYbps533fRQBhbMPjO64hQEAXYnhFM+PvOGFcobQNcg04BcEK9WVjNdQvgiYsrfsFlc6lW8BzTCdf0NKe3UYFdeqPjbBWifH5Iz6GUG7zSTbtLCyqr3WyCSy1mdM92oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572721; c=relaxed/simple;
	bh=rwVtocl8QFG6AaUZrwl4HjX8gTEbKaqLxkOKeOAb5m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atxseeLrM9OOxGbZgYE4lGBsw81GWg8d3zPeTHiEvkUwOgAldWOxn1xXRBfTuUbcZkoJ+eAiCNFXhYKhaWaH4a0BY+cEj81v4JvxieunngzG86FEDTzPRiiDIGAx7Mpe6fUzRTs7LJdGxUWiBmZjCKo6YWnzw77NTnlUJbZfg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzWBr09R; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzWBr09R"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-668bec50cc7so418866d50.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787572718; x=1788177518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZFQ1cWzuhWOIEwwaSmn6Rpdvmfaw4ozucDVtslq1L8Y=;
        b=HzWBr09RCmRoq/bxVeP0Zjgbh2DBU0ABmNOoF89ZPshp5wpA5jaoBwhbl1coqfEZ02
         DeE1TG0nEb4D7UPdQkLshtbTUW8j5okRBCh2TI0Mrh8vq1t+0oXae7jAtz2UYySsbv4c
         ZQjQ92MveJ6g5H89V0kCjv9enEgPby/mLGiZ64o88RW1lB8st9+5BSdevT1qGQjt6vaf
         SzMxa8QlADtCPdB6NRlv1I7N0wFylvYBAOiLQuOvq7acGCs8EjrIk9qxCxPMMmDzx9u7
         4jbCAIAPbBjZvBFrc7aoCe/s4AXG5PRiVR/w6eTopY60SVudyhZThuaQBm3gLWAjNev+
         ub1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787572718; x=1788177518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZFQ1cWzuhWOIEwwaSmn6Rpdvmfaw4ozucDVtslq1L8Y=;
        b=tXF1z3ex+YYsIdaILphcgfnxJoM2p4JPVjzRHP+bsea0QoGSlZJ1I2fGKLgiYwYNFV
         it1NDufyMg/tdtwWqr8V7L8w7MKKdb9g3LsZN2zYCKUZp6EQTRmmcDim613pgr2ppQsT
         7TymzgnR2IuOxer+Sv6WnOTs6VZN/uPRls4ME5lKnPpn1HSp2V8EqflZi5ORE5MIUMzv
         etgqa5SV6lYyN5fzem1Of7whYhejmUG/5239z78f5mi0nWU5mrAEROfZdDaHzlWie8bV
         1h3MblwGBEMsJs1ZVmZ7ZmJ7ymdzjbgfcBHyyRhSxX7+/HNaUhvG2xJxjv0EaOkxaSHa
         vDVA==
X-Forwarded-Encrypted: i=1; AHgh+RqqD1j2lvdSSR5F8Jk0kp80HNcEGGUzS2PTBITxTk3kU10WfmiOGu/Iyz8egqeAaCLxtKIzqOI=@vger.kernel.org
X-Gm-Message-State: AFuF++ndLjs2xD77qQDpdWT3VoxIwlI2U1ENPF9AMn1SmcCSTLCy2eo9
	rIirP+eE5sTeV1xEXhnE1SSkD6LVUD7foK+3T1N3M52DF+DeMub8ki/V
X-Gm-Gg: AR+sD10txuSUfdqbtYxtRdQS0KYfTgLToQOoRHv3X+X3T7y2YUHCIuSnoc5BKg413vR
	BZyz6LMDYSFYroCMFND0yt+mBXBNrZVcRAsj42RphbCggPPMP+w04dqntkhzEoFYkkLmfgD5XJV
	jltbo7qkXC3CCa9fag+jmo51h8+KlSo37iXYcnWm/mbxczbbbnqCXNsOrHbARx6y9dOdkF8KYfu
	sSYnl5IY/pjgq3ybCTP6WyMrxdCDbHTfSTyQzAJrq0tZPF0f5yv+N0v5i+EYRt4wfkyaJnVJap3
	Tp46pJ6mEFmV67Nhqh4TOj+33oMDkYFaSr9Igc1LlV8KYC6zZQUlZUCEYOLkitUG6usG6pC3lCV
	/LzGL9v8PfEFsuU1AykkTX31SXTLE8nI2fpBB2RBr8eE1IQ1ZOr7W8+sF9myLrbLpPI0LdMdLzS
	ahxtL+lyQOwGyuLiGmNLnvPsqbtc5UQQFKfVciIDGsysduauR/5xvOo819qPvXNiZeeNylA9SyQ
	H7+4040n5GtXLtX7g1BGlGRkoanWkWwhgBtJidNETZmUTK1YbleMqeidyKw0w4nfg==
X-Received: by 2002:a53:acc1:0:20b0:668:430b:a928 with SMTP id 956f58d0204a3-66ce48b6cdfmr6454864d50.0.1787572717705;
        Mon, 24 Aug 2026 04:58:37 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4a0c6c3sm3474127d50.12.2026.08.24.04.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:58:37 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paul Blakey <paulb@mellanox.com>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: flowtable: flush delete work after final GC
Date: Mon, 24 Aug 2026 19:58:29 +0800
Message-ID: <20260824115829.205118-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_flow_table_offload_flush_cleanup() drains delete work before its final
garbage-collection pass. That pass can itself queue more delete work.

During teardown, one possible interleaving is:

  teardown worker                         delete worker
  first GC: work allocation fails
    leave flow retryable
  drain delete workqueue
  final GC: allocation succeeds
    queue FLOW_CLS_DESTROY work
  destroy rhashtable
  free flowtable
                                          read flowtable->net

nf_flow_table_offload_flush_cleanup() flushes only the delete work that
was queued before the final GC. NF_FLOW_HW_DYING is set only after
successful work allocation, so a GFP_ATOMIC allocation failure during the
first GC leaves the entry eligible for retry. If that retry later succeeds
in the final GC, it queues new destroy work after the earlier flush, and
that work can retain a stale flowtable pointer past the free.

This was reproducible with failslab forcing the initial GFP_ATOMIC
allocation failure, and KASAN reported:

  BUG: KASAN: slab-use-after-free in flow_offload_work_handler+0xbe8/0xe30
  Read of size 8 at addr ffff888109c9fd98 by task kworker/u16:3/397
  Workqueue: nf_ft_offload_del flow_offload_work_handler
  Call Trace:
   print_report+0xd0/0x630
   kasan_report+0xce/0x100
   flow_offload_work_handler+0xbe8/0xe30
   process_one_work+0x63a/0x1070
   worker_thread+0x45b/0xd10
   kthread+0x2c6/0x3b0
   ret_from_fork+0x36e/0x5a0
  Allocated by task 87:
   nf_tables_newflowtable+0x5d0/0x22f0
   nfnetlink_rcv_batch+0x1396/0x1d00
   netlink_unicast+0x5f5/0x860
   netlink_sendmsg+0x70a/0xba0
  Freed by task 11:
   kfree+0x131/0x3c0
   nf_tables_trans_destroy_work+0xb26/0xeb0
   process_one_work+0x63a/0x1070
   worker_thread+0x45b/0xd10
  Last potentially related work creation:
   __queue_work+0x68e/0x1030
   flow_offload_del+0x74c/0xad0
   nf_flow_offload_gc_step+0x264/0x8e0
   nf_flow_table_gc_run+0xcd/0x150
   nf_flow_table_offload_flush_cleanup+0x5c/0x70
   nf_flow_table_free+0x280/0x350
   nf_tables_flowtable_destroy+0x71/0x270

Flush the delete workqueue again after the final GC. This keeps every
successfully queued destroy operation within the flowtable lifetime.

Fixes: c921ffe85333 ("netfilter: flowtable: Fix flushing of offloaded flows on free")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/netfilter/nf_flow_table_offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 801a3dd9ceea..0fd09554b9ce 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1167,6 +1167,7 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable)
 	if (nf_flowtable_hw_offload(flowtable)) {
 		flush_workqueue(nf_flow_offload_del_wq);
 		nf_flow_table_gc_run(flowtable);
+		flush_workqueue(nf_flow_offload_del_wq);
 	}
 }
 
-- 
2.43.0

