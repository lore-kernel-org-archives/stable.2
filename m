Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696128;
	b=WAaljWknj73iUQSW/wyyEFEqbW6ALjSy0cd6CEP/s+xhJ5C7zRT/7572yifNTRSAZrU2
	 ag0LaHQzBjXMekX5Y/dX1+waGAfAzM6yGOfLOSd7NdVl+VIfed0Dwqv8Scuy9T6NPGleY
	 4rOU0mk5rjwgiOA278xKqwQXoplt1M2LGM8UH6hgE/Oelxio9ws10etN+ixs2FBarQ4Xu
	 7eqO4lq7hTiMWK1VOMeVWoJqjKsX8fUwuIzCfcSvf+t9MjGc3hF9jCiqyMBuptcRFp9Wk
	 fergOwbaoiO/x1kgFMC00UKafvFDRQC3m05yBvCXGAdpGUfSzdzAVIR6Hf7J5FTGTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696128;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=skS4Hj0nFWFL/cGWu35SXWo0kl33qV99q/2dROGQj+Y=;
	b=M45J3+8SolDvkik9xuMdf+kY8EfdRRZbRMf/tGmGS1u8Or0SwY36AIOYRmPBs1zlIfnI
	 1NR2EIRTmoaM+Rd9lq9w0CI1mYJ5v/9zOP18ADkkxwUCNXtAGgFxbaArN8OJIY44dzNS/
	 pwlYW2LLjPkGnRAg90McnUARw2C2oi2N9gARA/uTgUppIylj4+A1gGTX4C73njVJEmO14
	 U5HRKbQYi+zMAysApyygUmvdzJ7Gru4PGmoee3B8J125nhzNmpXLJCDt9bh99jtB3mBVN
	 kda+dlxW12U4FoD2D5tfLneWfB+Z7xEv1PYUel0ULhPZjMigdXt9bWqzigDYG+02PQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=sHIIfLuQ;
	arc=none smtp.remote-ip=115.124.28.75
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393A606A324;
	Tue,  3 Nov 2026 08:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C393A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=sHIIfLuQ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793696115; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=skS4Hj0nFWFL/cGWu35SXWo0kl33qV99q/2dROGQj+Y=;
	b=sHIIfLuQc5qvtCAhQT8GYlRVviqImPNlRG1mWvCNApOUxii7+7yKaV3fE0aV0GhKDTp2+lEW1dKgrk6C3RGiHIBsWL6oUs1pHvjnhLtorN7Cd+H4YjAfe/FEVX65ctB//4GIDdVFV03b/VsnS69aFmrrHRtrK5Fv7BfE/evjQMM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1169655|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0211264-0.000480096-0.978394;FP=5579365199278152916|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jvSnYUX_1793696114;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.jvSnYUX_1793696114 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:55:15 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v2] Input: joydev - avoid signed overflow in the broken-axis correction
Date: Tue,  3 Nov 2026 16:55:14 +0800
Message-ID: <20261103085514.431010-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103084135.426629-2-zhugl3@xiaopeng.com>
References: <20261103084135.426629-2-zhugl3@xiaopeng.com>
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

The JS_CORR_BROKEN correction multiplies two user-controlled 32-bit
values before shifting and clamping the result:

	value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
			((corr->coef[2] * (value - corr->coef[0])) >> 14);

The coefficients come from JSIOCSCORR without any range check, so
three things can go wrong: the subtractions can overflow 32 bits
(value = 0 against coef[1] = INT_MIN), the products can overflow the
type, and a product that survives the multiplication in 64 bits can
still wrap when the shifted result is assigned back to the int
variable, which then slips through clamp() as a small value instead
of saturating.

Compute the whole correction in 64 bits, including the subtractions,
and clamp with clamp_t(s64, ...) before narrowing, which is
bit-identical for every in-range input.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
---
v2: per review, extend the 64-bit computation to cover the subtractions
    ((s64)value - coef, which could overflow 32 bits before the
    promotion in v1) and keep the shifted product in s64 through
    clamp_t(s64, ...) so an out-of-range result saturates instead of
    wrapping during the narrowing to int.

 drivers/input/joydev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 32459fd..18aa9ce 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -72,11 +72,15 @@ static int joydev_correct(int value, struct js_corr *corr)
 	case JS_CORR_NONE:
 		break;
 
-	case JS_CORR_BROKEN:
-		value = value > corr->coef[0] ? (value < corr->coef[1] ? 0 :
-			((corr->coef[3] * (value - corr->coef[1])) >> 14)) :
-			((corr->coef[2] * (value - corr->coef[0])) >> 14);
+	case JS_CORR_BROKEN: {
+		s64 tmp = value > corr->coef[0] ?
+			(value < corr->coef[1] ? 0 :
+			 (s64)corr->coef[3] * ((s64)value - corr->coef[1])) :
+			(s64)corr->coef[2] * ((s64)value - corr->coef[0]);
+
+		value = clamp_t(s64, tmp >> 14, -32767, 32767);
 		break;
+	}
 
 	default:
 		return 0;
-- 
2.43.0

