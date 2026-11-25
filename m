Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599445;
	b=EDY4ekmMXtcFgkmVDrvtRTqUKI9+8Y83IpwxVfLBGsToHV+lnNbCUVUjG8+ThedtemCw
	 TpVa1aJ7dPZ7Cq5MJcL8WnuqS4fhQKsrF1Pc/gROHMhBO7wvXc/xLZYB4ii3UfN9a+Wqn
	 1CqIImzoYV6bPcE2CGdXCJwyqGDP9hkdbbYTVjLGK+V5BgBBXUt9bc2Lw/rOX4sKWdnx8
	 jMEDLCi2C6Y9DHtabXvrI1sm5LTvAN/uhEQPO1B2Ws41qQxNUYo9LjeO2p9vPZq/4zdjA
	 aQAiGxspqy3zasNGfgYIXwhXn84gzlx4URLeOkkUFLhtZmsHbYM/4lSfjVDh0gJFPLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Uru4uc89gdbKTgL7oPQD/8sChQuJekgJ1PKHJDsBnDk=;
	b=aQssbYA8Vgu+jfT5TDEWK6JYH9JwThqALao0qUxWmSLM0xF1j/jkfqI5mAfKVpUhaO24
	 ivCKmhqiU3uAcxAIR+9EGDYNfjYYpGDMC2bb0YeMe9oclFbtwdJfGDKcpdy9ZTQPzH934
	 kf7u1j+6s2zNa7BRXBEVNyIJW7iWN+aKkDkau5FAVghGYhkvWvbbZF1RNCRJkaNR5snlR
	 YmRBdbW+jdVP/3iW+nFz7+FTxjJMeZvVTO5WwlxpQjLGGVgr5XqpuE1cJ7B3cNYIacXjg
	 Km9+/p3duL40y75ZosB0ndoh9zBbqA9OJFD/uaL6JEKW3S65/Wy38H2JghTkWvn3BZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z0dLjg41;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF332606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF332606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z0dLjg41
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb606491faso29549755e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599443; x=1796204243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uru4uc89gdbKTgL7oPQD/8sChQuJekgJ1PKHJDsBnDk=;
        b=z0dLjg41R3uLk2yeb8k5wxIB6q0Ke/05wkhEoBVYgl+hRx6El5jMIq6grFlpzdFuon
         qF5yUr6pJs5UwqLBK1T8XZ5EoxNpDB9jO28H70rVYGQKIA2VZwvuONhWDs2ceMcoDWgt
         j75aSwOvJWVHlSNd/0UZPtBRyOyubmhYJmAI7CHV+tuSN1HMki1uhpJwRo6IPN8GCR3J
         OZq5nSUUWtaQ0wGfWsPBhFgGHYwz5YQdCkOSLYWDe2SES1Yi53sMnk24AOKsJeEL6IYR
         NWDNhh8/c6LAHuZaTmPQBf4g13zU5LCGWjVQmbsozJyC/XkJ1UuP5SKQr3ZGLZ8N5NAE
         dUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599443; x=1796204243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uru4uc89gdbKTgL7oPQD/8sChQuJekgJ1PKHJDsBnDk=;
        b=tSNUsK+LLswhQS8MIs8FIdsLRwGgCYP/AxSkAc6LbwzBxjlBbmPtyXx1jHKhAcjs+5
         cRctPsQHEsGFYrgzMlMGEp+C1VicjOpRaoEJrK3TJHtZGtMoVnh/wJSWXFOtlG5CqBtk
         WNYiY4j+K09y1KNX51nLlQv93S4ajheMJepQi07dwAEZ/eJXO0jNLQPMmZPq0Qq/u8Bd
         zlB1JUaVM0/dkFj2l0TrvR2xici5zER9QPu5RSLzIXWNq1zkv7EOmPsTWZXZ3ACgw07E
         G9Ya2fSJ8rl/OVxirzPXzcn5FcPHjwLKuvOlV2561wrEIjMbAGuuODfjRr3tsdMn3IQ+
         yd3A==
X-Gm-Message-State: APuU4Z80urWZQcmnRsN4EDYKDPCpW02/T3WCUqnBDPWQJUc0B/zxRSTD
	TV7cTRm/95GgeckuQc4iXRW2PUamFIvJhAyUy9L4AopqFo4nvQaG2llkzylBc+94
X-Gm-Gg: AZFdTZeQn6pkAlIrZlmHWLr327oYPg1uPfDUOV2rJmMUybKZX1GMWmZSbRBgF0ulG3F
	a8eeI2ZZyvf/X/RB4NUsdZ+kx8GZrHz6sGJTuvQ1bdwfPGRVtzXTECkkeVRR0atwASPBphm40wR
	gLhkQKIlJahl12CfyA8mqqnWYlU7HhqJbSjwyG2CT/+kGsFUy3V2LYIW+YyODKKNt0T7jb5V/id
	3zxGXxbmJJzemtQC9poy6EpKirdr5pUczrHMLYBMekcJiuwbek9z92b/yQjtrciLxnYf26bF7Fg
	Lq1hUzu2dteuwzBqguNBIoxJl32kxEG+LTLbePWi5J7exiGBGIdugZfdLSRcSoXKpqY5RACDNx4
	FucBviylAhGaKn3s9flq1wYc2lIwFjK8ONByTz8YkeSjfSXjMf8dzJZAxv5uSnZEFRzyjbIrRec
	6wQnLoE2w1LjEi3B0BzLKeSq71ZqD2vvcdYoOF58RjF48Hbd9zQGG/Bz+OkBP90L8k11rqLPCZu
	6swm4JM4PfLviLeJzcoJ6UB1MGOTCl+8LYixaMMbc/TOHljv6cxUgJwrIojElllfL2SsQOxpB0I
	XhJb+i0mnjOWrq3xRYgDiaLXO5EJmgdakNNTIXgRsg==
X-Received: by 2002:a05:600c:6092:b0:4bb:6ac0:6dc0 with SMTP id 5b1f17b1804b1-4bb8892097fmr322215805e9.29.1795599442922;
        Wed, 25 Nov 2026 01:37:22 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm492567075e9.10.2026.11.25.01.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:37:22 -0800 (PST)
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
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed, 25 Nov 2026 16:37:07 +0700
Message-ID: <20261125093708.227125-1-petrvaganoff@gmail.com>
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
index 84d9a445e08d..67a13dca41bb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3838,18 +3838,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -3867,6 +3871,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 				       handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.55.0

