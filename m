Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66619D89E
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346298; cv=none; b=LflaKsZGQ19WzjTln4zQQmTJDO2XXWJeBcObIu0A/jFB7WJPuja7NHzRH/OtkCrKriY2Tk37hSNC67WgPhHRVr/lfaSJfapOkLwwS6Nepzcr1qyBykhim31/xU9DsSIVC+7dQUR+Lt7MiIsSKZ7UlK9s95TEBZhm6yvlCU5MnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346298; c=relaxed/simple;
	bh=M5r8za/NeNxSrRN8Md25usO4TkVpuB3TdlZWK01oJF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NxaHIkynWr3lgk9K+KeN90wMmWjjHrIEkXmzv5V7aoRG3PXbsJ6giZN8opIxVaqrHCNVK3r9ogBA0ZbvWtZ96jweqlKMPOrfGffQVZzU2wlZxysqyb9qxYjKP9S0Px6io0lxa1sGfTHuktrZhIwW6hHI63yUPfKy5PSpG5JGV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DCySpqY3; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DCySpqY3"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso633465e0c.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787346295; x=1787951095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIvMy7EYW+wk+fol8dmhHSm4n2ApUkXxUPMK2MF5POY=;
        b=DCySpqY3ythbmwdP9Vb2MNwdVYMMtRQlk1oocaJB6I2zJwM28oTTDydBEPjIOuULlZ
         jYmSH7rJGpdZR74ElQ5gWThSn9rvP0pTZJ44yveFPZijsiYQ7nHpq4bmhE3UYu6Yrll6
         wdt1how77botFgMY1SI/ehN0IXCBbspsPyfwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787346295; x=1787951095;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIvMy7EYW+wk+fol8dmhHSm4n2ApUkXxUPMK2MF5POY=;
        b=ju17qPJuuc2OEMjfGHbsJE2ynP+/cYjXBIggdT3osb3lyxXMdl6fKItwPAYZb+2xeM
         QtxTGW56rlB4InWo/z7RxdChHBR2L8zU129e/DfAxNGuqK7Vor2L/qhFCDsxO4SLzfRS
         f3S+V/3h53uR9c51aBuRKsKzm3uzY4xRbzueV0ctdeQG4xjsUGvuEvqB0/BlNjkcx67u
         TzA0U9GSf0pd8Yavua3uVJUC9XfgGFt+o7H3yfvQsXiBnIUZkGp8/MQIMsFIALxH7zl2
         u20dEaC/VY41aR+0pZNt7QSEE55AzAz9OROt+QvCHbPnLJud7nPUeJv/P/r9Ssx+0DR1
         VXqw==
X-Forwarded-Encrypted: i=1; AHgh+Rqr7W0i3Enz/2RXln0sGplGEVw4U583n5azXzQOBUEgM0zAds+pGdEvv/4nTrM16MiM1foLBW8=@vger.kernel.org
X-Gm-Message-State: AFuF++kN+JfN3PDfXT0WdzUpfMWZ3S5n2PohqfEv9bNzdWNW9zED2IRs
	Air9hco5BvquWH9wjgygSVCUTdQEJ476b0EA4+w6ALu+wz10nr50nMsEOLWaDIk3Hw==
X-Gm-Gg: AR+sD11Xjvk520q1V7yoMqb3vG6mgn1usfLXbyYsrwBC2REiba4WlyGKzWC4Zy04YPN
	YXvkdPkuMSUZDsFLmqEd97OMr1yvtrWTxWUrWN+vYK3Xm56sw1QiCahUj/xmqjp2xS5YkSxsckq
	vwRuMrG5Hgmqj8QApTVW5e6bW+7F1gG47VyNKaCjrtr/sltTTbJ826JfD9Ock7BBU8Mj7sdZpAp
	++NZQrrAN3m9hTTkzMnN/bnFQQZq1AKjCFfd7Le9ayH7GC8FlpRWeVMyhlQXl1Dxv4gCiPXR8w4
	ZN0UoClFlU1FArxJI29thg/LOsfahQTDbXwa+eWdZ7vcczJUY1UnsHaw8JEi0NaejTF/CpnQbK1
	tB8fpDCd5Wb/55e2UScslGPOxj+GOcRPineyffsbu+DPsL5PU7Jj6aK2j+1wEBnIhZfYx50n5TP
	pauzLImU4F/EedibQq7kEgaO7zUuxtZ+RwJzq/hDEg0Is5ahbPrv8f
X-Received: by 2002:a05:6122:7d3:b0:56f:6cc0:681e with SMTP id 71dfb90a1353d-5c5ff27a729mr4077783e0c.1.1787346295405;
        Fri, 21 Aug 2026 14:04:55 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e25e34b9sm10237720e0c.3.2026.08.21.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 14:04:54 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: 
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 1/2] net/sched: cls_u32: fix duplicate handle when node ID pool is exhausted
Date: Fri, 21 Aug 2026 17:04:39 -0400
Message-Id: <20260821210440.102177-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: stable@vger.kernel.org
Cc: vega@nebusec.ai
Cc: Victor Nogueira <victor@mojatatu.com>

