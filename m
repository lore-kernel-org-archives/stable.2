Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657735;
	b=0IbRKaBuYJde3IEY1bNGtv23h/lFThFqbFnxSzND49vGFTupFA7Q/Ze1IX1nPCdhGdaH
	 yhEPDO0M3x24WA+++Ix0wl+Hl1NSB9ZLko9E5nBHhu5y+Qcj5Lfgyn0G6qD12wRiHowpP
	 OWzMiWaREAv+1qGyGKbWdZkHRwpCerCE7nxtM5DFyYVMNFoRkREMU3XvpS9Hm47wGVBSM
	 P2StP/N1ceD32PSo/9+MdzgCPnJtNvLdY//0AqK2QfOm79UW05t/FDHGki4b0gQPwLMHE
	 5J88mbGddA54vMiMAgm3ZpWMda6jSE40SOnfr2Z2q7pD9ryyMDfODws7BeTxInq2miw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QzAycytcomj7YtaQRGxKObOzpf4opDuIErlVoBcZTss=;
	b=yR6w+PpX7cR63Ems2aPwGl49WvWzWOyMl0gtMpoL8boigjZ7qY0+RCQbvxP8FIIkSjMk
	 NDm0U81k7Tv2iXSIWRifHtyLAK46xGGG7Ga5+4o9FGOlEy7mLKr3CPCS1XfLp9E0I4MDr
	 Mwk/5q/74wLhWPUtXUvQo0QpfjwvJBKZ07Zm3QWN5VLai3QAFaxiOMgvFqHXLtk35mmwO
	 ntV4o49kfX+bxwpbC8TnsQFIlHvxaFZ/azrJaxfxnwhNFC1CUtd34nRMietiFW6MXuyiR
	 ZTRoKdX9jqzYAn06cNee23nY/rSBy3VIP4knUDNy9BTa76N9xEEcYQET8N6wKXQWABg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGzavak3;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E0606A335
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301E0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGzavak3
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso3138941f8f.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793657734; x=1794262534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QzAycytcomj7YtaQRGxKObOzpf4opDuIErlVoBcZTss=;
        b=GGzavak3e0tA7DrLmdafsU9MiTNFGXwVcuNo3wc33/hneDtK5/ziKFuxm2xZUq9+sx
         7h9D6opsLVutH4YG38lhjZEJTB4QciVNBUdN8o2+++QXDq5c/Al40ZYrt2XJt8KHfBXN
         nfoKkzp9m/fsJ+V8wdO1YsCGD4tWKPadxIfzNSfBoC8pRusOvtp/POf04BU8TRyLSrve
         t2JQS2NlbB+eSegEqjlxUSPPwi+pCkaN11FOU/itEAVIu27HAHqW1Oh3wvGigsSp7u2A
         FP/eb9r5ai4NEme3Gb5seyYGK0gnwNY3U0FnkhHf9WkZE1bmvx/YLZXJvnTarb+lX1M/
         FCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793657734; x=1794262534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzAycytcomj7YtaQRGxKObOzpf4opDuIErlVoBcZTss=;
        b=2L2jIAxasEKwyjJ6AE6by7WxrlQUYK38me5G67a6J+DaJ/6y8i7SrHMHIhUJ8JOfFc
         9U4lCF1ICEq460GBsiiOmCcuxc/gBK07G2WtSCD1lsPP2iiShhFxlm0KyFUiSrzKtAt7
         g5jJ8K3N9fxDl4R0HD08p8yNKXesL0o2FaZVL2vWTl5ORkt1WeWE3QKd2gTQkETazOa0
         dL5F6aOs6lpHYANPU5oqtUY68TD1bKWFABO7bmIT+KtEwOXIcdml371N/gNJFqP57lx3
         Wd+oOV+juOgeqDQfuBxGfY9P7yf3JGyW2Ihc3AvSzqc/eDEvM/Rlc9VRjYAnHhajEM04
         47dw==
X-Forwarded-Encrypted: i=1; AKwUvBzJytX7v4je5uT3Rc6ge2wHUG3qzpgVBNe7KnwwrcZyP8g1Jxdx44HBOmcvtS5JnHGHAoJdkVE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F4uBW4OTEUWDP0H5XWFJrTQecBnZAxGgGrg+GHhEGzqwLG32i
	7V+wd+ZlKj843tB+l14lbwefitclq+attg7yi3VyqTKC/1mLFTG3p3s=
X-Gm-Gg: AYBFou1wZfWp34Ec5AO7qhuWIFO9iF8AnCNO0Gul4hAf+JNCMAwcYTXyN9KdidJpgN4
	so00XfTc1j2Y6unBNXXgU+qYkkJIbocf4C82UUN1rKFVo7zv4iRW9R4/O8mVecJJtAK4DeeAedl
	X0hz+VXSyDqdsloYXShs0QFb7zQ+V4UqGJoIjBSc/MFr2moVaUiumf2qxOm8gvpBndwx5oplMVu
	0zmZ8Cn6IH5VNes2NfZ6NU5ZsGKm9GUKAkcXospyiQJFgJ00/maj/BBocbwukJDIL1MwpE8HOZr
	eJNVpR451k1ce0cPKXuCY6odk+8WE0nKYodA2EeY4VeRnhsYOXc27H4+oyGzraOjOm8PtwFOXqK
	ec8ECH5IE2jP3KHEvvbvX6H8H5381iYC/2gtd1/MYy8H8n2gt/6ixaTADV6WOyRyX0HURXUQznA
	wqx9lCvY5mKLakEKEi8ZFxwVQ2jSRKpIBEeLbee+yasvqX91aV64K8RZV0B6D3uhXjJx27Pg9B2
	TTgqJi6ukp/ThMfO+xL7JL+7YCYpz2byqn03+BUSuNiLbzH57z5lyfbJRNLETe+/qqnaD/L5Rq7
	0ynWUx34wjE=
X-Received: by 2002:a05:6000:2611:b0:48e:4e00:b72f with SMTP id ffacd0b85a97d-48e6e50c8ecmr24326939f8f.32.1793657733478;
        Mon, 02 Nov 2026 14:15:33 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b725a2sm20662549f8f.13.2026.11.02.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:15:31 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless] wifi: mwifiex: zero-pad SDIO TX buffer to block-aligned transfer length
Date: Mon,  2 Nov 2026 22:15:30 +0000
Message-ID: <20261102221530.3469388-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

mwifiex_sdio_host_to_card() rounds up the packet length to
MWIFIEX_SDIO_BLOCK_SIZE (256 bytes) for SDIO block-mode transfers.
When the original skb data is shorter than the rounded-up length, the
SDIO controller reads past the valid payload into uninitialized skb
tailroom, transmitting stale data to the wireless device firmware.

Extend the skb to the block-aligned transfer length and zero the
padding when sufficient tailroom is available, preventing the data
leak.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index f039d6f19183a..c46a048cc961a 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2386,6 +2386,9 @@ static int mwifiex_sdio_host_to_card(struct mwifiex_adapter *adapter,
 	/* Transfer data to card */
 	pkt_len = buf_block_len * blk_size;
 
+	if (pkt_len > skb->len && skb_tailroom(skb) >= pkt_len - skb->len)
+		memset(skb_put(skb, pkt_len - skb->len), 0, pkt_len - skb->len);
+
 	if (tx_param)
 		ret = mwifiex_host_to_card_mp_aggr(adapter, payload, pkt_len,
 						   port, tx_param->next_pkt_len
-- 
2.47.3

