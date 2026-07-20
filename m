Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B781436342
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562684; cv=none; b=bAMiUHKiqxhH2jaKaJ5ZAvvBfcngaY9FkW7xge5kYCUCm6OluxUI6EW4t4+bn19gl3t5R5xO4p6couWYW5UHkn7yNlgTKY2xaspVJG4kEHeWpRvE98UiAa4ccHK5kj7B0jCCaPly82BPf5cUVrY4fCTs17B80tCSsEJTYPj4fBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562684; c=relaxed/simple;
	bh=HkOZ3GAePKrbAYP+xT5D+I6SM/5VCiyknCQm7/M9CSU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UNlO/qqE5nrpCOe4M0uCvCtmxXa0LKBAwBdevNZkCP8ddcgggTSpUXyWviI1If3s/ejWTiD2Tk9fftd3MLubep3wnxKBt34IpYQJ+G2TJwdnfDTq6J5DQ5ykSsL5yLziv04NTSEAbob47XbDj9vD13uPZv21kc29bUYj+wPzlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tS7NSkFf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tS7NSkFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C891F000E9;
	Mon, 20 Jul 2026 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562683;
	bh=ce1OSl0RcdNpW+b8zN0oeVJ6mVkjwMaW9U1LwRgHHYU=;
	h=Subject:To:Cc:From:Date;
	b=tS7NSkFfiJ1buAsYMAd9Z+hTvS1puxi32mS4LEhcACS+gfGeRCSQ2HoPDvD2DIuRP
	 H65AzNU1emUcsRf7lD3aeVUVb2m3n0bELRQKUaPTrNJP06Zas/YekhBta4ktx1Y9+T
	 mXtRLPeIAKpxrxjdnvvtHLk3F/jeaxAwbnaA4x90=
Subject: FAILED: patch "[PATCH] Input: ims-pcu - fix race condition in reset_device sysfs" failed to apply to 5.15-stable tree
To: dmitry.torokhov@gmail.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:46:30 +0200
Message-ID: <2026072030-handwork-earmuff-b1c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 411b8c4b274737c3bf08e1e025801161603cfffc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072030-handwork-earmuff-b1c2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 411b8c4b274737c3bf08e1e025801161603cfffc Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 22 May 2026 10:29:04 -0700
Subject: [PATCH] Input: ims-pcu - fix race condition in reset_device sysfs
 callback

The ims_pcu_reset_device() sysfs callback calls ims_pcu_execute_command()
without acquiring pcu->cmd_mutex. This can lead to data races and
corruption of the shared command buffer if triggered concurrently with
other commands.

Acquire pcu->cmd_mutex before calling ims_pcu_execute_command().

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4f8265c0772f..39bc02ef3e53 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1153,6 +1153,8 @@ static ssize_t ims_pcu_reset_device(struct device *dev,
 
 	dev_info(pcu->dev, "Attempting to reset device\n");
 
+	guard(mutex)(&pcu->cmd_mutex);
+
 	error = ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
 	if (error) {
 		dev_info(pcu->dev,

