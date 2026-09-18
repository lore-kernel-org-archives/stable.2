Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF351B186
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752363; cv=none; b=HN6akHZQDM4QEiNf1W3ZqXD83P8ovJykV12C+H1tlDdq5KJeHgvXwfXnGwD1U65KcBlP5lQUt1gIQtPSBz9VP8KWNibQjTMFgtQFA7xtZpdaNG8bwAF/swdwA2xZ48zrsr39J5FiacXDgqdBWEcYv9aGMtTam2RTUBbI4lHOwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752363; c=relaxed/simple;
	bh=cZKn69nF+ltHhO2GnIWhmR8Ldl8qwapZb+XHEzvz4/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kawTl36EC1d1AixafR7242yeEkVxotzUoJ/5vjHn1LdpaOo7UcKm+ji8k3WB3O48l8JX54RDaDy7YEA0wH9lNXknuiKA1Nl3TGe8pCHhwsMDbVIPjC4A/JbqppNCMYz/L+86MTiwWP59kjJbys6t3yMqLI1/N2Xf1uPYF4hl0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA7MHShR; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA7MHShR"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so306787a12.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789752351; x=1790357151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7w41cGtnpU1fKAfJJK8XLWeOJGEaeMvKYoPj2+vL5e8=;
        b=nA7MHShREbJeQLkNa6zVyADyKV4Ml/X87W5j71Hi6xnXjmBNrME+Rd54rWgt+MADca
         UTHxfCPjAE08EAzLxYjo0R1m3VW/DBnyDP/uIKbrMz0SClqqxXHSpBQh4TUXuRCnspnd
         Fpbhix9XYFjuZ/8/1EmcTgpY4idHjxrji6Cvi6ALTlztH25j1j59u64vFu/0AQhY0wV4
         q5HZsSmGYkS8jKrytDRIBOwjQmmJashQzISHs5tP7i4KqG7mlNIlS4zNdtfTU3TYuqPT
         fR5V1itwB/0bEAUf7WvRaglINbFbskS+RRjv+FFED0SLIvBDh/72whxGvgxKfbmQx0HL
         k0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752351; x=1790357151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7w41cGtnpU1fKAfJJK8XLWeOJGEaeMvKYoPj2+vL5e8=;
        b=T1bRaoND3GXZTpso2iMgXK3PpiH0JWJKNAXQm2nT9sHO+6V+CzfVkvXalurOEoZpKP
         SklHO/H1KX6D8GAB9G2qrjGRbGREl5GcTotgnhcY+ts3BI3Id1PvZP+K3wHqKo+0fHUt
         meand9M17/WPBuqXk8Ia9Vd3SHjzd7OW4aH9iw1a2xmp29Ap/dkkbSf4+DCB7pUIPjLf
         L7gprE3KjHQBg5PD9VS+WMyWpL0JvYUWA61hROsG0+UD0hh3kbBxyqi/wsV2g+LiDUPS
         Km23l1NsBIOy/JHyHEb+4vyEBIhdwC+g4kYZWRdsqWEoGXQMrGJxd9Ep503IuJMAPoI2
         r7Pw==
X-Forwarded-Encrypted: i=1; AKwUvBy6BNKBhLUKFBIpIEP4rgU+xI6+B9+3pgma+Sg8+qV7eck5oFzwwBWxr7PHliRqchaPRCMeNws=@vger.kernel.org
X-Gm-Message-State: AFuF++mdwgBj4RLoKm+ycPzZ3DvWClzv0ScFZbOLlXpZ3ZTzNNudgp1N
	WtDE4XD8PGWjTdPTt5SwDhtLZt80gm8i4XinXBXtPsTSLV4GV45k/+5wMk659pPoWfs=
X-Gm-Gg: AYBFou27Kc0TeS78wtFWcVGuD41C5qCjjjuGrQSB0+MyjV9IW9yz3Oxutw6o1C3+aGt
	GOQI7BHiPZ77/0ztF5f/5bmAthzC3WLntqeaE3e4iM0zx/DE6x5LRtg1i4bQEBpMKHj5qkO5wt/
	GC4WBklRLmgQ2rHc+dgYeGCklumD/90atg6mR7cXdBCNFxpjDUfy5sdZDMeOfaOFDmn0xQg0E6c
	tszCKGFBTXbvRMUNNRdxud3jL/zrvsX7Ik5zBqtfmTNxXnhAMs6ni06bE5pVh/qVUcpvTd1Kz5B
	za/TW23h3Pg1hMQrYVo4Q+nF2hr9fCSwZcv6/Mwyq0rat6/Y8wnMyfQyK8cVDxt7Wkn6BUbEqqw
	M7j8/W36gUK4Py9R72DlwvFFjNPypiIoCQKtO6Psz0/FnRsuxzbqP9Mr9XKYwHSuPJuzq4+rJsb
	NwSeaC7rZuCmokNysEPjHPPMn4ymtVBpCVic7g5vWzzGkaNziQYl/fbA==
X-Received: by 2002:a17:90b:51c1:b0:39e:6c68:fd92 with SMTP id 98e67ed59e1d1-39e6c68fee8mr313201a91.39.1789752350791;
        Fri, 18 Sep 2026 10:25:50 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm395136a91.11.2026.09.18.10.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:25:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anil Ravindranath <anil_ravindranath@pmc-sierra.com>,
	James Bottomley <James.Bottomley@suse.de>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: pmcraid: decrement adapter count on remove
Date: Sat, 19 Sep 2026 01:25:41 +0800
Message-ID: <20260918172541.3599902-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmcraid_probe() increments pmcraid_adapter_count when an adapter is
being initialized. All probe failure paths decrement the count again,
but the normal remove path does not perform the corresponding cleanup.

As a result, the adapter count remains incremented after a device is
removed. Repeated bind and unbind cycles can eventually make the count
reach PMCRAID_MAX_ADAPTERS and prevent otherwise valid adapters from
being probed.

Decrement pmcraid_adapter_count in pmcraid_remove(), matching the probe
error path.

This issue was found by manual code inspection.

Fixes: 89a368104150 ("[SCSI] pmcraid: PMC-Sierra MaxRAID driver to support 6Gb/s SAS RAID controller")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/pmcraid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 942a99393204..da80f1d39ec4 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4778,6 +4778,7 @@ static void pmcraid_remove(struct pci_dev *pdev)
 	iounmap(pinstance->mapped_dma_addr);
 	pci_release_regions(pdev);
 	scsi_host_put(pinstance->host);
+	atomic_dec(&pmcraid_adapter_count);
 	pci_disable_device(pdev);
 
 	return;
-- 
2.43.0

