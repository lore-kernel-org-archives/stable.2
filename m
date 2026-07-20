Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D33D5C2A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540842; cv=none; b=E/akRDwKgDHNlMVFiYTbvI053UMIZSE7zdchdj6IT//C47EHWEHaC+ue4uYTTdhBTN7y2aqAi4/Rux3AdqIztmLfi3Eh1DMLqfGSsQ4G6QeFZyIs6ZeCG7p4J8Cwk1Ggm7EzzC0LXmhlV/vYEuRJZ5j05NsRMONohB2Zu477I1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540842; c=relaxed/simple;
	bh=qXwBxiQPSnqzk59DI7K09jzJ9Kius58+NMxio8QZDZ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=noOGc8whswUiLVaYeK2aFgXGDQiHNvql2Rg7IQVmlgcqk9VrYbc1C9ASuTY/G4gSqKyNW7xCdQVJ5Vn1yFmJPi3M1mmb72BxouteyVc0OMjlv6UeSAg9JJwnSwF9HNgXxWKQVMIVzYGO+rKSyGjBDB/HoNa6EKZeCY7fcb2b2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0etouWGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0etouWGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B913B1F000E9;
	Mon, 20 Jul 2026 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784540839;
	bh=5bpotKoF2yD3gp+nivY4K1ppZZbAD7giC0i8l+pQHqI=;
	h=Subject:To:Cc:From:Date;
	b=0etouWGE+pJaGjuaX52On2vdA0o3g1/G3uEg5wkvrEsare93pcA2q2kGBX85Qy/oI
	 dNPR7O8WQKx4YGVVadFYP2g4u+yQJQDZxL0J74LrbcKuAc8itY2q8isiL6WC6AMnQH
	 8Gg1R+gsHPCu+fW1oqE9E5cHw8aXr4opd4sFOeC8=
Subject: FAILED: patch "[PATCH] ALSA: hda: conexant: Remove mic bias threshold override" failed to apply to 6.6-stable tree
To: zhangheng@kylinos.cn,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:47:02 +0200
Message-ID: <2026072002-coping-spinning-bac5@gregkh>
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
git cherry-pick -x f52524da7084c1a54683ae9fbc73e93fff19dd64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072002-coping-spinning-bac5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

