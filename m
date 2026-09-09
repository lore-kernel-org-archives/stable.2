Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE0545D96
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955000; cv=none; b=WOPDTAypS3vmDnLJ7Obl+nlQYOCD17b4SumwXVIr1jluDpH9FWHk6IFIKqoVzBhbM8LB1CSLjc/Zjyo1h1YSG7qyM59RlJm5OJfWycNKMnL3QWcBnJM4IUEx8BJ00VHes1HajSma8poTE4DgKXWInigV8m4K5Dg8Phbmt8el1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955000; c=relaxed/simple;
	bh=TROM7wTzv621mDNUUxpiuyzI+HcxmHBnaZJRMlkxK9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mi/+ZfHCZleHBzZb9tY/CdBCESSZjkj7VJGkI2btJ8licV6UvaIRRPUIjAoOrZ5HHzJylQ6ugxWbCsjGQt3QHKP50wvg0PFS4BYL/hj5g9Zn7qMkG12bz1WJQDBqJaWswEpBAhE84FWhG4npANYvnOHQKQvyQAVHNNjlpfyJG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r0Mib/EZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r0Mib/EZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8A21F00A3A;
	Wed,  9 Sep 2026 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954998;
	bh=IRYkjlnnpUsiKyZWa3a+4xWrZ/f5M/DxaBSX35LukaM=;
	h=Subject:To:Cc:From:Date;
	b=r0Mib/EZ/HdTXDsqEhLGOFoaZd6gCcHTLxNDsU8+mJCO/2PD26xCmRF6+JIqrDGsm
	 l2M8y/kuTxRA2hREgIdop7eWW2mEVGjOggeS8Hcb3YIKSVEiyd2j2A7vH6JCccTHEV
	 RjC0rz6Mq1Scp8NCd0bq0NQiySsvB358B22TKI9g=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36" failed to apply to 6.12-stable tree
To: Roman.Li@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:52:53 +0200
Message-ID: <2026090953-snowshoe-unlovely-1c25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce3169430f1db035d491481086e2fae2552569c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-snowshoe-unlovely-1c25@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ce3169430f1db035d491481086e2fae2552569c Mon Sep 17 00:00:00 2001
From: Roman Li <Roman.Li@amd.com>
Date: Fri, 14 Aug 2026 18:03:17 -0400
Subject: [PATCH] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36

[WHY]
Splash screen corruption on some 8K monitors.

[HOW]
Set GPUVM min page size to 4K for DCN35/36 to use the correct DML2
calculations, avoiding the corruption path observed during splash.

Fixes: 115009d11ccf ("drm/amd/display: Add DCN35 DML2 support")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2cbfb03dead5088a7bdfe2ce392a5caa3d1b3719)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
index 166f10b8862f..c82886323a51 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
@@ -301,6 +301,7 @@ void dml2_init_socbb_params(struct dml2_context *dml2, const struct dc *in_dc, s
 		out->smn_latency_us = 2;
 		out->dispclk_dppclk_vco_speed_mhz = 3600;
 		out->pct_ideal_dram_bw_after_urgent_pixel_only = 65.0;
+		out->gpuvm_min_page_size_kbytes = 4;
 		break;
 
 

