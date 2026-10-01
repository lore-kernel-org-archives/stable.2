Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3646983C
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848872; cv=none; b=SHDujX7GHx9DM+8CEsx9g+d7UrzEniuDRoK0uT1mkXe7fhpreP+ftDMA7U0nEurgAPr7x6QQ1+PyJC5LpyFeqQ1zWiM81JkCfXFG2yKdTeefOrSs/sThEZ2zoyWm69/NRK4TugfpCA8qe6O0+dSXqQ9rm1O4KZEVIkI2XuJVYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848872; c=relaxed/simple;
	bh=ipiq9H8XzNQS+o0+COYIT39cFbKB4Awtyn7z3MAMDvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c/iUCI4AZTY671BUVL7Ltu4zPKD1NqJkoZ8MpcK63ExxCLoqCRlFrO/DlcVOj96oa8UGLIRppJizroL/BKoa9jFjbNIIHI+68d510AuanblEV5j09it3FPm5/PKp8OVys7TPg1BGVW3INznhpyzGv7rdadeWZwwOlMxhx6PUdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bmzJnsBD; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bmzJnsBD"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c5818c4a4so430882785a.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 03:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790848869; x=1791453669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=esnKie285mrgRlYsWWtvumiQ8ekXK64tqRDiZaGoaeo=;
        b=bmzJnsBDt5N1w9D/imk8FNrWCye+R8KYUXb9Ld1Fa9C4zOyx1KbqnswcGz0YZEar4q
         pdaegERJk4xbwqbTJzjisXfaSbJyuQf+bhEWFUMK6sw9wrDJClKKTrVTdPWPL5Qmf2hf
         Gois91/QodIa8DmginwSnaHlv2hMIihuz75PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848869; x=1791453669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=esnKie285mrgRlYsWWtvumiQ8ekXK64tqRDiZaGoaeo=;
        b=SsAx1tycRhIkdktWY9MgdckEPAThL+PkzbSpETOzvdD1n3ToRkANgJ+fqTMPPEwOPZ
         jxzhVpLDhwTWimqnsJdsfxWBZZKXSKy7HHOVxXuS0MjlWZujptBEtw4NEUk+JPAXkccj
         4+nQGZg7EJMqf6agquzod48LtQUOD8Ok3oX0gC43BStQbps5ZsJyD8OgsXNspws7N63v
         C3KtO6hths9ALxfGLQrzYHxPMpST7knOyOp3JQuDgwbCK5IwThqORtlTRuucD0G/AwPT
         hlHaV8MFBwjmOZCewn2gOA/Up2f2fNaeOTYN51guB+pifsqyD573PE87fZ5fcUWxTqdF
         g+og==
X-Forwarded-Encrypted: i=1; AKwUvBxEs1kN7VXo8IopI2WT730DcDQAGXitJXNtRcQ0lrhtyWduA9Ka+Rhs89hMHjt/gDac7rbtSjs=@vger.kernel.org
X-Gm-Message-State: AFuF++kyg8+ji01UQHz8c4BXvdytdi8KdlWLQdWm4D40vqMSO+3Xykml
	cbky3/moE5CZhcwqD3Ir0d+oAregwkQY9haaIckTOiSfDyfHHfLN2kE5Wt5Qm/HsWQ==
X-Gm-Gg: AYBFou1ozyrcWIWvW75mdhrZjLuMyJQGriePmdFLjzJtLNfmFsFw5KYzH1s5nSfQF+F
	tfwz6hCHeyyWsYTiK7W1aWMbi1Zh/lqwqzkdWP25hLPh9h1/y7K26cD3fYbV7WhPD1nEHx/rjgy
	wNUz6TUIwRUhH20K2ZDcvLxsb6g+kc+c45XQINAq3zE/htc704j3LdYprPegrhC/bY52LejTqdi
	A5Tree9Xyf4BuwnTGaayWg53w2QKMWPmWOIOc/5pkx1AQffrbEwqFXLEMAaHYqSdIRC+eeNYUOK
	cKcrtoGBqnIyla7KhayGimI71SPzfaTA9vcissOC91L03rm8xzdQ5K4Dq+kRV06gx3VAst7KT9B
	ReBsmkk/5UvrHLBkBufyI6xPBCgXUWXAZcvaMMPOAr4Sw+SmDfexM6PJGuNGGh5wjCYEvexVajK
	jG+aRNoKkLUGwU8n6kA1m8XfyvHuH+zTBQnAfBGHrZXAKRJtQrUeZdvNhIOiLJKcVjmsqGO3ATG
	xClM3BtZ/P6u5c5SjT6czTS2t3pem4Gb2E1ZwhsOx2qGtMF8awQjsWKZKjm
