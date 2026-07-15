Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FE25CC57
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114189; cv=none; b=uc0EuJ8dFvjnTMjbyeVutRHSiNkElDPVcOay40aY4SQknkvHEhyMUmtjH5gA4sRh09PEbQErCjqEcYFAL6zMXMiDwMuUrO1bnbUKe6P/PNSB/tKqIG87Ts1Ve07m0OqGHRJQAtPAdSy2hEng98GiwWkrYTYL9LQkgrd9rVxu1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114189; c=relaxed/simple;
	bh=iPBE6ev9W1VMUoQHtf9O+SktvmnnUBVHPH/5KlYPRXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJlJZi+TZMmawVwFtY6qNoGNpXfTFqR3XzVDvyci63TPcsXxnfewMYSRJ9LPiMIuea9ALguudHq80SktIWKUzfW9QbZjXckOhvN32ssNloP9e8a6IdgTMuqJlhmiCRhGy6RWJl8SSNrsCCgXvL05yh5faj7C1PCgK4kXi0Ua5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csrIOYwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csrIOYwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD71D1F00A3D;
	Wed, 15 Jul 2026 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114188;
	bh=jL4PVFFznYvJSFZSVEWfMVfqHJKvB7Xflth2pLlGc/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=csrIOYwAB6XAt1KhPVerGKeyCj8l2AnkJauPUUtlcf1pJc+c5rsnxf4R2Z+dBnxJ8
	 UerjgAbeuIh2u1Xk1W9OntIsPLr7fHPoLb4SKkKXYVaVf6GFcZOBG9hKKgrGfZNzk5
	 KpBhqd+Tm3JGCqFwBYiOZR6MnsvVvWNIhd04a5Kh1MyinCR393npNtPgfd/U7u87WX
	 7nHPeE5Kc13yWfVc15AMfA3o2nQK5BWXktVHFWuek9EIAFFXSOsvmyxplPJ+xWFU9T
	 bZjJsmhXePXkAaFk2ypLwmpt6oeaXLrAMVfaV7QRHbr3VwLJCTdDc2vQOSplKXZ6fp
	 NAGdXQUt/fxEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 02/10] staging: rtl8723bs: remove commented out condition
Date: Wed, 15 Jul 2026 07:16:17 -0400
Message-ID: <20260715111625.647536-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715111625.647536-1-sashal@kernel.org>
References: <2026071300-length-drainable-3f8e@gregkh>
 <20260715111625.647536-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Aiuto <fabioaiuto83@gmail.com>

[ Upstream commit 2a62ff13132a22a754d042b2230117bbea0af477 ]

remove commented out condition checking channel > 14.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Link: https://lore.kernel.org/r/83762719c0c13ac8b78612a32db26e691eef17d1.1626874164.git.fabioaiuto83@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 21489f67bcce35..70247ba9017a59 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -165,7 +165,7 @@ static char *translate_scan(struct adapter *padapter,
 		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
 	}
 
-	if (pnetwork->network.Configuration.DSConfig < 1 /*|| pnetwork->network.Configuration.DSConfig > 14*/)
+	if (pnetwork->network.Configuration.DSConfig < 1)
 		pnetwork->network.Configuration.DSConfig = 1;
 
 	 /* Add frequency/channel */
-- 
2.53.0

