Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D939391E51
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428371; cv=none; b=hZ7TWZpO9nSIM2XAUMmktVQnxOIDVhJHpgggiN52Wah4VFjsB8DjnmE0spl4KeUjRhtG8kC9iUUjd5QHBMZJ4TFH4z4yYcvjdlwbQlvLPX9W9QsgssexMKSNkXAuuvmllOGIZcXPS+nX3mR68qNVDp0Pq3ZFQxyxrsJShZw+Snw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428371; c=relaxed/simple;
	bh=Rr8JzWohT1tJsTGXm2ibqCRdqbA1on/DZn4rk+VclDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGsi9FpGyzgPjTc+iHsKwwDyUWqWl//V7U4svr9poDcskm+5zHDiUh2md+nokFVOZ8ZoLBSPj3MGpiIhoyy5H6UGp2AW13/x/F7oaDwlmbTgWcExentqZJ9miPYWo4SJDsrT8LgXp4rlzB3Sra9XfR1YHAfQvBg/1bdzgxhimsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ld2Vlz3k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld2Vlz3k"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so89658505e9.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780428369; x=1781033169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz9Gm1t+wb2XGdBfPNWvyntpJxCorkDCnuo7sD8+Tmc=;
        b=Ld2Vlz3kElhVFbe9t/6Bbc81i8nhWuwVt6NJGqBnRJITR98uaiikfHxJw4BTEqNp9A
         vxbETM2FcG3jzONh14FE8cRC8YgmqEtolIp76RQv5VLlsCjL5KsQuNiIbZfdY2WdkAn6
         1Yo6zZ+Kli4XhkI1W2ixLVut07uVWwqx4zuEb09GPsW0jsv9N/9tNY3TxlNQwEEnGhOS
         3XLgiNqypufgkdx3gFHZ5N9vp4x33hImUvmIzmrX73DU5fWNjPO3UOe9V0ahA1uibdtV
         Iz35smpoKktR4t4J2gTUx2Sd39Ng6hb1ivNtX1jrABYgppkueWyd6SKRD0Pd8ywxkYjR
         ojdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780428369; x=1781033169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gz9Gm1t+wb2XGdBfPNWvyntpJxCorkDCnuo7sD8+Tmc=;
        b=R9ATmezjKaQd9EtA5Btwf3A9BFf/E6hNgEFCrxnYgqGqZrGQwKR6LeQdRVRUgncZPj
         6Oh+HbbsICRTQZ3zNsHBhuSE0aFnQW8+Q+C3U7lQcOssyqP97yy85DcvP6a1xLUo9QuB
         x9IOPW0/oTvRapZr/CUH2Kd+imdReCOfwSoSU0ndp83dVFqZ1hpVNtnc5rd1WafJbVqK
         AY5Q+aqhbstLfll/WyaoSZkF1VjAdr57HZDuQf96EAb9JpmU1fb94DJMgDtSoNLqlfCi
         nzcKdcYdfCVAXyyccYgFIPxSUrv/aPde24rYN5aPIPeNL6E6fMIgr0oKZ4eY4uUndtL0
         45DA==
X-Forwarded-Encrypted: i=1; AFNElJ/aLdO2Dy6WHhDyreaE1tskVHi3Mx/QfVrCpdJ9P4lbL8XbMD/SKfW50D3k03r8anI1Ca+9rQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPVPm5BZNPKqndXSj+Mpqn610CUtMsqwsStyYi/AxUaNGm960
	f5MDG11F/6WbWARgd4g4wJMyIjkIz4vzwdT1SndsQzC13H6sazHAfNXN
X-Gm-Gg: Acq92OFNK6dpgwdIubGINmxDaKSukXRpIHHHcGAkS5ssxAYIwMef1FN2V69HHOkRT8o
	lXs7ForPftjtyw3ReMih0VYznRe9ct8o25Q2R8pDfwFj1QqdRu6a9HFa6kE5wN0DVuzJURWQFCD
	gid70F9S0gzUOoQWDlNfd7n9Cg1N0Pq9E1DBYy9f9NS3vhOuCOu/rRLdHHYEE8GvPo4KuAfP1gP
	IXu8s5HPetzdoIlEZiHOtCqYpGnG21elLRpk8KAINAFpkQr6W5wtnYWVTFFbZ6jsjyDHJ6r9i6d
	cti6CcWo4yVprSQNk5fKW9MbtkZKcJ6HcI+1GQZjVaVhX5oyrQsDVqeASM1d1tnBFQaNB8qSp4y
	iY0yfr38ghgd9ICXEm8Jl0CLFMFuMQwETEb/48jC23B9REf8SlZKWFxKX2cnFlAgWqYVsRAGkTJ
	CNxK5QWZOnVIILI7RgJranrW4u4Pw1tZr19MxXHyRoctSmzVVlzqPieX54EleYMSrEjpPuxz6Fa
	IrMdPOJJbZ0kZ1EFXQztSS0bhG04m/OXzlzEZhadCtUuQun1xYW0Mcp
X-Received: by 2002:a05:600c:8a0c:10b0:490:9d5c:a3e0 with SMTP id 5b1f17b1804b1-490b5e8982bmr2280875e9.9.1780428368805;
        Tue, 02 Jun 2026 12:26:08 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5ef:9913:4a77:3bcf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm1473364f8f.3.2026.06.02.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:26:08 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-rtc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup error path
Date: Tue,  2 Jun 2026 20:25:55 +0100
Message-ID: <20260602192559.1791344-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602192559.1791344-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260602192559.1791344-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

In rtca3_set_alarm(), the setup_failed path attempts to disable the
Periodic Interrupt Enable (PIE) bit and wait until it is cleared.
However, the polling condition passed to readb_poll_timeout_atomic()
uses an incorrect expression:

    !(tmp & ~RTCA3_RCR1_PIE)

As ~RTCA3_RCR1_PIE evaluates to a mask of all bits except PIE, the
condition effectively waits for all non-PIE bits to become zero, which
is unrelated to the intended operation and is unlikely to ever be true.
This causes the poll to time out unnecessarily.

Fix the condition to check for the PIE bit itself being cleared:

    !(tmp & RTCA3_RCR1_PIE)

This correctly waits until PIE is deasserted after being cleared.

Fixes: d4488377609e3 ("rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index cbabaa4dc96a..2dc080d0eb6c 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -455,7 +455,7 @@ static int rtca3_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
 		 * specified timeout for setup.
 		 */
 		writeb(rcr1 & ~RTCA3_RCR1_PIE, priv->base + RTCA3_RCR1);
-		readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, tmp, !(tmp & ~RTCA3_RCR1_PIE),
+		readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, tmp, !(tmp & RTCA3_RCR1_PIE),
 					  10, RTCA3_DEFAULT_TIMEOUT_US);
 		atomic_set(&priv->alrm_sstep, RTCA3_ALRM_SSTEP_DONE);
 	}
-- 
2.54.0

