Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047431;
	b=dNXTg0yecDT4fY4z86HwkrG66OodXYwnIiDP7BSsLBiVCfbcGFU+sD5dERcS0DmTEeJE
	 6m6DpAHkxgjVEniCQmoQUWam036tZ2idQ/sBnPuQ8NNzHGrPSOnf4IfzbMZ2B5vnUHPR8
	 QGAHOe25bwWtqnUeflPHM/i+Em55k3cYfH7wmtNU98WVV/hIyHwt23PEN3XYYtltN2W+I
	 ebsPh8zlnnb+8dw/WY7lIQZVu4ZFVf6pC8dxBsG9ESxdRy56vT0ZHtnYFl4tk3PwbxTym
	 rkiL4ej4dKT7KjXhRAzBzDPF37IAVs4PclEUTq2tJ0Ziy1lfA4oDFslYS7L1eokkASg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P14cUXGN1jqCv58/YSagHswKVyiPDhj5AK3xZKcsTxo=;
	b=wJDw8zDFE8MdBG+samewn3mU8c3k8Dqz0zAk2vFoUGq4sWaxyImz6uETVC9CjAfChm12
	 HkBIvruqMIJlVKJt7QkRos4goqAc8OuSmcWZA/R0g0up8q7oux6sWTPTa89PMOeJv/4jy
	 zXruyUbOru/5kO/pCCVuK0cJ1N0QtkmgsFSUFICAA67H8CcK96CrADtIH0fqkN+ajKyMJ
	 bCxvldyrPKUiF5RklcPm4aM0SAayT7/g6vdj25m83NzybizBKnrej7WQFJ41OVe7LQOKZ
	 D/3MZTbdEcwkKnHoUOQQY4G540kLdR15verTISC+tnc2C1YVGyM7Kwzf/TSUiNuL9Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WlHtOE/L";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062F606D807
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlHtOE/L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216651F008A1;
	Sat,  7 Nov 2026 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047430;
	bh=P14cUXGN1jqCv58/YSagHswKVyiPDhj5AK3xZKcsTxo=;
	h=From:To:Cc:Subject:Date;
	b=WlHtOE/LXIW6oZ0TlxrU3Jqv9S5uyE8mP3uke4io3N5st3EsupIGeRb1O6f2YqH/J
	 C7vh26BZi9snT7Mz54sey3VLLNWXcTjW39KnZJYGuEN38IowsBPbWU26+Af1ZIWfrc
	 ozWjgT3y5EBtIBRW2LEJGG2+50o69JCL1b7mQut4stbHpAzg86485TWmEdf2D6EZx7
	 9/GvSYw2StmuAM7vmdJDvanyp432qWUrIg/O/cpiOCIUEf3H7jy32ZB7q7PJKgsh2R
	 acBWlPh69RK40F9CCpnAV69AepxOMH59vF/FV5q67rVUTU1LNOhfHmJXufWx+QhdzC
	 lSHqFKjk522NQ==
From: Sasha Levin <sashal@kernel.org>
To: kathiravan.thirumoorthy@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	andersson@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:29 -0500
Message-ID: <20261107053028-failed-6.6-117d8d40be1d@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 117d8d40be1ded4f35f3252efa83607a7134d5e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053028-failed-6.6-117d8d40be1d@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 117d8d40be1ded4f35f3252efa83607a7134d5e0 Mon Sep 17 00:00:00 2001
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:37 +0530
Subject: [PATCH] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC

Connect the QMP PHY USB3 output to GCC so the USB3 PHY pipe clock can
propagate to the USB controller.

Cc: stable@vger.kernel.org
Fixes: a98bfb31f676 ("arm64: dts: qcom: ipq9574: Add USB related nodes")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Link: https://patch.msgid.link/20260921-ipq_clk_changes-v1-4-d242e3d49648@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index ecafd4cda6e7a..771a595856459 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -428,7 +428,7 @@ gcc: clock-controller@1800000 {
 				 <&pcie1_phy>,
 				 <&pcie2_phy>,
 				 <&pcie3_phy>,
-				 <0>;
+				 <&usb_0_qmpphy>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#interconnect-cells = <1>;
-- 
2.53.0




