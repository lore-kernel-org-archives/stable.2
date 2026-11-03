Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693071;
	b=FTyeaBoLFzNoWUqoSL/3SInOjUuQnbD9S1XorjO/5iM6l9AaStPPKs3qOOgdRBWd4KEA
	 59AXUc0cp7jkNwoBaZrXQMrmnC/XuIE4N5y6c3HcuXIGoZeWGo1dpYf/DVFP6saSS+fh8
	 PPVnYk4uj+UuaE4o9whrcS0feZRnk7CLfgGmiyP+sQwgDePmTR8w0BYoD3ztAV22a1CMJ
	 zYk19Kwm88SUgmdpW8duYAp03sOZutaGGcWxbEFCliJEhvZf7DRDyswB5mdBsYU8uojqT
	 hcAaHnDp5Ov/IHAaugQIYSj7GNKXmHsHXby4/Ce1eFnupYLEzus7wT52aFWc51Hd9Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693071;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=n/m1M2HjDjDaV6DwBEHZEUihDx/lp8BWUTBIt5vBqhg=;
	b=3zecq0lOi9eMGx6tJUH2pDI3X8hkjrmKBIt78f3lu+Cv2p6mMy4R5XIscGYyHkDiKLGF
	 ucU/M6Z3Jz+4yrUR5P8/CJRiTz5OtjQ60zXsYH3N4SgoITAd1/Dz2tqtRI8gaddlBXDVh
	 mJu6TG7w4YESj2XihdWGBlPugqsTdAXYvfpvQ33sTX4G5LVSNt3LHm6pICPLz491GudK4
	 kPw4QJ6rgL1kA9ekIZZgEKUU3C5h0rJUKCn6NoGNOwQoPRf2pXou8x1veEbUeSeow5Mua
	 1wFzEsVgcHpuBDq6BHSvt/4UsZrQ/GKV8NM48MDglzQvA7eJu8IxARIWAVEqO/7A+6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50146606A329;
	Tue,  3 Nov 2026 08:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50146606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADn9ZaJlelqUzY6AA--.1077S2;
	Tue, 03 Nov 2026 16:04:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: tursulin@ursulin.net,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/selftests: Unpin the context in the LRC garbage test
Date: Tue,  3 Nov 2026 08:04:34 +0000
Message-Id: <20261103080434.1127682-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowADn9ZaJlelqUzY6AA--.1077S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4xXw45WrW8Zw1DCw43Awb_yoW8Wrykpr
	s3W3WY9ry5X3W2qa4qya4jvFyak3WSkay3C34DJw1rtrsxZw1kKF1Sva4UtFyUCrZ5WryY
	yFnrJFyfuF4jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjU-B
	_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEAA2rpWtnbMgAAss

garbage() explicitly pins the context to corrupt its register state, but
only releases that pin when request creation fails. On success, its caller
waits for the request and drops the context reference without unpinning.
The request's own context pin does not account for this extra pin.

Release the explicit pin immediately after creating the request, on both
success and failure. A successful request already holds the context pin
it needs until retirement, as in the other context selftests.

Fixes: 24eba7a9981d ("drm/i915/selftests: Check recovery from corrupted LRC")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gt/selftest_lrc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
index 23f04f6f8fba..314922e778a8 100644
--- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
@@ -1782,18 +1782,13 @@ static struct i915_request *garbage(struct intel_context *ce,
 			    LRC_STATE_OFFSET);
 
 	rq = intel_context_create_request(ce);
-	if (IS_ERR(rq)) {
-		err = PTR_ERR(rq);
-		goto err_unpin;
-	}
+	intel_context_unpin(ce);
+	if (IS_ERR(rq))
+		return rq;
 
 	i915_request_get(rq);
 	i915_request_add(rq);
 	return rq;
-
-err_unpin:
-	intel_context_unpin(ce);
-	return ERR_PTR(err);
 }
 
 static int __lrc_garbage(struct intel_engine_cs *engine, struct rnd_state *prng)
-- 
2.34.1

