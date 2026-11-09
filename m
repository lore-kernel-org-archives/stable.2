Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258457;
	b=OZg8HjpA6Ip9MSBzE9WmK/59qLvxbc5LMcES0nRfVQ5b18gc2TVq2HSNm0fdxI2tE3ev
	 PMaTYBJJmyWEkYof6zpVuh1uos1qVcswYOao3vxL5AESOs1QAlmROjWpKNNL0NpNNJJwR
	 R5EMR7m6QLHaE9+qOUjjMLubh/DMEk/gdPe3BV+v97At+f4G2cYDJGxYbhNnBBXR2e5LP
	 AFnkeT6U1ks8fM2OemICnXdVxpymYYS3DKnn09HgYRAbirt9/3bt27+cEmbX/LYMx1Ozc
	 UeL4UNiNMonIQA/VZao7GPSJfg4Ct+GAnaYOqJ8fJ+l0q6ERmhGCo7LtXSCWeS+JQRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258457;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=zx8SxsoSV8Yyw8L+yqTj4SC0QqJPLNX7j1xl6sOh8vY=;
	b=vtAp5avnzZYUcMa4/0G5cbiYnRuqqUh3HkTfJkaQuWu8J0MByYZymtqJSwHCW1b/beqn
	 SC1DHEkmP2Sol0Ia+twHPXUITqW7n3vnb0gaHGoIWXBylIYWs5Rtw9/02EPfd/V5X9ycv
	 HNxAttePMgeIt5Vt+lliOt9EaLqVtxrhjaOA5fvkmngJoGY0VFvliB9SnPs7z3H23ay5x
	 d3OxhucmmHaM9lRsRioozI9VsredZu5wswPekvCYru7ewSQUG4DN2OajhZiA4kf1zWwRg
	 sxl5EldRTScPWsNK1/f2r4Mb98mXF7bRuucQZ69bfAgyTlMgm64+dsG9sJG1Gb27sqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nx06CGd+;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15188606A330;
	Mon,  9 Nov 2026 21:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15188606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nx06CGd+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258457; x=1825794457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JrfVxP3ZXPNoalDGXIJscDnrfmmTUh2X1Ow9zB8A+Qg=;
  b=nx06CGd+DMqCbSk83je7Ga0vSpr8Ya19MY8wNVk841l49fVD/Xo1wCwZ
   qH23mKtp8m8llSNOHn5DRbFyzIqkBuXl3ecvChreFqqFJ5wxiNRAyg5pB
   tlybliDo4qD7w5BV7HjblvQ6Vbb0Lzj0elimJvnm5LiK6u35SutSKOW5D
   dLqimto/DA7b3KjnKous9QnvJLwQ9pslIAZp8OXmX2z1Y1Veo79NwP2SP
   ZFFL/4MYZzlNtUpgHI4XzIB9K+tH/tXs13TtcfbxR+gzkmc+7RgusZYOC
   wZFgQa1o5ak3z8R+XG19NiofziFc9ANmS6tjPnQ41wiz/Mft0vufkfSFp
   A==;
X-CSE-ConnectionGUID: JXfoJbgLSwaedkyTqlgetQ==
X-CSE-MsgGUID: dNxWQH4CTz6wbXieAUEthA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3029290"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3029290"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:07:37 -0800
X-CSE-ConnectionGUID: mAzsME0/QRKbF5+XhEa2Eg==
X-CSE-MsgGUID: 0oWM0/+NTDeoAnuxyaLp3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8399045"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:07:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/11] PCI: Free device name when pci_setup_device() fails
Date: Mon,  9 Nov 2026 23:07:01 +0200
Message-ID: <20261109210714.3862-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_setup_device() calls dev_set_name(), which allocates the name, before
it can fail on an unknown Header Type. Its callers then free the device
with kfree() because device_initialize() has not yet been called, so the
name is never freed.

Free the name in the error path of pci_setup_device().

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---

CardBus disabled case will reuse the same label after the move, thus
add the rollback path in this patch.

 drivers/pci/probe.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..1c2caf3ce664 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2194,8 +2194,8 @@ int pci_setup_device(struct pci_dev *dev)
 	default:				    /* unknown header */
 		pci_err(dev, "unknown header type %02x, ignoring device\n",
 			dev->hdr_type);
-		pci_release_of_node(dev);
-		return -EIO;
+		err = -EIO;
+		goto free_name;
 
 	bad:
 		pci_err(dev, "ignoring class %#08x (doesn't match header type %02x)\n",
@@ -2205,6 +2205,11 @@ int pci_setup_device(struct pci_dev *dev)
 
 	/* We found a fine healthy device, go go go... */
 	return 0;
+
+free_name:
+	kfree_const(dev->dev.kobj.name);
+	pci_release_of_node(dev);
+	return err;
 }
 
 static void pci_configure_mps(struct pci_dev *dev)
-- 
2.47.3

