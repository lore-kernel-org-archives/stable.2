Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786851;
	b=pdNvm9JksJvUcBJZ+MqCyJA41rFLsx4/WHf9JsYo1Z21enxZRAjt3FoU0O9fhRA6QGf/
	 cB/BVWJkLs+tOiGScOo3DH6w/wiPkzi0FuvBIXz6ORre1MO8eLuwPvnjhhk/qrOEoJh5B
	 Zcjdpknyx0eyzPisjmk0zeMnzDtKxbCJixttwvj6m5QZsQgQWhVbZj4XGMfjP+2SFUKov
	 XXeZRe3Qi02K6xyoX2bFhBny43Jt5focxeOmW1cDRfF8InlJfTDP9MyEUthT0AJE/CWRF
	 r67kBapoRND36xsVEI7RH1imT98tf8Ponid2jJChHmQNVGyIZb8jQe0HBPpWvdRK0YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0AJWIA7czH9GdbmE5y7jSRhzHXqcVcwTzc1B62BZZmE=;
	b=YSkrnMvS2+9JJQn32K6upRBeZQHfjMgQApJIxxlkjBH1mXuOOGIHwcEMHiJVcSsJRfxa
	 SLOuTrh/HfvI2OOwQcKnjySHYitqgne5UlJH5H5nRuKWyz3rPSyR7VO2IZlG8oytbquI6
	 A8i7qTUq/MieqHbzzMlMxxMUJRUbntp0GAbKsRxQBX6HbTKLzenJjlxz/6Pq/D3Z5fV0P
	 ScU/Wygz0pYEkU04Ev//ktdmzLMAta1n9Kuu56Z49YBINAdvddNCy0KcMSC+lyX5cF97h
	 rVtBzlbvUH7A2fSVNWP0jRpqxt/PPBBQUyCxWU77hPzzWjFHI3nL7PePDoubA1FxCFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P+cj/vaT";
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531D606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8531D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P+cj/vaT
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so5209330b3a.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795786851; x=1796391651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0AJWIA7czH9GdbmE5y7jSRhzHXqcVcwTzc1B62BZZmE=;
        b=P+cj/vaT4MxktNnHPB4CKcI+P9/VHrGG0lfL2rwmQGr4IksHqVcr4rlAA+2RidCGym
         yZITa1CA5fDDLcbbB+j6B5Wq1u04uP4dihS6DbikUMYlG6VJklsP0q+1FWpl0s4zXaq1
         KMs2DWdnpXj7t/swjPPR1yzPl1i3e4GJr6fEm2d6tiAkVIX9ETMoSOU2B0fzmkVL1wJc
         KZq+83Z15V7DqFCmf/lcJIBPt+f91jUvT8aIHWwfivbX1nL6jAjkWJ2hvnpZUnRf8vA2
         rqdgN0I0RPBwrVi9FPJTKHI0P5FnPeGU9soPSU0mtLjqV1Ch30ZtAdmrkg1jIoWAS6hS
         hdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795786851; x=1796391651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0AJWIA7czH9GdbmE5y7jSRhzHXqcVcwTzc1B62BZZmE=;
        b=Htu8cSiQRPXiSrdFv9CFRaq/uBazwlF4WkyEdlw8lbax1IMFrtWcVMSvrAzjij869I
         e0AfwTWq/C1lP21O54jfplsRufO6UjA64bAjX5S6aAmK+uZMCvgn7PM/aDk0MvlCV4YL
         ibwhNpliyFbxXn38HPHE0a9RJHfUzaQwCHRk7b9ofxw7/krtLjfqvC2yYYFQSPCedfD2
         bne6GXjrBLo4wX79DsIRNJgazTrQ+8J7v1VBmkZNNIkdxJgUMENJ10+MpvpoRVtFr/Ry
         vIDmu0XidubQAwZ8ePQH11QkI/9COLmKgXScIyzp4IwzZYkxHxEhCZfRTG0ykcOKe+Ob
         u5EA==
X-Forwarded-Encrypted: i=1; AL+hErHB/s5IBSj7IwrBEv1tjUnR2IlSt5I8vlojbmZGrtTSbzhIqy2T1RnJ+RHY2i9pH3pAmI2ELWQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DBHrzfk9bK22qkCdHWwcJLJ3V2fgMS+9Y1QkIjrWny29bzYsa
	MukkG/p5+shuZmW7GPsKMpxt8Nuyc+dzvC1wRzDRUP+w2X8V8PPPj76L
X-Gm-Gg: AZFdTZej2esxQUWWk7vhwEzFG2kWTd8WuiEAY5zXLmGjlksO7Jnv3uDM5jRnEjwXQRk
	/252Ilv1chrWdFTCiBy57/tAV7Qu8uRGej+uN9WoeNzrZXOe1CF2n56ix0FC4ArvBc7kMxv27Ad
	xtcWiaIljcRrSJn87zhQ8vjNnQyJ0gRo+QB4+5+0caK0YY17/XAZTOz1U1KXyfbis9okFn12TxH
	4c1/B9xls+dHb3XSb1wKhDg2YMigMEp900J8PP+nBlwT05teMYvI3a4iQif2VhVFmtzXa8YLbED
	tbSGQmaVNiRVmEmbVDsWwbFew4lIPLiQDD08jpTbFdi6xsoSwVmK+ad2DUayubej2DGODyg1BuE
	rrrbC2fGQUupRpbksinBKFgmHZ+cmjZglWzafOw5YhoZDn9WElS45a/TPE/7HC0kL7MEkUr5MxY
	xoPkeV7mEMElO05EgkRELJKWlClhRgtlTLOE/d9mEkGrtwZqHDFT28I6bJl6VK2idLXeeLh4voa
	NNmDeKD4sMIPvxxqDzK4hyaR/JI3Z3x/UhNwuiuuabOC5K2wPhOmE9PqXe2KYAkajSrYjmxAGe0
	YgddsKBHossEVNKfhujC1NkhrfkgkpLztUH8MOw7akVzsn47IQ/sfXkuIZqbcbdcCdvNOTIs/X3
	L4KVE6/Onz0uhf6+OATsIMJSO/1x+Pf2JxUa1jMS65pkOHydlJBnj49G4HGDbQJqJcZis/8I/RR
	W+eBg3OjzKGyYyt2EL6K/DMcOuz7tZGI2Zfzw2zmQ=
