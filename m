Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093410;
	b=cMQGNrMMhDNBbUf2VkrZl8pBgvWeFJxWWtXQcqReiGqAR9x+oPoPkJhqT1+AzNLWahiR
	 m+I4lZuPuRgs/P0QsoRLQhZRGT8hMIDVwzZqVcKs+W7US9La7ra6ZkSGZsL+ni4VSOn8X
	 sKxqHu+ySauADH4QDogaUKREQ9YCy29sTTQOXoVGz2xep0id7GYff3L6wgo7UGXibVoaD
	 wzk2WwUe8OvI56Q02Tny4obGw6V6Q7w7JXrcSwj+3VloZKlIwad1HFSkl3fi9UGlwP5Dn
	 kd2QdBv4KXf2TqKxyZ1eZS28zywU7W1LtTlYoLYZbCnj6gsKV4S7dGfKXJFVicEvhYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093410;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Z/OSGHvHVnn2Ph/Qe+hZsNnhnmtZwlUM7JMP60OxvfQ=;
	b=qi8z6u6aR/9YmUVuZa5qdfRtQ7eSYjp0W6FrCeOK/hlivUM2mzOidODxjL4eZ5OuxavW
	 b+0Oq9ag2x+prtq4lPC4N5LrkclwWSu0TVkmFdLCfbt3xSUaqj8M7XoHbvl+wyEexjxPP
	 yLiX5SpcjbhnnTkGpfuJQy9F6KJ5K4jFF5ICTO7B06ccgDLVRnVqyOSWAlnpP8Ze8Picb
	 uKVmO2EKN/sLhVYMrOw/bwx0ZExfg+l6iUMFOPu48OqaUxKtEMskTcetiaMvs0SViB85w
	 EBUWeRg6wfoSrydeeuqoqm03Q68y/MLmK8VN61rQdZMGleMx+9EoZsrX5XGemDqPVHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=m7WXrInM;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ABE606A326;
	Thu, 19 Nov 2026 13:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43ABE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=m7WXrInM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=r/7DOVU3zbP/DiBvAk5lk/ApUFqwoCwJJqDxg9WSfaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m7WXrInM9CokMzVQlOEoy7QlC4SI7aRVqm5756P9gienxG9OA2pGNCFAs1MKwkG+J
	 b3Peawd3yS5KjBnj5vQ5a9pSQDKNS2eQ9c1wBHFjhgoS489yJF5CG3XMC2hzyg75DU
	 Oc2Mu8gCFt/JsBea13K0FPDtSmmKLGw9yWOZyWjt35xo6StZECT7KCGdIIwnc7NAiM
	 58kEUVEOsGXUT0FxBs+Sb4RU/hjWC/LZIAtXK2IU/BJI7GCPw67O66VofGcIJpHoOw
	 rb0HkhRkAu534ppMTC44CcI3TjJk+PP4P6kuPEb+swJjdMnJvHHX1l2IcfkJpMzEI1
	 sTmL2tVOvmwhw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D797317E0DE8;
	Thu, 19 Nov 2026 14:03:22 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 92F6A480031; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:01:53 +0100
Subject: [PATCH v4 03/11] PM / devfreq: rockchip-dfi: drop incorrect shift
 of LP5 bank mode
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-3-517a68c008fe@collabora.com>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=r/7DOVU3zbP/DiBvAk5lk/ApUFqwoCwJJqDxg9WSfaM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85rzgztPrhe15mOzQThqgubzxnmjjDiXZ
 Re4lABkofhTmYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qaxUcP/AnyYv/h/Ex+H+Nh4DTzdozserjwNba7o4OWerriSN68xuqqyLGrcRoM8jUZYlN63ey
 QiXp/QTPSsUyBCzsmjyEnyIVlGljGY+8BsezHg6rTBTh3SZ1XG+dJiTzmFELf6gvRDudr2acOEU
 zfWLRMidmbGZAE36uhiCIrkwow0VglA4GTnmHs4NcoPSNzsOtSfxmpgzGH4gQaksbzNHuXRuCHu
 EDqrXfOHZkWit0P8Y6IEtxP6IdfjyfRjjm4RvQDdYAfOrsFgXb43r0rX7D8DUF9qgvRmIDdxoap
 90Oy5iHbRZKQCiQBQGhiC5BhhRF001SUf0HlqpcVUPkH70JW3f4OnMUkpiDpD+aTok2Yx0fqZBk
 o3UtucIsnbBIUMsBZC7qoIyrKqNM/jps+6Aj6r1U/Ep4rgS+oL5CgZ2bFv0u5UHzPuo7SsacnkD
 4vW7gxgfDi+p94PxsciUBb10YZaWPs6kY8KL+nMB0COLzHCggm++6j/jS1XOge4zaDEJCSoapYS
 /PCAIiKv9A6b2Kz3OJmqSLXY6VpAP+ZXCMocr0ywm+PD1TMEfw/JqhiSKgRDGr788PEQjeRe+/N
 rYqPEUQHKE+0MwTYi92Uv/8laxoxM6NFlh5+4qiBy/Ncxg8CVOpbtc2MMLg493JhA5kIZWokc+D
 6mumnCqh66/SbB1gExoguLA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

When the driver got converted to the FIELD_PREP_WM16 macro, it was
missed that the lp5_bank_mode variable is already shifted in
rk3588_dfi_init() resulting in FIELD_PREP_WM16() effectively doing a
double shift and thus writing 0.

As most Rockchip boards use LPDDR4 (incl. all of mine) and DFI is more
or less exclusively used for debugging with upstream kernel so far, this
hasn't been noticed until now.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-219117@kernel.org/
Cc: stable@vger.kernel.org
Fixes: 7e85ac9da1ac ("PM / devfreq: rockchip-dfi: switch to FIELD_PREP_WM16 macro")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index e0b942028e50..22f82cb6e33f 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -800,7 +800,7 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 
 	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR5) {
 		regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG6, &reg6);
-		dfi->lp5_bank_mode = FIELD_GET(RK3588_PMUGRF_OS_REG6_LP5_BANK_MODE, reg6) << 7;
+		dfi->lp5_bank_mode = FIELD_GET(RK3588_PMUGRF_OS_REG6_LP5_BANK_MODE, reg6);
 		dfi->lp5_ckr = FIELD_GET(RK3588_PMUGRF_OS_REG6_LP5_CKR, reg6);
 		if (dfi->lp5_ckr)
 			dfi->count_multiplier *= 2;

-- 
2.53.0

