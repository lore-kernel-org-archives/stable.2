Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795840861;
	b=VHlVFghhdAHMm4Dods9LrNWjtx9iYEPBcPG9dQacOUQa7nZjCHn3Sz9T1DViERqkAbga
	 e2mg1POEDgTLGggxuEASJvxmfJ96c/FUeJqqqRXVvtLxIL1RcS991SHNk/ccioGXEh+oA
	 QHIf1M1S3+asaPuKibT09r3AuggE63/XUdu41MrJ3hHVEsvisN+QeSEXOjdFXiGS/JCLb
	 5GPz3/MqHLmZLwq4VtABW+qpxfe0ouso1FKMDyoyTs1/eaK3C+QGgAX6traDKkWlA2TAH
	 uphSBTp25w3Q8kxmI7lYncoGiokWmsqBiWTQEE4QzU6klhdC2oOZ1ZcaG4dsjH1wmFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795840861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+Us9tpfzzDLDdkUkSziqd+1j2O6M4UZEsHL8trtds4k=;
	b=v87OC80qhjMi9QiUwjDb7Cgf2VMozR3lzl5FUQ/s5SHUWNp0S3m9erUpa5XW5FxF4eMw
	 rhlvB3ztYZq0iTnM7hIkrRq65L/ZTObjk3Zl8enorYo4B0tAnDoQ8oAoLJ1GamIg4sykk
	 GZFFXww4C/n9j9FxTFYIhcvgevAw61ZK7nEob7dQwywZ7Ufu2TM5P7Gv/tliEW3vC8sKV
	 rU50+mLZEzn/xH67S17fypuTTE4RJ3e0ZeGtehI1ocWnkXTT92RWyCxU6ONlOWt/QQ1LE
	 D7CmdaqXsgheSt10GiccFdYVrxuxSXNLnxhwAg5Qbmc9Rg68vitMjN6sVknONgvay8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uR0ptSFe;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690E606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 04:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E690E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uR0ptSFe
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f020d0169eso43274875ad.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 20:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795840860; x=1796445660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Us9tpfzzDLDdkUkSziqd+1j2O6M4UZEsHL8trtds4k=;
        b=uR0ptSFe3kesOQaBYh7tue6sJ6IxlWz4FtDG9WL0Z29hr1i36Q602tvfKHuhZh+PYr
         ERMrcjUB0U4vza9f8/qC4RhFRJh1gB3gsnGE5BfP/qCirpKxnqydWnH2/V17zju5yxaH
         laanPjn9hJlRXhOQPvDV/ACnf9lzGBiz9NI3QSYI9K/3G/9PJOhJmB0LECIX+kI4tXZw
         KG2CQpm+2rx9nZuUy31EGRF39l+io/+piKLAZBN6mSzieaejVF9BHYEfsmgPAXfRiNr/
         gjKcTHWLsZ+qVu2gtOGhbEgH5gzF1g9//JCB3DnikVM3qEGdeU58jbK8PNY6t1s6sYVw
         2dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795840860; x=1796445660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Us9tpfzzDLDdkUkSziqd+1j2O6M4UZEsHL8trtds4k=;
        b=ktyRzHD2iv0Q/iDeqGYpfnW/d7/Zy3YlubJ61hzPzIuDu/jrUaCXNAK7Ier4OFNcul
         Fx2grYS9xZ8PPb506nzxrlNP/hwSya7lbaAnjKR/2DFQkvKfTQYea07rqczDwS8z+8Hx
         M9DWFPS23TExQy8+2jltGN64Xx5daGxB51cOBncroM/H2cPOzn5JWL/dC8o1APSJLueP
         CNiy0bMEyt6PTpr2ssvVXySvW9X4zvReDDWspgEn5l3AZ5idxnmhppV5RNQUD6Np1QPC
         kppC+6G6pFPyWhAn1PRjN7DBT6TZmomY4vjsyinUf0zlaY1bqjSxnCbIRAAbkN20xEvX
         8rQA==
X-Forwarded-Encrypted: i=1; AL+hErFXjN7AAI+ZlZ/ufvxE2Z/KwQYGrJqFot2X4+KmZ72ZJ1ZCTPNqnUNrBPGU3dHGLOlFB42L5a4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XIYo499gy1LqWR5usVsVDPpvTqYBbeQWyvl/JvqAUWILn8hDV
	f2uWmzbd/PlVenzdS8sOWc2AI0UNka+oh1KjSd4cm5EAFwNWAhJpqBck
