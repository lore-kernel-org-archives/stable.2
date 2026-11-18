Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006124;
	b=sFXH+mCtWTEN1ooY6G4N4QcowDfhtjRPrnXXStW1DNOQY/xkYT0fF7f6Tz4I+8dYxAvP
	 CWDPZitfy2TYuFs2worUocoi91dmNirv7c00CXaARz1/CjKQHUvtmPXIAsfRNn/p3nVks
	 5kzFdCVlR/9amc+vuMyswp2Px+gKmzOtrWh2yIcEH42vHh/NmwH7to1beYFCSfwdwT+RB
	 fXqqHk6MyuYzzx/TdP28I1ytUL9QIA+K8pJqDLG3frZJs3DLLDR3AFkV1iLvWfPrlwZ4u
	 1+deodUuELPZAWjsLOHloJk8HKzybx5t7nvNvehtmTN2mH7Qhl+oRm+ppmLOCDpsHEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ytH9EhFMxuz7YntPPbpTAV3Bn1q3+Hti8UBQ3IydMDc=;
	b=Yd16tS35Ln4XlUS7LV/Abdjd7Fv7c/b9pY5HU9DkOkNPU7G3CvEWPyUnTFJb9M/IA6Mg
	 kn7sgKXRYbzg6t9y0/TpTGfei2tuZUuGT6Bv5um8rqoA0kjTHsfjgk32bF8xZHb0KmP9w
	 WkhK3Gpp7qcgIo8Co7olVn7IybI0CP/vp2ulNoy3DIiSbGbaqkKFfSaT7bXEtWMMF9Q5b
	 weI0TfI0NX1HXs1lzA0wVD27pPbIeHjbZR+5wYn/QOu8a2GmzX14RAo196IOAR6X3u4nf
	 00y0lNDTrS0DddIYRDKXYSd6+AD0TLteycDqSpHfvoEo144kHRUsuaR6qEVlKPgq3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZyDNa6qH;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE73606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BE73606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZyDNa6qH
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so549278b3a.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795006123; x=1795610923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ytH9EhFMxuz7YntPPbpTAV3Bn1q3+Hti8UBQ3IydMDc=;
        b=ZyDNa6qHMqN8bT/9UckflEmKPPuhmBWElmSUA594C94jxxTf54Z5EYatCyvYVFjoYX
         hwApiSeGORrZ1+GW+mydas/M4G/Xcymm84AoP7egbmUiPf4ukExDdmUsLWbiom+x12hk
         gd6TMTpDHzVbTRqqfYHJ6pW4kNCvPBri0YZip51lYeFqyMOm9j4TOrR46nZfMp2Tn8Kd
         TtBvLOrwAUhemLdjYFrr2KC2Pw9LqiZm2tox/2fTYSofHoIeARlmHQbM/FftxS2rr28z
         tbwLJSJ5taOaNc4B803dtcycGfxzxZe/wP8S60zRqcBrMG9WjDVE5jzm4zXzXnFjTC+0
         eqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006123; x=1795610923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ytH9EhFMxuz7YntPPbpTAV3Bn1q3+Hti8UBQ3IydMDc=;
        b=2Tck8oovbPpkepttZeBRUovuxCx4iRV+FwvpoFgdVWNa8ijXCESFAuwSljkrhZtrNd
         /8kGgGlvw8zmk6EVd3PUO+rADAS7zgErhZ79d6mjt8VYRw+alZmFqMpz4MPqaZHfjC02
         QP4oe89w+Of82uDK+1BKUg0EwfiM3pmaLHahXhZuN5apa/M997R3r8A3qxndXPvwWEPw
         ck0rg9fOgSxrLCwXEGdSCae0KF8BoN7LrhtgRUpHw7UHetR+xaqD4/52KNM6z1kJ3gRW
         yE6MyFDV/VxsFIxty0rnkk/vAtyS4E0FZz0q7COt23FWqiBLFdY0MRockx+c87QsbR09
         lAJw==
