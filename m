Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227020;
	b=eSjMFEPX5tlfV6BHs3NyURMq/qi1S9hy0NgPIIDZel6xry1IhTLBPmXHpNSUXPSSQ2E7
	 IZWPg29bvm58EF0mGl5gJH8n1jXinWHdBySBSlAzTVw50hdxIc95MRA6RP0kmlUHHYIjf
	 kjXImb//8Z7rnpKKU9LQgeqfimRBva+J0bfyz7DdMDL/ywvpICFDQsgUlPRMx6kRVEHkg
	 zsjnGym6Bh0Jc7+lwL/8f1QDcy4cVBJ/wprbESqj7HpnZnqCNpYEyCIf4bQXyDPl3dZCo
	 wKjfb6Zvr/1mPCA6e47uzGzMdbyXtTS52rh/Sc/FRpQ+GN8LxJtXlUS8VeQaF2PiOqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uqkPwKdBphh8svxG0i7NhcNwoYudscGxRvBCQXii6DU=;
	b=EliPwAY6AHvRxx6EDHST58/QfCS0VDiqcOW50zJ2MnEEkwC0eOtNp/OnMDFvrXMpmYST
	 eP+54oupDrj6aCFb161V4QKtjda0hmvi0bERZAYDq26p4ywKOfe1JwHSsopm1wc1ckQMx
	 oxfU6vgTwTCnGRwzOnPch3RcWXQWz31EL5ZZaElHuYodE+8CmeEoZK84jW62PorrftcV0
	 3lAN8CpnGkKnMI/QpqdAlseGbod90ql4qLi0TozvU1kSmNJoJg65cHBSW8M28ED4UNFq7
	 xs2cUR4dc/IbKiWVgw6/wCvMAChBhM2yqQP+U+xUuySogQax3m+i2LmYSCTues2RLag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wb7L+Ebg;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34D6082BD1
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE34D6082BD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wb7L+Ebg
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so7049605e9.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794227018; x=1794831818; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uqkPwKdBphh8svxG0i7NhcNwoYudscGxRvBCQXii6DU=;
        b=Wb7L+EbgbfshuHOTA2DuNBCvwfnhVtbUsk8AFZahJYuPodOPs1oCGjtqiqYAZ4poT/
         wbCvbkVBv2k4xPQz3ccID18nQtK4HgGRWKU6tPvAdyGjzT0IfJr9+nfI70Bf8v1QcBQt
         LHxPsQif2FBfI9J2RY8l3KilTzLyTM0+F9vqQAx7JYnIj4YqhTE7FRLVpyG+jNg1iCbl
         AIFIPI+4TeDlVsv8FAaevmdzINoeJQ4A3F8irZagt2S3G9a72Coc0vJf9rwz8gAhTePb
         DJsezHzg4x/UFmJRRZU1mbhEoI0hiTb/5t8WaRk+pnlXFgi1n885Br0ptlsY3xVy9xtu
         ZFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227018; x=1794831818;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqkPwKdBphh8svxG0i7NhcNwoYudscGxRvBCQXii6DU=;
        b=OBt5yoNPwdbD6mqET9mSa/L57t7L1YbNTOGmQZXgsoULJkET4cRz9XROCI9MMyG08e
         ROWRFCgcSd9CTUm9v6JQUM9TzCXGejb3X/duM2Srv/pv5wb8N8Ne4inF+nPqmc4gtzBP
         wXxf8SiZ1kO4h7RUfEXrkpVLoTJzb/+XQijh2tDUt3NZu7y/3AXs0nUB9huNVXLDKOet
         QQqbVu4mj6EGNHOje6JKl0nRoljP3llLBfFlg9fWI2bQWYTB3RUzMwE/7D/xwV7OHmzn
         cE2FMsh3hLn3B3KE4cO7qy3wWmGAZ0v0HvdYTZW7ofbk6tLcOXssPT5rcleX+FihebX5
         GQ/A==
X-Gm-Message-State: APuU4Z9s9aFAuEWYXnxQWwvIC6EmNKkw74u30ARcLlbjaXS3f4lHdJKr
	Q8OtU1mjbphPPxEU7Wt7jsvPJgvc0ILlxnB60/fM/aykYBbNRVF73QYi+Eky24u3
X-Gm-Gg: AYBFou2QuNc8lCBnao8N1xhd4aq4UQIcU/CJWcj9W5ytrWIUkUxV8qYdK9oVfkf0e93
	bmBd5r1Oxj8DEpmqJY+Q26hzBxKNf6sxoW93ZugRfiM+qMsbNoztX6SyFvrzyP1VeNpLiwO3SSR
	EfaRUPUnYQuGRONBth50bpx2Soz3FmHnwfU/sD6cWvpX/cZOSMloyANYjIp2yovHdaxgAPXZtL2
	fMmdixe3cc67+im2gwFH6XSzvB/47yVDEx1Ta4Ar5X43i3XeGM+bqt4d/GUabUqfe0dTJ6d5+mD
	Lr9a3pOvhXFc6aT54u7/IyX5GdjqBd5S2qhDF9TCgoEroX+qED51gAbUcmCLKSkOW5qy2BGwwcM
	u3fE9fYdq/7VAauQI6hB12/iOM1aWeH2Gca10w2BPwgeWQnqyzf6yfxU2Gdu8vNM8tfZPV4KuG+
	GofouqFQo+ZcDn9/GtdS+ApqC3/PziNhLj1KohbolRbkhodWnSas++ABTLpwmLel36lAwxW53xT
	bT2neVvbtMTxG50tr14T03rlU7tHtvrZ9zxjwL3fAVt5eh5ejhd5oJEI7FT3ylDyQmlimLdLJP9
	x/O7Ecw0oXuwFH/r0SULZq3A6z60CMxxkVp5Ij/nZPJzVgCTCzw8DO5Cc3zSanTE5k6YlDxwZ/z
	D8hX5/4Tk5peAjkpVW2O/xL0Xdjc=
X-Received: by 2002:a05:600c:8b88:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4b963c8921cmr71803085e9.31.1794227017980;
        Mon, 09 Nov 2026 04:23:37 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f1117fasm155695025e9.13.2026.11.09.04.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:23:37 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] netfilter: nft_byteorder: initialise the marked
 destination span
Date: Mon, 09 Nov 2026 15:22:59 +0300
Message-ID: <179422697983.5131.11029262939381173340@gmail.com>
In-Reply-To: <179422696909.5131.4005481731765358036@gmail.com>
References: <179422696909.5131.4005481731765358036@gmail.com>
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
