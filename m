Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285021;
	b=cPyab4bTf3XL4R2jtUYSbVlyo+sN/9Z5A7Hhyb0PabNDVwKgud5ON6P/2brd2UMT66SU
	 XqJZ+N3eqsuwsEQCCUe/9KcSvydcvKhjxzmm456fG4EKb2swMAbuC0+9cRZoylO2mpFi9
	 nf8knkBXuJY5xqFTyueCkLVulBKImE/UmR7N1A6H+BL21/G8teyTar6eXYXJvJRUgzGjS
	 wW8kLp9Eh7R22umbBFKOVDJT+O+nMXoH4p9cAATCyGPDIsUm9QgUx/npnyK/iViDnOHfq
	 0wFNequGy7TRj/nCDEnZa7lhJYI525CTorYYMhZc7gy2x9GWGV/tB46aR/cH8kitQsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lyxNlKJrr7VosEoWkysr9zOPM5Qv8W1t3PwxQZCtDdg=;
	b=UYmWYPmizLj9sfEEwk/a4OrPYUCJyB301HPSs9BqCo7bVCqMTBVxISC+lGt03X3oCq5I
	 k08F0AJawm/J9x0gSbavMdtwz1ty0WjDF3rqgL3oijg2YbHJugk+yHvAobqtyD45J3dHE
	 iuRi7co/dKKv4yWfrjMwG6IQJ8cCrKvxwk6se3SeaetTHihEyMvzf7LPKswHjgjYlIuwX
	 0AGYIBnK/8xDQhd5tKYxoFO5TYXJ3BonAAwgr0XvrUDb6XIKw7jmjJS1BNi3e8g3cOGRX
	 UFDZL2kBymh6fU3A6iJ6tleF4qr/e77qzwNR8Sl/MsN90GCdXIqQHU0dZ4kJuPZIDRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhLF37tq;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81960A2615
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE81960A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yhLF37tq
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e55db58cfso137464885a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285020; x=1794889820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lyxNlKJrr7VosEoWkysr9zOPM5Qv8W1t3PwxQZCtDdg=;
        b=yhLF37tqJVy0RfoNOIf341vWvPM2VDB5/dEMhzJJI3vGi5Rv89+jEKjPQLGvAd9+EE
         B136HDRR2rEQSDkoJEXw3SjIp/h8jyoz7IFvxJ/N7oaaNQvJfagJt0d6CcURrIi/LlRZ
         ggYx0BKb8mxQ0nYbwkFgg9+sEBPGIt7Iy9c9Obg0g+ARQKLkJ0qiSHKMBiTJt3vDA0Ze
         b3vh6CD1rRKiF0Qx6tPeGkb1QYRW4fwGtemv/fN4QLEr+SBoI+1gGK6ihzmqSAw33wKk
         nzRkugrVd25XwNdm+pPLt7n60ejuUE924YhaGX1QAsI4vl4RZza8hQKR3UMfrV0h/uyl
         d/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285020; x=1794889820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lyxNlKJrr7VosEoWkysr9zOPM5Qv8W1t3PwxQZCtDdg=;
        b=HDvyEayRkXadIdKCKd1m3E5aute/HALQ/JQRfLjinL9H3hVizC1pk8OBBXJ0dzh83x
         qZXb+AlEfFF/zlpmJ9Bc9imTeNwo2bSgOb3UHI0l2GTJr6lhHE9qbtMi+aLXIsPM/AoH
         pZ/MwG+5H1KlotJY+79/qlLmUK6hNAqRKDYUtukQKHOEqvqVQbTIcIt4MYaootc5j4sG
         srIZuK9B/dEUwI4PxNScA71RB1NQ3YDpi2+1nND5ln5EYkAo1CU5vXO5MNL3og5r0QTx
         5vutAZIkq7oJrwmVonB4lQeRkl8zLWSbRz+V2fQod+wBbY0g51G+x8vnoPMzbk6Z2C2b
         R+Sw==
