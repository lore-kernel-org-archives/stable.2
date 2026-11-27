Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795752272;
	b=l9N1gegyQTfJmQOuDzDxIE3iO1NdxHpg+OiVnqEhbSkGWXklmYVGflPz1ZcfSKaWTN4K
	 oNPj/Rdp51Jn8WvYNydmfnZtgDMGRrwFfgqKFVCiKdgFN9JUkRafErd6DstnwEB25uo5l
	 QinQ4f8SxgBMAzp3daMjcbSsvAEopxF2nAHrFDWS6NY7caiHvA1jn2C/Vlr5mE6HhjIQm
	 SshgCwvzpPpuF7w9tyIjkaVqn2tB7CgR/hKcaHnrF9El2CLd7MYHuaPnyDtRNHrbc+txL
	 IUdnIZuOcZ+Tg6C6HAFcWYkRsYuNo9fc7JKnfSZphCSgFxBf7sM8FAahlRzmGT9i8sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v9W2gMejQa4ruYwRadXL7m8rwrpY1sGDNVmUPiT9nBQ=;
	b=cY5hoDg1fSGWunn6tlCvvPLCRNZt+t21J8ltWE8uISg8jGqZxw9dqaLntEHcPKKRU6c1
	 8Mq/jxXDv/H7WKPxBf7bpukDllUFiQTUp4IeLJ/DxkQueoOPYEiE3WaAMyVegfm619stq
	 IuW/JvP3+nLX0vhxWb3MiQ55JF+NUDFrkV27qWATfwFykk0t7p5aB7fgJ9qDzT1t4SI6V
	 5YqipXfGWddS8I7ziAZ026p+VedVjpJIK/PE1nEjf3ZpfD26lHZmpSSsUPf01En+n66Eq
	 M/2IAfYV76SEnIpIziIdltC39vwfe0hF7d3D5jwWR3MyHAoDkHQrvxIuxz9G75plb2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgv7zUk9;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B392606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B392606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgv7zUk9
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f04ad2c46dso47690985ad.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795752271; x=1796357071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9W2gMejQa4ruYwRadXL7m8rwrpY1sGDNVmUPiT9nBQ=;
        b=wgv7zUk9r7TVElCtooNO8NdZH2wqN50UPXtheUgf8EI1CxfY8SJg5eLNgh/7LLhrFb
         YcRrvOYgmvl9F5bRPRjsDvGG0jT1s3fZ1f33JOq3Xmz/jHZznoykafxvQveoQYoiqp/V
         3hgMp3a5Y8wit3ThIbX66H0G/M2iJKV2qIygoPksUEL+MjH5F2fsuFbDKzKNAbk818EZ
         rQ8YxzCftbFery/wjkHxfToJZz5KLGt43OC7iTYXyievXhGabL8wu5+ckF9232dJifrb
         qv98I2Y2jQw7CaeaQuF0fWND+yKuRng5tqT1Ds9jEH3pMHIiQsbnY/OHvQVQSzrc7Gcy
         fZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795752271; x=1796357071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v9W2gMejQa4ruYwRadXL7m8rwrpY1sGDNVmUPiT9nBQ=;
        b=C9iS1+gqbZwmcFlpd+5+pxbGS3HP0XbZLgP6+qZkjB0YJ508Z/dH1TY1OeNq2v3DRL
         Y6P8+vKTNUJPNUHZcM6Y1nW2Uwi9M+fuku3LMZKnTSyHAnmXl/Yiv7o0Ew5edLPZ3RF/
         qu+Uv6MFax9+LpkMzLS9qPiWRfKDkP02ix3L/Vq+h35/SXSK1j6umRq5YR6n7QMuI0lU
         GQKbln2oFHKQwmnEMN5k4IaCHfbjM0ed5r1Ku/xCYf7pql6Ap+Bj8HMicVcVPIldvuwa
         7ZxCSGoeBa0I0bvveWrHu1I49pf3fYZBmtVHUqYOnvqnWSLJdPHU79GcCEyc5CHrnFgt
         pzRQ==
