Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6E4E56C7
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554814; cv=none; b=BZ8eaLczY8WkqQOkNcwlqsG/5f+LMOdm9sMnrFYJ6/KeQP27PDNeADKxgGGatjpE9wC15+IlElHZ4ZbQQtqnD6ZXobNUYCOFKZjXY8dLXHjTwLLgHq3zSbIiz1y5hO3eFt2qV4vlv2oJ9M7miPsB0RNDXs5E7CVs8sPy83wJ3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554814; c=relaxed/simple;
	bh=v5FCbIPV/VtBBfR9hP3prqVR4fFU/yxy4+mYzNogUwc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MKNZ3Qb/osmO2uMFCCEB/EvdxAIQOfrOPHsWF1PTOIEINIJnVVzvs3xnbr+shYrR8rsBYaV/3xYp5isorfPMnORIGVoTuKONMiZuVFmlTlI/5qxGSdvviXVAI0QfBsap5OpP/vZWyOW/l/JUvyF4J9DO4rWD8ctJ/+uVnJLbe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nxs5W0vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nxs5W0vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9561F000FF;
	Wed, 16 Sep 2026 10:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789554768;
	bh=LUDOj/V//WfltVnrfRpfBjmASraBfswxQqCGXBR4+4M=;
	h=Subject:To:Cc:From:Date;
	b=Nxs5W0vm+keYW95qsYnvTIR2Na64WgdR8TiSUNW1a/nNyPb/BSoogUFVrjMXAybGI
	 f596JUV2X98lSmR9jclTAlE56TwAOF2zDbpbFHQxEbKngcgZz1QNJkF4t8Poc2mzIb
	 nO2i0ATRME4KDN/aqyofVKGY5mR6aZWuM0kqcG0A=
Subject: FAILED: patch "[PATCH] platform/x86: hp-wmi: Fix board_params typo for 8DD6 board" failed to apply to 7.2-stable tree
To: arfeliousheres@gmail.com,ilpo.jarvinen@linux.intel.com,krishna.chomal108@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:32:27 +0100
Message-ID: <2026091627-nephew-drained-5a51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x ee02ed6308fbbd851c4e5c1f642d029617049a12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091627-nephew-drained-5a51@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee02ed6308fbbd851c4e5c1f642d029617049a12 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Arda=20Do=C4=9Fu=20Ari?= <arfeliousheres@gmail.com>
Date: Fri, 28 Aug 2026 02:51:39 +0300
Subject: [PATCH] platform/x86: hp-wmi: Fix board_params typo for 8DD6 board
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When adding support for board 8DD6, &omen_v1_no_ec_thermal_params
was passed as driver_data instead of &omen_v1_no_ec_board_params.

Because active_board_params expects a pointer to struct
hp_wmi_board_params, dereferencing active_board_params->thermal_profile
results in a type confusion bug and invalid memory access. Update the entry
to point to omen_v1_no_ec_board_params.

Fixes: a7320d6eb9c42 ("platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8DD6)")
Cc: stable@vger.kernel.org
Signed-off-by: Arda Doğu Ari <arfeliousheres@gmail.com>
Reviewed-by: Krishna Chomal <krishna.chomal108@gmail.com>
Link: https://patch.msgid.link/20260827235139.154462-1-arfeliousheres@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index b2773fc1aca4..615b4cf6fc45 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -337,7 +337,7 @@ static const struct dmi_system_id hp_wmi_feature_boards[] __initconst = {
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
-		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
+		.driver_data = (void *)&omen_v1_no_ec_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },

