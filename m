Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026907;
	b=dgld6uZAl2uUolUwGQdQsx8bCekws1sGF/4PBscKEsV30LS1KrcnCaBQoLBeqHcI/z9A
	 UWcDlfqgZ/X7bUqzQkuzi0se01BDLsDWYFNnDDxvzyL5TrIPhklYJzfS33czdcdV1YYy6
	 Y81lO3p2c+VCsZl6/XqtlgMeoixNTFyNwdGxJdhV9XvgzC+KV2DI4nNLpneIkieb6xKUK
	 kMTfcbb6evTz3Iggbgwp2y7VqwLOcvIR3O5p5dTZxzlu8y8eURjpzBd0uGHVcZQE4GOka
	 RowS3L+mBeKnblnvLoy/AFvgBF9a62nKSHr1FGXwIr3hft4PIJxH6e2kmu8Ur3eHJ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J1mE2/uvxHDBhyh7b8T/IYHmltMNQ44dSYQaeZ69JlY=;
	b=WVIfQScP+isyCeRZD28ljz0tSh1XyW6owtjgJgfTkHNShyUUiJwnTpjfZlRzCOJCFV70
	 D9DiJT0tcyjy3X9DUyBW/+fuDeSaW7ofzFkuTOsjFgd6AwSr01STd4SHfqzkYOpWPNCry
	 5fScURqxOUKZSvYsugGe4ALPk4ik34tg3Y4p1Z5+6GkjcxdI2BctxPi3tUoSUh6lOMx24
	 5+KntrvdYgpnxh41hqUKKupAwPi+N9KEiigDVytyY2IFm32K3z0/ZUnnnImDx0wSvRWGu
	 4yaqFfdoK0medtNCnOJVtCGgjLu5Uk7OMmfG9Rr861zJtAN7f1Y4dPxOXftSG2KrDXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WXU7IlvU;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C64606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C64606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WXU7IlvU
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a315ed211so114812eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026906; x=1795631706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J1mE2/uvxHDBhyh7b8T/IYHmltMNQ44dSYQaeZ69JlY=;
        b=WXU7IlvUoaBDmdG0YdpGKD0oXbWF6EMQnA+H1DRw7s6gz7dnXmc4kP2voAooCKo5do
         X/NNmx8k0ulmLW+xXDicvQquBqw+3AFEetSr7GO9kOJLEE+qK6QjgOrfgpnc2pFZ4OcA
         RsQoyhvSWJVNBYEdWmvYI0SSc944SbEDtI5x4K4rw/TslaKjQjucCABoNhTehwt1FZtr
         NmwgYZellNLKIozbGeXe6yog5yPBFhw8RUqjL2oQ+q3ZlQjHS/xvXZDjDIWt5hV/8gNL
         qd4E3BJ90OevoLD/G8g0Ft1P++4IkgKFzgmOTUmxnJTsG548izhEd0dapgJ0y5kWTZNH
         9PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026906; x=1795631706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1mE2/uvxHDBhyh7b8T/IYHmltMNQ44dSYQaeZ69JlY=;
        b=jOjzlrPJuUXizPZ961vGVAPZsvn1tZIkI2wOzWxR4TIccvNSvSsckxWOr0ExevXjY/
         OXK2XzfTAiGsVY5a2l5kaudeGMiwpluI1Jqiz2n33k72+h1FV6SocRcvimoEfpZ4Wc7s
         rY1G/4rsJU0pSAlHoupJWmKkALhF2ezcWE7YDB6vJij4KiLJjBISLsZY/F0GurIv9N0D
         Y2r3y2smtp16JyKvmx71uVqF2+MgoZgWSrK4XHhpo4Cduv70C68UIQyB2VwhOwLAEL1r
         EcqiwRzApPX+4NnbZgnCutz36mNIC7Cx6K1N/TGBafg1mt38clGvdfN2l9xm5xKL055f
         UCdg==
X-Forwarded-Encrypted: i=1; AL+hErGe+VLUY3CLiAMuziWZKF27t2M619CRwn/iAIKYDzOQrlqbTUovD+Sw9tax505rCBzOVfROAz4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gvqdjJsE3kdWYVSoiwZGhyNFhCr/QAiti8srFy8TENQaE5GVX
	5v5NOwQ6SOVSEVcJj+552ay1ySEtj7EU1/D58/qiftKACb1Rufkc+pNf
