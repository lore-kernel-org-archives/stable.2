Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523008;
	b=Bq9ZrHtCD5AsDRerMUItDTX6gZFkoCxPSMJRL+PFqA7kVIAZf/XKoNzgWLg8WvCEHs3L
	 IGTb4NKrO50lEWDkcJtOQ/rnRVn38i7QZw4xvt3TD6lR1EueZqHInrEbWxIkjs1wVqXGP
	 swOVk/paNhIoPo9jL3lXgRj2ZPux+w3Jl15Baej/BIdg0m+fOFD+CyzzElMdWcuZHnamZ
	 regwYx62T0PSNgxMxmUP1ZFaHxK5BlyUhgjjbFY7qGa+56RI1SFxWbCAsFYv+to+DKD+6
	 9A6liPxiThpnZtx3EIuHQZEI/DRVQGKA4VibtYL6UvUyZ7i9P4YE4DwW/+2ETbmmP3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523008;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yDyp6R6XHxt49rPY0V1CwuTyDv1VXxyGmnKmgJVZ160=;
	b=4J4Dy3rrABT/6qAg/6vwsLiyigkHiuS3NBv53LO8xFzMRDJ5GT4yaC70pySflpWQJEDx
	 iOES3JaH1AkeCFSAbMsOCayU/z6uMg2wC97vWGAVsKojnLzvK+hxa4Ui1HGWksWYpV6Dz
	 3w+l/DYdovNDBK2g0HUTIfE/0BI7eekgnjoC0/jqcPz3FWhpvxQjEClbl5VWAYAMa+6A8
	 nR6xM7HTD0yDqMiiZDww2dmwpjmnyWIpFETrgGs+TOmf1SloRsa3NUSxX/dlGP6//kydw
	 UQ6a1TKi7Jr115NGUzNz0V+do7o2gEzml+sDM9Q3lOT/AbK+is6HvRHvo7GXbH78beQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65560A2607
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED65560A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso889271f8f.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523006; x=1793127806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yDyp6R6XHxt49rPY0V1CwuTyDv1VXxyGmnKmgJVZ160=;
        b=0fER4S12ZpUJkDDkNI6/3/fTBa1m2XK9On45WbQJsO+QOqc5jjpsQcwXbSDiVIBu5J
         ykxERPNzfh84NGTanl56bkFkipJnMPWkzEa28iothinvVzquZn2os3jY4oDxy3w0eP6N
         Aojo7YzD1tN3fugYoQHhOrfA3uII+HxI9OOZk5vtAAUWh9O4llzVSD8NPCbgn24gZt6f
         8SxGQ77OoNZAr32vEyzwJ8yKIpu6wZYM9z0sxaYNny8vLaIoYV8zB5AZuhCIIoPOoNkM
         845BBY7O1Hhqz3pRo7PprmeDaoKEqiDUB8h8nUVczkJb1nfzo34s/tar8QlclSg/A1JO
         qkSw==
X-Forwarded-Encrypted: i=1; AKwUvByzSr59Zfe8bIC5JA5zPQ9suMCHA0tU2nf4Qf5M5Oe9mpkBy+6Zx+WHxdAvVug2SpbtHQSENm4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7Ahn95uXrAeQI9zFFiPT7nuSS/vbwynHnQu9ruZgmKF6DSmq8
	AYlckhS82M49p4x+UJZyeYXQpuKAQwakPx/oMjUhYF5ZHU7EyTkS54sITVWn9zNrY+8=
