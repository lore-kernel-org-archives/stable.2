Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831957D22B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964550; cv=none; b=nRXX6/fCmAVOrACo5tyGTZul+v9vxtb7wPqUMIsd+OIWj/cPgnrbY1mqrYIdteWin9qVRabRejRmAYTyPk1kEFNbvk9sQM5awjMrZQ9qEBgdajwChtFzqeYjHAANoOuUWCgnUoQ/GmooJ41Vpx7gIucLzugVb+6jK43F5O8gbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964550; c=relaxed/simple;
	bh=ASeQOfjeyhdPbLhASuedExfwpFg01VG6A5+dBubdyMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKbsJCxppbPUPx+yC+MywzXgATMPErux/dHQGD39hP9eQ7bjbrJM+u5bsTjDXL2ru3M+KKcuXBvuHxFCnX/K3jKsS6wSP6OicyQtXXEZrc23Qrvv5xrDb5xk0bOb8WxyCKze6JZap0yDB4z1wnm75BkBu610pC2rUJtND8cQ7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz8d/do2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz8d/do2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69F11F00A3D;
	Wed,  9 Sep 2026 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964549;
	bh=jx3YAjdy1GQxlSPc8lb6fHtwV8KM/1KqI9ZGG5Ve8Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yz8d/do21iXyfx+JfiLhi3sf0D5xW1ei0xVjGNZ/hBw4qiAoCkBuKqao+Ng2bGH5T
	 CuQSssl8+IlXY5+SA2ZqnJzutgTG9HIHHmsvbSqMeVbRvv4B05wD+1WDDhRLNPWfM3
	 DJCXPrxmIAnejRxUMt9IV3nb3/HGBzL8lze9pm6B3C5js12Hxa5Os4SZslar/4aN9H
	 JyhL8Br24fyxoXsFadq3fZNgXheWD3ghMntmgynbGHx9OD5n7FS9luzrEJFTIjHk4t
	 CTtLPfqQ6jpsRNkUSuImojUdELE4R8uDhdw2LaN2PwE5ZT7jxj7ZyVpBVH5YQLtgRQ
	 ozpK9BzVmE7bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] platform/x86: ISST: Validate max level for set feature
Date: Wed,  9 Sep 2026 10:35:47 -0400
Message-ID: <20260909143547.2527299-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090311-concept-diagram-32f7@gregkh>
References: <2026090311-concept-diagram-32f7@gregkh>
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
[ Adjusted context for the missing write_blocked/CAP_SYS_ADMIN permission check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index df0b0118b751f..246013b26c953 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -747,6 +747,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (perf_level.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	if (!(power_domain_info->pp_header.allowed_level_mask & BIT(perf_level.level)))
 		return -EINVAL;
 
-- 
2.53.0

