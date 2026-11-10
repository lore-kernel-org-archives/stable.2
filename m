Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794314509;
	b=Gp4cVwl4UUrPyZ4Xjh/4SGVVtLdLECDyHWSL4/w83wzeD9dxJKPIUehNjSXEtkzy8TrQ
	 eaB3VH2VDRud6Np8G3xVXZKpZi5T3Vcf5SimeVUp/kTSV0dp5RXnxatoUQv79c4BQR/KN
	 fM91SS2qbkYha+TxCbXVQ3nwUu+A/BECOalmu7Xk+/xNcreSgDdU74/xM56hGvPqFp3gr
	 n+RAGBCfWb0hl5WOyphwNRMNUJjlzVjikbjFi4d7lb5KDPDITzCmHdwc2vWXPsXuE/LKq
	 +0sfCnaqR/hwITTcXgMDR9opn2sCe57JEitFYxet/kWbE8mOhTh9hMGyttWPEdUnmdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314509;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=X0IFJVOtpbpXX9qyQ+NjxAK8tq5FRFVx6Y0AIb9bC6k=;
	b=dM4BvFa0aHRRzZr3YnWzmjCURv9v27agEnudr0NMIq2Wo5fj+/Sj3rmrspWlybSx9a4B
	 zyGiF1tBMjmAALHgZ5dDKk5yXDSSCPjaeaQWfC/A6EoMyBq82DvpciZe3cCc1PiW0sG4G
	 kQ2S0P4lRtXZ0hxCUpwLjFpHPqk8tvRqGDlBcUdjNaTS8JB3LzA/YOvZnctV+2+rwHOIu
	 zSNU/uuhvSDP89i3PRdYvHBtpIqr9WJPvQoMUxs7wOPRYQBrUagm5HhrUVYsYVqCrxhV0
	 9y9jykG1EKdDWtCrTOFmx9M2QMuS0T8PeC83HZnUxQXUcIxhWYwJlguD7fyJMpsf04g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmG+EXuD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276F606A330;
	Tue, 10 Nov 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmG+EXuD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794314509;
	b=M137ffYybQgHxgZ5t4Ep37YiXbcieuak31EH96TvIyzumhxuP7Y9TGfFUrauYxFV6EKP
	 GlKfXM2OEM+sup9l/Zo7Tp/1uQuiWSHMUkfjJV4SR11Tc718Fa8K0SXZdE8EyKN48Jz+6
	 b1oskZve5ReshnNDBVeCx8JywV/uTar8T2XPhtZczNQb5hlApy0p/3CSgUXVdcFu8e13n
	 Ho54ay3SbNtoEBPx3iQTyLvoPmyPWEjMW7buGE8E2TiEHgjKR1TnpfXMghCFalOmVAKYg
	 6VOro9OL6TZLAz5UDnZ17E1jZ250P1kB4HLSs54E8GQXQPgn/WnQQ836VMv+r58F+oQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794314509;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=X0IFJVOtpbpXX9qyQ+NjxAK8tq5FRFVx6Y0AIb9bC6k=;
	b=lP1xupstwNQM51g4SwT1ayas2sR2LH8tYVF7tMCzvOA+KZcT0+9gid+aHOQlXsZy9GiU
	 edhLwMP0arARUCe9DvxDAyhlfAEJ2iEQn3OoFV10n2Q4GKAhw5FRLK6emRztiqdhdGjKr
	 fH0n+sDYgIhdlxfoh9tudldoUXC8o53a39DsCo2DvV6ACmY1dFu5Ce4IeZRQnxjzSXTZA
	 BMoTOftEDX/9i5dNd4pnAAx7Q97v+7d2cRxkbhL8AXlyhaBM/MKPVSvUrvvtobJwxfNtA
	 PGZPdgs7py6JAqefciqRHjUUZSuVXPvGob8QetOj9/tBSSciuUM61XJt7B7CPgwn+CA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E19151F008A3;
	Tue, 10 Nov 2026 12:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314509;
	bh=X0IFJVOtpbpXX9qyQ+NjxAK8tq5FRFVx6Y0AIb9bC6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JmG+EXuDaPcGCnO8ZtMVp91vlTpI2kjGTEPB1nr0JRHewE4JiMaQ3T+Vk5RrMtu0N
	 P+F4TQBSkatPNlKLuI0/345UvXLsNlUzvnvi3kQ8gUSVCrXEFnWHanpGXjPAd31zRR
	 ANS3LxMtOmDyGIdLXrJZCUFRResFpkoXyr1qMcoylac2cDrhP5YpfbIZ0bJW2omrT7
	 ftHOEbHVBamAx8HT7OJvO8K8elHil0F3qBgqdOKPpQgLgt3g3tdZC5jtX4WkcLmLUf
	 74dUj7FGvC2ZpSECUNXiKVPxrC4S5cwTNuD9rhdtkYKTHJuSWE8e2LPSP4kfN/+K71
	 XBjTv496yn1zw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 716E048B56;
	Tue, 10 Nov 2026 12:41:47 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 15:41:46 +0300
Subject: [PATCH v2 3/3] media: verisilicon: leave room for the JPEG header
 and one stream burst
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
Message-Id: <20261110-hantro-buflimit-v2-3-ff7790def9fc@gmail.com>
References: <20261110-hantro-buflimit-v2-0-ff7790def9fc@gmail.com>
In-Reply-To: <20261110-hantro-buflimit-v2-0-ff7790def9fc@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Chen-Yu Tsai <wenst@chromium.org>, 
 Hugues Fruchet <hugues.fruchet@foss.st.com>, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794314506; l=1858;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=CeJV7WTdl8YyEt6UT/A5SLtk2CJudxLaFIgLvsKKuB8=;
 b=a6Kl0B0YyzxhYqxv/b89jliXBQrKiAALwDgE0BamEs0dxGx9Dj/wZSns3/8hB3anPmZ4cp3a/
 WDD3Wbae9U3DCBHdA8Zs+B3G/zVCgIKLABK1qhp6RWL8uvwdivejO63
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com
Content-Transfer-Encoding: 7bit

From: Sergei Khomenkov <shomenkow@gmail.com>

hantro_try_fmt() keeps any non-zero CAPTURE sizeimage of the JPEG
encoder, however small. The CPU writes the 624-byte header into the
plane, and on the RK3026 VEPU1 the encoder then writes at least one
64-byte burst even with a stream limit of 0, so a smaller plane is
written past its end. A plane smaller than the header also makes the
WARN_ON() in hantro_h1_jpeg_enc_set_buffers() fire on every job.

Raise a smaller request to header_size + 64.

Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board; the assistant also drafted this change. Tested
on that board: a sizeimage of 1 or 600 now reads back 688, and frames
that do not fit a 688-byte plane stop exactly at its end. Not tested on
other SoCs.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 83af9fa1ce94..6a6d27443a5e 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -394,6 +394,15 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 		 */
 		pix_mp->plane_fmt[0].sizeimage = fmt->header_size +
 			pix_mp->width * pix_mp->height * fmt->max_depth;
+	} else if (fmt->codec_mode == HANTRO_MODE_JPEG_ENC) {
+		/*
+		 * Room for the header and one stream burst (64 bytes on the
+		 * RK3026 VEPU1), which the encoder writes even with a stream
+		 * limit of 0.
+		 */
+		pix_mp->plane_fmt[0].sizeimage =
+			max_t(u32, pix_mp->plane_fmt[0].sizeimage,
+			      fmt->header_size + 64);
 	}
 
 	return 0;

-- 
2.53.0


