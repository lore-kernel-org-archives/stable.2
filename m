Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE22E62A4;
	Mon, 17 Aug 2026 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937474; cv=none; b=MM0trBZWer0FiAa2jxdy/wNGg+1M/o41Av44ja8Kw/spXvr57jtudFraXCqhmoBvUb5Ubs8WCjWZq4CFxCORkF58KucxSNUhs26NngIJAcPWDXuAVPB4YT/3noBWIsybiNqu8E3BAZrguLsZMdH/IPuvkaXI7zozSbBlrZKF7AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937474; c=relaxed/simple;
	bh=3Lw8nNo3vlnI5Cj1H2N29cS3MfP60oakb6Dzi9VqRa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tiJszgkUeGaihwk90CbiPTPQZF6qAEFXWt5WGtpwkyk78TF2yg49AEiVU6Q64RqXNNhMsWzZOAfXAT+X0Oh2JbQOA46ScGY6oKoVBuwGkRDL8j+C9lj0sJhJpAz0j4P7E7J2sw+7WxQvw/w+i+31d0dZ5HXu24hdTiVHN8K6Vys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8vLFnA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8vLFnA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABF41F000E9;
	Mon, 17 Aug 2026 03:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786937472;
	bh=toX/MnDHIJfbzMtrwLv5Ia5fgxHNg9bMGwJkF9+Vi0M=;
	h=From:To:Cc:Subject:Date;
	b=X8vLFnA65DVCR+2PGFO16WB2XwankYOHjBcqOiQIIO/XZxK6I6HFqy/zeUUBz/QNs
	 LFkkTPeum2HQXclxW5wh3/UdTFQp53NV0s0UeMJdgmvBuydi3riHumZJyf3Sfdm2J4
	 ieV/Bbc5rx2IEgGBV1m7S8YttUBs2LGngtCV3TlZYhWqi8o/pek7QovPue77wfcNK4
	 0mJT5VyjU5P7D4VUe37hWf+8EA69ZXUUbC6VRzhN7wIZpAt8YhjYxOaSclxQ574+2u
	 rqs0PKyadGuK5nFQU2Sf56l7ydewpK3AgoXC8Ffu9E0YSSbW91pPMkVzw1WPLEFShZ
	 zC3pDCTROJLTA==
From: Guo Ren <guoren@kernel.org>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: dlan@kernel.org,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	junhui.liu@pigmoral.tech,
	"GUO Ren (XuanTie)" <guoren@kernel.org>,
	stable@vger.kernel.org,
	Guodong Xu <docular.xu@gmail.com>
Subject: [PATCH V2] riscv: dts: spacemit: k3: fix IMSIC num-guest-ids
Date: Mon, 17 Aug 2026 03:30:38 +0000
Message-ID: <20260817033038.2286436-1-guoren@kernel.org>
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

  riscv,num-guest-ids    = <511>;

According to the SpacemiT K3 User Manual this values is incorrect
for the X100 cores:

 - Advanced Interrupt Architecture (AIA):
    - M-mode MSI: 512
    - S-mode MSI: 512
    - VS-mode MSI: 64

Therefore, S-mode IMSIC (simsic) needs num-guest-ids = 63.

Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 SoC")
Cc: stable@vger.kernel.org
Cc: Guodong Xu <docular.xu@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
---
V2:
 - Drop the riscv,guest-index-bits change for simsic: the property
   describes the number of guest index bits in the MSI target address,
   and the per-hart stride on K3 is 0x40000 = 2^(6 + 12), so 6 is
   correct as is.
 - Drop the mimsic changes: already fixed by Junhui.
 - Reword the subject and commit log accordingly.
---
 arch/riscv/boot/dts/spacemit/k3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/spacemit/k3.dtsi
index 19fc9b49668e..4a4a9ec7c981 100644
--- a/arch/riscv/boot/dts/spacemit/k3.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
@@ -1129,7 +1129,7 @@ simsic: interrupt-controller@e0400000 {
 			msi-controller;
 			riscv,guest-index-bits = <6>;
 			riscv,hart-index-bits = <4>;
-			riscv,num-guest-ids = <511>;
+			riscv,num-guest-ids = <63>;
 			riscv,num-ids = <511>;
 		};
 
-- 
2.43.0