X-Forwarded-Encrypted: i=1; AL+hErEZQ2gSz98vUtBxVj1igC5HH20t6CkwZVsVyKv986Z1gnQ7zSovwmottKzpOpsfPVrpubUIOuo=@vger.kernel.org
X-Gm-Message-State: APuU4Z98kO5KjRbswixT1t+dSoNY1uDsCUs0gT9ZXDOuSrwNmVj0RaTC
	A+1xdRYlNah7ZJwFFReWOY/k1rFbLn2VKDMmfrDTT9K5QUWxHHsEP90=
X-Gm-Gg: AYBFou0kVfgZhgqCc3cRnGoV1MoIdKpa1bXbjDJTMhxf53QMNbVBD5d63EW7G5ESBSt
	FulR++81dQLUKY5xgaVcfGlAzzI+rsKA4rhKqMljWc/JvnsOIuXOYGF7Vjg/JlNZdJ1SmJQh+5+
	8r4aiOWATbJaCsvlLlyGlACEiGZ6x4Om0MqL2akOXbQBX2V9zCSvG2LDsUUMXqGeGKapgN2t+Fs
	mOotMzRcIaEP9MpAV99h4pxFloNXCPxFBXbf7BJwH3bhD9couuDGqQ15R8tNmBxt9qm7n2cI+Wx
	CU7h76V8vmtPG+JcaiYCjvrWCXLQxDu6gAKMY0eKMJXwguUYimtII7zYS10EXNB4X4LtlRsThY2
	wqNarChacbUSVTqy95hdhUvpWM76KP6XYbz9Pqkw186IimVO/rPFXpd3/aGaRY+tkml7YT3cJsB
	rJaL4ZkEot6SsZH3lgskBwNXaJFm8f1Vjgo7pGQPW15u0WwKQBPsOLCo7TQexjATVcYgY6wDIx6
	2ZLiw1wCefJF0feF182SUpROp8na8cZ6oMaKlyQVD9lJ44fW9O+IglRk/zYgvD3YN4OCBhCwNCH
	0q+0FE3+mkWFIu0g/8GOJ/teHHQLLU6TXGz7QsDM2oKKTEYy3ypRlLfCjXmEpnN7p0FaE0ozSLy
	8ytEH7NEEoSvmU+sR5NClGWp/jvqB5pmHySRyp/tcrGcSsKcRhuD7e/qq9xQjTN9r
X-Received: by 2002:a05:620a:2a08:b0:93e:c12c:9b6b with SMTP id af79cd13be357-9479f3e4359mr239464285a.70.1794285019816;
        Mon, 09 Nov 2026 20:30:19 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e619affsm136779285a.4.2026.11.09.20.30.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:19 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: usb: rtl8150: fix rx tasklet use-after-free on disconnect
Date: Mon,  9 Nov 2026 23:30:16 -0500
Message-ID: <20261110043016.56986-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

rtl8150_disconnect() kills the RX tasklet before killing the URBs.
Endpoint flushing does not wait for completion handlers: a
read_bulk_callback() that passed the unplug check can still schedule
the tasklet after the first kill. During driver unbind, disabled
endpoints make RX resubmissions fail, so rx_fixup() can keep
rescheduling itself and access freed driver data after free_netdev().

Kill the tasklet again after unlink_all_urbs() has waited for all
completion handlers. tasklet_kill() drains any late tasklet and prevents
self-rescheduling; disabled endpoints prevent it from leaving an RX
URB in flight. Keep the first kill to stop an existing reschedule loop
before unregister_netdev().

Found by a static analysis tool under development.

Fixes: eff674a514bd ("USB: rtl8150_disconnect() needs tasklet_kill()")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 drivers/net/usb/rtl8150.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index d51e43170e03..98c36c377956 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -971,6 +971,8 @@ static void rtl8150_disconnect(struct usb_interface *intf)
 		tasklet_kill(&dev->tl);
 		unregister_netdev(dev->netdev);
 		unlink_all_urbs(dev);
+		/* A completion may have scheduled it after the first kill. */
+		tasklet_kill(&dev->tl);
 		free_all_urbs(dev);
 		free_skb_pool(dev);
 		dev_kfree_skb(dev->rx_skb);

base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
-- 
2.43.0

