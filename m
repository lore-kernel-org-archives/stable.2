Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048236;
	b=PaQDazYDPMvRACyXtQXKvowr9GmibmjqewW0GgoqJ/Gu3fSDhi/17g969O0wCvwyEcFS
	 QCj1rpYzT0k+fIffbtg2bmHy+QNgZ+4A4PpwMvC5LkNqdVIgV46XcjO/iDWGeLlF5eES7
	 w5ACKdw60Wuud0W1XzUO86bP/gI4vJsWjMs95yRk+lWuAawEWUMM+6NwEwgvzNjRsvwCR
	 kZyYX2iz77yQ7PQRbp64vjZlNyn9lpxB1Em9vlqs2mICTrDy7byb92c0jijQX4saBh0G/
	 oPZUpBGhkuR3xaiLm9l5DnH5+NHhokvRaXLgTDse5yVUl8d8kiyL8AR9dFVzyioMSHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048236;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t17Cop97ze2+002ssMy1d4ISPR3xkBNObFSbMScXhks=;
	b=y/G2Rg9Py2A3+GPfneXb1StIukRYwg8ZNTrTlIkHj2Hg9zUbB4KOvo/uTT8aG8jyWmYt
	 RdNUfzp/5TJgDT17xpIYoJ53RDIjNWweTT3ziZFHkLVqoOLapn/9BRSJrbxHh2cdktGXN
	 4pDHf0p2YHPYb+nqUKnSrSXK5ksoxMbyFg0IzsYG3Mwrt2At2xhMRHrQJI+OHIewSvZUp
	 WRBLm6l7rrza9cc/CohT9dIROHx5QKYkuEh2YxERZjDrYNhxa7NmtX8tBXlgoE+kn59W8
	 kOoP7Zl3O/EoNu/AnX0XQpyGOZDrXlwS/XZK7iv19uHVEeUKuGGa6vTS7dHAyFOsnYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHbdRPNG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B80606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHbdRPNG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D8F1F0089F;
	Sat,  7 Nov 2026 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048236;
	bh=t17Cop97ze2+002ssMy1d4ISPR3xkBNObFSbMScXhks=;
	h=From:To:Cc:Subject:Date;
	b=EHbdRPNGrUQUhOQ9Ccpkhw4RZIKYFUoqbPL86NBExACh77q7qlmL1aE+7V2Ty0CWo
	 Kl9g70P+V+A3U5qsOeJq9HTGglpHKo3venlKwYWirpGcf6RHEjJW1dD1eKUBq1Z4Du
	 lX5GnlvVDFynoWG0BniWXUgUYlXam11b4Z3THQvGq0xd4/ChST/KXVNrryns9iTDPL
	 86XuFUG7EDv4MG9CrppCVIWogbYntaavNdennur39hstI2gghGU54ZZq4sXzKcMKqw
	 /Dhl6Uhxxg4vHYY5y2bbmd8biIgo+pUOhTUva47NZ44fc5wSiGDxR9ljFqWTxYwmFf
	 80WWlqdCuaH/w==
From: Sasha Levin <sashal@kernel.org>
To: nas.chung@chipsnmedia.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: v4l2-common: Fix P010 format info" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:54 -0500
Message-ID: <20261107054354-failed-6.1-8761a87aff82@kernel.org>
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
git cherry-pick -x 8761a87aff8259eab0add8a9428cee2c280fb6eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054354-failed-6.1-8761a87aff82@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8761a87aff8259eab0add8a9428cee2c280fb6eb Mon Sep 17 00:00:00 2001
From: Nas Chung <nas.chung@chipsnmedia.com>
Date: Fri, 4 Sep 2026 15:46:27 +0900
Subject: [PATCH] media: v4l2-common: Fix P010 format info

V4L2_PIX_FMT_P010 is a 10-bit 4:2:0 semi-planar format, but its
v4l2_format_info() entry described a 4:2:2 layout with a half-width
chroma plane. Correct bpp and vdiv to match P010's real layout,
consistent with the other semi-planar formats.

Cc: stable@vger.kernel.org
Fixes: 5374d8fb75f3 ("media: Add P010 video format")
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/v4l2-core/v4l2-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index c825820fd4819..11ab684024c54 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -323,7 +323,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV20,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 10, 0, 0 }, .bpp_div = { 4, 4, 1, 1 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 1, .vdiv = 1 },
-		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 2 },
 		{ .format = V4L2_PIX_FMT_P012,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 2 },
 
 		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 4, .vdiv = 4 },
-- 
2.53.0




