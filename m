Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E72C11DF
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789434156; cv=none; b=Q4VK1S2wwKReZDvS+kWED13wTI7EH1WOvkiuvRjU1njiZZS5ZCHJrF1JJiexmt8KgfC799jAJdFpuYuJOe7CJ3B9kO1VCOMBwj9FUNR15rKPCTFgi2VUNqLU1fDNWSL5KUECfMIzL/IldV2n17CwCIzdx6MZW9wiBNDEOJ1o66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789434156; c=relaxed/simple;
	bh=3AjDIB7EWMAVyxipcTRH5OCK7onXDuyQbUsnnxBTwFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dESn3UDM4LtQkcXH5indTzGeCq4KzhLgEPQcLfDrpyvF/ppkbfpy3aAk7BUHpM67oATc3GkaX1GfH1fqOcoPKBph9RVGAa7u2sSMrpNCL0++mN569qib2OeJQusGDzn5+3k6UxmvkoMXtJvdQHjGD/Y7tsppN8/2msgNsVyujk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTi2vJ2g; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTi2vJ2g"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso34475936d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789434154; x=1790038954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPCy7DFPSTAzIsYv8xVVBEwv2TCCDPqTTW4KAZaR2co=;
        b=oTi2vJ2gosfgW99S4eXgzmp4t7GytrGlM0wyr4ENrAYlNNreuItA5WPuMeK0KixFbz
         RO7ZLj/dsyoGgRpUtTcuD8RgkMILKFnULh2kmCscQlSJD6mLpo896kb02a7I5Mjw54vl
         GWlx/V37WRb6z0Df/0/1sEXTZa/IpG/PxoRvBvrGWJMAZ9lKIol/9+Q+UHIzp16HNwXd
         4uN7MjP08Y7QGRbC/Ao+4q4ezb8/Qf4m52rKFtbA4GhBge3zimOVm612frSiSZt5wKva
         tdUX2oSkfZTuplDHXrCUtlOQKtUZGjL5RcTdti7G4cbboIhf4tD1EwvAB9nuQJ4jcpuR
         xd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789434154; x=1790038954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPCy7DFPSTAzIsYv8xVVBEwv2TCCDPqTTW4KAZaR2co=;
        b=FZdVEnUbeQVmcEqHfxUv7hkB//km8EAFn+0Wj71vhtzpIdLh5T0Omy0AzbU4lHU8AM
         IlBY5nfns/vNyFFfKPTs0+rVJaQVh/qwfqSn3zyx24IjVBZUXdcib3E9ahKpQs+O9Anw
         TVvz3LbN9DHYDYwXf07fskZqUTv8GUx+e3HDjg65kOpwBqlg/n7u0ywvrDV2QQpehTdP
         vqjHixBr9TgbgcRu07d2N2tEF+pxvc05AmONcsnaFIoANRJxemEuPc9TXWNxexgh2M2c
         7nRLlKTHijY+n/0V+M3Q3kYMCp+5AldHYB5GB2hK0s12OgIlQbm+l2vYpF19ho+jmtNX
         srTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmNTmfU3JGp3ajqgd592gesYGEsjRViM5LtZP1PzhrTQVPrv/IiC4c0fFj5jsRk2EA3fXUcrk=@vger.kernel.org
X-Gm-Message-State: AFuF++lSuj7oRwVNy48PiDkDfrf6O5P6A3huM3FYX1dIz4TP0IEQO8k/
	R1ZmDhb+IDiW5oYklN6CoSXkRzL3u1LdEB9gblBWsb94kWTjyPvbamo=
X-Gm-Gg: AYBFou1PM+rw+IzLfLWM7ttMI4TMQJW4uqK+fBoc60IJzhb/OYTaf1vfXy0eQMR9BrQ
	HOxSvxkJvxPq0ib0/Lr/glseS/q7Pm+nPZqtbLZglaG0Ese9KQCcFOhAiNbW3hmQdpRXKvQqAm9
	WxrNVxv4k6Cenf4pdUgBHeE/VJPf4Hs5SRy2W9jmI/zL+xNCuUmQsrPsqCGPAjt8qceRD5a88nN
	FhH1jllzhAzvw0y32AojfNqmG3KKPvh1/JjXiV799Zsz3oPSCFEpIBCH9kT+GlklLXRTXtjClLH
	jHnDWxTBvivRZ8zmn8pYx16GV+6sXcq83MkhGvxWdcIMkaIkwTQjlRX3aFLlQQVVrmzJsMljPLz
	NWxrrzNRCnxiAP04QAQXrNLfurQ/gRthaxuZInAMwdu/YERw7V3bq5fCTJguiol2CGvVjKguZ42
	v5epG0kjoHAYDuzDkQAsuWSgiwQn6i0ZC/OzOlzb0OhbyOr/vPwsvXX24jbnPmVXtQ/NRl/5Pck
	epBdqhDdovsBMN5nGQND3dLbO2A5RdDvHsnRWzaTEBjkHj1JZEjinzo5g816VQ6MX5bsDBSvnyM
	nOdX9pWZd9bZsgYYCZiI+4fioot6zBMer5mQvs5LQW3e59bya22RZD15UYOHbxy+lvGZFw==
X-Received: by 2002:ad4:5ae7:0:b0:90e:95d0:927a with SMTP id 6a1803df08f44-9122e4d4aecmr105329926d6.6.1789434149663;
        Mon, 14 Sep 2026 18:02:29 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d51ffsm110574986d6.45.2026.09.14.18.02.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:02:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] scsi: aic79xx: Disable PCI on configuration failure
Date: Mon, 14 Sep 2026 21:02:09 -0400
Message-ID: <20260915010209.53250-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915010209.53250-1-mhun512@gmail.com>
References: <20260915010209.53250-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ahd_linux_pci_dev_probe() enables the PCI device before calling
ahd_pci_config(). If configuration fails, ahd_free() releases the
controller resources but leaves the PCI enable reference outstanding.
The remove callback is not called for a failed probe.

Disable the PCI device after ahd_free() on this error path. The
imbalance already exists in the initial Git import.

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
index 5fba316..37f4395 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -189,6 +189,7 @@ ahd_linux_pci_dev_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	error = ahd_pci_config(ahd, entry);
 	if (error != 0) {
 		ahd_free(ahd);
+		pci_disable_device(pdev);
 		return (-error);
 	}
 
