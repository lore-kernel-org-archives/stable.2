Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999480;
	b=EcrQN5KTlSifKPU703QQib/sfgoeZQtw+F4ohx0rm+VI4DKiL1ZbAZJ2Oth7GV/Blzzd
	 ixVx0Am8Lp/H0ppyTRxpibw4b7WPVqKeplXuRqGHSTMVpSnWi2hu+TrywAnmdaataNMFT
	 LwLtgVKX9v1C4fLP7R6OeYWCWYH0pRH0XvchQHdJh+ipOMM3JXhkAicAeFKzEsGzczdXB
	 1LSy3A3IG20uz31lnIKknFcCwCL+jGXNpenzmA8vrT1TZENNREjMT4Y2krKDV7eIgnCBK
	 NYaj43KEvvHDgNmjoNJYGYkQ6CutsEM28Ei52KFkNDEx5EC7Lk8nas+qmDq4nEkRbng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=UDszjkP3e6J/ldj/IovXua14w3FrBtTVVtfldVBDnUA=;
	b=HSyI4yheF/7KBy4sUvkUJe6H/yd0dZ4ncmo2dL9u6mrqG1fMS2f56isDbCOPXMFykf0C
	 9MEXLWRj34+a7hHQQIAkNjKwfnFM2SAzb2wNsetakcaoESYe7aOl/cZOdp88HfhhsVIok
	 xRIlljWBUUpeUg1pGf4IMIrKeRFXMfWOdkigxUan7E5FUkqc4Ja3NeB4NKLcD8WefXigs
	 BHTDz9m8BPHSY0jzGn5a1TnqLgGFefLUK9Uv1BXBMBowEF24P0RfR6NYSHs9Id2KXPEF+
	 Ahb/5NL8/HMa8ebLvXRsICxgMsXmF7edg5gq9EbH1KUm6LEigHvi76VTk6xCvpmX9fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=avNXL6TY;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22997606A321
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22997606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=avNXL6TY
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e96502e447so23019015ad.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999479; x=1793604279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UDszjkP3e6J/ldj/IovXua14w3FrBtTVVtfldVBDnUA=;
        b=avNXL6TY+rBzI1Wn2vgVg7teTpH9e8dgKMBOUIqtV407BaQ4QQL32MO7rbkwVFr21e
         rzAdGjabcTd91zciV2U9a1aCJUz6s0cm/qVVXLlbdaLGOnV/YSwbWi5ckmm9i/EZJBKj
         MF1KuYPwWnws+S8Kq9/y0d7WaUqIB4UT+sbsH5cGrLgRf3OMzHiJPJ8kLg1BTWnN4/KS
         Z0uCk3WxezZdhuPO83UDmgs1Y6x+16cak9DODPbynXjJFCgiPwi4jPZ28PxEZpu58YKu
         KjDtybBYWbNVWJG2QZroyiUrjCOPP+e3zR6HirfjXk6lfnaB6q0iggU2IX0QJ7oy7Mnw
         dS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999479; x=1793604279;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDszjkP3e6J/ldj/IovXua14w3FrBtTVVtfldVBDnUA=;
        b=Pn+/yKxYxzYpecQCp1N/ZmuDjCD+W00TBUlw3qYN42YJm+gLI4WD+Rn2TtSot1MAxm
         03oAq8dRni2o5baTJyFja+HpV8iusIDkCpmWpgdUL0177Sr90ZF1kOtphgPoRlpNywE6
         Q8rFY9qI9Ya5TqvVRPbp9dqlJMJ/7IAothMkiHqtQwZqRzYB3eBEM+1Lvx09Hn2U/Gqa
         +LJf0DRVcW1ZjeFd2nH5U+cbrEpaOLS4aLdnV8UVMHVXh0RAzQJmn/mPJHTBeJSu8QW9
         6qGmr68jwUheQPSEmwOCNwCFG0ih+VmEma1r+MTgHBObnlDZxws63VD0j7pZadaVIByB
         Tn1g==
X-Forwarded-Encrypted: i=1; AKwUvBykEWXtMJ3nPJbtycdALHKhPpmdRne6Y+5svr4FFfaYTJZmfjvBpnhZ+QGBsGAyJ+UDFRwAH6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUbl1drs9yA4x92MrYkJDd0q4rMrcmOXZ29MRRaSNyhHxwyKGU
	YDU4/3M01O/pJsioMGDrIsMgJPMQDdAat0L+N1lihmI/LOFpC3oDVJ2g
