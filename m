Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C53016E9;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784394392; cv=none; b=Dks5lm4vSskd4Y4wuPK3P5SkeEsZR8XyKS20QtvpecxsNQsbfOSmtIrbKzXSbIk/Q5+qK70P8THh6fKtlO/Rw5tFXdSem3EDsmxya8Fz1PZg+U25lnhmiRC7YYt/qYnm0itfyEmw23GPIl0q0lO/JisMwUV6hrat740xx3yoiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784394392; c=relaxed/simple;
	bh=flQxxyDGkNUZoBzNF8N+d/9NpxfyJZHQ27EXOZvmc/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qzZ2RQP/9U8EArDAPXgvJQ9zLZk5d1nHxWsj6saDD5DxbpSrjbbMHWWSPRkEhIsfHjcCUCiNyRVf8abybkGA4FUlPduj3/ublWyV38Dqm4lEqiRVKfs9LKGp99sbujxOrD1Ugc761eUDeyiimOFKfe1Uku3XvlNmCsHH6fraU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfwz+kQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfwz+kQn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D4BBC2BD00;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784394392;
	bh=flQxxyDGkNUZoBzNF8N+d/9NpxfyJZHQ27EXOZvmc/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mfwz+kQnIvxM436oqg7hjkaPkG/lBaKOJX5vG6O7DwtUlfB1TmsXh+Himit7F4s7n
	 zG012+f6ZQU538kmC1OSInmOGn2e/+/LMEzuot+ZDhEnZIVJJIm2UW1RB6K/Z6+8xS
	 UGm2pwfM3eD8ZwZ1H6Y6rFiOK3XVi7MDuT9O7CqcrqAEqRoVKT2kYQOd1r+pC9HEe/
	 m8d9UA6Tb32suJrkI06pXIx1af6nLnBTfzeI8Kv4hOvtCW6Qf9jMtVoSXy0JKH48zE
	 48xSYVLC31zfwhaCo/Bqbr2Qy8IU+hokv9xoKRa04D3LxExy0IsxaeuyGngc+N91sG
	 aH3hGp32bSmcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C9FC4451B;
	Sat, 18 Jul 2026 17:06:32 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Sat, 18 Jul 2026 19:06:33 +0200
Subject: [PATCH 5/5] arm64: dts: qcom: x1: disable ps883x USB4 capability
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ps883x-disable-usb4-v1-5-cec86d0b909e@oldschoolsolutions.biz>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784394390; l=11157;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=fJSmHKoLvyhaB/YtE0COu2+cIXH4xBGgcS2JfmoUp44=;
 b=p47O4I33BvemI+8ybEtxPmTyjzDNLwtKY6QPUgXt+88kDv8y7mID89ZaVszJ0OIJOVZAeSoBK
 cKxTibSTfryAwrzqQ/GBR5fPSM6kWlxNMUaze4CHV2lY3yrynb+eK2r
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Add the "parade,disable-usb4" property to the PS883x node so that the
retimer driver treats USB4 as USB3. This allows the combo PHY to remain
in a DP-capable mode, restoring working DisplayPort output over the
dock while keeping USB functional.

This is a temporary platform workaround until proper USB4 DP tunneling
support is available.

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts                        | 4 ++++
 arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts | 2 ++
 arch/arm64/boot/dts/qcom/purwa-iot-evk.dts                        | 6 ++++++
 arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi                | 4 ++++
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                 | 4 ++++
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                              | 6 ++++++
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                       | 4 ++++
 arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi                  | 2 ++
 arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi                 | 4 ++++
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                      | 6 ++++++
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi       | 4 ++++
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts             | 4 ++++
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts          | 6 ++++++
 arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts       | 2 ++
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi          | 4 ++++
 15 files changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 9fa86bb6438ec..5ec77c5912f8e 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -762,6 +762,8 @@ typec-mux@8 {
 		orientation-switch;
 		retimer-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -877,6 +879,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts b/arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts
index bfb7cea56df96..328a360843f4c 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-lenovo-ideacentre-mini-01q8x10.dts
@@ -601,6 +601,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/purwa-iot-evk.dts b/arch/arm64/boot/dts/qcom/purwa-iot-evk.dts
index ad503beec1d3d..9ce080b9ae896 100644
--- a/arch/arm64/boot/dts/qcom/purwa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/purwa-iot-evk.dts
@@ -703,6 +703,8 @@ typec-mux@8 {
 		orientation-switch;
 		retimer-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -760,6 +762,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -865,6 +869,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi
index 48c4ad648354e..d67ded1da5875 100644
--- a/arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-asus-vivobook-s15.dtsi
@@ -678,6 +678,8 @@ typec-mux@8 {
 		orientation-switch;
 		retimer-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -798,6 +800,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
index 66d566808f583..e1033d3bef359 100644
--- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
@@ -845,6 +845,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -945,6 +947,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index 9602d65c8b3db..002a974c88751 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -967,6 +967,8 @@ typec-mux@8 {
 		orientation-switch;
 		retimer-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1024,6 +1026,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1112,6 +1116,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
index d6de4da02dcd3..fa17cdafc07b4 100644
--- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
@@ -852,6 +852,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -947,6 +949,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi b/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
index 02708f23a8657..4dd62092b8809 100644
--- a/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
@@ -917,6 +917,8 @@ typec-mux@8 {
 		orientation-switch;
 		retimer-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi b/arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi
index 7559557610ed4..1aa075d6eeda5 100644
--- a/arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-microsoft-denali.dtsi
@@ -759,6 +759,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -822,6 +824,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 2e38402e2c140..ada5da526634a 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -795,6 +795,8 @@ typec-mux@8 {
 		orientation-switch;
 		retimer-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -852,6 +854,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -943,6 +947,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 5d49df41be02a..c8bfb38c64ad5 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -895,6 +895,8 @@ typec-mux@8 {
 		orientation-switch;
 		retimer-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1018,6 +1020,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index ce7b10ea89b6d..11412099eaec1 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -726,6 +726,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -789,6 +791,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index beb1475d7fa0c..d16d3627796b8 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -863,6 +863,8 @@ typec-mux@8 {
 		orientation-switch;
 		retimer-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -920,6 +922,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -977,6 +981,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts b/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts
index f95b1f9f439d3..55f9df8e5f403 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-medion-sprchrgd-14-s1.dts
@@ -857,6 +857,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 28342cb84ded7..4ccfbe7e14eb8 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -902,6 +902,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -984,6 +986,8 @@ typec-mux@8 {
 		retimer-switch;
 		orientation-switch;
 
+		parade,disable-usb4;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;

-- 
2.53.0


