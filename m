Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9893F329F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883111; cv=none; b=guzjMaGNLZ/nAntS7LW5zWT4Rp0f+ZWzJxAfn4fgUxTECAlLNgY8Hr71ofyGNshf9unmzQnr5+cBUZSow2NTQcTccQLhalwwHfQRE60HBxPOQCr3yKu2vpWUmDnM1JcY80m33TKBw50SvtHuAVG0gFqpqc6ff9Og0tMPiftm3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883111; c=relaxed/simple;
	bh=Qw8zae9NOxAk0It4XupnieJPLdroSQEYcZSuuA8SXV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPW01npG103UiMYGQpD1bW7yn/MtyA1CK/YlLQWCnNbXis2HnKrXSbU5ylACku1Q7cFlTRwhwg8+FjR0TahotoORqEcQfczrTpwyWIm4f/tlF/CEPGjGLTMi9bodYdzyYjFsGECYMIzXhAxVZkzGSowMPZSaqlYsBtsyiNNaYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRSPCnVn; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRSPCnVn"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3550dd02c9cso208354eec.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791883108; x=1792487908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJeGv4gE+1nP/kqGfhMNUpT5saqR4ArNAelaYTNhWl0=;
        b=hRSPCnVnM+EHmuYlE6ocgu8bFlYbbx0yCbV2F6dkIDyPBWkKHOffX8JJhRlcrv5N8+
         2zga9kSqa1Os9SMjjI/Dp+IA5OU8ID7CsEDA5DIGR1cqp3Ou4cjHYvmb/4KLprqJfk82
         B9RDQdRqMDQgjt/cSOBuD8LRNW4CR142xkWL9vYPOcPkhyX3tD9RwSt0X/ByxWVBH8q2
         Ajc6u9oqWonfo4LMiWOElLSBqwdiZWVKGVGolb029gkYrKiKXEejg8a0VlJYe++z1ndE
         go/l1R8QZjlfOsa6SV9emb7iPHXHaIgLoNeAG2WQOCn89P+jkXmDXXecrNYXIPovevrV
         iBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883108; x=1792487908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XJeGv4gE+1nP/kqGfhMNUpT5saqR4ArNAelaYTNhWl0=;
        b=xpdXJwjnzIuMlLeCpPuoeoAvPB5aQI3YqPnQ02eJBDCSWKCUkJbs2iBy2S+SJLgTT2
         gd/1tkjVSQTFH4phLFs5dtoGd/w4YgOz9Bfoht+2Ytser5qgbSLGhFpSdMST9TTmZrsO
         gKgHsKOg+CkKAUwpJt35J+bzIEnHvEi1OKvZJKtgK3Rg6jkttG1iOCa4GZOFA/hLc6YU
         ghi3qoh1Dn+CtSOIKy/2yLZQKi8j4z/wVxLKZnlh2dgEUeeQzbfnOlDEKs7VsdSwab1y
         zLRr3vKqAs9ySX+EhweKnL30Ev4zjoYZPS74r8NX35PDH2aXs6zEEiuqCPh+nNuhZuXL
         /SuA==
X-Forwarded-Encrypted: i=1; AKwUvBwbpTUgRbXc/CU3KlmjkZD0dg56cyG/edCWvBn7EoaM6YHQS+i1JqEO5vXY5rijIoyV1sxEQBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUmdCp+rr1ZqOf8rSP/XLG5paKjluxkBg7zFJJxZqjsM2l7xt7
	RKatovB8NgXw9w+l0ZA5Wvsjq2jDpyk91DuIpYTpxDMUfGDgA7RlrwTp
X-Gm-Gg: AYBFou3VXDnxY5keg23CRVCm7dK3BWWOcJUBcJcnJmK47gAIKo+b/War8OG8pg8ZOUp
	AGm4lLBAzKhVksGLDmc6mFgG65/DQKkNi8/1B3solHPjFeiOiQzl4yNq/Z4UyE4NSwja62JmLI0
	GzKs0mFW7w7SxkbFeqyzx92qqBdVy0RGsjFQ++m0szIMOmDBadHLb9RQU2k+t0HfVpbJux6HLdO
	plGFtKqUsHuNySu8eJpRjjIHQYSWjY1FBrBpxXx6lPdWFRDTSoZ+JOrPyYvkzMGpd+4ndJFE7dn
	/5jeDIWymxs/T2aJl4KemLnRrKC+w74itf0h7GewJIw+5ABkZdHJQRJ5R59KZbGZPHUt37q00jn
	TKKnKw32raFeTRNn/MEt7Epn3/XydqyGwkljS52BtbX19hsWmfq1AF9tDRclcLR/tFU0bpBO9iZ
	SfxCtYzPW6uRcc9bY8Xdah9AzhdO1TSoSNX43YmgxjLNtwhRR/0JVfi1N66XL73/kwiRuLT79YL
	+IItyMowRipiw/ZSgTvPpv3UT77yaNCfTp6ec+cXN+8wfOZuDYlZrUSXupLSpCBKkItQoG48nU=
X-Received: by 2002:a05:7300:d40a:b0:359:8492:20f8 with SMTP id 5a478bee46e88-35984922315mr16399593eec.2.1791883107751;
        Tue, 13 Oct 2026 02:18:27 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm41437975eec.30.2026.10.13.02.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:18:26 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	mjambigi@linux.ibm.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/3] net/smc: hold a link group reference for free work
