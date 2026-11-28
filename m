Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840858;
	b=dh9QwopHhWGV/hAYgDHKclmpcWTibswFyQTsNSPXm9fmfENldevft4IoTtBwdlphiq1f
	 xByIFHG+IbbgWApwsuHpf6Sllwu18qSMY1YljwxN1QldEWWg8rh25S2kHwCmsXs63Y9X3
	 +cuIwrgfpLwPF+sSTfsXekT94NbGWK7GsODjLfTa6E607L/1e4WnFOZkchur2uuQ60AOO
	 H1noV1zY4gCEy/AT8U2la2L+t4Z4SvhLoAkAIfSYQxf/UoAR2SjUqazmudoJdr/9Nq2cA
	 MAJzCuqM/R1CeKiVMr+YKLXOh9rwqH4CWctrfaNWVop4S5aBY/XUlXxMaO5c4ENMydQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840858;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0IEWdqpi7iJ/opemLt0tqH7v//3wrpWUTqWyICITBTI=;
	b=ALogxJD14vVEcJnr38zYysGBeV1EffretYDZoKoiFgQWLRY8kg4C89U3IWRc+bIS8msG
	 BfzIgbQrHyQsfAz7fdZnToBWvTkJD7Tt+NSNGc0hVenvqi54ZgTKkzh9KW7q9cEeI9Au8
	 3YZ5AKR9xIxIp/ICXh6JB51ezBYHkkWTkujqHzqYwQiXgeWi+90lBKIZ7T5l+0qJ4t/Uj
	 WkCqKIXLM8mbGxnimFAEUifdB2Z/MV47fFRTzax8mFX+PLkfYC19awRfRL1CKinME7Fpx
	 G8gNVV0VZHuejVJYuodfrA9IY0RlvKaS3RUA332gbvzrUuF7/5+a4UZIG1FikrqX8jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BurW4gAA;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A6606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C0A6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BurW4gAA
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso4368120a91.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795840858; x=1796445658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0IEWdqpi7iJ/opemLt0tqH7v//3wrpWUTqWyICITBTI=;
        b=BurW4gAAs5V0VVqQR0MBAYP0UcBDw/iLFm/nwWCVp3Es/jYaHFJgEIWo8FyKRvoXTU
         ipVcf2J1ToOVkb9hueYbMgnaFokZqOZYnhJKVYHC9MoAraVSYoV+pkURVxWyZJ5papb3
         l8gfWnfCva41N9Vg0fg+EUNKxv3bEbwwuAHVkO1M+1QMcdnDN7kDe/RdGZn1NmoL9iVV
         XkD/90jPg6Sz/5T/3l0RB/il5RHZuiz3oxtp6C/C2i4euPJQpivwCmy649bfk4srIaxv
         PR1G9pKcarPts8E4NO8xTgNyOHrW9Vu+GX7O1f+Iefma5MHQLk1r0pmF1EzHfY3j+sYc
         /Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795840858; x=1796445658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0IEWdqpi7iJ/opemLt0tqH7v//3wrpWUTqWyICITBTI=;
        b=ENckAD0DRNcblXY2bsk9RXFovN68Noa2fg1cYBj3M49xk3khs5/qFz6n8cEayGPlMC
         NcECPooopk+bbNlT89d4MBAkmtJhZmwf7Wf6JhNincGjSqLktonIqhdWSclZPCuCiqO0
         s3deJGQnGAtx1YI0WVkYM212zo2ES3EWfgoqvsH54Gu9DM05ldN7ueBK5lDcxNTJ1M8a
         aFEPyOhb8S8pwanHMdS2Ia198gG2NV8Dc0cxVKqX0wRn83rteVOgXajicZeTBca1DiTa
         uB4azi6NOWPiY655o/55Gg7XhIdJGrQa5LyZlGIIIJRkK/W3vD6x0uaM/zbNHKJt4/Rk
         r6rA==
X-Forwarded-Encrypted: i=1; AL+hErEn8IEQtQrylFo0lmtncj3TnqoPMATQCM34OrnCGrHMG5PAM3vCQFQSZVyeGryuF6mR31yhzqA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QZCDlGOz2MMeLeP8pBcXZnsf+lxohG0oG/tFixmHDD0q676xe
	q4QH49Ro9dTcbUwS2N+HCReUop9EDEPNnSZnLdmR7mhGnSHnvPpwsi0rpZGi+w==
