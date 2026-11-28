Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840856;
	b=YKXIFO9lCNZ/N395rzgZ+AjZ2kAXODzT3lA8+cM8MQ9p60hOuvp1dZaHFRAE/vKvkTrC
	 Li5Tdg3uEcCOiW138n0fVahvVeVpF9bIe/JbMNcUwliV3AHu1gJOvtY/lhSxkD3qQKLoS
	 64/ev/aQMIx0qcUdJj1NC9aoCtvQosCNxxZy60ziNHNT6qRc0rpOxzZb8NquFdzo3UmCe
	 lBd5jCESDXju2MSSFx+NUI/KMyZeF1TFKzbcDfIj//XE2AbV9qowUQX6HlfVdros2VreC
	 3me/WF7iS17xGZf4VDRL8qnlCWykgI6j2yfmXvjqjFt3zveVCpUZUH8q72DlVjkR7YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G2gW943aPxIkGmC/mCym/SSE1QkZf84pbYDIvYJaQf4=;
	b=DrKke1JxV4mxGgcnd1oMhRihCmgcN8yrNQsmT+nKI7ioDemZua2XD3T02kAJeHuAgC0o
	 9Bc6+Mq/FaQ5Vvh2gXwfefMgA1d7elWSlnGzXuJ9XcTvev1bzPzU935aSV5Wl623sDZZO
	 tmkIkO2lFZgyEWoh26HBLeaKcddOcQPdDTodzTEWzVbQxdCy32Go/kZmwwJgiZ3Lyvimx
	 WVseg+sgH93EZ9/YUEsevh0pP0/Y2jcEpYCDVLRYUT+WmZUmpQ+vIeijfjKTJuE5eYPaL
	 j/DTaqu1fL8PoghN4Dos+Rr6dSkiMgpc+h2vv6Mq3HB8GIJUSaVqkvcXiw016CGXF6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5hu86Kg;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492C606A31F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E492C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5hu86Kg
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b501791bb5so1565893a91.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795840855; x=1796445655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2gW943aPxIkGmC/mCym/SSE1QkZf84pbYDIvYJaQf4=;
        b=d5hu86KgPNihIvXZrBnXdkf7jyn3/R3dmEdHid8/gqaqw0AzYDNzzOUXE10A0lapfc
         UNGxBUZmp1fSP/lb9geX/K0ehWnCCozjcc7frLFoC9drKhgVuD6kzfdpk3iLxzrK+iF9
         MrY73AetswUHnFHFQl5SixRfQ7Ca8kMrqMGx2LWnrWteulR0/0hMNKoGz+Lhmiiqbu0z
         LMUzTCw2VfoL+mJ89HH+qs4yOcJjfU3MDCLxgEomaP8yhKuhDXIrUHSgM+p7Mw2reFpr
         lU0fb5LVS78gGoxgTVgaPBdiwGubtS/LWurt3kWJzcIenCtU/MsMrXGwHF0AQQlsXDMl
         TlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795840855; x=1796445655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2gW943aPxIkGmC/mCym/SSE1QkZf84pbYDIvYJaQf4=;
        b=MrObP9o3VlqAnZJXXxtSI14kkrLGnjzcAZPRV1k9+//Rv9neK1aaeQweKBblmmGQMn
         HrDPaJe7oUoNg3MFRj6ZEUTImdmZTBCxDHZ7tnSgb6nRuHCkXOis2aei0gIYzDKSmVaC
         4SccgkGatHjzYXN2GGqy1h43TQK16yFgy1MTBhRWzUtBHWkuKDqciVGa3fnV86MEwZ71
         /VHRj9ElKVX7nY9TP0lyYd29jg5/Wq9epeuE/JgI5SI/8DV5xni966siO06anwNaFEdu
         p+Tf8rwEvvRpzKuDnTruSlNKdqdJi82DY4GFZbb8TWr+OHaunCo6HE4EIQLOY4xfTyhQ
         SI+A==
