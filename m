Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02591353EE0
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603755; cv=none; b=TJEABRN4+iWgdRMQFRsVl/e3Ud17gf7RaaZjRIyjSUEfy5yHpech8+8H+QniQh4s/i5+zmQtFPyBDls4iIdBN80AQVrtkLqn7Bq2ew5rka8KDPiGqvBtyx7R/g1xBKqt2ccobAUGBf3hc4KHDcMgdkXRiiXjB8VMzyFn4pG5rLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603755; c=relaxed/simple;
	bh=IeM1daAIpfu6fABLMg3PEU0F1GEGvpEr8JNujtFyz5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJtMSAREaPOXztEhQMk/0COMzwq+bXm7akZhEFOLKQ1J4VDTxmGNagmqAog3+DgxzwGNTGm8N6F8FTnkWrqSziT+kFh37Llhv4UIOz4MjQbl2uJRmJmSswM0uJqWqEI7P9k7bMtjEWB1cGwHhQ5QYlJqz+qH14bR3fNYmWeaYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1CImrHN; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1CImrHN"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso549419a91.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786603753; x=1787208553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sj4nAB5UJQSiK8q2P2qqPUYrLHWdF5UCEVGSdlXatDA=;
        b=e1CImrHNgmNAu5tQcxmGeBdVLUYzIQfkRGFgH99kuwv9vhqvGWjqSneg5NwsNR182p
         jGJJCNpCgGt1Pe1twOsA+GY2BrD4Ct9S1K/NSZSz0xyE3BRgkpn5Vv553qpGi5ZT9F0w
         4CnYtTekRhvt0FumeSEhf9jdKhRzlufhMvC/krYeLhj7YoTSEhgcKcjzj41YT+Q413bV
         yvobqd70FXDosPzkIxn8pTDmD72bz343iOsTYd2iKfXcI5ebP29rOFg2AVpssh1SBTVm
         2uhgpz3tbdBh0ULjBxvL41b0SSUtCz41cn/w+P0oAOrtXVMiWzd7KJCo31GMlSrgJHX6
         wfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786603753; x=1787208553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sj4nAB5UJQSiK8q2P2qqPUYrLHWdF5UCEVGSdlXatDA=;
        b=lRZBCKXekRHYQyBUFAfnwSK6woX6wkL8Om7glBnsnL58TuurP6H6GpyCSpt3RLA2GI
         E7ZAfkzBdWWJVUnPkSjx3jPjHsZKD/ONKk48BKvamAESfwh0LmQBEx8wFB+LO/ypIZZz
         +CFZIH+rXtR8fFDxIB3GlykbPSvrINySZwlvg5QCLTITtEbDHiXpWnsoQ9B7SJ6s/zKO
         51M0oPKyv0PWLp9O2XItZcWZL5LuwvE2AeiRBFJCfuvFWXDloTxHKeTXjJJxCACVXhqq
         aMn6NHO2huPTFzaHoFHGGdkPGIkqBJ/eY/tnZBTIJ+GM1ckYygo+IMVKIe6G5KQ014ch
         bsuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6g6IkwxWsR3KwlhZh8llUgMe6VNrDsE+jthFvK8GYHf/DEIlxGGbfDtFl/SKOiY5Z6bsP6VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx848qKLcbNCpX/kM3TiQPWAwUfg0LR36d4pwg5E2VXpBMq/pHO
	X0lh0LW+tL9Viv93LyDkd7EJeb0d89H2s2fUH8M295GPeuQbgUs/4pwE
X-Gm-Gg: AR+sD12OC6qw1YZJM2rlS+K60LvEqHVP3xrLyQTUYl8+/DoikHy9qzWmh67pB62Pcvn
	HmtI60PlmIj6nDGI2U7d3P9MdbCJqYFEp+Y7B3yWb4+0qjZhusAljTYFAYaQqywqGLtZyV0TKVj
	8utAdQT46NO9NHiNkHISlteexmu4Mv89HmOx76aZ1xUOZCLIm8inCmGlohPVS7A4p8WwAnJ5vlQ
	DGtn1V2LRR2HaulS3+MHa5etiiCq2yetScx2kEZUle5OpF8zdtjYeQvR3eTRHaZqevTeE3loAPS
	9wVjVFXnR6o44zZvgHeqxocnvcZb2hA/tPJa/RnyDx+jU0sw2h4yAAXoHhvCSoFp6UekrTeoBSp
	AsMPO1P/TQDUbIc6CSZVXU2kENl+bs3Z64HzkQ/1gZtYzaluFso9I6FQ2oON41ALFbLdsN2sydR
	tY4YVDMgV6MJmf3cRBgQ1iW5OI/RewqXr4xQokPeDCFRehcAm5SD9kQh1zZWNY1M8L2wSheZpyD
	f2Js8jgfFaNxLXE1NdOgxLzwltwg1ceGGa7ET6UhNAim7mwTbT5RWTLfeaL7xMO
X-Received: by 2002:a17:90b:1d43:b0:38e:3fdc:62e5 with SMTP id 98e67ed59e1d1-3931e2a0572mr4819755a91.19.1786603753033;
        Wed, 12 Aug 2026 23:49:13 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:229c:e2c9:8c03:c9c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412da6c0e0sm7111503c88.13.2026.08.12.23.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 23:49:12 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	krzysztof.karas@intel.com
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915: Guard against NULL driver_data in i915_pci_probe()
Date: Thu, 13 Aug 2026 12:19:02 +0530
Message-ID: <20260813064902.367504-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_match_device() can return the dummy pci_device_id_any entry
when a device is force-bound via sysfs driver_override, in which
case ->driver_data is unset (NULL). i915_pci_probe() casts it to
struct intel_device_info * unconditionally and dereferences
intel_info->require_force_probe, causing a NULL-ptr-deref.

Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=db96c5ff032f4292a8dc
Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Drop Fixes tag, this isn't a regression from a single commit -
    the unconditional dereference of ->driver_data has always assumed
    it points into a MODULE_DEVICE_TABLE()-backed entry, an assumption
    broken by the generic driver_override fallback path, not by any
    i915-specific change. Add Cc: stable instead. (Krzysztof, Jani)
---
 drivers/gpu/drm/i915/i915_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 82415af47d54..2f03f95945f1 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		(struct intel_device_info *) ent->driver_data;
 	int err;
 
+	if (!intel_info)
+		return -ENODEV;
+
 	if (intel_info->require_force_probe && !id_forced(pdev->device)) {
 		dev_info(&pdev->dev,
 			 "Your graphics device %04x is not properly supported by i915 in this\n"
-- 
2.43.0

