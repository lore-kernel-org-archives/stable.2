Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12759418A35
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198119; cv=none; b=B8qjs6YRsxbO/PtyB5A0TiPLVVOeZ7VD4vpyHFgY+2wevdOaiQC8LY41WabUhbqhnfwS0BWNu1QR79hu1lUiXAktA08AbYQvQjPG5gUqYkPtAsAh8G2elVvqlxH5yfeP5M6ii5ypsx1OSkNY2KYFhiy3NOC6WFxcY+HZ9ySCdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198119; c=relaxed/simple;
	bh=fnNxW1I/REbahCjJ9LTDaUeOX4f0/4BYz879y6yEeJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ty3Rt4eSKP+KwHTSSdpZgsHDTGdegoZYPcFgSBbNJcz4TNwO5PYoGLqlSuUZqdmQ1fmZLWqKB5kWK0g4wm3H7CxzFgroJXqiUeOOdqcTcdYjW3j0TIB4oaP4xP9CcHmcoxUg31DY1UvjfXObP+6k/B0pTwKz83EY7ma0wvDFUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP2tP0os; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP2tP0os"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca88130e09aso280512a12.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786198117; x=1786802917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xpXkiS1syNfL3SE9V9W6WDFdug7+uucLTLZ+bvyu9mM=;
        b=PP2tP0osAWHg1ag4stjurym51701d5kPHDlwXNgArFtpkZ07MfO/kCppfUcvgzL1Ae
         5yBu5iIovzXoeBbHKutror5qMQm88Xb9DbuVSBiynj40fVEMmntDlVU3iTA/m5FKOO3e
         NRBDF5pEwLikz75NutOl37yX04cZI8K/ieItIoVoAJWCTbpOrYtotEzVP6Zkt+LZit4K
         H2D3sn1JL4ae3+/OXh9vWOidJpmD+VLnKS22Zp9RMydubKIjKxu9lheXsj/P0O9sy0s0
         KRvksiaELcgDtJB7Q8mKrB3qQl59/cs97b3U2YN/Nj4whISejpX29S6bcPUoKEvoB4jy
         l+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786198117; x=1786802917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpXkiS1syNfL3SE9V9W6WDFdug7+uucLTLZ+bvyu9mM=;
        b=TUKv/8dIe7/EP9wYWr7JWfaagFOB6pBoyYqiFEEIBx4e7qZlwm0WT8OHrPBtRCe9vZ
         41XzANbNKalqFCIOjyJug6jhYXVNTxhp66dDTeE+lCWWFReLc/NTDbVoMT+vSYaeat9u
         pIt7KW/fHw5CNxgf75Uv19vj+dc1MwrysgtzKEWGX2KXfqmSaBD22imuDDHfo3XzqQf3
         awXw7SE6lVBlcidjtPi+v1Su/sNXGfTAmrfAR9POy4a6H92FufD5+aOAoanlfstKVEc9
         oENpmtIQsAT+44MorIWep0SvfelIsAr+Bhe/rn45lsuUYEBZCN1T0yd/AV+puxmAGmWU
         7gSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJtwysL9JzyptPPbWfxUn0L9W8kab/U/UKbyVjdcBgqwHlowjA7APQVBDg+9ib4tuiFbCOjtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/pI7Sl2o177IVMHqPdD3LreMTg+wYA3c+cvpzoEns6e9fwc7
	s6+C6MthHLRjYbegKn6kGk47uvTPYadU0oU+VVfyUiQJSSIE9UECpV3g
X-Gm-Gg: AR+sD10rYshTbhfrP0tHzPMn8slRwVdjl/RjuSTc4anPr9vWvNjnzGCfgWHRoWSFOzS
	o4EJWiSc+A+Vx7ryKnNFioAzYa4BtBd0eCjJXT5Vdsro1NjIv3cWtowWSN7gbZXbJq4qlAt8akN
	lLShQ9d9f/4JjsnD1/0lzURs82+0TGZee4ZQ6HZSGwvVLFEq0NDbIHsd8+d0juaNZ4EuydkLiIJ
	IiaSpLAorbZQSVI6UZtq8b91XN1m6lP9oI8RQl3S5vcZT3aNYkG6WcI01unjNKsJM0M2IMKAsJ1
	MokvkCKiV71uEhqDOp8e5YaC8ajWYymYu4vo0bCiWSFGU+JMJ9zn1+2fpZ8Djw6LkvdwrkMRQIV
	D/6slJavwhRog6Gjs3SSovWaYAD7AbMD+x1qD0tUn/DRjgbh/4omgIeZzTxfM6hiyCEBAifHqXv
	Am/+y4zxMrYke7fI2kFE8Jqah6Zx7LpD+86Q3bOo+nShw=
X-Received: by 2002:a05:6a21:7007:b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3cb85ffca47mr41360296637.35.1786198117342;
        Sat, 08 Aug 2026 07:08:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f1af992sm1913171a12.14.2026.08.08.07.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:08:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: gr2d: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:06:22 +0800
Message-ID: <20260808140622.2887873-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gr2d_probe() calls pm_runtime_use_autosuspend(), but gr2d_remove()
does not call the matching pm_runtime_dont_use_autosuspend() during
teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: ace01e2af387 ("drm/tegra: gr2d/gr3d: Contain PM in the gr*d_probe/gr*d_remove")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 892e3450b281..95e8a14a9648 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -296,6 +296,7 @@ static void gr2d_remove(struct platform_device *pdev)
 {
 	struct gr2d *gr2d = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&gr2d->client.base);
 }
-- 
2.43.0

