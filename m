Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E62DFF04;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394392; cv=none; b=cTEoJdrWby7AOL9+DTybwA+7KP9rLvQcVRbkfqc6uSmw3M8dHi3lvmFqR0Pe8QDC0fXRJFSl93KbauIEAkgqlPNzhhA25YTHElnyCsL8kyaqza/t7ba8wjvMVWmDlzKUHyf2KBbQt7m3nQv4e5TOmxESQ2+qvxDZppWN0/mtoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394392; c=relaxed/simple;
	bh=+pzC4MgggAqh94dvxJCxx/cQIdDxbqD+7O8JFQFFrks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWv9Rdb05CwYxZrC7AnRGY6WJUYtLJcZ/lq31z4OQy20CyTto4SfK8TSBvh9lUIuxOVcOJzN3w723dHiBibT7UoQzQT3luhlUz1NNdVal7MhP2lWNCN/qhCFOxeNdJxDcrC2B3TfRSJrpTSAl+Z+8fZESfCPfETtaCzqDLIuytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChnISspS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChnISspS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A1E5C2BCF4;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784394392;
	bh=+pzC4MgggAqh94dvxJCxx/cQIdDxbqD+7O8JFQFFrks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ChnISspS8HzuW5859ZIErhewOP5Svk/r+BQN5bVBbYFQ1FJ0UyU40mO/XLY4vjHbI
	 l1v+zEKduIVR3cs0g5B3uEcNoN+4a+7IwLDPg/SN0qqLmDfUNXsr/Q98iP9XJGPOcd
	 vQZ+s1cxkIfPe7RuNsE5nRlIU+T0pVeueS0UOmxsi736zAP0dJvoFJ78275M+mnDU6
	 pjNP79TXct3glV3hYQAIOgnfcrZ5aeTTxpvjpJ3dmFUt8QU9jLKVxdIDaECI0GB752
	 P0Gc3OERjSQ4IrEuEUgrCdlFe1FzHjgIwDv8QE8MysD21CQ2YNWoDuBEve9n9Nv9j6
	 0JGnq97Ni98pA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E24C4450A;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Sat, 18 Jul 2026 19:06:29 +0200
Subject: [PATCH 1/5] dt-bindings: usb: parade,ps8830: Add
 parade,disable-usb4 property
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ps883x-disable-usb4-v1-1-cec86d0b909e@oldschoolsolutions.biz>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
In-Reply-To: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 stable@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784394390; l=1158;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=yrl6VP90X+qBDgzq2kPIZXWW8gy8rpei3j/WcM153qs=;
 b=6G4y8ZLykC2QUUG4dfWiXI32wWerJe6esfFw3KbJfJZLUiI4JDqQYl/7mj88BqmQqJssaMILn
 21ybx/ri+6fDQP7ERROm3WUmrOprk1reEvYPHWR76UqnDwVSutt4EJ2
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Document a new optional boolean property "parade,disable-usb4".
When present, the retimer rejects USB4 mode by returning -EOPNOTSUPP,
forcing a fallback to USB3 + DP Alternate Mode.

Assisted-by: Grok(xAI):4.3
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 Documentation/devicetree/bindings/usb/parade,ps8830.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
index eaeab1c01a594..44242907461eb 100644
--- a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
+++ b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
@@ -66,6 +66,12 @@ properties:
           Sideband Use (SBU) AUX lines endpoint to the Type-C connector for the purpose of
           handling altmode muxing and orientation switching.
 
+  parade,disable-usb4:
+    type: boolean
+    description:
+      When present, the retimer rejects USB4 mode (returns -EOPNOTSUPP).
+      This forces the Type-C stack to fall back to USB3 + DP Alternate Mode.
+
 required:
   - compatible
   - reg

-- 
2.53.0


