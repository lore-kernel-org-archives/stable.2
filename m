Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049314;
	b=N07FWPP5kQCRtBt0+mGbgz228pURjvxD5IXBKSZtQQ32jAVwAqqXA7TxBJT4rWyyblrB
	 YeEkkPFkFD5rVVydeI+qStzNA2gSqjJPPFq+h1LWrsv8VPCAH0prRPTKvdhdau5g0kg3d
	 +DjV4MWSDCiM3HH9e0lfLf8c0njFVYi/5cX5BUS+WCvrobosXnUk3zKQCjYGNwoH6XrVH
	 C3pw3sRAC8sE5OB9gW3YkfZd4RqExFvHdDY9W7aTGYppXnSTPh1XRAFgTN5i9j2cEVKy2
	 F2WlU1PATYH3yOzcntCm7AWz9heNylQbQBbz/kr6crUqoYpP5RN+aLLvknbbT3CJd/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049314;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fzkiWbQq4pVu4Ze/G7SE90TYpuKbYEBA4oCAh3T5rt0=;
	b=gpikuvOTiZRRVImwNfdhZSxsbnzmGs2qeZq3wkGeakuytzQfx64hpvDTuR+udmlfN6wI
	 TAqH8GOV63FVZlad439l8k+kbpPjv2b7OzWK4NJZojDLLQ2kIphSQkkiNaxVQJBmUjSoe
	 jWVGI6MZkoq4vDUDDx4HmWyikl67BlDltpxV/cshDG+IHTdKqCmlsrU+VswXEoDYLTWuR
	 G1pep4al6c28lycm6EPI/kzbhjacJWdlZhQ2jtQzAwPoj5EBosFOhklbsN5OC83DW32JT
	 Cq/6r8Aap3j7RX8PRRtB8B4M6M5cINKD96qR+M+Y+AiUIS0eDf4csCh28Nvqnr9GcwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BA0eqx/n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76603606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BA0eqx/n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ADE1F0089F;
	Sat,  7 Nov 2026 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049314;
	bh=fzkiWbQq4pVu4Ze/G7SE90TYpuKbYEBA4oCAh3T5rt0=;
	h=From:To:Cc:Subject:Date;
	b=BA0eqx/n8KdxGPq7ZaJeAtioC3CqF98xQ4bbH0eSWMmg+l3TtPAT7Q8/S97DXCDP1
	 7iZxy3ZvozAy2Rlyb0x2SxQAV1Ge3wRbFg2Ae9V+jvEFElc7NfWZ7LpVwnNQodSOjO
	 Lm1kBcWOEiCzGGT3llBZ9MCJbcBimvXCJtLx6j8dD5f0L4l/VGjF4NswV5G/gN/w9L
	 idbVcdKRPEjrQKb75A7nDOnGj9a4nwc+IrzMKpGecLry/bzJ6DzLrD9T2gjstV7zNh
	 GEfRYDIBwAGQGOg9xugJgX7E51hGgkLtoiaXhvTujy9+h1LGJTASZnf3VSHBh4CWaC
	 N5vgymqgMHy9A==
From: Sasha Levin <sashal@kernel.org>
To: jkeeping@inmusicbrands.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: rockchip: rga: fix rotation on rev0 hardware" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:01:52 -0500
Message-ID: <20261107060152-failed-5.15-a67578c01798@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a67578c0179850e80cf08b1e0b8b1eb857f0fc46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060152-failed-5.15-a67578c01798@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a67578c0179850e80cf08b1e0b8b1eb857f0fc46 Mon Sep 17 00:00:00 2001
From: John Keeping <jkeeping@inmusicbrands.com>
Date: Tue, 29 Sep 2026 10:41:42 +0100
Subject: [PATCH] media: rockchip: rga: fix rotation on rev0 hardware

On RK3288 where the RGA reports version zero [1], rotating a buffer
gives corrupt output where one edge will be truncated.  This is a result
of some adjustment done specifically for hardware revision zero.  But it
seems this is not necessary and there is no evidence for why this
adjustment should be applied on these hardware revisions.

Comparing the TRMs between RK3288 with revision zero and RK3588 with
revision 3.2 there is evidence of new features supported by later
hardware, but nothing indicating any difference in behaviour for
rotation which is supported by all hardware revisions.

The logic here looks wrong anyway, since it's bizarre that minor
revision zero would need the adjustment for _all_ major revisions.  This
was added with the initial version of the driver in commit f7e7b48e6d796
("[media] rockchip/rga: v4l2 m2m support") so there is no detail in the
Git history to indicate why this special-case might be needed.

[1] Comparing with the vendor code, it seems this is actually 1.3 with
    the hardware reporting zero more by coincidence than design since the
    version register is not defined for RK3288.

Fixes: f7e7b48e6d796 ("[media] rockchip/rga: v4l2 m2m support")
Cc: stable@vger.kernel.org
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/rockchip/rga/rga-hw.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/platform/rockchip/rga/rga-hw.c b/drivers/media/platform/rockchip/rga/rga-hw.c
index be1bc8ddbd03b..2e7ec8b7c20f7 100644
--- a/drivers/media/platform/rockchip/rga/rga-hw.c
+++ b/drivers/media/platform/rockchip/rga/rga-hw.c
@@ -158,7 +158,6 @@ static void rga_cmd_set_dst_addr(struct rga_ctx *ctx, dma_addr_t dma_addr)
 
 static void rga_cmd_set_trans_info(struct rga_ctx *ctx)
 {
-	struct rockchip_rga *rga = ctx->rga;
 	u32 *dest = ctx->cmdbuf_virt;
 	unsigned int scale_dst_w, scale_dst_h;
 	unsigned int src_h, src_w, dst_h, dst_w;
@@ -251,13 +250,6 @@ static void rga_cmd_set_trans_info(struct rga_ctx *ctx)
 	 */
 	if (src_info.data.rot_mode == RGA_SRC_ROT_MODE_90_DEGREE ||
 	    src_info.data.rot_mode == RGA_SRC_ROT_MODE_270_DEGREE) {
-		if (rga->version.major == 0 || rga->version.minor == 0) {
-			if (dst_w == src_h)
-				src_h -= 8;
-			if (abs(src_w - dst_h) < 16)
-				src_w -= 16;
-		}
-
 		scale_dst_h = dst_w;
 		scale_dst_w = dst_h;
 	} else {
-- 
2.53.0




