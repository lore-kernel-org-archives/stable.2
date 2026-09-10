Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190C58B6B9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069365; cv=none; b=D3/99UTPf2hnAQmFo67+xCN1KVUN0sOjbpob11x+IKXWt1iE2pX/GCsOliF6t9CRAOdST+Fy48hAWlqKqfO7i95LwFTF7HXTDHt2yUUpFfKemyUGAcSmvgXVo7ZxKjGPnF5zidPjaE1FECCcRGeXvNWwf1BzAgQuZ+2TCZ8O5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069365; c=relaxed/simple;
	bh=YSZkbJp+i+2d//IROZJBvgVueydxROJVmcZcYepamEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fp4qC4mBqqXF0ztlcyxvHW9+UjwCVGnmn1WMpyBVdKqeckDqkqWBBFVcS8YHUY8nKoahOq2CiKrU2r9yjAYY+psd5a3dzlhHF/3jwpY9fJdBFifNQrped3I/sdEJczZ5uvDmQg6Tq6KbfjeoJgTgRNOrJBThenKY+Ov+FZZmjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNVdkr3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNVdkr3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0751F00893;
	Thu, 10 Sep 2026 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789069363;
	bh=XF3fWJpK3l7tgJC+E0ypvS4zVtTweuwsw0nzgYTGAqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fNVdkr3wPdEARj6cs8aujbelbzi81JsPjHaQbsBM46UIDzqN15APQpjynzP3aZHoX
	 1Wkah1z6Pz3ws1bX2zM+WtzlXsCMUZ0lPZabWWKUchmdS02j1PqP7B7yYMHglrPe2u
	 a3Uze8lXRD2d0xxiQcmD6bRHf0cImwpxOSidZW48WId7HABOwYJG8ynVa577pSZjFC
	 LhJ+86cshJEyyI7KLx2Z/ZkKXw3Aht03CheQizcBxQtQBCFIPfPz7gBpNUD9xB5Wmd
	 jqfL0CCzXGAVC4GHh73adg+SkRCOypQKcGXF+1iOem3epSa9SCEumXGaacPjr+Xpk+
	 HdCYk8JY2RGPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: HyeongJun An <sammiee5311@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
Date: Thu, 10 Sep 2026 15:42:40 -0400
Message-ID: <20260910194240.1586464-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910194240.1586464-1-sashal@kernel.org>
References: <2026090937-unscathed-albatross-6872@gregkh>
 <20260910194240.1586464-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HyeongJun An <sammiee5311@gmail.com>

[ Upstream commit f4a23e17d84fd2a152d9e12369761934e1af0ee8 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/rawmidi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 7accf9a1ddf4c..00243e52fae2d 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -777,7 +777,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 		substream->framing = framing;
 		substream->clock_type = clock_type;
 	}
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_input_params);
 
-- 
2.53.0

