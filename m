Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435F34B1AD;
	Fri, 12 Jun 2026 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781230195; cv=none; b=j7VpXxQkataW86GGOSwpy3CLX+UoOWzYe+Ev0dHWm6/qe3oG1F7+vNpYg2KozX3DhCbCEzMvREGgX4kuzuY3SbSPQR5IiG9qK4Nv+n1BiSe3gN0RZru3pscZ2PMeQEkJs0g9JWu1RzxGFM2D6fdcUfc4dlE6hRQr5hmsApUGiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781230195; c=relaxed/simple;
	bh=9vjxgLrrIrxJwwXQMNuXmt1TdJMQMQWXyLf4ko8MckI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5YiLtjoQpoQSvEKSplMfBJk3KSyu3tkziFvLI7VS646nAfkLiMT0fyS062daE3qLH60xLhnrA4N2BcAhUH/F228nOfO19yueDdHxH3GL9P1pYX6gy0qOCRNAqpHJX1EJVV7sZQTkvuezGQNa1Ulvlki2pOIn3+xiLb1mX7VeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowACHKtNmaitq95VbAQ--.10628S2;
	Fri, 12 Jun 2026 10:09:43 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net/xfrm: fix refcount leak in clone_policy()
Date: Fri, 12 Jun 2026 10:09:41 +0800
Message-ID: <20260612020941.12694-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHKtNmaitq95VbAQ--.10628S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy8KF1xJF48try7Jw45GFg_yoW8Gr1rpF
	4UCasakrs8Xw1Ikrs7CF10gF1IyrZ8C39Fk3yrCw1jy3s3Gw1rua4rCryUKF1xArW8Jr4U
	XrnxJrWUKF1DXr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4QA2orL06fegAAsR

In clone_policy(), xfrm_policy_alloc() initializes the refcount to 1
and sets up the timer. If security_xfrm_policy_clone() fails, the error
path uses kfree(newp) directly, bypassing the proper release through
xfrm_pol_put(). This leaves the refcount unbalanced, triggering
warnings if refcount debugging is enabled, and also skips
xfrm_policy_destroy() which would clean up the timer.

Replace the open-coded kfree() with xfrm_pol_put() so that when the
refcount drops to zero xfrm_policy_destroy() performs the correct
cleanup and frees the object.

Cc: stable@vger.kernel.org
Fixes: df71837d5024 ("[LSM-IPSec]: Security association restriction.")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index dd09d2063da2..3074692b4556 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2421,7 +2421,7 @@ static struct xfrm_policy *clone_policy(const struct xfrm_policy *old, int dir)
 		newp->selector = old->selector;
 		if (security_xfrm_policy_clone(old->security,
 					       &newp->security)) {
-			kfree(newp);
+			xfrm_pol_put(newp);
 			return NULL;  /* ENOMEM */
 		}
 		newp->lft = old->lft;
-- 
2.50.1 (Apple Git-155)

