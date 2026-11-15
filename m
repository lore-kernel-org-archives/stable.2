Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717582;
	b=40eY+HlWAw3l5ZQOCd9ee/gve8jMw8+8sQcE7uSKM2OHtFEPBCNW4u23Nabrzz6cJ/Fj
	 zr1uu7v6BuGxYSLxjQqEZVdVP+2rjBtu+0urFtmmflt/OCURCRewOzVLLCJ7tW+lcKAp7
	 4/2gqUYARYNxZKuu2qtRcBLyZ+VEoOhPn/SPMUuK6TM/awFW98aobkMC+p5MZaS64uf4a
	 eufBemUmiKKynaA+vMr6dYPNPxVHMmFsFEiyAKyeQNMXnd/igkhuFMyt0sSa9pSwOAa0Q
	 fx8L0N/CrGTkH3iA3CVD4RRNFa97aAWv77M+94IKT1kiBGyVUQfEeLAb3y4hSoZSj7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717582;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Zv9QKzRQEPxxzpa2oYAmnKto1hcqlcY9m59gDaJs/hc=;
	b=JN1fv7aUPOKSyIbkeZcBzYpXY0m7nL4bLaUARDsVju5jbPy45CsZojEwMV97IoHPZDyi
	 Gmp2890aPO3tlvgINVK+b/LKX4Kah3Yv6zHpXUhuKAMW3fYWytf4iFXrCVWzv9MZcgqQs
	 8pZHHzQYyEmiDh5oHED81iGF1AidPlIc1qRsleKiobXYXYZMwE21C0CU+D0WldERD3emE
	 rU9lu3xuHGlB/mJvMYBwxmDByxleJyMZuxyGYIcqyVZSy06FsQQpJG5lcYfBHp/h21mp0
	 QGX2viBTv1rEfICsGi8St0x4mOSg2Hw2t/uUtL7TJCruq4ZRdW08DE1ho+yQieIBh3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWWzAGpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC022606A329;
	Sun, 15 Nov 2026 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWWzAGpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0721F000C4;
	Sun, 15 Nov 2026 04:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794717581;
	bh=Zv9QKzRQEPxxzpa2oYAmnKto1hcqlcY9m59gDaJs/hc=;
	h=From:Date:Subject:To:Cc;
	b=AWWzAGpy8xGbmyCue4Ch4R1fdVbBzavG+cKebKkUsf3/VvavKJj3qZAFiN9NPMQDR
	 R04vFsbioN0i2S8CN/szo3mM/7SEzVLSE9d6Ie9pQGLPL/NTjWHEMrNXKFjI5A+ULC
	 kD7dJTcl+Ikvbk7RtIDbCvLD1waTSfQGedzhNn4nDJ/bjQ96xmRfWG7Qr1hqbGlibZ
	 Wwct8Lw4qeUYs7bYFaZ4xqrs9CrOlzHP9A58wyoVwFink4esBXYLm/eJZ/Alz12HoG
	 U6anprDOirRZv7b+Y2fQ19duimyuEuq8k0ZwGKbd/ERDvcuKiyWB1jC92ISeizPqw+
	 hj899qq2v/Ycg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 14 Nov 2026 21:39:29 -0700
Subject: [PATCH net] qca_spi: Avoid unsequenced accesses to jiffies in
 qcaspi_netdev_tx_timeout()
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
Message-Id: <20261114-qca_spi-wunsequenced-v1-1-6b219b906db7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yWMwQrCMBAFf6Xs2YBb0lD8FRGJ6VPXw9pmGxVK/
 71RjzMws5AhC4wOzUIZLzF5agXeNZTuUW9wMlSmdt8GZvZuSvFso7h3UcNUoAmDiz2j84FD7z3
 VdMy4yue3PZJiptNfWrk8kObvkNZ1AzpIlyl9AAAA
X-Change-ID: 20261114-qca_spi-wunsequenced-a81e54616844
To: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213; i=nathan@kernel.org;
 h=from:subject:message-id; bh=8diMkiPDp0+wFaZenuORVyRA9hNw0BoDQxVNwlId7QM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk/zVvvbP7OZ3D5c21H2jTxaZUfdVrYazyVX/6aYbjp3
 5G5HIucO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEbLUY/gpsqrltavTFyj2l
 V+Hri/Bp0utdxFqmbXXbO5FtkVWKbALDX5k91bN+fNrnWD9DwGxa/NK7Zhd8z4a+Covr4b6mqNP
 KyAoA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in
qcaspi_netdev_tx_timeout(), which can break the build with
CONFIG_WERROR=y / W=e:

  drivers/net/ethernet/qualcomm/qca_spi.c:805:16: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
    805 |                     jiffies, jiffies - dev_trans_start(dev));
        |                     ~~~~~~~  ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
function call is indeterminately sequenced, meaning any side effects in
the arguments are unsequenced.

Add a local variable to hold the value of jiffies before the function
call so that there are no unsequenced side effects, clearing up the
warning.

Cc: stable@vger.kernel.org
Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2197
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 38a779f4b866..3ea745d4aef7 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -800,9 +800,10 @@ static void
 qcaspi_netdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct qcaspi *qca = netdev_priv(dev);
+	unsigned long j = jiffies;
 
 	netdev_info(qca->net_dev, "Transmit timeout at %ld, latency %ld\n",
-		    jiffies, jiffies - dev_trans_start(dev));
+		    j, j - dev_trans_start(dev));
 	qca->net_dev->stats.tx_errors++;
 	/* Trigger tx queue flush and QCA7000 reset */
 	set_bit(SPI_RESET, &qca->flags);

---
base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
change-id: 20261114-qca_spi-wunsequenced-a81e54616844

Best regards,
--  
Cheers,
Nathan

