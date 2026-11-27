Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.128.248.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779707;
	b=Bdw/ij3VNCucHE3u7Py9kt++cHGPvuIzD8hkqNtGbZkcl0EqsZIhpe+oOFqIxgbTGIRP
	 XUQajQbkcb9DBavLI9+dNqa+sELKXSXGOqpYMYMnX73kyDHax3jGLih5iq/5axs7TQE9u
	 HIaREUiXH678vrYdIUyqqr9gO6RGUzb6/h8iGrNDcd4qfxdYWMcZLSBzWqAlV5w2aHC5l
	 KVVTpriPY54ljgN1xYPZoIFcY3RakqxrvMW5rTrD6CMBMJWd3sGq3/KasOebD4X8S1BPr
	 de/mbf4Rned1xy9xOvHvh66LpFChliTlARSskvt6r6MIgGcPaEzELup3sV/myMv3NhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779707;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0XGypaCJ7EJQifKr/qwYwdAUFvbJAWwik5NXmXNQWeA=;
	b=tYv6PiaBuS+bjCkAe8c6ywbNWcwUBtnFdoGM6P+I76J3vPeNZURI/R4Sl0yz2RCeAWsG
	 9Azg/Dr2zFAYCO4iMN+2oprplmESKcW/yWkPDU0g7mGIVKnmJfxtUSVummAI7Has1QY2q
	 rKlS22WQytKRO7xFFYbz3W9HsZ9ZOmcN+rUrgenXOCCWgdFC3hIvZe08Idb5OtsE3aeuz
	 6LBDEYQvnvUSCRsPe9cWCU66SDGSoi2RHF+d4sv3SqHcUg0qtK+nJ3izCifea6kOWzkNM
	 tOWzDWBuRvORnuk5M4gku7oGfB0at3xhS8PEI8XR8UyEc+vVcfguZkI9jyJ6ZZC/mig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cesnet.cz;
	spf=pass smtp.mailfrom=cesnet.cz;
	dkim=pass header.d=cesnet.cz header.i=@cesnet.cz header.a=rsa-sha256 header.s=office2-2020 header.b=La4Cgz56;
	arc=none smtp.remote-ip=78.128.248.237
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989A606A6A6;
	Fri, 27 Nov 2026 11:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B989A606A6A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cesnet.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.a=rsa-sha256 header.s=office2-2020 header.b=La4Cgz56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
	s=office2-2020; t=1795779704;
	bh=0XGypaCJ7EJQifKr/qwYwdAUFvbJAWwik5NXmXNQWeA=;
	h=From:To:Cc:Subject:Date;
	b=La4Cgz560/hs2fK1204gQgoWc7x5S+YHF5BOLQvwmEqDXVHMojdu5d8dn8MXsh/Pa
	 xnC3K8aDavr6nnLbiSagymIADfBNu5w0+aCr2C12JPmiGprqHz/tgowpYC9z2KYf9u
	 I3M0DazwcRDJvQhZ7bUxm2UIGiao5Kcl8Jx89AsbY430kdH9uRn8R7PZ5jIrgG459g
	 GLYGVgOxBMDYMXwe7yaLRbxZfY9OIOEu5fN5bMMQPLMI6Gl+G+k+FO5SpTxujoyxu9
	 D9EqEnhrc4dBg6bn9JFODq/GmlrBxPruaHKohYccXn8yF6k3CAjgBmkIFrCl9W6gBv
	 +F792sd0dPl7Q==
Received: from localhost.localdomain (unknown [85.255.90.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by office2.cesnet.cz (Postfix) with ESMTPSA id B3501118007D;
	Fri, 27 Nov 2026 12:41:43 +0100 (CET)
From: Jaroslav Svoboda <jaroslav.svoboda@cesnet.cz>
To: linux-media@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jaroslav Svoboda <jaroslav.svoboda@cesnet.cz>
Subject: [PATCH] media: rkvdec: Reject 4:0:0 HEVC streams
Date: Fri, 27 Nov 2026 12:41:30 +0100
Message-ID: <20261127114130.1680888-1-jaroslav.svoboda@cesnet.cz>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HEVC backend of the first rkvdec variant (RK3288, RK3328, RK3399)
accepts an SPS with chroma_format_idc 0, its comment reading "Only 4:0:0
and 4:2:0 are supported". The hardware has no monochrome HEVC: the
RK3328 and RK3399 datasheets list HEVC Main and Main 10 only, and
Rockchip's MPP library notes that its HEVC decoders before the RV1126B
do not support YUV400.

Given a monochrome HEVC stream (x265 fed gray or gray10le pictures),
the RK3328 and the RK3399 decode every picture's luma as zeros, with
IOMMU read faults at addresses near 0 and near the size of one luma
plane. A 2160p stream hung both SoCs after a few seconds; only a power
cycle brought them back.

Reject chroma_format_idc 0, as the VDPU381 and VDPU383 backends already
do, so that setting the SPS control fails and userspace can fall back
to a software decoder.

Tested with this change on v7.3.1, on an RK3328 board and on a Pinebook
Pro (RK3399): a monochrome HEVC stream is now refused at the SPS
control, and 8-bit and 10-bit 4:2:0 streams still decode bit-exact
against FFmpeg. Not tested on linux-next itself, nor on the RK3288.

The problem was found, and this fix and message written, with the help
of an AI coding assistant (Claude Opus 5.5 in Claude Code) during
hardware testing of the boards above.

Fixes: 3595375c2301 ("media: rkvdec: Add HEVC backend")
Cc: stable@vger.kernel.org
Signed-off-by: Jaroslav Svoboda <jaroslav.svoboda@cesnet.cz>
---
 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c b/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c
index 88e90c438..97466705f 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc.c
@@ -487,8 +487,8 @@ static void config_registers(struct rkvdec_ctx *ctx,
 static int rkvdec_hevc_validate_sps(struct rkvdec_ctx *ctx,
 				    const struct v4l2_ctrl_hevc_sps *sps)
 {
-	if (sps->chroma_format_idc > 1)
-		/* Only 4:0:0 and 4:2:0 are supported */
+	if (sps->chroma_format_idc != 1)
+		/* Only 4:2:0 is supported */
 		return -EINVAL;
 	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
 		/* Luma and chroma bit depth mismatch */

base-commit: b4e3c4b6a36fd76f57bf3e48638f68ddecc54ba4
-- 
2.56.0

