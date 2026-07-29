Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9D488DAA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330121; cv=none; b=TaPGxU4HjOb4ZRnLLF+Sn3vd8Hs2FP9ZMyQPDfs/J558fPEOn9mu/MSfm2FiYDR4sDHv1imxyhwxDWJbPf6rI4Drw/eL1vjS/2Se9/BWhnJe1TJD/Yjr94WusvlgpTChvKh17D++75h8r63sF3zax28coFAaX3OaeGPnbpbrynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330121; c=relaxed/simple;
	bh=ZGrY47xSCxv+6z4/yKKTmThOuf9p5gqB38kT37B7kq4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mbbo1kdIjI/wiF2pHmGOVod4MvGWcZk6oN434z2OyF6ezuI1kISKLCqeG+XsHkvXWoPHQLHlLmQ1vlK5AZePYbR4in7wziZY+YmjrFQLLYYKTui+f+1jQznmSH7JvdssfQ+NMtXrb3CQsQoeYn9oJFrrXtcGymzYpWfmvFboEk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNtFetKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNtFetKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E83F1F00A3A;
	Wed, 29 Jul 2026 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330116;
	bh=rKU6rX6A6RlIQwKlNKmohB9X0WMeKxGFx/EPgAGcMxo=;
	h=Subject:To:Cc:From:Date;
	b=bNtFetKuAJghCYilLwa49omGuJfmRD1ISUPcqK5vhgrkphamy4efx0AYFu0YKeK23
	 nhJ2vtzuvUKoWplGPX39KXqV7rTjmNW9C42U3Ow4lOgqfnf3dKCozGdcd/bwNga7/Z
	 lP8I1X0qZ4FuUVHtiModCkbjv0dDF7TSIuyZr3u4=
Subject: FAILED: patch "[PATCH] media: qcom: camss: Add missing clocks for VFE lite on" failed to apply to 7.1-stable tree
To: wenmeng.liu@oss.qualcomm.com,bod@kernel.org,bryan.odonoghue@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:59:46 +0200
Message-ID: <2026072946-recite-glazing-c93d@gregkh>
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
git cherry-pick -x 924f45e58b1fefca0e6accd45a508029436e112e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072946-recite-glazing-c93d@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 924f45e58b1fefca0e6accd45a508029436e112e Mon Sep 17 00:00:00 2001
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 18:13:04 +0800
Subject: [PATCH] media: qcom: camss: Add missing clocks for VFE lite on
 sa8775p

Add missing required clocks (cpas_ahb and camnoc_axi) for VFE lite
instances on sa8775p platform. These clocks are necessary for proper
VFE lite operation:

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Fixes: e7b59e1d06fb ("media: qcom: camss: Add support for VFE 690")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index cb0134718985..9335636d7c4d 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -3742,15 +3742,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE2 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite0" },
 		.interrupt = { "vfe_lite0" },
@@ -3765,15 +3767,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE3 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite1" },
 		.interrupt = { "vfe_lite1" },
@@ -3788,15 +3792,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE4 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite2" },
 		.interrupt = { "vfe_lite2" },
@@ -3811,15 +3817,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE5 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite3" },
 		.interrupt = { "vfe_lite3" },
@@ -3834,15 +3842,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE6 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite4" },
 		.interrupt = { "vfe_lite4" },

