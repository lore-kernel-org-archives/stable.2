Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A33988F8
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784838190; cv=none; b=g5vGDZeIrORMqN8td00Gg0t+P6BQYofUjfm+EsnvjkkjbabM/oyJSMynqoqwY4TwKTVzKm+tFhPJqF2AsmzcWT0fa7LD+42K1ALd+dCi5V+MwWqu5xvhHJ6XPJMebKM9NS/Zs7Xi1SB5QxawEGdTy43Gv4n4h2USGTvvDFIjzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784838190; c=relaxed/simple;
	bh=a9sQmebtMT/rKN/M4el8HrGMyfFyyhWYzm3WPDgjCkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nc+xtqhUwQ1idkvwV5hhriFV2kvm2ekxdjQoPgWjFWSSUuVn7Lv88vZ94MOc3xkXeyVm2wUYSm4+OB1Eo6+q3KeBDabWJccHYuJtXFhLKnL+OWNq1EPX3s22uPYL/yZTBiAk0z4tRVHzL2pF/U2IUGmMbjcqaAx6BByTBtWrepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCVxdkCQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCVxdkCQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1165931a91.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784838188; x=1785442988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+R4wtSNZnUCU9FPYzMZaddP+ee/LgfHZwSutE9tQVFg=;
        b=bCVxdkCQKoqbJ5QIUmtqFJ8e0qNsJnh9weT46M63cDsVpUudUH745j5KVYnMCbu6Lw
         Ugtd61YSZsQUWOJMvyFAmgDask4ubX0AFtb5gEBfPxpfp8j1zi8/8T8qwepFy0/4Zytf
         gmlAAY4IK7dg9vcdzTw5kRY3H9Xa/wbEd8EP95V3XsLTbLy+kcuK/Q2rp5yhUGhDfC6Z
         Ez6UzGNjMAHtrrxdroTVyjN8oW/UhMuRCSHzFWbxQL+RJPi3kDjkC6H9PbyvxN0XdY7S
         zLREJC8lkQJQf72g1Ayyp1Qbo4jPnaSVqjn/pwaZe23Y5kWQcZ8ZvVh3qSgP3P2dPfwn
         +Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838188; x=1785442988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+R4wtSNZnUCU9FPYzMZaddP+ee/LgfHZwSutE9tQVFg=;
        b=LGsy0c3dej39P5JE3DIA6SzjWAW2Oq5Qg1zdZMcNhDR19XPI2/GF66xP/vL6fxiMnJ
         Gk6c/5LuZxyy6705hkl9kSy+5kv4vWLTyc0sEcpbkLKPFGnwygB6xAV8UnlJ9YCmw5hy
         rLg1RIE7RYYsP3K3JeEQPxblniQNpGGqBfuOzImiFYc2LEjomxkQbGy3mQiYYi4nnw+g
         yqOEydpZktiPz5ofbzj8wCLb1lfZENLCdW2H28odBf5gOntriwAn8psJO3/98dk0Ro7v
         vaG/ZBLSGs6DpJcqrKIreh2lb/LrArAJLM/8Smdv7hbtgtsD7/U5gboW1CMTqT8qM9rv
         eyIw==
X-Forwarded-Encrypted: i=1; AHgh+RqjBHOvM+WUKsgwJJyEhelx8DbMiG1/5xJW0yBpep5l39NXn1nBLagKKTXO0IFfQs4XxuWdF6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzgXlmHFy8uDeLdzJjUIziQL7KbW4J11buyw+6Bp51H1sY+nJ
	BoFXFBSutMDMdK87uUQtqrmAPRB8KgJExa3h8P/CQSlKvIEKhrIFJVVb
