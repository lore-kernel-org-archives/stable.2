Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE496439F9D
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879897; cv=none; b=KDFSuoonCjqi0TRfrEb8w7BHX2LxWEwBTYTvZ9BLSXrTYck6G/oIN72UfX16D95xtlOpSku5Oec5PRw0jFKMDDuMgynw8d6hELz13FiHf0Ntzcko0Dgcgo0P9P5AZJ1sb9BLUpEp5I2Rlrb9VOxCopshg9+oMH1FD9mTP7aAqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879897; c=relaxed/simple;
	bh=uqLWeexY0FUA91Iltdd+eCzei2kZMBM9T5pv9nPzzNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jcny+jNW7cN7xHwSsVdfM1IDW9NaUDYYUtMnB7siNJupepwQh3ay2ly4wHqIii44VGNU9uEW6YBybPLB4otYjcv6UiSbdS97YEpGdMiHh0Tfbn2PTfjoSWD2Z5j2+1BcWGOvNiIkWrk7Vz8JeeFOomKj7IDA8V11x/kyKa6LYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6csRy36; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6csRy36"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so2639585ad.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785879895; x=1786484695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4HhkYRTEt9owA8VmZCbbvuARD03O1U8pY4V0yqgNeZg=;
        b=s6csRy36MdWMINkGq+HcnKEHZLZfgGz+X0jbG0Ar48qUXJI2EYmcUAWWhLc+D1CBgl
         heGYLTXg0Z0Vcy3isijho/wEudaoxkWvqbWWdJpzQtLHX0ONlflLrinIRlSuf0CjjeLn
         71HVlQFJfsobYHwhXlca8RGEUxmWxUc//O8CukMCI2WcY2D6QR4v3puySgTxhdhNwm46
         L3REOFmrp/04qBHrNUnj4hGFEL6/iI/58ouM24z3p+H6sx82/ydHJyZDf5u0RIrb7lHF
         EGhWx21+5f3br4AU4qwhZv1/u/YJcVXcSFadLfp8DiL9hkZZ2lyvxAwbqgjHrXyfKmdD
         I5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879895; x=1786484695;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HhkYRTEt9owA8VmZCbbvuARD03O1U8pY4V0yqgNeZg=;
        b=YwzYKpTeLI/vT3QT8Xa9mAQcw1Lyz0cVKOV3WnIns1jWMMPkWq5qDa7k8hxUy4RRhT
         8qnFyau+/0M63bg0fARtN5XCQ/OuOXVgJA1ok1KklCq7uwPVnl73IBXvZQxlqjikJkSf
         kSGHiBdAOx17UAnEU+N6qDkqCjNxne2EmFrlfTs5T0zsRkS3TWOdfzSa/f9nO9fFx/wv
         MIIFTWLr6gqiFPbcV+Tu5z21j3rwWRpNuyJNYqCZMCn+tQqAZPwKWoLK14+LjIX/Y2v7
         NiSbCU32Xk73HySeirt/lZhMo1P7SVv5d6D4WoifJEM6qDLIv8z7fFhUnWnSqEXG8233
         pDvA==
X-Gm-Message-State: AOJu0YzRh4swsiWOIIF1XZmNtq3Xj8IsgSO0arleCgl23XDTpobGAHLK
	FKwJW2tvPec3iuOkTrin4ZBE9nhXq24aE8bSAApYT5pSlM8qUYxS5ioLzEJDSldnBYdIw+AFb5C
	hTLJyUbfvv/BGhoH9/b1IXQpODA8XtZxNE/NQYngUfHJVJdJBKzNHG0I72fiG7IaKk+Qr3C8euK
	qap1+3OAqzUdQUXFjneekkSWJa3Ow27xI=
X-Received: from plbkk4.prod.google.com ([2002:a17:903:704:b0:2cc:8a78:d849])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2310:b0:2cf:9347:f445
 with SMTP id d9443c01a7336-2d0ca757773mr15303635ad.10.1785879894882; Tue, 04
 Aug 2026 14:44:54 -0700 (PDT)
Date: Tue,  4 Aug 2026 21:44:06 +0000
In-Reply-To: <20260804214406.750710-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804214406.750710-1-tkjos@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804214406.750710-2-tkjos@google.com>
Subject: [PATCH 2/2 5.10.y] Bluetooth: SCO: Fix use-after-free in
 sco_recv_frame() due to missing sock_hold
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Sasha Levin <sashal@kernel.org>, 
	Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 598dbba9919c5e36c54fe1709b557d64120cb94b ]

sco_recv_frame() reads conn->sk under sco_conn_lock() but immediately
releases the lock without holding a reference to the socket. A concurrent
close() can free the socket between the lock release and the subsequent
sk->sk_state access, resulting in a use-after-free.

Other functions in the same file (sco_sock_timeout(), sco_conn_del())
correctly use sco_sock_hold() to safely hold a reference under the lock.

Fix by using sco_sock_hold() to take a reference before releasing the
lock, and adding sock_put() on all exit paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Change-Id: Iae15e58c35bddb5b78a13f48f94dcb83f00ebb51
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 net/bluetooth/sco.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8ac1f9a0222f3e947e75f37ac87115c74cbc0da9..d2a9e851386b6897a9fa873cdae8f191e80d7fbf 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -313,7 +313,7 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -322,11 +322,15 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
-		goto drop;
+		goto drop_put;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sock_queue_rcv_skb(sk, skb)) {
+		sock_put(sk);
 		return;
+	}
 
+drop_put:
+	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }
-- 
2.55.0.571.g244d577d93-goog

