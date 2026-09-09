Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B176233956
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947742; cv=none; b=CuQPqYsutQytMFg6/++pSUEN2pzdb4DVaAaKz0h48LnX3YZMcH3oO0xd+hDshZnMFQ/MRZzwA/O2nHhUhs9vtgL2OjHIkx/TLys6a5DFu7T59xclavCVqc5wMfUBc11oojTGtNC9ZdUUg428+oLXKFL1Du1s8lHUNNItcohtt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947742; c=relaxed/simple;
	bh=mdzChcb1N1WfEljUxx1IXU9QAM8fLA97nH+ue3XQ1ig=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QuibPFPl+Bd5aEKHUWqStDP96yA2iqEHpgI8KLg1AcGMT82BHw5s1p3L+DimHCGIDoq/b3yU8C5e1WMkSVyIpkjkOMGX3ZVdR+HxwmvQaTIQ+V9ZQioyuGIJmIBB41lwUmiuyPuQo5jId+9zBQYIuqcAfWXpx8vBpE6znaDOCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Quqr/3HP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Quqr/3HP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B021F00A3A;
	Wed,  9 Sep 2026 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947741;
	bh=MAvKuIGIunEWa3hX+DqSO4dkDmElWzDhnisW4oZL5cA=;
	h=Subject:To:Cc:From:Date;
	b=Quqr/3HPUh5zYEmBhHd2Fa/4Le0solSC5Dh5ao9KQc331DJMYEPQ7Gguipcpn5DHi
	 pGN115IPIwvEBr+t81m92awxqmPfnNnOuRExoVNSNRAKTzJb0kG8E9PYeg/pE90qt6
	 ygv088kyipJVCoxkR1O990oPUiqUPxxlQcMtDeks=
Subject: FAILED: patch "[PATCH] ALSA: rawmidi: Return the error from" failed to apply to 6.1-stable tree
To: sammiee5311@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:47:38 +0200
Message-ID: <2026090938-festival-dropbox-c7df@gregkh>
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
git cherry-pick -x f4a23e17d84fd2a152d9e12369761934e1af0ee8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090938-festival-dropbox-c7df@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

