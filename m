Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795063209;
	b=bbHS86xGtltPJAgq2Gn+nrzv4H7qgqC7TMtVLXTXicosPOode4fTbZFwPjLqHgYAbyen
	 h5tvro07VxaQTd9wRFOwcHx/J+hHTMii76NFr4DF6g1Xfj4L3tGUSObFGTfBwXGd+TPt/
	 xIyBaqs2N96tA90G1/QVmRFnXMowLMhDav4PK88xskGdXU+yIGCp07AmnNgkKkvkUQbvr
	 vqhxS0autTo+9ShTBzEWVQmqu3Q01oB1nH3APtjRMFAREOsDwGWpPMJ4805DgnhfooC5h
	 BLsNWIIxRlmJlUMZb0Annr7o9yeja80ZE4d02fzyaqknZpUEKzm2BCUweQtwOJeBjyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795063209;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=4oqpS4dQEE780ziYgVJrJjkAKFnJaNBh3UF7CqdybZ0=;
	b=2D4zFnhA9DfrAQX0pAzwLc2m9R/geBTeMQjQ9kr6C9Kay0V4tNTB6sypQ320065PeHsh
	 U4R7qJ/NGy0023QueyOZjouDoAG9Q0+Nn01tBXJZ0g1iuGULSgvUxu2OOjIPsRquvH3Ci
	 N0IXbw33Bz1fdFG/iD+OXHJOmNNrd5fwwxslUv3MpQBDGHQVvGY6pePGd4Lk2VpXbFh4i
	 MrEmelGgrPgnZr5Vv4PS+/Ngc0PSONpy05RgEQYZ9fL/EtVFHQCqbYIBe35+CESHHkFeL
	 WFR6B6e8EI/6nZpgQrVNQP+xqCHSwAi7pYZUInzR8XV4u6EOTM5ugeTiJAQJtyKjvUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3v+pohz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A3606A326;
	Thu, 19 Nov 2026 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3v+pohz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795063208;
	b=WYSTbAWURDXtAZCDlD+gRYO263pnQN2mx9A4vHlRl/NDjSF44Y3Uf9dYYdtnCsD0BqQ9
	 4DH8An2dIzjIci8peqyzpRS+UX/tgFrbZUGOhLo69PdY6MfNfvcxsO2YiRBZIFQd8iYS4
	 uJVUgPt3B28m+KRaq4vaOpstWvAOlhEvINjG/GBHvrBfwLY9Tn82zvJjihaCpDeqPRFK8
	 n+mhlE+qTN68fzoeCNXd2mGIIm38LvavuGpwmvc9zRtrypsbu5MS9l4XujN9BNcdmihOk
	 oMFOoFNsQ2naZJvgFQtlNHfraykkyqfDMqFO0BnwaAJpxMUKzwhYngzfUPneMiAMlIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795063208;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=4oqpS4dQEE780ziYgVJrJjkAKFnJaNBh3UF7CqdybZ0=;
	b=oqVzY/d5QmOnH2BwtaAwFDJkqXwJpJiaOsTbVOsrDDq5mp/V1Kmp7NZuqCNocMzgQG7g
	 MjBLkfw+3jDJNuJKEZQuQzNz07CWuKXXxZAfuOPkRZx4lX8q9jvdYppr3XBP65C0Etl3C
	 YqYi0UMCkY+GOt4QV2UQvz3MLG87WAqdGz9XuQdP6JHi78c6SDcQnB2w53SG0zdrgWvuC
	 fzs+XOA5v6R0wvxyHRvosfR0/Ie5H/j36uDGYH2ftmkGcCKZdk55dEtWvhP8X9Qu3KP/D
	 b71rqW50X6h9+FVxsgJy5Wn+xTkgHRaZ1Jhidd3f0mCCg9Y0IoQEBblfSV1XILIJJog==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9F6F11F000C4;
	Thu, 19 Nov 2026 04:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795063208;
	bh=4oqpS4dQEE780ziYgVJrJjkAKFnJaNBh3UF7CqdybZ0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=R3v+pohzN6ruJXzFzzbDhG2djn4aC6bfiACkiOCNzCC+Zkt/Z7BzFsOGySEbRy93q
	 HBG9kaqOYvl/0S4Bn0nk4tLZPmK3mATTvf/HBnTO3f5XkF+Vl4Z3UbzsScV3Yz1uwk
	 5ep9S5gmgYVGgGjBtvszByZeWR0o3rQeWHluRLMGzzvz0QlwAamlBbr4Db+aVpYRlN
	 9cPsar9EcShxcc/c3dj5gdVnhSLJrDGtg+mOUTNVlBstzhZ6uW0axI/6CTP5CQRBq/
	 ZJDSyRCQI6XskyM98Gm8Wfp3IJ56HbvOADHgrUvovUh5UPTjJDrA8EhsrfZVJJSxAH
	 AydKaEmlWZh6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3077E4B0E1;
	Thu, 19 Nov 2026 04:40:07 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] media: verisilicon: av1: Fix two reference reads