X-Forwarded-Encrypted: i=1; AL+hErGquNOKTqnR1Le6lcY+xF5lQB2b5jhYSJuvfKZGAoqJoNQVLpeUWXG5Zdxt3EJprVceiNULuF0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YyOVWKRCnFsUbHJNcYYLCbJwvsb+p4sClYNu+QQ4dX3N2XifA
	4iMCzRXM2klT0aDP7fwQ00m/fvVzZB+JXzrOrIUlISXHv+Ri2XpUWDTH
X-Gm-Gg: AYBFou3JFiOhiM3M88Aca6yT+JIH26zvaj+/A9v3PqyQNPr9nBD+IYhHIwJUYvo2fPB
	yWNFxDUBQOkunnRGIxgRLTZKqNhsLUolW6jurAqgwHioR5i3XixWyTM4UcdDm4wtNPhbjyh8dBl
	c8iQVfwxI5vUOKFS+cru9Anh6oxUrfWEYIjdEBq1EtrkZW4PEE91DqQ9wdoqI78ItkZ+7qEMMUj
	MBjSPedjJVIp4fxu5ltNxCXBW6ldmlHsR9OBTGqR32sLLfm0AU5leolRse3Gbwi4D0qmtJw+vCn
	U6ENLiGATNmxU0RJievAVKp22sdvRgr4afaP+XHhv5PYeQCJjhIC6rlrhaVGAB9pBR3yuMBgzTV
	4Of+VLL33gQE7rLuPj3Ivnd72I0xof1tjIrqiwmRfs7aIuhcnRqhOkHWH5Jd0x6120Gz+7MESbA
	2+5gB8OKwlNPrpsh76aXRHBC9Od04kYQ5rVdoGoEi0z/Bxb5/Iac5gYGNu2O0zC4mI0PAMpIkgX
	NgQFYjeYITYVf8U1h/f+0MCmaaL/WoXe4cTGiZB+GrEhCpAKT7w/MP6n2t7jW+Mste2E9VOeAgR
	2LWQcZYh+mfxIr0Sz6VGVV+m1erdd2Ht5oUDcYgs++fsfWYx9SRSH89QkShDiOjTUrI=
X-Received: by 2002:a05:6a00:1acd:b0:8a0:67e7:1004 with SMTP id d2e1a72fcca58-8c455fe5db3mr3817702b3a.11.1795006123031;
        Wed, 18 Nov 2026 04:48:43 -0800 (PST)
Received: from G7XWH7K1F3 ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb54e413sm1176077b3a.43.2026.11.18.04.48.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 04:48:42 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH] Bluetooth: hci_serdev: stop write_work before closing the port
Date: Wed, 18 Nov 2026 20:48:21 +0800
Message-ID: <20261118124821.3990-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
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

With HCI_QUIRK_NON_PERSISTENT_SETUP, hci_uart_close() clears
HCI_UART_PROTO_READY without hu->proto_lock and closes the serdev port
without waiting for write_work. The hci_uart_flush() just before it
re-enables write_work and may replay a recorded wakeup, and
hci_uart_tx_wakeup() queues it from any caller that passed the
HCI_UART_PROTO_READY test, such as the serdev write_wakeup callback.
write_work can then call ttyport_write_buf() while ttyport_close()
releases the tty, so it writes through a released tty.

A partial frame that write_work leaves in hu->tx_skb also survives into
the next open, which flushes nothing, and would be sent first to the
controller after it is powered on again.

Quiesce the transmit path as hci_uart_unregister_device() does: clear
HCI_UART_PROTO_READY under percpu_down_write() so that no wakeup is in
flight, cancel write_work, free the leftover frame, then close the port.

Found by code review. Compile-tested with W=1.

AI assistance was used.

Fixes: de8892df72be ("Bluetooth: hci_serdev: Close UART port if NON_PERSISTENT_SETUP is set")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.12
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

 drivers/bluetooth/hci_serdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 194f11251cc5..028f691bd7da 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -164,7 +164,18 @@ static int hci_uart_close(struct hci_dev *hdev)
 	 * open may drain the battery.
 	 */
 	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
+		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
+
+		cancel_work_sync(&hu->write_work);
+
+		/* Do not send a stale partial frame after the next open. */
+		if (hu->tx_skb) {
+			kfree_skb(hu->tx_skb);
+			hu->tx_skb = NULL;
+		}
+
 		serdev_device_close(hu->serdev);
 	}
 

base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.1

