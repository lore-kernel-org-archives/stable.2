Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046095;
	b=M7lgL6r01UQXUt3r/l/16biMn9Xx/y7btSbKCcSqFu8x/PEc9m5akZ1hW7+kQmpLZYf/
	 zRbDStG5qLonXqvHdSMbjdljMHd/VMLgHEwqQyGFddDrIgFukGOEqcAIy9U1M3bNn2gA6
	 uZDMf63Mw3tE0HJIFflaHszDCHB7hxsxtCge3eGohDtVp6t93/SAB1TTevdtyA+H9HxQ9
	 Exar4iPyQyYblzW9DRHJkTY/vPqJBRLGSPRLVQABWZ80rY/7NfMrmiyOTf+5Ak9ZoGPJU
	 IOWdeQGK/V8mkAQnEpvbCMEx9hWFNcptbiiNLoL3Xq4gK9NUf57B83OCzO2Dzygg8Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046095;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xvSTCo43Rs6WXqGHjqWIV8Hhx9vKfrLBTrXESSJfGxU=;
	b=gPk3zrouWA2wuTtwmwt8pPjBijczVX6og0RhHKVBsdTcdIgyTspE9RgBa5Ena1SyvQab
	 BOK8Md3uyYxy6uOniKQ24vA7FQbEGCWBFnqOqvqNlEme1z4FeOpoQAQPScKw/jYkhhgUN
	 IVp888aG0HCDp6wlxjwrncKrbuJi2jxBaERQerzg4WeNSlK5MiQ/3hmffX0axhL63Dh0h
	 +faSJehOWXAuLBfoWaKmanKGQJzdmiWiI7FMqu4fbx+/9eF8l/HlXxk9c4uPaSjJVmqKa
	 h0PkceNL+C8dvFAM6j7gvYPio0eaG8opUFFXpDQSR5D6ih55ORCKY1aFFhaCN2+i2pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYS6E1p7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYS6E1p7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA101F0089F;
	Sat,  7 Nov 2026 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046095;
	bh=xvSTCo43Rs6WXqGHjqWIV8Hhx9vKfrLBTrXESSJfGxU=;
	h=From:To:Cc:Subject:Date;
	b=AYS6E1p7BCPWBdNoh0E+ICBBZ1rA6bW40StHXYxo48M+1T5+mdt0zYfNIiVf9w9r9
	 72HLI5J2Rel1yHYKK2DgNJr4sNbQ89ZjqRCDI3yq7ZONDlVgrqaRBPHOLknOTHoMp7
	 yah9Zusxitw00sNyIVSGF67uVMslDD9oMcTjEMpSk5PT8Ggr50UlShjLuM/xe+GAEE
	 /aXbYaTvgWI6rJgDhBZqkVh0IMl54MAZuToGMwqXQ8+0L/xXoNpxXyZiGTFH4bhJxG
	 PTdhrsh1FPxdzj0MXcAwLt5OKG/ucdhcdMyM5a2fA4sZ/fs78oGErhN3hO45RuB0TU
	 g8IPQFjiQygQw==
From: Sasha Levin <sashal@kernel.org>
To: jkeeping@inmusicbrands.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: rockchip: rga: fix rotation on rev0 hardware" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:13 -0500
Message-ID: <20261107050813-failed-6.18-a67578c01798@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a67578c0179850e80cf08b1e0b8b1eb857f0fc46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050813-failed-6.18-a67578c01798@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




