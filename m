Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228607;
	b=5rCRVa9EdP0WCqz/h/gAFRiali2wXuunRfZiPd+mV61iGk6/kG0MjjTTkye5ONkdsjBr
	 xPTindVMhlTCA94/g8I4buquBSsissmCrbxXck1YOVcyycTpL0r+cB2f3GwSB3I2FUQZk
	 v4llNoltDR2fOBbdRJ6lTP6MuIFwIRTwAFegX6vu3T3rTD2fuITBYogS6XC4plULLikAW
	 eccQdE/9+jn1sMFjB9SxKZDISnhw9FVY/73NCyktLe07/fj8zUOoN6N1LSMJS+EE9pCQk
	 9xqsiI0IedD1KKfo53pArihw4V4syoWc6f7ArSF/Wi5e64LuP5NzozT/DajUyaagODQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ULzCO0JjMJTSMtXSK5ToDUte4FnYbn3iov4P4pXWrOs=;
	b=tiCHXGGCpg6K68QbBZ3IraNKsmYHho3/YonCmuvB1N3FPwdclXl0oVce+/tOxIcP9+Pj
	 9DAg/Qalh6yKRP4Q7wl7RgNzzShcH6wE/oJOF4r+Aw949IJvZnNp7weM9Ga6zyJ8SbDrM
	 X3w6XAcoKSRJmS+llQ1AJRvf7t7aoQI+y7X59lXL+K1dk9hq4E3MUzLpLGmwwK/Hzrf16
	 vaWzPCNAV6/nKlV+J4Z/SZNYSR4779Uw90nkjCe3mFocoptCeladm0UV+0xKnDM2g5YjX
	 u5ntXCjAJCCuonblxoErWIZ8hL0d3Y4p8HIPjTiIBt/GbE7/TUL+annfPb6iTg+/Ogw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWSEio55;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E173606A33E
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E173606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VWSEio55
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37000e7234bso625294eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794228606; x=1794833406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULzCO0JjMJTSMtXSK5ToDUte4FnYbn3iov4P4pXWrOs=;
        b=VWSEio55nDx45swB4s1+3i/yAB+YajUhF3GaZcaZ7QhmGyeEeDwdL5vIbNGBT5YE3k
         q+1Bg4f+Jx7sm/LjeiV30LCtDJ/eTaXYYxB19uRBRdvsWkrNfcA80S8wkQ1VAAL4RdZP
         Q4LhjnwbHYDacfReX+O3dpkl3E5vQaV2yzca2A5bg61YoyXn8Yl6Y0ANaEGHUwMGUdya
         x55v81jk+GK5zZ3PJ2eaYABty7C6oCbOj7Q4LImkYG9XVLeYGr/UfynJoVvhy2w+vnRm
         U9CqDwr/2oNc1bNt1/WXslmgCBGC676tXwonBZAI7ktN5HLLstyu0AqnOvUiugk2EAS3
         Eunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228606; x=1794833406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULzCO0JjMJTSMtXSK5ToDUte4FnYbn3iov4P4pXWrOs=;
        b=JHiwyQxLU5Y71WQenzR82Y7+p9OQ6QCGJM353uphsOIV06Gg6il3WD46cAencpN1nx
         Q/Y8H06UQRq54fPwz93ld9xeXumKkjl2gAachwod141N0tlGuI25gchk9k4ExfXZq08p
         FKB+C4GxXDc0P6skkXSGaz6nhkVcNuj3eY54jiBqpO4TPb/kZCOBowrhi3ReCbvCLMR7
         ngrBHD0uk5UPJ+tNMJxNG8GTTYThaRRffNZVtysBqiQ5MWFDwa7nULSX/QvnT9f98/Da
         +aO0pKawxIgjYwwlGj7kVeAmA9IGJtmgjIuVV+NCRSOhCAKLSA0TKaOJgzpFXYXzk7Ib
         DdBQ==
