Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B72236F0;
	Fri, 21 Aug 2026 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280412; cv=none; b=Ve9a2IKEs2CP3UQ8wbe5+/rjorxV77gQaslO+/pCOwwHTnwHHQoqsjVwJ6yjQnpzp2KfoVh1qRaR6+JK6FJzxlng6uZTJykiUcqhUKV6xDcsGLcnFItpVIv6XyXAsUG3vrv0Blw+TOYAF1kyqC+xz00iTqiZTU1BklbFKrxNNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280412; c=relaxed/simple;
	bh=/6wE3utFkGjVWIbmfoYjOgrZ5oA4wUr2EUMZ0RNBQtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SX7PEplwe1ZokLvmPDAczobG+LLUROcziwiFhhMk9jNl8sbKxr4XLJH9VCH4qWmO3J2j/+kLBs1d5ut85vdvichfAMIch4RvMRlSQRD7cQQHEVM23PEz2aghwDkdCfMxNUdkxt6d7o5BZQ5/HghO4dcQm/6iOkG+rRQ4jHI1e1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CqlM8EDJ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CqlM8EDJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tT
	oWt2P5Ypm2NR01faLfeHcsKTrppzXzg7IVTxdYrgg=; b=CqlM8EDJyDAMOKH72B
	VOUwDi7w7RDGP0ZtHOIOYTmMEGhDwlQ4yi+gCnFmu+745xAgNE4ZilwMOiX3Ue4w
	s7wkB1F05nAzN0rAIpKirjyw9lh33MSa0TBFjPxpw58z0qTX0OKY3yrC7q0y3lKm
	wToEAG4ulZZ8YpwN6TiLoTkMg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3FQL0u4dqml8+MQ--.51036S2;
	Fri, 21 Aug 2026 10:46:14 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Fix false success return in hci_uart_setup()
Date: Fri, 21 Aug 2026 10:45:55 +0800
Message-Id: <20260821024555.1647597-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3FQL0u4dqml8+MQ--.51036S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1fGw1kCw1DZw4fJFWfuFg_yoW8Xw4kpF
	Z8uF98Ar1kJr47tr17Aw4xZFy5Gwn7WrWUCrWqk3s8urW5tr4F9ryrXa4Yqr129rWUt3yS
	vFn7J3yfW3W8Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjKZXUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/xtbC4haoY2qHu-bz6AAA3E

From: Gongwei Li <ligongwei@kylinos.cn>

When reading the local version information for vendor detection
fails, the error is only printed and 0 is returned, which masks the
setup failure from the HCI core.

Return PTR_ERR(skb) instead.

Fixes: fb2ce8d11f039 ("Bluetooth: hci_uart: Add support for vendor detection flag")
Fixes: 82f5169bf3d3b ("Bluetooth: hci_uart: add serdev driver support library")
Cc: stable@vger.kernel.org
Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/bluetooth/hci_ldisc.c  | 2 +-
 drivers/bluetooth/hci_serdev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 2ad42c3bbaac..27644d2e53f8 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -451,7 +451,7 @@ static int hci_uart_setup(struct hci_dev *hdev)
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: Reading local version information failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
-		return 0;
+		return PTR_ERR(skb);
 	}
 
 	if (skb->len != sizeof(*ver)) {
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 593d9cefbbf9..d2eaf2f12aa2 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -221,7 +221,7 @@ static int hci_uart_setup(struct hci_dev *hdev)
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reading local version info failed (%ld)",
 			   PTR_ERR(skb));
-		return 0;
+		return PTR_ERR(skb);
 	}
 
 	if (skb->len != sizeof(*ver))
-- 
2.25.1

