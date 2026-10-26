Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792991955;
	b=gi00REPRTY9jJkTy3RSPUYIjKY7gESWBE2lGDL1jYXZjPI4Sm49Y37/virpDJZBLc7gA
	 9hJ9YFj3ZF/imHHf2rztu7Wy21tdf8fCNGym7R8VLK8CUbES69OGcfv4uM/gBy7RsFUgx
	 DSQkJtqqmU1xEukH6qb/zctavsiCGNnfmZYEGGEEZ/4Voj6bmLYul1kcq+JvF7oKNvPJF
	 bevkfM+TkiD+WkI7fvKWgoIJxUmDf7Kjw4Vkj2QvqOMOua/9c9j5w6SvimahoY5QW0Zri
	 moHoLukSDW+vVVjzG8iVUhOGUmDEBjMJXcHzY/BxF5fAnh4OqBTAWAz7sagp7yBdEIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792991955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GR1SJvSKmvxCr2BjcQJzd+vqvhW2VA+xloz7HS/XgAs=;
	b=Hat2StpMeAEvuLrGzyJLKLMqP3/Mz5/XPT3NwYEHhAHZOKqiEITS0YocAbd/UAmpAPkE
	 Ne2MzF+ioA7PsxTH2ph88AI9XOoK9nKJsy95fyK1pVyUrc6PN7lwhFDRv4OdjSxUjua9Q
	 AbCvboWdDFgu4ezqO8lF1Y7IECpQ7BPL0RKvrdZU85IM8FGG/s9wcndJQnaC6eWft0x/P
	 c8xOcDYXDRSDKqFRLwB/hJLv1dW9Srs5QAd88ETrszDlYTNFQPzOrCW8/A3h4NK4x3Akm
	 RTeaLeWkg9t0bSm8KFnux/qO43GzzC9q7amMLfV7C3LD7O+6M0TIl11cX2584OX8UFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kl88xs12;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1B606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD1B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kl88xs12
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e0d1da913so1968962f8f.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792991953; x=1793596753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GR1SJvSKmvxCr2BjcQJzd+vqvhW2VA+xloz7HS/XgAs=;
        b=kl88xs12a4DUn4RWwpvSIEj9DqMyCBJuuTbiJsXrpo4LqeUWra3r6jxSNY77+hi+pH
         FC7WgVXm2uLm3iBRhJYyIztvONqSdTTJ7O0nMHc/Oab19AZGZi8jW0P/1oXKTNU6AfGW
         wBHqmmajV9PNZsB4tOogGUqXSL7ZO3LpqtXCxU1MR2muPjhBotIEwv26VVMIPj0MZJWz
         Kq8x110PyZj99fCIozOeXbuKCze4BMv6srieDTYZcdG8VLegA1Yo+/59OWaP56c/stFp
         fuXfOmqyySum8NxvFQiO1BQxREmRmqex/OA1a3NAnjmiZ/OyeZ0RZHNf4MFzVGVVHBr1
         uMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792991953; x=1793596753;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GR1SJvSKmvxCr2BjcQJzd+vqvhW2VA+xloz7HS/XgAs=;
        b=YXZg4LFyipB8m4E+nAZAOYk8eQJ+QpF6ZFaflfeGYQKJr2xKe7lojh6f+6mCr2YqTp
         TZCTtc9FJE/xmt4ARtD7LPAgl8sd13DMu7mu/+lBbzrqgckElOlSxKO1eRT6tYfm/OIb
         C8ms+H8O3RUJMivO1HVwVHWxXvaWlOw3taSxNdYKwHG1E4+BgkKkF7aILOz5Itusnrok
         +EY60akp8pESxVhbWkDL+d9naVepPt9tZCOkCfwOtFvtTMV2IngSsHanUhTlLh7oCaa2
         jc7kvfRHC1URBjYPvGzf8scUyTDJzksjR5IVXcZz9r1xrL/uaOeVwtQQ1J6uabUD3pHF
         2VOg==