X-Received: by 2002:a05:620a:2253:10b0:93c:bb75:d8f0 with SMTP id af79cd13be357-93cbb75f281mr147814085a.27.1790848868695;
        Thu, 01 Oct 2026 03:01:08 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cb657a11csm176651085a.35.2026.10.01.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:01:07 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	sashiko-bot@kernel.org,
	hybris <hybris@mojatatu.ai>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: act_gate: reject oversized dumps instead of wrapping them
Date: Thu,  1 Oct 2026 06:00:54 -0400
Message-Id: <QDISC-H19Z.v1.20261001053234@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to commit cfa165cbfbed ("net/sched: act_gate: budget
the per-entry list in get_fill_size") caught by Sashiko.
cfa165cbfbed sized the add/get reply from the action's real dump but did
not bound the entry count. An oversized gate therefore installs and its
dump emits a structurally corrupt message instead of failing cleanly.

Sashiko also flagged the enlarged reply as potentially something that
will crash the kernel with a memory-amplification / OOM vector.
We were able to recreate this using panic_on_oom=1 (128 concurent
threads GET on a VM sized at 1024M). In the past we have used
panic_on_oom=1; however,  I am weighing-in that: if i have to
create a crash using panic_on_oom=1 then that is a "hardening" issue
and therefore left to net-next. See the discussion with Jakub
(https://lore.kernel.org/netdev/20260914191108.55a1a4f1@kernel.org/).
Note: The issue is resolvable using an entry-count cap, but:
an entry-count cap would also reject gate configurations that work today,
so it cannot justify a stable backport - so policy cap is for net-next;
this patch closes only the malformed uAPI the sizing fix introduced.

parse_gate_list() accepts any number of TCA_GATE_ONE_ENTRY elements; the
only bound is the nlattr header, whose u16 nla_len caps the request at
~5460 minimal 12-byte entries. That is fine for the request, but
tcf_gate_dump() emits ~36 bytes per entry, so past ~1820 entries the
TCA_GATE_ENTRY_LIST nest exceeds U16_MAX and nla_nest_end() writes a
wrapped length. The enclosing TCA_ACT_OPTIONS and per-action nests wrap
the same way, and the outermost TCA_ACT_TAB wraps first, at ~1815
entries, so an oversized reply is already corrupt from there on.

Close those four wrap-capable nests with nla_nest_end_safe(). It returns
-EMSGSIZE instead of writing a wrapped length, and each site already has
an error label that trims and fails the dump. The output is byte
identical for every message that serializes; a message that would wrap
now fails through the same path that returned a clean error before
cfa165cbfbed, so no configuration that works today changes behavior.

Conditions to recreate the bug: CONFIG_NET_SCH_ACT_GATE=y; install a gate
with 1815 or more minimal TCA_GATE_ONE_ENTRY elements (12 bytes each on
the wire, only TCA_GATE_ENTRY_INTERVAL set) and dump it with
RTM_GETACTION. Up to 1814 entries the reply is well formed; from 1815 the
outermost TCA_ACT_TAB nest length wraps (1821 for the innermost
TCA_GATE_ENTRY_LIST). CONFIG_DEBUG_NET=y (default n) additionally trips a
WARN in nla_nest_end(). Installing the gate needs CAP_NET_ADMIN in a user
namespace; the RTM_GETACTION trigger needs no capability once the gate
exists.

Fixes: cfa165cbfbed ("net/sched: act_gate: budget the per-entry list in get_fill_size")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_api.c  | 9 ++++++---
 net/sched/act_gate.c | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e45a63be397c..c7e87491a9fc 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -549,7 +549,8 @@ tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
 		goto nla_put_failure;
 	err = tcf_action_dump_old(skb, a, bind, ref);
 	if (err > 0) {
-		nla_nest_end(skb, nest);
+		if (nla_nest_end_safe(skb, nest) < 0)
+			goto nla_put_failure;
 		return err;
 	}
 
@@ -1270,7 +1271,8 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[],
 			tcf_action_dump_1(skb, a, bind, ref);
 		if (err < 0)
 			goto errout;
-		nla_nest_end(skb, nest);
+		if (nla_nest_end_safe(skb, nest) < 0)
+			goto nla_put_failure;
 	}
 
 	return 0;
@@ -1684,7 +1686,8 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
 		goto out_nlmsg_trim;
 
-	nla_nest_end(skb, nest);
+	if (nla_nest_end_safe(skb, nest) < 0)
+		goto out_nlmsg_trim;
 
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
 
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 6d6d45e03c07..14801c604bd9 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -654,7 +654,8 @@ static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
 			goto nla_put_failure;
 	}
 
-	nla_nest_end(skb, entry_list);
+	if (nla_nest_end_safe(skb, entry_list) < 0)
+		goto nla_put_failure;
 
 	tcf_tm_dump(&t, &gact->tcf_tm);
 	if (nla_put_64bit(skb, TCA_GATE_TM, sizeof(t), &t, TCA_GATE_PAD))
-- 
2.43.0

