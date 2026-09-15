Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBA3DDAE1
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462979; cv=none; b=LiClHqewnB1banF1hOKpv5uIr8m8etQUVs3JSTvTBpMM7uyiJi8dUsHKR/DKFvdNCXVjry15H6rmDkdn+6RjbrT0ySXha4CIs4s6N9Y8JXOcnZH88VJ3VJDlPHdrvq2WTQ0Z1iQ4CnSRayz0wfNmYbwRmZcdDwHJT/zmlY+NoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462979; c=relaxed/simple;
	bh=m9YQCnZ4wuu+r3kwEyUolM5dCU8c97GRk7G81aGdFR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlcVCYXaqNSH/2L3luuXy0n0ZJ6m7rnu+b1U0b37c9uerC/ihl8PeUJp2ee++t/XLJdF6dje5sbRr6Pw2HAdccO7JgwPnMnSSmpZ8HV+M/GrrSNjUwOdAeuicjHydFJOQcaD3gCGB2jRfklR5i00X3MaOmm0TlJppx0KdFrkGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKqV/k7u; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKqV/k7u"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a56so432017966b.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462976; x=1790067776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QV6AlfXXw+r11qGovTiPwbiifuuf1ZUfq2GxVsn5iw=;
        b=kKqV/k7uJEeSyZTnhKaXCxXp7QeU2mYEu+6D7Q244jXM9CJASVLdYF1/E9yIp/eJpD
         spGig9UQYIKNYaUlTPJGzWd0qxmVvD8E6AMJ0xfLffN5+v/LD1sW35YeTiRTYsiHD1Qb
         tPFmmRBTWWSJiyyPoRIAS5/Ty2zoOwU6GqAmzoWuYT6D1emwhsnv4PO6LL5zuEgv/VDr
         +5U+emCeBfh2S1ROyHxxjeRphcEPJUVHoTc3K9s+OqGswr3f/lbGR+D8L8cT7KqyRWGi
         2n/ABsAblWdjCJsx8hQ66STSUhx628cLwRRvvbpyACzcVFa6q9R7lYb1Wluw7Yln5Z5x
         uQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462976; x=1790067776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6QV6AlfXXw+r11qGovTiPwbiifuuf1ZUfq2GxVsn5iw=;
        b=WaC7sP/CMlgb3jOllzWJpSPThE1bCFRnKLAJyrKXjFZ+aiIST530xFKgAQImq0OaC4
         FB9BUE2kVkXqSyp/oLGTmhJpmIRa8U5rRDBc8KW3UGqbr9uWB5Sga9mJVXaJkEuvbUcf
         MVdwcqbR1JNGausDjPuFwFB4GLQMa9Ckv9d7lTIkh+4+mqSWNLSbwRXX+OePe3/fPizE
         CYk3R1hiZnvDauiimiZNmna+aTwx5OZfCIq4YI4CnSxNXdUp4Sv5QZxIvMZd+iitFQmC
         dXVmstU3OgTn2lKj9MxqTxGVjztbR+Fwhdwv/sSKz71y9LpMTgLR/QbKpW/83Jwk0yuv
         9oRg==
X-Forwarded-Encrypted: i=1; AKwUvBzQVWvf2GpNelk0G1BKbxALfOCqDsXIx10bgKfBevC9FHMcBEeKvoahfuZS7/2CkvZWv2HrRPk=@vger.kernel.org
X-Gm-Message-State: AFuF++mRgQGGCQir+nfQQrHrKaXvUQ/HK5n6mxHuGnqGDuf53DPfpXXb
	0+dJKC8kFiXg8OsXQbZGKTxtRODSn1J4Y/rD/D+QZqWJj2JCmItH74gAUzKT+II1pr36dA==
X-Gm-Gg: AYBFou3NgoE9JOn0Jwqeo2GMibHOkJu2zzCErI/c8NmuUI/bY4hlENU+sF5opH5KuqA
	hAjfdb8T0mZG5DN5VAaHdG9EakPV/PmOQ8feUQRbM3ST4/48GqRsE9OTl6J8CGDYRMXl21KOuVV
	B6ahwEYfbg1bQQQMz8y0HvI5wACvtwHwoFGgJrkZjvWIFk4T6NLmbUzdMddgyis7pQa6bBbFgp1
	WLbRTnBLJHW9avUSTetUpDPKCN8WTZcEuWbhrSfH3p4gIu7Ai6s5yNSn/AJ1Imb9W8/WhBe1sOv
	qO6EIvw4NdGN00l2+d7MB6rMX1edItCIjaHsckykb6btKIA4RTW7o7HfK/h73NsVJ2AKGqxNQZe
	7Ku8LUXCp+qq3kBOHb/1V1Jb8NwXS1VOtbsLEPfugfi9C2pfqXy8pU7kxrpaM3SjpauWZIPUXEX
	sT9ihEAYNkb1KAul3pV+SyltQZ92tiQ8Epr50LwXInFzg71QJBUD+adI3md4DA13Mg1GJOaCwLk
	idz1r9VmF2wueAkNiWqbYThqnXoVfI4bf8JLo/g5I/2i+S0NAX1T5K68JSU4L8DH8ZylsKubOjX
	RwYPVWkfD581drLPIuYAzDeRAtdxcSWHmhgkEe206shKOD3Nq3QDqJ/3qpxlHDfcRmMpg58CPXN
	31g/k6HDaAQb62iGZTibjE/YQR1bK0+bU72Z2UxZmJEvfMAI2zxc/PVjOvhwUTEnxViTg4qPNS5
	3n95yPzWOsW1Y/2406fG8pEiMbDi3nsODSeZDcWZMxYQiJFQ0xd32wID4SByiDOCRcRa1TZNAkT
	kRsl+eNVlE=
X-Received: by 2002:a17:907:720d:b0:c26:1649:47b4 with SMTP id a640c23a62f3a-c29b87180e1mr401204766b.42.1789462976048;
        Tue, 15 Sep 2026 02:02:56 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (88.71.12.34.bc.googleusercontent.com. [34.12.71.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4cf01sm546369266b.1.2026.09.15.02.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:02:54 -0700 (PDT)
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
Subject: [PATCH 2/6] usb: xhci-mtk: add missing pm_runtime_dont_use_autosuspend() call
Date: Tue, 15 Sep 2026 09:02:19 +0000
Message-ID: <20260915090223.1346-3-joshua.crofts1@gmail.com>
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

The disable_pm label in xhci_mtk_probe() and xhci_mtk_remove() both call
pm_runtime_disable() on error or device teardown, but don't call
pm_runtime_dont_use_autosuspend(), causing resource leaks.

Add the missing pm_runtime_dont_use_autosuspend().

Found using Coccinelle.

Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
Fixes: 04284eb74e0c ("usb: xhci-mtk: add support runtime PM")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/usb/host/xhci-mtk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 60af5fe29bd4..eb483a267bf6 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -700,6 +700,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 disable_pm:
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	return ret;
 }
 
@@ -731,6 +732,7 @@ static void xhci_mtk_remove(struct platform_device *pdev)
 	regulator_bulk_disable(BULK_VREGS_NUM, mtk->supplies);
 
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_set_suspended(dev);
 }
-- 
2.47.3

