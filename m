Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54E3F3288
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195925; cv=none; b=XZ8TEADcHwb79mDlQ9Gs0NUq/hJ7Hr7J+Wtn5NlgprjtnpfKMSdiaVO7+snZk4DQxq3dzg9tL9ZGyfk9fMUvU2QF14aQU+2wrhw7VCcHBkCXDifJGx8AnDXwRhK0wJ8X3H0SWS6XzrKgmzbNz0yGUN3REnM0sZay4e49rsx89ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195925; c=relaxed/simple;
	bh=noPRqWlnlERPBuJUfJktqEMqL4acO7N2FeUtBvALsS4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uofIzuqYHG7Liyogu9b2Jsnr2YMTUpYwvCL6Oxxs5Pjhg+EvzfVdbGRZa7hKo2N625LuRrCayA2GilEzAJxnzY8Z9OJrlGTt/D/iIyd3TppV11g2UT8JiFMcHNXtNlug0aSepHQr5PY+VxkoRllFG8mIv+XiWlglmAHCBNR3ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iqtjB3bC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iqtjB3bC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2F31F000FF;
	Mon,  5 Oct 2026 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195923;
	bh=jGBXYip2WfKEVaidkaeTPQnMXc0Gd+1s3d0xeon+4gc=;
	h=Subject:To:Cc:From:Date;
	b=iqtjB3bCADe1LB9g7IED7yylbRRap9ZKW+AB5FaEjHphxGq2pQ5fMgUUS7Ahs2Lq6
	 AA16d4ixPA/ZcTkNymzTSqYVOMlSm3rQKUyM85R/czLhnc5zbPtP6pj8JlS91uP5uq
	 xrliFbUNjeMZd5Lld83J46QJq1phuCzB24OgmICA=
Subject: FAILED: patch "[PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194" failed to apply to 6.12-stable tree
To: webgeek1234@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:25:18 +0200
Message-ID: <2026100518-penniless-browsing-d792@gregkh>
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
git cherry-pick -x 89365897f4210979966aa808d7b013edf4080558
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100518-penniless-browsing-d792@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89365897f4210979966aa808d7b013edf4080558 Mon Sep 17 00:00:00 2001
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sat, 26 Sep 2026 02:24:19 -0500
Subject: [PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194

This workaround was originally added for Tegra194, but no longer gets
applied for it. Commit 615d43540043 ("ALSA: hda/tegra: fix tegra-hda on
tegra30 soc") changed the guard to tegra30-hda, which worked because all
affected archs had the fallback compatible. However, commit 7f0ea5acfc19
("arm64: tegra: Use correct compatible string for Tegra194 HDA") removed
the fallback compatible for Tegra194, causing this to break.

Fixes: 7f0ea5acfc19 ("arm64: tegra: Use correct compatible string for Tegra194 HDA")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Link: https://patch.msgid.link/20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/controllers/tegra.c b/sound/hda/controllers/tegra.c
index 31c14c4bbe68..674cc0f79c3c 100644
--- a/sound/hda/controllers/tegra.c
+++ b/sound/hda/controllers/tegra.c
@@ -374,7 +374,8 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	 * in powers of 2, next available ratio is 16 which can be
 	 * used as a limiting factor here.
 	 */
-	if (of_device_is_compatible(np, "nvidia,tegra30-hda"))
+	if (of_device_is_compatible(np, "nvidia,tegra30-hda") ||
+	    of_device_is_compatible(np, "nvidia,tegra194-hda"))
 		chip->bus.core.sdo_limit = 16;
 
 	/* codec detection */

