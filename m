Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794231839;
	b=qnXehVD6yiO4JZen9l82QGzb3ErHSEqw+xrUsLCNhdTYBRxAGuHZ4Nj5J2BSJTFCsIS+
	 Emfh5EioudygPfJKO8gvGjb5tGD3K6mrs0jJn9eZsehX4dAtufG2vfNS3e4nieX0ygxGA
	 Kw4u/Tj65yY8PXvz13KegqYjD2fJ3TTOoUvbm/o2o+HILqCMnilrfhIAvLhCobGcCN7ib
	 FOuaR/5MuSs0kAK/eUnm4BaZzP3TS7iu8Gr0yHN1YZq45RSDW1H10XEc/m6I4yXrxVD0z
	 1Tbr8cDJVJN467Oc5C1o82yJKVVB6K/IRUig9PdjIm3UgdqKY0BgcYSVInBxBcGlFQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231839;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GtnnKDUixDs6YcFBue9AjIw6JGQ+hZhqw+n93Z0Tnoo=;
	b=ctvgU8IBlju972b7ZrAQQy31Wr6mEvi0D2/dEkceIEp3A2FTXTJab8Nrvk3eK1ppUv93
	 4DyheeYHhXe4IXXc2/f1vfMvhy7uN4uRRQBhUQIWC+Vx1rJp7figNriPrvkJoentD232t
	 cJpQCMsrMEN3wFBSpQ0e0DnPqgcKBX5xXNfBSjkIP1ymcKRbBKRO/NsZMRUqj4Cdx677K
	 rFH3ugT+bdyjqXjlMYkhzwGOnbgsYLFXTvTPP5t1ByHlEiPx7g7YuHpzcf9rtTYK495C3
	 PotievTuV3ZptcehjpoE+VaFOm81e/cdsWhx0luNBKdWMv/zGrWiJbT5DMl+xVfoCrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbgIlGB5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AF606A321;
	Mon,  9 Nov 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbgIlGB5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794231839;
	b=wbFCzZPnt7Ik+gtLJumpPuqF5LmkHGFnka65GKEaaV3OSQlsY+z6Z8HLVLjRg0hppPQP
	 aNs+mjkb1ZOso0+dNxfwvD8uF15Kw2+3S/gBhX/XKOF8TDJTj35KuO9g+HhExp0+/NY4X
	 LOLu9lQ0LFMBqSMl4SELh3Jr44zvPj9RdRkLxe1P86kKpyWHiTZLvdwLJmiOdBSu9zG4I
	 Sr1I8jI3NL6yHgAGxiue8f2Qlpwnsz+KPbc5VKzTvUv3JzFsHQ7a534O2lL1hFh+HJ0EK
	 RrFSxjFUONW2/sMjGPa50fiN7GoPojSkQXK8Q0391cFaEqfv8dYqTv0wQU0N/1QpNOg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794231839;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GtnnKDUixDs6YcFBue9AjIw6JGQ+hZhqw+n93Z0Tnoo=;
	b=F6/IakttLtW6jObX9bQ7sFijE6XWbho6M4mIalMvjlifegGSFR9RIWJKbQHvC0rwdxdt
	 nSW4xgauiKzrZNdfekvj3DCROu+BMwkMBgOLrJO4zt3BxQfDxuWb2AOP+c8nRoJXHpwdW
	 rBRVB+JA9+rkzq13iQvhYiof9JzHnxGm+3Pd9O42pjxSpW191NsrKSQJUG5HK81tc51ta
	 CqqtB2V3C/v7rz8ztzMtNUq8quI5X0Gf+x2Bl2ji/1DArvoCia0NOmC/MpVzsz7VMwoPn
	 G2f2v2sYo7yF9G/CSr+q76usK3UTFOyUBJX8xBwjhyS0huCVwoA4PBDQSEMpn+UB9QA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 336DA1F008A1;
	Mon,  9 Nov 2026 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231839;
	bh=GtnnKDUixDs6YcFBue9AjIw6JGQ+hZhqw+n93Z0Tnoo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IbgIlGB58wiNwULIAQYrTiVp6BeWsPw4QefYrrCANl5Sjt+qweb+WwMBLH3yC8oc2
	 s4MKzMMlOApMPm5s/oZoodDiGQG26Hd7IQLCMoXal4Hs9uVMb59qym/W4Yv6pQsYsE
	 tQhGTQrnwsgH/E/b0tO8/vcM+uh8lL7mmrhqgRUN+W0Q6YaAij4UHS+jzjY1sqNIb1
	 Ccypn2jjjm0TH/v8a+M/2C15B5r+zY0Q2kPMWy2M9Eeegu8k95Xn8nNtrld0+uBzUk
	 Eph0CKg0sBFpY2VgHfEspvQGTrZa862M3eLxwC6pjl5pkBinXtXGsoG2+hlJ7oiF+k
	 k4PwQL+VUI8Qw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA3EB484B5;
	Mon,  9 Nov 2026 13:43:57 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 16:43:51 +0300
