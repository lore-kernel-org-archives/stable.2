Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795811190;
	b=HiUI831biMfbbMbSZTDnzMvlLnW8lf/4+9d00OxO4l9EKjJJuN+uTZboZ7kreBGNFwpL
	 Xg/M1xiCOL9uKIZkAIH3PvYuTfkX0js5dQzilZl5noodHTsE9iX6QQ1+d69VkzyznkCk8
	 wUZFaM3pbzPeYpjIdK/bkxt28Spt3m67Ey9NetfGgIZsrB6q137ANkIxsBPXLVyp/ndak
	 UCdXvYChwacxeOTmku0L9h0Q5MrS61bCoG4CO5bhtStSIGI4C8jsB4gxZCaVu6wmDL8fk
	 fW2BqCX73OJ1OfBIOv9pliFz7/qeXOiD/g+2gTGI+bm5DmnFsSlAZl5VG5mC+1bGbbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811190;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=8OTUT592gZODM0Obxku+zjWewF3c0P4oGcuzyErdxAk=;
	b=fsZPIiUGKh8mFfGMM4XpB7rFYUK7pdmqWB0dkic6kijSqtLMRZ8f3MNdiQ4bLSFcrwAH
	 17yxwsLq3Hk4SENFcB1lh/awf6ms05MmSJbEsOsGqMel8MkDXxv6st7P0OCNPBbmBZgK1
	 pa9sMzrQwsg0lxvsgxZrbER/0gpUtV4B4AhsoU1HUdq83+bUQ2EkpSI8IVpF+Rp+WPUrx
	 JAmwvR/G/ACFEYijeGwjE6DCtztWKKZkbFmldsVHiAFPV1oYIgig0fXAICL+rLrUCrrLt
	 p+Xl5kvbJFTZT49dzAJq9SjS/H5DSZ+ettY4AMP9GNsbT9C7zJGTRZXHPS0WkJBQKLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XM8UI2Ga;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C5606A31C;
	Fri, 27 Nov 2026 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XM8UI2Ga
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795811189;
	b=AMoZbWQI+XSiwtL+5v6NyJosv83eN3rpNgDrrzKSHEDUnuJGmsUfGHLfqy546ds36m3e
	 weu+07Knt11xQ4ZPufNCQwF5sTJp6vqzPTZiciRRazOZy4pY46stOlJseqjQy1QcPs1gg
	 rhV/DhiaFK1QetON/NQWu2ZKlk21ioGiYSaL0pdTrWNg51gMiGyjhkti+O5LjsMKjewQN
	 YN96tRhyjXJvGe9MVVx/7AkJjtlSKvxF2R/mNne9KuofxKNvozlxR1s9jCM+Xp0YIwRMR
	 B4iNl5UIEKGDs79wzmRLZKHM+gKAHrWKFAPCnE0tNRYzac54q7v/3I3n5QK/ukM4i3g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795811189;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8OTUT592gZODM0Obxku+zjWewF3c0P4oGcuzyErdxAk=;
	b=pTqtR0VfzbFLY1IqJKALU9JucHLcBKQMJ3rKHqvqBlO38dFlumPrCRfzRgm+rTtZDq4T
	 qx9QTHgdhuEwUKK/x7cPyRPrxNse3idXWpiDgx3K4rFWw8S3Wpi/k1G/Ho9397D2M+sfc
	 9RwuDn1XIhu6QPfRzHVJQF/KyDnSD4cdL1ZZCvoXMgctorU+xNUFMe0GqaCEyqIVpmIIB
	 r0KaqfwgcCKT1DmKeGAMQf4hhqhmW6bmrw4DmmOZdecxSN+ykurdYu+4kUDlvTWMmSweg
	 U50VktTlIwUzgKYzvCEQcLtd2KBBkDL/14MlzSx7ZFJkRGNEL9fbzJ+chakzOlEpF8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 94E931F00898;
	Fri, 27 Nov 2026 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795811189;
	bh=8OTUT592gZODM0Obxku+zjWewF3c0P4oGcuzyErdxAk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=XM8UI2Ga3OOQLigG2Gi6PJ0iGpdNrJpxc/tg5wfzrBGp4h5QblrHAN81e14tNJMYB
	 7dsQ7ee/MEIjqouOsD4SNzxFPZlcxwgW+EsEc269QZCV61ecAW5+xxQ+TTjIOYsJif
	 O1V67ULkVspneAsUMVSuLAhAFB8Q10PMNFKZfkd8aoAtN66vT88JTW2bFXnHsEBIAI
	 EwW9Y5yX1QFfSHrCSbKD6hNSP415XDZQ9jORPkHKXX1QvTEohk8WOyI8/CxvLJcEZY
	 qrDIqm6xmHAQIzanFpkOfikyvg0HbOgyzN5H1D9EinpkP8odBaTHrb6yPMW+7B6Ow2
	 nUA3gFYTAXRSw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 160424DDA5;
	Fri, 27 Nov 2026 20:26:24 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Subject: [PATCH 0/5] media: qcom: camss: fix Titan 17x VFE-Lite, buffer
 flushing, and CSID RAW10
