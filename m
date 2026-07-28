Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786E434417
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239616; cv=none; b=kT9h2gwIqvrT+NtmJEQctQRtqOV2RtCsHTqls1q/OMtLx39Ha1RDSMa16Ww6G+Bt6ITpNpWFSN7vOtow3cRxcUTBGUT1FMOugnktbSXJ+pCnDKehaXRbdQV6ui4V0NE+RzkBJzBDbH9YNqqL74WhPl7sOCMPz2QNC791vYKYicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239616; c=relaxed/simple;
	bh=joLxa92zVzMzJaMavTBO3wCXnjexz2fmjbhYhlxqeIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMOZQtGkr1BUHbFFzwB9OiGY01L0WmXmsFwpHzz6Jj2fZvSivK3p2RMJz+5s87D1vwkIVuJ41WhOdXYQSf3YROZt9sx/5McjcTRuzLBEfl4+3Ke427ScQ5V3daEgqAu87gHyCWBNUbBoXyYlnL/67acYYvV7T7FgRMKz2LiXses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rc4RVs8j; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rc4RVs8j"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so3161730b3a.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785239614; x=1785844414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBarKm8xrGeCPAZ5wzpK+32+YWWS7s6o927ulWe4mGw=;
        b=rc4RVs8jp7kTY/d74NjUWZxuhRaD8XEujr3b0dnIAH5AHfqckPe5zY1Z49Mw0v5knm
         EsPNqt1vbNnwDi11s6H33JmhfmcOeprChxWOSzOUx0vA5JDrnTgHx1ccs8AEcm7fOgZ6
         ft9aWYO2U0RpgOyuZACEP/99mwSeSvobWY0rLvpIyDCSlJbVHj+WAFPdYyFGnNl65EUb
         UvAcbcZ9FvAqbQOcpelxm6o5OuuZf1TTI5TViLn19IhdM/F+upi8AaDRdP87ixaV9sya
         mCkvQjbgfe3iSQMIGUu7jwi1xKBsvtRaMYEnzjgJLskmF2OVgzgv0pPnuK0U3O6pYxZE
         HMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785239614; x=1785844414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBarKm8xrGeCPAZ5wzpK+32+YWWS7s6o927ulWe4mGw=;
        b=UHORaWs37f3ajwHVngmOVESyjPKCnGt6dl9HIRlwlPLl6zj3E38vCowYKwrQFMVsaI
         IsiM7x61NWlckWwPHORh7WrYZBTtfPJqIuOt7W+ahH26ALlmLHdAPyp61G3tU8+R/vm5
         kBJwXIr/updeqLcRye9NsP7E9NJdkQRmaOzQVQ4k0TcokOzCxl4urmOBF8jLhF9SHRn5
         /v/BRGnUZtduo9DOBCcgHx17cv6i8t9Z3j5OkRDwTlfXN2mfCvw1DmLGXXftp6SJZNB0
         54/AdkkIQL0i1u8SGOJhwEgff73BEQBxRqy/RO850PX1w7NeKCBOkyKHXzIenR9/7bYW
         NVgA==
X-Forwarded-Encrypted: i=1; AHgh+RphsOk+MBOG9hE1b+ro5I2P99+xKQZJ7xdvjQJs1u5JfY9P+uSgt5uuoiLtddJyR3Xx10iaVN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GdK1HY5VsvbMUnZ4F8iqyjlsvGs9vFtiqRlJ24UYAQN+H6ei
	YTYLkVs8rnstnQxmFqS1CMk+CQ1zi/nZUi9yTHNAVaZiHaR9eLA8XioOqSZEnBah
