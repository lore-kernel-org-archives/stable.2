Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794860182;
	b=wt56meYhfyDujHmTYIORvIJPRvOZc4Y753M6I9oRyOsHtkCl74Mt8fjMt6jb8VMYYz3u
	 wulAYSXjNwjiXWdjD6Udq/mSCbYjHSDb5nZG16Ie63u7EngDtdkreW0hEN0nXGxJ32aLJ
	 U/WIu78ENXzK2AokZH0mr2DZD8mBQ7iI0NSZAPkN9IgLXt59sKir5YIdJ53dl7NEacfXc
	 9lWYBeZ6n9lD7ES62+Lamyv46rh9w4JmXWrIQOP8LfcbYkQkJdiyrKmE5GRtHgnGfxrXv
	 JUx7nCLqKirCZ0bgNpnaRwV9i/Vlun90+BSzVfUZDRE4Oqy1lMDpJsvS9RqqsZm7UKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860182;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=R/V2B9ksNyT9kQm2jLqpoypC8bz78+PhZsW8jSiYt5I=;
	b=YrS4e3wCnxoNlAstca/BnVOxoSCvPpeqxzC8JGkHxP15wx7CpNNCWqgZ/z976Ncu4iJP
	 O++IQxbtcLiAkuTl0gEf+s2SaNKSnbNenF+yM1zpoD1TkKrI44d7IwlPL5a6UOtcuC0e0
	 fShkxrINaunqmeDvWq67MutFM+GXixrfcUMoguEn+jzubNSwyLW1RVkMCgUxz81zjICGF
	 bjofhAEw/NNy9zjAmxMdmqw1nh6FyMwAX6nEf3CWQpn+jRtTM8Fyq1WNAARlgcHcNGseZ
	 qQGEfJXC2Qq/nP+6vI/9MUUeXvgCS0rTqxqyt+W0muONPE5ctyxs8BO75K9WRF2zU0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1lFsOIN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CF606A31C;
	Mon, 16 Nov 2026 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1lFsOIN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794860181;
	b=tf7UMgHidrd3OvsPgu57/BoqFodehUW9exIRaVpoqfpa3heIQ2j/yOo4h8jIyYZwo2Em
	 OzoKfhJijsQVo6tp7JS6iAp8p5N9g82zS1eG2QlAn7Um8BybGj/5zOBnj9g7RfSh07gUY
	 1VypzSUKTiBLgSe1KiR5FNGCzuZdSmqj5syj7OLmSflhTa0T5fYgLQFuTCdVyY/ad/dma
	 TCNlRBX/+1A5wDdt+OgUVy+VAlFYPIJLLSgVXTQGSRfqOwtGsbO10VOUqzz6Gv0QrtJqZ
	 IBbCcyrnBjNzXqj9DV9AvnSJO+oVIEhq5m0ecwBBEupd6FjhPNhw+3TVvq4/RB3uCwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860181;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=R/V2B9ksNyT9kQm2jLqpoypC8bz78+PhZsW8jSiYt5I=;
	b=amUWmqbFQNHoJmyO14NjZ5ZPjHHGxFvEMcqC7S/vtV+o63SjB+kVXa1g0cTZAsjAqXgh
	 UjpkcMIC0aw5Q2yg28EWDivmyyvXJUtfz3vFmwMFqLKXmhZXvEWgOxUCgPD6XQGOFxRoR
	 8iOjybHbY1KD0+3YlymC5hTSlgeiyVqhIN0vRQal6s6FGoSXlxU9AqAvfAt5S29JfSljm
	 V7fyze8efoK7RFcJ1BUlLTYr6CaYBp3yaQQnK64HwcH0kasWJwwzdZtXZs3lulECn/uAr
	 tr+XTTPGfb8qOVlj0nGRmUzgEmeyitfs6IjWAYwN6Zda7qiFJmv546Ufxlpr8wVVtrg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4C0F71F000C4;
	Mon, 16 Nov 2026 20:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794860181;
	bh=R/V2B9ksNyT9kQm2jLqpoypC8bz78+PhZsW8jSiYt5I=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=M1lFsOINEl7KGIOvu0aRP2SguQe1lGRUvQTc7e9NYo8dCC3rnZW1tAyK4ftCGmKyn
	 JoBpqKMO3GfL2MDVHiDOyJpz56HIclYVNQuE+Sl9IURsDwEjCzcL7SLcDesPqKMsy4
	 8/8Q5P2zkGEGFZauOKQ6Yy7afMR563+PwWR5NJjRaamlKr1WGHYfsRAnA84cibx5/b
	 6rqxH322srJnYr3Rijt2wQWXapEFKzGJM0dmQN/y0FkQJKCFNGok4JiqxdZ7C1kNNf
	 4uz/RpCiEFlLMlysIxXH9j2Jcpei/4v26i1ytmObg+CBi+wZbgsXyhdv5n2xCxs8Rw
	 u4sDVsNFFc6gA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9995E4A5CD;
	Mon, 16 Nov 2026 20:16:20 +0000 (UTC)
