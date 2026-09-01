Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B737AA98
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239205; cv=none; b=Y2yal6j6AcdmxksCBmmuDLi/Ri8WEkNhKh/jrF1fMLyTmLYJAZ6tG1ks16Wu9jcjRohKwPRSh+iHSGZ6RnV/qoC5VqHzL3ugjejLyuT4qzBK5RN4t//1FyldwH/DFkrO2JFzw6FsHi41CN1vurD+2hfsSRzTf0wc/xRVmypVp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239205; c=relaxed/simple;
	bh=x5NKW2Iopwwx6bIbfF/bJ/VyAJm8pFaTAq9rg8iGH+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrJcOktisRNP2+sEIcjM/S/f01Y8sACk3X5Nj1IC7WWkqAeZGjvx0idAYdgnl/EvRyjkkijwmHTZOEr40TVwyYOnNeDC5uV/lBRV7A6O0NdKXspcQPqKRz4YvIEKwT07YUMkQmeFZ/Y4EBIwpW1Fa+MchliKFVKPNEIygamKwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fycEF8m0; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fycEF8m0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1788239196;
	bh=cy18hRXmqoQUSyWYrrantqEfb3DvB1PMV1O3Lz+8ad4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fycEF8m0ppWX7e5veLhoa9MhKkBk65gBeX2SXuPAOwdMQGMFyeNtoAMPZa9QuAIa1
	 ZpM1C9fMhzGEseP8yEfcRryYk/QfypvWT8oAQuvZa1FULjxtBxkoPLNktIG138pLXr
	 NrCwXRxWL3RYn08OfEJ5V1i/aX/C/GU/493xPZwE=
X-QQ-mid: zesmtpsz9t1788239181tb68da59d
X-QQ-Originating-IP: L6KVDYyUgpHnn/XOPry+9aUzLe7Ad2cOa1u8NJOD2xw=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 13:06:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16674903376900110173
EX-QQ-RecipientCnt: 12
From: raoxu <raoxu@uniontech.com>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	raoxu@uniontech.com,
	maciej.fijalkowski@intel.com,
	kuniyu@google.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: usb: ipheth: stop RX URB on ndo_stop
Date: Tue,  1 Sep 2026 13:06:04 +0800
Message-ID: <351B4C70CB12AE0F+20260901050604.2523039-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MiUxkXieYO8RSSSoG6BjsVFjmHFwlqAMdBBvsqFFx0IQswVc6e7RKvRs
	YQ4fWb/MpgiqfBSKQVVkg0vjA8Vwt1ohaftGtkZqobNcoplceEoh02tp4KQY1+9Cr2V9pBd
	2eKR07Hy9TyljyeqloDlsy4ERwMaPq4jgGEa/duCSugDynqiF7fazOKdntn/W5jxJgU+VSd
	AAqY6Sus9kZA7RlSVQPYGl9L8a5jcv8HI506uIKUhky5snDK4LtduHOj2BPuFCQP/fMcdW1
	NjbFsyO+clJcSiyNHFIZiMLILNf4v3sgBc948/X7CbZG029s+ftdUPt+iZ+JTXE27oaMRi/
	499ZW9bNpsL8lOng7l7ySERgIFmnoOcLzPbFJ/Vs7hrfCy2PH4URkKGRYxHGkDTaVpb9FB+
	f2rNo8u2AYkom/nFfsJ+P2PmwMK0dKlRcj8k+uyJs+oks61x/XzaDIHGytAJYO+6rX9FdEq
	5AuMv6aPfkcKF9aMjshHLVgV/MByiD7dU4wYFvA0Qsylk+SEnBRltWjqdWJqSxED/+WL0Hf
	DHEn0ODTNBUBwS5ppwvGhLwtMlwrSI9CZ3MKa6WD+z60EPrZ6CdRqOB0yRT0hczUEehqc9e
	ApuicFlw3s61g2qUWvBqXzozqE8zeNFqi2pOUxV1oEp6L6o2MN5fC0nqEV6q+ff7kFlYIgq
	b7ripgmlNpZ2Foy4W20byfG3SHsIdG+HRrDNfLLrL+8QmSvsAshc2y3TWIptQzYPpXaGpNy
	Qm29ISzfS8nQC/vLczUg+rnqwK5WOpOKune8yeadP8LgSDan6lsl/75PLFCePo7gO2Nb5QG
	EsyguSdIRM7tPm9Le4hqSPF9Enxu5gkb8/CnicDr9zwMaMFTEDrpGTtBVHTDohHObnGkxEw
	gPRiPfJj2YbMujNEju7QkwabNKDsxMPPLyNCcltJkR9IDLBvTr0e+UZKpYvsSRM2t2F5JSH
	tmPObh0ndv6UjYQ4kIROiAY7iR98WbLQYrCuMUrbeJ2WvG2ZDL1v5cGUjz+QPvMAkEnT8U5
	rMhh+R3hOwNfLMA1d88m1rKlKTaF9Y64Wym1AxGuFDWo/cqHCb1cwG82JT/HQ+w8bYmpGVy
	rsZDam90Un7
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

ipheth_open() submits the RX URB, and a successful RX completion
resubmits it from ipheth_rcvbulk_callback(). ipheth_close() stops the
netdev queue and disables the carrier work, but leaves the RX URB
running.

After an administrative link down, an already submitted RX URB can
therefore complete, pass received packets to the networking stack, and
submit itself again even though the interface has been stopped.

Stop the RX URB from ndo_stop. Do not kill the TX URB: packets in a
successfully submitted TX URB have already been accounted as transmitted,
so let an in-flight TX complete normally after the queue has been
stopped.

usb_kill_urb() waits for a pending RX completion to finish and prevents
the completion handler from successfully resubmitting the URB.

Fixes: a19259c3d589 ("drivers/net/usb: Add new driver ipheth")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
v2:
- Kill only the RX URB and leave an in-flight TX URB to complete
  normally, as pointed out by Oliver Neukum.

 drivers/net/usb/ipheth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 2b490114d232..6b90fe1e0e38 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -505,6 +505,7 @@ static int ipheth_close(struct net_device *net)
 	 * it, so that such a schedule_delayed_work() is a no-op.
 	 */
 	disable_delayed_work_sync(&dev->carrier_work);
+	usb_kill_urb(dev->rx_urb);
 	return 0;
 }
 
-- 
2.50.1
