Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017585;
	b=R5Kj1rrkYwg/u1hSfhcBr79Sne9NHXrMw4lbPHSkNqimKdKWLExl2rZGRX4CkqLHb8UG
	 3Gf27EuVeSB8hLJezDVc2od7HCyhjQJqiRTr6ekc8sh6zNavJQs5lXICrJnQem43SKydp
	 eaiJgtRRxjSqOsA9xYVsLkgft2v2doFN3nX+U/Qo4lpdlsVbCHumd/nEqDz2U2EZ9994t
	 aHwszs4AoqbG4/6iUU51YpB8eDTDxKFhHO+2hU/O2gWao9KfUaa0CHE9a3vCJXBXy6rk6
	 HvBAlO8AAvoYEmz5o8TvxKgpIG4l/5HpnD21k1Q0f1DeU7O0bvuLiT4p49wqi3UrrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mXaPzB2LTZSPLIrdOOZClzIPyJgWgWO8rm/whSLIkPM=;
	b=5EO1XN2lzELql7074GICE9pcz43uWg87m2ZPmrEBUFRVXzs8OeV9Pk8snKEj8sWsUDVs
	 NRrRgebVsMQ4U9wU4B45SGmkEz2LU/PtdeogRX/oJJyoSy0R79iSgr/G1jhOIP3OPAKOx
	 BkrqgLfM/Qs17ZEGTvCVLG7ajE6XiGJGnxNGXFntth9uvE035XKxjDiEjwEaEL3ulrkAF
	 OfPgdo4VKWPFn6hc4+PaVEXDDpNMHeTOpt0o3eOf2uQpBeQi6kKMbZPGsTWM0Xvv9+ct/
	 jAXnJVpmHw6P/c9q+IHmPAeM+oMJquBvTtQHLsJ1s5cd7K/P0LaQs46qG9f0Ya5a/0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J7RUKdBm;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8D606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54A8D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J7RUKdBm
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so878391a12.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793017585; x=1793622385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXaPzB2LTZSPLIrdOOZClzIPyJgWgWO8rm/whSLIkPM=;
        b=J7RUKdBmFWCFYf7Jm5iuhyIacJuMljP4DULL6+tfAbY8VnPD5NPIWoyJzDLqhCOK8F
         PniBYrHIfIa2L1Fl8LV7ahoG1/HQP3n8pi5GBdaqyYwFuOmJnh35QV/ZHqatgA+le6HO
         HNAulxRUnjbWO05GSaogpGkqryhZSuLSsqOYXzljsrH9vveEqXa5sSKco6lilfpvmoBw
         +F2ugaUMD9M21S6iqpDuSg4jHDaEpwwd31Elh7UOxn2KqC7k8/UAei9qMxhU52eVKsYg
         UhrZ8KtR/n3mMPgG+f74DQQi20v/K9j/xk3m5XfS0E6yz2xztPD1K6EWJldKHSIKfbsr
         kFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017585; x=1793622385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXaPzB2LTZSPLIrdOOZClzIPyJgWgWO8rm/whSLIkPM=;
        b=mD4MzH7+OjJNOd4qn7spyw7KZ7Z4Gkb6cdXEd1xAWFk2e7djLBFwxdvVfSEQ5NULm6
         fCOQ/9Mm19zs3ejV+5WXWhiTm36TsPLLWdg3qV/iqzu0/nmk+5xxOeGPnYKfPbkiJkt7
         Y8ZtSWph0ZCls/oQ/IUi1rzrtEW/LELgU1JGG5lajUC4jRO+N5UnnRxzlNeng9MjknL0
         Xb2cMfCLAblM1/exvk/dyxfeNo3ch/lQzituHI8cYCGpxtE5xPrcEWJzLZyhnPNUBkPm
         ZjDozkftTXt4sTVthvWSD3BTsXjUWWC3owNNjknyqUxgTEIUTZ5+6LPkaM7TaIMxXIAM
         hE0A==