From: Marc Herrero via B4 Relay <devnull+marcht.proton.me@kernel.org>
Subject: [PATCH v2 0/2] ASoC: qcom: audioreach: fix S24_LE playback and
 route mixer disconnects
Date: Mon, 16 Nov 2026 20:16:19 +0000
Message-Id: <20261116-q6apm-fixes-v2-0-ea89fb43316a@proton.me>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MwQ7CIBBEf6XZsxh2jTTx5H+YHlhZLYcCQkM0D
 f8u9uzc3kzebFAkeylwGTbIUn3xMXSgwwD32YanKO86A2ky2KNexqZFPfxbiiJ0jMzkjEXoRsq
 yD124TZ1nX9aYP/t5xV/7/6ei0gpZ+Dxq4tNI15TjGsNxEZhaa197p5KYpgAAAA==
X-Change-ID: 20261111-q6apm-fixes-21db1bb2d6a1
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 Marc Herrero <marcht@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794860180; l=1752;
 i=marcht@proton.me; s=20261111; h=from:subject:message-id;
 bh=gBvXPz/uO6Ui2hKJhCwlBxzxOFCbiLFJ7wMH5a0P35E=;
 b=o38zijKvCV/AHQU0xKqA7uJeKbRgtZqEhCGxF/hB322cob+JxhIaI9azUbLCiC7tj3A1cUEm4
 cBywMox1g1VBoOg0LNQrS9Jqg3Z3LldZ0JdMOgwYE0/fQDNs7K5v2iD
X-Developer-Key: i=marcht@proton.me; a=ed25519;
 pk=pIPy6L+INgiuJt7L7umVilPgpzy/Ni3QS77ToLj/H9c=
X-Endpoint-Received: by B4 Relay for marcht@proton.me/20261111 with
 auth_id=1490
X-Original-From: Marc Herrero <marcht@proton.me>
Reply-To: marcht@proton.me

Two AudioReach fixes found while bringing up 24-bit headphone playback
on the Radxa Dragon Q6A (QCS6490, sc8280xp machine driver, WCD9385).

Patch 1: S24_LE was described to the DSP as packed 3-byte samples, so
the ADSP audio_process crashed as soon as an S24_LE stream started.
Using the 32-bit container size makes S24_LE work.

Patch 2: writing 0 to any "<BE> Audio Mixer <FE>" route control cleared
the back end's link even if it belonged to another front end. As a
result alsactl restore lost DisplayPort on every boot, and the board's
UCM HDMI sequence disconnected the headphones (the PCM then stalls with
hw_ptr stuck at 0).

Both were tested on 7.2.9 with the board's topology changed to allow
S24_LE on MultiMedia1, and both apply to and build on asoc/for-next.

---
Changes in v2:
- Patch 1: add a comment on bit_width (valid bits) vs bits_per_sample
  (container size) (Srini). Pick up Reviewed-by.
- Patch 2: move the ownership check into audioreach_connect_sub_graphs()
  and keep updating the DAPM mixer state on every write (Srini, Mark).
  This also fixes a stale DAPM path when switching front ends, reported
  by the Sashiko review.
- Link to v1: https://lore.kernel.org/r/20261111-q6apm-fixes-v1-0-1beb5702b372@proton.me

---
Marc Herrero (2):
      ASoC: qcom: audioreach: use a 32-bit container for S24_LE PCM
      ASoC: qcom: audioreach: only disconnect the route a mixer control owns

 sound/soc/qcom/qdsp6/audioreach.c | 10 ++++++++--
 sound/soc/qcom/qdsp6/topology.c   |  4 +++-
 2 files changed, 11 insertions(+), 3 deletions(-)
---
base-commit: cde5523c75f1320a55ac1d55a717ccbb566557f0
change-id: 20261111-q6apm-fixes-21db1bb2d6a1

Best regards,
-- 
Marc Herrero <marcht@proton.me>


