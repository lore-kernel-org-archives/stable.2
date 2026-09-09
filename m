Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141254CC290
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948873; cv=none; b=YFpNjNAIyXMuoFe3fuHHclCOG20f2ZL3r/Wy6dfZ9cvAbbd2Ae7fDrd4T6leAWRpfNav/BL8/Kj/9SG3gNvXxPcr2CbJUgon+V4mdnt1RXIo3gGBIbE4Kb1ZhIS4oeBHtLt1uWw3ZsAln//xjJ3k2VrWfFL1EvxkjX2eP2WVUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948873; c=relaxed/simple;
	bh=Irx9bzikm/fWXosZCQ41Sd0xFwqwlqxLS4g2E2ji7wo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XT/7i5BqPfB8lZ0+2/xLdQCkcrTjaoHNPSO505jzKnPfozChqwFnFYr4U0FtPs0bIiMlHTN+dHAE0pfAmfPTSykkZOzEVwjnsO2UKPVl3g3mO1uu6ml/F7R3Bd3FmHYjMr6MwVNtkXJl043o+gTu1ucmX+m64g/49ZgAyrSsw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQlaO4Sq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQlaO4Sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6831F00A3D;
	Wed,  9 Sep 2026 10:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788948865;
	bh=gmVxLdFdb6f2mmfGEb7/To6fKP3YodbVeGS3yvcicik=;
	h=Subject:To:Cc:From:Date;
	b=FQlaO4SqR830acIMMvQ47xxYEjNmLcwFeejmP12eEg3xC+2N50GE8MHb5pu3l0kuh
	 C0riISDgCCoUPic6vYG0to5DiyWLOHwPCs/xvU9ipbzjRcowwrBHJvAskQv6aRuYLy
	 TfF52Jth85tNrhBDDBeefjzcTgT2M2u6yEQwAFno=
Subject: FAILED: patch "[PATCH] ASoC: hdac_hda: Fix hlink refcount leak on component" failed to apply to 5.10-stable tree
To: haoxiang_li2024@163.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:03:04 +0200
Message-ID: <2026090904-payphone-halved-2f01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6ad4892c4f5cb437a928a02f5b7d37d496aa9268
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090904-payphone-halved-2f01@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

