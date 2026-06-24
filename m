Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB52FB97B
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272987; cv=none; b=MfNkfXV4Inh3ek2OCIHjWKOeZXxIynrhPAmFJUyiXC+SXOEu6MhQXUiFX3hLcdEtgLK6sqYNa07HU0lytCTH7K69Qy9PVCxj8ovRStdy+dTI2/1RIuODCPLgvZlUV7LzEdylDRvIIIT6Z5PWzhibrbQTv3SHWGt/8j+MVCjWZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272987; c=relaxed/simple;
	bh=HGV0X+O8+L50gEFS8A9GPsWPKShs6DF22H4HmN1F734=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DTSzfQ+5knPOUltgHlrp+HbVHZmSxFEBfMWJ9NSrCpsWdYxZfAWVZiiomRQrYrXeuZlEjSN6hLrcrmUSAywh2vfY7PBVPYb3oUru8CgXaQas5IjQr85SJYGptRqWguLJMcys+LWL9lwQucm060FoAqrM6DDwstI6XNDKccp7x7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DQf4aWX+; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DQf4aWX+"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-36b9d265355so349474a91.2
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 20:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782272985; x=1782877785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dLXwVAuePBBU9QBiISkll/5W6YI/CqhcBrATziF0IM=;
        b=hDErStaEh1ISOMQdcByl/rkm7hAxcJEozuNu70LJ+E2dvratxqC/5kBZkGFLce4jaz
         h4pZGhhuTFNx1MC9E0clP7b6qmOjXBTsFHQKCpJf38DHRpunySdhREK8SRKgk34FB4tb
         wNqv5M2dkiqPgsGxaGep2+zDPo9p6yciHDxSCAwh0cDrfXhcoeCMP4NVROj9kb8fRNKf
         oHckzynz3/KdxHO8tOFCcNjy2zWOCUnJdSKtAEpbrhnvxzeUgAcnNFqEgeFiUitJGwE1
         OEW/3nvpiLBAbfnwCavAki4SDQEXnduPyIB9g+CxEUGEf7l1d/G6r6cQEty5wnT8ASoc
         lP4A==
X-Gm-Message-State: AOJu0YwiDk7YWwcyiwuBWtXtSyWgMDABh5dNMDhaMStHxsS+OMB7nGnH
	Xf3uUw8yDiV3YJimcXgZJZqnU7zE03cA3nQDjOofmiEYGQeKAxSNKIBG71WE6ge6G9iQALcizUu
	IcnkG9YMDbI7q+qDwFWd6IopIJkMFF/IHE3cN9OqqEJ9fiolLss51WRmZbAOhJGXTp75cZ86CF2
	lyZ3dfKEnr/4v5hOW1RS1lTPO25tOZHH28PYhDpRBBOAs5WZm0O9mme1KssbomsOE/zxrMhM+Jz
	noxf8RkVQ==
X-Gm-Gg: AfdE7ckK/ihu0UlYEbNY07Y4m+3LrF0utAuicc2mynh5XqeKua0vdv0Nzhe1ZVO/DrE
	ZgITmpFV8AVgzJbOYRtTMo718uGsbgv9V1NbuKn7HdNGL5AG3MpNqS4DcPT5ufXWwXOO0Z3nvZ0
	3dy2uY+jURBjYvUpsBu+ZgTGILbqtDp/ytejgApO43yTTH925IMhA1Q7SPUFopGWfpy7HjzOnox
	OoJz0mxmIDouozIb3rH0YgyGbz2Z8Hvy+8pkncV4qUvay4TLMKQCd0BCiiMNF17+O4ZsglTp2tv
	+9tycLTV0BCaCFhWalsMaB+06Esno5QMvwo6Ubdqel0XAsR29ouCN3cMuJ3euhemIGuyu5h0VBH
	PRes7fTCcSJksbpb8FhZ9EHD7IINW2IEb25Q/x/3n4sq3W0FD3dbXPXoSZvY4JCx+0gAfuPlCFm
	rvDdoV8HZMRG/NA1rm91UCiaOogPIFMM0y+0gO4dPBtfeeAno=
X-Received: by 2002:a17:90b:5650:b0:36d:9ea4:d0b with SMTP id 98e67ed59e1d1-37de46480ffmr1609459a91.24.1782272985177;
        Tue, 23 Jun 2026 20:49:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-37de3ca30c4sm135950a91.2.2026.06.23.20.49.44
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2026 20:49:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bccca5620so801578eec.1
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 20:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782272983; x=1782877783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dLXwVAuePBBU9QBiISkll/5W6YI/CqhcBrATziF0IM=;
        b=DQf4aWX+//PS9WgrCrOK+IDYHENyncexo7O1nI2EviylGYUsKIrIM7iLFuJht7tRVW
         g3co8vpqBiA/HK7AnM+U4yf/c8iJeYLkHKUq/pNYYUBUH4Wi+OPnTlAyVCrsS9Li0HO4
         pJbbvXdivelxszYYNDsaIyI6yM8jxgjT9ovD4=
X-Received: by 2002:a05:7300:cc10:b0:30c:efc:c399 with SMTP id 5a478bee46e88-30c69404640mr1868268eec.35.1782272983332;
        Tue, 23 Jun 2026 20:49:43 -0700 (PDT)
X-Received: by 2002:a05:7300:cc10:b0:30c:efc:c399 with SMTP id 5a478bee46e88-30c69404640mr1868239eec.35.1782272982618;
        Tue, 23 Jun 2026 20:49:42 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bdffa83sm25451255eec.23.2026.06.23.20.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:49:42 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	bcm-kernel-feedback-list@broadcom.com,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	David Wang <00107082@163.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH stable 5.15] xhci: fix memory leak regression when freeing xhci vdev devices depth first
Date: Tue, 23 Jun 2026 20:49:38 -0700
Message-Id: <20260624034938.4126679-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit edcbe06453ddfde21f6aa763f7cab655f26133cc upstream

Suspend-resume cycle test revealed a memory leak in 6.17-rc3

Turns out the slot_id race fix changes accidentally ends up calling
xhci_free_virt_device() with an incorrect vdev parameter.
The vdev variable was reused for temporary purposes right before calling
xhci_free_virt_device().

Fix this by passing the correct vdev parameter.

The slot_id race fix that caused this regression was targeted for stable,
so this needs to be applied there as well.

Fixes: 2eb03376151b ("usb: xhci: Fix slot_id resource race conflict")
Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/linux-usb/20250829181354.4450-1-00107082@163.com
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Suggested-by: David Wang <00107082@163.com>
Cc: stable@vger.kernel.org
Tested-by: David Wang <00107082@163.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250902105306.877476-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index fb81e61a599d..7f75298a09d6 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -961,7 +961,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, vdev, slot_id);
+	xhci_free_virt_device(xhci, xhci->devs[slot_id], slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
-- 
2.34.1

