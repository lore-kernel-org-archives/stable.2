Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CF35E93C
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922774; cv=none; b=ujj9/zJV3pHNuz4+1iMnPPT7S0T7kMIZoLxeJVku4pGEIGr2w/WvhHF/Nuwbbz0lFvTyQ1wJR6EgFPzTS1b8gcQp7T5+QriufN2oedD0SAme2RFSJHvEK0poFAFjFuuGFb4kkhvDCD7ReXgw4Ys+aIsnJ6RLXH3rtLc0PlJqjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922774; c=relaxed/simple;
	bh=Uf/n7QKFRPpvn6flJx97otAd8DbWAFxMfSF1vaH7eo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dCeBj/4XztPLN1DzcRZDRq7cRMqsJqGyjEyimGszrMabgU7S376E/oemDNoW6xWZGLO3Y9VU/DBrCxA/PRmuIaCkA1LtM/JyShmouOTZO20+5opeu7Eojf39CuUlvUw9hjCxA97v+H4Fg8VhS6s/7+jnQTV9KqZOSRHBMJ9oJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=f80RQC7J; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="f80RQC7J"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e65e18969so63033085a.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782922771; x=1783527571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ckI+JdAlb9UtyST/QGohWOrUDVT+c26uP+nZIENTBVM=;
        b=f80RQC7Jm5Pu6hIL0sGQdXf9RloZMK/3aX8aVDPqANSCCT4ND54+wKxp30+2TppTGd
         VxyaFP/BH0o1Y5u5YpDoTnR/hysZoPsfQW8JLW8Me0cfSWUz94iak/tyiFpEI+ppZIYQ
         5maEZI+wwfgBZqXPEsXXngOk/CFOQa1D4+F6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782922771; x=1783527571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckI+JdAlb9UtyST/QGohWOrUDVT+c26uP+nZIENTBVM=;
        b=TnawNInx6Dbm2ZkgQ1y4Zsy1UbUxr4lSzeoFKSeNZlAeyYWtRSA6HybA9FGt/4otIk
         qsF5I6qzj1lKEmoRMDhYp9CIHRX6rxuOWPFu/k/I2BA/+884zyqi4b31boVnvByG7odB
         mSQP7c1lMXNYZvKy09JjNw5h86wq0swqtmzexvVhHkYVuVwABx901Atg+FbYf/iEdONq
         dc1EmOy9sddohEkDUOH9AzEZ3BGAcz2sbis6NyzDISRshvMS9ZYMLGFWNkur3yzVro2/
         +jFauQnY1URV40Zp3tr5x6AX1/YEsHQBgNyzQ7IkDIl8tlRFHHiAZLPMEfe+ndS3EoyD
         gctA==
X-Forwarded-Encrypted: i=1; AFNElJ/D3v4Y7q8A0haAw+eZNfHO28pc0DJSRejD6nfhRMwAH1YccuoF6RdKrNXZq2ZW/FHmxgc2kbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMZkLv5v+Wsh+sTkKPSnxz1ag6ue50wk1DGJBpM9H1sFUY4e4
	mGAie2BcnrD7RkF70zo8vyK4yDnEptRHT/1IyENEB+lbqiJeqe4W6ksPklp5h4TRoQ==
X-Gm-Gg: AfdE7cmIHdbfO7MeOyLKLTFx7LusxtRhCZySujmf+wRbCDuBPK8MufzHjxa3lCstO5s
	rjBJ1FBClK2Z3uanuQCjwNE7Wyqg+mvNKLJ6zzH4dkVEnJfXoK1IZMjPUumkMDMjJI9+U+O/KZL
	4i0U9UEiuTTgsL99axzYeE8ICe+RhktqonVTm1P4M93uvBEaWAN3pm6QAfSUtdectsmAQZ4MvBV
	7WmxkfuJoDZcWmYIQeBeU4XrEcaWswWvQijMWm3d2zR4gk0Ulno16D4QI0VaTa/sQAJbfB6LQRY
	3eD/veiAZolYpVLmF9kh/9JBR5lrtGdVj6p+CTpQq3gZT1mafDDwnKAoEuKdGaGvqQ+g3PT1o/7
	CKk+wtnD9AAknW0VwyQnmzE75HbequoMZ2sWfVeLcNVQSznrH3yaEVQfRYcydWc30R9h7u2+8S5
	3JTT21EA==
