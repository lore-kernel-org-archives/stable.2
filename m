Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227033;
	b=q8qMF2r4CoDJNfbaVUCmytjU9AqSpJgDUXC04AHSdaMa+/gLH7XRkVPaSncB4w7C//Zd
	 g8ueJGUSSw83yH1da+EAcofq3mAmq3zEdYE0K36euNpNPYCJW3DTjPAAD13dYiti+Ix+2
	 wW45esargH2BJUg/n0vd2au1OH2QJX4oQLtj7ha7+nqvYIZMkSLO0cSsWub7ypVU7o21B
	 rgNnez0oM9a7jPV/gHw1ehB6okcMA5wNhp8MN5BgmESnPAets75Zca5yzWrLZn3j7B5Ie
	 ULtMpgM/M+yVpyejHQG2oMKoamPN2cw9R8T8fcRwNYpETqYa9oLr0YdOeEXJEx5cq2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FtIc8OJQRVs5mxAHtFndAKUpp3irN4qncNUdkvOYWPk=;
	b=ycdmff0au8f0VFYaFt5vjofXyQCRB1+OJ1m42bYl0SpDLqgdylWfs1wow4rPEIcKhl7A
	 t0Wlge9JPknTx3OLXJlb+XYTDRmwv8mnrz9ew//ybHK+0kpTBqWQ4WeruMfRm3MGKh5FK
	 MwEwS90o+7/DGu/y2ng3+2OV2H785t32JyEKDB4+5qja6RbAA39HSWdmyqHQckVUbpUbC
	 PwDYhnp0fx8sPNwLuyD0/vx6gIThtPHkQSQRslavudoTLYJQG1Ie2ltwwjowPG0hO6h0s
	 QIdmGwMaLzM5eOBwcU1fsb5QlXij+/6MEGqBPkFceS2TVGHrrPnhHzEp6ov27LjVGTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ehWEs9aY;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC913606A338
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC913606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ehWEs9aY
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so8177945e9.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794227031; x=1794831831; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FtIc8OJQRVs5mxAHtFndAKUpp3irN4qncNUdkvOYWPk=;
        b=ehWEs9aYR22ZWprEjQ+2zKV4ZJuc4lQ/buuwHCmK4CZCi4L7py9re69s7Y7Um7ZMsX
         IEo7KBj/FXtdBPbijwtlrBxrd62pMLdHrmaAz3n8QxIMtFrYycq8EICuKnI/wUwLStT/
         we+9wXC0yTvesHLcroOByqFOuS3sjzwjcUYd9RuCfm+HDYnIixLO2Izy42Fk0oz5vHQO
         AY3bIY3wYrVZebhYreoeOwpBDx9qhqqJREuGBExo2O8f+p8Vh31KIY4XmLVif+D2k/S6
         JzFkb4D/WRWK62HrDoo9dwjb7zDYvX+Bu0LhaH5nOSPs1hF0d9qATOQ8hA+z3YisJlhd
         NHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227031; x=1794831831;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FtIc8OJQRVs5mxAHtFndAKUpp3irN4qncNUdkvOYWPk=;
        b=oE7cloaGPTEwMI+NE5hiVgmfmasTIT0vv7hVv+Xr0Lcb4tZqDBmwymCvwXTr+OXblf
         DI+d8yoQgA9/p/GSdjeIqdhFd5EMXhV/7KnJ3xUZWfrG8DeZ7oFmXroHIhrzFogtvwH/
         b1QvEX8lDO+8CuwzRY2tAAzSprmsYnj5Xm7HRATKIgCv3/QGvGQaQBvjbsFAbQmr0c1q
         Dg9syAD3VM9AEkuokIAwBNfPlrdIGFoUzbeT8LbdRTqbjRA1YhzPvHJg1M0XOMjknK2l
         RyNiHLFwMOIlgwXhujnGy+7ssgmQdBM11OaLn5sxZE2gp7aI3m8bOFQehABe1X5oRQOB
         RRbg==
X-Gm-Message-State: APuU4Z+ySukJcmaRGBJiuWmy1wDX/P5KI1qbyMu6YBIOyEwlE1eKs6wO
	yMCoQyxADRa5hjLvPt36i3IddSe6irg5UbW4F1L2dvwzFPkIgWZya1MxIL1K0M0r
X-Gm-Gg: AYBFou1vZVcSOgbPES9evQIb3fSbeDUskmAkeOcAClvGuEM6lFTSokS4Nbd6i8ZujVu
	QLLfWT8+8rUeSiSQvXww1S0owtAWEnND9dt284SNLCN9MrdTAdtEyVbxQiv+VHu+ufGW3A88HWu
	hxJxW9gwQpAylppu2Zlt1if6MeK11f8ZIXYnNAaMi2jwF+KjcCsZnoHpHZOIiMynbQ4OwuyLxBa
	u/vnEHJCO5y7k83IsxPTwcUANoMYNquwWD1j9jGkigtGKNCj4ekzBm3lyr6+9IVTJ9PKVbIV4ha
	Nzzmu/SWsTGfl5c7K18TemhOUd+aUYw+oFd8r5TtKaZePcPFxX/m2AgmMpAOSKv3dNZXJ+Xs5mN
	cgO5pGfLrdkM1M9hBEZ7s4TfhaJaJV/SiUX11OUBnMwD/BmHqYXQsXNEO7Lu2Bo4ZW+PIkgolK7
	fqTlbTja5Z0gQKnqw9nrzEQmImhQHK8joBx8fBvLMhGN/JxobuPK6D/z4I8GpEs8dTWQzBtXJUU
	ILDZ5GXXCfMfxaOg2fd4FvUprNbLg7OJY+c9Eu1u0uIVKmBUjxO+1IdsS695ngjxpSJ3CFt7RMb
	uGbny5GcOwbKz+BYM9XPKnEp7Moy7CKFwnfW+gNWzoQMH8eZkyHJg84yD8Ll+jUOf/H43MPXRad
	wD2eSOw==
X-Received: by 2002:a05:600c:8714:b0:4a2:150f:1609 with SMTP id 5b1f17b1804b1-4b963c767a3mr66470605e9.8.1794227030969;
        Mon, 09 Nov 2026 04:23:50 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4974b7645cesm3077886f8f.32.2026.11.09.04.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:23:48 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Date: Mon, 09 Nov 2026 15:23:46 +0300
Message-ID: <179422702651.5131.4174988605567778384@gmail.com>
In-Reply-To: <179422702104.5131.8115555421206983838@gmail.com>
References: <179422702104.5131.8115555421206983838@gmail.com>
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

This reverts commit dc29c0478b8564feb9371e715b5a0016eb8903fd.

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
