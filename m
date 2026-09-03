Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DE4E56E7
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450014; cv=none; b=A/IxHLvMBPuQpmL2C6QONoNSnvkHtAH7OksMbUVrva9GgqDsP0B0lxjW/e4sZXU51fCXTZI5Zyvf3v4h96B62S7onVK8tsRpgqHQFHN9wdeG2hcanH3GweL2FlDftw0qmOeKGSG6zEVHrgdkJGhxP0Hh9SjZTL8aAGRMxmR1158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450014; c=relaxed/simple;
	bh=QHwSfXZk3IaJ672/LtToAtWdRVd+ITtR7fghu9E5YZk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hgQD3/4RvYYoMwG5hQdibAD/yvIwnwwocOpqpVfsi92JaYfsMBfZQLSI3vaUV89F4O3+ZSJoMglvns3fg4U+woVZUTlKl/qgzwUrMmp2kKMQr6EZABAI6edr2HVXApHG6jmPpN6Rt1tmCLYZNmFWBiJ1WM/p8l8n+/zqt7ZnaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=en4+npAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="en4+npAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB1A1F00A3A;
	Thu,  3 Sep 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788450012;
	bh=G8zHSGI66G13Mm0txUE14ht0QzxkVEHAEuPpmvZqoXo=;
	h=Subject:To:Cc:From:Date;
	b=en4+npAmq1fmizGjyr6gvKa2+nhh3HXCuFg/Ftq+NswKYsHdqHZhrxOYiI+ASsCtz
	 3QiXQjpVCMluZYauHNej7pimA5EQy77sPwfplUk8jPqvJYf+aKu0rAvIBYQLkipHyG
	 18H4J8qjzqDoKJoHSwYOWMlbIYhlZ9wBbcIyA7SI=
Subject: FAILED: patch "[PATCH] ALSA: hda/ext: preserve PPLCCTL bits when clearing reset" failed to apply to 5.10-stable tree
To: raoxu@uniontech.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:13:45 +0200
Message-ID: <2026090345-hangnail-getup-f661@gregkh>
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
git cherry-pick -x 36aa66de481d29edd63cbad9b5c4dc18c340fdf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090345-hangnail-getup-f661@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