gen_new_kid() falls back to returning max (htid | 0xFFF) when both
idr_alloc_u32() ranges are full, instead of reporting an error.
u32_change() trusts that value and inserts a new knode with a handle
that is already live in the hash table, breaking handle uniqueness
within the table's node ID space.

The handle was never reserved in ht->handle_idr, so every later error
path that does idr_remove(&ht->handle_idr, handle) removes the
reservation of a different, live knode, which is then reused — one
failed add compounds into further duplicates.

The 4095 limit is per (table, bucket) — ht->handle_idr is per hash
table and the range is derived from htid (bucketid), so a table with
divisor 256 can legitimately hold 256*4095 knodes.

The sibling helper gen_new_htid() has the same silent in-band failure:
it returns 0 when the tp_c handle pool (1..0x7FF) is full, and
u32_init() publishes the root hash table with handle 0 without
checking.  Two root tables with handle 0 alias in u32_lookup_ht(),
allowing cross-tcf_proto knode add/lookup/delete.  Add the same
exhaustion check that the divisor path already has.

Return an error so u32_change() fails with ENOSPC/ENOMEM when the
node ID space is exhausted, and so u32_init() fails with -ENOMEM
when the hash table ID space is exhausted.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_CLS_U32=y (or =m with module loaded)
- Create a clsact qdisc on a device, then add 4095 u32 filters with
  auto-generated handles to fill the node ID space for the root hash
  table (single bucket). The 4096th auto-handle filter add triggers
  the duplicate handle (fh 800::fff reused). Reachable at Level 2
  (unshare -Urn, namespace-local CAP_NET_ADMIN).
- For gen_new_htid: create 2047 u32 proto entries on the same block
  to fill the tp_c handle pool, then create one more. The root table
  gets handle 0 and aliases with other handle-0 root tables.

Fixes: 7801db8aec95 ("net_sched: avoid generating same handle for u32 filters")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Commit message: removed incorrect "4095-knode cap" claim (knodes is a
  liveness counter, not a limit; 4095 is per (table, bucket) via
  ht->handle_idr/htid); reworded to "handle uniqueness within node ID
  space".
- Commit message: added IDR-desync paragraph (max handle never reserved
  -> erridr removes other live knode's reservation -> reuse compounds).
- Commit message: noted ENOSPC/ENOMEM both reachable (idr_get_free/
  radix_tree_extend).
- Fixes: e7614370d6f04 -> 7801db8aec95 (duplicate-handle bug predates
  the IDR conversion; e761 only added the IDR-desync consequence).
- Added NL_SET_ERR_MSG_MOD(extack, "Hash table node ID pool exhausted")
  at both gen_new_kid() call sites; bare -ENOSPC -> "No space left on
  device" was confusing.
- Folded gen_new_htid() exhaustion check in u32_init() (Sashiko nipa
  main-1-0): same silent in-band failure pattern — gen_new_htid()
  returns 0 when tp_c handle pool full, u32_init() published root table
  with handle 0 without checking, causing cross-tcf_proto aliasing.
- Renewed tdc test (v1 tdc failed in long-running sweep, prompting v2).
---
 net/sched/cls_u32.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index c297d7dbcf91..1a72817bd449 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -370,6 +370,10 @@ static int u32_init(struct tcf_proto *tp)
 
 	refcount_set(&root_ht->refcnt, 1);
 	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : id2handle(0);
+	if (root_ht->handle == 0) {
+		kfree(root_ht);
+		return -ENOMEM;
+	}
 	root_ht->prio = tp->prio;
 	root_ht->is_root = true;
 	idr_init(&root_ht->handle_idr);
@@ -695,16 +699,19 @@ static int u32_delete(struct tcf_proto *tp, void *arg, bool *last,
 	return ret;
 }
 
-static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid)
+static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid, int *err)
 {
 	u32 index = htid | 0x800;
 	u32 max = htid | 0xFFF;
 
+	*err = 0;
+
 	if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max, GFP_KERNEL)) {
 		index = htid + 1;
-		if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max,
-				 GFP_KERNEL))
-			index = max;
+		*err = idr_alloc_u32(&ht->handle_idr, NULL, &index, max,
+				     GFP_KERNEL);
+		if (*err)
+			return 0;
 	}
 
 	return index;
@@ -1079,7 +1086,11 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		 * handle which is used to uniquely identify the match entry.
 		 */
 		if (!TC_U32_NODE(handle)) {
-			handle = gen_new_kid(ht, htid);
+			handle = gen_new_kid(ht, htid, &err);
+			if (err) {
+				NL_SET_ERR_MSG_MOD(extack, "Hash table node ID pool exhausted");
+				return err;
+			}
 		} else {
 			handle = htid | TC_U32_NODE(handle);
 			err = idr_alloc_u32(&ht->handle_idr, NULL, &handle,
@@ -1091,7 +1102,11 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		/* The user did not give us a handle; lets just generate one
 		 * from the table's pool of nodeids.
 		 */
-		handle = gen_new_kid(ht, htid);
+		handle = gen_new_kid(ht, htid, &err);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack, "Hash table node ID pool exhausted");
+			return err;
+		}
 	}
 
 	if (tb[TCA_U32_SEL] == NULL) {
-- 
2.43.0

