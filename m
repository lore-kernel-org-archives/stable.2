Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312284;
	b=HgLpOGX0DcZ51+c+CxnVYLc8rJpcQr6/oOWA8masJ7kHrv52hn+FdGbZrVgnsXFeabuQ
	 t6J/dZCLNo8jPX4NgTAYC9lNHJMNWJ2JM9dR9ZCp8IoHOO3Esix+pieVZpVNSGvssGByn
	 np6XWn09EXwwczIcS/pwU7BOlttL03efkbKfeTLlfZrl0t1jUlfReuJkJeJNDmTJFxnw4
	 Pb+WQFWzh4UUGitgk/yuYGiOQ7LNBYBjxxNUr0IkDgffJrOalXEnh/RIUcktMrE7rBjtS
	 zOLIqLBnOYj7vOJAsfE0Ij92Nabv0l0ofHJSjEoBnZNLUBoL5XR5HfxuazhVHYui6DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dhHAQeu9oUtrGKOchQZz0sO8AYTgScEfmdJqYjqDO6M=;
	b=bKwC631Ko6fFJDXVod2Ek1aBUq/jUp/LyiC8cjtNFMnCd4CMwI6c1mvFNbrrNHINj/kZ
	 GTqoCICDYR120bv3OrbQG9BFItug5zZbxFsteCW8HL6U27gAjlZzh85g8GPl5XSIMXRFt
	 fQOG0VoV9yhXsWSxU9uC/Zf78pIHRjtieVxStH+/5S29TbWjJmiuFRAKLG5WmNQhNQdbi
	 eNZpZ4Z5T/1SBNN9xuFxYKmPWR7E5j5JLXIeUx+h0nnjo3bialeGgI1HIyH4tTPy7MpRO
	 2Aseyb6UYHugJDu6BLq7s8BNLh8TbFpFkyzCR1pN4jk7Z8HKS6Gy96YfOahrgNaz3xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Om922ZP8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01812606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Om922ZP8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E063B1F0089F;
	Tue, 10 Nov 2026 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312283;
	bh=dhHAQeu9oUtrGKOchQZz0sO8AYTgScEfmdJqYjqDO6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Om922ZP8r87+wv0fTYJwXPmEUUx8myiz2f4nT8tM+VL7vg+N+kP4yUhhEtAqC64M1
	 btgEIzSnjXrtebt7XjBY4T6UTjom4U62RlENH3TpADqsmqDxGTi9YvhtjzRyc+x05G
	 LZgzx2WAMIL6Mg6wlUA5++HkfLenDnQihvrFFITeG2vMcxvpJIuPPa3MFW8dI12c5z
	 W4SvoL/oaYlg2QZBAGddp2443eElAbOJOwH6Su+NfQFthGyFR+/EV4cCyDJS1FG8Rr
	 mN9dWSrUpCeCZ/LtlX9Har5axbmC8UEzCsbgA5i8aay5uPPXnwSkEGb/yILKYd6hq5
	 FOCHENHiUjZUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] media: microchip-isc: store the unshifted PFE_CFG0 BPS value
Date: Tue, 10 Nov 2026 07:04:39 -0500
Message-ID: <20261110120434.946561-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051644-failed-6.12-bb96c78c5f87@kernel.org>
References: <20261107051644-failed-6.12-bb96c78c5f87@kernel.org>
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

From: Balakrishnan Sambath <balakrishnan.s@microchip.com>

[ Upstream commit 14cbe597504a04c5c49342d0566438e2b438a948 ]

pfe_cfg0_bps held a pre-shifted BPS value (ISC_PFE_CFG0_BPS_EIGHT was
0x4 << 28) ORed straight into the register. The other format selectors
like cfa_baycfg store the bare field value and position it at the write,
so this one was inconsistent.

Store the bare BPS value and apply it with FIELD_PREP() at the PFE_CFG0
write, and fix the pfe_cfg0_bps comment to match. No functional change.

Suggested-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: bb96c78c5f87 ("media: microchip-isc: fix SBGGR10 Bayer pattern")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-base.c |  4 +++-
 drivers/media/platform/microchip/microchip-isc-regs.h | 10 +++++-----
 drivers/media/platform/microchip/microchip-isc.h      |  4 +++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 3d09c421f370e..9c8d02722f92d 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -8,6 +8,7 @@
  * Author: Eugen Hristev <eugen.hristev@microchip.com>
  *
  */
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/math64.h>
@@ -291,7 +292,8 @@ static int isc_configure(struct isc_device *isc)
 	struct isc_subdev_entity *subdev = isc->current_subdev;
 	int ret;
 
-	pfe_cfg0 = isc->config.sd_format->pfe_cfg0_bps;
+	pfe_cfg0 = FIELD_PREP(ISC_PFE_CFG0_BPS_MASK,
+			      isc->config.sd_format->pfe_cfg0_bps);
 	pipeline = isc->config.bits_pipeline;
 
 	dcfg = isc->config.dcfg_imode | isc->dcfg;
diff --git a/drivers/media/platform/microchip/microchip-isc-regs.h b/drivers/media/platform/microchip/microchip-isc-regs.h
index 166f57e6ed5d7..cabecf128b37a 100644
--- a/drivers/media/platform/microchip/microchip-isc-regs.h
+++ b/drivers/media/platform/microchip/microchip-isc-regs.h
@@ -31,11 +31,11 @@
 #define ISC_PFE_CFG0_MODE_PROGRESSIVE   (0x0 << 4)
 #define ISC_PFE_CFG0_MODE_MASK          GENMASK(6, 4)
 
-#define ISC_PFE_CFG0_BPS_EIGHT  (0x4 << 28)
-#define ISC_PFG_CFG0_BPS_NINE   (0x3 << 28)
-#define ISC_PFG_CFG0_BPS_TEN    (0x2 << 28)
-#define ISC_PFG_CFG0_BPS_ELEVEN (0x1 << 28)
-#define ISC_PFG_CFG0_BPS_TWELVE (0x0 << 28)
+#define ISC_PFE_CFG0_BPS_EIGHT  0x4
+#define ISC_PFG_CFG0_BPS_NINE   0x3
+#define ISC_PFG_CFG0_BPS_TEN    0x2
+#define ISC_PFG_CFG0_BPS_ELEVEN 0x1
+#define ISC_PFG_CFG0_BPS_TWELVE 0x0
 #define ISC_PFE_CFG0_BPS_MASK   GENMASK(30, 28)
 
 #define ISC_PFE_CFG0_COLEN	BIT(12)
diff --git a/drivers/media/platform/microchip/microchip-isc.h b/drivers/media/platform/microchip/microchip-isc.h
index f5e322c2e36bc..d7bcd74efff92 100644
--- a/drivers/media/platform/microchip/microchip-isc.h
+++ b/drivers/media/platform/microchip/microchip-isc.h
@@ -62,7 +62,9 @@ struct isc_subdev_entity {
  * @mbus_code:		V4L2 media bus format code.
  * @cfa_baycfg:		If this format is RAW BAYER, indicate the type of bayer.
 			this is either BGBG, RGRG, etc.
- * @pfe_cfg0_bps:	Number of hardware data lines connected to the ISC
+ * @pfe_cfg0_bps:	ISC_PFE_CFG0 BPS field value (e.g. ISC_PFE_CFG0_BPS_EIGHT),
+			written into PFE_CFG0 with FIELD_PREP(ISC_PFE_CFG0_BPS_MASK)
+			at configure time.
  * @raw:		If the format is raw bayer.
  */
 
-- 
2.53.0

