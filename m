Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600989;
	b=DQf+MIppst9I+s8494DtBpDCogoNjAR/nGN2sBJ44RKtLHMzyWIb6YQfurG6+6VREmJ0
	 zj/D+C27r0kSyFd+m09a8gkCds4uwzJ6O4xRRtvBcTj/svmAxNavBLUzRowOf3WtyrUFF
	 uIlv492IHQSBIhFvghiMJh4XJ5MZXu66LXse4Vr078NgXClePuJ3vLlhUHC/Z8HmbwbCA
	 3RYzua20xpBa0lbEgQCu0PAJc+SjqsDVGsNq3YGEJ5y9GorPOJX55PbGuKmilhvQ3N4sD
	 dz+xhAd2xEJOyURTedz76+83pNAHSloL5YHgDoxQVXGjx+A9svT4wUKd65+1xBLwFng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=f+38X7/93OJZ0w0/yOS0NSZnjJd7UdYjHJOWwQOd+XQ=;
	b=wyOlMW6pZod426Cn/boWm+oNy2YXhonG7kw0emGMb93W+44+RkXlsBp19J7qPktbmPOx
	 0hvbbz84lDK7E+Z31vxjGmhsxAZUC+9NN/5zEljwEBwNZy5Pn3IyO9fSrf27nqYWYFAfC
	 veIjAoDQ3grFVxsQuNpS0VafG7o9t0SPm8tb7ZED110U5tPmTubE+YlhVKH4dKjksYZdQ
	 f5v9saQ277jKTjRpyeS0DQNFWmBqWZWUeJUuEkG4mTnD+NtuK6CSs++Ptibll7/3bugEn
	 +xEVcV3S0PB5j11T9pRVBXYuBc+dlXhl3u2Z8jued13KbIjQUT0crhchTXGrOhtuxyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="O+o6V/9G";
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC689606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 06:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC689606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O+o6V/9G
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso14286915e9.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 22:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600987; x=1794205787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+38X7/93OJZ0w0/yOS0NSZnjJd7UdYjHJOWwQOd+XQ=;
        b=O+o6V/9G9qcrrD5uEeY2MT+wwGYpdxNfuZr21zm4ab+1ZltYZ2gkMCBCsbjvyjVlEb
         AIUueBf5hhZ9jwJb+5cWZleACmSXRGXXW2txSSX0P+3Ne45UMVO/Y5kZNTcc7lns/Hai
         X27+LuWKvzxAas7iZ/Jz4ErRg11mD3Dx6AWxzB1KG5tRUaFe1bFfPb8zVUfcfp1KoMA9
         izPXC7IBjzrl/egWOPtKNF9XlEoToCa8s1TfmEMhrcwUmiHSsHIHfBO+FS5WOCgUVkJE
         +uDT8m2BPBg0rvyn1roa4hIW7apuYIzQQq9N7qMsl9y5w06XzdE+uYtMJddsopVt1/UF
         5Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600987; x=1794205787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+38X7/93OJZ0w0/yOS0NSZnjJd7UdYjHJOWwQOd+XQ=;
        b=FEdDbm9gz5Vo1tlbwrPU04KFiYGmvpfw6I8hchnpKYWQd6s2pjTykwWJOGNJJgDmta
         3JT2oo1wi4uOJ7w30oVBEIYtJAq3H36W4C3UzZiFCmCXLJ3WkPaY7QF3i0P7DJDBQ3mN
         Lqlc4PabLJ4sWTfdm/r0S1a0xL2oOUAeKq4lu8wYwWeiGE3AnVB0XDmdSULcYXrSeAtY
         NBGCkHhEahH3zmeeaRPG3FiXmiJ4P5oooIZIYMHI411XmfW7KZgwyCCbujeOMblg8VoY
         Q3Ri34LnbySMc4O2C+hGRqfzWrglBbGqNZPMA4kKUKAmi58WE19uGiGUYjiWbJ/zLy7E
         +acA==
X-Gm-Message-State: AFq9FYLbZ5IqNiJ7oHSSTQy5tfmI92lNWu6FziIB6YAv8+FHFmLAdzQh
	ZBBznrznSeEdbUv33wkNqL6S/KrvCot5DALbjogVMadJiiCH2+zWR44YWIembHYA
X-Gm-Gg: AYBFou3+x9v06wVlk+qV5uS+179uirSohivaHmDXd4PN5aduFnnvh9hAMWe13f+4AOw
	iNicYvgXnuHSlK8ye8PsoRfeU+ZMMsbgHNAUWb81vc4vfWCk9uoUD68ORrA8gNAQTMorOz04K7d
	lqFglNDjLJNtEnM4DdmWwtjMJkl+KM2U0kjakiIrxHau37KQdK1bmZXFFs8S1Mvh02+J7qdq9PM
	GhUY0oPxNmg6UE9mcCuPccxNvnyo93yKObgzfZDCdfje5aS9ukfpioJOkyp92l9D7bs6DNABgPg
	7eIe9mgW1T+ofiqRI7SNj/j5q8aOGZoipxrTOYDBlKqP4/yQHDKsOJZlqYQ9sIXt7ObMUdT84zt
	EMZrDkeSLDfelYDG+o88gzuGiacxWNzREX1CxW5D0g2fXeazd1USZdp5KCFw/x8NRaRnSXsCKtk
	mXq5OhyHGws0iQWmsNBFjVvjOWuRfiq1Hb6qC/VP93hyJaNhyV14/dIR76BX2dgrFhiQDUkWcBE
	Mxvdk1u9SoafEaFd5LfVoM3qPecQ/vFqc2EkuzRo3mTrzbnGCmuZaoP7w94uZd5Q6LhqKggrcA8
	9m7hvvKDGY4iny4y173ZcWrqQuKK1s9BUc3f01oI8q9Udg==
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4ac17e10ac3mr219059815e9.19.1793600987081;
        Sun, 01 Nov 2026 22:29:47 -0800 (PST)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf751c2d2sm273759905e9.15.2026.11.01.22.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:29:46 -0800 (PST)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Joachim Vandersmissen <git@jvdsn.com>
Subject: [PATCH 5.10 v2] crypto: ecdh - explicitly zeroize private_key
Date: Mon,  2 Nov 2026 09:29:08 +0300
Message-ID: <20261102062913.6603-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Joachim Vandersmissen <git@jvdsn.com>

commit 73e5984e540a76a2ee1868b91590c922da8c24c9 upstream.

private_key is overwritten with the key parameter passed in by the
caller (if present), or alternatively a newly generated private key.
However, it is possible that the caller provides a key (or the newly
generated key) which is shorter than the previous key. In that
scenario, some key material from the previous key would not be
overwritten. The easiest solution is to explicitly zeroize the entire
private_key array first.

Note that this patch slightly changes the behavior of this function:
previously, if the ecc_gen_privkey failed, the old private_key would
remain. Now, the private_key is always zeroized. This behavior is
consistent with the case where params.key is set and ecc_is_key_valid
fails.

Signed-off-by: Joachim Vandersmissen <git@jvdsn.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2024-42098

 crypto/ecdh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index b6f493e82812..c37e8d35387d 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -33,6 +33,8 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 	    params.key_size > sizeof(u64) * ctx->ndigits)
 		return -EINVAL;
 
+	memset(ctx->private_key, 0, sizeof(ctx->private_key));
+
 	if (!params.key || !params.key_size)
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
-- 
2.53.0