Date: Tue, 13 Oct 2026 17:17:16 +0800
Message-ID: <20261013091716.1210420-4-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013091716.1210420-1-nicoyip.dev@gmail.com>
References: <20261013091716.1210420-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__smc_lgr_terminate() cancels free_work asynchronously. If the callback
has already started, it can still access the group after the terminator
drops the last reference. The callback has to dereference the group to
find its list lock and check freeing, so that check cannot protect its
own access to the allocation. This lifetime gap was identified during
code review of the scheduling and early-cleanup fixes.

Take a group reference before mod_delayed_work(). Keep it when a new
execution is queued, including when a previous callback is still running.
If the work was already pending, release the extra reference because that
pending execution already owns one. Release the queued reference when
cancellation succeeds, or at every callback exit when it executes.

Use the reference-aware cancellation helper for connection reuse,
termination and cancellation of a rearmed instance by the free worker.
The callback's reference keeps the group alive even after smc_lgr_free()
drops the teardown owner's reference.

Keep cancellation asynchronous. Waiting for free_work from connection
setup can deadlock: the free worker drains tx_wq, whose worker needs the
socket lock held by setup.

This builds on "net/smc: serialize link group free work scheduling" and
"net/smc: serialize early link group cleanup with termination". Together
they close admission before cancellation and give resource teardown a
single owner; the work reference then protects callbacks that are already
running when that owner cancels pending work.

Link: https://lore.kernel.org/r/179113886433.434549.10069135669585050618@kernel.org/
Fixes: 13085e1b5cab ("net/smc: fix deadlock triggered by cancel_delayed_work_syn()")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6.1-Sol
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
New in v3:
- Address the independent running-free_work lifetime issue reported against
  both v2 patches by sashiko, with the complete reference protocol in this commit.
- Cover new scheduling, rearming, all three cancellation sites and every
  callback exit while retaining asynchronous cancellation.

Review: https://lore.kernel.org/r/179113886433.434549.10069135669585050618@kernel.org/
Review: https://lore.kernel.org/r/179113886579.434549.12546097168507601074@kernel.org/

 net/smc/smc_core.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index c1bb284c4233..9b54f873c6a9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -89,14 +89,22 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 	 * otherwise there is a risk of out-of-sync link groups.
 	 */
 	if (!lgr->freeing) {
-		mod_delayed_work(system_percpu_wq, &lgr->free_work,
-				 (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
-						SMC_LGR_FREE_DELAY_CLNT :
-						SMC_LGR_FREE_DELAY_SERV);
+		smc_lgr_hold(lgr); /* released by the worker or cancellation */
+		if (mod_delayed_work(system_percpu_wq, &lgr->free_work,
+				     (!lgr->is_smcd && lgr->role == SMC_CLNT) ?
+					     SMC_LGR_FREE_DELAY_CLNT :
+					     SMC_LGR_FREE_DELAY_SERV))
+			smc_lgr_put(lgr); /* pending work already owns a reference */
 	}
 	spin_unlock_bh(lgr_lock);
 }
 
+static void smc_lgr_cancel_free_work(struct smc_link_group *lgr)
+{
+	if (cancel_delayed_work(&lgr->free_work))
+		smc_lgr_put(lgr); /* cancelled work will not release its reference */
+}
+
 /* Register connection's alert token in our lookup structure.
  * To use rbtrees we have to implement our own insert core.
  * Requires @conns_lock
@@ -733,19 +741,19 @@ static void smc_lgr_free_work(struct work_struct *work)
 	spin_lock_bh(lgr_lock);
 	if (lgr->freeing) {
 		spin_unlock_bh(lgr_lock);
-		return;
+		goto out;
 	}
 	read_lock_bh(&lgr->conns_lock);
 	conns = RB_EMPTY_ROOT(&lgr->conns_all);
 	read_unlock_bh(&lgr->conns_lock);
 	if (!conns) { /* number of lgr connections is no longer zero */
 		spin_unlock_bh(lgr_lock);
-		return;
+		goto out;
 	}
 	list_del_init(&lgr->list); /* remove from smc_lgr_list */
 	lgr->freeing = 1; /* this instance does the freeing, no new schedule */
 	spin_unlock_bh(lgr_lock);
-	cancel_delayed_work(&lgr->free_work);
+	smc_lgr_cancel_free_work(lgr);
 
 	if (!lgr->is_smcd && !lgr->terminating)
 		smc_llc_send_link_delete_all(lgr, true,
@@ -755,6 +763,8 @@ static void smc_lgr_free_work(struct work_struct *work)
 	if (!lgr->is_smcd)
 		smcr_lgr_link_deactivate_all(lgr);
 	smc_lgr_free(lgr);
+out:
+	smc_lgr_put(lgr); /* smc_lgr_hold in smc_lgr_schedule_free_work() */
 }
 
 static void smc_lgr_terminate_work(struct work_struct *work)
@@ -1576,8 +1586,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 
 	if (lgr->terminating)
 		return;	/* lgr already terminating */
-	/* cancel pending free_work */
-	cancel_delayed_work(&lgr->free_work);
+	/* A running free_work holds its own link group reference. */
+	smc_lgr_cancel_free_work(lgr);
 	lgr->terminating = 1;
 
 	/* kill remaining link group connections */
@@ -2029,8 +2039,8 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 			conn->lgr = lgr;
 			rc = smc_lgr_register_conn(conn, false);
 			write_unlock_bh(&lgr->conns_lock);
-			if (!rc && delayed_work_pending(&lgr->free_work))
-				cancel_delayed_work(&lgr->free_work);
+			if (!rc)
+				smc_lgr_cancel_free_work(lgr);
 			break;
 		}
 		write_unlock_bh(&lgr->conns_lock);
-- 
2.43.0