X-Gm-Gg: AYBFou3+I76ZZAVbc3O4vs7RYT3/Hio3ek1/JHgeN/+JjX6q00csOsXLqpzu5mIFdoV
	BTD9PtRHZXQ08CNLAOMsyRfX1KYj19/1VUOH/qXb6sW/5mNBcPMV1c5DrgU2WXQW8sDgFhZswEC
	cv6ebX1bZoY4x/INRnLeHceqL4IrT0HqlbCi6msRcL2EdyhtZqtfvErtYY8emtlJlqfDEKDa17W
	Mnen/pYcQKfeTxvFMhqSRDT8t+2HjdNAjDxf8tMI8Ns6V2aUdrCbFBFnkkq3cJE+xO2PY2VPe4L
	nKuha3SROfwy9l3Ru95ocXkRRANWiZvK7thxD/sYNwoJI8XB/rX3RZtwStJYsgRn1rDl+0pkWkO
	L+rzdqsdbrHn8F23tkmfJscTUuYPHoFsVL4zBHhd7uha7+ew0BnwA9gU+NkgNlQItOPa+C163kn
	0EN/MXDltyIfNpGVQDxVOaCzNGn13ww2eyQM6n4/lL67BHkD434RSWUPtMl+AoCn4BBeI=
X-Received: by 2002:a05:6000:1865:b0:48d:f7ef:cd1d with SMTP id ffacd0b85a97d-48e07bb2cc8mr29021791f8f.9.1792523006337;
        Tue, 20 Oct 2026 12:03:26 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:a3ee:29e0:454d:c31e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm279157f8f.23.2026.10.20.12.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:03:25 -0700 (PDT)
From: Grische <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Grische <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@nokia.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: stmmac: dwmac1000: don't discard frames with only a checksum error
Date: Tue, 20 Oct 2026 21:03:17 +0200
Message-ID: <20261020190319.884375-3-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020190319.884375-1-opensource@grische.xyz>
References: <20261020190319.884375-1-opensource@grische.xyz>
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

On dwmac1000 with enhanced descriptors, the hardware sets the Error
Summary (ES) bit of the Rx descriptor not only for L2 errors but also
for an L3/L4 checksum error. enh_desc_get_rx_status() returns
discard_frame whenever ES is set, and since commit 1b746ce8b397 ("net:
stmmac: don't overwrite discard_frame status") the checksum status is
only evaluated for good frames.

Return discard_frame only for L2 errors. A frame with only a checksum
error is then reported as csum_none and reaches the stack as
CHECKSUM_NONE, so the stack verifies the checksum itself. This matches
dwmac4, whose Error Summary check does not include the checksum bits.

Also drop the per-frame pr_err in enh_desc_get_rx_status(). Once the MAC
delivers checksum-error frames, it can be triggered from the wire.

This prepares for setting DMA_CONTROL_DT, which makes the MAC deliver
checksum-error frames instead of dropping them in its Rx FIFO.

Fixes: 1b746ce8b397 ("net: stmmac: don't overwrite discard_frame status")
Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
Cc: <stable@vger.kernel.org> # 6.6.x
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Grische <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 051253601225..5c43d32a2f22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -195,9 +195,6 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 		if (unlikely(rdes0 & RDES0_OVERFLOW_ERROR))
 			x->rx_gmac_overflow++;
 
-		if (unlikely(rdes0 & RDES0_IPC_CSUM_ERROR))
-			pr_err("\tIPC Csum Error/Giant frame\n");
-
 		if (unlikely(rdes0 & RDES0_COLLISION))
 			x->rx_collision++;
 		if (unlikely(rdes0 & RDES0_RECEIVE_WATCHDOG))
@@ -209,7 +206,11 @@ static int enh_desc_get_rx_status(struct stmmac_extra_stats *x,
 		if (unlikely(rdes0 & RDES0_CRC_ERROR)) {
 			x->rx_crc_errors++;
 		}
-		ret = discard_frame;
+		if (rdes0 & (RDES0_DESCRIPTOR_ERROR | RDES0_OVERFLOW_ERROR |
+			     RDES0_COLLISION | RDES0_RECEIVE_WATCHDOG |
+			     RDES0_MII_ERROR | RDES0_CRC_ERROR |
+			     RDES0_LENGTH_ERROR))
+			ret = discard_frame;
 	}
 
 	/* After a payload csum error, the ES bit is set.
-- 
2.54.0