X-Forwarded-Encrypted: i=1; AKwUvBycWOKOFalurnR1v3SxdOzQtyNrbq205ELUtTE1M879e7Gavr7oZUp9kGkF/qsNKk7JHzK8Xww=@vger.kernel.org
X-Gm-Message-State: AFq9FYJD2IE5m/CqOjNnNsviFmL4WFKvGRY47gbflXJeIVUE4fYCiatY
	VnfpO5H64JM/lodhJbSkViDzk2ex9c1V9ai+wUBlLbvUI3GE/FgloYaD
X-Gm-Gg: AYBFou2DpNAe7QG4kFgD1NSxgPayocr005R5XLXYE6r9jcdOz3zaae5LSrew8Z1geFC
	hSAxw1xnaXwvCHa3ueGYtA9lNvAUalj4reH4Rn7WY/3tn/LWnxOe6bdnwfmgcVYzFNWgdUIN8+b
	sIzxkc/pH/7C3/z2+LH5l/VQGboQyZoTPYtmHS8tQS9Xe0PriWX1b7qdn9FLGZRlWNlYMQY4csH
	laxYCAkQRAT47g1wCqXV8IZ6Rb5osg4NN3KJ2Soei8B5xkG4Hbu6Of7fBgqW4WTc95krVqoXXjs
	M3zdUnca4M83Ep3PS6vfhPVQhNeyJe3xoI1Wfc+tYShD/G4oRM3f7fAbpewm7+mYW15o9kArBaa
	6OPnj+F3ciB2SXziaLViRkMypJdGKKlgzmStKFWNox2n+A7gYsaaIm/mQP60+Fyi8Qm2t5noIgu
	7z+E7U9tzhETRZZvQGTAAtWqhjUPMzipIxLenk3N4J7JpVfJX5O7acsFAy5Dn0i006kVfJAJS8B
	q538t3KQ3iN+9hkGW3fdWM2k90NV5dl1Zk4k1lqKMaYWMDm9YR8Deqh4xgsMQtWCJqID8GtgWI=
X-Received: by 2002:a17:90b:5105:b0:3ab:752f:5f9c with SMTP id 98e67ed59e1d1-3adeafad11emr5076749a91.31.1793017584676;
        Mon, 26 Oct 2026 05:26:24 -0700 (PDT)
Received: from lgs.. ([101.76.249.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm8894148a91.2.2026.10.26.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:26:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
	support@ems-wuensche.com,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sebastian Haas <haas@ems-wuensche.com>,
	Markus Plessing <plessing@ems-wuensche.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: sja1000: ems_pci: fix UAF in channel cleanup
Date: Mon, 26 Oct 2026 20:26:15 +0800
Message-ID: <20261026122616.97845-1-lgs201920130244@gmail.com>
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

When a CAN channel is absent or register_sja1000dev() fails, the
driver frees the network device but leaves its pointer in the
card->net_dev array.

The cleanup path iterates over card->channels, which counts only
successfully registered channels, while the array is indexed by
physical channel number. This mismatch can cause the cleanup path
to access an already-freed network device and skip registered
devices at higher array indices.

Set the array entries to NULL after freeing their devices and
iterate over the entire array during cleanup. This prevents
use-after-free and ensures that all registered channels are
properly released.

This issue was found by our static analysis tool under development.

Fixes: a61a8423c71d ("can: SJA1000 driver for EMS PCI cards")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/can/sja1000/ems_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 986fc8786fac..ff680486a299 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -213,7 +213,7 @@ static void ems_pci_del_card(struct pci_dev *pdev)
 	struct net_device *dev;
 	int i = 0;
 
-	for (i = 0; i < card->channels; i++) {
+	for (i = 0; i < ARRAY_SIZE(card->net_dev); i++) {
 		dev = card->net_dev[i];
 
 		if (!dev)
@@ -399,6 +399,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 					"Registering device failed: %pe\n",
 					ERR_PTR(err));
 				free_sja1000dev(dev);
+				card->net_dev[i] = NULL;
 				goto failure_cleanup;
 			}
 
@@ -408,6 +409,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 				 i + 1, priv->reg_base, dev->irq);
 		} else {
 			free_sja1000dev(dev);
+			card->net_dev[i] = NULL;
 		}
 	}
 
-- 
2.43.0

