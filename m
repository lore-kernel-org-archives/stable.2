Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745306;
	b=NRSesJxUE1XNYv/RFvUg8Uuhfz5QJQtdo/OTFjR4a2WOyi2ZlMXYtvwn1CcFNiUxgcrV
	 ny8y9dFtRbvjH5gzZ5wl/zEmlpZFl78S48ngMbV/nWDvis5UMeKJgwY1NrfG6CVfCRsvY
	 YFe5eZdZ0BJ4JzjwP852W10NHiuES2x65atSIotKOz89GGtB+5EJ4dJmlGyEWvX7wkQzO
	 qBIyVhFgMI6BUm4TCQiSoqBETHGqcXR+EddG2bQtHpLmdCV4K9BMVRNUK5CmdQTNo8Hmd
	 d86NeQ5GizDJSHfiQ3oxfSeFWN/g51Bh/TYcxZ5ja/pRr8dR1eE1DItZMmdgpbA+Svg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F6Klyh0k2DMvnciL91BfEqRQ5lu6e2socN2fUvplmJA=;
	b=15q+UKuDacyueVhGVnOaj8hmLFFR3HUOLoZKhXJ3qCipnKhvRtGrjN8Mg2Jk/s5Fg2Yz
	 Gu5Yfhz3XUOffm8F78fNls1RWFIN46UF0qlnGjd6LeH1jg9W5le/cGkbLm4MG6TGwEIXE
	 koXDrgre29ecDWKrN4gs6rfLDlOh+iRZd6/TUl3i2xMf1owZ3c/MimlEtpAZklbRAVfJ6
	 SnesOrKs8hEJtZw2NG5bfb/PzRi7SPwkUoQRuZl8uM4yzZp+Mr18hG4W+PZheHEPHuxDa
	 P7rM2wvZYb0etFTgWh0eIc8YwFtpo53QpANJXftA2T/GBuCwIneyGfPNDhfn5NsRoZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pc7S+pI0;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9112606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9112606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pc7S+pI0
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso4659035e9.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792745304; x=1793350104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6Klyh0k2DMvnciL91BfEqRQ5lu6e2socN2fUvplmJA=;
        b=Pc7S+pI0JXKhYwN2qAfpmiYFWvf0iq4V1IM2XBk0p5KiC6vtCBllx2sjknvhh1LNT7
         uorj6HxSdCzFMzFOsj2zY8Y36vMbEqMkBbBRlfxH6wVloK8QQP8VUaQn57++bWCjgoJ+
         J4g2kCzi0/bxvJnyObGj//7NJnQM41djmObkoJRuO8ENzftSYUG76YnBInFZpbR1QMtx
         NCJ29sBladKrAVZz5RloPAfeSdQQdLv4UOO3bbRFn8BhxrycQLefpblL/cysyN24B6pG
         j8gKU1uT1kPzWzPtzzSwIZoDWYXS7OfYj7vqNlUrDAaSR46w/A9wnM1fyhQmhmtClaaR
         a3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792745304; x=1793350104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6Klyh0k2DMvnciL91BfEqRQ5lu6e2socN2fUvplmJA=;
        b=t0xv+bnBHBc+fvquEiujZEsjtI2sHzKuWs7zT6a+QZe680GzRGM0fINSJswScluoPu
         D4jBkxYN0sAZerfRd03o/yOOfo+AQgM7+b4Iia1dsEQqTPTqm5ZGvFwFpvcxV5KdZU0V
         m0ExB3E98qaFr7XxXqh9LTLdhl4WzNdr33BOdN5z/FbDPDsE5ZfV8ZL+8fYHXsi4Bk9b
         SnTPgc8o49KKC6GByi8y43SwPLNIbk0N4/zsxrhYq5ESNumc7/ZjPllkc5qJGfRZA4ti
         oEaWwUw4d1eHZ461JIk9dwFvJ7OgvoSXusuXm0l0pDVBDn6hUItYbQn7iFe8n6TpQJZ4
         oeSw==
