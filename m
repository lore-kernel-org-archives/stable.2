Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4241835B
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393720; cv=none; b=LflOE03wyQh0i8kgYI7TlhDyp4RcG6jL/U7vZBNeCBQv0fmsn4nMnfADdO3b6GGy/v0KFzxndJdS4vsfs1S7yU9S0cN+uZ+vRhXYd8x5dokPNbkW+V+jD9uElKgt7m69cU+j/GYThVcmHzOTfC1DkpvB5Qh3brQ2t4FQtlquyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393720; c=relaxed/simple;
	bh=N+SWmdaH+2cRiwbNCy5UPcXe7DRlzub1npgEjPIf0qc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F+k3YSM3quEV/mfWQWN0YNnlSLKBOz31PETk9jPvy8dcquf3mH2Je7eT60mtN1jexAhpCtV0NtNqRv3OKrDW7dJgA2iP7okNRJrLqOAGfUyruF/IEbFv6ossFfbGctepQ8pK6qQ6PI7yWB+ztgnXpyUbg5OJfnKowX6bOq9M/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji0R0clZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji0R0clZ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-487049569b6so795669f8f.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792393717; x=1792998517; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/uWVvmvrKULI1x066IdmD6ra2sGipF1udI1GYAPn4U=;
        b=ji0R0clZthj+mko50cfmoO0/3+YH5V9hWRW5YXFmo8hqdTiR7DsIBipAc89yn/9Nqw
         YZjmLZACnbp7pLflmwGV17Shj4lA9Z5Q1od8RYlcgUNYRn2yC9spW5AZf97ex25Z7mOM
         4WesQuNvpPkj2j0v/FChQvtB4BLY6YL2dvY4yES54l7Ueu3U4UMfXPE2O/eqCLfXiI58
         lgl+z7wRKu9mGlz8BbNX6CjytEmDWn++gcD/OSIB4pZFkRhHsteg1a/k0JD30Y268eMw
         JF6lY+vqlMel8uRIO+i8suKY2THVhqcPYjwG720jp5Ch8CqKfWHuAQ0WV/PQmOp3tcfO
         Y6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792393717; x=1792998517;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s/uWVvmvrKULI1x066IdmD6ra2sGipF1udI1GYAPn4U=;
        b=Tzx3IUOwzW45PWhDzzE/XDU5EOTocEmg+TKqQqom0UrFlsBiL9o8RjWrpd2BQRAB7k
         Hpfg9m4P5TSzi7dC5HslkuMspUMMpdUm4dQfYsSsaUIURmNzy8id85IpK2JMISLX5i+H
         jeIOGtrqxeUhcjyfTOjmLA7tZadOBhEv3a23MJ83Q0KTeikmUY3c7wGm8XrcV6kMuy3E
         6QeA+AmEdZxVcEyOgY/IgxRBDMKUwyRKutTTxDIOKI8VKtKBxnbvYW33rSZwu7RYZ56f
         JYqN+f9BYNFGh2BR8ZhHhlQsDVqjs4JYDZsgvpsCJfaqeclF9V29be7HhBZdMYlJ3UcJ
         5W1w==
X-Gm-Message-State: AFq9FYKlmSAIgFvylBQvbHzYIOgk/7nyQ8q7sNgZZKISmpUu+XH+AbIz
	BXxjqISfunCnNCaJfz40lnUD4gif2jx2iX12Y9NWhcdtOzQuwIrKJ2SvZ1j4xPhv
X-Gm-Gg: AYBFou3p4TRSdwyfYw2LbblOzlzbME3HblVZW/Go4E/dqjQJmVhymrt7T6/KrUC2nNZ
	0GhXPT2Ni9qywQcTw08pyadWszFOMV3LKd974XAO5uqaBXI0jzU7Dg1ohTx83OpQm61w9/OKuYa
	+xWz9MtytBueZoovmxJ7eJWcSJsOUYig0K3HJfanIAFJTn1E9Wo7f/qn0l8FjCMk2ieoHhQDWPp
	u+fpIJyzgNoMCWzVPX5hO2jFZyjqZoSDjOQiw26+5xdDb9S6ly4hxeoYnUF72hjKyCRCMBoE1lF
	ltrK85PXI8w9SQTyHY6zlR5NfEBtBwziiBwIjfgqGh4H1k4/IQaCQr0lSf1LY6N+u3xA8T9Y4Op
	HugW7xkb5vkIwxMpEgKpKIF6Y6rMXMo1BNcYGIu9rXgpGHSNwX0aYuPw7nhzWtCvW4/xS+bij2u
	cWTeJGrgyFQ6w8KU6pjwg3udJSe9C2IUdcYU83m9zZopc9Wza/dwXHBLGS0hvXvVNQ5O/A1mja/
	AMbXzUCqT2PFJlqCYAlpUZcSPkLhJZz4bry6bvPYUS8V8npI+7ehR3V5w8/nA==
