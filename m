Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66F48876F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330110; cv=none; b=KfxkHOcVJlALN0w8PcLFMgaVh8lA+Eg9/zIbrRTyGWhmAdPNKvBs8valYZvdZ6groI1b0jhbDNdjyd8NjVvnmfEqN+ZCGahybfTUkHilFhduFHYLFhDz3QF/2feWJKKA4YO5CwxPG1YW+GNFkjiiAhbYXYYAYKGzO7DhTRANO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330110; c=relaxed/simple;
	bh=A00yqlzYF6x5jl7VhRSX9leNzBMT2YUKAz+Z9zEV4yM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gUEJ56LOf2fStkFAvAN+SMxQl84IgoBfjlKCPJe35Ia9i+gx2oKOwCHR4IxYCbLXYBygUaWtlb/Aq/C4KzL9NGWjXkocexTZC01EkjQHh7IfHqbuDyCzmN9o/OUg+MGtnMS0B10g7teKwJ8/W6Ed8j4Re/BLkm33pLHeMBPE5lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fbw1PkU8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fbw1PkU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB8E1F000E9;
	Wed, 29 Jul 2026 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330108;
	bh=bSEKXG5yf/YNKqPTQ/SjA3H7ngOc272I2FVNVTHAT14=;
	h=Subject:To:Cc:From:Date;
	b=Fbw1PkU8OBQwUshfktOp92w/aRZrc90XBOtbHHYHAkvnALG09gAY314ZDr2o7GNdR
	 E03QaJ9UxJ4A29E4Vv1iq9cTAjo2pZOH/ZFe4I0HzMKJBfIy6mEXHL0B2SYUPYlp5C
	 wSa9NZ+6d2lnsgCaZVSUSnm0VJ2tc4RuJo/Lgo9E=
Subject: FAILED: patch "[PATCH] media: qcom: camss: Fix csid clock configuration for sa8775p" failed to apply to 7.1-stable tree
To: wenmeng.liu@oss.qualcomm.com,bod@kernel.org,bryan.odonoghue@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:59:39 +0200
Message-ID: <2026072939-rake-crisply-d981@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 27c6817bbc0edfe11669d0185e7ae5dc7a113edb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072939-rake-crisply-d981@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27c6817bbc0edfe11669d0185e7ae5dc7a113edb Mon Sep 17 00:00:00 2001
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 18:13:03 +0800
Subject: [PATCH] media: qcom: camss: Fix csid clock configuration for sa8775p

Fix the mismatch between clock list and clock rate table for CSID lite
instances. The current implementation has 5 clocks defined but only 2
are actually needed (vfe_lite_csid and vfe_lite_cphy_rx), while the
clock rate table doesn't match this configuration.

Update both clock list and rate table to maintain consistency:
- Remove unused clocks: cpas_vfe_lite, vfe_lite_ahb, vfe_lite
- Update clock rate table to match the remaining two clocks

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Fixes: ed03e99de0fa ("media: qcom: camss: Add support for CSID 690")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 00b87fd9afbd..cb0134718985 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -3598,12 +3598,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID2 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite0" },
 		.interrupt = { "csid_lite0" },
@@ -3617,12 +3615,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID3 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite1" },
 		.interrupt = { "csid_lite1" },
@@ -3636,12 +3632,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID4 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite2" },
 		.interrupt = { "csid_lite2" },
@@ -3655,12 +3649,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID5 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite3" },
 		.interrupt = { "csid_lite3" },
@@ -3674,12 +3666,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID6 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite4" },
 		.interrupt = { "csid_lite4" },

