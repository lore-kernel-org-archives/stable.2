Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFA386441
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791188768; cv=none; b=e0CMWrmKtIw2AcplUQMda8ArWtqSyF7DJmSFkgadnbNsNS7xQsJwn56r5LJKW0xGXitF3m1t94BmIv0l/557H8eo93GEpKCjw+lC6AUSoOgwh0DOqpR1AvYjPdw1X/TVE132l4qgaW2POBKMAyUX319P9fgCehJ5BR/18o0ksTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791188768; c=relaxed/simple;
	bh=+dPqy1haJnXOxL3BTzUvL/rt639tPscMnOBxON3/KWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qorbaa6tlf8d4IhcN9pEMFY8o15+z9xwqLEvSJUr1J/dZ5vFEscXTrFBHiErR8lR+QXBbCsyNjCaMMRMx8ythTAKBuwheqDYq0uAzikDK+tA57osHW2/er+swtNsZJmQSWfDrsqHeQufzsxZ1O6d3qgr5cMQPeveAomPpG/xHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MHyY7dKh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MHyY7dKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AC81F000FF;
	Mon,  5 Oct 2026 08:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791188763;
	bh=qksMjGuGrnZ7BzcprTkz9tHaxj4Tdvqzrrw0f0xzpHQ=;
	h=Subject:To:Cc:From:Date;
	b=MHyY7dKhat/k2ECbhCVb/9zjtVga9rpSfA3/VPP1Tx7PiBL2D7SdGVTriWfH/GUNE
	 GYsxDXU1QauZ7Ip53NvY92Z9Bnr3Ir2FiKgiAtPxSWbngqNe34sUirYPi5h+E8JJC2
	 Yxxq0t/AZZKiZtAfxMlHC+H73BnFF2EH4vZayi98=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix fast updates on DCE 8.1" failed to apply to 6.12-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:26:01 +0200
Message-ID: <2026100501-overdrive-smashing-51d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 687d31ea9ac76b299817060fa1e5582d6c752ae0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100501-overdrive-smashing-51d9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 687d31ea9ac76b299817060fa1e5582d6c752ae0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Wed, 23 Sep 2026 14:20:32 +0200
Subject: [PATCH] drm/amd/display: Fix fast updates on DCE 8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DCE8 should use legacy fast updates.
This was already set for DCE 8.0 and 8.3, but it seems
that DCE 8.1 (found in Kaveri chips) was forgotten.

This fix should be backported to all kernel versions that
have "Refactor fast update to use new HWSS build sequence",
but this patch won't apply cleanly to older kernels due to
another refactor in "Remove dc param from check_update".

Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260923122033.1046651-2-timur.kristof@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 57605379559e3b5044c8274a1010ec658e5e73af)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 26820d35478a..2f4de697ec4b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -1148,6 +1148,8 @@ static bool dce81_construct(
 	dc->caps.max_cursor_size = 128;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
+	dc->check_config = config_defaults;
 
 	/*************************************************
 	 *  Create resources                             *

