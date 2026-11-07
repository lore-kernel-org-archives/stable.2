Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045783;
	b=xW23C2Mkw6t+2kIU/EZi24g921zdFGHJT3niSecJHoQvK9bKX8EuxMn9BtHmrRf90JSF
	 0Eg7EBjUWDQGPDyhWMo/rieouOoM06a181cOTWSjP7uNgn86A5uiJXi6weiZw9/Z7nG8I
	 Md/uJiOTHso/e4T37rgIyFt5nAJuXKDWij7k0giwSuSt2kmvwsZbpPHCmLSWosjGxDCOX
	 lUjA6i9Ty1QOXN9nlQXVCKdUoKntEb5EYWGWYfZMR3TKrIgTshnj9C6YRPg3Un3tqO8uJ
	 dcBd4Z+BjrBa+ugYwo1SWnbiLZUjEXpsLUhY6pefcMg9HhSfzqa83fJi1x4lElleBXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045783;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fbS0wIbLFR23nhGA45jPOX3QDxCVqtk6P8UOJ42X/p4=;
	b=sYkuVcnEPFRPjyvAMFtnTsiG2Fh/771GeCZBFeaiW/zEMDe9BEti68tpjNuWWVWoySf5
	 K3F2fUxRqHHDUSkWQo5Ohexjno2+KvUS5PaN6+8RyYvJaMI+YG2winWp2dYNbQ7CK+h0+
	 0wX8c75x0tbpevewxSvdhKyfbag7FhRS/i3vfYPR5ujQuOBlqQJAfWgSyrrQBpfRzOslW
	 8K4zcKYigY7iyEkmcEgtA7ugSvHMKjXEyLSH5dvuOMGJMq9HyC6t+n2s65714EWZ9kvAH
	 /LVfTM8fArHxHXBjAadhUiImMA/vL5+RrUgjRs7mvzrZUTm+5XTUEUqtjZjLBk95c3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGmwV8pQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED441606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGmwV8pQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9271F0089F;
	Sat,  7 Nov 2026 10:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045782;
	bh=fbS0wIbLFR23nhGA45jPOX3QDxCVqtk6P8UOJ42X/p4=;
	h=From:To:Cc:Subject:Date;
	b=OGmwV8pQavqgXAaez9JgNUZyNBsofa1GWzjo/CwdZiJBdhsm2fGUL4ehPbMu6eoQV
	 HcQD8E0zj/Jygu5rlR9PsazxrrWmEPUtXFUVqHQB7kihu4eRuCVMlK78fzbkUxHSe4
	 FTL5+CnJOAcNb2nZ2ev+QWyGAL7fX5wIpuzfHFVG70C3sGm6AlBPQvLNnY4+GqpIo9
	 uLS4ISITE/YgpVshrGEf2J7ZN0UR05cJkqXl+KJQF+9uxelJV3o4JNhXY8qdwCeGZy
	 wA7SBdJAOlBWgc5Q59nYn0yvbmCWi6hezJV/KxS9MjurH7WFhzu6t4Ww/yVZunAB2y
	 SqkfYI3EeFlGQ==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix SBGGR10 Bayer pattern" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:00 -0500
Message-ID: <20261107050300-failed-7.3-bb96c78c5f87@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x bb96c78c5f87072913f8825faebe64bf711a503c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050300-failed-7.3-bb96c78c5f87@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bb96c78c5f87072913f8825faebe64bf711a503c Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:06 +0530
Subject: [PATCH] media: microchip-isc: fix SBGGR10 Bayer pattern

SBGGR10 was mapped to ISC_BAY_CFG_RGRG instead of ISC_BAY_CFG_BGBG,
causing red/blue channel swap.

Fixes: 1e8f401474d6 ("media: atmel: atmel-isc: reworked driver and formats")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/microchip/microchip-sama5d2-isc.c | 2 +-
 drivers/media/platform/microchip/microchip-sama7g5-isc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 57a5aae3cabfb..5e41eee45dbd7 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -148,7 +148,7 @@ static struct isc_format sama5d2_formats_list[] = {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
 		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
 		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_TEN,
-		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
 	},
 	{
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index a841266ffc30f..9e78ea07b013a 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -157,7 +157,7 @@ static struct isc_format sama7g5_formats_list[] = {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
 		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
 		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_TEN,
-		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
 	},
 	{
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
-- 
2.53.0