X-Gm-Gg: AZFdTZd+N34D1c/0dcuebWwAFKZEmTpptwhOaVc0JvSpkbJPNn3SpqVL4Cnrf4pGfcv
	RPpEj6LOsnQtVk4KOl1ypU3hZoSKQSlWwVaTMprKM3LkBAIVT2630XcKcC+/+vfCaRh3zP+UMxt
	jr+bQmGD44kTdJfCr+ujYBxYFr0uYp6+3HNnaDFYYqd1pJqJ8+KWvYBTWX3eJl947DKoHLZy4Hj
	BTpme935n8U1kHHQ4nmU6Zx4P4xe7yC7MaAyuXB5DZjR4T37okSPTYk2dlZGqQEvTNeTHON9rck
	U6Ghb9niSsOHYJWJb62ZeO7MKltjBgcbplmRQSbIzHqK67Txi8ACsbXL87L/rljazy/8Uyvw71b
	M78YtWoTpzTS7yvxet57my6EwmoycoRsezRSIRFOxm1IhePzQUVFrXrMeQlnfcA7nKQAzI3aMD8
	huV8X+mnl0auWd89nXBTtTfyk9i9Xwe2b+B8qNdw2Yc8LOa1KGBJszR1RJSvzePtbA2YtvAxY/U
	VweJA6gprAKun2tCa3PyMvq5Ww/jx2hx49r46MvPmUANqsoZjQ4FTvFCrB0dVToCqQ+sEOmsxnE
	54G04+efH79SikRNd+1mkFE6nU8oZ8QVX2OIUSnrzOd2tv/NxclSOKR8jVwfe/4tIoqSebY1T+Y
	HDEiNhvXXkfXZnN/8pI2T0DA8t8o8+nGqlchh+gwQSFtsafzqEViZsZUtTnTaxrY0RfEInbs+Pv
	H59w==
X-Received: by 2002:a17:90a:d607:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3b41c9759a5mr25096820a91.61.1795840860227;
        Fri, 27 Nov 2026 20:41:00 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb1b66sm42716729a91.1.2026.11.27.20.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 20:40:59 -0800 (PST)
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
Subject: [PATCH 5/8] crypto: cesa - keep the chained IV on the non-TDMA cipher path
Date: Fri, 27 Nov 2026 20:40:47 -0800
Message-ID: <20261128044050.722617-6-rosenp@gmail.com>
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

On engines without TDMA (Orion), a cipher request longer than the SRAM
payload is processed in several steps, and for CBC the engine leaves the
IV for the next step in the SRAM context area. Since commit 2786cee8e50b
("crypto: marvell - Move SRAM I/O operations to step functions"),
mv_cesa_skcipher_std_step() copies the whole operation, original IV
included, to SRAM at the start of every step, before the copy further
down that rightly writes the full operation for the first step only and
just the descriptor afterwards. Every step after the first therefore
restarts from the request IV, and every CBC request longer than 1920
bytes (with the default 2 KiB SRAM) gives a wrong result.

Drop the redundant copy.

Tested on an Armada 385 (WRT3200ACM) with TDMA disabled in a test build,
against the software implementations: CBC-AES and CBC-3DES results were
wrong for 77% of random lengths up to 8192 bytes, i.e. all of those over
1920 bytes, and correct for all of about 38000 after. ECB was always
correct.

Fixes: 2786cee8e50b ("crypto: marvell - Move SRAM I/O operations to step functions")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/marvell/cesa/cipher.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/marvell/cesa/cipher.c b/drivers/crypto/marvell/cesa/cipher.c
index 3fe0fd9226cf..fb9ea9623746 100644
--- a/drivers/crypto/marvell/cesa/cipher.c
+++ b/drivers/crypto/marvell/cesa/cipher.c
@@ -91,11 +91,11 @@ static void mv_cesa_skcipher_std_step(struct skcipher_request *req)
 	size_t  len = min_t(size_t, req->cryptlen - sreq->offset,
 			    CESA_SA_SRAM_PAYLOAD_SIZE);
 
+	/*
+	 * The op is copied to SRAM below, in full for the first chunk only:
+	 * later chunks must keep the IV the engine chained there.
+	 */
 	mv_cesa_adjust_op(engine, &sreq->op);
-	if (engine->pool)
-		memcpy(engine->sram_pool, &sreq->op, sizeof(sreq->op));
-	else
-		memcpy_toio(engine->sram, &sreq->op, sizeof(sreq->op));
 
 	len = mv_cesa_sg_copy_to_sram(engine, req->src, creq->src_nents,
 				      CESA_SA_DATA_SRAM_OFFSET, len,
-- 
2.56.1

