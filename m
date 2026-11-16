Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794804333;
	b=W2SmZ5dHzk6Neelr7cVoWfRTLzkDOUweqGr6GUkm+Ikj27ostkxiBAHexTJLPMfVR+gg
	 TLXSAJtYXuFwusHzmV23TerGoIGGRn1NMjj8O7b1aHGBwTcx1O2Kwc3TMHa7WHf/OTaUI
	 V/drsfiolUDXZw2icH5TlfTbyzu5qcMzpbhgp+Xaeu4arRGgGHAJZOFsQ2RrCj7JfPoaw
	 rtWR+gfQFq9IqPLM86O40oRuwoiqsKSQIbnO7BBvIgIRrL9qCeBhnDR14KnOf1r7PeTxE
	 9bpWpkeCDjOWCg7+uRQ2jjOJHZnWPsMdFMqVkB1d4xGSHrp8PO5WzPmmfashhNCe73g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794804333;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=C1nXCu3xpUAPoWbsrSdR5ivMdPwVi+OL8YN1z8S9pu8=;
	b=Xtuy5u9BgjEmJywl7gC5zcHn1jwHlhfpmFujji0DK8NTcc+2PilEGaRpjuP8OpoWxXfk
	 +iumEZ43OK32YQa9rmE6SoQFB2R7E0UoJdn0luueZZojuBoCl9HBQDPEWgeT0XZ+td0TA
	 3ub54wXlDvpnka3b85RYrqTlXta/8xiBO2cZv637tgqcKknJerVz9SezLtkYYcRc2YloN
	 4DZ5UGPzjCmcqDICcVfEZSoqiLzCKWf6Wcjv/xwKJVeu2lXuPZg85TkqH1PiOO0OBW8g9
	 mRKN7LqCgeE4NRe+JAu/2SUugdHHWzwwCnTrG6yYaIUzFdFkznKSA1pnRa9qa2J/HMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1mzUkq7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC7606A321;
	Mon, 16 Nov 2026 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1mzUkq7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACD11F000C6;
	Mon, 16 Nov 2026 04:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794804333;
	bh=C1nXCu3xpUAPoWbsrSdR5ivMdPwVi+OL8YN1z8S9pu8=;
	h=From:Date:Subject:To:Cc;
	b=G1mzUkq7FFJ5EOZDTloszthKxKlWQ0lUybewTZqXEXxg4IQnpev8qo4P4+fKJu2g6
	 ARqO4Lb9tj4zuN9Blv1H5Oj4YWPP1vwQjhoWOE76RLCCfiLxh8J10VHXn/JOgZJINi
	 VLl8MikDAU8nLa4meS/aXUxpOWdu1OcOFJpuQzGarWcd7tJnvDnH3UuW3Wamzb/ySB
	 /gXy5eH4jmwjgnjDRR1ZIXcDT5Ry8YjwVtkzFmTSzLCB4hwXpzlj5Fngu1kxWZJ3A9
	 e/VpiK2nxbroVa7yh6KWeO7jPAoxbJGwukl4ZG0ws3R7nX3M7/A8scKnI93guL+PKh
	 vp/PWy8cFh/wg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sun, 15 Nov 2026 21:45:22 -0700
Subject: [PATCH net v2] qca_spi: Avoid unsequenced accesses to jiffies in
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
Message-Id: <20261115-qca_spi-wunsequenced-v2-1-8cf32f12d546@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/32NwQ6CMBBEf4Xs2Rq2qRU8+R+GGFpWqJoWuoAaw
 r8LePc4kzdvJmCKjhhOyQSRRscu+CXIXQK2KX1NwlVLBplKjYhKdLa8cuvEa/BM3UDeUiXKDOm
 gNOpMKVimbaSbe2/aC3jqofiVPJg72X4VrljjuA/xs52PuMH/f0YUKLSRmJs81ZU5nh8UPT33I
 dZQzPP8BYwtMtzQAAAA
X-Change-ID: 20261114-qca_spi-wunsequenced-a81e54616844
To: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=nathan@kernel.org;
 h=from:subject:message-id; bh=IgZPl7ILzzabDjruOxBCjVz4U4I25Kp8yanQCQxS3vg=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFm/utLLtfhXHGiyED4pP3V/+9FDgTN49TevFV7M6PbE8
 p2xOOe6jlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRCycYGa57nb/kuZEr7d7j
 E68W7NxftODL92fynxaGsixSeSDxiaOM4b9z9pNj79cVpHTLGub7bG2Te7hXj99r9k9O9yAe35J
 pVzkB
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

Printing jiffies on its own is not that useful for debugging transmit
timeouts, so get rid of it to clear up the warning.

Cc: stable@vger.kernel.org
Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA7000")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2197
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Eliminate printing jiffies entirely rather than using a local variable
  (Stefan)
- Link to v1: https://patch.msgid.link/20261114-qca_spi-wunsequenced-v1-1-6b219b906db7@kernel.org
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 38a779f4b866..249b4b549a12 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -801,8 +801,8 @@ qcaspi_netdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct qcaspi *qca = netdev_priv(dev);
 
-	netdev_info(qca->net_dev, "Transmit timeout at %ld, latency %ld\n",
-		    jiffies, jiffies - dev_trans_start(dev));
+	netdev_info(qca->net_dev, "Transmit timeout, latency %ld\n",
+		    jiffies - dev_trans_start(dev));
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

