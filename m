Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C94A3F09
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264676; cv=none; b=CEBoKS7l4apd2/fxtH/4lF/WKIRZ91SnaG2qsgbijdc5ikKYNYIWrMGoD2dPKIBlZy4FRMB7LtJk7gPv/IFIfY1UM6EDxF9Pc6hlWQTcbVMeHD7gVfsU8TD5KzXa0uPIW7EftZKxwz/YaaHen1yYcpJgO9IF3j+j10H34yhPjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264676; c=relaxed/simple;
	bh=F722r79Bmh7PI6YVKi85BrdG6Xr35DU1IZmnFgeTke4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DTqv99QH/clDO23Ie2CQbVRZJBG1Ml3DUvlvrBjM1f+7gtNSNXxtw4J/CQG0qnHgwcmgjMfZv8x3JG1/vhYhtLSDxfmV4183Z8wutwbwFxzmVJo+/lbRLkT9cCUCVF5J343VNT3Oxs3Zjd5aSvLkUPXMKQefv4GpEuXz8BMrDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H82M+4IP; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H82M+4IP"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f4b7091dso39259d50.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264674; x=1790869474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CU0D2cxA3xiiAsXwNtIVwxMqp3c9ZGhfeXIr6+SStxE=;
        b=H82M+4IPvy+kYqBXwP4Umf2uK+bmolKK5KLVrqkxClIdAU7Wucr5CLWSWc+NC99t3O
         yNtiTeJWfgmIsZBq53hyQES5oiCXmuxfadEqfMkxtcJFQPLWu7OlEzjyj8Hjcvz3V6Fy
         WM9k71eILllPAiE3GkVxbZaO226HUg6EafFJjE7d+RJf7GDA3hRrzHN9zZpg52n31p27
         6K0QNB67VtZoqNZC7ar1x1lRW2RlkVnaFiNsBUokQ0FLODC0SJx6cQwu9QbSz4jURVyK
         BouQ66mm8ehnKrQWJgLXRxFaMIuR1pd+yZfFhFYVBPNGpheK13yZIUMhABbEAl2mvYhU
         t6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264674; x=1790869474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CU0D2cxA3xiiAsXwNtIVwxMqp3c9ZGhfeXIr6+SStxE=;
        b=T+FckSRrXJbwkrZ/vWJaEpVHO0OnbgHA4TdkDnExVbk/HcT0tcDX5ATybgqFZxnHfH
         biEJFbZ/cYhTG3cgBQ1BGz5DFJNpMyda/meelNFABD/a1keyEi5vFUtASlTaBdOS93FX
         ovjoxb75bjeosbcBk52r7yPDHEv+sK/YQKto0lYkqrVf5W/Z89a/lgoMZSFR4LUD1EoG
         qU3iIv9Zm+FMeGx+9THwGZN/jpLANpgSxCCT4i6cbmQtu7i/oytwdWSVwVRGpqNRqK0f
         DZurzGLrE1GHk5nIyNfOK4aSi/HGoTNsqIIvYxwcTmqrdoJuW5fV+KK4FTPTAjW+AeZU
         D9aA==
X-Forwarded-Encrypted: i=1; AKwUvBzgqjSZ6/Jdl7fpmrTVIDxOeBG9XRUd8RNpeicYsuCJ77aI1ho66FfVJE8s2UBB7IikmkuH4Tk=@vger.kernel.org
X-Gm-Message-State: AFuF++l98qSE6l+vd0PsIbWAiHNzwktoeoBea+WanemoqH6fb0hgKQpN
	pby/W4HOAdx9vcZiV5wNVHX20VH/3GC8nzLrdEjIJieQypgByi+MhrtQ