X-Received: by 2002:a05:620a:7104:b0:918:7e9e:de74 with SMTP id af79cd13be357-92e696e9164mr915456185a.17.1782922771448;
        Wed, 01 Jul 2026 09:19:31 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6233a5acsm602066585a.35.2026.07.01.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:19:29 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	security@kernel.org,
	zdi-disclosures@trendmicro.com,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: act_pedit: fix TOCTOU heap OOB write in tc offload
Date: Wed,  1 Jul 2026 12:19:12 -0400
Message-Id: <20260701161912.125355-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a TOCTOU race condition in flower lockless approach between sizing
a flow_rule buffer and filling it.
zdi-disclosures@trendmicro.com reports:
The cls_flower classifier operates with TCF_PROTO_OPS_DOIT_UNLOCKED
(fl_change runs without RTNL), while RTM_NEWACTION holds RTNL, so the
independent locking domains make the race reachable in practice.  KASAN
confirms:
  BUG: KASAN: slab-out-of-bounds in tcf_pedit_offload_act_setup+0x81b/0x930
  Write of size 4 at addr ffff888001f27520 by task poc-toctou/312
  The buggy address is located 0 bytes to the right of
   allocated 288-byte region [ffff888001f27400, ffff888001f27520)
   (cache kmalloc-512)

Note: The result is a heap OOB write attacker-controlled content into the
adjacent slab object (requires CAP_NET_ADMIN).

The fix introduces reading tcfp_nkeys under act->tcfa_lock in all places
using a new tcf_pedit_nkeys_locked() which replaces the old tcf_pedit_nkeys().
Additionally we close the remaining TOCTOU window between the sizing read and
the fill reads by more careful accounting.
Rather than silently truncating the key count, which leads to incorrect
action semantics offloaded to hardware and secondary OOB writes if
the remaining capacity is zero or consumed by prior actions, we enforce
remaining capacity checks and return -ENOSPC if the required space exceeds
the remaining capacity.

Fixes: 71d0ed7079df ("net/act_pedit: Support using offset relative to the conventional network headers")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/tc_act/tc_pedit.h | 18 ++++++++----------
 net/sched/act_api.c           | 13 +++++++++----
 net/sched/act_pedit.c         | 13 +++++++++++--
 net/sched/cls_api.c           | 22 +++++++++++++++++-----
 4 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index cb7b82f2cbc7..97754ea0a827 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -37,17 +37,15 @@ static inline bool is_tcf_pedit(const struct tc_action *a)
 	return false;
 }
 