X-Forwarded-Encrypted: i=1; AL+hErEmTE+B1gbsSKGBXQDPQ4Lxf1YRlywooZdsgeafE5nWCxwW8umJZfFmO1pn/3ZurN8+yCFtoKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xy7PzT3cEjaznhIOzFswk/0eJ5Vz8C6dVSRL4LQvY5Xv6BLoW
	DDofXYlW38vAQwKRTdYQ9p4FHIFwjsGLxy/MFVnzFkLgQkXW7ujIY7Tp
X-Gm-Gg: AZFdTZdTpMI3PvX4i6oyWYqi0O32KgdKb4fw/+9GqBHBpZI/Oi+45epwOOc0jJE8Y1e
	DJCReUJ3aUFPe8c1lwQzayHcbfmEb6cKv6WHlOK2GY1b2l4HKY/h1BJ5CKGrXY7yfhb3OesMslR
	xfNzU68RbyrE7T7vjwGUq4SYZBYmW+sRYydqI5WytqupwroDQ7F5xr/qkN818WFwNX4MH8vmX/y
	EYMWOpqurGy6ThEy6UoWopZ61GULyxKqr2Q5ULAOIq+EBoJxJuv/ma+KxGg4uzOROToWYe/5XwM
	vVvefIBC5Wnn8iacLla83h04t2jxFSymrzivXK1ihbFagpCX9hC9meMO7aAFx5dlglybtHIZctm
	xl4GCmkw5y0O0HtgGVTMY4eqTFCx5lCQTtXVZTG7XMzBfcbR4c95QgpeTjPrYzfpp1nGi4lgcsn
	6mBsfHOyBM/xC56vbSp2daNIfsxFWJKFmDws1pF6meJfzk8EsRR/T0P7515SWVNvaoKygaULD8s
	v9ZRIIMWSi1Be4PARNbdRYOVT6hptPa6fdYKmnHvPtdj/BlZisdunF7vXDE84qheahhiZcS4L7p
	b2t9a+bfGeF7yt+NdiJvrZCeGCk7Ia819I2mr1KYUumdU1wW2KSI1He0coVsEXLi1pHrMezPCUk
	tXrmA/ZvYTYFm1s3Bq5S+DLirMHU4ZyuEgeNxG8feor4xj5GolxysMAjsVVHQR3Tfu65wOSdbRD
	6J6w==
X-Received: by 2002:a17:90a:e70c:b0:3b1:ba59:56a1 with SMTP id 98e67ed59e1d1-3b41c939b8cmr21039920a91.39.1795752270766;
        Thu, 26 Nov 2026 20:04:30 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b457a58d04sm15090652a91.0.2026.11.26.20.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:04:30 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Hsiao <jhsiao@amcc.com>,
	Rosen Penev <rosenp@gmail.com>,
	Christian Lamparter <chunkeey@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/8] crypto: amcc - fix missing DMA memory barriers in descriptor handling
Date: Thu, 26 Nov 2026 20:04:17 -0800
Message-ID: <20261127040423.1023233-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127040423.1023233-1-rosenp@gmail.com>
References: <20261127040423.1023233-1-rosenp@gmail.com>
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

The descriptor ring lives in coherent memory that the engine scans on
its own, and PD_CTL_HOST_READY in pd_ctl is the ownership handover; the
INT_DESCR_RD writes are only a doorbell. crypto4xx_build_pd() sets
HOST_READY before writing pd_ctl_len, and nothing orders the descriptor
and SA writes before it, so the engine can fetch a descriptor with a
stale length. The wmb() before the doorbell does not help, since
HOST_READY is already visible by then.

Write pd_ctl_len first, then dma_wmb(), then HOST_READY.

The completion handler takes an entry as finished when it is marked
PD_ENTRY_INUSE and pd_ctl has PE_DONE set and HOST_READY clear. Because
the entry state is written after HOST_READY, an engine that finishes
quickly can complete a request whose entry the handler then skips as
not in use, and nothing completes it until the next interrupt. Marking
the entry in use earlier is not enough on its own: pd_ctl is never
cleared when an entry is recycled, so it still holds PE_DONE from its
previous use, and the handler would complete the half-built request.
Clear pd_ctl when the entry is taken, mark it in use before HOST_READY,
and pair the two with smp_wmb()/smp_rmb().