X-Received: by 2002:a05:6000:654:b0:48c:557d:ab24 with SMTP id ffacd0b85a97d-48e079800d3mr10152426f8f.4.1792393717094;
        Mon, 19 Oct 2026 00:08:37 -0700 (PDT)
Received: from SurHub.localdomain ([102.213.69.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5ad06bsm22031609f8f.14.2026.10.19.00.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:08:36 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>, security@kernel.org,
 Willy Tarreau <w@1wt.eu>
Subject:
 [PATCH 6.12.y] netfilter: nft_byteorder: remove multi-register support
Date: Mon, 19 Oct 2026 10:08:33 +0300
Message-ID: <179239371327.27230.3709565488726931662@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>From 55bb91d40cbe0101fb7410426d93d833e23e83a6 Mon Sep 17 00:00:00 2001
From: Florian Westphal <fw@strlen.de>
Date: Tue, 12 May 2026 15:36:14 +0200
Subject: [PATCH 6.12.y] netfilter: nft_byteorder: remove multi-register
 support

64bit byteorder conversion is broken when several registers need to be
converted because the source register array advances in steps for 4 bytes
instead of 8:

  for (i =3D ...
      src64 =3D nft_reg_load64(&src[i]);
                             ~~~~~ u32 *src
      nft_reg_store64(&dst64[i],

Remove the multi-register support, it has other issues as well:

Pablo points out that commit
caf3ef7468f7 ("netfilter: nf_tables: prevent OOB access in nft_byteorder_eval=
")
alters semantics: before the loop operated on registers, i.e.
 for ( ... )
   dst32[i] =3D htons((u16)src32[i])

 .. but after the patch it will operate on bytes, which makes this
 useless to convert e.g. concatenations, which store each compound
 in its own register.

Multi-convert of u32 has one theoretical application:

ct mark . meta mark . tcp dport @intervalset

Because ct mark and meta mark are host byte order, use with
intervals has to convert the byteorder for ct/meta mark value
to network byte order (bigendian).

nftables emits this:
 [ meta load mark =3D> reg 1 ]
 [ byteorder reg 1 =3D hton(reg 1, 4, 4) ]
 [ ct load mark =3D> reg 9 ]
 [ byteorder reg 9 =3D hton(reg 9, 4, 4) ]
 ...

I.e. two separate calls.  Theoretically it could be changed to do:
 [ meta load mark =3D> reg 1 ]
 [ ct load mark =3D> reg 9 ]
 [ byteorder reg 1 =3D htonl(reg 1, 4, 8) ]
 ...

But then all it would take to change the set to
meta mark . tcp dport . ct mark

... and we'd be back to two "byteorder" calls. IOW, support to
convert a range of registers is both dysfunctional and dubious.

Simplify this: remove the feature.

Pablo Neira Ayuso points out that nftables before 1.1.0 can generate
incorrect byteorder conversions, see 9fe58952c45a,
"evaluate: skip byteorder conversion for selector smaller than 2 bytes"
in nftables.git).  Affected rulesets fail to load with this change and
old userspace due to 'len !=3D size' check.

Fixes: c301f0981fdd ("netfilter: nf_tables: fix pointer math issue in nft_byt=
eorder_eval()")
Cc: <stable+noautosel@kernel.org> # may break rule load with old nftables ver=
sions
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Link: https://lore.kernel.org/netfilter-devel/20240206104336.ctigqpkunom2ufmn=
@lion.mk-sys.cz/
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

(cherry picked from commit bb061d3de41707415269be75ebf700efb03ec212)

[ Backport note: 6.12.y does not contain nft_reg_overlap() (that check
  came from a separate later fix); the corresponding check is omitted.
  The multi-register removal itself is unchanged. ]

Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
 net/netfilter/nft_byteorder.c | 49 ++++++++++++++---------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 7448787..6228830 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -19,7 +19,6 @@ struct nft_byteorder {
 	u8			sreg;
 	u8			dreg;
 	enum nft_byteorder_ops	op:8;
-	u8			len;
 	u8			size;
 };
=20
@@ -28,13 +27,8 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 			const struct nft_pktinfo *pkt)
 {
 	const struct nft_byteorder *priv =3D nft_expr_priv(expr);
-	u32 *src =3D &regs->data[priv->sreg];
+	const u32 *src =3D &regs->data[priv->sreg];
 	u32 *dst =3D &regs->data[priv->dreg];
-	u16 *s16, *d16;
-	unsigned int i;
-
-	s16 =3D (void *)src;
-	d16 =3D (void *)dst;
=20
 	switch (priv->size) {
 	case 8: {
@@ -43,18 +37,14 @@ void nft_byteorder_eval(const struct nft_expr *expr,
=20
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			for (i =3D 0; i < priv->len / 8; i++) {
-				src64 =3D nft_reg_load64(&src[i]);
-				nft_reg_store64(&dst64[i],
-						be64_to_cpu((__force __be64)src64));
-			}
+			src64 =3D nft_reg_load64(src);
+
+			nft_reg_store64(dst64, be64_to_cpu((__force __be64)src64));
 			break;
 		case NFT_BYTEORDER_HTON:
-			for (i =3D 0; i < priv->len / 8; i++) {
-				src64 =3D (__force __u64)
-					cpu_to_be64(nft_reg_load64(&src[i]));
-				nft_reg_store64(&dst64[i], src64);
-			}
+			src64 =3D (__force __u64)cpu_to_be64(nft_reg_load64(src));
+
+			nft_reg_store64(dst64, src64);
 			break;
 		}
 		break;
@@ -62,24 +52,20 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 	case 4:
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			for (i =3D 0; i < priv->len / 4; i++)
-				dst[i] =3D ntohl((__force __be32)src[i]);
+			*dst =3D ntohl((__force __be32)*src);
 			break;
 		case NFT_BYTEORDER_HTON:
-			for (i =3D 0; i < priv->len / 4; i++)
-				dst[i] =3D (__force __u32)htonl(src[i]);
+			*dst =3D (__force __u32)htonl(*src);
 			break;
 		}
 		break;
 	case 2:
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			for (i =3D 0; i < priv->len / 2; i++)
-				d16[i] =3D ntohs((__force __be16)s16[i]);
+			nft_reg_store16(dst, ntohs(nft_reg_load_be16(src)));
 			break;
 		case NFT_BYTEORDER_HTON:
-			for (i =3D 0; i < priv->len / 2; i++)
-				d16[i] =3D (__force __u16)htons(s16[i]);
+			nft_reg_store_be16(dst, htons(nft_reg_load16(src)));
 			break;
 		}
 		break;
@@ -137,16 +123,18 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
=20
-	priv->len =3D len;
+	/* no longer support multi-reg conversions */
+	if (len !=3D size)
+		return -EOPNOTSUPP;
=20
 	err =3D nft_parse_register_load(ctx, tb[NFTA_BYTEORDER_SREG], &priv->sreg,
-				      priv->len);
+				      len);
 	if (err < 0)
 		return err;
=20
 	return nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
 					&priv->dreg, NULL, NFT_DATA_VALUE,
-					priv->len);
+					len);
 }
=20
 static int nft_byteorder_dump(struct sk_buff *skb,
@@ -160,10 +148,11 @@ static int nft_byteorder_dump(struct sk_buff *skb,
 		goto nla_put_failure;
 	if (nla_put_be32(skb, NFTA_BYTEORDER_OP, htonl(priv->op)))
 		goto nla_put_failure;
-	if (nla_put_be32(skb, NFTA_BYTEORDER_LEN, htonl(priv->len)))
-		goto nla_put_failure;
 	if (nla_put_be32(skb, NFTA_BYTEORDER_SIZE, htonl(priv->size)))
 		goto nla_put_failure;
+	/* compatibility for old userspace which permitted size !=3D len */
+	if (nla_put_be32(skb, NFTA_BYTEORDER_LEN, htonl(priv->size)))
+		goto nla_put_failure;
 	return 0;
=20
 nla_put_failure:
--=20
2.53.0

