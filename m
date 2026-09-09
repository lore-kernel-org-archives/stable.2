Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC454D2ED7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951297; cv=none; b=mAdZ7LDsJbnidCWSjEvG0driIMUyqhiKS1hGJE3ikoNNG7U+Nou/r+yhglVEXyfA06PhMD57rc9QIfdjMIm7KxIAYWMYr9BCrYdwV9M6qO8Pzok8KJqyScDsfVmY/Xle29q7mQ0WzaZyUb9xlUN/YimcuCyfARvrtNut9Vi09PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951297; c=relaxed/simple;
	bh=B41rE4kgLlkW76ekx3G3CeuHfSPSLnnp2PU+4Pf3IS4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FOlnoYvt9emB5iEhNi8EllQhZ91yN39hu4FtWrI0IXWmpZkte04498nwhTKmP5NbsT1Wh5UzF0OIwGCYk30lr/qynKXk4DO/Hw4Frw9AcX4Le9BOF9Mk6vm0zRkXV/ZN7ewEnYy4sng/ev2u4uu5twCIc6Q9ztX22TX/NKV2kyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x+ihhtPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x+ihhtPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFA91F00A3A;
	Wed,  9 Sep 2026 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951295;
	bh=a8Y6xz4YkBi0bK852d1v/6WY2PnQzQUcPd3Z9gwU45Y=;
	h=Subject:To:Cc:From:Date;
	b=x+ihhtPclYvDFj9qExsW6ref0DGzg5LikRmE49egcUI87h6riBYrng7zz+48CRSr8
	 bHBe0q4ADCeso17qSi1W5/u84GUjEbCa8YGCV3Fg8dWs8+2jBL5U3fmI98HhI6s1hQ
	 giGDdN02o5d2PcaFv6nrbI/bKzWRPXWLE+fX2JcQ=
Subject: FAILED: patch "[PATCH] media: dt-bindings: nxp,imx8-isi: Drop fsl,blk-ctrl" failed to apply to 6.18-stable tree
To: guoniu.zhou@oss.nxp.com,conor.dooley@microchip.com,hverkuil+cisco@kernel.org,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:44:53 +0200
Message-ID: <2026090953-widely-numbing-ac50@gregkh>
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
git cherry-pick -x fc312f830d8df6c082bd6f7250aa5c0ff063eea4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090953-widely-numbing-ac50@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc312f830d8df6c082bd6f7250aa5c0ff063eea4 Mon Sep 17 00:00:00 2001
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Fri, 24 Apr 2026 14:49:50 +0800
Subject: [PATCH] media: dt-bindings: nxp,imx8-isi: Drop fsl,blk-ctrl
 requirement for i.MX8ULP

The i.MX8ULP variant does not require the fsl,blk-ctrl property. Add
fsl,imx8ulp-isi to the exception list alongside fsl,imx91-isi.

Fixes: 288517a3c6c9 ("dt-bindings: media: nxp,imx8-isi: Add i.MX8ULP ISI compatible string")
Cc: stable@vger.kernel.org
Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260424-csi2_imx8ulp-v12-1-da148eabc035@oss.nxp.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
index b59c4ce30b8b..279c9cd3034a 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
@@ -117,7 +117,9 @@ allOf:
         compatible:
           not:
             contains:
-              const: fsl,imx91-isi
+              enum:
+                - fsl,imx8ulp-isi
+                - fsl,imx91-isi
     then:
       required:
         - fsl,blk-ctrl

