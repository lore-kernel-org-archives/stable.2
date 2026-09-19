Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC532B13E
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807714; cv=none; b=Yk5xXTgzXWGvANdjnEIoMyIdtE+tJUAw4GhWdHQ58Cl2slBMUXZy7AGkD46x+qd0sPoQI7bvqRrfgIa0O41fyDNZ118lxSX20f9w8hKiIClHgDPlK0NZin4MMt9aiqWZ8gmQgFqSDFpFzrx3LrkQvCKN1dgzqQLRTqSbOC74Lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807714; c=relaxed/simple;
	bh=yBoG2rJMJKT+Oj/XtmYc5L2ukMyrQZUEjAYXo1F4XRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDl++muva1PnXCWqADh+ShCP5t+8wu93a2Kc9vwFsLPF151OUhYLZ+rqaAk55miOymjqH0NQNip3F+AEwt0fdqP2D5rqPUUxIHiqu475+gc3VcdNZhFW8WXdEAj6njN91mFGU0d/SUs4NmHxhh/qUqJi4E3MQm6fGceN9y7NdOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwZiFXvu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwZiFXvu"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1280368a91.2
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807712; x=1790412512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qk4mWGpiI1Ntb6GqWAdlmOOpCK9T/mDj+iXbOld1WtI=;
        b=KwZiFXvuVamy8O1pcavcCX5Qs8mmBG9J2C93WWRNx7xpcEYcGrfnIpL4GhSosi4YZ6
         tZx0zeGZizSrHSsUHzpB466cz/lkN9vT/dCBEe6w+6S+QlFLCDoCDyAMbK1kG5KprHM5
         9h0EP4R0XAGVJb8U3WifttftIullFKrV6Ifj60BoJ39rzlgfywKDU9BiUKHYIYLDdMMH
         oJeQMN8zK7zsq6B4OCUPYKNm+jmeaYbUnre4v1Tl9LifosKBYtlVvCvr9VmPsB8VEq6q
         FYZmBpkzAShD/xnlMKOQwkgzcu4SxJcBtR5g6mmu9MFn96MJvF9zPZZBlgG/PzQe+NMZ
         CywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807712; x=1790412512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qk4mWGpiI1Ntb6GqWAdlmOOpCK9T/mDj+iXbOld1WtI=;
        b=1B1OGx0U1c04VE5ibbVbS38/HfspTyfwigiz2uDA1MwrsICk/JseA/zHLmYlu8t0fi
         fkkxYdcmZuOyqDqaZ6lURPjK1nR/dmn8YNcNhxvcURcfcgk170IXy6ezPRZT/3w4bDcu
         z78mGM+TIZi8Me9wl0jJwgrlNnrU0KO4+wxvs1aFZ28cMCi7dn99N7cKdnuexKoVRmSN
         D6zHnQkVEyu/fUJAxa4GE/IFjgzRAkeKGxtwHxCpJvgKihG1lFl0aJGRXvi4IQ0WsuWm
         hZmz2V8G5lmcP5HHX/LA0yGnQ0j8skzUn7Z7847XZNE+HnVhZ34/l/S700kNXmlSyoIu
         RA7w==
X-Forwarded-Encrypted: i=1; AKwUvBwD1LQgC66BR57KDDZap2LQWywf1PPk77t80tcFPQiRnT0PTJUwbZ0v8OgV9Ws/mqP7FUR9ziM=@vger.kernel.org
X-Gm-Message-State: AFuF++lTjGNHdk18THHKQVhCfdmcjGDJWynStqMm3xdkxNuE0r5NhlN/
	BjPS4iWqy7PXAhagF+kXuLFAfVLH1VdtULqJ7/BtyNoJBPsOugzdWlk0
X-Gm-Gg: AYBFou17DmpVCvDacyVfTT1V6uXrCUIowmmd4gqsEtFGFSTSYpedxX6dBf5DrmXa298
	hvvr0UQFYIWs3IOFY8ec8tii2wMj38zNnnTM2F56+qirQyjQRbrRYk3jHR/4xcB6xNy4g0SMgdh
	iGAPB3WXzCLQYoK0PYv9pL+j/htT+dXVYKcrWhB7yX1e54XGV5Csq3rmRxGFqDufnmhItPmyLVO
	yUMCuvPtEWO5zfE2SwYnG9gFUm4JmUSFE2yd2FDnrawq+rp4EzPIC+uJt6qyu8CjAV2c8hgzRoK
	TZY0lsmjGDCPZQCKveTE5z3mbglOz3kD9Nox16ISGFBFVADwef1AbT8WD9JhfsL2gCil5vu9zxp
	w6GGYbtNQcaxolbRXJs+p5jLvv7g711gjq4YBGQss6jnY/D99DmS6CxCTng66zglkgxSZjScpGN
	jTd1zSzfLTXNOco4PmA8jN0TLc1WHfMandbSCkkfwrTd7cZuD1jDl4w95RJfvIb4zvreRaS21zn
	5jP6ENjg+1fJBFzgZp2HlK+RGrk9ytJYaeWSckzTOSF7L7R+s+MEtouWiDbOQ6T0Sw/o1E=
X-Received: by 2002:a17:90b:1647:b0:39e:4498:4863 with SMTP id 98e67ed59e1d1-39e54f4187emr13651417a91.10.1789807711949;
        Sat, 19 Sep 2026 01:48:31 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb3607csm3566816a91.16.2026.09.19.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:48:30 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jouni Malinen <jouni@qca.qualcomm.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH 1/1] wifi: mac80211: handle empty FILS association request payload
Date: Sat, 19 Sep 2026 16:48:12 +0800
Message-ID: <325c048982d637a3af80d74ac5b36e9369b93f1e.1789751126.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789751126.git.xuyuqiabc@gmail.com>
References: <cover.1789751126.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fils_encrypt_assoc_req() accepts a (Re)Association Request frame whose
last element is the FILS Session element.  crypt_len is then zero and
aes_siv_encrypt() is called with an empty plaintext.

kmemdup() returns ZERO_SIZE_PTR for a zero-length allocation, so the
unconditional sg_init_one() puts an invalid page into the scatterlist.
With CONFIG_DEBUG_SG this triggers a kernel BUG in sg_set_buf();
without the debug check the bogus page is handed to the crypto backend.

AES-SIV is defined for empty plaintext and the S2V result is then the
complete output, so handle this case before the CTR step, which has
nothing to encrypt.

Fixes: 39404feee691 ("mac80211: FILS AEAD protection for station mode association frames")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 net/mac80211/fils_aead.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mac80211/fils_aead.c b/net/mac80211/fils_aead.c
index 293590976489..9c4f00d61981 100644
--- a/net/mac80211/fils_aead.c
+++ b/net/mac80211/fils_aead.c
@@ -89,6 +89,14 @@ static int aes_siv_encrypt(const u8 *key, size_t key_len,
 	if (res)
 		return res;
 
+	/* With an empty plaintext there is no ciphertext to produce and
+	 * the S2V result is the complete output.
+	 */
+	if (!plain_len) {
+		memcpy(out, v, AES_BLOCK_SIZE);
+		return 0;
+	}
+
 	/* Use a temporary buffer of the plaintext to handle need for
 	 * overwriting this during AES-CTR.
 	 */
-- 
2.55.0

