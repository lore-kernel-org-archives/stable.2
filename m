Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605250;
	b=ad2LIl5ScjiPnYRFpi4Kt+MXeDnZi20HboTW1hJXMF/fqtYR+dNrk4kbE2wLp0JhRzyU
	 iT1e/qCL50fMRonk96a3voib5Ed7KL0rC73LXCOyYSjjUaJSiDaBaAn7Z/KjRnNw95oQZ
	 H4ID9oHFyGnQlTkj1Uv0pbsc8Mz9GmU5E6EZTwt3Dk+Tcs6ehvTT1Tm8bLBOY31aJ/ezP
	 V04DPeXmu/sabMdCIRFJbTClBt4SW9D9td9P6YPwCDNk8JWXBX1Wvrww1gi7WNvciNOIg
	 x3hHPIe4DHNGJMutJkSrYsrfmstHoxHAaqYAb558AFkP4NruO7p3NLDWJ9dD04dzGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5PqjLYJUgUiokTOvnfFlSVLgSp4XVLZwVNOD0zgcVgw=;
	b=I80ICpesImT9oua+OY/hy1ZVE4ppB4pNqX3KA2ns/RnxdN0XsY1LDPuMvqRnkKkeKFKf
	 h8o4+8q1sYmCqHnZ+m54CpUvwrsr+1gtBlVEFgdsH+0Wjmu4arzhtZc4DQ8dV/LVWslx1
	 o047EHbbl5XIHb2mtT7XOTeUEKd4w5jxEwypf1sBRD/sO8f6L+cq0hpel8s4mcA0iaqmJ
	 JZwlTsrsa6sueDRRO5hG92ARLayZthpWJkmJzeEE97u5VjP4FfSoY8C9QsAvxetC+l8+N
	 BAEQimpDOC3+KUduE1lB6NHJaorKf0H3fnwQ1mSsImsp9Vv167mxm+39bIWtXfsHXCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=JcpocVIS;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E8606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B47E8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=JcpocVIS
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535a54bed9so1355100eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792605249; x=1793210049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5PqjLYJUgUiokTOvnfFlSVLgSp4XVLZwVNOD0zgcVgw=;
        b=JcpocVISGPYKnrqPOePf1IjPWVkOdMt+vqMiqK6675evji8SrVn43ad1vly8ipbMKk
         ioH3OmdSkiYoRTq6bTJ0nasbwHTF7cxKPKLWLhYu+AUkTMYd4h8hdnIpfnXzzG7laeqs
         SImsnVR2K6ziy8+63x9g7rmLQY5xdzxSTk8lZG7E1BHnFpqwLVXwv/tRmLYn611qDpKk
         8PuKs6IldcLrfv6QnuOJgK5t+38ZMwnEJ3aKY+9sTNYXyyQ1rm2T+Kag6tpIaAwomBQA
         IwHYp4JJqh1/hOgTPbmnRQhkq1pbxkxks5QbB/W33gNVmMfitcS+/l3pS/2rt91GInG1
         31ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605249; x=1793210049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5PqjLYJUgUiokTOvnfFlSVLgSp4XVLZwVNOD0zgcVgw=;
        b=cY1qCHanricvo2BDzbj3NeS12Ns8jlS5aXnr126LE/HF8WVXdrLC9pfb7YGnv3v+CG
         Gugbsxa67ICXO2iyTTiFIswpzwXiLLS4uCUhBsFu7EyApDDKytQgNsxk1bRooXOEE8g0
         M2sGTZYdFyCdg7MNWyIiagG60xkYD8QsRmGFgWZ+e6UTxdVJcTdW8s5wA5ZscgtyHHgC
         rUAYBW2voLt/xPBlE9Erz7Rbyn160r7NSxB8qqZdCw6WF2ymROmMwiGhRbfIGro+BYQc
         us8yKRnToTU+qx/zM5vsSjXMXucCfNdTia026EsF/CdFsylRTA9Lh+cgwA7nWz16jT3E
         PqDg==
X-Gm-Message-State: AFq9FYIiGapkvNLTnW1j013Fj9RedB17vngQDffBtVNuukg4hNFDBy7Q
	IhUy6blTUEtAN0O0RHkTMh35hJ3ggU0aLaMkbtf/h8ArrbgCxNwns8g/YP2V/6PIZxc4JcgSey9
	rDKxCPl0Tbg==
