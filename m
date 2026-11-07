Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046675;
	b=djPh+KeWglORj2wtmdPAhO1Z1ntNUD55megxpmRtpsx3Oq5qcsvZmsrdOmiCqIzBseIl
	 KI2ga6mKvUVjQV9h/o3R8AWpQuFe1vJS8zC3rkSzcclDbz0k06hu0idzTbTxlH99TA3OG
	 +vXjkOG8Lk8WbKE4o815H4g9bw5T5AMLDrSazR14FKgEEwwZfgxB0sSZtYeA/DaMJLF7c
	 qSL9ay2hyaLdi4QqOYEPzUbf6PlxHgasTX1lUrS6ZXQjdzAHC3z/piSLSAIwRaeY4gSP+
	 XWzlZap+s4a3oMgH4ZrF0otFQFYhiMvq6ZiAbjUdF/dZzVyds4PAXl73gow4tkGqeGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vLr/ll6UDXiwmJovAmmnbKTkCMJjgFhqBYNLIPiQW4g=;
	b=bliAfT783XnecSyR2Vy6mSzuMCc/xE3b0+PNaONbgNMMs4m+NIb+4kwf2IFu1lxU7SL7
	 ID4J+Dncy/fIkA3x45aGo3cd0I4cZx6X81ZADbg84IGiwvs8v8x0J2bFuhUOR2b30rne8
	 AkzILqsKyV8vw2YuStFlzsuikr2xKJulHyzeRqALgJdTRO6zGQT5JCNYaWq0ia6sMQmjF
	 n0yAcEYMT8o6z7IRps3aYuOsB9i6mC4WGMA81msBx9xoAhgYCxgojZM66LnBfeGEvQ3hE
	 Z/03G1TthC+YYNSLaXsDfk4rPXh+RWxxnuDkk39l4Dyo66tMs6X6nUvoBHfFqfT2QHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GP/vo0Gd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEB606D830
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GP/vo0Gd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED07D1F008A2;
	Sat,  7 Nov 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046675;
	bh=vLr/ll6UDXiwmJovAmmnbKTkCMJjgFhqBYNLIPiQW4g=;
	h=From:To:Cc:Subject:Date;
	b=GP/vo0GdhTCcHLLso6RvwLMjAHutmIS80WhWharGpsPN4SktJh4VugVYeSoeDixJy
	 2wlFer2enj1iY13viygaWDo9nXPVr6NrGyBj0OlgtCtVMD8taqTRrbpRIRgPTWNSZT
	 fa/syQZWMt8L9FvlzjKp6FSjiXPX8ZxXOK3nuGyXnYRDHMgJTlrtzuVXfI4p9dsK0f
	 X2ozMNMh4K8GFuIIaDnBgn64P3YSvOaWTjB6J5vmFS/aVLRGFenVZ+zLYqlslFbszY
	 8iliGpCbZEyYj4TmCKJl/jZY2sMtzIY7sLGkw+DiNw3GLVcPxpqQaxUavGuMMLrKp8
	 R0J4s877PzwDQ==
From: Sasha Levin <sashal@kernel.org>
To: kathiravan.thirumoorthy@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	andersson@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: ipq9574: Wire up USB3 PHY PIPE clock to GCC" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:53 -0500
Message-ID: <20261107051753-failed-6.12-117d8d40be1d@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 117d8d40be1ded4f35f3252efa83607a7134d5e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051753-failed-6.12-117d8d40be1d@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




