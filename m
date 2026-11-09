Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227038;
	b=Jn+2ul0eVzmHv4VCIZ10WYvOSFO6yltZl2biGDfeSTmpQy7C8c6Unai136SFkCC+2UVK
	 qBbCAr6bP9IyyLHLDDaltP3k++nYr03lelF0VWEsNuNCNk76W12hf31JZUZycMlfP7id/
	 FwRkjPM3tWkxblFOeqmDzhzi6QdaoN34juROC1HCCPRN2jMGgtg6zWRPPabcfJqFrt1gw
	 qqc5E92y4FWl79xDp1lB0NZXkXIN7hFmGAE+VMvFRgBoOevjMlePqwgHsEBL2QdfD/8Cw
	 E5MCBKcAxfWBYPrO7Io2nAFhcwo9VsOgO6Lwy5X0Rvw8ctSlGrvIWKxxVbbBjP8YSkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uqkPwKdBphh8svxG0i7NhcNwoYudscGxRvBCQXii6DU=;
	b=cOlYOp0/lt8YTCzA8XNkXI8Xw6gJGvhJOtLiBOR0SN3iIcAzv3O6lIe+7vVMzuMwETKE
	 dBrJkTzWbKg7qhDnhyK3PcCKLTtDqSlcGKcXFNlCRJSc5kBJPwZMEaFw7WD8z55+AWMl/
	 WBlquC8nquRGZWTyEW/Hjt0FK9kmTgbdACgRW09U2jSqG8EO3yRuF7wzyqB76nH+kRhpV
	 So+ktRYpwZBThhHDmaU9Er9BAaFjaZbQSb88IXPD+C57k9A9TFRgNOXkymikV+KWGskTY
	 +1gMlegvEmyGzz0UVPMAprrhVOKS8jRVzUYnSfHbXhgPDiPETAbJAaZy8JrjoxzfF0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPTrfm5l;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C32606A338
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18C32606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPTrfm5l
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so527047f8f.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794227036; x=1794831836; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uqkPwKdBphh8svxG0i7NhcNwoYudscGxRvBCQXii6DU=;
        b=RPTrfm5lVhTIPyG4HW57SNfmkoxwJIqPwVQS7d1kwNoeybCNT+ooTXN3G5Y/5j6VqB
         7V9uXwFSnBCf9OVzc4ZMrd/lvfftdRwV497bO2/2hURmFh1z+ajA42Z7FHrhoo/73Si2
         hHkirkF0qFWItyeg2hcmcf+knbTBgwbbe6G96ydv6Z1aeJO2KACPwVm3tzTecTRIC7dd
         D+LHcL8+B5+0wdAdyaSTY6PRtYTN6o9O8mo9w5afag52FJCMLjThmlRIfHr4YWJSbTxB
         rMVijW1PqH0RE48sWCYaz+ngRuafTslXqfNrZYhtGnDaor/RLuxIWxJZB0m1M594SdxF
         Lrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227036; x=1794831836;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqkPwKdBphh8svxG0i7NhcNwoYudscGxRvBCQXii6DU=;
        b=tl8Vil3kYmS/Rov13xodqxQT6fKfJiQVoFKO3xriga9ayjHQkRpcV2PPJXy0jLSvUN
         NSIsW7MsOaTB6k79E4jEcLYW/oULboTKGZR9p/S7l9aqPvRQigrjntoNrpH2ziUq938l
         7v74ZRECgr2oBJqyiymaSSGcp870fW7oAXAftd8Wrj68m7JqEWvzEi7dyjxRmf9+Jfn0
         S2TKsOS9TjIwsC1l+QBPQ7OEtLsGsbVJHGGJ9BD/1YA7adpJxMflk6OVeRdqmKn97M4I
         aRNYlFlGQK6wsuLOqtOBLx//xNEVZtbu1BzcF/A/F6ueoAFDfjtqTAI7tHvEoFJgUPmt
         yUww==
X-Gm-Message-State: APuU4Z+H9mi47Dd5DV8U1R9Va7TieXc5U9mAxNl5MX4R/dPXc4gxbEy6
	dbMsGh4YW5ma5iP2+f9xsi83fwWjRkXART8nkfF9L/I+InKwzZmg+bIRRD/Q6Jb6