X-Gm-Gg: AR+sD13jPw5YV/ntOMTGi35RrksBDQ9Moop9gzmMImigxmreSkIPInCizf5widgZGLE
	XnsojNo7tW5TN2Mt65Jl6IXlpp3bUXrgFHY3l0Ss44502+94F1a3a9qyZwVU1gG3usg2iR6RAoa
	OMh3jFSVw4Gt47bjMdhLTYqwvZlva+68X6vWgaXk7wfEWRg4FmLnViBTCyM3KYsQ9ouidGchu8b
	noJgoW9WQV+6rip89ISwhuaISMa0CK0ykVUki6qZMEBpCIyhyjwMuAi9qeCZR+tS9mQGf+3M7lb
	euOSm1MCeeW5YFoIljY3h9sVIRgtiPzHzoT4AYaZAgaUk+bEiZpZaEKm4hyeNoOSfhwhd7D4rBZ
	uiGurMLLowbg8YMZjNQhhTG6c/UwxSsrYtZrG9lkNAtL6xPjoob0KOpPnhhTJTvvdZjWTG7UM04
	f256nDPx2Eiw+5sM7rjiWnPKngq6UNWw7BbctX1XPJ0periy+osw==
X-Received: by 2002:a17:90a:c88d:b0:37f:9ce1:cdb2 with SMTP id 98e67ed59e1d1-38ec65ad624mr5066440a91.32.1784838188033;
        Thu, 23 Jul 2026 13:23:08 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([120.234.91.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03adb16esm417883a91.1.2026.07.23.13.23.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jul 2026 13:23:07 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	briannorris@chromium.org,
	francesco@dolcini.it,
	linville@tuxdriver.com,
	patila@marvell.com,
	cluo@marvell.com,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] wifi: mwifiex: validate action frame fixed fields
Date: Fri, 24 Jul 2026 04:22:57 +0800
Message-ID: <20260723202257.688-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260723011013.76968-1-enderaoelyther@gmail.com>
References: <20260723011013.76968-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_process_mgmt_packet() accepts an rx_pkt_length as small as a
four-address struct ieee80211_hdr plus the two-byte firmware length prefix.
After stripping the prefix, mwifiex_parse_mgmt_packet() can receive a
buffer equal to sizeof(struct ieee80211_hdr).

For action frames, the parser reads the category byte immediately after
that header and, for a public action frame, reads the following action
code byte without verifying that either field is present. A minimal frame
therefore reads one or two bytes beyond the RX buffer.

Require the category and public action-code fields before reading them.
mwifiex parses the firmware four-address layout before removing addr4,
so add ETH_ALEN to the standard IEEE80211_MIN_ACTION_SIZE() offsets.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Fixes: 72e5aa8d2a6d ("mwifiex: support for parsing TDLS discovery frames")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/66f148d83eb9f0970b9abbccc85d1b61244e54ad.camel@sipsolutions.net/
Link: https://lore.kernel.org/all/20260708195911.84365-8-enderaoelyther@gmail.com/
Link: https://lore.kernel.org/all/20260723011013.76968-1-enderaoelyther@gmail.com/
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Changes in v3:
- Drop the redundant parser-local header check; the caller already
  guarantees the complete four-address header after removing the two-byte
  firmware prefix.

Changes in v2:
- Express the action-field sizes with IEEE80211_MIN_ACTION_SIZE(),
  accounting for the firmware four-address layout.
---
 drivers/net/wireless/marvell/mwifiex/util.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 7d3631d21223..e54a86ecaa33 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -317,9 +317,15 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 
 	switch (stype) {
 	case IEEE80211_STYPE_ACTION:
+		if (len < IEEE80211_MIN_ACTION_SIZE(category) + ETH_ALEN)
+			return -1;
+
 		category = *(payload + sizeof(struct ieee80211_hdr));
 		switch (category) {
 		case WLAN_CATEGORY_PUBLIC:
+			if (len < IEEE80211_MIN_ACTION_SIZE(action_code) + ETH_ALEN)
+				return -1;
+
 			action_code = *(payload + sizeof(struct ieee80211_hdr)
 					+ 1);
 			if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
-- 
2.50.1 (Apple Git-155)

