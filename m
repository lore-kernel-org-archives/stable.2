Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC1A48F018
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814386; cv=none; b=EZw3FpG+EaifwbO2acFdi0mVtYOdwBih8M97T1xZlZOy6VVHLYfgooOkHqp6xNrx40O5G5/kAyav9Mrh0PnWgBYgjQs4w4sHsxNbj09De+YwEYdb19vYLxBrv/evksx9FfK1OFgsmYU2OvD6/ZZpaFNecHp7D2Bx0e3ranr2V0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814386; c=relaxed/simple;
	bh=Op9mdkaqB5CNS94ylwnFmEPh8O+aB/lXmsYsw/4hf8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APLystnsWCLoMoHf7Xwz/qpeeCjLQYGP5NQLIfSkP5LmOn1SyTpshzmf5Ifu6O/3DkO+whkrhejusoR3rntc2mcOXX/7KZC62yxzuRxsX/MIv0k65A5xsm9NV6FmJyT+UPGuJvk2a6YfwSGaeH2vSLIXdbn2f0FPJvs12yKbPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlHLtFv7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlHLtFv7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a17baef589so15537925e9.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814383; x=1792419183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FEGgdcLnqcVqT4VDy0LsmeHP+tq7RUbfRCvfJ7zm1f4=;
        b=GlHLtFv7jxKrQRsMJLjlCynrQxeG6HHCWeaaKqrzsIvlE8frTFyGach8ZCvdOlObn7
         P48+TnIioT1Fvr0sO1jNs/6xIQN9bHAOF0KjcmUjbtHxZbzVU/DHfWK9dgpytct3+Ec7
         okHho/d/YrcgX1vUukbsZ4lE8hgEO0zkUih1UkCmmjEsBxXCHT49DEnDU9sSbeVBV7C4
         sJ7Bs+kPoCBHT2wjoUOnEACiCIrtw4XdD7VgiSXmF7Z6n9n70KVhOwNzxcC6C/VbekUN
         Dbp0mkG2mi+VmwjUtHidnHcQJGz+Hjt0h8wTvskTaRWwrtn7VCMM7NMrruwUDiU1J7Si
         7Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814383; x=1792419183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FEGgdcLnqcVqT4VDy0LsmeHP+tq7RUbfRCvfJ7zm1f4=;
        b=NLENuyuu66vF8q/ZlHJm+IjHXoFuf24OouG99fUIKSBOCmQuy9YfQRTzEKxqb6Fhtl
         A7jWCmGp3E13yD6aPBzxxaPlKlcTSA8Z0ltvlHWl4H5E+3U/37OrFm1+8mx6MPMZpE3K
         lT7tMhBlM/bYxioJbZXfuy25B7486fDa0OkrM6ieEkc+CIx71nOzlTxagA+ww6SyiQYU
         sNw6D7HzvCts5rk0KP/0CmCYlU4GZKF7MqVAFjLaus/Gb2UzrQviVeNTZDljuXc8f3CR
         VYu92ZZU/+QRyu2Hc6g47llZFQj9ZYoiuTwQj4qcwrMK57oIJDHUZdu/cnP058bmFDKf
         FNbA==
X-Forwarded-Encrypted: i=1; AKwUvBxCdsTjRd4+257qNxP1WZtomt/Mz7LfFl+wGzl5FwjdDtFthmgq5h0gnzes9WxXSgr8dJR0460=@vger.kernel.org
X-Gm-Message-State: AFq9FYKISATM9ETLd9o/PjnI+Yp18bkKVEAzkWs/0pgSkleQmoAEm8O2
	KcFOrs2y4/8BJ3BoRlL8Xyac/YpA4/qe83icyiIgMQNiSiTx5VrttRxl
X-Gm-Gg: AYBFou3iPV48u4zkWrTsiDBS68B4F/ZHg1pNiqRAvwH7nYkJ8pNPXGDhn8eDsSHlFLF
	trDHrXmhawbJ8xcJ1GPWlnYfpswiDoOft5FGjHRCynXSKn6yjnZRy+xMICud64bP9zB5FaWpxso
	t6NYJXSDd381SkPxTcC5wcTeBy/h5BgCWuzw88uLkQAwlujgxaOW7Uj0kMLQfUgQd4Mu/koU/nT
	MR78sW70mOrFp6oArRXIJInotvtpr+e3zdczGuVwF8OuaL27f+1xmGk01HrqNakCMpuOly9ZI64
	BPT9oIMvc8rD556o09wm4peY+3oimCo7EUxAZ2l+8lxq8CRoVBryT4peJaPTQCizT9MokfAsLEp
	POqFpEMuXffWgnj0l+MBWc85jWfVXaAm6jKRM4e9oSfk/F4XUh6eLJaOIpsLTwKOP6dmQmxjSbf
	9pLD6aE/wRxNIbtXoZmJE40ZuVul5KNL0ZqQXHlojZYljFmH8eBxANw9FHPca7aLweM/k14IXdy
	ihpxYF1XFKsoHnM/Zkfqip6bWrziF4=
X-Received: by 2002:a05:600c:8208:b0:4a0:1b14:d00c with SMTP id 5b1f17b1804b1-4a18e446f55mr177700555e9.3.1791814383286;
        Mon, 12 Oct 2026 07:13:03 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:13:02 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/5] nvmet: pci-epf: report transport errors in command completions
Date: Mon, 12 Oct 2026 16:12:31 +0200
Message-ID: <20261012141239.156408-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012141239.156408-1-parri.andrea@gmail.com>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PCI endpoint target fails a command itself, the host receives a
successful completion. This happens for a data length above MDTS,
malformed PRPs or SGLs, a buffer allocation failure, an SQ that is not
live, and a failed DMA of the command data. A write whose data cannot be
fetched from the host is thus reported as written, though nothing was
executed.

Each of these paths sets iod->status and calls
nvmet_pci_epf_complete_iod(), which then reloads iod->status from
iod->cqe.status. The nvmet core only fills that field when it completes
the request, which these paths never do, so it is still zero and
nvmet_pci_epf_cq_work() posts a success status to the host.

Drop the reload. Every path already sets iod->status before completion:
nvmet_pci_epf_queue_response() copies it from the request's CQE, and
the transport error paths set it themselves.

Found by code inspection. Build-tested only (x86_64, W=1): no PCI
endpoint hardware was available to run it.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/nvme/target/pci-epf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index c683450df4227..4c5fff232fb99 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1152,7 +1152,6 @@ static void nvmet_pci_epf_complete_iod(struct nvmet_pci_epf_iod *iod)
 	unsigned long flags;
 
 	/* Print an error message for failed commands, except AENs. */
-	iod->status = le16_to_cpu(iod->cqe.status) >> 1;
 	if (iod->status && iod->cmd.common.opcode != nvme_admin_async_event)
 		dev_err(iod->ctrl->dev,
 			"CQ[%d]: Command %s (0x%x) status 0x%0x\n",
-- 
2.53.0

