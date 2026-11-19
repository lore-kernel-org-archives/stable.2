Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069208;
	b=PcUeEmA+oYMt0SGo1F0+BCrjwGyMrVGGB0VcYfkhMD1Ea9g+o/Jo8g6m8neHrluaQE2g
	 hb088p7NiBi/U52V8rSOmqaDFZ8MXZTyAS9ptfubLJW+9Kvcs5yLcZr0NtC31fDOmsALF
	 ZeMRzckD5a/xwu/R07kFkZPjXAGqwCzRHdGRQtK+nHuOd1FlkPFPTX2KcvOUe7QllEUFe
	 3ZTffQXv1zBWXFG7v9PCBJxdg7RHCAB+cX5yVRtF4QzUoVOAqwMWJnimX4uDlSFXqknk8
	 vkN4iQNK40FSx034FtXPkOLR9WA+mbiS0c0wbNzlnL8IjHaylDyAhE0QqoaI8redExA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069208;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=P51zQnnlFN29NM1R8E8OMTMjHLC0aAOfMUy/UOhFuHY=;
	b=fxPhhsXHBby+U06wY864B3bk5RKdNOt117Sm/aNc1Z3PJCKBlAa0FlRHCyRBZhL1v9+M
	 rwqhWh+eLBfLrr0YHGNqF6HWudd+IarMvh45TWq41lJhxCgJkZ5/7R7bn8hgQfZ+Z13kq
	 cPo51G3GUf6p8T/5pqpAdt9GByl83cV/Q8abkdYX4/79Xvv5p44XUxtwLOfNrTGFLLksU
	 r+qRI5nVugspEMHO+NxExHMeV0lDRGklAQ3Wpdvsbpz5l7qD12O1X0kl7qMx1ujUn0byG
	 M7wBAXVYUDvo6Cq9LWXwXBqAc67er0GJJmce1eR/P9bVtpDZ3wtE0P9quW6h25hU22A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma4EZ4Mz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE0606A320;
	Thu, 19 Nov 2026 06:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ma4EZ4Mz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795069208;
	b=Qi/id70l3RB72kxMY9/BLZI9e07QZ7filVhVDTK7iadWz9Fhp/L2cnheQjh15yWfEnNg
	 FQS35BIvXgjCQWAMTweViqP64ShDeqNSjoSIV1oGuUPl1Rf4ao0xViwHFlnmWBbyxhGH+
	 cApyP0kC/sQyThEA4ajZ+ZxUAnuu35qVWBZN8QA9PFfZ2iRpsBE8GSptlkFam59Wgt+Os
	 AXVG7BtTqACTyqXUpCecrlLPxaGaXVBTxycTeiw+q6cgCW3WnUYLHAhH5zG8YAoFkPLNR
	 VJOIbQlN+cJ9CtobJM5IFoC5niL629pJXHL0lDF7amxeAaDzq3SUX9wf7h14ve9EGiQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795069208;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=P51zQnnlFN29NM1R8E8OMTMjHLC0aAOfMUy/UOhFuHY=;
	b=AVakpmYKl5HWCI831C0NdDiYD+qT7c6E5/RAKuzwO3tr3YDcMtSqLdpcKRvlCxtMVPnU
	 5l5vvmRMZ3tcOnx5TdiLTns28SwWMUR2RFwaipQrjyx5Ln41toqz22y94bPO1RCU6Npzm
	 P7Oa1HIpfUNC5hHsRRGfS3Lqotw4jRGKlRM1aOaeJ2UGSucaNOpY3kAXxzGUcitmUKOah
	 nNxtDyFQfuLy3b0RN/IEtqDWoZjMTv2uIkaft9jmTmNfmcP7CcPbWcbr7BqLpuQG9TcSC
	 6liAN6YfkIowHSJ70EIFbkwvS3o2f9MnRUwHEAooNgaGxYcl8QyFm1b4QlGM+oQBQgA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC7661F000C9;
	Thu, 19 Nov 2026 06:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795069208;
	bh=P51zQnnlFN29NM1R8E8OMTMjHLC0aAOfMUy/UOhFuHY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ma4EZ4MzINVfA6Pkkyhoq9WX4oO0jz4QRd0NedKsHkClM0FuSzkJQzBg94zdaTldQ
	 YbFKym6983FEj0tl3T2v0OFnqteCehGQiAgGC7MjAWLZISqEBuy9Yy3TcQk2EfNlOE
	 RvXRBPa0DUOTH5IXKr3R76IQ2Ca0NgGwzPeTK0ibXjmlr+CGEvxtHgNdYpQJVCrmkg
	 yUySdVXayWgB/jmmOgqN83E7/WNlyCZzv57CNT/hejydRhOI8BkuOP5CsYN37ESac8
	 Sq815wy2rjYBWw9LZONKpIg7X+pNVrO67g4lTFKtQ454GFDxpStMnSyJGTcd9GgSEj
	 x/69bpPdIi4rA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1DE334B130;
	Thu, 19 Nov 2026 06:20:07 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/2] media: verisilicon: Fix VDPU2 decoder error handling
Date: Thu, 19 Nov 2026 06:20:06 +0000
Message-Id: <20261119-vdpu2-errreset-v1-0-f8fa403b6a3a@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqDQBBF0a1IjdPQHzStWwkZ+HmJ5UClSiUg7
 t3WDM/g3p0UwlCqsp0EGytPY4J7ZNT29fiF4S6ZvPWFcy43Wzev3kBEoFhMLGJ8WhvKUAdK0Sz
 48O8evt5/69oMaJfrQsdxAjWqA61yAAAA
X-Change-ID: 20261115-vdpu2-errreset-8688700393a3
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795069206; l=1334;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=2RFAUR3ng5/QnrGOQnWU+xGFztNU4gfgufFi7kzRutU=;
 b=OjJRsu4+0DdVHmvl5f/yUFh9DPg7MhS/pT7qenF5H07QM1yFTfJx6KXvTla6h9Fqw68gjmIuo
 mtkobnUna1sCg+BTTpBZtAsQOddm23UGyyBfLbCHqFHog2CZUfoSsl2
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The VDPU2 decoder reports failed decodes as done and is not reset
after an error, so it can keep accessing freed buffers.

Tested on an Orange Pi 5 (RK3588S), KASAN v7.3 based kernel: 72 H.264
fluster runs, no IOMMU faults or stalls; with patch 1 alone, an earlier
run faulted. The VP8 test vectors pass (61/61). Two H.264 vectors
(FI1_Sony_E, MR8_BT_B) fail in 1 to 4 of 249 runs each, with patch 1
alone as with both. Build-tested on media next. MPEG-2, RK3399 and
RK3568 untested.

Independent of "Recover the Rockchip VPUs from faults and timeouts"
v3 [1]; the two only conflict in one #include line.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/r/20261113-hantro-robust-v3-0-82383c722ad2@gmail.com

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (2):
      media: verisilicon: Don't report VDPU2 decoder errors as success
      media: verisilicon: Reset the VDPU2 decoder after an error

 .../media/platform/verisilicon/rockchip_vpu_hw.c   | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)
---
base-commit: aa0f4c41d4870a18e65772a1817af16427200371
change-id: 20261115-vdpu2-errreset-8688700393a3

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


