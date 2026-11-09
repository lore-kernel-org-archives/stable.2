Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226979;
	b=XVPdB0q0M2iyF5jFe6IeIfSSAGn1jGN4zqZ0M7OOe0QT2oEG8ZLBpmv2Mf6gzCs3W5Xg
	 JpC55xCyRrWCayj9lMYlwgGPv15Tgx6xitVrf9RXGhFx60wwaRP3s2QyrmgB9CNgrvdmc
	 l9+OBcD7eGPzwVzOZ7SDK+/KZvh0595Yx7BPxqVWP1yGFN/8m2mpJQlBRwYdjaPJDnFrk
	 ddrbH+HHzt1B0Y48YjhCmbnZW3c2FNSaa4u54wIuyYv/ReK/V6Ay4BIDZBmDsk9CLPMWB
	 mYkmH+0eE0NazFS4UHifJfUjTz9wIvPuYHNmhX3MmE31ea63+dfzkFqLplfsDfNbxQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1uEBzQLVNMcLf8jWdf0mW3ZcQyTVXswBezUr+ycBWNg=;
	b=xpUhFL2mBs6Q++F6ae6tDKxAx4bxktrl+Ps4F1FMrO1XGsRAkym1mO0u4AU/BkeeBLxI
	 yEkbUBECk6FpChnqkb4iLDtmKYyqvD68HXFLG/A3vAViCb7nKYwzrAEgUj0XCEgRIOg0E
	 Apu3hMc485wT0cQhl4veCRq9TINXgL6N9FBS8UwmS0kmzcFa0NgJltkZ6Cu+fDhsbhC92
	 S4WoaG/ZBKD6Wyb8wL1PmZBmGxgWYVsPbQLmvOU8O2RLpmDM+Sn17Mfu+Ky2KWWATPf3e
	 eP6YGrwf8AbVV9lw+fhNLlqJz5zLjEQ3R+tWIufnNrRTf7NF+59+cteDavlXyK3MHtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAYt3iLF;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A24606A335
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7A24606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAYt3iLF
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so9928125e9.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794226977; x=1794831777; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1uEBzQLVNMcLf8jWdf0mW3ZcQyTVXswBezUr+ycBWNg=;
        b=pAYt3iLF+rH3TSVo+9U16LYFA7TV4QKtgHNih6f9YggilLt3eL3okvA0RIeH/41aPM
         gc5cHrnZ4dyoAQkrluDmeCq6bWryzXuTS0edN4nf2HxDJGX7LAI8VJGddu/f/gNb+ZP8
         nqb6UzM6+NpQzLWVp5fI2rmUdMippufcxKLPj3ioD+a6J9+SrzrxqLxJU8cWv+F7xpII
         IthtAeq5keVA71oKKdRflUbWmWJSOwGxW856k8gbiZoPq6qOeRNJkjHjt+C1Z/fT5Xjg
         7pjcCvtboezgFVuU0p1uCbGKpvZwz/cH2M24J62SSJODWxj3zzDsHkngrSy8RCri5NRf
         uWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794226977; x=1794831777;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uEBzQLVNMcLf8jWdf0mW3ZcQyTVXswBezUr+ycBWNg=;
        b=DfSnii+n85InKVm3IaKutYAKaD2UR00S6yKg5sxeutmv5T2vVp5OxTp9BJqjwISqC3
         WqFJYmuZ7oTJ9vKH6ATTZEXaj5myF+QHSe5pn2S9xuKNqxNYrcQhqKOMC1o1DsfezcIg
         JD57g3FiLg5Qxfyrn1xU4/xKzF+x9ywg4dBDP9lttaCaaArwOXaC8lErY8qNDk2vAIGK
         w0fYjGoPzeHLP1gXmjqKiQv8dy7o4O+D56veCBwoRx0QvwMgLN/gsrWLQ21lpLJO4E4V
         Go5jy76Rp3BkIxKib7+xuR91Eak6KoFfPEenbb51WZXDDFjOoiO4Fzl3MnSYXXT2pKrm
         c76Q==
X-Gm-Message-State: APuU4Z9LIVwKEPvZCV74G8WyJfpCx06JLQw5ydzVkpPANPFHAmLXCcnR
	vUHV+Yzymq5QSPsa8hTtHsx5OwtdV9NFk1+ELX7izLsJsWCseQXI2TSi4qlsixyG
X-Gm-Gg: AYBFou3oQIVLJdHGFnArmBxwPnTZVKW8ETPSAhPx1Qo37VGfBJvMiFRFDTQD47NZ9co
	XBO1m/Q0UUQhGrQozjelKpFD92hAtLdOwwLukuBl87xBPiiP09QIzFZzY+9GTjz9RMu3NtwYJSZ
	PwWx2/qsMtx0A7W+7BGjSE8f1LTLqZxkLmCd+mAHTp3CS96JwRXWqZN7W3nw1C4H29u3RQp1NEU
	K/IfmJhp+g2U1/LvgF2cKIWLFAJPhT/aQOaZwwe2T7f0F6Ceu0N5ZM40nXgr/RkeZAo+NCA8qDP
	oDQpfHJY5WgpYunKe4Bm3YZ0havq5xpHEcGVzcd4S+IOhqAxgJiZZesS5z+7KzXJRIwLGmTxXXd
	WebgMuTNf0SIDrnLU5m44OUvzEV01JoAL0DfITKJwl/aR7Ep86D1jTS972ckiTIpxsB6b7BrvBn
	x/Ry5J0CA1iToGfVRgu2Sx0vrknE3xAvSxTfr2UokzBFrhS1ljpbiawY8zobsIbROoGyF9Ch7gi
	EaANzX1eORxLFLFfSjtnEeroco89ECCXYZWlmItIHgKnZ8F8dLzIiXNFIvwpti17EffPIkGV08x
	EN5w0FNvDGNIbfkpWL2tLwmd1RJ7IRCBs7bD7dX7YvuWa8P2BWe3spR1gB8ZzBb/nnfp842oGBE
	TszHHFvA=
