Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97208311C32
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791007719; cv=none; b=trzcoBWfuCnZCdGE8Ry5eDvmYuDuvakK6ECPDtl8pBzzDmQHf1ydGdqfR8IuaN1ElVhJ6RXqwKC/+nMhSXoz/kmCa5/YzogP+q+BpV0fqlmT+tKuUdg7NQXTc1mIby70mvU3lHS39AQi1zaDN8qwTjGveIA3S1Eqpbc+Yrz7N0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791007719; c=relaxed/simple;
	bh=Bq6MIY7CYCGN5YFO83plBrLT0wDS2LRD2/45NbCikMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2bLIV0ERywVGo7atQx2qsb49H79IB2XFMax1iLcugOCwppt9BF83IjVf6ESJIU6ngNUhNuFZN3KbyDdzjO0+/0z/nKOa5F4MGmTMZhj8Xc12VJ6QMQB2cPwniktQRDNoweaEt34IoOfvQP3aqf8jrYDM3oXF9j+H23CNpKZz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONiK2IVN; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONiK2IVN"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-34ca2d54925so350098eec.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 23:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791007716; x=1791612516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xvPvgzZ7iYnqitO0H1oFllRNtu+MflvF26mLCrcp718=;
        b=ONiK2IVNxf4hQGT6f3SZK54c9rAUF9yxU5YImJzhjRu0o8L3BR7qKqmSqd9+CrKfaL
         9JdIS/Dv72cephy8A7J9qD/BibBIvhcV+DqCHJQcVlt7q2Gv9RSO/OLoCBR0nZEsWppl
         eiifKI0uTUxJO4ypazFqVgwi4fTHRb3721E3uxpzEvLouIE59qRFNBtiQ2iTy7P1FLQm
         bNSbBLKKRwrH30MzfEqoCBEDTOWXnripJk7mdguTdZIo5XadVo6Gh0KXEVDovmDbJfAH
         qoi2wBvWlHL8f2kH7scN9diOmrdywlPZOKGB7Wm7l3red86L9OyEwguELm8wV/MzMXkB
         KtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791007716; x=1791612516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xvPvgzZ7iYnqitO0H1oFllRNtu+MflvF26mLCrcp718=;
        b=13HWb7ZUaY1YEiaBlqwuUY0meR2d/FAzWCt+43kAwwjYjuiNcjLoXdLBvFppfdTXRW
         94qZZ97zqtEn9SxvR55UwXL2b4bkl6e7lLlmNKuyvPBrFfySEDNa7jODLb/51GJzT5kc
         MTJf6v9vNuJYSOeKJAwAzK7pAv2kDrrwH0yXCeVNqz1/C0+EDvfZIcOHwd3cxMuuje7/
         dd/9DCMC9eQp9j681M3aomq4qRsdBHRb73fAR8tkdu9eoHro8u7rF8it4wMG+DZpUikE
         +Igfb56D97GlZsbtNRFUw3lVl4ydgOz3Wjl82Mle9sGV9gaIZwPP0LCGTamxvsc+igNQ
         KTpQ==
X-Forwarded-Encrypted: i=1; AKwUvBztCjTAK8YopjWoRVDdTQIKEdew6A4hS0OxJqscgpDPe86peZuBM+0fNenF0IrfvgOXUkPT6Bw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwLQxwmoBgBBgxbXZXAOP1ToXaVI5+RN80E4ChcVG5JkCsOcxR
	i4FQOfBmnuJxkI9lb1NkJ6aEMBTbwLe3XwInn4P3sIftaMhE5GHs91OR
X-Gm-Gg: AYBFou2VJBQ+aruzQv0wRTDQl0eAg41q4W21rJuRnoCl5gbJBU+eUSxlyT5MBy9nqPa
	FJBM7ReClbfYMP4X8W7bUexywO8iqpVxP8KkSPIX3P452zAc5deU1VVYw8LSyqRmDnFJptpZUOA
	ETHRLFZiNcMJ7zQJW08OS2R8TW2A6mZkUpW4dxo0Eci59x96yt1niqXRAeahvvxRKiX4u5jYaWQ
	u0f9sfPWBhnYCyfyETLtCbC7NYKAVRxLIDTNbI804n9EIOraS/+BmEbjhjPorbHEbFYAiiNEx2k
	4azT0dMwoEbtZaXc2N0vHZJNeSKF7PIAuB8ebKD72M0IwNJx9AFTmTKL+6XJqA9LVp+6vJpWBK8
	qYKN97ASsPD6uznkJu8p822RzxVTvxS3i0SWChuBb3dVSIO0jzVsyC+SrvPSQVF+CG2QkBKqIqf
	wVtvJmTwFXKoZoYPcBRKs/oTB16ppAbIxOY3Mb/acbuwJ4uvdpOytIBVOxQ2wBYWZ4PpHfLwlgc
	DayXD+k6dXbvsPQXJs=
X-Received: by 2002:a05:7300:550a:b0:351:fff:6cc0 with SMTP id 5a478bee46e88-351114114b8mr2562425eec.17.1791007715633;
        Fri, 02 Oct 2026 23:08:35 -0700 (PDT)
Received: from kernel ([103.219.206.69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f067301b5sm12313344eec.1.2026.10.02.23.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 23:08:35 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: ebiggers@kernel.org,
	ardb@kernel.org
Cc: Jason@zx2c4.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: chacha20poly1305 - Fix missing state zeroization in xchacha decrypt
Date: Sat,  3 Oct 2026 11:38:26 +0530
Message-ID: <20261003060826.7792-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `__chacha20poly1305_decrypt` function does not zeroize the chacha
state, unlike its encrypt counterpart. The regular
`chacha20poly1305_decrypt` function handles this by manually calling
chacha_zeroize_state(). However, `xchacha20poly1305_decrypt` returns
the result directly without clearing the state.

This leaves the derived chacha20 subkey on the stack after the function
returns. Fix this by storing the return value, calling
chacha_zeroize_state() and then returning the result, matching the
logic in `chacha20poly1305_decrypt`.

Fixes: ed20078b7e333 ("crypto: chacha20poly1305 - import construction and selftest from Zinc")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 lib/crypto/chacha20poly1305.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/crypto/chacha20poly1305.c b/lib/crypto/chacha20poly1305.c
index ea42a28f4ff7..03b14d272520 100644
--- a/lib/crypto/chacha20poly1305.c
+++ b/lib/crypto/chacha20poly1305.c
@@ -199,10 +199,13 @@ bool xchacha20poly1305_decrypt(u8 *dst, const u8 *src, const size_t src_len,
 			       const u8 key[at_least CHACHA20POLY1305_KEY_SIZE])
 {
 	struct chacha_state chacha_state;
+	bool ret;
 
 	xchacha_init(&chacha_state, key, nonce);
-	return __chacha20poly1305_decrypt(dst, src, src_len, ad, ad_len,
+	ret = __chacha20poly1305_decrypt(dst, src, src_len, ad, ad_len,
 					  &chacha_state);
+	chacha_zeroize_state(&chacha_state);
+	return ret;
 }
 EXPORT_SYMBOL(xchacha20poly1305_decrypt);
 
-- 
2.53.0

