Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794394462;
	b=x5BTiP7fbu+87h29tCNTOItW1uhiVH2sRtr5RxGGTZZL1IxuABH9zXTUvuH47vkeEE6J
	 u+2KAckZ7zzgTaqKYge4zUqtXp0FMIxQz7qnc+3D8Z0P07eGYfVUHZS0uQ10dJjppsaKD
	 IeyoN+B0PEV47i6puTCIUWf6BarWn8poDHwp/Vs5hirpgG5FLRMTwFziqytHCMNHohRtV
	 AhMd1mhE67ADrPTH2DGlKdf/weD7O71ioO43/pyAa/cno0w4vXJp80Nhv/+qViy1uEp81
	 fp95VWaZyuTSyGLXNOshcqV87/SO4KYvuqguFSuyvfgFidE8HsZh1FyLfMaU5LR6jyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394462;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ovOSCTXiugxe7VtGCTb3pycG8k5BGyfi+pMJcRVL4/w=;
	b=wM6UfSjOd4RFn3GYqL8Z4TN9UX/GUgxw3tPH+tRJqI9QttkXM7mC14IBko57wwdqyttU
	 i1TmGYE4LHK02s+RoNHW+qAu5nH1e+KZaRqf/caAJVSzUCCNi/BT7rz3a+gspihK3L+g/
	 nLNc9lnRaOPwUNPm0ZvHAu+stO6zKKz+rtPl9oYsVkwJ8wsU/vLdfGHyk0mKdTHwzuHx2
	 pGUenhaU0fQscEOYTqKUk0d5VevB4uOuEiogk9E6QlB7hu9IMefH4Gv9tDqzX2mzZcqe8
	 OlyCMsxM5uC2sGgfGq2QK4d/U/k9OKaMx9HOgz/8D8ZRlwLwNr8gpKt/VXZ2HMKZC5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9E77TFQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E05606A31C;
	Wed, 11 Nov 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9E77TFQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794394461;
	b=eqGKRQfk9pBCu2Q2BGnngtBSP3YLsebGX08yo7BaPRlm6NSXasuBKzlJnW95Ln05Embz
	 oPNX0H2+TNIJv+axd0uaI/hG+7qJIxjIe/s4Lespash9OchuQjDsemLwL8v4vcOkNDiUA
	 BwIaAdVuHrFNsoaO5WEGUrZ2O3Z7lL+1DjHbcudIAgf9ozMa+3/XyQ5IZJ4yi4AdxuIuJ
	 YlMnTSH9zWiLNls9cSKwgwtsG/u8lSY742a1GEc7V+bFCHpn3IDuTh0X5pHgtfMwxdXbS
	 Dy07sijLQAe3V6DYHODF3NN13+jRy9Vw+bcPh+oQboQs1/1irD7ggqYufIGVYvcsm9Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394461;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ovOSCTXiugxe7VtGCTb3pycG8k5BGyfi+pMJcRVL4/w=;
	b=X91MsWfoJJ6jNKndScU5CoPjuya0/QYnIhirV6kMGrUNhVnavxTEIK9P326sznDSNOmI
	 Qoza/MPjGMKE4WFRw9pGNlEuvUXIJ7IpydG9glWNsUaXCNyi3sAw5HOFvEIa05eAwoXM0
	 FyoKABQN9Aw5Tci4XYTPMXsErAdf08H7W+heUQWMz/hbXboeufVR4TYBhkeANrBtMzMEY
	 fi193wuWvWxFiSHk4F/C2NBVtlbs2UWOei8mw84dV45oWWoYl+3zJWPKfF2rfhbMxTA2b
	 mdmZT6L0k5IUIYgEiNm2j4AoRst3eGimE/uEixeunrsGHtDas1c47pJ8Z2V7J0aNbjg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5C2B51F00A05;
	Wed, 11 Nov 2026 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394461;
	bh=ovOSCTXiugxe7VtGCTb3pycG8k5BGyfi+pMJcRVL4/w=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=G9E77TFQYxWena4eH1wmiinX0ImnsRONBFjIFESJDeTYGHAXBxHuGfPUpngzlAbXg
	 wIU6NTrqldrAonMf+gfOkOdk6CPaOMO77Lk0MDqR1CWvpCA0ASyy821AJBkT5tBhZ5
	 QDkLdb2nvtcexSV0Bj9X+QjWUCrbdH98Pa4H8VbQZGzxG4MdDdrqfDdDuSmTmiN4bF
	 vbLw9LElB08/VC8Rx9y2Gx8Ag3i+H4DuImNGVC5besjt4nohth1zMccSLOfaSqD/qZ
	 MqkFo4rw8yTghbidDEr7avEvY+4qOkCYhFXqNQswVrbwGNRBp2X508rsJgrzhBfMUn
	 X5N43u4b2gOvA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DD5D948F4F;
	Wed, 11 Nov 2026 10:54:20 +0000 (UTC)
From: Marc Herrero via B4 Relay <devnull+marcht.proton.me@kernel.org>
Subject: [PATCH 0/2] ASoC: qcom: audioreach: fix S24_LE playback and route
 mixer disconnects
Date: Wed, 11 Nov 2026 10:54:16 +0000
Message-Id: <20261111-q6apm-fixes-v1-0-1beb5702b372@proton.me>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LMQqAMAwAv1IyWzAZOvgVcWht1AzW2oIIpX83e
 NtxXIPKRbjCZBoUfqTKlVRwMLAePu1sJaoDjeRQsbfz+bSbvFwtYQwYAkXnEfTIhf+gw7z0/gG
 JQE3KXQAAAA==
X-Change-ID: 20261111-q6apm-fixes-21db1bb2d6a1
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Herrero <marcht@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794394460; l=1262;
 i=marcht@proton.me; s=20261111; h=from:subject:message-id;
 bh=oDandKZoj9aKJ9LxqOQ1TuaE8cLg2Oz+Q5oKITxptrs=;
 b=MLo4KyG596+Yj2uFfnkjg1GFNX1GeimwQGRcyl7E6gfpjgjkPvfkWK6SeMJ9/D4dwakUg6TFF
 g3xmL0H/JGJD9ssPofWc08VVZD6zUApR1fXU3kL9aRHxtyPeGsFMiZv
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
Marc Herrero (2):
      ASoC: qcom: audioreach: use a 32-bit container for S24_LE PCM
      ASoC: qcom: audioreach: only disconnect the route a mixer control owns

 sound/soc/qcom/qdsp6/audioreach.c | 4 ++--
 sound/soc/qcom/qdsp6/topology.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: cde5523c75f1320a55ac1d55a717ccbb566557f0
change-id: 20261111-q6apm-fixes-21db1bb2d6a1

Best regards,
-- 
Marc Herrero <marcht@proton.me>


