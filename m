Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EB3D6CD3
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540854; cv=none; b=QZSM4M8VcRwldMuJQbIIE5LrByhNtFmWOd9Qm+iNIpn6oPbfeXpokv5c2Yu0NaWp5XzHirw6pasz5QeT4K3gFt4hnuwJZZM2VmwkkuToMnXCfrWnX3Ib3XLWjV/ZSnQHthJdVt7XUk5G6QQl+aM68k4cEG32ojlHMnSfdy+Z9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540854; c=relaxed/simple;
	bh=M79UiWMQRlPuOrOSBgjGSuCI2qJNCum+hS+HX9IumcQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HWafNEgRGup2AkeqLOshG3PGNQPeq0fMKzixOXGEoU96vs1b+s0B3pCZfxzTAU56vOCWjaHXCX6CPGb/LI9BqvYwyqESSwNMKlYZDdRcmLYwLkyLKBr9WI8LYfvwmHViR8ZXNcJTYN7GBeykOvBQ5P1FyPRBPVLZfmsf7vkpX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpAjSpDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpAjSpDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517DE1F000E9;
	Mon, 20 Jul 2026 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784540852;
	bh=rNw3bc3KqhS2SJR3s2ufS+hanWzLdu1MVAC1NwfupYM=;
	h=Subject:To:Cc:From:Date;
	b=xpAjSpDThEK/bGPGC6WGCyYeyZY/lNRYSEmsHNkUqNs1Gov7aESvgNZ52SVEmGZVI
	 ScGSiTxfimtYWcjXX+aSqBuvYtLX42rrJ4wv22Z68gylkVp7iMTYalFVknYxM3yTPc
	 0P8Wm7hPQGkpftoq1EYkYUJtk4A7hrsaaolWJDxw=
Subject: FAILED: patch "[PATCH] ALSA: hda: Fix cached processing coefficient verbs" failed to apply to 6.6-stable tree
To: raoxu@uniontech.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 11:47:11 +0200
Message-ID: <2026072011-pedigree-pebbly-e0e6@gregkh>
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
git cherry-pick -x f67be28fdf8b5d31ac1cc1152bb17250f9f8f513
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072011-pedigree-pebbly-e0e6@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f67be28fdf8b5d31ac1cc1152bb17250f9f8f513 Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Tue, 7 Jul 2026 21:24:19 +0800
Subject: [PATCH] ALSA: hda: Fix cached processing coefficient verbs

Intel HD Audio defines Coefficient Index and Processing Coefficient as
separate audio widget controls in the Audio Widget Verb Definitions:
Coefficient Index selects the coefficient slot, while Processing
Coefficient accesses the value at the selected slot.

hda_reg_read_coef() selects the slot with AC_VERB_SET_COEF_INDEX, but
then uses AC_VERB_GET_COEF_INDEX for the value read.  That reads back the
selected index instead of the coefficient value.  hda_reg_write_coef()
has the same issue and builds the value write from AC_VERB_GET_COEF_INDEX
instead of AC_VERB_SET_PROC_COEF.

This only affects the regmap coefficient cache path used by codecs that
set codec->cache_coef.  Direct coefficient helpers already use the normal
SET_COEF_INDEX followed by GET_PROC_COEF or SET_PROC_COEF sequence, which
is likely why this has not been noticed widely.

Use AC_VERB_GET_PROC_COEF for cached coefficient reads and
AC_VERB_SET_PROC_COEF for cached coefficient writes.

Fixes: 40ba66a702b8 ("ALSA: hda - Add cache support for COEF read/write")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/DB9023BF2920BA99+20260707132419.1731342-1-raoxu@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/core/regmap.c b/sound/hda/core/regmap.c
index e7b866fc52c1..d6eb17aa9e08 100644
--- a/sound/hda/core/regmap.c
+++ b/sound/hda/core/regmap.c
@@ -214,7 +214,7 @@ static int hda_reg_read_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8);
+	verb = (reg & ~0xfffff) | (AC_VERB_GET_PROC_COEF << 8);
 	return snd_hdac_exec_verb(codec, verb, 0, val);
 }
 
@@ -232,7 +232,7 @@ static int hda_reg_write_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8) |
+	verb = (reg & ~0xfffff) | (AC_VERB_SET_PROC_COEF << 8) |
 		(val & 0xffff);
 	return snd_hdac_exec_verb(codec, verb, 0, NULL);
 }