-static inline int tcf_pedit_nkeys(const struct tc_action *a)
+/* Must be called with act->tcfa_lock held to ensure consistency of parallel
+ * reads of the same action's pedit keys (e.g. flow_offload count vs fill).
+ * Note, this is only used for pedit offload.
+ */
+static inline int tcf_pedit_nkeys_locked(const struct tc_action *a)
 {
-	struct tcf_pedit_parms *parms;
-	int nkeys;
-
-	rcu_read_lock();
-	parms = to_pedit_parms(a);
-	nkeys = parms->tcfp_nkeys;
-	rcu_read_unlock();
-
-	return nkeys;
+	lockdep_assert_held(&a->tcfa_lock);
+	return rcu_dereference_protected(to_pedit(a)->parms,
+					 lockdep_is_held(&a->tcfa_lock))->tcfp_nkeys;
 }
 
 static inline u32 tcf_pedit_htype(const struct tc_action *a, int index)
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index b68be143a067..f141634df214 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -148,10 +148,15 @@ static void offload_action_hw_count_dec(struct tc_action *act,
 
 static unsigned int tcf_offload_act_num_actions_single(struct tc_action *act)
 {
-	if (is_tcf_pedit(act))
-		return tcf_pedit_nkeys(act);
-	else
-		return 1;
+	unsigned int count;
+
+	if (is_tcf_pedit(act)) {
+		spin_lock_bh(&act->tcfa_lock);
+		count = tcf_pedit_nkeys_locked(act);
+		spin_unlock_bh(&act->tcfa_lock);
+		return count;
+	}
+	return 1;
 }
 
 static bool tc_act_skip_hw(u32 flags)
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 0d652dea4a69..d4d47a9921f4 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -567,9 +567,18 @@ static int tcf_pedit_offload_act_setup(struct tc_action *act, void *entry_data,
 {
 	if (bind) {
 		struct flow_action_entry *entry = entry_data;
+		int nkeys = tcf_pedit_nkeys_locked(act);
 		int k;
 
-		for (k = 0; k < tcf_pedit_nkeys(act); k++) {
+		/* If the required keys exceed the remaining capacity return
+		 * -ENOSPC to abort the offload and fallback to software.
+		 */
+		if (nkeys > *index_inc) {
+			NL_SET_ERR_MSG_MOD(extack, "Not enough space to offload all pedit keys");
+			return -ENOSPC;
+		}
+
+		for (k = 0; k < nkeys; k++) {
 			switch (tcf_pedit_cmd(act, k)) {
 			case TCA_PEDIT_KEY_EX_CMD_SET:
 				entry->id = FLOW_ACTION_MANGLE;
@@ -606,7 +615,7 @@ static int tcf_pedit_offload_act_setup(struct tc_action *act, void *entry_data,
 			return -EOPNOTSUPP;
 		}
 
-		for (k = 1; k < tcf_pedit_nkeys(act); k++) {
+		for (k = 1; k < tcf_pedit_nkeys_locked(act); k++) {
 			if (cmd != tcf_pedit_cmd(act, k)) {
 				NL_SET_ERR_MSG_MOD(extack, "Unsupported pedit command offload");
 				return -EOPNOTSUPP;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3e67600a4a1a..ffeea6db8337 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3886,12 +3886,21 @@ int tc_setup_action(struct flow_action *flow_action,
 
 		entry = &flow_action->entries[j];
 		spin_lock_bh(&act->tcfa_lock);
+
+		/* Abort the offload if we have exhausted the allocated capacity */
+		if (j >= flow_action->num_entries) {
+			NL_SET_ERR_MSG_MOD(extack, "Flow action buffer overflow");
+			err = -ENOSPC;
+			goto err_out_locked;
+		}
+
 		err = tcf_act_get_user_cookie(entry, act);
 		if (err)
 			goto err_out_locked;
 
-		index = 0;
-		err = tc_setup_offload_act(act, entry, &index, extack);
+		index = flow_action->num_entries - j;
+		err = tc_setup_offload_act(act, entry, &index,
+					   extack);
 		if (err)
 			goto err_out_locked;
 
@@ -3945,10 +3954,13 @@ unsigned int tcf_exts_num_actions(struct tcf_exts *exts)
 	int i;
 
 	tcf_exts_for_each_action(i, act, exts) {
-		if (is_tcf_pedit(act))
-			num_acts += tcf_pedit_nkeys(act);
-		else
+		if (is_tcf_pedit(act)) {
+			spin_lock_bh(&act->tcfa_lock);
+			num_acts += tcf_pedit_nkeys_locked(act);
+			spin_unlock_bh(&act->tcfa_lock);
+		} else {
 			num_acts++;
+		}
 	}
 	return num_acts;
 }
-- 
2.34.1

