Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6E550DC3;
	Wed,  9 Sep 2026 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959593; cv=none; b=LrLbiOqkfMA1vbEBh1bZiBs2kLK2kr412lGLgLFTqu5ZAC0Rx2Fb4Jxald1NxIWr3Zt3CDZemKUT267rnhk5A8bAH+Ymsq6AkuxS4jDIv6qcP6dKKeadujEOK0eMpSPPKMh4U5F/wamH4s1V5yGVquBlyquu2dyaJBcAuGSumPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959593; c=relaxed/simple;
	bh=/flwUTsnBb5pJV3uqQagfzKUQZrYrmEI2hn3JX4TTTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xmr9DCZk3eW3nJU+OaF9pfnEifkrnTSYIXd2FigqCVWCySm05+x3/sCy1oVcXiUkjy+ppgeCl0GGoFSLb0mC/iduSwxRroqIfwKIjxRgBbbIWKTwuIUhAcr6fRYCr73E6YqtqjNO81aMydOqkHJMx6+DdIlzBLwYKfmVPpbd8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od30AXtH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od30AXtH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7469F1F00A3A;
	Wed,  9 Sep 2026 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788959591;
	bh=Iw3up/37K0JEJR2NToWqFDiwdxlhN8ItBMVuaFF4dA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Od30AXtHNUifWmX7eMgpGUrLzJN9FL5ljuc4bOxHNSaGNLtqdfx7pS3f4vd39LHIQ
	 0flGungmeL6eBAFnTgdUlhTlyHvVdQFhWjrEK+rBv3rJ7v13A2AVqhlGitYO0nmegE
	 Gi3LWlVOdw+6D4vOwL6oxexvgOwMH43PquinI+Jdtr0yaotRA/zsKIEdo5j3Vtk3Dv
	 CUUgBWM+NLSBHuCjFSFSqTpN0oPxkBIW6tbJ1+xeTenzRyic2Eh/pOpBp9mJ6yunTT
	 M/co4W8A95aTnPr9KgXy+ecRP/OWHJp0qKvSTSbU4sR0wOfIMb7LIjSDvDjZG9j33H
	 gqoAyXKvwhviA==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv4 3/4] EDAC/altera: Fix code leak on dci allocation failure
Date: Wed,  9 Sep 2026 08:12:52 -0500
Message-ID: <20260909131253.2158486-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260909131253.2158486-1-dinguyen@kernel.org>
References: <20260909131253.2158486-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko reports: If devres_open_group() fails, the function returns -ENOMEM
without freeing the dci structure allocated earlier with edac_device_alloc_ctl_info().

Free the dci structure if devres_open_group() fails.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v4: rebased to edac-urgent
v3: No changes
v2: reworked v1 to include only true sashiko hits
---
 drivers/edac/altera_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d8a3438fb5f44..4b289b90186f9 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1517,7 +1517,9 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	*altdev = *device;
 
 	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
+		edac_device_free_ctl_info(dci);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;
-- 
2.42.0.411.g813d9a9188