Subject: [PATCH 1/3] media: verisilicon: stop the VEPU1 JPEG encoder after
 an unfinished frame
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
Message-Id: <20261109-hantro-buflimit-v1-1-f0b86ce61e66@gmail.com>
References: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
In-Reply-To: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794231837; l=3446;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=zI1doLggNAdKArdfoF8NOsjTBvai2n/eWahpgrADzl4=;
 b=8i+V7bEymp3SbAXhd4ILpebsao8cHm3kZV+rAwGPEaCvrJGhxMx0PLQmL0tt4yySDSzHBZ10+
 s0AYQgzA3KKCl4CkjCPqkaPVq/KO2cNlL5R+YVmF9czzhtjDif/g6CW
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com
Content-Transfer-Encoding: 7bit

From: Sergei Khomenkov <shomenkow@gmail.com>

When a JPEG stream does not fit the CAPTURE buffer, the H1 raises an
interrupt with BUFFER_FULL set and FRAME_RDY clear, and pauses with the
enable bit of H1_REG_ENC_CTRL still set, waiting for more output space.
rockchip_vpu1_vepu_irq() returns the buffer with the ERROR flag but
clears only the interrupt and AXI registers, so the next job is
programmed into the paused encoder: its ENC_CTRL write aborts the paused
frame, which raises a reset interrupt while the new job is being set up,
and that job times out. The watchdog then calls
rockchip_vpu1_enc_reset(), which sets H1_REG_INTERRUPT_DIS_BIT, and the
JPEG encoder path never clears that bit again, so every later job times
out as well. That second problem is not addressed here.

Write 0 to the enable register when an interrupt does not report a
finished frame. The write comes before the interrupt and AXI registers
are cleared, and before the next job is scheduled. On the RK3026 it
raises no interrupt of its own: in the test below the encoder raised one
interrupt per frame and no job timed out.

The encoder rarely gets there today, because the stream limit it is
given is eight times too large; the next patch fixes that, and then
every frame that does not fit ends this way.

rockchip_vpu2_vepu_irq() and stm32mp25_venc_irq() do not stop the
encoder either. I cannot test the VEPU2 or the STM32MP25, so this patch
leaves them alone.

Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board (VEPU1); the assistant also drafted the code and
this message. Tested on that board with the stream limit fixed: without
this change the job after a buffer-full interrupt gets a reset interrupt
and every later job times out; with it the frame that does not fit comes
back with the ERROR flag and the following jobs, overflowing or not,
complete as before (10 alternating jobs, and four overflowing frames
queued back to back followed by fitting ones). Counted in
/proc/interrupts over 24 runs of the series (48 frames, 16 of them
ending in a buffer full), every frame raised exactly one interrupt, so
the stop write raises none. Only buffer full was exercised, not bus
errors or the hardware timeout. Not tested on other SoCs.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 02673be9878e..144d320302a1 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -376,6 +376,15 @@ static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
 	state = (status & H1_REG_INTERRUPT_FRAME_RDY) ?
 		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
 
+	/*
+	 * An interrupt without FRAME_RDY does not end the frame: after a
+	 * buffer full the encoder pauses with its enable bit still set,
+	 * waiting for more output space. Stop it, so that the next job is
+	 * not programmed into a paused encoder.
+	 */
+	if (!(status & H1_REG_INTERRUPT_FRAME_RDY))
+		vepu_write(vpu, 0, H1_REG_ENC_CTRL);
+
 	vepu_write(vpu, 0, H1_REG_INTERRUPT);
 	vepu_write(vpu, 0, H1_REG_AXI_CTRL);
 

-- 
2.53.0


