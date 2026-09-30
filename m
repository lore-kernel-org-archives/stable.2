Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110495187EA;
	Wed, 30 Sep 2026 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803164; cv=none; b=j7XscG99PqtYvGk7nYOQzXK7iY8B6t6C5qH7G+RSykZHCq73opPT9TsDkJU9c0YXbwjbD04/dX3Xj0AtIuQF6Pm0ZzGss3JBmswzvKh2uF7vuZQY6Mb4AJe6VjC8klEaZdENjZ8O8ue1je2+JWTLhnWcRkEeaAMeG0lyjOoAyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803164; c=relaxed/simple;
	bh=B8mRYbZ+m95yrxQcBS9a9ZY5dJhC17OpVBUgNXjWQcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P1sk3vA3Jku4nH9RxH2JW3CVfdIrlQc0G39l1XJuiInmPnqL/7LFmjckRZAZ+rbpNSl4iIHQywd7KuOxLjuv3jtNb3YdsE2ivT6Qiq8/DJBpgMORVb/R1PK5bF0QGpseBfLeYHWgaqj/iX/c1QMmQANru4Y1JW0ePmcKDCPz5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=CwWw/Hvb; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="CwWw/Hvb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=qJBpt5kFbOutkT9AiY+svHLqSNY7CQVkyn/ViPMrz84=; b=CwWw/HvbiTFeR/ZOuYV+PHh/Mu
	SZUTDS/KeMRdANEal1e1HKefqlphkfR7waHykfVKiZpJhe96fECBch0nvRGm1HVi8mWIRCY96UMXJ
	LUfPLcyaBZJENgW2/wMedWRQWWQ5D80Y07yRhhBybZ56LlkJYHWZ0ATwRcIot0MNDHFIuF/LOW7aD
	xFQkZc+q5X3u0OkW8lWHLyyJOXP/Szr8CCTOXit+h6pFnt2F4H3PXcAPsr5jWuxtjj+k8NLKJRqZi
	/F8ytCN6/mZeoaKMuwh2YpqUYKvbqTxEJrVwBnDKMz1EOxry3rU5r8q7L7VbicGGtqCAy4X2uA1us
	wcofIVfA==;
Received: from [151.115.150.205] (port=38236 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xC1hy-0000000CYOw-1bKU;
	Wed, 30 Sep 2026 23:19:20 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: fix use-after-free in __tcf_action_put()
Date: Wed, 30 Sep 2026 21:18:40 +0000
Message-ID: <20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

__tcf_action_put() decrements the reference count before decrementing the
binding count. Another thread can free the action between these operations,
causing the binding-count update to access freed memory. KASAN reports it
as:

  BUG: KASAN: slab-use-after-free in __tcf_action_put+0x327/0x340
  Write of size 4 at addr ff11000000d46420 by task tc-put-pause/64

Hold the action IDR mutex across both counter updates and IDR removal,
keeping cleanup outside the lock.

Fixes: 16af6067392c ("net: sched: implement reference counted action release")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/sched/act_api.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e45a63be39..a422bc7 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -372,20 +372,19 @@ static int __tcf_action_put(struct tc_action *p, bool bind)
 {
 	struct tcf_idrinfo *idrinfo = p->idrinfo;
 
-	if (refcount_dec_and_mutex_lock(&p->tcfa_refcnt, &idrinfo->lock)) {
-		if (bind)
-			atomic_dec(&p->tcfa_bindcnt);
-		idr_remove(&idrinfo->action_idr, p->tcfa_index);
+	mutex_lock(&idrinfo->lock);
+	if (bind)
+		atomic_dec(&p->tcfa_bindcnt);
+	if (!refcount_dec_and_test(&p->tcfa_refcnt)) {
 		mutex_unlock(&idrinfo->lock);
-
-		tcf_action_cleanup(p);
-		return 1;
+		return 0;
 	}
 
-	if (bind)
-		atomic_dec(&p->tcfa_bindcnt);
+	idr_remove(&idrinfo->action_idr, p->tcfa_index);
+	mutex_unlock(&idrinfo->lock);
 
-	return 0;
+	tcf_action_cleanup(p);
+	return 1;
 }
 
 static int __tcf_idr_release(struct tc_action *p, bool bind, bool strict)
-- 
2.47.3

