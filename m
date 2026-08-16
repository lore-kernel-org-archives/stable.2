Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0A718BC3B;
	Sun, 16 Aug 2026 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786866100; cv=none; b=lgO6z0a4XM2wlZfg716+hALH9bd5AKuRAKVbrzm87vFL+n0rxvRyVQucErVuZkkI/oR0Jb9CBb26mOpN3PaR7yF50MBvDJhz46DFh2wtUZG2xVhVETG7vUMWKURZKXsPLpYDVVmj1qHUEj3L+0nG/QfKO0ZcHVxoH6qu2EBq6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786866100; c=relaxed/simple;
	bh=wN7iSMMaGhsQeofzb6qK7Tgl4wGdSW3AGantVN8g2ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIPtczinvpLnDjqCWT49hQlqrgV4bLGMmk6aeNz5ovabMGWej4XNPAM8vqD+Fc559DRFouN1yJjeUt9czl1Kkbdf6ySPW6RtSnBXncaOwhTW3oz3V+9J07iYzuhPd9Gq3gNrDwp8yLZETYoMjg0tQY4E/hZ591ntRkxPevwhav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNdO0ZGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNdO0ZGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3361F000E9;
	Sun, 16 Aug 2026 07:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786866099;
	bh=Mga7YU8olL03rKcmeXwf1ZVpiLVR3P7uFAukeYH2nEk=;
	h=From:To:Cc:Subject:Date;
	b=bNdO0ZGS0NB+KiJgyB8kBORkitZ40RFSin9smRe2M47kyLoAAKGwAUvdwjoq5YeLm
	 qfovbYfmIz4aR43xPXaGFHUh5dU7AK+Sbg7WI1PfFH+vXwXSrfAUPc1NbWiFISGzin
	 Da2m6B6Rt6mHb/HCw5istgPFOfObDzdjZzdtM5SF6r5oK9JM8ogE9i0cf3ypwIcis4
	 iDSohKpYL/l5HNoyRq2xKgsP7hWRAo7at5BTNgJH6UAhMp7bdplpXvM9MPN+LlOreO
	 DHEc4vZZRB+SVGmdUb8La8+QfQqffrPm1oiXmiTmMDU0cK0wePgT9JBqtt58smQbAt
	 mOG7LRpXjhhYw==
From: Guo Ren <guoren@kernel.org>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: dlan@kernel.org,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	"GUO Ren (XuanTie)" <guoren@kernel.org>,
	stable@vger.kernel.org,
	Guodong Xu <docular.xu@gmail.com>
Subject: [PATCH] riscv: dts: spacemit: k3: fix IMSIC guest parameters
Date: Sun, 16 Aug 2026 07:41:25 +0000
Message-ID: <20260816074125.2105828-1-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "GUO Ren (XuanTie)" <guoren@kernel.org>

The initial K3 device tree used generic/placeholder values for the
IMSIC guest configuration:

  riscv,guest-index-bits = <6>;
  riscv,num-guest-ids    = <511>;

According to the SpacemiT K3 User Manual [1] these values are
incorrect for the X100 cores:

 - Hypervisor Extension: RVH 1.0, GEILEN = 8
 - Advanced Interrupt Architecture (AIA):
    - M-mode MSI: 512
    - S-mode MSI: 512
    - VS-mode MSI: 64

Therefore:

- S-mode IMSIC (simsic) only needs guest-index-bits = 3 (to cover
  GEILEN = 8) and num-guest-ids = 63.
- M-mode IMSIC (mimsic) does not implement guest interrupt files at
  all, so the guest-related properties must be omitted.

Although the KVM AIA driver will re-detect the actual number of guest
interrupt files via hgeie and correct guest-index-bits at runtime, the
device tree should still describe the correct hardware parameters.

Update the device tree to match the silicon.

[1] https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k3/k3_docs/k3_usermanual/08_cpu.md

Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 SoC")
Cc: stable@vger.kernel.org
Cc: Guodong Xu <docular.xu@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
---
 arch/riscv/boot/dts/spacemit/k3.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
index 19fc9b49668e..4120eb0c4083 100644
--- a/arch/riscv/boot/dts/spacemit/k3.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -1127,9 +1127,9 @@ simsic: interrupt-controller@e0400000 {
 					      <&cpu4_intc 9>, <&cpu5_intc 9>,
 					      <&cpu6_intc 9>, <&cpu7_intc 9>;
 			msi-controller;
-			riscv,guest-index-bits = <6>;
+			riscv,guest-index-bits = <3>;
 			riscv,hart-index-bits = <4>;
-			riscv,num-guest-ids = <511>;
+			riscv,num-guest-ids = <63>;
 			riscv,num-ids = <511>;
 		};
 
@@ -1168,9 +1168,7 @@ mimsic: interrupt-controller@f1000000 {
 					      <&cpu4_intc 11>, <&cpu5_intc 11>,
 					      <&cpu6_intc 11>, <&cpu7_intc 11>;
 			msi-controller;
-			riscv,guest-index-bits = <6>;
 			riscv,hart-index-bits = <4>;
-			riscv,num-guest-ids = <511>;
 			riscv,num-ids = <511>;
 			status = "reserved";
 		};
-- 
2.43.0

