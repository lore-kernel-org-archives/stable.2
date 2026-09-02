Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DFC364038
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314249; cv=none; b=UuV/P0a45R74SDCdZoRMW7Pn79xzuowXUsPlI1ipn61RTO2PzDb/i4iPirSJ/3abGDj72q/Xq2o2Ko8nSAft2DMfo0XFHe+z87QUf6Auug+rzofFjsDKD6zoUB9UA0L3FqGqgZWSLJN3ASOJ48g3T8/mUSLcx6voR1qmmc+tCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314249; c=relaxed/simple;
	bh=gccopKJo6AMNY10hGDCTCtkumpeREXXBiisLLwf1er4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmkdXjpeonyaN54JAi6uGvNcR8C9wU5QonkyrY/k6QesGoijB5QMPUaDjSCR/+uV5VpuqOBpQyK16iaWVvXfKdFEemYcgO0mfCtnSurXFQ5wGhrqLjhsn+jV0xhcO+R7zQMrpY9/muLXjPhClq55D8/TlnXLEZvQ5HxqDnH9WuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=TTXXe5Xu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="TTXXe5Xu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d032846c95so5212355ad.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314241; x=1788919041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2wimfaoY+1kK1sxo3NPrBDMOhhGsT7Wm36ytAjDSTIU=;
        b=TTXXe5XuttfR+yczz59mBqblBnFMovbkhBNBNs2hUIzuscgXSpmhjGT+ulevxYL98Z
         MpDOIZf3SEURftEF98mP/Qy6Lw5steBzYsHOUV0iJD1MtYsmrrX7+eVERc8o6tMBXoIG
         T0E9GrLaFVED2X1JGEI5iMCe0sgZ/udgE6OIqYejugYS/ORNSlDav4EIl3pYwxbdy8JK
         sW+tgob18UM8zkfroNZLZieT/R+0LH2yY/iFGiMO4vrCRys6k8Gj1HPJ17Il5z0hb7Mo
         zviVK7aKWDK0htuxC0pVpd4M47+ZYWtaDGJ0Tr9xT8u1lmRpCEGWOcb8gu3iq19ayH5F
         RtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314241; x=1788919041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wimfaoY+1kK1sxo3NPrBDMOhhGsT7Wm36ytAjDSTIU=;
        b=glEcqw7dSortJ/cibIxNmSdn2p0uxi4iIVDYfiyrtTc2oyIjVejd+TQaXA3v1XAAOe
         +8BVT+pkJOd3EY3QyKx+cRjDYpHDMFj6kelNTkcI7U2XpmF48pl4fgA6UAGNvKnvb0J3
         1sOwrKZRgwPYRcXPZAb83ea33z/rrFBWlDkoD9cgCZ+2qNDJJ1xh2erXlS/eL2N7XXxw
         +slCNxHxiVh0+mjv9RplYR58y92EsfOQA38aASQF/OFBrC8s89dQRDfXAjoQtXE1xyoe
         F5v7QbFrVujhnLymy0fKuQ7cm5HMyTVQjzF4zI+XFjAzIV6WVzwz3nCCJzyJse1RvSOL
         PSKA==
X-Forwarded-Encrypted: i=1; AKwUvBxsv9T5Dyj6HUwhsno2/N61VwQMbTVbI9GkhNbiorhZ/mPE2tLwya2+vdzqnWzunwbUIDBk6VA=@vger.kernel.org
X-Gm-Message-State: AFuF++lfJzSZ3ICdnairCwoRqqzE2Vbnl8gN+lfopiOSMUD7nZiwAnfm
	qA1cqE0XQpTNSDyk8VNuIsnoLXq4tcRM8LNF1Gu+9JNZf1bQ8mX0vdxqwtVtRVNwvLk=
X-Gm-Gg: AYBFou3yqTB88dl18Sdaq4syQ1NZGadPKig81pP6TkrcgWXFH5A1NPM/zCZVc9rn3Tz
	DQ91VDleRfGHAzFAfm434I81xgbm3DDfHOhGEIC02kML4TpUexOAn6u2SnzWU8GKLXhG/hKLz2T
	uWIxtxZdcuIomBCnp/FNm6S/W4GsQMSaPXFj1A1KwnVS4tmdflxk6aZOYxV0GXwKQuGKE1oxF7o
	kuygugyOGKeXw7xA7EKhioKmdBBWog8qE2vn09TU1UFS47X1aUjzQ3dHoTQvPd6weZ8C0qry1Kj
	pp9WhAe6Ca3HkTUZAXUkTpowvGaPSktkYKqGikvLxr3VIDTznj511t9sbRbo5Erk3AuU3eP0RoF
	By5dqr0N07VhRpkoxb5Oc4MmaJ3d4Rf5RJEP3RYBD6mrW5C2Z9YShnYc7Bm2B0ldJI7mJDv7PDm
	w/Oz0dIGCx9vPsHLbNtKIjQ8ctbWSfWTuDIvtCNjt6DdRgaEZ51JqL
X-Received: by 2002:a17:902:e544:b0:2d8:d4d1:313a with SMTP id d9443c01a7336-2daec77411emr18790655ad.17.1788314241319;
        Tue, 01 Sep 2026 18:57:21 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd488d18sm5198245ad.45.2026.09.01.18.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:20 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Prashant Sreedharan <prashant@broadcom.com>,
	Eddie Wai <eddie.wai@broadcom.com>,
	Jeffrey Huang <huangjw@broadcom.com>
Cc: horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v5 5/6] bnxt_en: Propagate RX ring init failures in bnxt_init_nic()
Date: Tue,  1 Sep 2026 18:56:48 -0700
Message-ID: <20260902015652.2421609-6-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
References: <20260902015652.2421609-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_init_rx_rings() returns an error when bnxt_alloc_one_rx_ring()
fails, but bnxt_init_nic() discards that return value and calls
bnxt_init_chip(), which enables TPA.

If an allocation fails, this could leave rxr->rx_tpa[] partially zeroed
and TPA would be enabled over an array with zeroed entries. This would
lead to a zeroed DMA address being handed out if the agg_idx is
translated to a SW index at a zeroed entry.

Fix this by propagating the error out of bnxt_init_nic(). Both callers
already check its return value and unwind with bnxt_free_skbs() and
bnxt_free_mem(), which tolerate a partially initialized RX ring.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a8e5fdfcdf59..d2943de1b62a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11341,8 +11341,13 @@ static int bnxt_shutdown_nic(struct bnxt *bp, bool irq_re_init)
 
 static int bnxt_init_nic(struct bnxt *bp, bool irq_re_init)
 {
+	int rc;
+
 	bnxt_init_cp_rings(bp);
-	bnxt_init_rx_rings(bp);
+	rc = bnxt_init_rx_rings(bp);
+	if (rc)
+		return rc;
+
 	bnxt_init_tx_rings(bp);
 	bnxt_init_ring_grps(bp, irq_re_init);
 	bnxt_init_vnics(bp);
-- 
2.53.0-Meta

