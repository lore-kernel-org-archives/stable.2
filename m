Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786845;
	b=AEDDyQeQVa7Bagx8qVqtrDbOwZObPMNRDvux5PpWNfTqR3M3VMp6Mff8mTajBhyMP7J7
	 23uqTXnSjUW9GY29Aa4mmUJMns9u6LR87jT1TJ23gSkKjKykD6EVVzNxEYpKadcn8cqCW
	 nAWvVeJjoDWTMWeW7Hc7B26CX2tzCYoogKtweO0IP9336R4HiaC8H2e9687i0GHhBoPLU
	 rnikp+WUmqheSgGzBPqecov/dMmpbEJzQaOcnfIznginNt96H0/TqBzzVqOqdjj8IHeuU
	 Vv1D3Iw6G8KMolywNAGAMVcSVXtCycBwU3wugDu9Hz2h1iCi+ldkuImjCgcFync0mNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3LE1BcVVH7zEc6qfRLayg6Uqh5RJSrPQPBJQY4neVbI=;
	b=NBKY0Ovklv4puVx2XB85khcs3t2+c9c5pEADywNojQLQgL7Soauy18NVDl3oyEF8z6K4
	 h3RSqnzMy0GLw1U4POKN3dwnOMIIXrfHfeXeCKgsmKBiUsyODgJyIX4FOGAgo7LEzEVpA
	 RzYKKQmNkikBuVpe6emO/hO2m2z163kmTgibR3j+wytMBUQELFLCIn0ZNqVxzBKW2iqdB
	 gTrtsYVlL8RwqWcBsAwE5jrqxCwfMfMwghqf7CK7xdg9Zl2Qeutdtbqo0Out/ZMCMKuAm
	 hLVF1CnQaZ7wdFZkm/Ig491BhB1+mrCjnCFH+bUfQqAiHq4K1lysLQl7kM/GctZ049g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TemjPT1P;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9A606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A9A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TemjPT1P
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so3992235b3a.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 05:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795786844; x=1796391644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LE1BcVVH7zEc6qfRLayg6Uqh5RJSrPQPBJQY4neVbI=;
        b=TemjPT1PYCXrCtrlGMEwsLLKM1b89Ehunh/TUQUm2DuXh9YR9LmychrTwBTJOBY3X2
         XWybj9F+0Jjoy+xBIevoOnRWWK3/Ep4DeSCAKbLOXavUXQOAa91k9s9uqmAB5RqLN2og
         DahD833A8zFojvbde7DDbqacUwE8CtwOFBWcv9sJjFaU3/McaiyLIOscO5QX4uANW/eO
         IybnsCMRLXkDMMaM98894PKWLxUx56brUBsQOrscilppESS0ufUAJ7r5W/AxekFfUCJZ
         LaYmPv8tYnymhI3bxnA/qjY3dKdzjaAod0NtNrHsW1577vBb1/WK1bOQThPjzXxnKysi
         yZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795786844; x=1796391644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LE1BcVVH7zEc6qfRLayg6Uqh5RJSrPQPBJQY4neVbI=;
        b=cE3SzOnIWXVg8M8GAMDF6+CtamJx25lFYXMvnztsZWDVP7yDGKED+37VxAmnZItxf/
         AfSdsKjD041IbAh8TFPqyTe53zyut9CbSnfNO3mzBUXhEU7DsCvTfH1Mmb4Ppk5hi4mB
         0yy+LFZ4W+yH+ywibKzcHM4LlQzAjSZN77WOMHGvywUyjJ//bunbbRSeFWLzXg+Ssvad
         2jc88H4BGUNIMFkOLbJM6M7V8ibwi814kwhZmcwshgnOt+It4IOZtWtRMZkjoIN2F+WP
         EUClfLXCVBtfN/W2z7vhfZYTV9xGuIWjb1az9GCF7FUMiYPthbMigWZk2qJq/6avGpOw
         qSiw==
X-Forwarded-Encrypted: i=1; AL+hErHtQiiyZC1L9M9HVLg2YIrkdXQPrgY3ig5PtEXYVegyZkiHVPXkhh6LvcLIiwEm3I/2Zn0UOH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8teTlXqfivQlgraxnb7rz7sDXLst/XDNVCcsQDLeNx6ovpii8b
	IE2eN0tA81VbFYdqML9HjUR9LzGAW4ngM6car0QIep1mXjzPTtxIzwQU
