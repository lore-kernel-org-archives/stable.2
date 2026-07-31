Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CB3B058A;
	Fri, 31 Jul 2026 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491190; cv=none; b=n/n2AeBC8OJBArnM/sqcFA8TkUSKUX3fs3FngrOon6Y164CHTT/v0W/nl11bXUEO0HPcBX2E5OXpS+rFnvfj/QvszoJJ0AmUu39nYaCsHPwKm/ROayvNVG8fSMR9j2ZiRiLQLCyZEu7SHeIkwsKIVoqBnASfxYhchxH7xCVTMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491190; c=relaxed/simple;
	bh=sga4iS4mXhBATi/N6paKtspNFAbeqI79SpwLFcZd3lA=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=TrSxFcPabvW7EVkWdZJaGAn0pAW9txyQiiTc+nuYS8HUW53TLs0vaUJCikgvCribHDwEZpLNupd/lnZEdwE+SMt0KNjXCwXrbGyQrkWcVJVdnu0DTU1gl9g6KeMJWhb5ro140O5EWVUTSDYNzUys4eS1WlYkndACVnllyFIXh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BCaIWJOX; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BCaIWJOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785491180; bh=gp6fYo+i0fMLxQpOirAzYN/8+l/xwXXVFsY4/jAZV74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BCaIWJOXXRyz56nusVtd7FdLv0VyIUGfNsle35ddZTQ5e+b7l56gPK2vGOdi6eNRV
	 5bHrwRfrS8FqXZeU499V6xL1y3IBwFttALyZdYsDlrtA1qNpVrmsvfZiuQcX4tVFGw
	 5/XgdVdPN7dAEWXVa5Kz+NJOJLwItPeg+gyU7Sk0=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id B4623E87; Fri, 31 Jul 2026 17:45:06 +0800
X-QQ-mid: xmsmtpt1785491110tio7apm0y
Message-ID: <tencent_683AA16E643DE00211CD2FB62991264DC605@qq.com>
X-QQ-XMAILINFO: OV56TfPCuCfRMdrKAX23NWbIPRTyB/zafAeCFr57mMzwCYZUih+IIN+Ljwkd+H
	 1uK3rJao1cqGLTpdjN6VGReOdvVpili63rf7PbPZA+UjeuxwAmDkqSRFcGWDy1ioQcO1vVxAyVcm
	 ArBYcPiBhS6hh4u7226K+ueueMu6Yiy62itUPRlt3CK+mkBiFfnxTFHixdviXVY3ZfomwxIWUwVU
	 JJLhDpTf/yeLqFnS5qTbpZqjr881/EBOcm87XLJjHdApGFSclx6G77FeYDz2el22a8sUtsJ+qVmR
	 VAjyMyECfadK//csKM+xzkLbkcbsHNIg7vCafskBPUnzjUNYnzodg8RDdHVoVlgG4Xcyn9yHHKcT
	 9vqq7J3bxyvxURZTFQB/RSfSKLdPAPdfUEzJ6gUOBoH/sU4g9/vzrl3g5pMxUjPRjIRC+vrUGnqv
	 kn09MW3n7QXNhyZUE3A+N1f224NUTM4CMKrz3o/6RmB634hkOJ4Ca2E5DB5LCSsMLMjKJZKjafvb
	 j+/J3vHcAkDzPx7c7B9H9pxZ/MY0cI3K+5J8bQoUgE9dH/0asjXKqcEtfO52lSMzmJfAumGHCTMT
	 1QCyHr0xHqG2doPf/lrKP4jpJ56hce+GgIszjNfGTQhsLlJ1BUaFFK6EJNMynpFmNxwaEYAZI1D6
	 oE+NMZvhJJf3MuywVt7mjyjy739rsMTf1oX3FSN5xKLxVmGHBPBudhzWDskvCWlerJ48U+zzKGBM
	 2FQiL39bbRYUtfLP74w3CvjwBQ1xRixj6Ed31JYfHUUcqap/vs9ynPoRBG6+J6rdXKIXu+qY4il9
	 hVUkHauqj+lIMrAUHgZYvMOyeeCg3EWRxIPC0OvtQOv5D+CCLiAf8A7T/oai8fNLfXvCQLvBsE3C
	 iTBltS8AvmTLkcX3LIn7ByYWVFonjk8qlnDfHyCq0hvR9mVdNfoseVjOeomRbKMn9FHBFMmLGcK1
	 t8MJF2GKBZIViYhmDIUmXRp2SXx9kojvGlYM9XWkBXE8WoNgb54ov2V5iFJxnhdmNbYW49qbANRx
	 JxZ3mH8MKSw8TFHUi8dZtlzvtMotk0YW1VnHZ8kY3p73FriuoUCRy7TXl6of6mq83ZEt4uvMlpZG
	 /Z2QAWruW5TVm+o2w9p5qAydVsgbF/mdGD3GDOFRa2qLCEm9bv8lZMRQBfYeu1YqobSBtoIsNZnV
	 6/rXr3siBfcqdq4OyeSKiRLCJ85R3xTo9jDtE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Cunhao Lu <1579567540@qq.com>
Date: Fri, 31 Jul 2026 17:45:02 +0800
Subject: [PATCH v3 3/3] can: dev: can_put_echo_skb(): free skb on invalid
 echo index
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260731-master-v3-3-b56cd1e8d675@qq.com>
References: <20260731-master-v3-0-b56cd1e8d675@qq.com>
In-Reply-To: <20260731-master-v3-0-b56cd1e8d675@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

can_put_echo_skb() consumes the skb on all paths except when the echo
index is out of bounds. This leaves ownership with the caller on -EINVAL,
unlike the other error paths, and can leak the skb if the caller expects
consistent semantics.

Free the skb before returning -EINVAL so that all return paths consume it.

Fixes: 6411959c10fe ("can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds")
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v2:
- Free the skb with dev_kfree_skb_any() on an invalid echo index.
- Collect Vincent's Reviewed-by tag
---
 drivers/net/can/dev/skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index d34d3e7d4c9f..e985616c062c 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -54,6 +54,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	if (idx >= priv->echo_skb_max) {
 		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
 			   __func__, idx, priv->echo_skb_max);
+		dev_kfree_skb_any(skb);
 		return -EINVAL;
 	}
 

-- 
2.34.1