X-Forwarded-Encrypted: i=1; AKwUvBxlj051XEwq7mvCUhCzVNfkKwJki4Br/e39zjzDpxG9bnvKT0AgSlKR3dc2cJWA19bCCnXC2HQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNCa7w8YFnoG0uhBfLc+jSJ7d0yBqLEgIznRa2x4fdS7ubRDV7
	1vCzwnUgzX+kRfoYEb/wsvqMwiHCa/e+RvEjvu65dMlDNE9fWIxo276Q
X-Gm-Gg: AYBFou2aNdvfjaM8+Y87UVKf8OQKboZ61ACqkzeqA9By6gW6585SlkWvVYCB6ODMDSq
	/wcwAwrN5Q2zfbCEcs7ZM6Xcxq3PaRCF/VR/8rJLgdZVvF8BV4Qt/+lZe4TjKHcErBon6D91bSJ
	Ns7ncpVSXlD4Vl+Wp6M0ocHn8UGExNUPsxF0yEDkNtykGLdEguF0w2ljEHV8/rMLItHMADTTSls
	fhCbIr5WywcOn5hg4X7ajIMqPQFsZWTQWA0IDZs23TojSi8DD+vPyqcHpLV0QGAyGaG177lL4MK
	+CZNXMlYW/JYWlQhlDeJFFadRoMB2yQBlZL8eYL2cwuax5uvC2y3vYE0ED4f+HSdUeyA9RohfBm
	fa+A/nkOJMFjXYY7AFE4wcSODnI0ofVCqbj5Wl1JRMOFO4FlSu3lmCxpTlGyG2McB50nOzPshAI
	rA2868jzvM3AcOu8o3b0CNYFORAUS0U8wqWc9oOR5gHLLfI3wdma+MeHOwdKgQqvy3F6B2cSGed
	w4C/OqrPNJJOpd3Mk7880JKU6ir7ppDjZ6mf9++FGFsTSlwVpxnkbe8VC0eHmH5JrYEUFVQgfzb
	5Q1fCzMZvjuHtfp6RczKNHbXy6uEtDi4eg==
X-Received: by 2002:a05:6000:2992:20b0:48c:7f94:8755 with SMTP id ffacd0b85a97d-48e3ed3b79fmr6670550f8f.20.1792991953028;
        Sun, 25 Oct 2026 22:19:13 -0700 (PDT)
Received: from fedora ([131.123.42.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm13667258f8f.4.2026.10.25.22.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:19:12 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	linux@weissschuh.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	meatuni001@gmail.com
Subject: [PATCH v8] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
Date: Mon, 26 Oct 2026 10:17:40 +0500
Message-ID: <20261026051740.88791-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The input is copied with kstrdup(), which stops at the first NUL, but
the full write size is passed to hp_enforce_single_line_input(). With
an embedded NUL the helper reads, and can write one byte, past the
copy. Use strnchrnul() so the scan stops at the first NUL, and return
-EINVAL for a NUL or newline before the last byte.

Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
followed by 4093 bytes of "B" to current_password 100 times returns
-EINVAL every time, without reading into the heap.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v8:
 - Restore the comments dropped in v7 (Andy)

Changes in v7:
 - Use strnchrnul() instead of a separate NUL check (Andy)
 - Drop the trailing comments

Changes in v6:
 - Return -EINVAL on embedded NUL instead of limiting the scan (Ilpo)

Changes in v5:
 - Limit the scan to the string instead of copying the input past its
   first NUL (Ilpo)

v7: https://lore.kernel.org/all/20261024172641.19424-1-meatuni001@gmail.com/
v6: https://lore.kernel.org/all/20261016025352.230535-1-meatuni001@gmail.com/
v5: https://lore.kernel.org/all/20261007134711.473857-1-meatuni001@gmail.com/

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 876fc35d035b..435639e19c59 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -162,11 +162,11 @@ int hp_enforce_single_line_input(char *buf, size_t count)
 {
 	char *p;
 
-	p = memchr(buf, '\n', count);
+	p = strnchrnul(buf, count, '\n');
 
 	if (p == buf + count - 1)
 		*p = '\0'; /* strip trailing newline */
-	else if (p)
+	else if (p < buf + count - 1)
 		return -EINVAL;  /* enforce single line input */
 
 	return 0;

base-commit: 8667bd30fd033295b3038ce374c551d1059538ba
-- 
2.56.0

