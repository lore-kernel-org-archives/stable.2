Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D78E4A4F00;
	Thu, 17 Sep 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642747; cv=none; b=q61MJZ8CmieObDXegmjLml6lRZV/fkT1K8qOEqwpgo2yRwejBi5tW9g8eeehm2Bkxedc0QS2NzldFpNf5cMQCAzq4ZO3BAf2eEvBRja6BPOUwBlZ7Lb4kYugJAm6Cr+tgUyX5in6ZTc7enLJJgOX7LU9pbI/hOqt9JoofsnsCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642747; c=relaxed/simple;
	bh=sdUBXHXhyU/BIPuoV44D1DHJ8bJOufyy5HHk6/9LY3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFyaQaay0bEWsNnPydZon+4CzK+1mgwsqC4RnDi8tBY/twW7CcGqb8e/uGVXSVGk9/Is7w0pkxeO80XHyHtSvdMYt4FGceIZPoYJeyfCSbTyRC14dkFebnWxK9er6H38V1dK9vcyw1+43VqivcoR5AvD6lYLFvCOlAdtmVafLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3Hzrmx6tqChl_CA--.1287S2;
	Thu, 17 Sep 2026 18:58:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: ayush.sawal@chelsio.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rohitm@chelsio.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] chtls: Fix skb reference leak in chtls_send_reset()
Date: Thu, 17 Sep 2026 10:58:46 +0000
Message-Id: <20260917105846.2147976-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Hzrmx6tqChl_CA--.1287S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWDCF47ArWfAr43CFyUZFb_yoW8Wr13pw
	4xJFy2k3yDtayrJayxJ3s5ZFW5u3sYyry5KFy8Gw1fXFnxJr4xJF9xGF1jqrWDAF4xGFZI
	vr4kAanYgFn8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZF
	pf9x07befHbUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMNA2qrrRlXLAAAsE

chtls_send_reset() is given a skb holding one reference, to be sent as
CPL_ABORT_REQ. It consumes that reference on every path except the
TCP_SYN_RECV one: there it sends a TCB field reply built from a freshly
allocated skb and never releases the passed-in one.

This leaks the reference taken by reset_listen_child(), which resets
half-open children in TCP_SYN_RECV found on the SYN queue.

Release the skb on the TCP_SYN_RECV path as well.

Fixes: 8ad2a970d201 ("cxgb4/chtls: Fix tid stuck due to wrong update of qid")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 0e3e5cf52c2c..a363f20452fa 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -265,12 +265,14 @@ static void chtls_send_reset(struct sock *sk, int mode, struct sk_buff *skb)
 	chtls_purge_write_queue(sk);
 
 	csk_set_flag(csk, CSK_ABORT_SHUTDOWN);
-	if (sk->sk_state != TCP_SYN_RECV)
+	if (sk->sk_state != TCP_SYN_RECV) {
 		chtls_send_abort(sk, mode, skb);
-	else
+	} else {
 		chtls_set_tcb_field_rpl_skb(sk, TCB_T_FLAGS_W,
 					    TCB_T_FLAGS_V(TCB_T_FLAGS_M), 0,
 					    TCB_FIELD_COOKIE_TFLAG, 1);
+		kfree_skb(skb);
+	}
 
 	return;
 out:
-- 
2.34.1