X-Forwarded-Encrypted: i=1; AL+hErEY4qDEOevaJo/kPdQ5yphfMExC9A2DNUcdHo6ZodQAUhigxC235Ut/yVyNQ3wLJA10ZIQ27is=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BQQA3+IUhPKmjt0H3NQMF9RmF2uckOiGQDdV8VAzTCo3kJ/f3
	Oy1jw7XIb7YqmzLHZJr+vc/RwN+ZcMxywLB/VROKv9Xwf/4GS2LH4kpu
X-Gm-Gg: AYBFou3W9kwon9MIsEH6EK5tzeysgc3u5scD1UUiSWnAeNL5ji1FefeqogCWXahxOFH
	X52T2a932mqriRMlfk2uCfuIp6eRBCh/MfiwlMtuyS1/2rgbsLRbb+hTPDlWrJwOwTHtcZExd1w
	9/gb8YiccNNm90/sRLkWt9B1b+jzowHWTmEF8cwLur3h9KGWsWXkJH9/y1bzD64GYSiJ0ApbEVu
	114P2A7X6RH/Q8RBplwsVrynE++1ymggoKTEdyNKdpRo7vFG679PC/NUcamEII3D6pxFafnx7vg
	uTJYSIeWHZYDYFqQULdveG6ioZ8KZ/o1kkR31tiNWJG+FTZsjTLrs0Te3HA2RGDIR92dOOAXwgd
	YdvpTWswTEr8Xcx0O+j4z9pr4bpUXRuZKiF/ZebP2I5HgeyAc9U9qx0KQttiTtuoagSFKaF75+F
	MXOxCksDEkp8XuSPnp/st+nLYKMxXvSQCyqUl5c8/+YqqDXngAI8XCUAs4J3CEXXNDDZClJxPup
	GnvkzHqNn56PzUzmmWgHEueCBYB4uWafX2ARrp7t63xRjZ/yxYswzzG7nR2G3tomj/d1IlXBQlz
	wXkLFsv5WGuvKvFzBrsxBnhyY5qd0eESu8m74Vd5lGpQetGh
X-Received: by 2002:a05:7300:a223:b0:36a:5042:85b1 with SMTP id 5a478bee46e88-3725302be58mr7671219eec.2.1794228605882;
        Mon, 09 Nov 2026 04:50:05 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f444csm20376602eec.19.2026.11.09.04.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:50:05 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Lennart Franzen <lennart@lfdomain.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH net] net: adin1110: flush rx_mode_work on stop to avoid use-after-free
Date: Mon,  9 Nov 2026 21:49:53 +0900
Message-ID: <20261109124953.1604903-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

adin1110_set_rx_mode() defers the hardware filter update to rx_mode_work
(adin1110_rx_mode_work), which dereferences the port private data via
container_of(). adin1110_net_stop() flushes tx_work but not rx_mode_work,
and nothing else ever cancels it.

The netdevs are registered with devm_register_netdev(), so on unbind the
port_priv (netdev_priv) memory is freed by devres. A rx-mode update
queued shortly before the interface goes down can therefore still be
pending after the device is freed, and adin1110_rx_mode_work() then runs
against freed memory (use-after-free).

Flush rx_mode_work in adin1110_net_stop(), next to the existing tx_work
flush, so both deferred works are drained before the device can be torn
down. adin1110_rx_mode_work() does not re-queue itself.

Found by static analysis and code review; not tested on real hardware
(needs an ADIN1110/ADIN2111 SPI Ethernet device).

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/ethernet/adi/adin1110.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 53fac3d..788cf4d 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -956,6 +956,7 @@ static int adin1110_net_stop(struct net_device *net_dev)
 
 	netif_stop_queue(port_priv->netdev);
 	flush_work(&port_priv->tx_work);
+	flush_work(&port_priv->rx_mode_work);
 	phy_stop(port_priv->phydev);
 
 	return 0;
-- 
2.43.0

