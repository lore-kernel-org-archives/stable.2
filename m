Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335E3F99EA
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424681; cv=none; b=BDRP3KkKRYTE4LjcnkEcV9GC9YXU7xQYYPJembZ5jUGh9njb0l//5Jfi4Z2sQHl24ca/2vnyfuaTVgv7YIlxOLWxUSFPNk/HaPbIw1zdcFpSicXUIPAJthIDxKPUPk4xKlxGLGZgA+iCE7fgXyC++YPz1N1KiPNWzu4To1b1c5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424681; c=relaxed/simple;
	bh=KyobzfFT857/xJYn7ncP07FGsnX/hqiiLm+rms3UCTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDnPMfCKAqkDQ4M2k3BcZMML2MfBu+HmXFaGE8ya0NFBcgkKW1ScoSHAyHQPgLyILYmtc6d27nnCzEyxKYe3N/4yToi6Yk+xSx7GgVpLkWZ4L18ugaxJpC8xDe3iCaXxsFRO4BlEo7qkIUuoMJAjRAVTxYRIV27a3NLCMgf0qyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=oQhUC+7+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="oQhUC+7+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab973140bso48925365ad.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783424677; x=1784029477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pKhBjhdvedO5kI4cf31ZT3jc8IVL8OLcFwvvWlnVO1I=;
        b=oQhUC+7+wjfUgw4RL3m4EqE5ZF3ls1YWlPg2NP/bRBFg48Fdui/Gor/qqejJwEvG2m
         vArNfn0+j2KKcXsjn5Xs4hPDWNMW9/EdHbR6D6f+tIo74Mx4Kh/QlC38lobC6toHQ6zB
         CRAlJQnRGNJgPJMF7QgB0e0q8neX35q+PyWWeVeNmFTQJa0o/Q9t3UjvUNBtSXJoMS4v
         bsk3Voi+ojAwRNHNWD+GSssQCmD/Hxp3frFdTbb/6akRrZGodOt42fZS1LetahhmvrgG
         IPt7Rk558gDO40X2JOwn8icS/TekUIseNPUXuJesQI1CLxfBLJj/4WGJAtvS8A54UbbC
         M+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783424677; x=1784029477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pKhBjhdvedO5kI4cf31ZT3jc8IVL8OLcFwvvWlnVO1I=;
        b=GIYZpOwKOZ/ymadYCNvyNrBYZ/3snZ5WSfGSQeKm+LyYBK/PZR/Z+LZ/++ND8kMEf7
         pFWUjiF6BJZWZt6b14k5xaTdxwBwlFgnLoTc8twYb0oSItrJHyYE95u6Ooa9Kw8u7/hj
         nUniUJ2HgSGWP6Zf4Ujs2Pu3gS6n0RPDkcJsRuYMc50DGmB4rLWCaLoY3qY9NlneDnfB
         0pNVnp5A6A6+VVyVbv4z9FDVbU82Plc1Kv7zPNCzlWSZo92LHy6UoeJm+++WA318hvQe
         zYXtjaCwyTvpkjCL3lZKCkRnzLys2QSBFnfmzfhPBPb/8w0ZZmvCEx2TUBypSei9iiJR
         Dfsg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4rf+zZq8VaOlFlCxpkUAhINICLi570Vmxa2xeYfiai7LuAFQROEISyoMnb+p55HLkzzD3jho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQQkybNyiqIeCi+M7FCiihwaqh7h0/FX6mZt/akXQkJxfsHz8
	FOmWcvLfYPGVqZFMgzKj36b7ACjW/oKiSZ+QELC/r5ZfknTAylfuLtnEVPxIvMwR4IY=
X-Gm-Gg: AfdE7cnGprFKBiAHLcaI8FOZUP1qtGK6o3f6f0s+cW+WUjVNG5PxvY8Lkzs3x+len6+
	rENAYW+HJAHCz0wykvNLX6wD7Iw5qB3yVTD3NUWls321fwsl/riSfZqI6/T2VJRPcf3WmNGg6jE
	pNNoCy3NP0y9fZc2CEJuwK0VN0yVrZ9yb12xkXTtdGK1Ur1zpeFPhiz7e1eyQE1MA6hC5RTNiE/
	PcA047eLbSuWM/YbkeM8PMQfeN2yd6+PDkHv4U7AsDh339r5Pi8oh81XwPbSBWmM3qDl1dLgBpa
	GWYZgSK2sfQradk0syAcwfjDT9O/qmU3rSZ+REbzda9xI2V3XbpReGXeqX2epMhrNAG6hMcENcg
	ziZU7SnW1GVCrd3NnSEHLb48PMVIdisQ0/JR8QfLzVuFzGMnDL7H0K1DVoGCfzrqSiv2xwmqSqt
	8lgMY1F7meU0Q/vzr7Zip0AeJwq5VvFHf0JgJEXCuTnsyrdL9pNeNRpiSrsRYHCp4iVOXIqkDKV
	X63gn9200MoJg+GwFu+Vx9df5ZQ424WkRJhw5WWOPU=
X-Received: by 2002:a17:903:38c5:b0:2ca:11fd:659d with SMTP id d9443c01a7336-2ccbf07b550mr53814135ad.34.1783424677549;
        Tue, 07 Jul 2026 04:44:37 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2ccc9d59e51sm10206015ad.76.2026.07.07.04.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 04:44:36 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: david@ixit.cz
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nfc: st-nci: Fix potential memory leak llt_ndlc_send_queue()
Date: Tue,  7 Jul 2026 17:14:08 +0530
Message-ID: <20260707114427.998485-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The skb dequeued from the ndlc->send_q is dropped without freeing or
queueing it back to the send_q. The two function targets of
ndlc->ops->write : st_nci_i2c_write() and st_nci_spi_write() don't alter
or free the skb on error. Fix this by queueing back the skb into the
head of send_q to be processed again later.

Fixes: 35630df68d60 ("NFC: st21nfcb: Add driver for STMicroelectronics ST21NFCB NFC chip")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/nfc/st-nci/ndlc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/st-nci/ndlc.c b/drivers/nfc/st-nci/ndlc.c
index be4808859cfa..480a30acd996 100644
--- a/drivers/nfc/st-nci/ndlc.c
+++ b/drivers/nfc/st-nci/ndlc.c
@@ -101,6 +101,7 @@ static void llt_ndlc_send_queue(struct llt_ndlc *ndlc)
 		r = ndlc->ops->write(ndlc->phy_id, skb);
 		if (r < 0) {
 			ndlc->hard_fault = r;
+			skb_queue_head(&ndlc->send_q, skb);
 			break;
 		}
 		time_sent = jiffies;
-- 
2.43.0

