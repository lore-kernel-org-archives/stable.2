Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87256C624
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963274; cv=none; b=rJs2bAaiu2eyXggvze45iZss62UD6zRN57dUCfLiG8CrnNWHfl7k19mBh2xWkCcZdj2rTlDbwCFC9TOedTC497Xb0W+PtwmbgOqnuPysO6H5q7gTl8u6FO5dlmTj3BT5pn2X36d5aYENt3Z14NgwxpMEEImPr1fYZZNmgyouucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963274; c=relaxed/simple;
	bh=t0iLNaIX5wRq+gf9Z9nAE0WMx0OvHbkY2L2hJ1Lm+0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0vpEhc9FGvQa1HQu1uQZceHE9OJYmYGBDpBE5j2cZnhj1Nohs4Qd7Kh/QC5xejPhbYEcSgCd29wC/Lxlaf+8ttLsgt2d7/+ylVZNJjYlS5En04UPeexkC+ztr2HgohDClpKe0XK8zo3aXOtup8T57EJZj/6okZL81HrBnd7Qps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVMUgmuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVMUgmuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7456C1F00ADF;
	Wed,  9 Sep 2026 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963273;
	bh=aKOlHnqY7jsLDFcReZPqgT7L/y1YarRiySnpdPhFeDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SVMUgmucVzImwSDvg6wnCmZ2N0lUm057t7j6PQDZ/DRo/Wd3CfWLVCwjCmhYUIopM
	 A3U4PluppFOMw2mbe5uya6IR8CLoAdHbH4BLQAlnb8Q/iCsbW2uqHuZW6NGo61kYyl
	 LZXSt9+uGHcGSZdW8NOnXz1pczoyuSWoksAgt5O/7pMgpXxGhyk//z73XCHqzoljqV
	 jbcvg4RGES0pf/Tr22JFGfnPVO5QsP0YRkaBMUSV7TV0D4ZfcDrMNaz7QLoTt+n/Gr
	 j4D3ORSFRIm1Gi3RBS8TUXGAmUm6yFmhkSF0i+hkrxnri2MKoXOUdr1H4PS7LoNaL0
	 OUW/NSdHhDc/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] platform/x86: ISST: Validate max level for set feature
Date: Wed,  9 Sep 2026 10:14:30 -0400
Message-ID: <20260909141430.2391220-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141430.2391220-1-sashal@kernel.org>
References: <2026090311-unboxed-worrier-de27@gregkh>
 <20260909141430.2391220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit e45d6b8472861d3bac86bb37f8556a7c5aca3266 ]

Validate the level before setting, so that it fails early instead of
failing later when checking the bit mask for allowed levels.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 3c8fda948b651..7f1885fb4a34b 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -969,6 +969,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (perf_level.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.53.0

