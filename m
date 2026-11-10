Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284948;
	b=qIuKcgpi91PmSp8/57J7R8v/SxrvcFtM9/XVkY7sTNHFjeLK0iBmAvMdOZF1lnC/uKyy
	 +IgzSkZmC3eG+HRXwftEq3sO+2H0RjiehxxHXKNDg6yli/4/hXU2dMw7A8+niZlLLNxko
	 M0Q6XAbHWQK7kfbW+4H5DD3Ckd6D5v2WeGvYmAgmtbXWfjKEw3pEbrOx+3jcWWkPRkYIA
	 J0GXEF0Td4emDHax+FwxIOvlRx571MBy7ayDaz6oyQFMg2neHDLXTGdg/5etrgI9PlyNA
	 pz9v9Uc0mOHt5OWdqyyrOOLTySvHgPy5jFlzKP94LBf02HMhG1muZgw+ryWwn0zLZSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PqMa10GWujoLZY5ARFf5ggCfIRSXU59hjyLHYjCoHzs=;
	b=Mxp89MY9GIhPMKU9HHDTjWXZ45fc+QC9b9D1qPuQnc5PwwKxklOw0DAqKp+GqRQ1xYH1
	 FoIKtc9Gp4GzOA30lCBkDKISkGO/sr+LQ4Cs3Y7H/3XtvgS/b81CIX9f3yWprDGrSLYla
	 /7154XBmKSYFYIhDgQe9ClPtJ1h0Tn2rzAhsCleZsrny4LGeCU+LrXInf2ikMlQ7Tc7Pl
	 MFXtNcuFNz+nee0n2czut9lwqdiRwanoFmPvD1GQPrDvbUKi0gk5LeAQ3jolJ6z1lqcfy
	 qB+iHySJ6jCRk+PfHT59BXdwR1WEjXyLkIzWrBsrMs+an5VPuxFsLUmKmI/TgLDPz2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QrvFQpiq;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C6606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB4C6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QrvFQpiq
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5361e313e63so14939541cf.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284946; x=1794889746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PqMa10GWujoLZY5ARFf5ggCfIRSXU59hjyLHYjCoHzs=;
        b=QrvFQpiqQvmj+9/Nm3VJyN6X5xyfcId/jmKNHZdY0e0FU3aMxBm4BL/M9o01QeWsCQ
         koc7cCHYMlf73nRQkFxDKO32QoPULOSIjtBB4M78esWbcpLnr3LYactRLbs/vBHsjqk1
         zxHFmadM7TwhntDZbAVIpKoCUG3cCwgZ5ckFAoBx44dr5+YBPk50jfpAOuJ6q7iy40Kx
         E94s2zR/xHuxQhZDhhi4hZfZBrjmM1RMo/TYc+tabXSmCT1mzxyz4cqxWaTAek2KjrbF
         TIZkJeTXuWBhUAWv0DcIT2AKqT3JTYbAWmoFrUl2K8ERZ2Iy8mr31MUhxCQFMpB9ZRwR
         xeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284946; x=1794889746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PqMa10GWujoLZY5ARFf5ggCfIRSXU59hjyLHYjCoHzs=;
        b=bhOSmlubz03RTzWpv5NpUk9QXMPzD15GwnHeExGcheNO/g1GqWDdPdFQxYJ8bIGxKB
         APCdFP/dB/FdJo+tWIICRXGQz2fgNLyXkj3cRpsCHbOp9QVZvO8TtetG3kyXnpiq0N5Z
         /j0ppFclzQDHekwMEWjZKLKwNlZo9nEC0bAM+iUKMSjxwLfEGaAZgtN+r0miZSsc5dhp
         twLqQ64nFXG1092aRCkarITGnTkOh9/bz2YfatHLsgox5m6NAMSju1FWsFCSWm4vh/Z5
         R2tfPyLh7WnCXAWUk++mEtdb+HiBQgH1p1qzWgjG2yalFBLxT0CNjSjgGxV0ibeo9oy1
         x8ow==