X-Forwarded-Encrypted: i=1; AKwUvBxqoAxSDW0KP1Z9nTXb2d5GQUAjZZi9zuiuAzRpAQ+0Q4kXttL+nAQLB647HZIGn5B5JKbsRVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0m+FpaBBzXpNTs5y/Led29EVyCA/60VfUPVs0ZG0v8M/cfIfB
	NRO33J3UjntN3l3MxMbit69RxuEoryN6WWvYM6oF2rob0SgIx5e9N5rS
X-Gm-Gg: AYBFou1AhV7988/iJ8ZSZgB5Ulq2Uyr4qKehGZir9I3ApFTYZgUmDyaVEKnihzPhr7r
	D8+/SjE0f2NwNW/6Pl5F1YmBPVAQf26f2LS81aBEb3rgxXR6KCg6z2S3nodIQM1rJ9WIQixzP0l
	yXDR+sxAnkUdwlRqW7hJ7J6ZSVIbvNiOVKhPHObCux99K6M478S5sY09VabAPf1/c+zavJxFgRk
	eHl7p0itEtxy4KE5Cx2gJ3/WOl6OzKS8TE4S9RsvegCZoRnfDPunKX0cunZFB+wFZz/yBqF4wCT
	H++Nuf5uy5oDan5PIkVWpjnQdcYuR+IJWnii+yZEioCnENsadCtaygEd9sJw/11QrWMizQpXGeN
	CJj4bUfAd7nyIX1LgTdcGyB4wYZxsL9U65H0XbXJYzjqEc+ujO1E/wF1KLbIefu54fGORaN7gYy
	oEAFJMkj2Di5zKk1ZdyRmKlZPKoxioiq6BMI5bLq0DlCq0ySJXVxWVBB+qBZEAKFPAJNXOy+XAf
	FCLy1ZB2YsgYfqIx4yiN5dkuI/uhlnGWkvnJD1Z9ilgQgZtjtkvDAtRcFSC+2d7iYSEq03EJg==
X-Received: by 2002:a05:600c:3b96:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a211cb88a6mr29706125e9.6.1792745303675;
        Fri, 23 Oct 2026 01:48:23 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:4fad:2c9a:1a55:76b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a211b291b8sm41702955e9.1.2026.10.23.01.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:48:23 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	cel@kernel.org
Cc: linux-nfs@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix TCP-with-TLS transport class identification
Date: Fri, 23 Oct 2026 11:48:19 +0300
Message-ID: <20261023084819.609293-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

xs_setup_tcp_tls() assigns the ordinary TCP transport class to
a TCP-with-TLS transport. When rpc_clnt_add_xprt() is called
with an unspecified transport type, it inherits the class
identifier and can create an unencrypted TCP transport.

Looks like a copy-paste error from the commit 3 years ago.

NFSv4 trunk discovery uses an unspecified transport type when
adding server-advertised addresses. If the additional transport
passes server-identity validation, it can be admitted to the
client's transport switch.

An isolated loopback test reproduced plaintext application RPC
transmission for TLS- and mTLS-configured clients, including
an unpinned TLS-client RPC that selected the added transport.

Assign the TCP-with-TLS class instead. With the fix, the
plaintext-only test peer receives TLS negotiation probes but
no application payloads.

Fixes: 75eb6af7acdf ("SUNRPC: Add a TCP-with-TLS RPC transport class")
Cc: stable@vger.kernel.org
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 net/sunrpc/xprtsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7f60723fa64d..62a51eabc353 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -3499,7 +3499,7 @@ static struct rpc_xprt *xs_setup_tcp_tls(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = IPPROTO_TCP;
-	xprt->xprt_class = &xs_tcp_transport;
+	xprt->xprt_class = &xs_tcp_tls_transport;
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 
 	xprt->bind_timeout = XS_BIND_TO;
-- 
2.43.0

