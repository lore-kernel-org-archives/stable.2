Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4626982C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085749; cv=none; b=jmd2SZNaX6tIRBzp3lTmR0uviWJVjZQX8vUPjf16xryMGZaWUCQY1iV2Uqz8y85qbYZAmljIJ7j7czKoAjheeiKyfRs3aLaimE3gqVZy2WmTA1xq8w588q1pVUYO/dsfyMwE+rngcwrSUji+QEXxRQoxkPEs9vzBJKWX6pz6eOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085749; c=relaxed/simple;
	bh=mZ57fwrTU5gB/UfrigbZzx6iae4g+5f4Hoh1DfUP1eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1zfhNDLjFmRw3fyk6KFmWUw+B0H8osZJyZ/d4I0dkGMB/pVQcLRYBSNb5zzj7YzWhtL3QYrTebt85qvFqpom71Cox4mOthe49ft8QYqMluvLWWtOUMR8mkPRx0avr65NjAzuC2HtqfWp2rE1WaldUZh6XU/5MCcgAejZl9yfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjEW7Klg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjEW7Klg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B8E1F00899;
	Fri, 11 Sep 2026 00:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085747;
	bh=VTEs3BnzvbdNR25FIlPRse4SZ71vWAqRBjj6Mv0IrWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DjEW7KlgORRW8gIs5gRZmUH0S/yWvkKon+zxT7r+jmEvaH0UJh4Yw3uu9dIT1y1me
	 EX9+iKElYcdak8ByETrz31/5RkyAKyKks+Gm8IS69JCR4qk6BEEsbtefxnDZw+gVVK
	 +b17pYiYWRkb31/n/GCA2vbPiLqXioI6SJNJy/1ASW+6KHp3WCJb/4V4kLOPR80MGj
	 0bbWGUilfA3QDWdiWF7wPIcL1ylK4syPPHKtn+BgYCbBPABGImv62CGc3pZuC1Tr3D
	 A7kCDFjVyuHZrLMkInzkjPZJTwvyIDm3jNJWDMTbkKEuL/AuMgonxJpOHjCTmL+iwF
	 E43gtTh6LBvbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: HyeongJun An <sammiee5311@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: rawmidi: Return the error from snd_rawmidi_input_params()
Date: Thu, 10 Sep 2026 20:15:45 -0400
Message-ID: <20260911001545.3304069-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090938-festival-dropbox-c7df@gregkh>
References: <2026090938-festival-dropbox-c7df@gregkh>
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
index d8edb60550724..a1c4e280e7894 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -793,7 +793,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 		substream->clock_type = clock_type;
 	}
 	mutex_unlock(&substream->rmidi->open_mutex);
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_input_params);
 
-- 
2.53.0