X-Forwarded-Encrypted: i=1; AL+hErEvvNDk6btWX2BQ0SxrXujcpxejq41Ec9wg7eeZ1rjx0RrY22xkSrNbgI1zRWuoosuLLNumraw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MImylnQ/aTY5JR5rPPMGvitDWQ20f2HNLiao77yf/PdLanaLE
	1XATqg1xr5OvBgvr+HAfCQvexAxosgrwIjMSWVsQ4Rlgu8b0CvSQ00t2
X-Gm-Gg: AZFdTZdxTRtVz5wn+bwC8e2ZJNZmL6GL586emyf9TWi9UfAY0fG9qbUuqL1i+P+vpPu
	6UxIJ5uwXKG3JGfNqVpLykZrndhGji+3sxSIzj1IOuzYIYpa5HGD21bv+3Ad9qA9c26pqu2P7ED
	7Obw7KpWYJnF7h/7jhP9bTf2uUwOIp9DOzaSwRiuq62BCpqJ1CDqXKKfu4qHyl7JjpEwTuI1XNB
	blkSfx48X78mY7AZIeTI31rgPvQ+VCyR/WoHkWnp6E6pmnv0f2MMna6Znh6xGcmVtJvToGKttVl
	eDsUuVFWq1CZMEJ77vOD1a43IeYBTrafmyVC0oJ7aS32lW1x3fIYxjCjGfiZxQDi1ZJULNZhqxn
	y0NbnJIuvqlzpLQcqmzinoZp6NIOZFdo94NHbA+WPpGlusZsk3baDEUUwQT+FoFHVfk4uyhekBM
	pMw+9Loe3/2U3iJ2mpSvfAV747LiJ8Ewf9K8yBVCWymGzWTh6ojLUs4hrEqTx0kXmAfZ6Yub+sb
	BHblbMzvBhBAa63oToMMcthondgwMdfXVEwWfIFlWP/67abo2Rhdb6OMBauL3ML3rpwgm1VxQuN
	ilyzQ3kXCqbplrbHJiZtK461ZlM2FNETsnAlcTvo1dwO8gHfhrmFvmp9Lv8xOsQ7PQurbzkHZOE
	8eqEbfuAGGkyBw5bdiA+uGoBGlM+NzKYCh7A/0CWIIHNzGGk1gy8TfhnXyEKY9GBxLMH6u1cm4k
	8HMw==
X-Received: by 2002:a17:90b:4a88:b0:3b5:29e:11b0 with SMTP id 98e67ed59e1d1-3b5029e14a7mr9016636a91.17.1795840855310;
        Fri, 27 Nov 2026 20:40:55 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42716729a91.1.2026.11.27.20.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 20:40:54 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Rosen Penev <rosenp@gmail.com>,
	Arnaud Ebalard <arno@natisbad.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Romain Perier <romain.perier@free-electrons.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/8] crypto: cesa - do not allow unbinding the device
Date: Fri, 27 Nov 2026 20:40:44 -0800
Message-ID: <20261128044050.722617-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128044050.722617-1-rosenp@gmail.com>
References: <20261128044050.722617-1-rosenp@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The algorithms are static and a transform holds a reference on the
module, not on the device. Unbinding the device through sysfs therefore
leaves every transform allocated earlier in place: crypto_unregister_*()
only stops new lookups and warns about the algorithms still in use,
while the driver drops the device pointer and devm frees the DMA pools,
the SRAM mappings and the engines. The next request on such a transform
then dereferences freed memory, and the algorithms' reference counts
are left inconsistent for a later rebind.

With the bind attributes suppressed, mv_cesa_remove() only runs when
the module is unloaded, which the transforms' module references keep
from happening while any of them exists.

Fixes: f63601fd616a ("crypto: marvell/cesa - add a new driver for Marvell's CESA")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/marvell/cesa/cesa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
index ac4fe783735b..6dded0d44373 100644
--- a/drivers/crypto/marvell/cesa/cesa.c
+++ b/drivers/crypto/marvell/cesa/cesa.c
@@ -577,6 +577,7 @@ static struct platform_driver marvell_cesa = {
 	.driver		= {
 		.name	= "marvell-cesa",
 		.of_match_table = mv_cesa_of_match_table,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(marvell_cesa);
-- 
2.56.1

