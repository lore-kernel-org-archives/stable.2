Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746DA2F5495
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599115; cv=none; b=MKO41AcjZ2/vTs72/jFmpHyGvu4AB+yZGG+QDy1iQ+OmB5Dk7Z1ng/Wj0jfvZw70lHv9C3yL182cH7axWQYUq+Kl2MuvYfcRIkJpUq1Omr9enU4qT/2eaZkMDz6x/nYrcHW1ijYyREocSgfEVMocwwjX2cTI01iRCsgNcH1BG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599115; c=relaxed/simple;
	bh=eGWh/UwqM5JjiDpOuyETKfrpirh9r6j0dXiN+aB0t5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY+RyZiH1NyvNI4Bml6Qni61jT9LAGNCkVPf1mPlqqxq3NJ9LTIyHPOELDqPNZlCCS0vYWLYsKQP+YD8ucLjiDJPpJm50lOKJgUiVGp0R/bdgZLhd5zRF429/OUdtsmxzRDcjkPjHiq+h/UUYdT3JAGNSUW0/p+yzfbDcC+LduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1/oRNTo; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1/oRNTo"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae1f2cedfso3773954a12.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790599112; x=1791203912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D+buAjiyG4ncBlcUW+2BpEu2Hb7PWv2fVmuPggXs8iY=;
        b=Q1/oRNToeLjB/9+ZiUDBqmLg4/4RpqYLTtQ3dtXFDHve+P2i6Be+Cjdnjop5o4S2aO
         tLpsTT23t3hhZ3IIfs5jKsgJy/p00J9L2yu9AMlm2X64pOa7t42qP2MhjqCxtK3DlIBk
         6jIqrg9l1JxC1X+HDtcI6ZEum0K98OWiYvMtZ+7XVBqSwl08uYZmdpYdnUF5+JeJswQC
         I7ejwGVG2om/2wfhDq7zxe1F0AJE6E3Ud65hGwPCt4hbpZFdjASSSksBiOqWAeC7P27s
         FYRWN/BzrRf+owoBRsmpu5H75+UUa63nNCr67uvPvJDE42b473gAw5Vd1gECetw00LjV
         oFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599112; x=1791203912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+buAjiyG4ncBlcUW+2BpEu2Hb7PWv2fVmuPggXs8iY=;
        b=0+w5hHb4K+DO8+iTkmQFp8YRUEY2sXfveK2W6upV+7yz/CJxd8KjXv/gPikXAe0EwI
         Le6SFNbATYNF79FUwfkB2pHktIBtz3fytJA5HGdWXs/R73uFqDRD3Kx0sJmvSveAojHE
         XFyLaHFqiTO1UM0dRShweOeClHL6ZjotVgCjOlnY8BGgpF7RM4ikgi8uM3NcOfeKJ92L
         H2XyDBP8w8Ju1Vchr0YCCqi2iNyicOGUpuwyIZcgrsgBCgxDOYYvPdotYveZLKITTTlb
         DgbZtmQQJyarhKyy6YdLItOKPFWBtxMrUI0zG1sYi2/T+qVQ/bjQ5mhfNQJ9fWh9Pu6f
         wOqg==
X-Forwarded-Encrypted: i=1; AKwUvBwuBhiZSL236R6lDQTwq3Yu/Yjuis1s8YEuOZZhQirJrSEQPGODJWs5zyBIuKIzg9NdmfxNhGk=@vger.kernel.org
X-Gm-Message-State: AFuF++mlLbm8FgmEfvM0YfjF9vg54M9/pG9e30VIS192EWRMRru3HhnX
	XfMfS6I6fgMz6ufg7cZHy3EV3L+5d5hoFhwsF2BR+5yX6KKz1FnjZc/A
X-Gm-Gg: AYBFou1mw8+SjQZPfvOpdLFMEUNJySCmxCbGq7EZvFhbFD6vDvAR8mB9PJDTuEYuiYt
	S3Sxld9BeSkcP7mvLpmwa0whQTTxBLK12i5BS82UAGmNWhPbcBVF/ZGYhR3XB5dwMTUsc1G/Tst
	mI/B4pT2XvUDsHrPnfAB6/2oN7bKQdpB00LBZcRYRzFmaDaLjp0BYHZWKmrS1Wss6VeNE8WUPG0
	0POFOL6NYl1jBD3Gq2PAYbu2b6jUU3umfC1QmwSGFaRMriSofGEChhN3jrs0RM1FDtxop7yr5cQ
	10M5qsAehHtnsR978O5GOejS7DNW3Biag8RVy3IlwUGbf5krJwOo7hipIIF203tJrmm7Jhp34TD
	GLYLAsXgWT+cNzNfdZBmUPoVBi2BqXDxmzUl2JvMI4BVd7INrOU1Jc/sNdBiOF2o/0/gSslsQOO
	chKh8LvBDc66f59US1pmc2HpK/Yq+x3oL3vuYMnRKx974g2+oksEoZEYt10VLlCrvf9JOfDNC/8
	IbuRAx1lI2SeMm8lA==
X-Received: by 2002:a17:907:97c3:b0:c25:9102:ed with SMTP id a640c23a62f3a-c2ac2311b07mr1040138666b.5.1790599111445;
        Mon, 28 Sep 2026 05:38:31 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dd69d4f65sm161462966b.22.2026.09.28.05.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:38:30 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v5] net: e1000: fix warning in iounmap on probe failure
Date: Mon, 28 Sep 2026 15:38:13 +0300
Message-ID: <20260928123814.2605-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In e1000_probe(), the error unwinding path at err_sw_init unconditionally
calls iounmap(hw->ce4100_gbe_mdio_base_virt). On non-CE4100 hardware,
hw->ce4100_gbe_mdio_base_virt remains NULL.
Passing NULL to iounmap() triggers a WARN_ON_ONCE on x86 architectures.
Furthermore, on CE4100 hardware, if probe fails before or during
MDIO mapping, ce4100_gbe_mdio_base_virt is also NULL.

Fix this by adding a NULL pointer check before calling iounmap() on
hw->ce4100_gbe_mdio_base_virt. iounmap(hw->hw_addr) remains unconditional
because every code path reaching err_sw_init occurs after hw->hw_addr has
been successfully mapped.

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b
Fixes: 13acde8fffc0 ("e1000: cleanup CE4100 MDIO registers access")
Cc: stable@vger.kernel.org
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
v5:
  - Updated commit message and changelog to accurately describe the NULL pointer
    check implemented in the diff.
  - Fixed subject string in the Fixes: tag to match commit 13acde8fffc0.
v4:
  - Actually include the code changes (v3 was sent un-staged by mistake)
v3:
  - Switched from pointer null-checks to checking hw->mac_type == e1000_ce4100
  - Removed redundant check for hw->hw_addr since it cannot be NULL here
  - Added missing Cc: stable tag and Closes tag
v2:
  - Expanded commit message to answer reviewer questions (reproduction details)
  - Added appropriate Fixes tags

 drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..d7e279b739b8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
-- 
2.47.3

