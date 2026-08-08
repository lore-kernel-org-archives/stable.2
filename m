Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D94B04B7
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786167196; cv=none; b=HZr84KkqSlJo9DThx6Oj4j76hyP5exbqFP4pm57uFhpaT3aqZKosTfVm6in2EK7v36ASQpnwuf0ps3ToSyrutyRAbFb4rzOx4JIgrMvWMN/OKalq1b0LWvbj14+vAodKJ+ziqJE8cwRb826o5aCHVe8nNQWWnlBokv2RnNi1fXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786167196; c=relaxed/simple;
	bh=f+PKGIJQf4ftrFEY6rgBleDvCwFwCbZ1sRMyIDjxU8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROj+F7nKYTnEFkgC4XlPvg2P79iHVblSgm5VRXNXXUFlA8I0zUzJBBS1qQMuMLVEprmx0dsTy0iH9M9gco2dfo6MsQJGeP++7gubqk8BQg4a4bh+d1RzXBqX2c0ZlHLo6Q7LNh7cfCpuMdxrTYWNyuh2BoeaAyk8LkplfYvISGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moCUv/Vu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moCUv/Vu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so217800a91.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 22:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786167195; x=1786771995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFroGAPZp4ej2DXNEJ/q4PSHjxNJnm1z9YjC9aaC1bA=;
        b=moCUv/VuNa0roKLyGPgZ8RSunSnUUHis+uZXP9InriulBG2q3ODuYJlpWpKaY/bTqo
         pqbFphIjLHEB37LRClrRwdDWnbbkIykQXbRODu/FPeOJbqTlUGfyyxevMrHO/ItiyPd4
         +fkOtCvNms+E/FmP+IsrNq6AHy+rdK0fxnxEYQdCevsS6W/fc6TuJjJP8vpxDF5nFaGR
         /Jgx36wpBl0Rbo4/fr79+Wh3Z6NXgn4nFk1aHCYc4prpef6gA3D1K6RBp+ZXbXGpyHBD
         Nmy18NURe+4TfxCP20hrSSXy/I1BEtT86rtjyf/+F7/Ef3MKzV7Me7RX8uY477PPLpH4
         VULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786167195; x=1786771995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFroGAPZp4ej2DXNEJ/q4PSHjxNJnm1z9YjC9aaC1bA=;
        b=bPGF6/nJStnFjLYStFpcpPPRYUiP17Q9kmDPUUMsNq4LNdrs+cMQMEJBhu76i6U9gt
         z3AnlkcipXZOwXGATBKrnuoEChuZqvrDnBROxHSg6TRPla0+LyieJdLspn+hH9+H5Gpw
         BijCKgiNmuSpXfscURv/lj7+mEk+382GLrPv/BJg39Q1w3Z/0J93th4aH7coy6966nKW
         pygWshyuLyjkiCKsnZU0mXeOhlPRAlXXkfB5GFp+arVrYlZdL4ynAJ/6O8y+7gyC+G7d
         GgVFUI/oRoAQHEy0fTDJk0BifoIHWTPBmLQ0q6evn8Iaz8qu4hydWVrUIQpt5PgC+URr
         eG2w==
X-Forwarded-Encrypted: i=1; AHgh+Ro3s4er7yfXUGTpUXQ/w5f7bwDAqg3A5Rrg8esinLKHTgSuxxBFCnYXGkKpqkLBdOE7IDSSbks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVBHLAqyNQ0Dbo2jTdSV2Xd4ltBOsccXv9BFbwcHXnTiASo/u
	yuPS2HdBPNade3K/eTxhnoaE+gt/A6H0PZFT1IYQgtSLZxkaimTqZGJZ
X-Gm-Gg: AR+sD10SvMuwgxA955Jtlng/xqkCmQ2jWrBUif/NDXtrcGdZLh29Jg5Mw1Ny2FDBRRH
	LRUYeBqK2Ec0eo99hnZHl0IIftP4o7SA+WjrPxas3p/kC7vknMeh/Hv5PCSiLL5uYnKbghltlrd
	vc4KMquyWfRAy9VuH6cuck0Tvpp/e8T9gX+Y60o3YohiKIMtQ9CeIY6INQnOHmJ2NxhX+14IGXM
	2blWz97GQubqncLuV1Uqw/jf/fYkWKOEPwQeZ8xAFs8/zixdKSp6bPdgf5puIjDxzMVwEqERHOr
	tRPBKOWPdelHqcWvR2yuOQIRmKoIDHcFC0yisSa2AfoHOSNCVKjj3klRdew2IHNB204Cud+5+Yq
	xaglTbVVH6owCyezL9HHN2s2xcBqBe1Y1vSJtwsRCc2sXJCUH9pqcE+GFE4bIAP3BV1nymY/CA9
	CvKIK1K/TQ96owS/ka5kiw8IDTzbPiIdtlFHYa2WFLy5I=
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-3903c5932femr29991164a91.13.1786167194908;
        Fri, 07 Aug 2026 22:33:14 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95794sm4856341a91.7.2026.08.07.22.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 22:33:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_intel: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 13:30:57 +0800
Message-ID: <20260808053057.2566366-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_set_power() calls pm_runtime_use_autosuspend() when powering on
the device, but the power-off path does not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before disabling
runtime PM.

This issue was found by manual code inspection.

Fixes: 74cdad37cd24 ("Bluetooth: hci_intel: Add runtime PM support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index c31105b91e47..1919547ff2a1 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -345,6 +345,7 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 			devm_free_irq(&idev->pdev->dev, idev->irq, idev);
 			device_wakeup_disable(&idev->pdev->dev);
 
+			pm_runtime_dont_use_autosuspend(&idev->pdev->dev);
 			pm_runtime_disable(&idev->pdev->dev);
 		}
 	}
-- 
2.43.0

