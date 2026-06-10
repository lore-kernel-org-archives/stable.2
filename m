Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C13E2765
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088047; cv=none; b=NjMp0UjjdtX0f+nPUx1T8YfA6ktD7eAVTV9PpQM9bhBZsu6Cb93Q6wkldU7SJXc2YPFNEqgDF6b1qFfW9I//08n4/8UXhsTxNy2WNpts7r4dFVX8MXsXs4fP2Z6U4Y89BYcdu2qljJnW1oF/zWAC/ZPHAgMhRl/H2EDJzjdte8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088047; c=relaxed/simple;
	bh=BgIWThzfJbN929F7TMVAmhJQXdFhIwYy0gF4vFRNzFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4h3u+C9pAnhviQkJup+3vL5qxftlifklXnVkRjf0YcIkL37qKl0zjRJIZ4uWkTxtsvF/+FEjmlxRz/KTx+Ikn6b+cc0l30Q78LCisexujN+nDmlUFvFPm1LAM+mFfKRCAEs1srSfX7H3MiZt9lAO5caDmWjWDl7f+NfkjoeIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxeF4v5s; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxeF4v5s"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4600cbb06deso3620540f8f.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781088044; x=1781692844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQESznGGkGRPzFP+Yzi0QaSyHIzGH7L9pn4wzNTvfPc=;
        b=WxeF4v5sHV2jONGuPFvSbnV1/gDYU2iH7M2bHHt31ttU23ARfIHfA8/sgn4zi0FD9M
         hlibbHwL+e+fjf1g4IIGBuL2D95NJ4Z0ABCXVF5MBbEEEU+8ny1BlSPdKmSNuFEkRxOq
         9f7tyqSPD+lTey2LRAVWI/p6Tvv8P8rU6woGWWPjidZH46mPeKeGHLdlnU+ebavNx8+d
         vfExYWVdSUQleF4BQkGzNY2pEaHGM73Rc2ejXU5rZNcr6nNUIhyHMzp4bld4jCyC+Ya2
         BhW4JKsdBeVfWQzWGatH0tHGnr5CZoZW87qWi+eAFa8Za3cgruEJAv33v/3Xa5rrt4m9
         GNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781088044; x=1781692844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQESznGGkGRPzFP+Yzi0QaSyHIzGH7L9pn4wzNTvfPc=;
        b=S6Tjs65tY5gyt9ACrmf1Bk71+gDZF4ABo7tJJwf+ZjuIBKYepzdTErlybchf8c+SFW
         aKct2pTo1ZlKMOLr4XdlGg2qg+uFapOe2o414Q/TR5DSr6jJOzU6M/pUDmGno2ujiZJr
         VLOr1me/CE4R1vsLCpRsQiXS0vPeYn+eOR+HCXv1Pa3Obm3NeMTZfd6uDoGaDmydKOFf
         55zj/QcgQn09Oy/+FFgSS2HIZn6QSL93RCkukz4/RhAQlkE4FTZaK9st9zDvJ54ePMfX
         RwQTuXCcWWbXg9e31+1IZWVZ/O4ivvmnbH+LYJ9OVNfDJHtrnpiSIIC4Yn7C8NFJb9fU
         1qgw==
X-Forwarded-Encrypted: i=1; AFNElJ8o+PpSmTm6RNQUBCf6B/3P9pgxCFBTEieWZ33zM9ygRllKt3+Tc9IEk6G2CtiCkBxV/D0Yo48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQyY6dsQkZ7LLg6yIz1UvpIpnPy2MFCS0OijlK+02amT4uVN8M
	QgM65/7hWG68moO+bKiNz9m5zuXUZbqkisRwNml+ei1WA2d5hh8eLlDsphRyrZ1IeUE=
X-Gm-Gg: Acq92OH14x16EsxuXcIB75pd8+G4vIlKtaUp8gZHg3gsHkKEcwLLwtBmx/ZoyIepP3l
	8xa7lJFX6xAQUxEfmBNnZII2H3Fvv3eOYSJJ6XanetVMLCUyV7IZAWciP6uH1DV+z4qoInRN42Y
	MB8CQfbJjAKErNmQ27c0+wrICa/cb9DG+iFK17FeMZRruPzDB8rnkbGD5n+14z5R36vVnUEZ7xg
	Drrycdm49EO/itldat9im9d66MEvy/M3S1IcbcAdKNvPgnup45+TSqQIpc09eIfsaHXEWh2sy/3
	hGQfmyVAStXw3idIdc0PTHik/gJwzEY/9ZZliyYOsrL9Y88GE5YXdT8PcXxenGK1DuU/NCTagQ9
	BUlCyUwGiIcozGQ1Py4scdqYyc9SSmjocuExNbEOLG8ZCiljTZV6bzB0i9IzR7QdrFhyBO3sDVR
	eCsZMEyXpvw4jLXaeQZKtqbAJl/Nj5SMSqSNJhiSx2y/Kz1UDmAFiYhRV3P5XUOHl1rTkw1OAD4
	v0tRBs/Fw==
