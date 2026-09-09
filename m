Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17A48F85B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947739; cv=none; b=orPQyKr+jBQhE1xGyV40D4hLRf1d+8ZsVYXLDP+xPWnX6PU7YCihTgVf2fNAva8a4aJyRwEG+xPhp0JKjZ6f3Aq97V4vSPDkXLSGcnYfJnVqooNqhwCRxAtJslZVepFN8LtCmIpop0GGcgFItszK6ekQWDK3NOkZwyZ9E7kb3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947739; c=relaxed/simple;
	bh=JW334+8b8oyhqiZnhZwFiHNZBf1YDajsY8K5w+jcLLE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sGO/k3+9GNomdYwatQ9gAat3KcBi8/8vnAy9xwGYHgyAeo/7Y1JvUuvtfrzsqROdnj11hc0YBaFJjKDYSaHplfxKUvJ03y8Nf5X0utrjHfREbPgAUNNpg2iGmCbOQmmKrxkaMdTOGQ31PYxXs4Gg2QNlFA5nwBmdFqZ/YuNtgc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GUjRPwa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GUjRPwa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1FB1F00A3A;
	Wed,  9 Sep 2026 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947738;
	bh=UjnhLQxAiXlLIkhZ69RorpUNWEe4GXg2EDgNQMx4aLo=;
	h=Subject:To:Cc:From:Date;
	b=GUjRPwa9TSu00rwU3H4sSjWnwWXc1YP0V0ccQDsk8bhGDZb22XVBMSLD8oBsdAbNi
	 QDRKVqb1vPElQ+xTFtZjY5VWrz5/Em9ra4NKxk6qXL6irY6U9Y66tbrzyXD34zqXxU
	 hqaFRqgpGITggg08geggt7KuFb6RQo7CXSXL5qWQ=
Subject: FAILED: patch "[PATCH] ALSA: rawmidi: Return the error from" failed to apply to 6.6-stable tree
To: sammiee5311@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:47:37 +0200
Message-ID: <2026090937-unscathed-albatross-6872@gregkh>
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
git cherry-pick -x f4a23e17d84fd2a152d9e12369761934e1af0ee8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090937-unscathed-albatross-6872@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f4a23e17d84fd2a152d9e12369761934e1af0ee8 Mon Sep 17 00:00:00 2001
From: HyeongJun An <sammiee5311@gmail.com>
Date: Wed, 2 Sep 2026 21:50:58 +0900
Subject: [PATCH] ALSA: rawmidi: Return the error from
 snd_rawmidi_input_params()

The snd_rawmidi_input_params() computes err for the three invalid mode
combinations and for resize_runtime_buffer(), applies the new framing
and clock type only when err is zero, and then returns 0 anyway.  A
caller that asked for parameters the kernel rejected is told the change
succeeded, and the substream keeps its old buffer.

The open_mutex conversion turned the early returns into assignments.
It handled the output sibling correctly, which still returns err, and
left this one behind.

Fixes: 94b98194b62e ("ALSA: rawmidi: Take open_mutex around parameter changes")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Link: https://patch.msgid.link/20260902125058.19499-1-sammiee5311@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 34b4c7d6dbe6..2617bb5b4faf 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -785,7 +785,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 		substream->framing = framing;
 		substream->clock_type = clock_type;
 	}
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_input_params);
 

