Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEB633939C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295826; cv=none; b=s+zVj+butnce4mXeWO5LqFYV+6h8FfX0o9wyUeWb6xURrT2O/+jEbGT0mnLc0UhGzdtwh+ydPnmQ9PL8j2Do3b7u+gYZqpoeYSTsm/nzWJhuzO+jmWgTOaJr4SD7cU8Pc8DtoQamiS+uv0bNZPfJa5QrrTDC96bTEMPXBPieahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295826; c=relaxed/simple;
	bh=QqSLNPG7r9G2TUAElBEhYU0c5xAfLL9ZhIBmlG5MOug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAx2+YWRQTMCyCSDMMM8tCz4BG2QIPlhSRQvMjstMeMWowDlzmzTU3bsS8SqmLxl8FKZLJUT1DRhiZ6IckfHR/5H0ICbvdoKzHCdfGYDhGGgCfwBZTmRDnwZolwBkzdu+XZKuRiXbWVl736RIz5Q3DtPd/muUfrTlpL4TBGB7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSFltFa9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSFltFa9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71974de4so1373465e9.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791295823; x=1791900623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=adarSOWn90FDPZZRf5ocRhThbb60qM7pgklG4w9baeA=;
        b=mSFltFa9f7UxeE+X7CE28x+/F4DV/NW5HaGdFLvXJibF+9yO5GjybYu+nXGTF/7WWh
         HhiTyK4JIDyDqtrJTEwWw1GHmisM9zVExk1KaESf4VZ6gV2C2c+LCj2dfMCPuT8BVnkb
         KyoWg9gfh7jyg/FEEjm6j8ZRn5qbX8P8GEszd0x9aF2xGai+hgpy4PgLThCemGmFu20U
         Pk54VLNM+Wbj7xzCOvaql+GCbzhwbuoWT+vJypgd2Hx57rjl35CS9jyZNqYH3wNWs5b9
         +4ABljjHt9G1VD2Li3sQCB90lH0kuC6OB8odbeVGk4/qmxdWrrfiKybnpPJMND83CcBG
         0v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791295823; x=1791900623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=adarSOWn90FDPZZRf5ocRhThbb60qM7pgklG4w9baeA=;
        b=0xHRmqoZadEbkJ7r3Mur5gDmVr31WRw8pwSrs5tQ1hUL3GP/GJQfxHiNzrFQ8Me4eE
         kKmgL0tL+caxPGFJMaB+eFB9NKyzVyi0NIC/ZUWc1v2cLyrtO4FlTybiCcf7nobtukxJ
         MqWRI/yaFK/X5RrpQtTHZyUG1uvotk8nUyRlucvY47PhpQmUvhMwcE1B1AvTP2Tc1yC2
         c2zlt1UkHy99RAXXwGWP/dSreub73iT4XkXFA8n0UGk6e4pp/sb8VZjcsrPhcOGKV9Ul
         qmjEJapVmWoJoFrJygy1C868ZS30ebn2uscRg6WiUjIOmCXTJTf5mhF/pKGcQOh4xhyf
         FSug==
X-Forwarded-Encrypted: i=1; AKwUvBxDuOui/809aMjjXBz4uaLBwXyCbvocn7Ne5ecQKjVps0vEu2R4Mo93JHp6tHyroW+XRCX4Akk=@vger.kernel.org
X-Gm-Message-State: AFuF++m5uTM+gvHXV7ePMsV8JLSacwofLtN2maoKJMLvOweRFrs7TgxY
	69ulbgHck9OTooMRHuy+3P1Gf5hv3kzRa7/yoFwl6VMIrkDNYvR5A+eR
X-Gm-Gg: AYBFou0zljmS2T18I0R60Z1NHAlVaTTaxmusSb9kePQRYqv1zhce8xH6sQSLKC0ZSkE
	lVvDVBwsnqsZCJB3lJoXcDdLDsWZfI7sgLHtdporRJZ1ETnbpytUx5uHJWy4ogT9CbGuO2bWdAB
	dCfSb1j6HjJC8BKDgh5TPVYxfn0oJL9PruXVBdHpyua3quah2XrV9zP46R4gNERR8jf1tNRCOCS
	2iLBacVGA6xBc5IiHq2DuyXnWNH3MwYSZrQP2gW9W7Cs1yPdoXSwjrjC8VJj1oRrKSmDO+RTjdE
	BowWMbbTZ4HvoSk30umU1Tz/7DUAjH2tMnRUDk4ayygxO0xXGFtpwABZPdf3FFXAtrevIMCAhhf
	lcCGnzlOkYKmPM8XYHouOIWyfjPzLj0eDBRB3Z+zur2aCPCWTR+KNtBGqxFj6gZRnICxs7hw3jm
	+M5KRPoXVi6JIr1NO0QRdItaST+3FUFf2rnFlKtza6XeMim4+RYPj2m5vHSZkKw0+un/wbT1nod
	T2IWQoxbBojj6EpPTNsRmxbZqZpg/llVG1vJ04tGkV0ztcT8RB4GQVA1hHSFKpDbUE=
X-Received: by 2002:a05:600c:a18e:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4a1715d1a84mr72134545e9.1.1791295822756;
        Tue, 06 Oct 2026 07:10:22 -0700 (PDT)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a166bfaf73sm227777175e9.4.2026.10.06.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:10:22 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: alacritech: fix dma_free_coherent() in error path
Date: Tue,  6 Oct 2026 16:09:09 +0200
Message-ID: <20261006140912.50828-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In slic_init_stat_queue(), a series of coherent buffers is allocated
with the length size. The size is then stored in stq->mem_size for
normal deallocation. However, in the error path, stq->mem_size is also
used but is not initialized. This error may leave the freed buffers
mapped, leaking a resource and allowing the device to access freed
memory.

Change the length in error path to size.

Fixes: 60c140df15db ("net: ethernet: slicoss: add slicoss gigabit ethernet driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/alacritech/slicoss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index c1949ca060ca..311a9d1d9071 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -813,7 +813,7 @@ static int slic_init_stat_queue(struct slic_device *sdev)
 
 free_descs:
 	while (i--) {
-		dma_free_coherent(&sdev->pdev->dev, stq->mem_size,
+		dma_free_coherent(&sdev->pdev->dev, size,
 				  stq->descs[i] - stq->addr_offset[i],
 				  stq->paddr[i] - stq->addr_offset[i]);
 	}
-- 
2.43.0

