Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E14EBAE5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949690; cv=none; b=klXvb2OlVdX4/5Td4BQm6I7WyBL6FydamO+9qPmuE9Q6rb4T3kZDUyEju6MUGn+jTogn3ruZ9V/fdlklQ2NjmrU+PEfJW6btGOxIpV32xdLVipE2Hq69XgZCJqlSvHNjnvms0komvnQjbKspboh1mFDdvbvi6pz7ytuv+g6P0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949690; c=relaxed/simple;
	bh=GHh9N97rH4bQo7PuMqKD206DYDFCHOwx0D4uFWKfqpA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oXmS06D+F7rJ1oQ6cOOXE005XuoQ/zJtwzgoycv0pdCsK3RF4nEv+o6D/w9LoldeaKqrUOJVcdCxaAbSzzZtsoeFXxnwhbJCXRr4N8CN9r62slcmm4VegiurRIv2bYZBT0HTvNY30G4A1gOCXBjoDDL0J8A6jB8xWSO2wcAdKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mGBNHfU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mGBNHfU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572151F00A3A;
	Wed,  9 Sep 2026 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949688;
	bh=AlT26Aez2GYhLG3gX/LkfwIH87vOBmEmZFrPJsWtJA0=;
	h=Subject:To:Cc:From:Date;
	b=mGBNHfU6Es3GbNMU3a3rB6W5y4cLzhEkit9BFBkeRsKf5zQZaDnm4n5YS8ANVxN7R
	 4ZlZDOuuD+qssq0tf25g/OnGLFghDtT9g4JFmswP0ErpsgzzVZ1Eh5jC3PPAjTFmjb
	 pVPsuftb1HzQH4Cgxduzia4ckMDHBflM4wtIablE=
Subject: FAILED: patch "[PATCH] ASoC: tas2764: sort the register default table" failed to apply to 5.10-stable tree
To: peter.ujfalusi@linux.intel.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:16:27 +0200
Message-ID: <2026090927-landscape-subsoil-644d@gregkh>
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
git cherry-pick -x e7643c3f7eb3292f8a98c2ddbf46ba78d848b83d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090927-landscape-subsoil-644d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7643c3f7eb3292f8a98c2ddbf46ba78d848b83d Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Wed, 5 Aug 2026 13:41:47 +0300
Subject: [PATCH] ASoC: tas2764: sort the register default table

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

TAS2764_DVC (0x1a) is listed before TAS2764_CHNL_0 (0x03), which makes
it unreachable.  regcache_reg_needs_sync() then cannot compare it
against its default and reports that a sync is needed, so it is written
to the device on every regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 827ed8a0fa50 ("ASoC: tas2764: Add the driver for the TAS2764")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20260805104149.9795-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index b11b998aa32a..f9c65c9f6d0a 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -897,13 +897,13 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_PAGE, 0x00 },
 	{ TAS2764_SW_RST, 0x00 },
 	{ TAS2764_PWR_CTRL, 0x1a },
-	{ TAS2764_DVC, 0x00 },
 	{ TAS2764_CHNL_0, 0x28 },
 	{ TAS2764_TDM_CFG0, 0x09 },
 	{ TAS2764_TDM_CFG1, 0x02 },
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_DVC, 0x00 },
 	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 

