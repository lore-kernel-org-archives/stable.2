Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A046EF69
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462982; cv=none; b=pnuVjZZiOcfk+lXfCaez+txeaDPIeakUCkzANrlFQK2Gh4aTkkck5LmOpSSYpmPCom/EHlLbGvsHjAlG77UKPU5DIh0HDs1yW6EdwCWhePh9732oHhinHNGSG2lKyUwN4E8k6MOupShsaNn3BPt2Lh76fKYThxFXkKMKVo/MsdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462982; c=relaxed/simple;
	bh=I1E5aCaEBVe8ChMV1fF1cL0PZhqlKxPCI5YYxzTLLHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dx4YceN3Ww0cK8sdsBWrdcB71KX549NmhZWj0K00+X/U2isvPJ4iMS7/wEN2ac4VxhW7FFRQDAiNz0gUnVRDR9T0HiX/3HOYtgshI6uApJMA0ww+/6/o42Ybkr5i269jrdNBuosTW59q1M2wvuadsAFAdkCcilHkXxIAEGG2W4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxs0A2e6; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxs0A2e6"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbfso7542866b.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462979; x=1790067779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLWSmlyXJzRPOS1GeQ3EyJF1epHoFNqr/jbcGqxOmCY=;
        b=cxs0A2e6v1ibZcAaQAnCXppZFBX3CV9HA3x50ukFhPhdPtVVjeF7gWgnlBkORvB1pG
         Rj7dGj19s8jvW2jGAeg/0CG0kwqXbtO95nvg3bOxoC4FwZ3+3xnfZlgMcnq0XH9tdv9X
         OldPSR2SUQIW7Hi/AzLb4qkrARZ9867HdusBLTa/3WuuutzumHgA4mQepD0kJsSAIwS0
         Nxi7C1j9qhcKK3ChMeNKRZw00Ww5GknXFmrdFg0GyYJeXfsLMZwpbsFWfVKPbSJo3OgZ
         dc6C7FljpV1Q7TF12I+LHWrerLWMqqTt8nsmbnF3b6rlmGU4kxKavopuxUimNcgDCF8N
         yfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462979; x=1790067779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLWSmlyXJzRPOS1GeQ3EyJF1epHoFNqr/jbcGqxOmCY=;
        b=SNUOm7QtdArlHSNMnWtsgBSPxubLLAMkQfPlpbpLXkp10D2Pxrr/5vzaJwKV1rZynu
         K247pBJEYgohhqEXETQxSY5LbtPp/+K7j0hEY5Z7kspnYg03WTGGN2fd0YQmrwJAtVJO
         +k7xB1vpdG6PkjiXiNl5VIQ3BCXatS2EmSjQvPBKkH3eL5jUIA8+RbrbeRPK4zgubnFm
         x8v5IBLfTPvcMUe4ZoeBSQiHSGCsOQM1Vo1gXsQKRWu7dZrsSZza++NDHhHfDovwcBIK
         7iEBsY+I8qGpCYCjWGzwBCLgW+X9PQFNOQsYuvswqF5GqkHlEMdBsE7kQ4gPIivjGntl
         /OQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcCbdqHDHXi76JK92hgG9T92WzlUiZoc+OVNxR30/GIw7u6+ZRVn95kaCddipYO5yvAcPZCRg=@vger.kernel.org
X-Gm-Message-State: AFuF++l4I+J+Zzp+Da3Ym5DaT4AcwwdcPMq2DlaLxVq4Ue9CcL0aw95x
	imcQqn9fd3Q8pPUomitjnz3sckqcgeckDONXRBSz/h3cEaqUefnS+R+G
X-Gm-Gg: AYBFou3CVdc+kgL8pP1ksIM13Y/M19pA5lT8Kv37+uJl7/UPa2vH4yPmkqvMkdWIXOa
	iZgXanl+AYW+VKtZAvmCiwkB+uVtvb8LMoT+p71HQ875Wr7Uf+GM0+c65cT+Au9sB3SPAaglTw3
	nlVL7bkKKPEv4rc67l7VjPqKJMlXS1M79psNcdG5AFdhxLBaJ9E72o80DlyVoNcBTpjZT38vK9x
	+oAvj79MUz7tDtAOMFiV+bXllaEi2wgB6VDjlMmN+XtF9ofOxerVw8FnDf27GNp08kcoMN03b3g
	khBV+caULPjbouTnBvU40OWR36s3sOQx48p4tLUL1c8IaE107xSkQt8viOmPNOdi1BVyZkjDBvh
	n1JL6HDRt8axFACzaruNxGS4poGgwsTmpq5qnjKifybKSwu7qeBcTBNGh/OHerok5zxEKj99hui
	R4FuxoQPxUNkQrO4V9vpmbBK+JTuSIUBSoOAfRaTEWZnOqWlmRLQruuMvX6tH2O2Rq8DZNEswhV
	hIHcFtakqowDcqEvIvIOK5zUegZjyarplOcPqCxjOA36we8XwlyGEVZ1LwNCoEZIxCK77tXB6lY
	sFJxNWno7ZWPHBTn034aARlEFU288+aKrTX7+1qxzK230ntVWXlfsZ+Tk/6/6Vt3cMQgSQHur7K
	ROQBmJkkzpjLWLM0+/74ZCDOZcLvwRp6l8XkmiiVnl/AMCBtzFR9bDqmvqLjAkZifXnSzCeePqE
	obklfHY9RN7e3bSD9V47391Fzn1YwAH4aKgFOR/9/akV2HX67n/E6wBODAzxZn3Bak9SU4Xp8n7
	xrvmSM4Rjg=
X-Received: by 2002:a17:907:9407:b0:c29:4634:5c99 with SMTP id a640c23a62f3a-c29d771747dmr18032566b.4.1789462978527;
        Tue, 15 Sep 2026 02:02:58 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (88.71.12.34.bc.googleusercontent.com. [34.12.71.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4cf01sm546369266b.1.2026.09.15.02.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:02:57 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 5/6] usb: mtu3: add missing pm_runtime_dont_use_autosuspend() calls
Date: Tue, 15 Sep 2026 09:02:22 +0000
Message-ID: <20260915090223.1346-6-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915090223.1346-1-joshua.crofts1@gmail.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comm_init_err label in mtu3_probe() and mtu3_remove() both call
pm_runtime_disable() on error or device teardown, but don't call
pm_runtime_dont_use_autosuspend(), causing resource leaks.

Add the missing pm_runtime_dont_use_autosuspend().

Found using Coccinelle.

Fixes: df2069acb005 ("usb: Add MediaTek USB3 DRD driver")
Fixes: fa6f59e28c61 ("usb: mtu3: support runtime PM for host mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index b4f4c776adb9..ce64c36a98f7 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -445,6 +445,7 @@ static int mtu3_probe(struct platform_device *pdev)
 comm_init_err:
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	ssusb_debugfs_remove_root(ssusb);
 
 	return ret;
@@ -483,6 +484,7 @@ static void mtu3_remove(struct platform_device *pdev)
 	ssusb_rscs_exit(ssusb);
 	ssusb_debugfs_remove_root(ssusb);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 }
-- 
2.47.3