X-Gm-Gg: AYBFou32MPKHiM7GNrNJHlo95kpHQuyLcWX76YF0pBQqEHWA1V3bj2tMDjy4MnlRBCL
	TW6dXX9qYIZKKotwgLbw7+CsZ7gfJSTifWQdH2ob39McR0dgYSTim9uYl79lmp+XW2rp1AZ+5g6
	C8L8D+ErM7aypyjVSK6SGKueQlJUqn/po5ZqJ9tD3WK07Ax2vo/rdgaLyA1vAW6ntn5ddBX3rz7
	WGfsIMmlaefi0I0g/70IBi3KFBwqyIQ64Cm4OP0uRTuFpcOc4I/pnmIhdsLPOdyOAL7KlC14koH
	azLhxGsqv7dHEhb0ZD98B493alKRSWESSFkj7C9wIGhJ+ZKVXckrwojpAQ4osJTsYorMBzujBd8
	UqBC/zK1sCospRss42VDgIimJoFWFDQKB+j+7scD15rHGfU4kHQoI9wQDwHZBU0Mqp99gjKmJkM
	RqWZA6XRJutFlCVJ2+L8tg/mKDFnFKr4V/JoHyI30q7b3C+LjfSbTy1FObJTekmF1nkN8q+6g8O
	gqjHLhnLu/Uo2J965Pz5sFOltJWAOLKjWxhAdeHasgjD3Wm4t8b6h25c/UlweqBf5Clwyd9AcdP
	xVg0CnoaO3wiwr6DhgaAy7eF+Xrll5aQ8r/oFQJ1
X-Received: by 2002:a17:903:144f:b0:2e9:a16b:c251 with SMTP id d9443c01a7336-2ea9c03ed20mr54617845ad.3.1792999478994;
        Mon, 26 Oct 2026 00:24:38 -0700 (PDT)
Received: from 1137-patch.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1210f0sm12617335ad.25.2026.10.26.00.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:24:38 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: [PATCH net 1/1] nfc: llcp: fix use-after-free when purging local
Date: Mon, 26 Oct 2026 15:24:07 +0800
Message-ID: <1792999447.107874-1-xuyuqiabc@gmail.com>
In-Reply-To: <cover.1791171477.git.xuyuqiabc@gmail.com>
References: <cover.1791171477.git.xuyuqiabc@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.56.0

nfc_llcp_socket_purge() walks local->tx_queue with
skb_queue_walk_safe() and unlinks matching skbs. The walk does not
hold local->tx_queue.lock. tx_work, the LLCP send path, and other
purge or dequeue sites mutate that queue under the lock, so the
walker can follow an skb that another CPU has already freed. That
is a use-after-free and can corrupt the list.

Hold the queue lock across the walk, unlink with __skb_unlink(), and
free the detached skbs only after the lock is dropped.

Fixes: f31652a58bee ("NFC: Purge LLCP socket Tx queues when being disconnected")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 net/nfc/llcp_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817007cf..500c65e2a90f 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -47,7 +47,9 @@ void nfc_llcp_socket_remote_param_init(struct nfc_llcp_sock *sock)
 static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
 {
 	struct nfc_llcp_local *local = sock->local;
+	struct sk_buff_head to_free;
 	struct sk_buff *s, *tmp;
+	unsigned long flags;
 
 	skb_queue_purge(&sock->tx_queue);
 	skb_queue_purge(&sock->tx_pending_queue);
@@ -55,14 +57,20 @@ static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
 	if (local == NULL)
 		return;
 
+	__skb_queue_head_init(&to_free);
+
 	/* Search for local pending SKBs that are related to this socket */
+	spin_lock_irqsave(&local->tx_queue.lock, flags);
 	skb_queue_walk_safe(&local->tx_queue, s, tmp) {
 		if (s->sk != &sock->sk)
 			continue;
 
-		skb_unlink(s, &local->tx_queue);
-		kfree_skb(s);
+		__skb_unlink(s, &local->tx_queue);
+		__skb_queue_tail(&to_free, s);
 	}
+	spin_unlock_irqrestore(&local->tx_queue.lock, flags);
+
+	__skb_queue_purge(&to_free);
 }
 
 static struct sock *nfc_llcp_sock_list_pop(struct llcp_sock_list *l)
-- 
2.56.0

