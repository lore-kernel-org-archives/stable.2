Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.128.248.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779341;
	b=QlQkNVHy+F92CzDjYaIHA2W4PG7Dp10s0jvDQofwNEi0ZEZS2mVuTlaEHgY4EXpdDjWK
	 ClGMm0Qr7M53BHRqD1Pq9NOKQhqyzHpd4+bpZ0LqsqwdX87mO68QMvwk381RYVDVoAnJT
	 78KT4lZQ8O6vGZEXXBLs+f3rq/OIMQiMAsJjtRSEZlNgnLDp+2g8OCzc7gUCw8as62HU9
	 bFH0R7ZpTsyaiBWp03Ni3uh8zx/Y+vf8TfBCkGNCnr+pvL4rq4GqW3P2w8bS0MK9f7km3
	 i9TxmCev/I8dutuNau8i7LNdm35ZnFQwuchcns6Ka6bN3Kw/b3K5lo2ved6SoF++Vdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779341;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0XGypaCJ7EJQifKr/qwYwdAUFvbJAWwik5NXmXNQWeA=;
	b=MogoY+mhvBGanRfKSIOQwsSkp2Kr47aB30j2pc8cH00YPg0o2LVXVVtJ3mQ6RLAN3neL
	 i2UgqaJXjYv30lWbxgXlY5QiTLHWY9z+Zf2bpmT8Pc0NYQCubR1tZ7tJIg4slOIIG4B5X
	 mlk+hUVgRWq6IGUiuqsoMzzZMO4YNQ/IDUkMBk6OpJ4t1eXNHyCIX/BY3FcTzE2EzMD9G
	 N48/GB+llebWnnKpjc8j5TIpKkYnDAQWvvtUO4rMGs8XXBIpGU5yhnd3Co6Gv8kHH9de2
	 0Y45cWTF2RRzam7iYVkajju/GQC+InseGMt2MD0/Ul4SPUaH4NpLpIBUKncV13dpR4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cesnet.cz;
	spf=pass smtp.mailfrom=cesnet.cz;
	dkim=pass header.d=cesnet.cz header.i=@cesnet.cz header.a=rsa-sha256 header.s=office2-2020 header.b=id56a0B3;
	arc=none smtp.remote-ip=78.128.248.237
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BE606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cesnet.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cesnet.cz header.i=@cesnet.cz header.a=rsa-sha256 header.s=office2-2020 header.b=id56a0B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
	s=office2-2020; t=1795779331;
	bh=0XGypaCJ7EJQifKr/qwYwdAUFvbJAWwik5NXmXNQWeA=;
	h=From:To:Cc:Subject:Date;
	b=id56a0B3w7bXsaRgIS9NAglpkokOFRLdgKPr9rLjUTClBdgMJJMVklaBkXZvH03pA
	 0+1zOVsyAseZhfLhYLV/QGqcOhTstPQPM8hcTVrR0LJYY84cL4ssBCxRAxNN0RSpAB
	 +GIzcYflMwFFq69MtVs0wTOthXibFpyvq0emNOrIN9JMtYW08hbu6F8HJHsOAl9tpl
	 UKHl48QjClsqqT7gwSwbs4H1QFiPMAymWMSBsWybQzj0RDVPXivd7Nv8Uu7KOLIJAN
	 w5ypVh/oRIlitBFmiGcjQfWbdhQtZHXReJzjJY3oiRVIHfiuvBdUgruMiIjZjrgd7M
	 wyE82KqAAPkEg==
Received: from x670.vse.cz (unknown [85.255.90.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by office2.cesnet.cz (Postfix) with ESMTPSA id CAC99118007D;
	Fri, 27 Nov 2026 12:35:31 +0100 (CET)
From: Jaroslav Svoboda <jaroslav.svoboda@cesnet.cz>
To: jaroslav.svoboda@cesnet.cz
Cc: stable@vger.kernel.org
Subject: [PATCH v1] media: rkvdec: Reject 4:0:0 HEVC streams
Date: Fri, 27 Nov 2026 12:35:16 +0100
Message-ID: <20261127113516.1668491-1-jaroslav.svoboda@cesnet.cz>
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

