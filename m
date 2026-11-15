Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717522;
	b=wCdwBYyALiAJIbCQ7V7lydoT0+gDe7/ZAd6P2SwoJ9bjmtlwFO8uH8oAnZ1r0o5sYDxh
	 RdwElPvKTZhxx7XGH2emat5WnRCkINvbzs0PjC3hfb+WAyUMCzBin9zjtW7WzIv3bLruN
	 sEwrfQtS0a7BmK1kBe84uzJGqlA/W84pRcC8up/nbPayRGVyDF51CvY3xq+ryK5Lb2nfd
	 BS90A74iVmucqgmlEWDogjf7hE2AYOPKZASuGx5mPzex+Okvu4ms3Qcw2Zpxvi9BgcTfC
	 fWiT1HryryB+teQEII+rxPhGyIPtMEEOcZyyhsKJLCDLPjBuGHGihlri4C33dPHzKfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717522;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3sk+H4+98RAl4s00138LkHpzbHdfMDnYcTQX4GZfKCE=;
	b=dbxlxgPr2x22XrKEzBF8FvjTOX0J/V2E50vjzmkaZmnI/dTh1nycGKs+vqqagQtvdAoR
	 og6DHmC/J57GLCaP+kj+dDunJjbSUPLLyZr7i9KbdE8KHeD4822b441hbWW7UStQgllfy
	 mCQykuYh0mfN/7sMuyL9PXOujb3vxX0D0g5JKxww0M7qBaD1Y4yrklGpAw6aKfJ9meNQ4
	 Ank0NPCQuo8RjSsgEBGxH7krlZlPe+bbQqMl3+kCCViK7DESjj5WefEv0eb8p66bE28if
	 la9Hy1dr0kXRsDEDfQSCgECpyJ5LCtQdgUF+qfxOJvH/mUxUDCfvEIevUBM1aGusc1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eV/QTTAQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C5606A323;
	Sun, 15 Nov 2026 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eV/QTTAQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4229A1F000C4;
	Sun, 15 Nov 2026 04:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794717522;
	bh=3sk+H4+98RAl4s00138LkHpzbHdfMDnYcTQX4GZfKCE=;
	h=From:Date:Subject:To:Cc;
	b=eV/QTTAQjx8EsTQUVFKoeBT8/EcVF7mGyI6K73GhSMwvp7ErveBqwr0GVS9IEOZjl
	 VPv3hT1TuavJfOKbhRI6cS5BfWer+030kEIgiTnh69D7pjOv+c/LRHG1TRQND48Art
	 W+rzqUD1rdonFB189H0asId8bxnl1eRMOUAJkTgEtAC+la1iZO/0AL4AifbQevfUaS
	 5VTbSTmGZkha93k59EtPqoTGoKOmcnnWvS8fEuGomaQXdafFAx3zqQewRc1DgUOmSE
	 8F/ojkZvx8x66ugyFMvu8DgL6aJoMBZ0SDJ1oLwNchpl4LcE87s48JRjSKq3/DwdIG
	 P3IuT2aW9JLuQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 14 Nov 2026 21:38:26 -0700
Subject: [PATCH net] net: microchip: encx24j600: Avoid unsequenced accesses
 to jiffies in encx24j600_tx()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-encx24j600-wunsequenced-v1-1-c978fc36cacd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yWMMQ7CMAwAv1J5JlKcRhn4CmKgjinuYCBuSqWqf
 yfQ8U6628C4CBucuw0KL2Ly1AZ46oAeNx3ZSW4MwYeEiNGx0hrilLx3n6rG79oMZ5eRYk/UJwo
 DtPpV+C7r/3wB5Rmuh7Q6TEzz7wn7/gWZX2nVgAAAAA==
X-Change-ID: 20261114-encx24j600-wunsequenced-d1c43cc36c2b
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213; i=nathan@kernel.org;
 h=from:subject:message-id; bh=xxcRp0UP7mcYpCcgqOp/Ic2NGshPPqhLsHzrb0KeC2A=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk/zX34Nni/vW121+dlpM8dAROXjzWfHrhPvSfqe5lhd
 ThD6OV/HaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAil+Yz/I/5qLePcfm2osOx
 3Yu/JH0MUvQrWab2P+TB+UwrHa7bia4M/6Pdohi0l+1bfuF3+tsi+1tfX2Qxb5Jw/fZaa8NCY5F
 mNmYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in encx24j600_tx(), which
can break the build with CONFIG_WERROR=y / W=e:

  drivers/net/ethernet/microchip/encx24j600.c:898:14: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
    898 |                   jiffies, jiffies - dev_trans_start(dev));
        |                   ~~~~~~~  ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
function call is indeterminately sequenced, meaning any side effects in
the arguments are unsequenced.

Add a local variable to hold the value of jiffies before the function
call so that there are no unsequenced side effects, clearing up the
warning.

Cc: stable@vger.kernel.org
Fixes: 04fbfce7a222 ("net: Microchip encx24j600 driver")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2196
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/ethernet/microchip/encx24j600.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index b011bf5c2305..ebc067cb2c9d 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -893,9 +893,10 @@ static netdev_tx_t encx24j600_tx(struct sk_buff *skb, struct net_device *dev)
 static void encx24j600_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct encx24j600_priv *priv = netdev_priv(dev);
+	unsigned long j = jiffies;
 
 	netif_err(priv, tx_err, dev, "TX timeout at %ld, latency %ld\n",
-		  jiffies, jiffies - dev_trans_start(dev));
+		  j, j - dev_trans_start(dev));
 
 	dev->stats.tx_errors++;
 	netif_wake_queue(dev);

---
base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
change-id: 20261114-encx24j600-wunsequenced-d1c43cc36c2b

Best regards,
--  
Cheers,
Nathan