X-Forwarded-Encrypted: i=1; AL+hErFU0zQfN5pcc90ARqVtNGs2QPKCPRRHK4VgkIzw1pK/t2yYpB+NusaVp4JGgQaXb8lq39iLCNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/z4lUdooMol3+NxM+4WJz3AumRX6Zs1kjmfTRXrkktOZHCOuhi
	hagOE7HqN6YKIxBn2XRnC7WW/I3Y38J5bIUUtHhKggd0kScfamwBIg1NuSR0
X-Gm-Gg: AYBFou1715Q1Gou0DTSUe1/I57tzZkqC0b6783KXD2mnMEX9QY6VUc9UihEG9i0ndA/
	9hGez2Ruvu5R815AYYO6nufkZJa2GfLeD0L2wzfOwe5gpqXlP8n6yFNXTyaeUyVH30EPYm2MFGZ
	zmXAWvQh+AyL+UMgkYNwTawLHBFPPJBHcoYLRqpg8WgvbiUMUHF97n8mpb7Z3Oe6c7nRdSvfhMc
	hvaxarNYL+S40d3FGjzsUCne+7Q6bWLbl/OtumWEP4d7YAMJNok4vX6ZPjTstHPtOyDhms/721y
	oGVeauKh1HMpbHmvNVoaMa9aZeaysAqhKbsBpM58DzqXnVXRD0pWIrwnjNRPH7iGiA+TP1vTPqf
	Z8foVKu/MeH8j1WcR0TLlRxyHM4wKw5EsJIicy4jJXfaRcv8tBr8YGtThlNKHXCAQ2AkLxJq+DU
	9DC09dP1/xI/7H3H3nKIUmhE8rbWjfGkTcpbu/uetIzNGMfp9UDc/gQn1PpMwWHG4ih1joan5XR
	0rr1xfOoMOkwA/DvNJAzxrkWwQ4woaDgoFV3vDs1wvYeI2npafI6ox44KoMJTsEsOctZKt3FNWH
	NkyA3Ix1kme3SUrxMGKVlV4BTCnk6bBWLf06QnhrTmKaR7OPzeeUTH3mzmkrR7I3BTizZ5H+ghL
	zKJnKQl5ZcVQIB/ShvG0pRwItkkQ4xHuM7fuig5bdnxpPWKJ5/uuiiF2G4tJ6Z6SP
X-Received: by 2002:a05:622a:1787:b0:537:dea7:adb1 with SMTP id d75a77b69052e-55524e01138mr24744181cf.4.1794284945612;
        Mon, 09 Nov 2026 20:29:05 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm14190091cf.16.2026.11.09.20.29.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:29:04 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: 8139too: cancel the thread work after unregister_netdev()
Date: Mon,  9 Nov 2026 23:29:03 -0500
Message-ID: <20261110042903.55991-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

rtl8139_remove_one() cancels tp->thread before unregister_netdev().
rtl8139_open() or the TX watchdog can queue it again before the device
is closed, leaving work pending when __rtl8139_cleanup_dev() frees
the netdev and its embedded work.

Move the cancel after unregister_netdev(), which closes the device
and stops the watchdog. The work then sees the device is down and
does not re-arm itself. Synchronous cancellation in rtl8139_close()
could deadlock because it runs under RTNL, which the work also acquires.
Disabling the work before unregister_netdev() would not suffice because
rtl8139_tx_timeout() reinitializes it.

Found by a static analysis tool under development.

Fixes: 83cbb4d25771 ("8139too: RTNL and flush_scheduled_work deadlock")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 drivers/net/ethernet/realtek/8139too.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 8241bcf76664..efcf46fd9842 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -1103,10 +1103,10 @@ static void rtl8139_remove_one(struct pci_dev *pdev)
 
 	assert (dev != NULL);
 
-	cancel_delayed_work_sync(&tp->thread);
-
 	unregister_netdev (dev);
 
+	cancel_delayed_work_sync(&tp->thread);
+
 	__rtl8139_cleanup_dev (dev);
 	pci_disable_device (pdev);
 }

base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
-- 
2.43.0

