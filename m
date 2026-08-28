Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C12367B6D
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929366; cv=none; b=h0tTDvY4dSiOqFOh57Vj79w0FirVfRSvGhbEBaQgjmF3AP10r7lbsX7vHfCDzoROMTZyH9jXwYQhb6OaPf2ZwFKXj+1/wlc7GZbfWsB20PO/NBEVuRsfGCvk1rssG9MlkHh21P55v4z/j2q/kx4lcKaXwLkcE26BIaKLsrSfUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929366; c=relaxed/simple;
	bh=3PzgDiqiy1oNIWRe2oB+sNV62Q+Jw0+EhuWagGqurb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSTfxBeepP6nO3aaVnPG+DOqoCJ9EcDjGwacoqOQ1YhvLUNP4zvvEH1ln+BDGOgCnB0qI0Q8pEq+YNbCogIAhd+EOylrPV/EJB2E7wOUneW6Fibi1nv/r0vXBlYkZihJOHLorGkaFQZRhx7LI/Uz7nlnArowIMSuAi8BUwHMilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC9l9AWh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC9l9AWh"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so887374a12.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787929364; x=1788534164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOOUEhwDmB12LFQNSiGGCOAzSpgGLKnq2vsZHwr0Wgg=;
        b=DC9l9AWh2tEERohee0xTeMTX1jaMWPyFSqqJrgyAi+O+9AomXM4stMgrZu9EpZ0CO8
         VTzj7daDu4fZlkKT9QaSHlMk1GV8SFKrWMGlom+Meh9c8LNZiLCwTO//We/bpQtRTuZg
         QbCS3SoGX53dVqjo9abU/wkJL6qIIWVfLLLu40tru+akgdd+HW74MBiMyR/5R3if9LCN
         FUJeJNrQdUsCpW6gKcx3NBnkAESilUo+L6w83OTj/KokRL4vq4iOJ3sRjlD+/UPeJgxw
         6O7h2gRCxZkAHjax096yG5UQFrO95Oh1PPhqfwIHJR6KJvDPZbvyYVCHZ9BN35vDI2XZ
         OkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787929364; x=1788534164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOOUEhwDmB12LFQNSiGGCOAzSpgGLKnq2vsZHwr0Wgg=;
        b=OognncsPDKPDEyRsrIwZR5yI+5+roK7egjsUVuGm1A03xMPWEonTP//H0w+j+gtnlQ
         jqqNeJVe2VraLC8M63MX1t4156jVNnpv2h8gFyRbIN8+B+RruIU30PWRW0oKvkYj5LWW
         m/RVHQx+qjOV5LTUq2D5xC4+bK2K+ZeC5dKKYvo7/A7wz1mWvPicWGzb78vh7Decns8n
         rJYLBBChhAkqdftT+I5lxRf6FxbODFVdD48y67nbqH0UaR1hr0JaDniyXP7h/6PediUa
         lLvKZ1xdVoAAxcg4Cij6CJZJ6GHWo1SWVK0mcy/fUrLS9I/sQzpf9g1nLD2jTSRUDx2N
         ukWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFQvTL5X4I28PueVbtK/xASx+BVVUUBPUiw3roI2GfgPY4S+/CWtrJYpDDgsf7JioIkOkGv0c=@vger.kernel.org
X-Gm-Message-State: AFuF++kT3u/6XF9jYvo5iTrkr9/WmCgF0tY9UMdW5RvyhpWUlUkOz2lA
	aaDRT3eMAQm6M2fLL8Ik2NyJjNotjY2Uuh1joK/zpocu9cy42oQH4GPE
X-Gm-Gg: AR+sD13y+cjMfUjMXZLE7i+LioLOoz2gDB1su7X2SNUXfTloeg/xQz3VgKhKkA9yhrQ
	3rwSuMd8k5uOrNTweF0XNwMRA9qLVe9NNMHYPgxYg//7SdFh3H60oLkc+3rdkfKOjZAnfyOB6Fe
	diTP8TxO9v468QIm8xGrQ9zxSNNKe0/yDKsJ6jPJx5+MsqrA5O5MMNEmAL7FFWrh1uxarY9QwHN
	9Cx54obsKac/ZqMX+k+Z7XxD3BUylszSBIak7mphphTapcy7nDl2EJl0qHwA4wQ05jF0url6lkn
	n7YYrSk7tKHzlEhFjE64OTwsw4Vt8ezq38X7awOAaVZoMfCusyyzFdG4Fu+u3/QyJluLXGJhNFH
	eW8f1t25J4Fm9UrgtsnnfI5bLsm0gOsMKYTqxeSO3BdEJQUVq+5YtIKvhBc202MAuXDspts9DZI
	Rn9q3dlOOKScPDS3czWJ6uf6fgYd0EAsn52icgmZjw89/bDOFTF/DGWdRU7MAwKx1x5Rz4r1lMP
	pa4KyJJlg==
X-Received: by 2002:a17:90b:5188:b0:396:5fce:8e24 with SMTP id 98e67ed59e1d1-396d0ea530emr17557004a91.4.1787929360339;
        Fri, 28 Aug 2026 08:02:40 -0700 (PDT)
Received: from cfarm424.jing.rocks (cfarm424.jing.rocks. [2600:3c18:e002:2e11::c424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396db196903sm2911068a91.0.2026.08.28.08.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:02:39 -0700 (PDT)
From: Ridham Khurana <khurana.ridham222@gmail.com>
To: Felix Fietkau <nbd@nbd.name>
Cc: Ridham Khurana <khurana.ridham222@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: validate default EEPROM firmware size
Date: Fri, 28 Aug 2026 15:02:22 +0000
Message-ID: <20260828150227.1062217-1-khurana.ridham222@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt7915_eeprom_load_default() checks that the default EEPROM firmware was
loaded, but not how big it is. It then copies mt7915_eeprom_size() bytes
out of it, which is 3584 on MT7915 and 4096 on MT7916.

If the file is smaller than that, the copy reads past the end of the
firmware buffer. The extra bytes are whatever happens to follow it in
memory, and they end up in the EEPROM buffer that is later used for band
configuration, chainmask and TX power.

Check the size before copying, the same way
mt7996_eeprom_check_or_use_default() already does.

Fixes: bbc1d4154ec1 ("mt76: mt7915: add default calibrated data support")
Cc: stable@vger.kernel.org
Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>
---
Based on next-20260828; applies cleanly to v7.2.

 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index fe7b29ebc0bf..145d14a1012d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -111,6 +111,12 @@ mt7915_eeprom_load_default(struct mt7915_dev *dev)
 		goto out;
 	}
 
+	if (fw->size < mt7915_eeprom_size(dev)) {
+		dev_err(dev->mt76.dev, "Invalid default bin size\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	memcpy(eeprom, fw->data, mt7915_eeprom_size(dev));
 	dev->flash_mode = true;
 
-- 
2.47.3

