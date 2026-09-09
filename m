Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DC2DCC13
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955003; cv=none; b=FUxAWa3GhMNELPzmRouuFV8ZbvFn21VyssjwIXvR+wWe876KZwWHHCPDIhHzLmfZhE5rqZfghGY+kYcUTM8VfgTqaQiENUt+JD/fW6+T/Me/e99lwMdDx6mqHYbGJbZfIli6HPXO52x+x0+kLgWe2k/8KCzYopx745LH/QlsuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955003; c=relaxed/simple;
	bh=oS5CcIhbMWX8gIrVOoFZ+T6VosVr+lYWVFNGnlG5FOY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OczCwJbgvaOLIAZHurUxR7mxPYHk8k20Fok2y3JG9OUCmySuolGYkqae3IFo/g3ItLaU+FCYOiphAB9bz/NkPhTQIG3rII0Mbk/VAUFxB3tEvzEw6MEtuO+pTvdYmrdNK2ns006cHV8jRaLy9QxggWdhTESKbSI5JEoNaizNYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jc5BOMVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jc5BOMVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47881F00A3A;
	Wed,  9 Sep 2026 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955001;
	bh=UTU5YDZyPuC54yBV+b4qBh/pk9mLE+Spjq7wKE2+QCA=;
	h=Subject:To:Cc:From:Date;
	b=jc5BOMVHXrt2fxRkL+ZzVGFm37+jiduuozENRvXH3vBzajgdHZv9BOk3ZdKRxirky
	 6SkUicoYhJI9I9GW+shA0PyJYJET0WvANfk3kuMs2DN5zbZ0eweYfCO0dRVzfkcjas
	 gN99rR6R0zsCkM0aWa8ylOaUsX9wWOmptTGQSN90=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36" failed to apply to 6.18-stable tree
To: Roman.Li@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:52:53 +0200
Message-ID: <2026090953-attire-untidy-c602@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce3169430f1db035d491481086e2fae2552569c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-attire-untidy-c602@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 
 