X-Gm-Gg: AZFdTZfW7oe+DHK0+IiQBTZvH1MJBmC0yTeFCURWvpFXDPTdzoZHfeUeMUgycucuxQl
	wyiug8RlTZDER9y16dtcbDW4R6KpZ62tcz18zn87JiKpjckFlm7AxCDWDlnP2rIcJ8b2Mf1BMP0
	7HGZUTYm+5JmZoeWhtbvo56RiLs8jAxoU74EhRSatDH/yky1G3dJZ9JxTjvK6ofm4WV/cSC8KZS
	bNsv4MP/iT9yQvI2weVgrn5dn0+zd9MwJ6k0w4YDqQX0eIxBfcAPQ5utlFCPJ6KKVnFThSJ18jD
	eNJvpPgsNzYNWainQ4tLUnFTYmNaAd4FyPpZrAwJhyQvJYOb9yDdGv7AizUdF14vOrPvGfXRelj
	t7GUQoN5CdrbVeNnUxPCVRb0f0JUAVeU4779xTFTfcl2oLY9aQE57/+oHFncS/C1lFhhAxvxkeq
	ntk7CSm0Jwo9VOfWrEG2rFJSuXlkI48t/nA14fZ6AmY1QhYdo9iqB9rv1yE1fHJnwaZfgMWKLWE
	aK4KLH9FWfVrTRkiLqD2NgGidhbB6YnEhnsz7HzaP9A5pXRsxG7fMCTtxMnAmsPFPRbKSKbOHgA
	ZmQisPqnGEf4u0b61GPwixqOKMLeHmeiuAj2Ge1uwuHXDZGHmTJXFj+2wKwXHj1tWcI9bygIoXL
	F0+W5
X-Received: by 2002:a05:7300:ae97:b0:382:2ae3:b1d0 with SMTP id 5a478bee46e88-383ee2228b7mr240375eec.13.1795026905715;
        Wed, 18 Nov 2026 10:35:05 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:2c16:ada8:2d24:d03])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a73e0aa6sm9453348eec.19.2026.11.18.10.34.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 10:35:05 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH wireless] wifi: mt76: mt7996: restore the wcid flags on reassociation
Date: Thu, 19 Nov 2026 02:34:38 +0800
Message-ID: <20261118183438.44794-1-enderaoelyther@gmail.com>
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

On disassociation, mt7996_mac_sta_links_event() clears wcid.sta and
sets wcid.sta_disabled. Nothing has cleared wcid.sta_disabled on
reassociation since commit 13e2e9c6b348 ("wifi: mt76: mt7996: use
mac80211 .sta_state op") started setting it. The ASSOC event used to set
wcid.sta again only after the rate control commands, and no longer sets
it at all, so wcid_to_sta() returns NULL for a reassociated station, and
both mt7996_mcu_add_rate_ctrl() and mt7996_mcu_add_rate_ctrl_fixed()
dereference it.

Set wcid.sta and clear wcid.sta_disabled at the start of the ASSOC
event, as for a first association.

Fixes: 13e2e9c6b348 ("wifi: mt76: mt7996: use mac80211 .sta_state op")
Fixes: 28d519d0d493 ("wifi: mt76: Move RCU section in mt7996_mcu_add_rate_ctrl_fixed()")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Found by code review. Tested in a QEMU guest with KASAN and a test hook
that reassociates a station through mt7996_sta_state() on a synthetic
device whose firmware commands are captured: without this change the
second association hit a NULL pointer dereference in
mt7996_mcu_add_rate_ctrl(), with it the association completed.

No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 9321c8146e2a..77f0664fe57c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1491,6 +1491,10 @@ mt7996_mac_sta_links_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 
 		switch (ev) {
 		case MT76_STA_EVENT_ASSOC:
+			/* Restore the station state that DISASSOC cleared */
+			msta_link->wcid.sta = 1;
+			msta_link->wcid.sta_disabled = 0;
+
 			err = mt7996_mcu_add_sta(dev, link_conf, link_sta,
 						 link, msta_link,
 						 CONN_STATE_CONNECT, true);

base-commit: 763b13f622e2758726e8e3ecaef819db8fa0430a
-- 
2.56.1