X-Gm-Gg: AYBFou33pa4/vFgnSwq4339c938ABcQ4Uae+j4/JDJUdAwe2wl0ld678752zUKVJi+B
	pNa/ERDMrlnqxGK/I9J0jxVFVsqHD76O+YH5D/oRKmWR9CvK3EJgZRELyI24kt9r1IoBcvKX8kx
	JzE/0xPMy26PEmgPuNV4kTxqS2v3hrL8I9xqtCBx8tUKtM6aq0fE7mMPqyUjFQR6+JIU3pOxe6P
	o/AQtncHVUreK5q5s7dXkb5I46NOke57OudbSzYidXalfsv4/9fXP+BdyTog0Mu2DoTylv/z7aB
	YHM7SsJKzck9wSrkVfbl8ImJuj29wvzk1wJ4hJJ5c80cKLGzJVHEis8ea98FTVzVtB5fIgN493E
	5BpK9D4fpK1aZUQJaZGovxey65e//OaZZhauPbLRMbLNfuQn5VSHZbJ7RKp+Ulk7xfHCVmZFp/u
	e2+4mdZCnoJPoKdUhK2JuMLXvvMxSiPok1HEAn1JgcEibmbC9c+wdN2nuwIbUyNka7K3NaZUKl+
	cfJI11vPsDp95gXr6f33gtFoSifzKv2uIUKLXcgFq3cE4XPT5xRIRjj3E5nZpFQqFT25BiFBf2x
	XpAbus5M8CTiQMhQm+WMxZ4jLIkNO8KAL5JaMALj7OScofCYLdjOH09oKwU+nVUCm/pf1Tf/i8g
	3lmNcGFOxlwlZZr9ykteSHEf3Uqqx
X-Received: by 2002:a05:6000:2212:b0:493:c0a:507d with SMTP id ffacd0b85a97d-495867426c1mr7112639f8f.1.1794227036219;
        Mon, 09 Nov 2026 04:23:56 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597e00d75sm9506403f8f.58.2026.11.09.04.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:23:55 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] netfilter: nft_byteorder: initialise the marked
 destination span
Date: Mon, 09 Nov 2026 15:23:54 +0300
Message-ID: <179422703408.5131.108447142790135267@gmail.com>
In-Reply-To: <179422702104.5131.8115555421206983838@gmail.com>
References: <179422702104.5131.8115555421206983838@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

nft_byteorder_eval() writes only priv->len / priv->size whole elements,
while nft_parse_register_store() marks DIV_ROUND_UP(priv->len, 4) full
32-bit words as initialised.  For len/size combinations that do not fill
the last marked word -- for example size 2 with len 1, which writes no
element at all -- the control plane still accepts a later load of the
whole word from another expression.  That load reads stale bytes from
the struct nft_regs stack slot in nft_do_chain(), which is not
zero-initialised.

Zero the span that the control plane marks as initialised before the
conversion, but only when the source and destination registers differ.
nft_reg_overlap() allows an in-place conversion (sreg =3D=3D dreg), and the
source is already initialised in that case; zeroing it would corrupt
the value.

This preserves multi-register support and does not reject any rule, so
old nftables versions that generate len !=3D size continue to load.  It
only removes the dependency on some other initialisation of the
register file.  Builds with CONFIG_INIT_STACK_ALL_ZERO mask the leak,
but nft_byteorder must not rely on that.

Fixes: 14fb07130c7d ("netfilter: nf_tables: allow loads only when register is=
 initialized")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---

diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -33,6 +33,17 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 	u16 *s16, *d16;
 	unsigned int i;
=20
+	/*
+	 * nft_parse_register_store() marks DIV_ROUND_UP(priv->len, 4)
+	 * words as initialised, but this function only writes whole
+	 * len/size elements.  Zero the marked span so that a later load
+	 * cannot read uninitialised stack data.  Do not touch it when
+	 * source and destination are the same register: the source is
+	 * already initialised and zeroing it would corrupt the value.
+	 */
+	if (priv->sreg !=3D priv->dreg)
+		memset(dst, 0, DIV_ROUND_UP(priv->len, 4) * sizeof(u32));
+
 	s16 =3D (void *)src;
 	d16 =3D (void *)dst;
=20
--=20
2.53.0
