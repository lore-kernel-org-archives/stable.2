Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7357C72A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963045; cv=none; b=qdEd4j8YGrY5II6pcgICXUvR8UGQwpF4N0kQqmJUOaPvTYWLhBasM7BrG+cqRXO+3TXnCmbGkDSTegK5CvIAGlOQpehhAgkx+nRY9EDprbXRWR182rEY/EV47W4N55162JeEowue19N9abtmvLGti3jegY5MQR31IRRb4zZ+moM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963045; c=relaxed/simple;
	bh=FqeUdctmlmlYB132HhbLaeGXxzj/gaibPK9uYuEwAQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWwaqLc5xdxPDdIsvYrvCqsM+72f2guLaSIJPStO41O8/hnK7qAsNox8JMGQ2WyCZFEzcu62QWev6hbjsisWjpyQo0WwL/WOqr88ESIWt5Oz6y0Yh2gAU+FtMDFL+lXEVzEMW9sM1FEEZ3fzWsM8jFFXuiPZrx1QQ2+E5YQ/HdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nliJmGs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nliJmGs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AAC1F00AC4;
	Wed,  9 Sep 2026 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963044;
	bh=ctJHt1IajnKGVn6VSWUNrFr2kxdSqstQQH1R4PzQRns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nliJmGs3ae8HvBp6vfcDyYb6F1VQfb8Jg2Mz5F+q61Knm8yJisXwEVi2GglW3JnjV
	 4UtyUtRyUq09JnhfsCmPXpLNTpR1867a1NpmoSiHH4zD/NWX3lYOVI4lenyTZd9mQm
	 adA9Z78KaM3PtbRYOwYz61Gg2rRP/Y93tWWIMwvzSU9XJZYZ4lh6GuGvEs4d1Aa2vn
	 DDhq8oy/aH3FkRtfQCY5NaTbCHXGMCOxnF9Ce43pgZU3dMVeREyqTdoKU1oessL/sW
	 bWgO0hK0lUOzqsiJ3eri6B0h8yQ8BoRq8gKGU6gRx42u7t9qoQtTVPlPcpM42n2CGK
	 3FD/OxhwITNjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] platform/x86: ISST: Validate max level for set feature
Date: Wed,  9 Sep 2026 10:10:41 -0400
Message-ID: <20260909141041.2381301-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141041.2381301-1-sashal@kernel.org>
References: <2026090310-gawk-vivacious-d6f7@gregkh>
 <20260909141041.2381301-1-sashal@kernel.org>
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
index 317738d5b0668..7c45b05190f3c 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -974,6 +974,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (perf_level.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.53.0