X-Gm-Gg: AYBFou3aANbiKu4y13n1Ap5cCNiRrBn4RIA2KZT4GPCws76SksZDSU+jxu7c80/vaeW
	LcmIct/d1IoTu+8dz9/TXVw5ZSjAyPSHVln72nUJ/u3ubD78x1d+NypNR7Dsx97bPa78zYhHVa8
	hNWvqcz5vO9MiT+Yx6oTMwxdcJDdBDo2guY12bvmbMC9g/u/uqK3nDb7yGvP+WVvLfAaL9BhB0i
	kjc5Rn/voo9aqRZmBlAKw75imtHwAC0k5YmAnKeD5Tjxjq5Z2//8oDED4O7qLSeppIwKZjDp4mC
	GICK+O75NPtCxj0/R7GIeepsCL4dyaCI0DcbSmKh1yK3db33vB3KLdR/rInsZ4M2nizga2O7beU
	IVfYY6Uduw7/GN1pSFcL5iGOu+Bqv8Tt4V7tCHoxtBphgwbm8EUXTdVdDCkVNTdOfZ80SezlqHh
	kYMq4C9+7KNbYOyET4ih7DijHuh3p90Hc96eVSVYF41N03eyoVy5jKQ66Ye4IHVFm2q8KV9cMPo
	464EC0nI275NekGAiSvIwaiD3LxaFvRblvZNxM4BSCPvOAL989u/LDrJTm5kUkoA0FvsbgArj//
	XkdJS+9B1Q==
X-Received: by 2002:a05:690e:4081:b0:66f:bfd2:6b80 with SMTP id 956f58d0204a3-672ed243db0mr1795049d50.4.1790264673706;
        Thu, 24 Sep 2026 08:44:33 -0700 (PDT)
Received: from willemb.c.googlers.com.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672d8052bc5sm2172549d50.4.2026.09.24.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:44:32 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	dzahka@meta.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tcp: prevent collapsing skbs across boundary in rtx queue
Date: Thu, 24 Sep 2026 11:44:12 -0400
Message-ID: <20260924154427.953800-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

tcp_write_collapse_fence() sets TCP_SKB_CB(skb)->eor = 1 on
tcp_write_queue_tail(sk) to prevent skbs queued after a switch to
device encryption from being collapsed into earlier skbs.

The fence is a no-op if all earlier data has already been transmitted
when the switch happens: sk->sk_write_queue is empty. The not yet
acknowledged earlier skbs wait in sk->tcp_rtx_queue with eor 0.

On a subsequent retransmit or SACK shift, tcp_retrans_try_collapse() or
tcp_shift_skb_data() can then merge an skb queued after the switch into
one queued before it.

Both users of the fence are affected:

- psp: devices only encrypt skbs with skb->decrypted set. The merged skb
  keeps decrypted = 0 from the earlier skb, so merged data sent after
  psp_sock_assoc_set_tx() is retransmitted in cleartext.

- tls device offload: the merged skb straddles the start marker set in
  tls_set_device_offload(). The software fallback (fill_sg_in() returns
  -EINVAL) and the mlx5, nfp and funeth drivers cannot handle such an
  skb and drop it. Every retransmit rebuilds the same skb, so the
  connection stalls.

Fix this in two places, for defense in depth:

1. Fall back to tcp_rtx_queue_tail(sk) in tcp_write_collapse_fence()
   when tcp_write_queue_tail(sk) is NULL.

2. Check !skb_cmp_decrypted(to, from) in tcp_skb_can_collapse(), as
   tcp_skb_can_collapse_rx() does on receive. skb_shift(), which both
   collapse paths call, already has a DEBUG_NET_WARN_ON_ONCE() for this
   condition.

Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 436495ff2271..4416cdf9bf30 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1232,9 +1232,9 @@ static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 					const struct sk_buff *from)
 {
-	/* skb_cmp_decrypted() not needed, use tcp_write_collapse_fence() */
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from) &&
+		      !skb_cmp_decrypted(to, from) &&
 		      skb_pure_zcopy_same(to, from) &&
 		      skb_frags_readable(to) == skb_frags_readable(from));
 }
@@ -2327,7 +2327,7 @@ static inline void tcp_rtx_queue_unlink_and_free(struct sk_buff *skb, struct soc
 
 static inline void tcp_write_collapse_fence(struct sock *sk)
 {
-	struct sk_buff *skb = tcp_write_queue_tail(sk);
+	struct sk_buff *skb = tcp_write_queue_tail(sk) ?: tcp_rtx_queue_tail(sk);
 
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
-- 
2.56.0.rc1.310.g51773c2048-goog

