Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599056;
	b=Wx30Bw+YtLTqDWEPzj70V8nLUdOexsTZocCl1067J2u/c0FSsr3Gs/76PhuJNBM1oBbC
	 G4RoaeNSlrhJBCuvmRMwSsAoLv2j63JNKyuN86au+BFCrP/EUFsX0ba2jHGcrBlC37jt3
	 t6SC4bcGsWiJEIf+4tZAENkNKtYftar8iEQSjJlw0sQFIxKHUNye1a9PtD9oZg5lT3yDN
	 qC2d1ubI+Z92EbD7I09slmVDBPSg8sHYcdIwLUpdXSuORNjyWQy/FIUpM2dqIhDKU52CE
	 cHES9sEcfiBhCIf8XajTQ935kSrvyWwHZoXveydt6MhkrvgpWnEhaOFvcpgnqeT+XPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=I2k/a6mQECX9SJa18m0wd08GRI20x24K3kfWl4JRMIY=;
	b=pHlUPoYQYQF8Gtjf2fCc/3EI3OrA4oanYgdUfJv8HTZtunjy4fSb0qajpCOEgCvfotvv
	 VZEy3GaGeX+dei3ZCjIKYy2+FSpEl/JBCpF2iKnxGsSqtTaopxmRgYzK5LAxJdosQKNnI
	 JjUcWJvb2Xc3vlbEpiFFBvmwjEhyYMIWQDYZtttYtR63aDDxYbxOKok9GV6+VZ5U4nE3w
	 +aEtcbAS4lg2V7IBHvNsFis/jASVL0bVJXS7w1Tqh0lq4C2L5dKHmzaak5bQH8Tz4sNPW
	 bLwJIn+/AHQQmDCH0Mw0c+fjs/ha7+KpaD1K3UpF8J9gp6NvqiJC2BAi4QdVOzruMUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNWXc6r8;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BD606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5BD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YNWXc6r8
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490d59c3edaso3740848f8f.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599054; x=1796203854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2k/a6mQECX9SJa18m0wd08GRI20x24K3kfWl4JRMIY=;
        b=YNWXc6r8Tr7pGkQTkgrOwXGti2YSQEYweanEGmmVxaHxG5ojfqnJbZG0bCR8C3eAo7
         YRiN41T5jMnoDCHmBwZCD1pmx+RoHAbsAeJ7zYnDxpPVQsYYiEv1yKYZsYaQO/RSxRD5
         t4huvYenXDx8fLJwmW7BmWkueDVWntqeYQkmOz9udTrjEhUyRPhqbGde7SojZQS/lLez
         EopmoOeJFFu3DIT+PMpbB4g7KCBvpgij8B9iFQ+3ezCb5ZOLfD2HcUHw7/QNqpmXiXzt
         XF01dUkcGQqzzd+/kOkh4HI9++vDoICoyYn0Ytvp5lNBmTdAxnN0rUhCk3/FNrG4UUmK
         CDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599054; x=1796203854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2k/a6mQECX9SJa18m0wd08GRI20x24K3kfWl4JRMIY=;
        b=NXiGvmEoIzRc6p3AAnddyTB3LmpkfPz8FbRDShjK2FLk7aIaWkjTs2avyCiko7pixr
         1HZ9WFStVbwMpZv5WhyORlue1xwKWJYq31boNgYfxeg9lHImCSXMDsYCXF6itcz7/088
         WBo36Plh0bHTrVypRgc8UcTVQ+lJz4SEMsCCAtt3gpwWNONUeFVEWv3tOG7oRDgkByAK
         tOFUnRd4O1QJVUNP4KfqY09Zdgc5REBrMCkUv0SV1VYF9/VbMl5J48jdkDr6VNbE2iTM
         RdZKbJp33D6SLtJxeFAbKdCeIhSM0E425XbfokeupXLgEXFUq4x4c+6IS8J6jipfZb5r
         bvAw==
X-Gm-Message-State: APuU4Z/xorvQLJWe1ql/ITqunReY0dDSpsocYcc6Rx+v3ZNnJsd7fp9Q
	PV2DLT2zP0u/tuC7VdmYfyNqKqGs2fTBrlK33qNnU1gHxjjYQ6yWo9BDmZbBL9kN
X-Gm-Gg: AZFdTZerXQmsaBrMFf8f89cpk3i4HKqw4Y3xe+Q1UN3QhTbDjCEUcPwLaFOejjaGWNq
	Pdp51JkC4kIBm4+dPrgmz8/p4nexTU1WR31JUwsDBAotmN97COK2QipcIB+qvFQeaJkA23XwWqL
	ebZmGNYh1nLHnczEbauwFeqFvNEu+SGyZZC2iyHAnoxkk95UcrgLiNzHXbJnrWe2J9rbIdXj+ST
	qh0sQPvOMTJWYYShAHZgCpEzx2I7PP8aN+Q8tW1+TY72Dk6oqVop2vMTieVNso/KyY5oCi4y0Od
	x0eZGEyN/cD0vpZLmdoRu/Y83SRuhyGVLpXUnwvSj2H1UfOkiOnD+TAOp+KyfTW5wVaryZFwkjU
	F63zruTKG7nRGwRW/KyF/WyCUX946qYmzDhUvgW0c+CBEa8GMo+oAztRWtg+Sx3GGWQVQWULIaK
	VuvR4i2bIfNDav03W/Bu13ABT5LPQArFiY/kPUW69NCFymcVMOaPSnD2HtHSc2IQn+0jWIJDJfd
	ye1yMLOsffyeNHJhsGkhyQSEUur6a0NT5B3YUwGAsUon5rBeomk5fWPq/f9D0+iJuSRRtUpqh2N
	Y1aybOIEMwYn7xUPUzcx
X-Received: by 2002:a5d:64c5:0:b0:490:1395:9b00 with SMTP id ffacd0b85a97d-4aa545e25c0mr40657507f8f.10.1795599054259;
        Wed, 25 Nov 2026 01:30:54 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm32220869f8f.47.2026.11.25.01.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:30:53 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed, 25 Nov 2026 16:30:33 +0700
Message-ID: <20261125093035.224140-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 59437cbb5781227567dec226aaa88c66a09ccc5a upstream.

This fixes not checking if skb really contains an SCO header otherwise
the code may attempt to access some uninitilized/invalid memory past the
valid skb->data.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Petr: add Fixes tag ]
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 net/bluetooth/hci_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff3ccb33da0c..f32473e02c1e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3905,18 +3905,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 /* SCO data packet */
 static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_sco_hdr *hdr = (void *) skb->data;
+	struct hci_sco_hdr *hdr;
 	struct hci_conn *conn;
 	__u16 handle, flags;
 
-	skb_pull(skb, HCI_SCO_HDR_SIZE);
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr) {
+		bt_dev_err(hdev, "SCO packet too small");
+		goto drop;
+	}
 
 	handle = __le16_to_cpu(hdr->handle);
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%4.4x flags 0x%4.4x", hdev->name, skb->len,
-	       handle, flags);
+	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
+		   handle, flags);
 
 	hdev->stat.sco_rx++;
 
@@ -3934,6 +3938,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 				       handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.55.0
