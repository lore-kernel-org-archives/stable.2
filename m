Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539413E0234
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139393; cv=none; b=fR2STqCNuqS0SN1hwcxFXRsDgjlKmVRqLtANPuGpkgf/BtZDb9LUdQP64Up/DKKY0nOCdVUPTRbEuTmR0hjFI5U3sw08ePxvEkV4LK2XyaAQi6MDTwxgiz0HBWlscQpDqflmtMCrbe6q6SR1Kgbog/2VWYEahKzNXyjQDEG4D64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139393; c=relaxed/simple;
	bh=ieSAsQ0y548BNMnJ472yGH+KhvpzsF/yp3+FUAQfOp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdIoIc/mV3vV5eYbaNryhN21OJLMgR85uCYWl79H/WP27lLOyBhKGI63J/SoKq291hANAJgGf3NNfwbVyW7ooWfJThtnRIdwDjP4FeqOSwQw9JqS73l8S8NoKn2EhKKPP1yd4ZNcpnOasSDAxDn+kH24T5hOSuXWrvM+Z+1yfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=DtXEeVjv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="DtXEeVjv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cea3004256so24847835ad.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1785139389; x=1785744189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Tm2X0pi/lU+RwWD3OympRfnFsE8L6GJ39TGJpdkpUg=;
        b=DtXEeVjv4SHLVVsAQtkEtR1Nd6ItsU6ZQdx+e7Oa7peABJTCTyZHl60m9CC/JyWt2k
         cxmuPrAuD2Pj2mfz8TteokK6Fjcr9IK7lC5AoJcDnnSuF86X5prPmcOdyUVAwfdIBVnv
         5rEr5nYB2t9yURYKI708kzXAtzPzCVAEDfLCttcemec0Z4VanCM5lWrIrj4wcQHwj81D
         x39cCQ+6XsSGp78Ecrcl79DV6C/mez3RVBHA4PKf0dyv/LoAV0kfMop4gayWmUb/KG+Z
         9hHsidMEa2C7dAuUKWfvvuUC+YUYjJI/98mkIhNu2K5Dv1trR7gBM8IyLAROJAHegTUg
         pNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785139389; x=1785744189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Tm2X0pi/lU+RwWD3OympRfnFsE8L6GJ39TGJpdkpUg=;
        b=RtvBmPH5WWWcqarMf/Qzxx9qDbyCLGCu+2f5GCcqABiyStzuZmYrT9iNCjW6i+15DZ
         wylEGVgg00l28YiwctNlJYu8fpEBDQDzfVn+//dw9R4bvfUZtn2blKGlPjiJaHaLMekL
         XtVadwknFjzG1Wnj9B9k/p4A1ev+l9wIi03HPioEXu2zIBTG8Vboow8wDv5DKVOD671r
         ZocwyrtYTqDBdVygWiwaITU7DGMUL5pWZGerlheGAh0GlmiUeQBy2OPN6YMxy0kWFK6C
         KlJHxrOFPIJNyzkjxDQurIc9VoxfuVlyE/JpLhXiyHNIMh94/wn5fkGs6pM9BFWKoGgi
         VLwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYaETG17U8DxI5zxs71hmL7kA8CtZj0KYqRHvzu7FvCfm78UAezhg4bgvLeNYQgbQ+ApiUvp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXOkMQE76UgqIMSqtGgCkwn3TZDHS+4iirvCTmT9ZD009IUbz
	IplnI4mMv5wUgK0p0SV0InqJh1O55fGqsfbtGV3xCqCRK6vmUGEoBW0dftlZxEkvMPk=
X-Gm-Gg: AR+sD112JMuPGN0WcV35qt8KFFijdHujwwIsEP8+oZrzrbWxcyB9rixRwsBJEDn1iEk
	boaOspGzy/677Xcn7HewwwvD9Lo9XHvq3dkuWDNwR6NGR5ZyhHtCCl+cu1nWQk4CHVvsH60p/Kj
	BOLNNPTjArIIZ5BwZ/sTEg94b3Ro9bxrFU/5TtWJrJcvwkWnU+4H8JMUaBfFk+QBiZzsW1SIWiO
	QCg0ukGPC/CbPJ1VUSi9gKr+rl+n8rp2KqtTid+HHJNZ8Wc4P4MvmOdOhCQvhsMLR915pMHzIgX
	eqnwX64i6fG9/sRUOsa6uVv2YgVDk7iEcXARUQEiOSDLNWnZvIn5fYFReDGnY21DHT9uIPxdUqo
	JkTHBMvOK434Y94HCa35AZjoauLypB09pgJXzcwOvlqULFvTyDDJbQCoEZjj9G2hF6K+x0O/5Fh
	8J+X0xo65bwmEhAwgo74d/403Wt6QZKtmLIAcLDVnn1H6ih8xYlqyXefKiihKWA+gAoxk7VbPSt
	9XyzF1U+QssXuwi6sjYDSR7utmQRgR5
X-Received: by 2002:a17:903:1846:b0:2cf:b6b5:9cce with SMTP id d9443c01a7336-2cfde89378amr69538425ad.46.1785139389264;
        Mon, 27 Jul 2026 01:03:09 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2cfde59bb13sm31072945ad.1.2026.07.27.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:03:08 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: andrew+netdev@lunn.ch
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] liquidio: Fix possible memory leak in lio_reset_queues()
Date: Mon, 27 Jul 2026 13:32:56 +0530
Message-ID: <20260727080258.86279-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated in lio_setup_glists() and setup_rx_oom_poll_fn() is
not freed in some of the error paths in lio_reset_queues().
Fix that by adding the corresponding free functions to the error paths.

Fixes: 4b6e326b2d34 ("liquidio: Per queue oom work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index c849e2c871a9..222ef0b661da 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -1242,15 +1242,20 @@ static int lio_reset_queues(struct net_device *netdev, uint32_t num_qs)
 
 		if (setup_rx_oom_poll_fn(netdev)) {
 			dev_err(&oct->pci_dev->dev, "lio_setup_rx_oom_poll_fn failed\n");
+			lio_delete_glists(lio);
 			return 1;
 		}
 
 		/* Send firmware the information about new number of queues
 		 * if the interface is a VF or a PF that is SRIOV enabled.
 		 */
-		if (oct->sriov_info.sriov_enabled || OCTEON_CN23XX_VF(oct))
-			if (lio_send_queue_count_update(netdev, num_qs))
+		if (oct->sriov_info.sriov_enabled || OCTEON_CN23XX_VF(oct)) {
+			if (lio_send_queue_count_update(netdev, num_qs)) {
+				cleanup_rx_oom_poll_fn(netdev);
+				lio_delete_glists(lio);
 				return -1;
+			}
+		}
 	}
 
 	return 0;
-- 
2.43.0

