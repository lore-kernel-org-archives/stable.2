Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE9196C7C
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787356832; cv=none; b=YZkKBi7DJbh3pq9G5tpl9JFomiIqEbQyLqVrjuwwc1D/+kF8teQRCypOG+iMQVAgQsy7+2eBMIIJlmIpbFQ4erYTsNiBYbHzJVj39mM+5kkwdSUbKP4JUmr0yULm5yEbP3VF+AS8GgTk8CGCL9PajzTt2KC68qCvNqEqugfsLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787356832; c=relaxed/simple;
	bh=SfaQPqYZ2TcCPfNmTQhPxeigT6af4F+W9zbI3dBjBSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwBIkl5N9G79hR5tQ9yPyeGFzhhe+fJQZMBSXtZHb3hbGkSJB/AFFI9n9D38t0MTI9nM9hD/becDDK5m03PeqSUi6reyJ5q7VxAO6MUnHpHGFxRAW37Sh1Fvb8wKjm5i/LeFLCFy4nFA6hn2pF0kgObwP+HIiAfjDMA78RSIhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Zi/dsn3Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Zi/dsn3Z"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cace91f112so17813215ad.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787356830; x=1787961630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3i9zm7U75qqZoEzuNvaSawAYL3AG1P0lNOfzOpKLfms=;
        b=Zi/dsn3ZOx0Fhrbw5BGKq5vDhggieae1XtEW88b6WZ6Wigplck3W8wpW/FEtkOArGb
         uw48HDPcST2fQMY9PWA71BGPA8tN9CPobvsJHcx9dZn6zRGE4BGgFX1VC0yQawNoqETF
         uYXnJ7GlBUD62rVOzouMIQsYCuFZ5Ht2Gx/Y4Sh4canjy+2nYt3QMXjxHVpOJFW06Rha
         wwOboRoNiMUVvrmKMZc//nnqCEXJDt8abC+QeUszmfFfhLOT3bXqqpCkH2Rx/SLM4rGm
         2+wGMjGYLkyGyG6Xhc0urOJHImCWWiFjbjb4YZw+OrC6fSo04IqYXX5Ljbwb9umXlCeA
         WZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787356830; x=1787961630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3i9zm7U75qqZoEzuNvaSawAYL3AG1P0lNOfzOpKLfms=;
        b=TXY78pPEQ/Px0QaCIhk9a+aI4YkE5JGcoxTKeKRXinZbiyaFbdvFRUavjpqSM5FHg2
         tT5wGhtmxWjHFFLdceL0RGirrGzpZTaxlrbNAzJ6YXbJbmcDzm7trJ5VFdzPs2y9DhaR
         uyRsdHMBz9zmsGLLyk0Cu/Ut9LlbknFtgL/t6z+mIvKdGYgBbAcNR+S5wlODJavZi1tp
         JV9cFLNSqU+IKiJqjrJBd0JugfodVpeEacF/Waavs31H+fGcuq1mDxmqqBhB031bP0s+
         /Iwt/3Tgpcf2hvBffk8Dmg1ZniY3OD/n7T26MIuMDfJ1emi59FWJL2b4V7XnLp3tkqdg
         Ef9w==
X-Gm-Message-State: AFuF++nRR1c3Fr1eh9sCACBjHolV8Kl9Cz2xKuaNnqd69J6QPkxoenAd
	wMzktQOnNs+kj+/uRAGmSONvBBxE32dxy07ercbkBRt8C95IsL3boX0bLnB/5iqK1PYbdx4AH3v
	su2lBx8s=