X-Received: by 2002:a05:600c:8714:b0:4b4:262b:88a2 with SMTP id 5b1f17b1804b1-4b94d762f82mr69307955e9.1.1794226976748;
        Mon, 09 Nov 2026 04:22:56 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795024730sm170813445e9.4.2026.11.09.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:22:56 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Date: Mon, 09 Nov 2026 15:22:54 +0300
Message-ID: <179422697447.5131.3947908931395034167@gmail.com>
In-Reply-To: <179422696909.5131.4005481731765358036@gmail.com>
References: <179422696909.5131.4005481731765358036@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

This reverts commit 3c5fb3a6c8118d15e60295e76fb5b879021eef43.

The upstream change removes multi-register byteorder support and is
tagged stable+noautosel because nftables versions before 1.1.0 can
generate length/size combinations that the removal rejects.  Backporting
it to stable can make existing rulesets fail to load.

Restore the multi-register path so stable keeps the old userspace-visible
behaviour, and fix the uninitialised-stack read with a targeted
initialisation in the next patch.

Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---

diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 391aade36ef3c..74548b4c114b9 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -19,6 +19,7 @@ struct nft_byteorder {
 	u8			sreg;
 	u8			dreg;
 	enum nft_byteorder_ops	op:8;
+	u8			len;
 	u8			size;
 };
 
@@ -27,8 +28,13 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 			const struct nft_pktinfo *pkt)
 {
 	const struct nft_byteorder *priv = nft_expr_priv(expr);
-	const u32 *src = &regs->data[priv->sreg];
+	u32 *src = &regs->data[priv->sreg];
 	u32 *dst = &regs->data[priv->dreg];
+	u16 *s16, *d16;
+	unsigned int i;
+
+	s16 = (void *)src;
+	d16 = (void *)dst;
 
 	switch (priv->size) {
 	case 8: {
@@ -37,14 +43,18 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			src64 = nft_reg_load64(src);
-
-			nft_reg_store64(dst64, be64_to_cpu((__force __be64)src64));
+			for (i = 0; i < priv->len / 8; i++) {
+				src64 = nft_reg_load64(&src[i]);
+				nft_reg_store64(&dst64[i],
+						be64_to_cpu((__force __be64)src64));
+			}
 			break;
 		case NFT_BYTEORDER_HTON:
-			src64 = (__force __u64)cpu_to_be64(nft_reg_load64(src));
-
-			nft_reg_store64(dst64, src64);
+			for (i = 0; i < priv->len / 8; i++) {
+				src64 = (__force __u64)
+					cpu_to_be64(nft_reg_load64(&src[i]));
+				nft_reg_store64(&dst64[i], src64);
+			}
 			break;
 		}
 		break;
@@ -52,20 +62,24 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 	case 4:
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			*dst = ntohl((__force __be32)*src);
+			for (i = 0; i < priv->len / 4; i++)
+				dst[i] = ntohl((__force __be32)src[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
-			*dst = (__force __u32)htonl(*src);
+			for (i = 0; i < priv->len / 4; i++)
+				dst[i] = (__force __u32)htonl(src[i]);
 			break;
 		}
 		break;
 	case 2:
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			nft_reg_store16(dst, ntohs(nft_reg_load_be16(src)));
+			for (i = 0; i < priv->len / 2; i++)
+				d16[i] = ntohs((__force __be16)s16[i]);
 			break;
 		case NFT_BYTEORDER_HTON:
-			nft_reg_store_be16(dst, htons(nft_reg_load16(src)));
+			for (i = 0; i < priv->len / 2; i++)
+				d16[i] = (__force __u16)htons(s16[i]);
 			break;
 		}
 		break;
@@ -123,22 +137,20 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	/* no longer support multi-reg conversions */
-	if (len != size)
-		return -EOPNOTSUPP;
+	priv->len = len;
 
 	err = nft_parse_register_load(ctx, tb[NFTA_BYTEORDER_SREG], &priv->sreg,
-				      len);
+				      priv->len);
 	if (err < 0)
 		return err;
 
 	err = nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
 				       &priv->dreg, NULL, NFT_DATA_VALUE,
-				       len);
+				       priv->len);
 	if (err < 0)
 		return err;
 
-	if (nft_reg_overlap(priv->sreg, priv->dreg, len))
+	if (nft_reg_overlap(priv->sreg, priv->dreg, priv->len))
 		return -EINVAL;
 
 	return 0;
@@ -155,10 +167,9 @@ static int nft_byteorder_dump(struct sk_buff *skb,
 		goto nla_put_failure;
 	if (nla_put_be32(skb, NFTA_BYTEORDER_OP, htonl(priv->op)))
 		goto nla_put_failure;
-	if (nla_put_be32(skb, NFTA_BYTEORDER_SIZE, htonl(priv->size)))
+	if (nla_put_be32(skb, NFTA_BYTEORDER_LEN, htonl(priv->len)))
 		goto nla_put_failure;
-	/* compatibility for old userspace which permitted size != len */
-	if (nla_put_be32(skb, NFTA_BYTEORDER_LEN, htonl(priv->size)))
+	if (nla_put_be32(skb, NFTA_BYTEORDER_SIZE, htonl(priv->size)))
 		goto nla_put_failure;
 	return 0;
 
-- 
2.53.0
