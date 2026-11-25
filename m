Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599196;
	b=h0U1LdfB0cHLIYRAKn5DbVTlH3JrBImw3R11zNsJZHffQpX2KeGy5fiErCUwa8mN6DRn
	 lvmdA0X6vE6GIoQNF+9nVVPfdLVW57jW8fZWQ0G+ABqnI++CoRc2uD4mP4Xu28xfbeOPC
	 xai4V97Oa9xjTmVxAvQybOnONsygnk5/4CXalqt14DkEGLtRk0bih4GTWv84sd5t3UUy9
	 ubVi2ZIjPoEfuVhfq2az0JFsoe5I3QIcYRqCHoYIDjsPpGaV+OuI2k26a/t+gIZbNXEAy
	 Qh2CzjRhDn4mve+05GcFB9SStHA5CNLRmf9LHwfoDtGflOTxsAZytdzFj95uyJ+v8iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FSmYL94CLAH42+p2nURarn8jPDSqfDJDEGZWaM+zzZk=;
	b=nLpulFNhnfXewkdblpOBcohHoom0NsDoXueH/I4usL/OkSFUK1IcgBaq/G4Wi7uWA/rm
	 9fbryfovpehXnn0zQuo8M2CnRyTVpJQqAzx7qCP4omYgVhIk3sh6XXXLVS9c29Cn1Ca3L
	 DSxv04aN9j7BlRWhfAgKAcNGy0P27ktZMWHfPXmN7+6Bpy2zO17UveLid22DJesVtQUO3
	 FvVNSaL+pYun6JNw7e9L+a2ZmGN5SWhixfWC/hKTi9nM+VuuyUKpvDKRpoRP8vJw+xEvy
	 peyXHJUyBRDolG3NI79l9as4SDafPBa/FkD8ymCuNopkWM4MqXVzKvNUtAkLFGxlE4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t+jv/z5h";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F54606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F54606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t+jv/z5h
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492f0a1b685so3803469f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599194; x=1796203994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FSmYL94CLAH42+p2nURarn8jPDSqfDJDEGZWaM+zzZk=;
        b=t+jv/z5hjGeEZm/mbVnKGhsbkhkJJWeN8VnCFyULn7VO4KiVYiknQKEAtQ8MsVmYf8
         LKvx/zvmxcc21se1l+Wa9RJLJFBNW117WZ4wfoKsn5OH5xoVeJKZs5TC5ThbYb9vRwUe
         rBV8Njv/LcIDpW/kBFSl60hriN9wJCmov81Eejzr8mVtlDL4I8n9hnJECpQ6dVk7Gu68
         doyBYGFzRrL4NCp/QaVBrtM75SP7fZo+GWRCWjr66yv6meracAZe3ebRVg95IqQru9tI
         GNL0uj/OG+xDvfjUdPt6eXAOjG0Q9eNUGVizx+bnpv/A67Ch+WOYm8Ocm6jd++GL3hl4
         eK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599194; x=1796203994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FSmYL94CLAH42+p2nURarn8jPDSqfDJDEGZWaM+zzZk=;
        b=SynYP2pp2ukJUxnZG7hiC8xY1zTQVlbdkauK+92LQrJq7TRJoM0GK8NPHhC8y37ivF
         BirQOkT81Q3lY2K2XxgZbvubvIXVopegIAOwg61BLEDFEsEBa4zXeRg9//ALsdK5WgXy
         4OvgXwQMGpffEj9AEX7XliECMcCQUUlY4tB+BEkscVru8004umDOKS17/CVtFPvsCDr6
         E03M8d2PJegEtI5zlfG2JLPcDctaIw3ca2rAiRjll22vjNrIkOwf38Cm0bA0NhB252Ni
         7nUU9uiBVzWumoWC6pxUZvV+ivN1Cwde9eb5XLBgETBb/tom+QO03KKtGylx+RVxZAcV
         Tg4A==
X-Gm-Message-State: APuU4Z+iZgkK5rm0aKuPYGcJTEozdtpYrVhCdm6IkVRxl7BHV/nBGY1C
	JftLNs616LiwyJD+DQW8OvScCelcl7B0XiuqBpos10hF6hZSRO1Dekg+xyGGMGzU
X-Gm-Gg: AZFdTZfVB0WodAT1lw2oPbDwb0S3rfUPDIiFuaOROOT4Rz00K+mC3/QP0GPRmw/eERt
	1g8rmXo9ebbJdLAoElp+8znI6ISZ+/BGE/925D01PPydHXiI7zXdNqxWDb82MBi55yAfoUadoIW
	5iC43gKq0+LhOpS7xVeXuXsxHKAFJcQx3AjH97FB9q9eUoian9BCfB3kMt+Z2zGAVJfytxxPmPy
	fWZn5kiH+fxf2HV7zrcqEjjCaXEuxhnOla+EapKMHvdR0VOvWj++kOilYsBT3Xyz5VUQtQIJl7U
	ClMNQ6/vRcRC07jG6QcJqNqG0ohidJHwSPyUhOrA5AJwvalEZZ7u5GUiTOK3IyUM2wge/fLueh4
	+Zn9infelaQ6L5aLWOxPZ3yrbCArN/nmbPYJajZIPkjAnB7RJ3LbbmZKaT0L7t+6WKOBsZMahfk
	aS6O+l5s/Zz17slFlhr3w/cC2WLQjhvHzdNX5d+m3PONiV3KrX5DemB93K+0ckigZ33lNhrnznq
	X8/G2rYeLX0DIfx3b/jMSQpLNizkoMz+f/aVh5w+UIsOPwswP8RmR0xWhXbtFFmyqrbYpFavPbH
	t6l48CXvVKofmlqOfImS
X-Received: by 2002:a05:6000:491d:b0:4ab:f5b0:a7fa with SMTP id ffacd0b85a97d-4b598a60967mr13697952f8f.33.1795599194330;
        Wed, 25 Nov 2026 01:33:14 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm32077607f8f.36.2026.11.25.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:33:13 -0800 (PST)
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
Subject: [PATCH 5.10] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Wed, 25 Nov 2026 16:33:01 +0700
Message-ID: <20261125093302.225552-1-petrvaganoff@gmail.com>
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
index 60b1dd16ab0d..0ebfab2c26cb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4819,18 +4819,22 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
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
 
@@ -4848,6 +4852,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 			   handle);
 	}
 
+drop:
 	kfree_skb(skb);
 }
 
-- 
2.55.0