Date: Fri, 27 Nov 2026 21:26:23 +0100
Message-Id: <20261127-camss-titan17x-fixes-v1-0-541ab39e5889@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAG/nCWsC/x3LQQqAIBBA0avErBtIwayuEi0sp5pFFk6EEN49a
 fn4/BeEIpPAUL0Q6WHhMxSouoJld2EjZF8MutGtUtri4g4RvPl2QdmEKycSXA313ttuNsZCWa9
 IfyjnOOX8Ae7XOo9mAAAA
X-Change-ID: 20261127-camss-titan17x-fixes-f5e9dd78b557
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Andrey Konovalov <andrey.konovalov@linaro.org>, 
 Atanas Filipov <atanas.filipov@oss.qualcomm.com>, 
 Milen Mitkov <quic_mmitkov@quicinc.com>, 
 Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795811183; l=2151;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=oZnTJwNV6PntoYX76wzl+jwfwWqVmbMVwDUv61lu1Hg=;
 b=mZw2LvD2yynvac+B7hNbPz+5VkgBnoPZNmpaN3SmrfY9fFtab4K+Tu++9YsDJoG8hy+tTYNbM
 m14aJcLqTO+BAPDTdIwKtkml0DJM7XAvByrSkVUKPeNHTxE31n08Hhw
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Reply-To: robertijtsma@gmail.com

This series addresses five remaining Titan 17x VFE/VFE-Lite, core VFE,
and CSID gen2 issues discovered during SC8180X (Titan 175) camera
bring-up and code inspection, rebased on media-committers/next after
the initial camss fixes series:

1. vfe-17x: Omit CAMIF/bus-bridge/testgen/DSP bits from VFE-Lite global
   reset, guard VFE_BUS_WM_DEBUG_STATUS_CFG behind !vfe_is_lite(), use the
   4-client WM_ADDR_NO_SYNC_LITE_VAL mask, and iterate over the 3 bus IRQ
   registers (0..2) instead of vfe->res->line_num.
2. vfe: Match numbered vfe_liteN core clocks when vfe->id follows full
   VFEs (such as SC8280XP/SC8180X) and reuse vfe_match_core_clock_name().
3. vfe: Move vb2_buffer_done() outside output_lock in vfe_flush_buffers()
   and reset gen2.active_num = 0.
4. vfe-17x: Reuse shared vfe_buf_done() (issuing reg_update() on buffer
   updates), validate wm_output_map[wm] before indexing vfe->line[],
   initialize framedrop/subsample registers, and defer WM_CFG_EN until
   vfe_wm_update().
5. csid-gen2: Add MEDIA_BUS_FMT_{Y10,SBGGR10}_2X8_PADHI_LE to
   formats_gen2[] and configure PLAIN16 LSB unpacking in
   __csid_configure_rdi_stream().

Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
Robert Ijtsma (5):
      media: qcom: camss: vfe-17x: fix VFE-Lite reset, debug, and bus IRQ handling
      media: qcom: camss: vfe: match numbered vfe_liteN clock names
      media: qcom: camss: vfe: call vb2_buffer_done() outside output_lock
      media: qcom: camss: vfe-17x: use vfe_buf_done() and defer WM enable
      media: qcom: camss: csid-gen2: support plain 16-bit LSB RAW10 formats

 .../media/platform/qcom/camss/camss-csid-gen2.c    |  11 ++-
 drivers/media/platform/qcom/camss/camss-csid.c     |  14 +++
 drivers/media/platform/qcom/camss/camss-vfe-17x.c  |  96 +++++++------------
 drivers/media/platform/qcom/camss/camss-vfe.c      | 105 ++++++++++-----------
 4 files changed, 107 insertions(+), 119 deletions(-)
---
base-commit: 10c156a0a06c0a255cbd13cabad649fd8d604b47
change-id: 20261127-camss-titan17x-fixes-f5e9dd78b557

Best regards,
-- 
Robert Ijtsma <robertijtsma@gmail.com>


