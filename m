Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795242622;
	b=K9Yjrw5plmh0k+zA/FM0LrUsB1DyAIgkOPTNHjxi4ljkxZbzorrfFmm4R83Qi4NC85GQ
	 0TQ+qmaaHslN30C3maigKs4uv6MrxLvtK1I433y0J72idPUAsq0a/rBl5O+bcLiLBlAJA
	 u732jICLhupTwNjZiFFJnIm9D9KluI7gjqdVy7WDPa9ifaqzHIcQggyyeBrXdAaVsPIII
	 Z7gdfHElWzJJqRV2uS0hT1QQDit4VjtRjevUfSq8EUDyecnQOmnIMYOBulkxTdrNu5GJT
	 o6nsASFMXOBxKRBQN+ZqTGt0I4LzQOTrRDb0ZcrB2TgUQ+GQAXgTwoLCVDwqFzQVL9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795242622;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	b=XEtm+3YsBEcLkZsllIswNzXx1L1v+0wRE6P/OZmfPA6QslAKqUrz0TVEPT8xC8uUduk4
	 4eHTjtKjEm3WCXDN/MGQBxe1mM8AyGC4lzTqPDshc2HBI4Yn+sGMWd8YOEXqOuE9i8Rz3
	 ZnIUZB54xlOmsy5eE/QnP0RTqJs/cHrxzlGIc/0GrHe5UxXLPQg1LNXGHY1zfJ7IHVf8h
	 fSRqGQtXBNZzmNS8KR6Q3AL/b1CkPUqybG+whwClURjUet+YRrxRsFpEsO3rt9IVFQdDO
	 ig/Zf737UfC0ffWSs131KGRfoFZiX6wCpLCh1uuaZg84yDenqm/Jz1G/M7StZ0Rmu0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJiKudU1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AE606A335;
	Sat, 21 Nov 2026 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lJiKudU1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795242622;
	b=JfHYi1d5I3iT5KGtmZrsjFspRBA1V82BWezXbu2hSE5fpL2SvH+ts0whlXioXiZY8rN6
	 OQAJKzUbq+I1rk9lqTQcSYTR2I9MLHi20cMVGWv24xXeJh2SkP/wW4nrkPbWIZo6Utska
	 /yyy8uapNQJvR3W3rp2D5B0nqSIHWQVlTK8/krqNT4APnPJU+9HIducQBuRBeJJMafsc2
	 eVEDlc6JJZWe5GI7JlEpllS68dM8NOh7dSY++fZLUCIR78bAEjaJBCnFlsfNfu4eECgRv
	 YhzyX+fHkuGNCLSUhavvacwl7jVIVnSVJ+954BpQjgH72DUFTiJCDOs52mkNHqS4bwQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795242622;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	b=M3+ZFArPvBKCmWKW4P5TPLMU1kO3t9jBdIob7Vr74i0Nqxpe3A0K2Pufpk0Oj1keT4wa
	 zBsHtYS8TEoLZxmMkET7mTcaDazLWH1gHRlZaqE0lYctNV4piLkPSOhxqrhqXPyYgwOlG
	 0ylc8Pika2RZycAEl3V+a0DmFk1EYP9H+DcCNu+UIw0uLXw4NrufJi+cOcYxJZR0zxbV8
	 9Ktpwem0N/cOuqji+5bXQTGFZLuzVau/Kf9ISa3LEwcBbiGGJ4QTB595qelhftdao8K8/
	 cjNwPCwx80br20lxK3sgBZM6QOxu5F9iPoDFH3C8kYYGTJ/uLsDTTHVzYBxViQyLRDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EB91F1F000C6;
	Sat, 21 Nov 2026 06:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795242622;
	bh=uZkRTJla5CwLMcW9i2JUtSgkCfjOBmDVaDO3vNDdUEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lJiKudU1xaxLC7fUqn6ajC0n7JctNVbDuiPkBMw/KOz78rrpaSF7TYXGf1eDIc7ss
	 PuppW31gM7U/+qaFSyewY4QbSqTocDLzksDbVK1zeBngVrYB9UFoWcPHNUjBJM5sA1
	 Sli5SHFWWx5BaVk2Py3sGUHj61kThbcdusl2PyHrJn/y8bZipRhiwzHR3bcGP+p0KK
	 tR+JLjTGEhHqdQFBKT+Mub7F3NC9L73g6fSyd45RDYG+Q3TERIXAj4f00qop1++F5Q
	 eUx6ApxKSB6WsiudMbLaBXaIRynUlnCyNDQpDGdvlwkFrh55GnGGwnIVSU9inQx9nD
	 YYnq/cQd99XCA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6D43B4BB1F;
	Sat, 21 Nov 2026 06:30:21 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 06:30:21 +0000
Subject: [PATCH v3 1/2] media: verisilicon: Don't report VDPU2 decoder
 errors as success
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
Message-Id: <20261121-vdpu2-errreset-v3-1-073b5e5bdd64@gmail.com>
References: <20261121-vdpu2-errreset-v3-0-073b5e5bdd64@gmail.com>
In-Reply-To: <20261121-vdpu2-errreset-v3-0-073b5e5bdd64@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795242621; l=1243;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=pmz+6zoUL7toWQYosmuS4NH+xU1lJuYNQV3oDGrhPbs=;
 b=fZoK2FEoeZgyyOhO9Z9qRzR+Amsd9fpmeMfElCJEh+JucH7z/32Bgz/EyJ8qXIB8gzwM1lPyK
 Mlc6n67J67EBxSAC2rJ0eDT/e5D2FwCHl5jeMkIXi0/tZwCpuxqHWo1
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The VDPU2 interrupt handler completes the job as done whenever the
decoder raised an interrupt. DEC_IRQ is set for every interrupt,
including timeouts, bus errors and stream errors, so failed decodes
are returned to userspace as valid frames.

Check the picture ready bit instead, as the G1 handler does.

Fixes: 879dee56a40c ("media: rockchip/vpu: Add MPEG2 decoding support to RK3399")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 02673be9878e..4bc1bdb41c70 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -391,7 +391,7 @@ static irqreturn_t rockchip_vpu2_vdpu_irq(int irq, void *dev_id)
 	u32 status;
 
 	status = vdpu_read(vpu, VDPU_REG_INTERRUPT);
-	state = (status & VDPU_REG_INTERRUPT_DEC_IRQ) ?
+	state = (status & VDPU_REG_INTERRUPT_DEC_RDY_INT) ?
 		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
 
 	vdpu_write(vpu, 0, VDPU_REG_INTERRUPT);

-- 
2.55.0


