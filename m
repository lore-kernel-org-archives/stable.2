Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCFF339399;
	Thu,  8 Oct 2026 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483297; cv=none; b=IDH7w5QfL+4mQykocfVf0anHpsjdWKdva8iXf5PUiwkcUcXRVCQbReqW1kBFdo2ZXxwnNho9wTkvKY++PIKFtm/qiP7bwHQX5V4efUb28kH9BNiG90KdUjOtFvWp7skHA50/W1FdQTO8FvolD00RYnvfG+Dolz0PKPa9lXi5jdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483297; c=relaxed/simple;
	bh=qR5BnTBaQnbBv+3i5ZX12qxKoVcwZ+J1+uyZdL+dP9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JUQzuTCCM5/5Txc/LcZ23x7HCwCG9GW/d76ojpaPbYkKXR+kg3/Xhtl6CAZaVoR2tHjFNme5gSc2kA02cebABmpXn0oD8cSPF4cqkQ0W4E7s7XwWWisIsO2+kkp3QgTUvajYWtdWWSkuGVYh32vZIpdUBpb9SjQUm6SqEa10LOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=dyStMKwP; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="dyStMKwP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8gcCbqmu2rTClPFAHfTZZJOSvVGZqAXvL5XQElcT8kI=; b=dyStMKwPz0561YnQueJAJJXoVv
	NDEvq0NI4hlD3KyiI5upCSxNw1BbZCo4jJsCzbpK9PykKDQyEeULIY3Tw6CEHz1AKh1XnXPIm0r52
	ig5fYkJ8PPf+oyXHHQg08QEobFxVC4QEjtQZELFvZtraC92V5yTosgZ5dDJtaHYVMcravEIXcYpBH
	0lMTnKky8ioNMue7/1htH6+1T4v/WOVsiy5xAuO44uZ3eqNIsxIH8ldL6pAz+kXVlKLFWypAf9MmD
	4Ie2cVM94quU/2j8un92YT+GE1d89WIw56Fh08TvRgU6SZsA9jrGvJ20p2d1p2yrN/DmWKsAATbml
	7G7d9DLQ==;
Received: from [151.115.150.205] (port=54770 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xEsdp-0000000HGdw-0RU1;
	Thu, 08 Oct 2026 20:14:53 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/sched: fix use-after-free in __tcf_action_put()
Date: Thu,  8 Oct 2026 18:13:49 +0000
Message-ID: <20261008181348.527035-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Change in v2:
- Invert the condition of the test.

v1: https://lore.kernel.org/all/20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr/

 net/sched/act_api.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index e45a63be397c..9eb1dec14cb1 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -372,9 +372,10 @@ static int __tcf_action_put(struct tc_action *p, bool bind)
 {
 	struct tcf_idrinfo *idrinfo = p->idrinfo;
 
-	if (refcount_dec_and_mutex_lock(&p->tcfa_refcnt, &idrinfo->lock)) {
-		if (bind)
-			atomic_dec(&p->tcfa_bindcnt);
+	mutex_lock(&idrinfo->lock);
+	if (bind)
+		atomic_dec(&p->tcfa_bindcnt);
+	if (refcount_dec_and_test(&p->tcfa_refcnt)) {
 		idr_remove(&idrinfo->action_idr, p->tcfa_index);
 		mutex_unlock(&idrinfo->lock);
 
@@ -382,9 +383,7 @@ static int __tcf_action_put(struct tc_action *p, bool bind)
 		return 1;
 	}
 
-	if (bind)
-		atomic_dec(&p->tcfa_bindcnt);
-
+	mutex_unlock(&idrinfo->lock);
 	return 0;
 }
 
-- 
2.47.3

