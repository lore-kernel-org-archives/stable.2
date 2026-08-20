Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC653A2549
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219569; cv=none; b=a0CEJZjHRqtzFXr7ypCg2onizcRiVEvoFK+KtW/ViPNGYbB7id9pzgxHLByApf7euMgPjIMerbAe+ogLpanFB3StClbbOl94M1mXVikTzuBrEw7tI49Lxd1Uib8E2SvedG1lekilfT6btGY5bimhoFHoxxnV+pOFtFszzvaNG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219569; c=relaxed/simple;
	bh=68V8U4WQDih+Kj/9G/1ue48Pi5NWSScT3hTceWvBxJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HW04m2nMsU9TtTzVdK/f944i+ZU1CWuWYcpdjZ8lgIX3rZ4QORlvVCvJbWi/em6lIvoyjp3giX0CJFL+3Xvqhw1GNJq8OvLh5w/4dnnFp7cpSqqJxgW2WkHKxYW7GflubRmCEJpnW02e8QvU3HAsssMj3gk5vXPwA70AWokj4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gwss7Tn4; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gwss7Tn4"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4af7283bf83so1196252b6e.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787219564; x=1787824364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NkqPyRMbCqdK29EZqFCfmFaTaPXyrsBFpJa6vBIgB00=;
        b=gwss7Tn4wmtKijb8ZCyihLtnSMX6bBuuvrbE1MLtdSKNicMIu589B8oCGkBx0oj13P
         Lz15bVtiEN4wLuYvNX/+inTxB+9GXx7c/SHMdJ2i/zXfcMLo7sZ4SU/KTIejHdMiTaes
         1Krq6rEF+DjDYs00wUNAdVf9I5pStG72jgP5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219564; x=1787824364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkqPyRMbCqdK29EZqFCfmFaTaPXyrsBFpJa6vBIgB00=;
        b=QTME7MfPZqAZG4IcNdsvnNPMAr/YBWqSlq03Q1sdKKmNVBfKBZNu054lcacIeZ+aGJ
         yHfFAWCwGsOOkT5n/fiLPa7OXVK9n7snTOtkOGv0BBp66DHFTkW0e93QG4yN1vu6OkUi
         ATjjTKgrKmDEnAD76KhlmWtvTHqh0l+HFQb1bJ7G27+bCqJxNb0r1oWT3t+i+KyUqJxI
         oZ9YLEPr3aBIaIVbfxuQvcl9gLfQUZGkpw3KesPfqn+ej1eYa/Zau923yLap77qsLr2M
         hfdMN1WK0div1egQfrRe6CZPOv0HXMCEjuPn9GWrpqgaaFmIv0Vp1UaeOANiBlDyqNfG
         yH+A==
X-Forwarded-Encrypted: i=1; AHgh+RqPOkyf5zuiPtOWgvmW3d7UwlxbxOyrOZUhnV0paZo15KE6P51ZfAvQukJuMku3HAHkojvia5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4znRuDYqk7wWcN/M8+HSfA6pnSDhHp0iVGC0DtSqqAsSUHJM
	AEDlRCYlO7tI4noLZ+MNSZpUMPBhxePLdkTcWm0i0fmG86vZP11TQRNIPWsgdTpkbH4nhTdkIQs
	/RGmv+A==
X-Gm-Gg: AR+sD11xYECZacf4qNsEzC6m5YBx2yUoC3gJs2oUrgzV8+HRHBuFI0ktCJbiRjNQand
	cXdbdDmvwlULrxjbgkaZyJ4OhtOMMF5Vi4JeNb1Kr/2XpufX9LrFJark8C7x4qGP9eQWGPUv5nN
	3RbyHXdgMyNBsmqDHIUKX+7xtdjPxq5wU+HRnlbQ5MFNSIezQhhCC8sjRzGkbUnsBNF4H25iZGY
	l/dmHzYLE3dUi9SBR6PYKqSdeM0JXiOuMkH5dqAClvKVEr2e0su9WswqqUyLCnXq+LAYWvNGXvn
	ZeDPYFxyh4Vxiw+UB5ZJn9KGv2hyhqQxUL1F/uMX1meJ1fJ84uVc8DlCC355q5/1Y3qs3JuBjQH
	wFyrkCEFJq1hgTRPDJQ7s2miuvAvJCWDvd7tba16bVUjIZombbSpfLUONEYvEPmi9EB4yaRCwIj
	+lTfEKppoo652z3a8rqPNpC18q40+kpjAsHIBAZC3HEXBptuj3lSH6LzoEmrrc/UvKLv+5/XaJ0
	S7ZLtrW84gjtpmHVLrFJV77A772aspRlzuRkej4sMlktxAhfTKWN/Xv0wYz2w==
X-Received: by 2002:a05:6808:5290:b0:495:ce61:4e0c with SMTP id 5614622812f47-4b2bc8b86f0mr9389578b6e.3.1787219564293;
        Thu, 20 Aug 2026 02:52:44 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm1286981b6e.13.2026.08.20.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:52:43 -0700 (PDT)
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
	"Victor Nogueira" <victor@mojatatu.com>
Subject: [PATCH net 1/2] net/sched: cls_u32: fix duplicate handle when node id pool exhausted
Date: Thu, 20 Aug 2026 05:52:35 -0400
Message-Id: <20260820095236.68390-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gen_new_kid() tries two idr_alloc_u32() allocations for auto-generated
knode handles. If both fail (all node IDs in 0x001..0xFFF are already
reserved), it silently returns max (htid | 0xFFF) instead of an error.
u32_change() trusts that value and inserts a new knode with an
already-live handle, breaking handle uniqueness and allowing the table
to grow past the intended 4095-knode cap.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_NET_CLS_U32=y, CONFIG_NET_CLS_ACT=y.
- Create a clsact/ingress qdisc on a device (e.g. lo).
- Add 4095 u32 filters with auto-generated handles to fill the
  entire node ID space (0x001..0xFFF) for the root hash table:
    yes 'filter add dev lo ingress protocol ip u32 match u8 0 0' \
      | head -n 4095 | tc -batch -
- Add a 4096th filter with an auto-generated handle. On the unfixed
  kernel this succeeds (silently reuses handle 800::fff, creating a
  duplicate). On the fixed kernel it fails with ENOSPC.
- Reachable from an unprivileged user in a fresh user+net namespace
  (unshare -Urn) with namespace-local CAP_NET_ADMIN.

Fixes: e7614370d6f04 ("net_sched: use idr to allocate u32 filter handles")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_u32.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index c297d7dbcf91..13ffad47cad4 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -695,16 +695,19 @@ static int u32_delete(struct tcf_proto *tp, void *arg, bool *last,
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
@@ -1079,7 +1082,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		 * handle which is used to uniquely identify the match entry.
 		 */
 		if (!TC_U32_NODE(handle)) {
-			handle = gen_new_kid(ht, htid);
+			handle = gen_new_kid(ht, htid, &err);
+			if (err)
+				return err;
 		} else {
 			handle = htid | TC_U32_NODE(handle);
 			err = idr_alloc_u32(&ht->handle_idr, NULL, &handle,
@@ -1091,7 +1096,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		/* The user did not give us a handle; lets just generate one
 		 * from the table's pool of nodeids.
 		 */
-		handle = gen_new_kid(ht, htid);
+		handle = gen_new_kid(ht, htid, &err);
+		if (err)
+			return err;
 	}
 
 	if (tb[TCA_U32_SEL] == NULL) {
-- 
2.43.0