X-Gm-Gg: AZFdTZcGCiitRpbWcTwP4cNFH+x7Z7FcxUVZJE/F2DG8iYnHxv/ywhbx1JuFC6VaioH
	8aVX3O+W3qKVOwzo+1QZibo9Fc91/TwuW4A/vkneNk+vihCh65HLaTpinIVFblE9AJhij3nbsCg
	nnfmuvRQNvvUYxNLyK9af6QS1g6XFY9NoQPowedmYQNLE8BD5fNknPKkeqjXZhX3sqMnkT63G8f
	fAViXG2MH5MjKgvwg9DFlZKW2TcbUXvYRJHkqIsI5O7qnPINUImiJXmB1GXfDdU1Xds1hFnKMyk
	zpaEIDqArdguWkoxqSCjshlPHOkV5Hy73KS9ZRJMB7aZqKqZeW7tBxuPm9UjV5JoEtxCbTHeSk4
	RB68TGDoYCNRfN9R/TsrTkplWRFLcgAXE8Ngo3PQHO41rYKWt88PSvOnIh4biWSHJvr22GIP/WS
	kfchf647fo3fvxyDl4ASctLcIF9KPKs2VsEyp6oKAh/VsZowuWvZRJspI5VU+xdMlbMlXFTnZEZ
	GicwPLSPNpmH5Fw+wRruRJeMuJaNgbHgmcXm8gqTR/QurUDp3qSH26POddP7pOBaHihgmDsnw9y
	leVPQSB50ue7Czyw0mfqoK7dPPmir0zLwH3xvgk7u1CF9s8SzBP8DXsnszYnSlvUH3PSBVQBAbx
	id2y2YkP0lLVzAdUdytW5HxXFFdKn1urzyqApWpBx0aR9GGnVe4bE9R+SoxrFUJnSrEMvDA6qF2
	lrTlaSjJy55gVjE8kodQ12dN0CSZl5Ucn0VQesavg=
X-Received: by 2002:a05:6a00:a0b:b0:881:4b47:f30b with SMTP id d2e1a72fcca58-8c87baca629mr21852554b3a.12.1795786844449;
        Fri, 27 Nov 2026 05:40:44 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-18-138-229-8.ap-southeast-1.compute.amazonaws.com. [18.138.229.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285b60csm12705838b3a.9.2026.11.27.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:40:44 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: johan@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 2/5] nfc: pn533: clear resp after queueing to avoid double free
Date: Fri, 27 Nov 2026 21:40:26 +0800
Message-ID: <20261127134029.1813-3-luob87709@gmail.com>
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

In both pn533_data_exchange_complete() and pn533_tm_get_data_complete(),
resp is queued onto dev->resp_q before calling pn533_build_response().
If pn533_build_response() fails to allocate the reassembled skb, it
purges dev->resp_q (freeing resp) and returns NULL, after which the
error label calls dev_kfree_skb(resp) on the already-freed skb.

Clear resp immediately after queueing it to dev->resp_q in both
completion handlers so subsequent error handling cannot double-free it.

Found by static call-chain audit and code inspection.

Fixes: 6ff73fd239ff ("NFC: pn533 Rx chaining support")
Fixes: 3c13b244de96 ("NFC: pn533: Add support for incoming fragmented frame in target mode")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
 drivers/nfc/pn533/pn533.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index b0133e5..c42cc33 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1104,6 +1104,7 @@ static int pn533_tm_get_data_complete(struct pn533 *dev, void *arg,
 	}
 
 	skb_queue_tail(&dev->resp_q, resp);
+	resp = NULL;
 
 	if (mi) {
 		queue_work(dev->wq, &dev->mi_tm_rx_work);
@@ -2138,6 +2139,7 @@ static int pn533_data_exchange_complete(struct pn533 *dev, void *_arg,
 	}
 
 	skb_queue_tail(&dev->resp_q, resp);
+	resp = NULL;
 
 	if (mi) {
 		dev->cmd_complete_mi_arg = arg;
-- 
2.51.0.windows.1