Date: Thu, 19 Nov 2026 04:40:06 +0000
Message-Id: <20261119-b4-vpu981-av1-refs-v2-0-7c270158b20e@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4V07Rim4WFd+R+GRWkHGCOPtNBoC
 P9uwbhzNTmTe+9ZhSfH5MU1WYWjwJ7HIYI8JcJ0emgJ2EYWMpUFImZQZxCmRV0QdEBw1HiwKkO
 lG5SUWhGLU/zy6xi9V1/2S/0gM+9Le6JjP4/ufVgD7rmfIP8niDcFU+RloUrMba1uba/5eTZjL
 6pt2z5VNL4FxgAAAA==
X-Change-ID: 20261114-b4-vpu981-av1-refs-d9419af12e0d
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795063206; l=1699;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=OVghNADDFQgyMPns3Y0DpyFYJj40oVDPUx76Vlxtv0A=;
 b=bFtv+bW9XyZ00rINk+J3aZT/SH6Had8LfW5wFMAjwS6QIWZefb+9/8hgEOR1TynoMecwnrsYr
 iHsBWdV+KIxAxtTutwPnrz6g2MyLwCWzDtCTQLrxi9nOROoipO5G147
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The RK3588 AV1 decoder (VPU981) can read a CAPTURE buffer freed with
VIDIOC_REMOVE_BUFS (patch 1), and reads the segmentation map past the
end of a smaller reference after a switch to a larger CAPTURE format
(patch 2).

Found by code review. Tested on an Orange Pi 5 (RK3588S, 7.3-based
kernel with KASAN): AV1 resolution-change streams (sizeup, sizedown,
svc-L2T1) and 203 AV1 conformance streams decode bit-exact;
with a reference buffer removed, or replaced by a smaller one, the
current buffer is used and the segmentation map is skipped; a map in a
smaller buffer is read at its own offset.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

---
Changes in v2:
- 1/2: Also fall back when the reference buffer holds a frame of another
  size; set the CAPTURE buffer up before the references; drop
  current_frame_index (Sashiko). Reviewed-by dropped, the patch changed.
- 2/2: Use the buffer checked in 1/2.
- Link to v1: https://patch.msgid.link/20261115-b4-vpu981-av1-refs-v1-0-c65769715db9@gmail.com

---
Arun Iyengar (2):
      media: verisilicon: av1: Find the reference buffers by timestamp
      media: verisilicon: av1: Read the segmentation map at the reference's offset

 drivers/media/platform/verisilicon/hantro.h        |  2 +
 drivers/media/platform/verisilicon/hantro_hw.h     |  3 -
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c       | 79 ++++++++++++++--------
 3 files changed, 54 insertions(+), 30 deletions(-)
---
base-commit: aa0f4c41d4870a18e65772a1817af16427200371
change-id: 20261114-b4-vpu981-av1-refs-d9419af12e0d

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


