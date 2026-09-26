Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC83009CB
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445147; cv=none; b=qBIGMohWSXz1AQ2o4AIw+9Df4HOBSjXHLA5OjRJ4yOMOEinQqnWVWRnXZHDq9YrXyJawomecKYMZQQyPF1ljwIDKcsM1xQfIbib4NtB5FTVi9lbuNxx8Jg2mseCqjdYEyDb19FeB1ng2xO4X/MpIACBu07eTO9p9EcChNgYvBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445147; c=relaxed/simple;
	bh=J+AhSgGwt6r0gJXNT77YyglaJAxP3u30DbwIyT1MBgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbmkcary6Otk0VtP+pbrEop6gvw1cXqX+n+DEEx9iSPkJQVZE1KXYTkVZqAatDxFptbf8BWdw00Ka2tcN+ajCuHrKnCYx9VdNIeB2/HIp+o9NmV/b30HizM4nJkvGTcHjCtv2VBwFM6nj5pGZcODHFMHNvPHMrrwPvQ0bfc7bRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHAr7+C6; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHAr7+C6"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-344213c95bdso3101eec.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790445142; x=1791049942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwvxlwyQkpsMgM6uNMmOr1LUHz18HQva7SpWQBiJmMA=;
        b=RHAr7+C6j2hxZQNac9iNTMedEzf+XAqZiz8UBrbw1VVKP/DO583IaUZAu0NjfdDZji
         w6sm8LFaSIURUgniznrLanYijIBDonAE/woTLtpQW7vMIqGD+hJTgxZXl0tFyyEZcqN6
         AG6S/rL6QkvsvCgMfQ8I3YRezczag7P1YvOmI91Q6ST6DmtXmZiHFmsBQlOf7/yZYqoR
         +OXXzYOpKMPFaDdZUwABNCYvWfnu8gd29QAqmjwUYtrOOcpE5+ClaBdCwdNrocAviuvH
         btnn9JhBVncu4IMfniVx4rJa8cgFOi2sJp97At8kgLoG9vIt0ad0d4PlaNhwdLkPzBga
         cRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790445142; x=1791049942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwvxlwyQkpsMgM6uNMmOr1LUHz18HQva7SpWQBiJmMA=;
        b=wYLvShhNlFH4aDbfgDZr6vC2zglde02UngwuCOIPd05koxECU7RahUzBpgT0MDyrzk
         v5EyLHyQaCXvAQ0QUL9mlDTMoH0ULM6305Q/fS1owgaeYShpmd8GFFp5gLPQQqFX+5/a
         uQ0PiQCnUIsD2PeX9VWpe5RxPx7p9OvcoRJHW2qQ8dQxU5hH8RAH6SDzHIprob1pCSGq
         8KcxYRmPDNP3WStF+gh9QphJsXVe+8clfFbtJ8Cg9yhHJVUGsVIAw0aUn/UEk8nQQb00
         HKrgBelI3AOA2tWkpXBo3MB7/IjIHSPG0/LleA/E4fFuaie18AExHiBsamZMGEfr16zU
         h5HQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHT8EAyGaveaOctRg9CJ+sBW5NFXLjyYzefOUl4Z10XtJVscUeLbVLIoJLU//JR7IqDun8+CQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nasQaR4SQC6FBhfw+jMpYL+OiZpoe8WX85o2PG8s4t3xpvsXBg
	cxOkRY5CyWZi4xA7QTaHETd3Pv5n1zWWrNNEiKXq5E3wEi9lKGgJQr76
