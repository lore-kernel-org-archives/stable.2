Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA29568FD3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963071; cv=none; b=JLhcnakUHw3b3+ziXcGUymLx+/vmxx2EkgiLLIYqcWDmnWRBoscftqkEfO/hNtMmgwOCkaOH6XtUv7LpzkWrmhSIn17Iw/Iv7Ln8dBfgEU2oVrHJrLEKHIDZprGuR0ykIn8RM5zzV+mvOljN2qnAqnrxtp3r+E1+5IcMb5cfCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963071; c=relaxed/simple;
	bh=EL3hgMWEBY6T72CYljdiC6F9zm7DHbuyTbFxn6fO/0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A62SZNFa/NYgAzgzAreAnbPnfn1ej9ktMrY/auK3zGoMVxHnVVxzzSnsTzMgeVMAaTyAN7K9q7lX3IR4youpe9s/ctKY2t56kBJSwCjyIyscS/Y4MzEd46d24mQnEYJCvggpRrJYsmlH993BEgsgepns9+1aQLhjOU0DX9kShFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mShJIXL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mShJIXL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E1A1F00AC4;
	Wed,  9 Sep 2026 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963070;
	bh=jDtfXPuC7orxn4+nFacD7HVyE51IeL2FtZoXela0Uiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mShJIXL9B5oiBekG2WzoB8K6DAHOLi7QI2L6/thVd8QX3eCRnPTWxUyBtePV0Wpza
	 Y24idADN0aKW6czLqxeCcVGv8qgsC4sv0hhErV7+u7p4vL0M/8QivEzmc7ILA8UERi
	 Uxh2AGcdErFfPFAhfxD7WPMIwhJqcJp8n6RvKM+ottZ/tmSy6xYJnpJuK5O+LN95DM
	 pVqq8zVx28IIGdFuZadqmDyHjEECraGPYhTIZT15T7IOOGlTNjL3LEZuN4tB6ctcc+
	 uDNpIt1xDBQRm8dMwy4FZ2PMONMDmOfY2aPsnp1ENddc3DJUgW6llsRMy4yXEx6G8y
	 9qEs4pUp+8nbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 7/7] platform/x86: ISST: Add a NULL check for sst_inst[]
Date: Wed,  9 Sep 2026 10:11:02 -0400
Message-ID: <20260909141102.2383363-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141102.2383363-1-sashal@kernel.org>
References: <2026090334-lumber-underfoot-3bf9@gregkh>
 <20260909141102.2383363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 3de2776e9d7073765c10c2326c2bda5926811ea6 ]

To be consistent with other places, add a NULL check for failed socket
loading by checking isst_common.sst_inst[].

Fixes: d805456c712f ("platform/x86: ISST: Enumerate TPMI SST and create framework")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811222134.3912626-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index b6cd0ab38a7ec..a605a0ba18f64 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1130,6 +1130,8 @@ static int isst_if_get_tpmi_instance_count(void __user *argp)
 		return -EINVAL;
 
 	sst_inst = isst_common.sst_inst[tpmi_inst.socket_id];
+	if (!sst_inst)
+		return -EINVAL;
 
 	tpmi_inst.count = sst_inst->number_of_power_domains;
 
-- 
2.53.0