X-Gm-Gg: AZFdTZcB/qelKmXkq/tj0+OU7okvLPhMoEXTCZlT9+tkef98ch+Eer5tJ7SRqm9Glej
	FUrW0n1rcj3/+DETaVHfWLdb2hOo9UWiAzZl9OA1308QgKlxsSkH8BR2MSepufVWefI8XnON15j
	2R6HgqCYyvESCp1y/lvI5NiQwE3AYZqtyegJhxhfDGyjxIVdJsBfiB8R9+k1HKNvoAUQBGK9/gK
	CU1eFaoElJ3Npf71yg2cEdU0lymPFfUEaIis8asq9S/dUK95qT2FqOWnkGx5LrQvvDBz7tNu+KH
	w9ALAqWO7pL5cHe6eZ2NxsGPIRiuXN3oyAph91Exd9xkxMeli2Py1qC/QHD+ULKyIyTFAV72/lN
	ThCaWgjtAwt1xYPqolcpm2Qz46HOM8Hc8drGqFTA8g+MHKVvA9E1NBg8bHvbmpaZqjtViQy3iFz
	j4TZhbRbbFe36CCMOL4fXmeAjYE89XOguXRZtTJXRrCehNRJhey00iQfpyuTm0bYdoWMGvZ4FAh
	wCmknkIzabz23pa33ufgzg7kJCYM+u/UT6orNGKWoIim0jevbTglDhr1M34KDv5Pf7L/u5kFO57
	mIZAntL1I2itLyzCRz2lQ6Qwar979sijnreeEniO+eGar0BtJ8avWT1xEawN+n8x7tMK/W773ll
	92wSY5Atis0eVeKOfKIeFXkkp7sraOfg2OXT+Jp4Y51vTL6xD2ygICQwBC3tVlX7gFi7jwHWZ8i
	VKZQ==
X-Received: by 2002:a17:90b:2f8c:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3b41c92c175mr24780300a91.26.1795840857655;
        Fri, 27 Nov 2026 20:40:57 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42716729a91.1.2026.11.27.20.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 20:40:56 -0800 (PST)
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
Subject: [PATCH 3/8] crypto: cesa - hash the last full SRAM chunk before the padding
Date: Fri, 27 Nov 2026 20:40:45 -0800
Message-ID: <20261128044050.722617-4-rosenp@gmail.com>
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

When a hash is longer than the engine's total length field (0xffff),
mv_cesa_ahash_dma_last_req() pads it by hand. The padding is placed in
SRAM right behind the outstanding data and the two are hashed by one
operation, or, if only part of the padding fits, in two.

If the outstanding data fills the SRAM payload exactly, none of the
padding fits behind it. That case adds no operation for the outstanding
data at all and transfers the padding to the start of the SRAM data
area, overwriting the last payload-sized chunk of the message before it
was hashed. Every message longer than 0xffff bytes whose last chunk ends
exactly at the payload size (1920 bytes with the default 2 KiB SRAM),
for example any one-shot digest of a multiple of 1920 bytes, gets a
wrong digest.

Hash the outstanding data with its own operation first, as was done
before the padding handling was rearranged.

Verified on an Armada 385 (WRT3200ACM) against the software hashes,
with random lengths up to 140000 bytes: about 10 of 40000 SHA1,
SHA256, HMAC-SHA1 and HMAC-SHA256 digests were wrong before, all of
them of that shape, and none of 60000 after.

Fixes: ab270e7055e0 ("crypto: marvell/cesa - rearrange handling for sw padded hashes")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/marvell/cesa/hash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/crypto/marvell/cesa/hash.c b/drivers/crypto/marvell/cesa/hash.c
index d2fe96d865bd..9fd3d5c32312 100644
--- a/drivers/crypto/marvell/cesa/hash.c
+++ b/drivers/crypto/marvell/cesa/hash.c
@@ -607,6 +607,16 @@ mv_cesa_ahash_dma_last_req(struct mv_cesa_tdma_chain *chain,
 			return op;
 
 		padoff += len;
+	} else if (frag_len) {
+		/*
+		 * The outstanding data fills the SRAM payload, so none of the
+		 * padding fits behind it. Hash that data on its own before the
+		 * padding transfer below overwrites it.
+		 */
+		op = mv_cesa_dma_add_frag(chain, &creq->op_tmpl, frag_len,
+					  flags);
+		if (IS_ERR(op))
+			return op;
 	}
 
 	ret = mv_cesa_dma_add_data_transfer(chain,
-- 
2.56.1