X-Received: by 2002:a05:6a00:414e:b0:8bd:281a:5cb0 with SMTP id d2e1a72fcca58-8c8796a7bb0mr21771676b3a.6.1795786850971;
        Fri, 27 Nov 2026 05:40:50 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-18-138-229-8.ap-southeast-1.compute.amazonaws.com. [18.138.229.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285b60csm12705838b3a.9.2026.11.27.05.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:40:50 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: johan@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 4/5] nfc: nci: drop stale rx_data_reassembly on errors, timeout, and close
Date: Fri, 27 Nov 2026 21:40:28 +0800
Message-ID: <20261127134029.1813-5-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261127134029.1813-1-luob87709@gmail.com>
References: <20261127134029.1813-1-luob87709@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an NCI data exchange receives a partial NCI_PBF_CONT fragment into
ndev->rx_data_reassembly and then terminates due to a data-status error,
CORE_INTERFACE_ERROR_NTF, data-exchange timeout, or device close, the
buffered fragment is left behind. On subsequent packets or after a
close/reopen cycle (including listen/target mode, where
NCI_DATA_EXCHANGE is never set), stale bytes are prepended to later
responses or leaked until device free.

Drop and clear ndev->rx_data_reassembly on all four paths:
- In nci_add_rx_data_frag() when a nonzero data status is received.
- Unconditionally in nci_core_conn_intf_error_ntf_packet() before the
  NCI_DATA_EXCHANGE check, matching nci_rf_deactivate_ntf_packet() so
  target mode is covered too.
- In nci_rx_work() when handling a data-exchange timeout.
- In nci_close_device() after flush_workqueue(ndev->rx_wq) on both
  close paths, guarded by req_lock and !NCI_UP.

Found by static call-chain audit and code inspection.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Fixes: 004161cb52ac ("NFC: Handle error during NCI data exchange")
Fixes: c4bf98b220cb ("NFC: Add NCI data exchange timer")
Fixes: 98ff416f97c5 ("NFC: nci: Add status byte management in case of error.")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
 net/nfc/nci/core.c | 15 +++++++++++++--
 net/nfc/nci/data.c |  2 ++
 net/nfc/nci/ntf.c  |  4 ++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index efd4e5e..f832251 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -582,7 +582,7 @@ static int nci_close_device(struct nci_dev *ndev)
 						   ndev->cur_conn_id,
 						   -ENODEV);
 		mutex_unlock(&ndev->req_lock);
-		return 0;
+		goto flush_rx;
 	}
 
 	/* Drop RX and TX queues */
@@ -622,9 +622,17 @@ static int nci_close_device(struct nci_dev *ndev)
 
 	mutex_unlock(&ndev->req_lock);
 
+flush_rx:
 	/* rx_work may take req_lock via nci_deactivate_target */
 	flush_workqueue(ndev->rx_wq);
 
+	mutex_lock(&ndev->req_lock);
+	if (!test_bit(NCI_UP, &ndev->flags)) {
+		kfree_skb(ndev->rx_data_reassembly);
+		ndev->rx_data_reassembly = NULL;
+	}
+	mutex_unlock(&ndev->req_lock);
+
 	return 0;
 }
 
@@ -1607,10 +1615,13 @@ static void nci_rx_work(struct work_struct *work)
 	/* check if a data exchange timeout has occurred */
 	if (test_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags)) {
 		/* complete the data exchange transaction, if exists */
-		if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
+		if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
+			kfree_skb(ndev->rx_data_reassembly);
+			ndev->rx_data_reassembly = NULL;
 			nci_data_exchange_complete(ndev, NULL,
 						   ndev->cur_conn_id,
 						   -ETIMEDOUT);
+		}
 
 		clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
 	}
diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 4253ede..3bbebb9 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -220,6 +220,8 @@ static void nci_add_rx_data_frag(struct nci_dev *ndev,
 
 	if (status) {
 		err = status;
+		kfree_skb(ndev->rx_data_reassembly);
+		ndev->rx_data_reassembly = NULL;
 		goto exit;
 	}
 
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index f5c9a8a..3ca1009 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -132,6 +132,10 @@ static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
 
 	pr_debug("status 0x%x, conn_id %d\n", ntf->status, ntf->conn_id);
 
+	/* drop partial rx data packet */
+	kfree_skb(ndev->rx_data_reassembly);
+	ndev->rx_data_reassembly = NULL;
+
 	/* complete the data exchange transaction, if exists */
 	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
 		nci_data_exchange_complete(ndev, NULL, ntf->conn_id, -EIO);
-- 
2.51.0.windows.1

