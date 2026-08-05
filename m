Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944840B11E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923149; cv=none; b=CoGZcMtFE3d8nVG1Z6iZYd4Ye4F1wRKwMz6KCRSWvxaOTqTJ17Lynj6/YtIZ4DgAXubnErSDa+ruuG/yXwzDUawpXT8sAowl1PFq+4bsecCxVAewBY2vKrUN7w7EXuL+Uj7fapbTAk8a/wwRNB75JLM7v+yWHBFUI+1L4g9Liyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923149; c=relaxed/simple;
	bh=pXaR6g3MNn8kgRZ7AUpRSYQiAzVyEWUrXgYJ5UbdPsA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N1+EPo6NFCYeNzBkP5B5KSl4NTeBq6hko240MHj0wurFt0b5TtGExH4ub3An8BDlIaOAdKG6LCN4pNIZAujoUW5j2z3Wm3v3ydXz3cfEVu8i006zwkzPyaRtjD1tPVe6f3YbnoLmXVQNpJP35mC7+gAYnk6PqdVWlCr0+gvLoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g9ozOrTH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g9ozOrTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AB71F00A3A;
	Wed,  5 Aug 2026 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923148;
	bh=y3ZJ0Vw4sDG0iSAsqblL8fbIonnOcVUShQQdIOiVQZI=;
	h=Subject:To:Cc:From:Date;
	b=g9ozOrTH8FChPU8ZqyvIu03h+ZysHTZnQJbqbnyPyoQi9KCpZavxD1wGapfN9k4sL
	 0pdxWzq0VoTNALP+wXn0pSCoaMieEUJwQmLwmqwPKbZJhDotB3PyR7dCHz8c6eCkid
	 xpProLGNlyOu+7gCbTP6N8toLFDoF1uMDwqWZQMM=
Subject: FAILED: patch "[PATCH] ASoC: tas2562: Validate values for volume writes" failed to apply to 6.12-stable tree
To: broonie@kernel.org,cezary.rojewski@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:44:58 +0200
Message-ID: <2026080558-implement-huskiness-3dc7@gregkh>
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
git cherry-pick -x 8fb41964f7e4e4207c8999af2056894caa7a252a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080558-implement-huskiness-3dc7@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

