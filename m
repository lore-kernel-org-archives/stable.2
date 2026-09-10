Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565A3E1D1A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032878; cv=none; b=o8MjQTT2ZPReCR1BrzIen07C8a0zid/NKA4cs8R6ZLP/JXVpmRJVVyDt691zX6YOXirGCAbtJ788YyNNLvd4Pt7Jfe7WzqltV9PcguHw4zY3xyd5HaAbQTxOr8v6fTH74nB7KfgePr6LCjVeYLufkXhPtFLNFnJ5Fzkwno6PhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032878; c=relaxed/simple;
	bh=pxNPuqInUXA5BhBex6CFLs+8pBKZ4qJtowlQoFJZa4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Onx7J8Qdd/drxYAvDESFRBG7veYEHFFpMVTSdp58C2ALY01YKEErtX2DymqBkjjUMouvU/dfjgiOgHNgok+ZLKDCWuyfavOMjdhzjw+P8BOQNe7IDRJHIqyU2bkIEdAYTzwPiSkB6Vt1t7En3tDCJYfJLTMgaywH0oJl+Wnc1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tfCRU3/j; arc=none smtp.client-ip=91.218.175.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tfCRU3/j"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pxNPuqInUXA5BhBex6CFLs+8pBKZ4qJtowlQoFJZa4I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789032874; v=1; x=1789637674;
 b=tfCRU3/j+Nemfjx1rtIU4R7iEj1EcpelSYw4gs7bQ+gnktELoxz+a4VT1a5Aqbhd9Sm9sXE0
 vjucqRB8PSJhvI89EnXme2VnIft5nk7uEv3I99DtqgAkpls11KDW9PKymL/TShhEayAAKk/bPe5
 YAF/qGVazVwSBZLywrcciEn8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5d418fa20c543b52;
	Thu, 10 Sep 2026 09:34:33 +0000
X-Mizu-Trace-ID: 5d418fa20c543b52
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	marcelo.leitner@gmail.com,
	pctammela@mojatatu.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1 1/2] net/sched: act_api: release tail references on DELACTION failure
Date: Thu, 10 Sep 2026 17:34:12 +0800
Message-ID: <20260910093413.34509-2-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910093413.34509-1-xuanqiang.luo@linux.dev>
References: <20260910093413.34509-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

A batched RTM_DELACTION request takes a temporary reference on each
action before attempting any deletion. tcf_action_delete() clears
each processed slot and drops its temporary reference before attempting
the deletion. If deletion fails, tca_action_gd() calls
tcf_action_put_many() to release the remaining references, but its
tcf_act_for_each_action() iterator stops at the first NULL slot.

When a batch stops at an action bound to a filter, this leaks a
reference on each subsequent action. A later delete of an unbound
action can then return success without removing it from the IDR.

Walk the full array in tcf_action_put_many() and skip NULL slots to
release the references held on the unprocessed actions.

Fixes: a0e947c9ccff ("net/sched: act_api: avoid non-contiguous action array")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/sched/act_api.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 37eced84dfa5f..86710a596a0fa 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1223,11 +1223,16 @@ static int tcf_action_put(struct tc_action *p)
 
 static void tcf_action_put_many(struct tc_action *actions[])
 {
-	struct tc_action *a;
 	int i;
 
-	tcf_act_for_each_action(i, a, actions) {
-		const struct tc_action_ops *ops = a->ops;
+	/* Deletion may have cleared entries before failing. */
+	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
+		struct tc_action *a = actions[i];
+		const struct tc_action_ops *ops;
+
+		if (!a)
+			continue;
+		ops = a->ops;
 		if (tcf_action_put(a))
 			module_put(ops->owner);
 	}
-- 
2.43.0

