Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C446E017
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125995; cv=none; b=VaUFesLuDyceb52KC4cyAEvbCtoXJxTwIeZw+/pmTLNhVoXgVmQdCSO+UUUnJ+3MmUfR1NfS8vUOdn18TvYjKwyNCV+1v4ObXUPYd47+kNfNDlVw/8c7wX2tKnORdAjqIvPV8PNF0BOkTiXb6uCmT7X8rHepPwInlqoV9K1UGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125995; c=relaxed/simple;
	bh=yxXUAmkVc0pNWgSUCRJZ6mPRAdcYq0a8I58xBk+jIL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9mMDfLGVVxovCNZgNB6RIUc7m5kAMxHLUmIE3cC2emy/pwCJSL4YZLX+G+SR5e+GV1vanlh3fuigs28m1U0Q0UlM0+GO70XRFJX2L5kK/4/FEh1SUJ5c1iA431uBfh0AyK/qhHnEnXzD+i22CHMStuRzfEf+4h32ODGk9Av8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xry43HC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xry43HC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D8A1F00898;
	Fri, 11 Sep 2026 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125987;
	bh=I+FebFjUK8mkKOCpfNao8DITsutBF2srOreNv4KZWL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xry43HC/cEN10HzApTk99n7wmGU3NNLGJm7Za8GGM3T9k9RDPhCQVYWAoarTLMP+g
	 7CUe30GANMMiWNGJ+MZbASefBEP7kahQH4xEBAAyPznHGeiH1OTcbSQNUkKcN5Wtyq
	 ZgGPbdssPokZ703lKzWASdE/SOj4/MyUtqYPIoD+ls5jvkLNx7aUNZBpygf8nQMRO3
	 P6reOoo0FvdqfsW8aRt81UJ/r75NC8Uclw8cUM5eC0czZHklfdsL5c/OIbV98KNxET
	 Tf22jS/eY6C35gjhbd3hMVF5MwvJi0E1OemivrHXjMaz3CzrK3PSfSaGuJgkaODRKf
	 5aqOXzfnC+CVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: dt-bindings: nxp,imx8-isi: Drop fsl,blk-ctrl requirement for i.MX8ULP
Date: Fri, 11 Sep 2026 07:26:25 -0400
Message-ID: <20260911112625.381581-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090953-widely-numbing-ac50@gregkh>
References: <2026090953-widely-numbing-ac50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>

[ Upstream commit fc312f830d8df6c082bd6f7250aa5c0ff063eea4 ]

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
[ added the missing fsl,blk-ctrl conditional using const instead of enum because this branch lacks i.MX91 support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/media/nxp,imx8-isi.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
index f43b91984f015..d5e631f339a08 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-isi.yaml
@@ -66,7 +66,6 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - fsl,blk-ctrl
   - ports
 
 allOf:
@@ -109,6 +108,16 @@ allOf:
             - port@0
             - port@1
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: fsl,imx8ulp-isi
+    then:
+      required:
+        - fsl,blk-ctrl
+
 additionalProperties: false
 
 examples:
-- 
2.53.0