X-Gm-Gg: AR+sD101DIPjsNb1LJQ/VdcwcqRUFF/25HsQYcpYdHWWWpmjurEs5bmuMCnotgfKZyt
	HT8bBsukEu5NBbzJibkn8xM2xTKfKG/XVun8kKsGtZAjFGOxjXAFz2QAif41awcLmiM6wifz5nK
	r8gbbUgEG2hlrlcuH2UrpBSQqhWy12u7zBEy89Z9tcS3P/GCz/1QRMiw9iDl/ebeHWq+xkkLuQF
	L1bkzYvcxr9mA1k12paDomNJRMDemMDqbrGNBRLnYCMRaad5QUG6KNReOW9c51I0uaoAV3cPKv7
	+mLvP0l4hSA/BjHhUp3CinuLmwLikdfLQRkBjyO04MvzSjWDUJqB1l6ad5w08OcioOoXHlt3Szi
	uDLNDnFmLePD7zZfSdvLFQomXUnFEoVB79cQNSmJKRSaXXx7xK2XJCxVBOdtJDQA5jeKUiA4zfr
	W7UzXFH3VNFUTyEibZg2+Zau7h49lQST0/uc/t42twRo10mi9nT9TmGYVVMuQ7rAT5a3XbBC9PU
	jCtw+zTHSFkoKi9kmwCKRGpEdB3lKYfcaFktgyia0kac2AHo7Je7wGxcfLAMA==
X-Received: by 2002:a17:90b:39ab:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-395df686f1dmr3705527a91.16.1787356829643;
        Fri, 21 Aug 2026 17:00:29 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:fc5e:9d66:f144:bfe9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm1743425c88.10.2026.08.21.17.00.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 17:00:27 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: [PATCH 6.1.y 1/2] tls: fix lockless read of strp->msg_ready in ->poll
Date: Fri, 21 Aug 2026 20:00:17 -0400
Message-ID: <20260822000018.48130-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822000018.48130-1-artem@trailofbits.com>
References: <20260822000018.48130-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 0844370f8945086eb9335739d10205dcea8d707b ]

tls_sk_poll is called without locking the socket, and needs to read
strp->msg_ready (via tls_strp_msg_ready). Convert msg_ready to a bool
and use READ_ONCE/WRITE_ONCE where needed. The remaining reads are
only performed when the socket is locked.

Fixes: 121dca784fc0 ("tls: suppress wakeups unless we have a full record")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/0b7ee062319037cf86af6b317b3d72f7bfcd2e97.1713797701.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Assisted-by: Codex:GPT-5
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Prerequisite for 2/2, applied verbatim with no source adaptation. This
also fixes a real lockless read of msg_ready in ->poll that 6.1.y has
on its own.

 include/net/tls.h  | 3 ++-
 net/tls/tls.h      | 2 +-
 net/tls/tls_strp.c | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 037049def..b5856a280 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -122,7 +122,8 @@ struct tls_strparser {
 	u32 stopped : 1;
 	u32 copy_mode : 1;
 	u32 mixed_decrypted : 1;
-	u32 msg_ready : 1;
+
+	bool msg_ready;
 
 	struct strp_msg stm;
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 8304afbe0..9fd5867a3 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -167,7 +167,7 @@ static inline struct sk_buff *tls_strp_msg(struct tls_sw_context_rx *ctx)
 
 static inline bool tls_strp_msg_ready(struct tls_sw_context_rx *ctx)
 {
-	return ctx->strp.msg_ready;
+	return READ_ONCE(ctx->strp.msg_ready);
 }
 
 static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 850146ed2..32b57e574 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -366,7 +366,7 @@ static int tls_strp_copyin(read_descriptor_t *desc, struct sk_buff *in_skb,
 	if (strp->stm.full_len && strp->stm.full_len == skb->len) {
 		desc->count = 0;
 
-		strp->msg_ready = 1;
+		WRITE_ONCE(strp->msg_ready, 1);
 		tls_rx_msg_ready(strp);
 	}
 
@@ -533,7 +533,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 	if (!tls_strp_check_queue_ok(strp))
 		return tls_strp_read_copy(strp, false);
 
-	strp->msg_ready = 1;
+	WRITE_ONCE(strp->msg_ready, 1);
 	tls_rx_msg_ready(strp);
 
 	return 0;
@@ -585,7 +585,7 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 	else
 		tls_strp_flush_anchor_copy(strp);
 
-	strp->msg_ready = 0;
+	WRITE_ONCE(strp->msg_ready, 0);
 	memset(&strp->stm, 0, sizeof(strp->stm));
 
 	tls_strp_check_rcv(strp);
-- 
2.43.0

