Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55840B103
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923158; cv=none; b=IjgJiA/OKYC5g/TtZAt9kVhpmuIkVzAnS7ek/+A0r2eE4DLOLbtidEYQ+fH+LUsxpTS3bOpP9sflAGj5F0OwZjuxzZkoRRTIDPfIgdEsGd1A7WTeSIGhXLjYSaxMOlfeVomtXKUGsuiy9rXvuqpA9j1CCpLcpwYmj/0aRp9ZyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923158; c=relaxed/simple;
	bh=gWy8AHZvbUDdA7NKJ2JXVgGRRK95en4adAoQid3f2SI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QylRqVMP9VkG32OdSYbnKoLRG5WCIhG5t1tkyU7DR29FTtizTtdoCllNLYX02H4rvEhobGVb3vyo5DVHr2JNQ4zK72lDJaBWC7CY6isWME6jdS7uLnzaxRbzlQVX8x1cm5pni9ZXWHiHmnVRo/PizcbJXKcWc9qbx63kQTJGUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xooIZcG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xooIZcG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503151F000E9;
	Wed,  5 Aug 2026 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785923156;
	bh=t+WJwCKA9iYzoq3L2rQhQaS1e4447kG8ttl8tz2wEsk=;
	h=Subject:To:Cc:From:Date;
	b=xooIZcG08DqM0+wihzR9Rvcrmrgg2+/E25XpbNhtY8P/+n/8q0Nf2W87EF2kev22Y
	 qPbhZueC7TAoM0hrcW25d46lJr9JCvxZirSlTYKOoP5YHnlLJjKkCLLth5MfZVx+oh
	 WztyMW/hy3QnVG5lQ6jziq9/V6gO/18JIrGOVDWE=
Subject: FAILED: patch "[PATCH] ASoC: tas2562: Validate values for volume writes" failed to apply to 5.15-stable tree
To: broonie@kernel.org,cezary.rojewski@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:44:59 +0200
Message-ID: <2026080559-decency-ultimate-2e09@gregkh>
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
git cherry-pick -x 8fb41964f7e4e4207c8999af2056894caa7a252a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080559-decency-ultimate-2e09@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