X-Gm-Gg: AR+sD13w4uhqxm1+2HF2fMIx333aFtcMLQRgSthUBn2EG2AfGclkuHs4GEzLxVuhLtO
	mCF8DfmTB3RiK/y+KXpM8SSjmETyNjBNzW4Mug5IQuYw24oUOevBtFsE0/6icVzqPzkgForA7So
	nygDcrvn9ehj0i3n9q1BtoiuOpcVu4FOUM6uLCv6FodBXtXkSSOh0DaB//aqJYpzfkwWjWXYqSE
	vSFoTYgyMR7YS70S279tBooyZ9qiDUN/z5UXD2Pv3iF5vZGjkmziVHNQc6304RrbBj48Oxmi5wi
	uptUXQTYfHFL66cpkiqKtDyoBL1oQGcA802+eCmn3Ip6Til4HVpY32cXlMzBr1lXvd1txoqxyv+
	he7qOBqLUMujCK6yz30vtnUvZ8D4u9JMlTP9jymNUK/nzPn19RP+dlkdc9VBmRISBxqnGxwHQiN
	6YH7BhNIDaTPNvEvO3K1dcpzfuKuuPdEcUQ40=
X-Received: by 2002:a05:6a00:148a:b0:84e:29df:d994 with SMTP id d2e1a72fcca58-84e932ebe3fmr2099463b3a.45.1785239613705;
        Tue, 28 Jul 2026 04:53:33 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5346dc8bsm4371305b3a.61.2026.07.28.04.53.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 04:53:33 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: use the subframe length when parsing A-MSDU TDLS frames
Date: Tue, 28 Jul 2026 19:53:25 +0800
Message-ID: <20260728115325.19128-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_11n_dispatch_amsdu_pkt() splits an A-MSDU with
ieee80211_amsdu_to_8023s() and walks the resulting subframes. For each
subframe it passes the subframe data pointer to
mwifiex_process_tdls_action_frame(), but pairs it with skb->len, the
length of the A-MSDU parent, instead of rx_skb->len:

	rx_skb = __skb_dequeue(&list);
	rx_hdr = (struct rx_packet_hdr *)rx_skb->data;
	if (ISSUPP_TDLS_ENABLED(priv->adapter->fw_cap_info) &&
	    ntohs(rx_hdr->eth803_hdr.h_proto) == ETH_P_TDLS) {
		mwifiex_process_tdls_action_frame(priv, (u8 *)rx_hdr,
						  skb->len);
	}

The parent is not a valid description of that buffer, and may not be
valid memory at all. ieee80211_amsdu_to_8023s() ends with

	if (!reuse_skb)
		dev_kfree_skb(skb);

and it only sets reuse_skb when the parent is linear, is not a
head_frag, and is being consumed as the *last* subframe. So when the
parent does not qualify for reuse it has already been freed, and the
read of skb->len is a use-after-free. When it is reused, skb->len is
the length of the last subframe, applied to every earlier subframe,
which over-states the buffer whenever an earlier subframe is shorter.

The callee cannot absorb a wrong length, because it derives its own
ceiling from the value it is given. Each frame type computes

	ies_len = len - sizeof(struct ethhdr) - TDLS_*_FIX_LEN;

and the element walk is then bounded entirely against that ceiling,

	for (end = pos + ies_len; pos + 1 < end; pos += 2 + pos[1]) {
		u8 ie_len = pos[1];

		if (pos + 2 + ie_len > end)
			break;

so a too-large len moves end past the end of the subframe and the walk
reads and copies beyond it. The A-MSDU layout is chosen by the sender,
which makes the difference between the last subframe and a shorter
earlier one remotely selectable. Reaching this requires TDLS support in
firmware and the TDLS ethertype on the subframe.

The other caller, mwifiex_process_rx_packet(), is correct: it passes a
pointer and a length that describe the same region of the RX buffer.

Pass rx_skb->len, the length of the subframe actually being parsed.

Fixes: 776f742040ca ("mwifiex: fix AMPDU not setup on TDLS link problem")
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: Kimi:K3
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 610ec8302adf..9deb47f22a61 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -44,7 +44,7 @@ static int mwifiex_11n_dispatch_amsdu_pkt(struct mwifiex_private *priv,
 			    ntohs(rx_hdr->eth803_hdr.h_proto) == ETH_P_TDLS) {
 				mwifiex_process_tdls_action_frame(priv,
 								  (u8 *)rx_hdr,
-								  skb->len);
+								  rx_skb->len);
 			}
 
 			if (priv->bss_role == MWIFIEX_BSS_ROLE_UAP)
-- 
2.50.1 (Apple Git-155)

