Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD393475346
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195932; cv=none; b=NmgGXbGbJb3mj/yPv6wp9BJTgpQ7xie8eoOjB2NaeuJU9LjxFeRDc1qICKEDe0EVnBJTXqxOvGZ1SPlViIGmufhvmriBQimyuPOEL1Cx2m+y3Xhdz2zkfUlv4u9Tt7tS6lwYq3Wnz2b+YovlLN3MEgrsnS6CdhESZd32+4LXZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195932; c=relaxed/simple;
	bh=L//4Camo8mh+sEc5sRNQyvgRiUD7IoZwwlfNOyYqV4A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HwnnieFexcYp3Bm9vzk2mrVIfr1dAWnlEIK2dvzWJGdnWShXC9TDC32J4g9qMCf7+OfAWvl9By+oWEPEeBlwkQYwRuQf7tqrqffcB8CemBubdsBusUe1Sq/k3PK1VKojX76GP1zRZ8IPhBPvTrYrUzNndjwnPfNQani6FITfr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HtCDtRpO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HtCDtRpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300861F000FF;
	Mon,  5 Oct 2026 10:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195930;
	bh=EZ1eBhaSRAGi36OLDQvQkWiGhVh83N5UPszc8CYcPRI=;
	h=Subject:To:Cc:From:Date;
	b=HtCDtRpO069IK2LOkEk1BO/uW3FlDHsF/BDV/fkepkAsCdv5FoAXXJd3Uo7OAXKuf
	 gc3mc1Gid9uiKgLzlzGiKN1RAYBw1tp2yM8JnN30EkjAJ4dyOcl5oYGVBAOJ6+pCnC
	 YTLqe5yb5TnQRlTV5RO2+Ny4U1SSj7VzEWFoDjM8=
Subject: FAILED: patch "[PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194" failed to apply to 6.6-stable tree
To: webgeek1234@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:25:18 +0200
Message-ID: <2026100518-diagnosis-entomb-8d1e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 89365897f4210979966aa808d7b013edf4080558
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100518-diagnosis-entomb-8d1e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

