Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599152;
	b=jmY3M5FgebxiW7Dj5W+rV3be3FB/9fX8OgHJLh3laJq1a7HFas+SM4pfC5jZXAn1kvLR
	 HZ9UPD9f+M7MetVvf36DOw/z9OkiLtRrZmxctA1RIgvr63FTI/+EZrur1tf4SdEGggCIN
	 JxRjnemo0KJI1z0Exd/mrSENJDX5Vj+JGpILklMVdMTScKwKjwNRfSy5sbu5KjZFKF0up
	 SgJSDDMKopnys43v1ZReVHnR1Hbnu6ZHaynlnqzMVLlcIpXw7ykX/StO/LjkyxCOpES8C
	 4PkWqrLFbjGbPyuXl8lHqDLxawK8iOrgWaeB/vGYkTFfrNnBldNhkHCirKdrrewZPjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=l4RHB6K7RgAz/nQf8J1fwTRQBwHcMKQGbkgU+q0PgV8=;
	b=VFUhDg3sziGTqD76aVTwEtZnA8UbOR5J95yVrgSKBoJ91AdX/8iPS+n3SxfkZNxzXeiM
	 6OgcwNln59Y7J3OioxlyXML284IvfEKvb8slIP7W96nl55Y+DcHeTX3jBVTOlFZA6oaRk
	 D7ekC0u430nRZQoUsUanJq5xHeNh0qgJE9tCj1gq6/mP59KpJWmuol5cOSeZpAf5hQey3
	 OhI5uP7U2d7Fv1mpdnDD3nPCBldHFWczz8LTjSuSAFdtJ3ge/ogL3Zd42TAnDtiS0RVEi
	 HMh61tJoB0G9qfglCCTx91PMx5A4/sB2dLq3iHMt5IZxwa4met6k73HO5LWGzBJOlrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ucWggkp/";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36FB606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B36FB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucWggkp/
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so44165955e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599150; x=1796203950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l4RHB6K7RgAz/nQf8J1fwTRQBwHcMKQGbkgU+q0PgV8=;
        b=ucWggkp/ylQeQo+d3P3B4kePoFLjOBL4EURBC03OYEs6t0KRzCt7GAV9npYPdoHzLU
         y2QCcusM0/gl1bRT/7n6sOQOlH8ZAZvNUziP9aOJxCeCF9B6O2ZQyb9/irm9jUDgVqfd
         KBrfejRrsKZfakTfthYUuLt3B3LVYrXRrjsXjXu/0eq13CNTZ28ATtCXjnhlXj8oGqn+
         y+XiET0B6ez89fSEwIN6oUY3zGE6Mo8w+F66hI0KqkGCVDkgSAUXbPu4jpmIAF3pImhn
         TMQVlLSY2STfsdpLmQEvN8nj7QxV60X4C4kNhU0wWxhADCPybT0L3FZ+KRhBwXqR8aTP
         bhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599150; x=1796203950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l4RHB6K7RgAz/nQf8J1fwTRQBwHcMKQGbkgU+q0PgV8=;
        b=zCIniGqRXkdnDMW3gY2IZigiJtLY1w5mRayJ9/l1k+OKyVSXJToQZ8oWBKERuhC9aj
         O32vS31q7gjN2S9dw4AtsP3skLLe27fKn6hosb58haRT01x9Y1CWPHKDPivQSOU0vNJb
         CdHVtPG9BSDLiQanarIAfVl+W2d/WH7HAserFfoX7++NU7c0vXxnVV329U3wEpy94+8f
         uWYfgzyib5g6k6q1Al4DKa4UBsQB7QDbl7LyfZICUD0MjYRCCsk6l7ba7qhhdMoIFUO3
         IOsGVmmCJkgGLikSM0TdIG6Pf38a5pDwsDA336+gANqXw4ZZO6bHldp7KXxindIisps2
         y01A==
X-Gm-Message-State: APuU4Z8Q6wU9iYG5YQCVQexocgcakSW9A0agKkpKvFU5L5LzhsqhC4du
	H59SOvOPNJ4qskkIqWlt/Qor7s6CftdG1ysSGWtiSA2P+jWC41MZ0ooeV8uc7ryR
X-Gm-Gg: AZFdTZc5q6/wCRjDXtFdd5m+jROeykVw9qnTbLsJsnCmmTYaVrU7khyI4SSKJ0muJpv
	hZe0ZpfjQBMgaiMhxpQ1fOgfkU0gqesMZG2dpFuhjWnI8gMF3L2FhtfTD40k2d5c9Jen8snbFRD
	OClfwHV7SUL44XjFaxKJahehoPZS0AvUazRYpbLLXZf4Gfe08fYSFWC37uZp6j1VYBDUNowRmnv
	9QxoudjhS80+deDGXea0sSsv6RuslkjmoxZDXKXyqQJlj6Q0+kxJgIfpdPOZj84nhVTcju1qp0X
	CcrGXEAPRvgHMU40R/Vj8dLAqy404YHUHESy9UrgaQb6/EH4tQ1YMDlttC2Z+axSgv4EqTLpeHA
	4jBxZ1K2RJP7IgPOFpZEdgPXIlCawMUmTHag1U7Nj7F0Dj7BgkF7enZ2DTy2/TPUOsR/v6RBx/T
	/nE6WiAftiDI0pu+ugEXsB7cxZWJAwaFo5QpwszHknXfe06UvqzwjMyhl1RYxJn9X96yE0uMUy7
	RxfA4WI/FYvxMHe1Smok8TP6E9Zci7fcHwhVqrz05WPFLNHuIEK47vniHcKK2q1sJnwhPdQzLEf
	Zjj3M0U3ijrGaPAUaMSm
X-Received: by 2002:a05:600c:4e02:b0:4bb:5d39:95fa with SMTP id 5b1f17b1804b1-4bb88811c82mr338133785e9.12.1795599149909;
        Wed, 25 Nov 2026 01:32:29 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm608782495e9.6.2026.11.25.01.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:32:29 -0800 (PST)
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
Subject: [PATCH 6.1] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed, 25 Nov 2026 16:31:00 +0700
Message-ID: <20261125093208.224568-1-petrvaganoff@gmail.com>
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
index 1639097a865f..443a1bb76019 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3786,18 +3786,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -3815,6 +3819,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 				       handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.55.0