X-Gm-Gg: AYBFou2IDT38BTsFOwwhngyOaLQE/yEcOHreaent53F17nNmR1+bpZNyopd3Kd8LUY0
	rl6gvAVgu3mXv8OXDOBVUArCobDmB+Wrt9IGg0nbJLJ3XL6xgslVaicxBwWbPN1WzkSliUWP3Qc
	g3QmkGfpQ+5j8dF+7CclozONFXSE0wCsCjf6mjvc4qiK952m3gCdJGwqPQ0MugFHxvYSrP81GSC
	g5VDjTPjLSXKOkqAsWUVvcyRTvfSoJNtsVc+A3RNXubFKiJC4eVQULgoorf5V7GBVRcSa7ShoBQ
	2TGsgplUs2n3OQdZqr1nMCHe4zb5bgZkw5BpQplfaxo+lKdWIr7+D4uGlMUmU/aRCdMn8GijXjF
	TZsDW9He+2tC/xPDNe5tTkyb3HzXwnIA8T3y4zxDa+PrWaX0ETOe7MDDNIU4R0nUazSthCxYWx1
	wOG8w0RkO/CU+UI7tKlWSCtEs11muAxjXIGNHCVFS23RxHzWrvYb7T/sLm6nlTHENWZ49rhxZ23
	3JM2Wy9qcscfGcachxaRmHGE7z6DPPIZlKVxoS+qYhjTzafShnJIVnmXTETr2maYseTDJw=
X-Received: by 2002:a05:7301:dd97:b0:33e:6a79:5a81 with SMTP id 5a478bee46e88-3427179721dmr5365610eec.1.1790445142180;
        Sat, 26 Sep 2026 10:52:22 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341463ec3ecsm16482252eec.31.2026.09.26.10.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:52:21 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfilter: conntrack: wait for RCU readers before freeing the hash
Date: Sun, 27 Sep 2026 01:52:09 +0800
Message-ID: <20260926175209.2618167-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_ct_get_tuple_skb() calls into conntrack under rcu_read_lock() without
holding a module reference. CAKE can use this hook to look up a packet
without an attached conntrack, even during nf_conntrack module teardown.

nf_conntrack_cleanup_end() clears nf_ct_hook but frees nf_conntrack_hash
without waiting for existing readers. The grace period in per-net cleanup
runs while the hook is still published, so a later reader can race as
follows:

  CPU 0 (packet path)                 CPU 1 (module teardown)
  rcu_read_lock()
  ct_hook = rcu_dereference(nf_ct_hook)
                                     RCU_INIT_POINTER(nf_ct_hook, NULL)
                                     kvfree(nf_conntrack_hash)
  ct_hook->get_tuple_skb()
    nf_conntrack_find_get()
      access freed hash bucket
  rcu_read_unlock()

The same missing grace period affects initialization failure after
nf_conntrack_init_end() publishes the hook. During module teardown,
KASAN reported:

  BUG: KASAN: vmalloc-out-of-bounds in __nf_conntrack_find_get.isra.0
  Read of size 8 at addr ffffc900012e2ae0 by task poc/90
  Call Trace:
   __nf_conntrack_find_get.isra.0+0xf87/0x10c0 [nf_conntrack]
   nf_conntrack_get_tuple_skb+0x255/0x400 [nf_conntrack]
   nf_ct_get_tuple_skb+0x75/0xb0
   cake_hash+0xfdb/0x1e10
   cake_enqueue+0x5cd/0x36e0
   dev_qdisc_enqueue+0x40/0x170
   __dev_queue_xmit+0x1e90/0x3110

Wait for an RCU grace period after clearing nf_ct_hook, before releasing
the hash table and the remaining conntrack resources.

Fixes: b60a60405fb9 ("netfilter: Add nf_ct_get_tuple_skb global lookup function")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/netfilter/nf_conntrack_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d0d9e5ea84a0..b07e94e75d4d 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2455,6 +2455,7 @@ void nf_conntrack_cleanup_start(void)
 void nf_conntrack_cleanup_end(void)
 {
 	RCU_INIT_POINTER(nf_ct_hook, NULL);
+	synchronize_rcu();
 	cancel_delayed_work_sync(&conntrack_gc_work.dwork);
 	kvfree(nf_conntrack_hash);
 
-- 
2.43.0

