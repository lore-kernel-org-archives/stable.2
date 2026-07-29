Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1A485CF1
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330109; cv=none; b=lIBUPZe/LJeoyKk0n8mtd7zii7LDavlMMjZ+jHHUGpywy20i8gx0blg/PiRhdT5Z2ZPoIb8Cs/8uxa3mhlDqf+7vSDUJhhR8BWay+7d1wmCdjNfX6cq5IJMOqf8syhEl4ZsszN7ggdGJg4FM7/kOxuqU8ZDO5KjG+6uL8dWUkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330109; c=relaxed/simple;
	bh=BRLmQYiIlLZyy3BaABKLK6sDTdN3Asopg0I7bw5E4YE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J8E99YQUAVk1Td568Mtu5cLqMysfilrJpqC8pwHLWMsjhk2h1eGDt7GB/RPTtDWqgarNiuy9NStHxvuwwE5EGJfLyt7M/n3KwvV1r37dDzItQe27+yqmLkpc2VtGhzvDhNS/V8Hqv/0xCiEIzKelaCEUD9fEKn+ZRjD+Tk2aAMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pL4DR1JL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pL4DR1JL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101761F00A3D;
	Wed, 29 Jul 2026 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330105;
	bh=oACE/+a0WQla8gnmtEnQu1nfQbMswX4LP/5LtGmEPes=;
	h=Subject:To:Cc:From:Date;
	b=pL4DR1JLw8jZY+46hihyU/woU7op4+Ujz+EyBkXu37ZKX7+XvYeiOtGLrYAvHpRZG
	 tNVE4p9RAcU2lEwgNTjShwZvJw7P6btdLdE5oNGq5Vo2UxdBqINyNH8KtKPlLuzR+S
	 MNPV8kKvdnZNMBGWhbkzV62swMM0Wida/dg9RjcU=
Subject: FAILED: patch "[PATCH] media: qcom: camss: Fix RDI streaming for CSID 340" failed to apply to 6.18-stable tree
To: bryan.odonoghue@linaro.org,bod@kernel.org,loic.poulain@oss.qualcomm.com,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:59:33 +0200
Message-ID: <2026072933-pungent-everyday-da96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x cc1c35619c9895f918f9e388e3caa6ab2ff2fbe7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072933-pungent-everyday-da96@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc1c35619c9895f918f9e388e3caa6ab2ff2fbe7 Mon Sep 17 00:00:00 2001
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 7 Apr 2026 11:34:52 +0100
Subject: [PATCH] media: qcom: camss: Fix RDI streaming for CSID 340

Fix streaming from CSIDn RDI1 and RDI2 to VFEn RDI1 and RDI2. A pattern we
have replicated throughout CAMSS where we use the VC number to populate
both the VC fields and port fields of the CSID means that in practice only
VC = 0 on CSIDn:RDI0 to VFEn:RDI0 works.

Fix that for CSID 340 by separating VC and port. Fix to VC zero as a bugfix
we will look to properly populate the VC field with follow on patches
later.

Fixes: f0fc808a466a ("media: qcom: camss: Add CSID 340 support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>

diff --git a/drivers/media/platform/qcom/camss/camss-csid-340.c b/drivers/media/platform/qcom/camss/camss-csid-340.c
index 2b50f9b96a34..0231985746ed 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-340.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-340.c
@@ -74,9 +74,9 @@ static void __csid_ctrl_rdi(struct csid_device *csid, int enable, u8 rdi)
 	writel_relaxed(!!enable, csid->base + CSID_RDI_CTRL(rdi));
 }
 
-static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 vc)
+static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 port, u8 vc)
 {
-	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + port];
 	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
 								   csid->res->formats->nformats,
 								   input_format->code);
@@ -88,14 +88,14 @@ static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8
 	 * the four least significant bits of the five bit VC
 	 * bitfield to generate an internal CID value.
 	 *
-	 * CSID_RDI_CFG0(vc)
+	 * CSID_RDI_CFG0(port)
 	 * DT_ID : 28:27
 	 * VC    : 26:22
 	 * DT    : 21:16
 	 *
 	 * CID   : VC 3:0 << 2 | DT_ID 1:0
 	 */
-	dt_id = vc & 0x03;
+	dt_id = port & 0x03;
 
 	val = CSID_RDI_CFG0_DECODE_FORMAT_NOP; /* only for RDI path */
 	val |= FIELD_PREP(CSID_RDI_CFG0_DT_MASK, format->data_type);
@@ -105,10 +105,11 @@ static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8
 	if (enable)
 		val |= CSID_RDI_CFG0_ENABLE;
 
-	dev_dbg(csid->camss->dev, "CSID%u: Stream %s (dt:0x%x vc=%u)\n",
-		csid->id, enable ? "enable" : "disable", format->data_type, vc);
+	dev_dbg(csid->camss->dev, "CSID%u: Stream %s (dt:0x%x port=%u vc=%u)\n",
+		csid->id, enable ? "enable" : "disable", format->data_type,
+		port, vc);
 
-	writel_relaxed(val, csid->base + CSID_RDI_CFG0(vc));
+	writel_relaxed(val, csid->base + CSID_RDI_CFG0(port));
 }
 
 static void csid_configure_stream(struct csid_device *csid, u8 enable)
@@ -117,9 +118,10 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 
 	__csid_configure_rx(csid, &csid->phy);
 
+	/* Loop through all enabled ports and configure a stream for each */
 	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS; i++) {
 		if (csid->phy.en_vc & BIT(i)) {
-			__csid_configure_rdi_stream(csid, enable, i);
+			__csid_configure_rdi_stream(csid, enable, i, 0);
 			__csid_ctrl_rdi(csid, enable, i);
 		}
 	}

