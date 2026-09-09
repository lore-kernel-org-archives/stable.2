Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9154CA798
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948866; cv=none; b=dN+PLB1+iNns4oiUzu+NPzBbpIB/tQzanR1KiVRQKPU1X66M2y3v9p1wbeFikSGpz9lQ3p0GJcU1rWQRO03xXR0Dt76uoeWBlX/A/p63nfMeq/nzyMf89WqVvl7UfRnJxYVh+sBTD+2CNwvntzHzg2aKbHA1ffoUbbqisuQ488I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948866; c=relaxed/simple;
	bh=sjhStSswJFRVIw9Uhd7YobELXnppWy8gfUyddXYWKdQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O7+GPtbrTm5kGrc4ruFtpsGRH7uwsX31MdhLrpRjGWSdpSzo/3j/cZkk+gDGyD3Ow4bnGrQ4d+AknbhsmifznOlaJr8Gk3hLvZjpYASTAT+pcNfAhthVCO/7H36q4EaiRcSRd4mD+PpbX7RaxXTyV2dJBmDGjWqQvJ8tgKDfNRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSfNc/TS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DSfNc/TS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CF31F00AC4;
	Wed,  9 Sep 2026 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788948859;
	bh=xub/PTNH+Cmqn4wsLT3v5em42tjyxXP6LzT+sfFgQ+g=;
	h=Subject:To:Cc:From:Date;
	b=DSfNc/TSptSn/NklckZb8h8TlldXyKfJu91ORlGKE9kinayJFgYm2GYHhho8jk8Mj
	 /vaMoPxk2b3lhcSEb2cye5FfZ1yTWq6KmR3Z/c348GWJY7APzGREhlxAfnE92PAzWq
	 MbrEAw19O2JjXe8A2UFaE99JTdPuM8xE0cX4oYAE=
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Fix hlink refcount leak on component" failed to apply to 6.6-stable tree
To: haoxiang_li2024@163.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:03:03 +0200
Message-ID: <2026090903-snap-maker-9654@gregkh>
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
git cherry-pick -x 6ad4892c4f5cb437a928a02f5b7d37d496aa9268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090903-snap-maker-9654@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ad4892c4f5cb437a928a02f5b7d37d496aa9268 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Mon, 22 Jun 2026 22:56:45 +0800
Subject: [PATCH] ASoC: hdac_hda: Fix hlink refcount leak on component
 registration failure

hdac_hda_dev_probe() gets the HDA link with snd_hdac_ext_bus_link_get()
before registering the ASoC component. If component registration fails,
the function returns without dropping the link reference.

Always call snd_hdac_ext_bus_link_put() after the registration attempt so
the reference taken during probe is balanced on both success and failure.

Fixes: 6bae5ea94989 ("ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Link: https://patch.msgid.link/20260622145645.1184986-1-haoxiang_li2024@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 680e341aa7f1..1ab5f8a26e03 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -642,10 +642,8 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 						&hdac_hda_codec, hdac_hda_dais,
 						ARRAY_SIZE(hdac_hda_dais));
 
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&hdev->dev, "%s: failed to register HDA codec %d\n", __func__, ret);
-		return ret;
-	}
 
 	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
 

