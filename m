Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810633F585;
	Thu, 11 Jun 2026 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195880; cv=none; b=io0VR2SoI4foscPAEErf0vnBWOABhvFbp87FSMUTZWWimGlr7kNhzpohMLHcQ4G0E8xBmNiawrLYDTC4VhV1pICIjCEbDoJJxZRCVfowoYozpV1NJhGNpxqS0zQYrU8Nuy88Guf2lrURRVB1oecthpYK0kaBs+EPpZPKiezO25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195880; c=relaxed/simple;
	bh=2tj/KtXz7viCSArb/If5hec2upVXPx/kJLGbdyL42zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPTcHTlp+ZR6Q0Bc2iUEv63hcGgRtIVwE25yMqGhLBKIfv1bnkCFXu6zI+hhp2ULqbqb5U7hEIVbpQixqZih/zrdwQsIO67Okx7t/AUY+8iaOrPIu88eIdsvDsehTKlw4Dm8PB0vd5IPwYWOsLJQ+V4k5maI4wM3pU7tl3MRD9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowAD3Z+tZ5Cpq+kEaEw--.26165S2;
	Fri, 12 Jun 2026 00:37:47 +0800 (CST)
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
Subject: [PATCH] net: af_key: fix refcount leak in pfkey_spdadd()
Date: Fri, 12 Jun 2026 00:37:43 +0800
Message-ID: <20260611163743.99526-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3Z+tZ5Cpq+kEaEw--.26165S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wry5CF4DuF4DAw1fKFW3KFg_yoW8Jr1kpF
	43G34YkFs8X343CFs2ka4UWF1Fyay5Gw4q9a18Cr1Sy3s5tw1ruan5tFyjkF1fC3ykJay7
	Jry3Wr98CFyDAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0PA2oqzjQ-SAAAsK

In pfkey_spdadd(), an xfrm policy is allocated via xfrm_policy_alloc()
with a refcount of 1. On the success path the policy is eventually freed
by xfrm_pol_put(), which decrements the refcount and calls
xfrm_policy_destroy() only when it reaches zero. However, all error
paths directly call xfrm_policy_destroy() without releasing the initial
reference, leaking the policy object.

Fix the leak by replacing the direct xfrm_policy_destroy() call with
xfrm_pol_put() in the error unwind. Keep the xp->walk.dead assignment
as it is required by xfrm_policy_destroy()'s BUG_ON check.

Cc: stable@vger.kernel.org
Fixes: 64c31b3f7648 ("[XFRM] xfrm_policy_destroy: Rename and relative fixes.")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 9cffeef18cd9..013592086f1e 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2370,7 +2370,7 @@ static int pfkey_spdadd(struct sock *sk, struct sk_buff *skb, const struct sadb_
 
 out:
 	xp->walk.dead = 1;
-	xfrm_policy_destroy(xp);
+	xfrm_pol_put(xp);
 	return err;
 }
 
-- 
2.50.1 (Apple Git-155)