On the completion side, crypto4xx_pd_done() reads the descriptor and
result data right after the PE_DONE check with no barrier in between.
Add a dma_rmb() after the check.

Fixes: 049359d65527 ("crypto: amcc - Add crypt4xx driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/amcc/crypto4xx_core.c | 42 ++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 7a1ababd9198..e28e836c4f35 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -767,6 +767,12 @@ int crypto4xx_build_pd(struct crypto_async_request *req,
 	spin_unlock_irqrestore(&dev->core_dev->lock, flags);
 
 	pd = &dev->pdr[pd_entry];
+	/*
+	 * pd_ctl still holds PE_DONE from this entry's previous use. Clear
+	 * it before the entry is marked in use below, or the completion
+	 * handler would take the half-built descriptor as finished.
+	 */
+	WRITE_ONCE(pd->pd_ctl.w, 0);
 	pd->sa_len = sa_len;
 
 	pd_uinfo = &dev->pdr_uinfo[pd_entry];
@@ -876,11 +882,21 @@ int crypto4xx_build_pd(struct crypto_async_request *req,
 		}
 	}
 
+	pd->pd_ctl_len.w = 0x00400000 | (assoclen + datalen);
+	/* Pairs with smp_rmb() in crypto4xx_bh_tasklet_cb(). */
+	smp_wmb();
+	WRITE_ONCE(pd_uinfo->state,
+		   PD_ENTRY_INUSE | (is_busy ? PD_ENTRY_BUSY : 0));
+
+	/*
+	 * The engine may fetch the descriptor as soon as it sees
+	 * PD_CTL_HOST_READY, without waiting for the doorbell below, so
+	 * the descriptor and SA must be visible to it first.
+	 */
+	dma_wmb();
 	pd->pd_ctl.w = PD_CTL_HOST_READY |
 		((crypto_tfm_alg_type(req->tfm) == CRYPTO_ALG_TYPE_AEAD) ?
 			PD_CTL_HASH_FINAL : 0);
-	pd->pd_ctl_len.w = 0x00400000 | (assoclen + datalen);
-	pd_uinfo->state = PD_ENTRY_INUSE | (is_busy ? PD_ENTRY_BUSY : 0);
 
 	wmb();
 	/* write any value to push engine to read a pd */
@@ -1027,16 +1043,20 @@ static void crypto4xx_bh_tasklet_cb(unsigned long data)
 	do {
 		pd_uinfo = &core_dev->dev->pdr_uinfo[tail];
 		pd = &core_dev->dev->pdr[tail];
-		if ((pd_uinfo->state & PD_ENTRY_INUSE) &&
-		     ((READ_ONCE(pd->pd_ctl.w) &
-		       (PD_CTL_PE_DONE | PD_CTL_HOST_READY)) ==
-		       PD_CTL_PE_DONE)) {
-			crypto4xx_pd_done(core_dev->dev, tail);
-			tail = crypto4xx_put_pd_to_pdr(core_dev->dev, tail);
-		} else {
-			/* if tail not done, break */
+		if (!(READ_ONCE(pd_uinfo->state) & PD_ENTRY_INUSE))
 			break;
-		}
+		/*
+		 * Pairs with smp_wmb() in crypto4xx_build_pd(): an in-use
+		 * entry has its stale PE_DONE cleared.
+		 */
+		smp_rmb();
+		if ((READ_ONCE(pd->pd_ctl.w) &
+		     (PD_CTL_PE_DONE | PD_CTL_HOST_READY)) != PD_CTL_PE_DONE)
+			break;
+		/* Read the results only after seeing PE_DONE. */
+		dma_rmb();
+		crypto4xx_pd_done(core_dev->dev, tail);
+		tail = crypto4xx_put_pd_to_pdr(core_dev->dev, tail);
 	} while (head != tail);
 }
 
-- 
2.56.1

