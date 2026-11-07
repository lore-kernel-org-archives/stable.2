Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048243;
	b=Agiyy7h7tPHP+BWI1b0L2lz5vXQxXGflnlGbDKoFCFItmBGvRxgsrOYFTU4FHj+UfViE
	 ne0BdYeCMkLe1I/g9g+vmcWfgnhKOO+G+LFMrFk0T7ov97W3575Gh7rZubjbb3rWAVQym
	 ei2D50pzW0mcWMdHR+dnk+l8mpwPFqX+E9emq9RNCovQV4eFd/V/HA6qOw4maiWsMoqNC
	 iBrbXsv2khKAAjLPrHdiCD+LbfKiT4DMV4oHExja4bgfou465v35y3lAMKcGo7J/MrZH7
	 WJlo2+HowhzhxwBSngHiNIJK5ehuuJWes7fMEJdhloWhBL3DOIOLm83fcrGTNzBN5kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048243;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dnUALRqCYEF6t/uFzaCAbbZuzyjn0SGUgwqNM4Qvdj4=;
	b=DYpHw3OkWC+fQ97gPeNhKNA8kSd/+t05CzHYt+ESKYIO0BMb/NWgQCzbMZYcEF3yMYeJ
	 SEFRPe3+5/3nejsD0DWxM0G3scX4aPJasJRSxuUVnAS3+BOb3P6TJwSQazxl6PSFP4sPb
	 QtZYaE37FkSu28Ee+HZJzPZxRrrsc1XX0m0sMBOzSkp0Fkv+dZrkHChBSrw489aU+saOe
	 LKQIRtRSdBHZ10DsgS6KgBd2HV/d7lp8UL/THjSwfPiEiahz7y4PjKaxA/ah06ZK4SHa+
	 ZP+u5xFbes1o30QJlXMsERwVLze4BU0ykwkkum98PbdQaxRq2q6uE1jGT+ZKknIbScA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMGJ12Pb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E84606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BMGJ12Pb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F40B1F0089F;
	Sat,  7 Nov 2026 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048242;
	bh=dnUALRqCYEF6t/uFzaCAbbZuzyjn0SGUgwqNM4Qvdj4=;
	h=From:To:Cc:Subject:Date;
	b=BMGJ12PbzdRptopL2FL55Z6J1o+KMWBtmtihoeUvt7kyHtvFhxUoXS06pY+7NpOuz
	 ddwepvTnAzrhXhRD6MRX5zf0jMNOPtU+meVsLHSoxRS2JBbbjBU5i+Piua80olQAzE
	 i7Yue5froayrHGujlM04PG71jNh/5q60nVnm3k5rzcEaFjFl7aQ5rnrf44Z1dfOxNF
	 EWOSel4uHE5mg5SCKoV3x0QBf6QOoFILwH/JRHLpT9uLONhFDILLy4gmiz8nRaR8wC
	 LroOrBy+760EwhnjxHcCtjUQFMaa+AFiQ7l1ZAoBl9m2C2V0r5Q0yamhzKbz10d14V
	 KnumZ74no3Rkg==
From: Sasha Levin <sashal@kernel.org>
To: jkeeping@inmusicbrands.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: rockchip: rga: fix rotation on rev0 hardware" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:00 -0500
Message-ID: <20261107054400-failed-6.1-a67578c01798@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a67578c0179850e80cf08b1e0b8b1eb857f0fc46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054400-failed-6.1-a67578c01798@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




