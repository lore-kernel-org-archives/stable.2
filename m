Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD194380FD6
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609164; cv=none; b=Ba5c1X5SbXT1D4z5RJetbidlvBvjkj5L20snh1J2ygntI/eaPP5C2nXBjiKYUyAWnlPNRo/npKn6/U9aZxApW1FO3otyp/Gee/ruJ2PdrckirZ3Jf2V0HKbVTmYgdhGyhINL/tuG99wbzjbPoA8bt+qiRbk6Bez+sEnCOyAxzQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609164; c=relaxed/simple;
	bh=dcz4je6cYiWPoImvv92Je/jtWJq/8GhnoQPU4iiC4xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqIpCE1OJ7mfw4Mo42ktiWANdOpbmq2jOfn6QclBFfGvrmdDm1G+aYTJiocXLl8K0mPM3U8C3KajnlaFI+K1evJVlfEFdCgVMuIeFX6GuMbK805DOUj3czr/cXFxg00uu1czWRtM8COWVxf1tj9BskuIovLFr9/UqGYG+zwV+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmQVu3/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmQVu3/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9851F00A3A;
	Mon, 24 Aug 2026 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609163;
	bh=ZgPNNQthV0HNknDEnHdQbaAfG/LG0EwxmQ33jOU1oZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BmQVu3/7KdHcB8JvNWA5F7rqN9pAwFX3Fr3AukIAxmmMxfzrLiFP6IrH+zXvTqVto
	 pIUJlZbLpDHt3/UcsfW5czxaBr9+wM93sdzssLtdUdsBzkROc9Q/Yo3UNK2QDjbkxd
	 cI06VJmcYWpbkxyU0EZ9lMcccOXhm5dBnlqbl8hDPrgZBnMSSxgXPQkIQQUfmtWVVe
	 vPfot8WiashgU4SrYETTa8X/p4PW3EJEKN5RWXxPs0Ia3xD7Ffpad68q4LwRQ04fE3
	 wXt96oc11X6QZijbxneIXrHCr4yevPG6vwE0j+wCSkQq/usss2mrVyKRhmgW5t3fAK
	 3z2ZjAlXslEzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] ASoC: sof: pcm: use snd_pcm_direction_name()
Date: Mon, 24 Aug 2026 18:05:57 -0400
Message-ID: <20260824220601.440874-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082057-slush-president-f8ca@gregkh>
References: <2026082057-slush-president-f8ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit cda4aa0069b73e3404ee61864b4814ccc7b7a6ad ]

We already have snd_pcm_direction_name(). Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://patch.msgid.link/87mslzk51h.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 17661c67b206 ("ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 7a8eebb078e83..bc32324748a18 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -100,7 +100,7 @@ sof_pcm_setup_connected_widgets(struct snd_sof_dev *sdev, struct snd_soc_pcm_run
 							     dpcm_end_walk_at_be);
 		if (ret < 0) {
 			dev_err(sdev->dev, "error: dai %s has no valid %s path\n", dai->name,
-				dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");
+				snd_pcm_direction_name(dir));
 			return ret;
 		}
 
-- 
2.53.0

