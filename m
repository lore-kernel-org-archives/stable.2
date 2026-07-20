Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954C3D6480
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540843; cv=none; b=ZNCQAHgmNruDS81wiHoGIvpEQR6dX1W/cKysxDyQAWdtVNKeg84eRYpjwgE9d326QJX4p432XcKMHL1TrMn2Hx3wk2s2MGf88A+YDolEWZPdB/t8n88NmYFE/TajtjR/u7xI2MSexri9mdRRjoq06NHHW+PCh5RfPlVCnjLaq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540843; c=relaxed/simple;
	bh=Qd+JGMV35rmJUS5I6RBHcbI9CQ8XBKTZAkgg7zMoaUM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ffXuAJS/jytnhZ4/bxNgKJfCMZ1Khl+O5gFxaT7oNbcRvBIXU6ZULbZQ13N2iIy3K/fPgHssI9NiTeI/bfZHRQNdiEWrX5j67CWwPt9dPLGLLPpToDAWLrhpIVQfNb6bCvnzMU8T7YYoPFgGr57UXvtTWLqYzZBYaF/eZLADGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XsS9AUWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XsS9AUWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665AD1F00A3A;
	Mon, 20 Jul 2026 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784540841;
	bh=05uLN5O5T7NbuNXYyXQPEAkF3h9jLakan5GMM3ub0ew=;
	h=Subject:To:Cc:From:Date;
	b=XsS9AUWaSCQ5KNRwNeHzjw1TAtucsatZhNL0txbNjpgJNL1m7SZzX+i+IMJ8+vRE1
	 feUkoPxXGa48o4+1if/6YIZ0N3yzNsOjCkEirYfyX/hhTsgNmWJHQe8bcLvF9wpIJq
	 +EidXYaXyCVCytgN4BU8E6WInpAbY+tnGtVtrQes=
Subject: FAILED: patch "[PATCH] ALSA: hda: conexant: Remove mic bias threshold override" failed to apply to 6.1-stable tree
To: zhangheng@kylinos.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:47:02 +0200
Message-ID: <2026072002-drinkable-verbally-6958@gregkh>
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
git cherry-pick -x f52524da7084c1a54683ae9fbc73e93fff19dd64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072002-drinkable-verbally-6958@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f52524da7084c1a54683ae9fbc73e93fff19dd64 Mon Sep 17 00:00:00 2001
From: Zhang Heng <zhangheng@kylinos.cn>
Date: Mon, 13 Jul 2026 18:03:29 +0800
Subject: [PATCH] ALSA: hda: conexant: Remove mic bias threshold override

Remove the mic bias current comparator threshold override (NID 0x1c,
verb 0x320, value 0x010) from Conexant codec driver.

This override was originally intended to support volume up/down controls on
headsets with inline remote controls, but it causes microphone detection
failures on some headsets with impedance less than 1k ohm.

After consulting with the vendor's engineers, it was confirmed that this
setting is board-specific and should be handled by BIOS/firmware rather
than the generic codec driver, especially since inline remote support
is not currently implemented.

Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20260713100329.306892-1-zhangheng@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index 3d92262763f6..40da2832ba66 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -162,9 +162,6 @@ static void cx_fixup_headset_recog(struct hda_codec *codec)
 {
 	unsigned int mic_present;
 
-	/* fix some headset type recognize fail issue, such as EDIFIER headset */
-	/* set micbias output current comparator threshold from 66% to 55%. */
-	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
 	/* set OFF voltage for DFET from -1.2V to -0.8V, set headset micbias register
 	 * value adjustment trim from 2.2K ohms to 2.0K ohms.
 	 */

