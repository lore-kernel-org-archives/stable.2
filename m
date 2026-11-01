Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793566699;
	b=XUA8V9K9NXjH+Kk7blue80Jrpj12o2WOcXlfQ7N7tZu3KEI4GRaKcfr9NlTzDNMkVtVp
	 qjBsrLI24tIY6sl0iXThMNfy/oVKG3LIHJ4Tpkxxph23Af4KrTovDp+L/cpb08Uy5sy0m
	 I0DQAe5CAmPpFsBvfVHCYCiqabPfyOCrV/CLlSNgYQhMQJDuSY1oUFLoJStsAT08f7x3R
	 s8Ja/TFZyJM6M/VQS2gjrc61goPNbasZyYEyqybVvZCr3PbZoyyZTrK4/qNUl7kdKo20a
	 m5BdcnBravF9Jes0T5WXgUDr78MNgwP9+TAHKyGikmyQ+ExZCRZXKiBnMFNZ3J9NI7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EatRaOk5FsW6bG/r7gLBVDmf186l+yQEdWvonTJkkJA=;
	b=iOxoxiqF2gwaId/ehojJ5+s2Jwg5it4bWeFXDHdrOL0GTpyTalqPyWAZRULkO52I07ju
	 BkUqclpzVWcDq9yb3Ueg/AhiM1vhj7xErMbS9SUE706tO/uQV+9gafKJ5YOSDcKCGxW2s
	 DbNICeNuoluG1WDNhupHOrZlqNxCYM5awoPtbwkhPy/u49fi+UjoBEI8t1XqUInd0kJu2
	 hP+uxuyHIqwsfWIyOf6eEyVH4et7QMIdhn967ndCRT8ewe3MwStF2jLFJG103WmOlYbY8
	 TnwW2Nt7KhUQGzxIcH4wW58OEy/oZyEGybJxaTNvz4YwLU9yNJMvSfwdsAfqqTMNZFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjVy4QrS;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C832606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 20:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C832606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EjVy4QrS
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so25441455e9.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 12:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793566698; x=1794171498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EatRaOk5FsW6bG/r7gLBVDmf186l+yQEdWvonTJkkJA=;
        b=EjVy4QrS+xIi8+Bxx+wdM9VUiJUwbuMmi1YRWNdM4wsivLqbfhh9kSUjqoM3UHbyDy
         5CgoRo7BDRWOxZiJoD6rMNEgXki3PH+9hJvy/iwvhxmwEja7CwzCepxTfgWJ50XV1cU+
         cii2qKVabdqfv984KGouJLZF0imJXL+36J8m8udDNDBKJGkSkcC4Iy/MpkKiO3PetDC9
         GHhh4nGUqsh4PbFPpfzBvtMNnFsV7tmW3rjR4IEZ3aiWjWUY1pba+O7RO7K59Q20YHFp
         m0KUHiX/trDZogQQWGdYf3HFV/wXqmo+LKvNlboe0jfO11yaW/4GaJStSeJPLgtV/0ja
         dkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793566698; x=1794171498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EatRaOk5FsW6bG/r7gLBVDmf186l+yQEdWvonTJkkJA=;
        b=Tve69UZexPkQ0AOtKtIZ6TeX3977q+qJNsG/yQezUH5Mwo7VyUzmkVhdNmBJRieZ5m
         xRB+vzt5lD7PPwg/4zx9h72qbsKZzMUrP86nX9/ux+16GzOg7Vx0Vp2bKXduu3/pxxjw
         CQSfVhZxdhETC+JxV3WmD/tKVHPva3CiuqLYFi4msloeDqD5E2g0HmwBYZ9AX/bjbdgA
         kYXIKN1XNZuHM3kGTU2Q+2FeXiL2BQf8+o5nEGSy/mG5GjDys3TDNlU9GFdicCIfg4ia
         jhHV/z1Gbv1RWuxa6GJxpGYzeBnlLMrLpwd47g86S8r4Q5XILujDPzOFXC9ZWtjGmUkh
         3CbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwsbfoRP6Urz5Y2rA1g59ESmW+yzr2Nrre83eYTYJxVvBoapBONDTsyFZE/NfZT06pUth8dWF0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHEpGW/pA2+7zNCs5Qut49086LTQQ8ZGitTPlNAuBMpbt/aYqN
	HOulxYze/5/ChPseYC6t9SzWHB0qGMnu6dF1snV5694A/sHHNbnkxN8=
X-Gm-Gg: AYBFou2gVPBGjNLUDAKnSzeZ6rd+k1Xs53ZZxy3KNaXshj7q+FSNvAcFx4uSb0D15CB
	NGoYTxjJ5CBefK2CQ6v7aWvSne8footOvkQcP+cRMeQhvwTSHhj8FYdVJc3ZLD+roS+a3A9B8xL
	cLkiLb00gXlEOFWhWFtSrMJrhTqiyyZ7ZzQSsCkLD5moUN57RtxZh21RFTkxJnqfUiS8KQnnSk4
	UE7YwX6vMjFbNgXp7AUSRTtMQped+Ip0dscoTngfYUNUhLJ5TiRq0gO8f+KaIOSThWl4uUDWl20
	dqGdJMNy6XxRqHGIScfAh0uekJtHOeg3QB1RsTjF33ZzzucOM6ryqz6ZmiktXTVGB74tgblIrTi
	F5HdiXDHnsiaZQ3tuPdWBBo7dq+VERp0llhoSoTD8iqLNMNuZ5zMtShH9/iW1yGfdk6iTWbffmX
	MsfKrUWFi0/4ujfd7kvb4KgDaz/MsOo14/tFpvphS7jy+kWE9yEGHRpm53nECAcZ91U5acIQO89
	56DySE6oigL3NCuf3XCFWflm38ECBDROPdBEXr4xnjBXPckkgw8CGuqKfQ3Y7j6HMuuUmrPJuoD
	/sj8h0HjiUlKppUz7Oo=
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4ac17b2c8a7mr191454345e9.25.1793566697821;
        Sun, 01 Nov 2026 12:58:17 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9eaeesm16002280f8f.49.2026.11.01.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:58:16 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 3/3] wifi: mwifiex: cap TLV length in IBSS connected event handler
Date: Sun,  1 Nov 2026 20:58:02 +0000
Message-ID: <20261101205802.2909524-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101205802.2909524-1-tristmd@gmail.com>
References: <20261101205802.2909524-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

In the IBSS connected event handler, the buffer-bounded evt_len is
replaced with the TLV header length from the firmware. An inflated
value drives the IE parsing loop past the event buffer.

Cap the TLV-derived length at the remaining event data size.

Fixes: 432da7d243da ("mwifiex: add HT aggregation support for adhoc mode")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/sta_event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index 1f746e8f6b3e18..3f683698e4a60d 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -45,6 +45,8 @@ static int mwifiex_check_ibss_peer_capabilities(struct mwifiex_private *priv,
 		 */
 		evt_len = le16_to_cpu(tlv_mgmt_frame->header.len);
 		curr += (sizeof(*tlv_mgmt_frame) + 12);
+		if (evt_len > event->len - (curr - event->data))
+			evt_len = event->len - (curr - event->data);
 	} else {
 		mwifiex_dbg(priv->adapter, MSG,
 			    "management frame tlv not found!\n");
-- 
2.47.3

