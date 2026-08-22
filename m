Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986B30AD1A
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437268; cv=none; b=GbF7sgA+MkDm2NFhTFhYPErksPbM01Sr/f9OD1wZi4CfV49y/6ylFzeqfJA/22IHHab2ES9VPukOlwAC0koZwCtG94vvtgLwaGZHe6tTz149ojELU38N9lqYAlBYdn8hu/WfIZkRMbPS+MToiP9mTI/36sh2D8QCCD1lC4PKzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437268; c=relaxed/simple;
	bh=Hm6DGsvEv0UfW3kLRDGah7GifgO4QxzKNiyueKgICDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tcKfOsmXhDtayzeCex3WHE1x9ZhQEDlCYrfyycahrVfsBks0PJU39D8ITGRRSu7UYsH7pICHKqt4pDjR3UJi+jgPXGXoOGadDzoXTnHacsICH5XvPxVgUFgjTsVXK4JIyP1SGZJBtNpu3MvRUS3eMPzerzocIkpN0XcJGN9PCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=PcmDii1h; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="PcmDii1h"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-517dc520840so16449671cf.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787437263; x=1788042063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRESx+fjyo1UXWDp3GcCh/xEpgAf6GkQkCqatIvZlVU=;
        b=PcmDii1h5i7TKJKEycPSQ+ZeM/5QMkQfuPbbQj33Dw5S4GXFyKFUUJ4YAls0ab8S7K
         rsT77CKubfFESZbBWMdKRWBbpcTKNsgr8dfTE90ZCbvT7eF60nrowvBo5gwMiWgSwIjS
         LPDgjp1gKx4c9jPF/wVB02TItkZAjW3V7ZTUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787437263; x=1788042063;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRESx+fjyo1UXWDp3GcCh/xEpgAf6GkQkCqatIvZlVU=;
        b=FyQ9nGa5jkJ3fQoOd2Q1G12WzrDr1BlJEwH+3xMpgbUP/kW2oXX+EdRxgByCy2agHj
         xk/evUsTAU8RXZ+M9KlfMSShETLjvtoFi2Y0vKtpbuElvvLwa1cV51KZDfMRpG8TpUMY
         4gENZrdqWor6xcTGNYUY6eR7GD/aqVgcl8R+GC6obWjRz4laDe0wybdAzsuqNoxNiqnd
         e8d15R4VcwAqbWXqZ1KG2OQGN3zXrv6rKPS47uIBeX/3bkimW/AphEB5NtFQURIlgPRU
         1pYi0nvgElZGMnpsoy0Z46ayoxBzsoS6zeJLWOMVLkKG6MyWTbKdkpQgLfXk3alX4vzJ
         HmBg==
X-Forwarded-Encrypted: i=1; AHgh+RrVmlkf4qxqcBR50UHTZBtSbEtQXEFc57rZTbnWsXLHwPFa3+csH9mTGIIlxlB7qXe3o9SkQ9E=@vger.kernel.org
X-Gm-Message-State: AFuF++k2kzWTzhNdsKy6jm1x9PqXNXMKqpf/9PU9VrV6sac5bDbMtg5r
	ek2GUzgvcfKPtLLJFyTNWIYkWJY2m4/Xvb0M2wCef12whYjipQYB/bs5afrVsothnQ==
X-Gm-Gg: AR+sD13lVRONcEqszkIY8ag3j71d1SJXm5iU3v+AV2Yrz2gBQHZkbWKlGp04BToQs/x
	+HL7EBS/HxhWIAWUiHXvPCzlefCxCrqBu45DA3kryGFGfdQOnl0L0LS2WfVLpFju9ePHnsfws5V
	sxBRuagOCrCcdEDwxyhMsfDXiMUpQ4qgAYgxOxW8c5szoWaJLv8x6qX5YvR/VSsidsVNy/zj7mq
	DRoLBEKY1tLZs+icT1FYYHrosktUd0yb2HhyC4ERAE/aEyofAnx9tt/nCjoDGCiUWQ378O/1sNK
	C3YCDTBrxSoi16GHY/LsOlF8ZTwvU2IT4bFUS93WxyS1PTIlO+fRKoYkk3n1Z0/hwbSjWqlNgvt
	ED7rGX/+qQ2asuKgq8kpLyg/MzXIO+868Vit4qqvPMtyOU1aGgJpQyudXeZfWyqIjEyugnIJrVo
	Ic4gvFna35mW58R9hi2iJvYAYtFA5teZjCzw5nljO0mC+uE/itf6vR
X-Received: by 2002:ac8:584e:0:b0:517:a7ff:935f with SMTP id d75a77b69052e-52e09bad99fmr81845291cf.9.1787437262923;
        Sat, 22 Aug 2026 15:21:02 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a8be17sm22573156d6.46.2026.08.22.15.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 15:21:02 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 1/2 RESEND] net/sched: cls_u32: fix duplicate handle when node ID pool is exhausted
Date: Sat, 22 Aug 2026 18:20:48 -0400
Message-Id: <20260822222049.114526-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

