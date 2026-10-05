Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2946D09A;
	Mon,  5 Oct 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196387; cv=none; b=MJVy1M8U5x1Bkf0dP8dNpz9nlbUY2EiDD21PQjVqqpK7vw/wzALEuxdsTuBSlPKY8KWUpQXiR+l2kVkNLiVGUurbajkRqjt5PVcuhEPtvMfCQMXD2Vu5Ox8Lv/Ne15XpApqbzWnsBF1YksPZdU6QowDHxhS4pFRLHquGDVUnmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196387; c=relaxed/simple;
	bh=HeYnKht+rbXkuUa4EohCDb03waSQr6SlS8L/YvVyIcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qOV5u9GlmJiz306NsASNY1vCHAmpOUqSdomi8JiAUUXDESdRIBZ1JK3yBEWpJQV8MSUXS5ekf727vFoImaOt4iSeiI/zHSbCG13nr6H4Z2OH2+QCelyiQu+PKMGhzCVcIQ1eLL2WwxfMRh7OxgT+1Q3OFZj+wqW7HiKy+CI4Zag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIKbOsTL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIKbOsTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619791F000FF;
	Mon,  5 Oct 2026 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791196386;
	bh=mJAWf/W409wQdx9doBOu157lRcmZ2hxa/1jrWIjHjcM=;
	h=From:Date:Subject:To:Cc;
	b=XIKbOsTLThS/39UM4QHfq9nlzcCJ1R0cIhknq74mI4QBHNxaliTFmlLNd/f398uyH
	 puooWoXQmtSZbuJECh1j93tK/2E+OFNdUMc/2r5xbLLeW8RcDuT/08PhI7KFyR36v1
	 r21t85yWTIwlUA8scSga1+drWWdTZ8vZ0NSLBQoUVAQ8U5Po//9OtgKfKIUOl0kjVg
	 3DkM1s+wbon/NJuL8RaoUOb1i6H9TXBUf0bg5Mil9y6ivrgVPf0UgiI15tpDHY+6eQ
	 G7qRvTeiazBFvk4Xmpz5rKTh5J8rhk8iiK8d6s/hyPTEk0Bsl8oyfBQmHirb7sAlQB
	 FK0KPuKYjMNHg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 05 Oct 2026 12:32:59 +0200
Subject: [PATCH] wifi: brcmsmac: Adjust txpwrindex value in
 nphy_ipa_rxcal_gaintbl_2GHz
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-brcmsmac-clang-24-constant-conversion-v1-1-a30c5692d582@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBBFr1Jm7UAa00K8irhIx4mO2FQysQild
 zfR3X98eG8D5SyscOo2yLyKypIq9IcO6B7SjVGulcEaO/bGDDhlmnUOhPSsN1qHtCQtIZU2Vs7
 NgEw++nh0g/MjVNcrc5TPr3O+/Fnf04OpNDns+xdb4z/UiQAAAA==
X-Change-ID: 20261005-brcmsmac-clang-24-constant-conversion-ec9f9f345496
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
 linux-wireless@vger.kernel.org
Cc: brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=nathan@kernel.org;
 h=from:subject:message-id; bh=HeYnKht+rbXkuUa4EohCDb03waSQr6SlS8L/YvVyIcI=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmHa+7OqKl//f6v2ekg54VvzsyYEW1z5dVbjVl3dqZ/P
 cCfey3QrKOUhUGMi0FWTJGl+rHqcUPDOWcZb5yaBDOHlQlkCAMXpwBMJMOP4X+CcVz9hJmGs4qY
 LULjbtzJitWcmjn7arPuF3n/+LBvvaaMDBPqTweXba2dYlH4ZPFrsYPJqnY2Wz/5rC79q8yj/2P
 7Z14A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent change in clang to warn on signed char conversions within
array initializers [1], there is a warning (or error with
CONFIG_WERROR=y / W=e) from nphy_ipa_rxcal_gaintbl_2GHz:

  drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:224:18: error: implicit conversion from 'int' to 's8' (aka 'signed char') changes value from 128 to -128 [-Werror,-Wconstant-conversion]
    224 |         {0, 0, 0, 0, 0, 128},
        |         ~               ^~~
  1 error generated.

This value was introduced in the original staging merge of brcmsmac in
commit a9533e7ea3c4 ("Staging: Add initial release of brcm80211 - Broadcom
802.11n wireless LAN driver.") and it is the same in the proprietary
driver [2]. Presumably it is correct since there have been no reported issues,
so update the value to '-128' to be type correct and clear up the warning.

Cc: stable@vger.kernel.org
Fixes: a9533e7ea3c4 ("Staging: Add initial release of brcm80211 - Broadcom 802.11n wireless LAN driver.")
Link: https://github.com/llvm/llvm-project/commit/a5ef934a8d295dc03be3960f2b3744ec2e53238e [1]
Link: https://lore.kernel.org/1a107e21b08.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com/ [2]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index 86cfa3e87a04..9ddd5d519893 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -221,7 +221,7 @@ static const struct nphy_ipa_txrxgain nphy_ipa_rxcal_gaintbl_5GHz[] = {
 };
 
 static const struct nphy_ipa_txrxgain nphy_ipa_rxcal_gaintbl_2GHz[] = {
-	{0, 0, 0, 0, 0, 128},
+	{0, 0, 0, 0, 0, -128},
 	{0, 0, 0, 0, 0, 70},
 	{0, 0, 0, 0, 0, 20},
 	{0, 0, 0, 3, 0, 20},

---
base-commit: d24e8ac715de2e16a53c144005b1863660a5fbea
change-id: 20261005-brcmsmac-clang-24-constant-conversion-ec9f9f345496

Best regards,
--  
Cheers,
Nathan

