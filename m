Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12B4CA798
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948878; cv=none; b=bTFZSxssY8Jt+NHEI2kN8u0mYblLro22DXxDvYcSL2JpxHIHyb56qEE3JEH3JrngPfQIzi0gR1eeTE1jDLCGCcrjfTTs+XkXxEXV1Bundse5frxxmUfjGzm29OasQzAyKgPcMKMz1UdlENK0c+2qkP7cgcLzaAfUZuNVvkP14EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948878; c=relaxed/simple;
	bh=QoTeN1MTOq4bn1Ocgm/8aEa/cejQXYFLCn4V6FXnbWw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MELTMEWanTd82Nynl//wRHEzslJnzyO7iZnjNyyH8MNeKLNAM9ea4Dq8aYuF6R+NlO8U/rQ7rPVf0+6uD8bOQgHNrPCsY11e3epDuNrl41zkgLMuwA60/8EAeoH53NTjrVYHbFAUfuEFib3HaEmQm5yji+9d9nibbQH703csbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ahuDqc1a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ahuDqc1a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764F61F00A3E;
	Wed,  9 Sep 2026 10:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788948868;
	bh=Ib2ZaX6ge+16OEvDOHk1d204+KWcfu+Pm9vNncdQrgQ=;
	h=Subject:To:Cc:From:Date;
	b=ahuDqc1aD6RtW3lMtkvE4ESlpF0Kt4u6ke4yyoQujFvlcQ5JVTOIObei/ZomU5Kc5
	 XxW5T2OI/IWtiEvX3sp8UGU3KOeEV9MGORwQ10QFAbyK8JKBIeyLWFnh8zBtZf7MQg
	 c3ALeZLTo03HU+EX6LLQkPHoQB9XZz+s2jy0pDm4=
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Fix hlink refcount leak on component" failed to apply to 6.1-stable tree
To: haoxiang_li2024@163.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:03:04 +0200
Message-ID: <2026090904-opposite-unpadded-c0c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6ad4892c4f5cb437a928a02f5b7d37d496aa9268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090904-opposite-unpadded-c0c6@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

