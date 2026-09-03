Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1114E3EDB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450005; cv=none; b=ugkODMKIAYitkkt+rw5vNeBULa8FfiRuiBMM+YJzrT+sCGPboSfkUAo4tQJqpipCEtdLta/oOG2eKs/Pbgph27wpvVKeK1kbsxk2dD2o23ILfsYZjHEaicEQFmkpYe9qI6390MWlX+9Aqv8HVaaLsVA26qUvKWyWAfTGV6laTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450005; c=relaxed/simple;
	bh=6qHZuaDWS3519uft9bQXuJu3fan/6NBlRI8736PsPSg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iCoQ6Gd/Q8gprA96vqHsqtZyMdYz8/5HU85FgV942YmxEUoUd5hJHdRGjBYbQJmwUN8XI+jT4N4rcHGyrgVZ+42h96M55PaW7bm/AR5ziOF1R9TJU4OkjvMMxLgabWpf695z/CFDOYw6QgIGWo3LjDAfW2jb6JBc74MJEgPeS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1uloCwfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1uloCwfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CD31F000E9;
	Thu,  3 Sep 2026 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788450004;
	bh=ElGpPiOl9sSJI9UMfMKTzk13dCn0HdrPSd78Tq/2hs4=;
	h=Subject:To:Cc:From:Date;
	b=1uloCwfjsA96WmXWpog9GonlwiwaWyWO1Ji2fSDBbhJD+3jAzc1YnOD5sByIFSSi3
	 gCmY7cv9RWZ4xmN0bLSmDrqxn1Z5xJv0Rhj76tIv8kDYRmBoHI2rQEDwpOqZnCm/bJ
	 sbLj4FVgM0eBGLiyHXQRheEoTwrq6wNZWmOgJDdc=
Subject: FAILED: patch "[PATCH] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset" failed to apply to 6.1-stable tree
To: raoxu@uniontech.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:13:44 +0200
Message-ID: <2026090344-passenger-submersed-9dfe@gregkh>
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
git cherry-pick -x 36aa66de481d29edd63cbad9b5c4dc18c340fdf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090344-passenger-submersed-9dfe@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36aa66de481d29edd63cbad9b5c4dc18c340fdf6 Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Thu, 13 Aug 2026 14:55:24 +0800
Subject: [PATCH] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset

snd_hdac_ext_stream_reset() polls PPLCCTL for STRST by masking the
register value with AZX_PPLCCTL_STRST:

	val = readl(...) & AZX_PPLCCTL_STRST;

The same masked value is then used when clearing STRST. Since val
contains no bits other than STRST, clearing STRST from it always
produces zero. The subsequent writel() therefore writes zero to the
entire PPLCCTL register instead of clearing only the reset bit.

PPLCCTL contains other stream control fields, including the stream tag
in AZX_PPLCCTL_STRM_MASK. Those fields must not be modified as a side
effect of clearing stream reset.

Use snd_hdac_updatel() to clear STRST, matching the existing set-reset
path and preserving all unrelated PPLCCTL bits.

Fixes: df203a4e46f4 ("ALSA: hdac_ext: add extended stream capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/43BB7930B0F07C09+20260813065524.1955696-1-raoxu@uniontech.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/core/ext/stream.c b/sound/hda/core/ext/stream.c
index 4c7506d49f55..517bd151fcc3 100644
--- a/sound/hda/core/ext/stream.c
+++ b/sound/hda/core/ext/stream.c
@@ -210,8 +210,8 @@ void snd_hdac_ext_stream_reset(struct hdac_ext_stream *hext_stream)
 			break;
 		udelay(3);
 	} while (--timeout);
-	val &= ~AZX_PPLCCTL_STRST;
-	writel(val, hext_stream->pplc_addr + AZX_REG_PPLCCTL);
+	snd_hdac_updatel(hext_stream->pplc_addr, AZX_REG_PPLCCTL,
+			 AZX_PPLCCTL_STRST, 0);
 	udelay(3);
 
 	timeout = 50;