X-Received: by 2002:a05:6000:400d:b0:45e:dd32:92fa with SMTP id ffacd0b85a97d-46032b81e04mr36180470f8f.12.1781088044150;
        Wed, 10 Jun 2026 03:40:44 -0700 (PDT)
Received: from manta01.. (host-85-36-215-182.business.telecomitalia.it. [85.36.215.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm75828687f8f.17.2026.06.10.03.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:40:43 -0700 (PDT)
From: Davide Ornaghi <d.ornaghi97@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	coreteam@netfilter.org,
	Davide Ornaghi <d.ornaghi97@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] netfilter: nft_fib: fix stale stack leak via the OIFNAME register
Date: Wed, 10 Jun 2026 12:39:12 +0200
Message-Id: <20260610103913.1949008-2-d.ornaghi97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610103913.1949008-1-d.ornaghi97@gmail.com>
References: <20260610103913.1949008-1-d.ornaghi97@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For NFT_FIB_RESULT_OIFNAME the destination register is declared with
len = IFNAMSIZ (four 32-bit registers), but on the lookup-fail,
RTN_LOCAL and oif-mismatch paths nft_fib{4,6}_eval() only writes one
register via "*dest = 0". The remaining three registers are left as
whatever was on the stack in nft_do_chain()'s struct nft_regs, and a
downstream expression that loads the register span can leak that
uninitialised kernel stack to userspace.

The NFTA_FIB_F_PRESENT existence check has the same shape: it is only
meaningful for NFT_FIB_RESULT_OIF, yet it was accepted for any result type
while the eval stores a single byte via nft_reg_store8(), leaving the rest
of the declared span stale.

Fix both:

 - replace the bare "*dest = 0" in the eval with nft_fib_store_result(),
   which strscpy_pad()s the whole IFNAMSIZ for OIFNAME (and is already
   used on the other early-return path), and

 - restrict NFTA_FIB_F_PRESENT to NFT_FIB_RESULT_OIF and declare its
   destination as a single u8, so the marked span matches the one byte
   the eval writes.

Fixes: f6d0cbcf09c5 ("netfilter: nf_tables: add fib expression")
Suggested-by: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org
Signed-off-by: Davide Ornaghi <d.ornaghi97@gmail.com>
---
 net/ipv4/netfilter/nft_fib_ipv4.c | 2 +-
 net/ipv6/netfilter/nft_fib_ipv6.c | 2 +-
 net/netfilter/nft_fib.c           | 6 ++++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/netfilter/nft_fib_ipv4.c b/net/ipv4/netfilter/nft_fib_ipv4.c
index 9d0c6d7510..177d738825 100644
--- a/net/ipv4/netfilter/nft_fib_ipv4.c
+++ b/net/ipv4/netfilter/nft_fib_ipv4.c
@@ -128,7 +128,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		fl4.saddr = get_saddr(iph->daddr);
 	}
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 
 	if (fib_lookup(nft_net(pkt), &fl4, &res, FIB_LOOKUP_IGNORE_LINKSTATE))
 		return;
diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
index 2dbe44715d..b9ad7cac14 100644
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -239,7 +239,7 @@ void nft_fib6_eval(const struct nft_expr *expr, struct nft_regs *regs,
 
 	lookup_flags = nft_fib6_flowi_init(&fl6, priv, pkt, oif, iph);
 
-	*dest = 0;
+	nft_fib_store_result(dest, priv, NULL);
 	ret = nft_fib6_lookup(nft_net(pkt), &fl6, &res, lookup_flags);
 	if (ret || res.fib6_flags & (RTF_REJECT | RTF_ANYCAST | RTF_LOCAL))
 		return;
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 327a5f3365..a1632e308f 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -107,6 +107,12 @@ int nft_fib_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		return -EINVAL;
 	}
 
+	if (priv->flags & NFTA_FIB_F_PRESENT) {
+		if (priv->result != NFT_FIB_RESULT_OIF)
+			return -EINVAL;
+		len = sizeof(u8);
+	}
+
 	err = nft_parse_register_store(ctx, tb[NFTA_FIB_DREG], &priv->dreg,
 				       NULL, NFT_DATA_VALUE, len);
 	if (err < 0)
-- 
2.34.1

