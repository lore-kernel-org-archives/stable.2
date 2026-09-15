Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54230C345
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434140; cv=none; b=PH2xfHaWvpNobMfnVDtmHAHpPRdi3D8+/jaNeVDyfqowNgDKGePsvsXv9vJqnkIagZXOh2KkoeULeySf49tPYtUixBn9XgsSLpMgvnitCQc7UWTSZpOahT71jpF4bk/0NsSl6K6c+Ww5y66Qk12k0ZjeHmEURSNBD79Lr6+fKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434140; c=relaxed/simple;
	bh=cEPjvYmUpZzkbb1qaVYv5rKfnVTnkZ4bUmEcd21UiGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYIcNZup2OHWNP9f9eP19BGApzEbUfQ43/IiG6RzbOl1npyotZXMRjaanG3WTb4lWYFSdiLz/DTXzWPWUPqVRMXQHNeo5Mn8HGPDnCkJ1Dz96/89o/9SkLW1er0JordjNvEANmkqLG8Mmzz0uIkianZwQrbZNEX7CPY17vmUpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZLkJdFS; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZLkJdFS"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe208so30839026d6.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434137; x=1790038937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1LNCA2rVzMsb3MvU5q313bU41WDHWDxRU5eL4UYHU0=;
        b=UZLkJdFS4HB09Z/hZk8rXyXKv2iQoX/xLPMkxVFZyBXWvE4COR7NfOVc+Mj9pt8gzs
         gOXziTzi0GxZlWcGj0gctktmgP03ce9T8AJg7c3foimzmcgXiFfBNruIq62Yr0ExpQrN
         RJTYPeUsNghGrultFnmDnRblL8lWaf2mJxQ5SasChaDlNuBYDMU4onLw8MWrkKdz9k+m
         Qs3O0cj+AF45ZjHKD+BJ1/FWMaJtLOUIJz60rcy44FZwF4yuxkSvZ+ICY1DSxk8x61lk
         L1DnIhrVEVToUqbNJWlkLidmhfk0GfwtL0+G+9pyT+ZbDZt3Qn72JNfTo4VQiuQhw35p
         z+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434137; x=1790038937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1LNCA2rVzMsb3MvU5q313bU41WDHWDxRU5eL4UYHU0=;
        b=jIQBp5vcyNmyVi0ba5ATdHZa4McILKXcYwQp3BvhwGljOTrpLGF0oFua19N4cR+g1J
         4+KMHcZkCAj5TCRePtXS1YXCUevDSELkaH44X0QnVauDlUZrG/GDcgYqrCBzeyXSp05w
         q6K/rDeLwq+c2g7otjuc17rEk3bXAFUtuzqsQMET5H7AaN1Gn65B1ib3dm+FfoXeK8Dx
         S/odlcwX/cmk+h8syGnHG9ZAJ7CAaCgjYuVs+F0rH0XoCRbcVYvaUNEz9fdqNHqgLAKz
         J4FBINrDfQfW9CGOE6IxYRL/6p0whEcBmQ4UJ0RbNpkuVyZc3UAaQZPZLfuH7880xJd6
         QAbA==
X-Forwarded-Encrypted: i=1; AKwUvBwsYfpKcrH4eAmba9fGFLtCro9d6LDEkEi3dx88O/iYrPOQvNtSW/XsnWJrCEjYlMfh1DMlRRM=@vger.kernel.org
X-Gm-Message-State: AFuF++ksHsvj78FrccPo1v7KIAwcNbp2VA/8XEon0tR0w988LXyNWE17
	Vb0alVLdkgLf8xPHM3E0bKjTHEaBqNNawJjJWMkhUQvmutK8oMAnoOA=
X-Gm-Gg: AYBFou0TP/R59sz8ZGncq5iLR4T+q4pHHJU2kk06LyRh8Nk7IK5hsugzvJscXdgrxbb
	/yNBmFAvtK66Zh5zg0MSA4QDar+4s82j2RwniplXZRK875t9ui3KaQmrnJdILcgNi13wCtK4DkB
	6yWFXfBmBWsi1oQ2Zeqkft1tJl2Iq8NASoljxCkVSYWvpTxeOG77hatwfS6dNwJ1kBz2gtgBwHG
	0nr/0Rne1YanLIOcuJ2lHuSMqLIpz8jQi1tIqSExmD61E6Y8cevuj8KMuaA2vfTX2rs9nFBW8r0
	GEr9uWjXPaBY6zSAt57BW4FSBtqK7tzIU81j/q8OLKIVJJ1stBEOGIqa1/XvKVXZBlz0bOYJo5a
	Q4lT0cmV2rT18gMjdx5Dnsw6GwfOW1zKVL72EoA5BGjZipo4r4W6ytSa4Qa90Qq10vuuUBD09z6
	jeJ99vTZWtiRbfpabHA4YhFsB6walrln1Sw7Wrfg9wzTuQyoLDv5Gcr8bomThsadlPDkGAsDT3X
	hd5M4yCm1PntIrKfEEx6PIIk0g1Vm37t3KE1dgha1le0SyOu9PnlOSJ6eZc3G7bDMEOxzi/Tnro
	DlpY04Z5ZgJxJT0STU80Qh3WIhDFejjqu9/RkKM73SxJy9bcgzBG+1Mco1yUt0pE1QB6vA==
X-Received: by 2002:a05:6214:1942:b0:910:48eb:605c with SMTP id 6a1803df08f44-9122e676001mr87569056d6.28.1789434135881;
        Mon, 14 Sep 2026 18:02:15 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d51ffsm110574986d6.45.2026.09.14.18.02.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:02:15 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] scsi: aic79xx: Disable the PCI device on removal
Date: Mon, 14 Sep 2026 21:02:08 -0400
Message-ID: <20260915010209.53250-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ahd_linux_pci_dev_probe() enables the PCI device, but removal leaves
its enable reference outstanding. Disable it after ahd_free() has
finished shutting down the controller and releasing its resources.

The imbalance is already present in the initial Git import.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
--- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -113,6 +113,7 @@ ahd_linux_pci_dev_remove(struct pci_dev *pdev)
 	ahd_intr_enable(ahd, FALSE);
 	ahd_unlock(ahd, &s);
 	ahd_free(ahd);
+	pci_disable_device(pdev);
 }
 
 static void
