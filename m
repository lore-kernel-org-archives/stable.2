Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53240B11E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923163; cv=none; b=K1ixbPGFhGqh1pMK64G5hxWxmtsy7aAZ67K8Fz6RZLGefa9pnFLIPXMvfLZFTrhsBD0Ae5DrXrrdI1h75FX8yVey6Jp83sKYoWUtwu4tqkPAUkj0Ry0RJniVZPe2tcOvxsXT3GzmCM/ymDmtTF+AKA1yDBcnxaQ23OMRfIC/OVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923163; c=relaxed/simple;
	bh=n0r7I2ufhRSiFsMQWDLiAYznEwMvM6tG143R/jbaTGk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a09MHvuzgXR/8AOlyXI61jZ0XUB/nu5FJvtir+E72T9jdf4q168bXqz+iWTgxwf69N6dEekzxzUGJmOWRYKTMqGP+dn3RHQkts+2hlBinj10Um2pdCIe2KwJRSqeYh1nqUJPgJv6utA/iN1QiY3u9ZC1pYEhOKiOOBztj/8n/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wZpupPIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wZpupPIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076D31F00A3A;
	Wed,  5 Aug 2026 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923162;
	bh=nGrX7e6A5DwqJtMMUYqU3RQ4QQYk9GaSciIsT4WMxug=;
	h=Subject:To:Cc:From:Date;
	b=wZpupPImrka8zzhX5u2XjynAM4dDaMWDpcdvcoOxWUE6lvXOOgdnawKodd+vFyVQT
	 kffgZ3W63jvEQE6v9bZE0g9UFobrfjx0TxgZDk5uNvWXqmLeS8Q5Kd2k4Pcnqm15wX
	 zXYKFeuW9sht9Uj+5qPh3qgrSW0RXFmx2qmTdf/Y=
Subject: FAILED: patch "[PATCH] ASoC: tas2562: Validate values for volume writes" failed to apply to 6.6-stable tree
To: broonie@kernel.org,cezary.rojewski@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:44:59 +0200
Message-ID: <2026080559-motto-posture-14cd@gregkh>
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
git cherry-pick -x 8fb41964f7e4e4207c8999af2056894caa7a252a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080559-motto-posture-14cd@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fb41964f7e4e4207c8999af2056894caa7a252a Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Jul 2026 21:18:09 +0100
Subject: [PATCH] ASoC: tas2562: Validate values for volume writes

tas2562_volume_control_put() does not do any validation of the control
value written by userspace, it uses it to look up a value in a fixed
size array which can easily be overflowed and then writes whatever value
it gets back to the device.  Add validation that we are loading a value
we have in the array.

Cc: stable@vger.kernel.org
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20260715-asoc-tas2562-put-retval-v1-1-97bf467c924e@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index e1d62f30418a..40b7803c68be 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -471,10 +471,14 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(component);
-	int ret;
+	int ret, index;
 	u32 reg_val;
 
-	reg_val = float_vol_db_lookup[ucontrol->value.integer.value[0]/2];
+	index = ucontrol->value.integer.value[0] / 2;
+	if (index < 0 || index >= ARRAY_SIZE(float_vol_db_lookup))
+		return -EINVAL;
+
+	reg_val = float_vol_db_lookup[index];
 	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4,
 				      (reg_val & 0xff));
 	if (ret)

