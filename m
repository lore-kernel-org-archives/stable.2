Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0647ACC6;
	Wed, 26 Aug 2026 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775829; cv=none; b=Z0CgYueEqyvRLE6yKPyW3DABQj9OwTMH6GPberDo8hCEG+26kblB3ua0AOkMLmDCjogLHukWKoZQ2Bjwwej1L6sFWYEXiWr6gRcr7PreyPdjGWlw/pszT80E8rNTb0lBuqTkRY5ocuqD5FuSbLAVIWxZGxxB6005TEZB75Nq3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775829; c=relaxed/simple;
	bh=zYr4xm/hZ57XjrhWkYpqW/TwlIUd4MCyuqKjtJCS4so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hD5BCGcv7lsJiqB5l/8cvZr9ZaVU2E/BfvFBMf/epqfTj5JikkjQB5Lx78qcyI8jLU3K9ZtXIVQFU/BOJxMqDN2UeSTXmzaPonlDVVBL8FxHusX6NSatrT8qCKWTy1nSaYYCwxw6p6D3K6O+5SbwVJL4F4wZD3ziVptMNqImaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IABba8sP; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IABba8sP"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B39E4C000C69;
	Wed, 26 Aug 2026 13:15:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B39E4C000C69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1787775337;
	bh=zYr4xm/hZ57XjrhWkYpqW/TwlIUd4MCyuqKjtJCS4so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IABba8sPB9wCMLvRuFrzzJPUw/+Yl0dxMe7t4ZMYEsGHRtAd+kiB81gCuK7BMH8id
	 rR8FByLK1653yeQb9+OuQGImDAkvITQz5xY6CFMqRw4IZlsYD5ZHBEnuoStq6Oh32v
	 v7wpvSB/o1KB6BFmfFOxpUEkLx/xRF04+pWG090w=
Received: from bse-build-07.ric.broadcom.net (unknown [10.136.28.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 139EBA9A;
	Wed, 26 Aug 2026 13:15:37 -0700 (PDT)
From: Danesh Petigara <danesh.petigara@broadcom.com>
To: mmayer@broadcom.com,
	krzk@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Justin Chen <justin.chen@broadcom.com>,
	stable@vger.kernel.org,
	Danesh Petigara <danesh.petigara@broadcom.com>
Subject: [PATCH 2/2] memory: brcmstb_dpfe: Bounds check DCPU-supplied MSG_ARG_COUNT
Date: Wed, 26 Aug 2026 13:14:59 -0700
Message-ID: <20260826201500.3000125-3-danesh.petigara@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
References: <20260826201500.3000125-1-danesh.petigara@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Chen <justin.chen@broadcom.com>

A compromised or buggy DCPU coprocessor can make any user who reads
world-readable /sys/devices/.../dpfe_info|dpfe_dram trigger a kernel
stack out-of-bounds read of arbitrary extent. This bounds checks
chksum_idx against MSG_FIELD_MAX after reading the response from DCPU
message RAM.

Fixes: 5d06f53d9509 ("memory: brcmstb: dpfe: Compute checksum at __send_command() time")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Assisted-by: Gemini:gemini-3.1-pro-preview cursor
Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 66343205f585..7b02c36c7fca 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -503,6 +503,8 @@ static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
 		for (i = 0; i < MSG_FIELD_MAX; i++)
 			result[i] = readl_relaxed(regs + DCPU_MSG_RAM(i));
 		chksum_idx = result[MSG_ARG_COUNT] + MSG_ARG_COUNT + 1;
+		if (chksum_idx >= MSG_FIELD_MAX)
+			ret = -EINVAL;
 	}
 
 	/* Tell DCPU we are done */
-- 
2.54.0