X-Gm-Gg: AYBFou3cWCMny0/AQLpGiFTV0V4hEk70LiQB3T2fy0FvT8munQpd21mZYuKj/AiSChk
	TZBoR5MQ0RSbg5JU4UUhCHz/7VzfinFwVEovLKyKo4e9/FAeVD4MPPKoCx+KK/xlTW8jq46B5Ya
	7hBaXMKess+3Sg99d0giIidJ2a6erB4OTXTa7w/6dR34qIXgzx6RzyzMJncmO852dD6Uy+0R9Wi
	i/e4KhBEc9W3UMIKnPT815CcybF7ZpPJbOcDom1DCaODkRp394tBp9uXzVtH7fBlskwK9o8hln4
	7yC/Lg4IsAoc+zfdbDI0/ko5vVS4Ku28rTk5h5JGDyugyXjhpTCNl3PqyF727kPczXG3lTs7Qof
	6U5JdtzA5tPAJYKpWrkkwd5nEEUvXgKc/UAv2BR+NHhxz98ipz5Q4bAtBeRBMtG0AK5z7NsVf2W
	Y5PYtZCKSp7sciAqzmVZMidyCHPsg4lnv3eUiqvq4xJkZflOuMfApFaHJ3AaUbeEoVQ+cDSyVxn
	7OMWwrk2o4ZKoUjo6rqkBzjCFsDHLERhBTZj/3n4ZzXXXQy2oGdwkrsd/Eyp+M106sGrr3AV0YU
	8f3UAXRcJldKiiGMxLwoUaPekeYkM2JQGAyuDaPDzaxnF3sa7+OU
X-Received: by 2002:a05:693c:42d9:b0:367:e68b:c047 with SMTP id 5a478bee46e88-367e68bc08cmr2811480eec.40.1792605248757;
        Wed, 21 Oct 2026 10:54:08 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d059:e601:becb:a5ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-368b4b8e9c6sm17395eec.1.2026.10.21.10.54.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 10:54:08 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net,
	herbert@gondor.apana.org.au,
	ldy3087146292@gmail.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	n05ec@lzu.edu.cn,
	tomapufckgml@gmail.com,
	yifanwucs@gmail.com,
	yuantan098@gmail.com
Subject: [PATCH 6.6.y] crypto: af_alg - limit RX SG extraction by receive buffer budget
Date: Wed, 21 Oct 2026 13:54:05 -0400
Message-ID: <20261021175405.1542-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
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

From: Douya Le <ldy3087146292@gmail.com>

[ Upstream commit 8eceab19eba9dcbfd2a0daec72e1bf48aa100170 ]

Make af_alg_get_rsgl() limit each RX scatterlist extraction to the
remaining receive buffer budget.

af_alg_get_rsgl() currently uses af_alg_readable() only as a gate
before extracting data into the RX scatterlist. Limit each extraction
to the remaining af_alg_rcvbuf(sk) budget so that receive-side
accounting matches the amount of data attached to the request.

If skcipher cannot obtain enough RX space for at least one chunk while
more data remains to be processed, reject the recvmsg call instead of
rounding the request length down to zero.

Fixes: e870456d8e7c8d57c059ea479b5aadbb55ff4c3a ("crypto: algif_skcipher - overhaul memory management")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Assisted-by: LLM
[ Backport to 6.6.y: Add braces to the older block-size conditional so the
  new short-block error check and existing rounding remain under the same
  condition. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the fix for CVE-2026-31677 to 6.6.y.

The code changes match upstream, with braces added to the older block-size
conditional. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 crypto/af_alg.c         |    2 ++
 crypto/algif_skcipher.c |    8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index e7fea668473d9ede47c7d0e2005c333d34147b29..e6e94b34e0afe78f4d2a8a60c6a194bd0a958beb 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1207,6 +1207,8 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 
 		seglen = min_t(size_t, (maxsize - len),
 			       msg_data_left(msg));
+		/* Never pin more pages than the remaining RX accounting budget. */
+		seglen = min_t(size_t, seglen, af_alg_rcvbuf(sk));
 
 		if (list_empty(&areq->rsgl_list)) {
 			rsgl = &areq->first_rsgl;
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index b12df4544d0bbba3f3d156f0e279ac896cd81ec0..8729ef268d9d83cea537abaf23c6cdbb45f59ccd 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -82,8 +82,14 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * If more buffers are to be expected to be processed, process only
 	 * full block size buffers.
 	 */
-	if (ctx->more || len < ctx->used)
+	if (ctx->more || len < ctx->used) {
+		if (len < bs) {
+			err = -EINVAL;
+			goto free;
+		}
+
 		len -= len % bs;
+	}
 
 	/*
 	 * Create a per request TX SGL for this request which tracks the
