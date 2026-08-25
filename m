Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144A3F4827
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657133; cv=none; b=Ji99oCwGDC96yBenPKNxQO03tZbRonlGWZNluIncJv5Q2W5/oCtUH5fog64FVN8b32zDKRBgbO53XjTKtRkheE3v1J5FHla7hs745csrwmOXUUlYQn2ubo4AMlteOcKhqB7czQSeu5wX3flft2E/uMiJm7Ql0OSNSZUGOdzVttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657133; c=relaxed/simple;
	bh=QAx9UwZc966QvaW1bHnvqvofEVuYy1Q2vCksFrWoe/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpfLOFiClmFetOv8nEk9Kh1YHhSV9cJKI46JH6Ez1Nso2pHf/DNBZXzdqTkbKkJVnZTLF/EzcK3JyTYv8JVmB3ya/Zt8m+DgFE1aLP7X6VPBUwuU3r20yWmsi/x3yLsu0QUGUC5hvA4rD+1cOlMKEkeyur69Mj3lmGeRVZjjC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcaAeMr1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcaAeMr1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso2855872a12.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657132; x=1788261932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3XeY/668kVDZ4xfNnAVG7jTvY2qaZfXTD8D/1tCfTw=;
        b=QcaAeMr1+e5SXe0Tkz1PcjxL3K5KcaiKYFz2BlN2b5/ZRqjHU1BCzmhTJJkUA3S2i+
         3nBQniYt0H9uyYKhl0k/6yhDe0aVtUnfvW43OAfqGdvcoVNQtPKVe9qhWXVfgcIlT96q
         fFdFjWg6PGjsCEZaN5WSyZGxygIhXEDodAEohnKGsEJVlSwx32MdiaYwZL8OYKZXfKZI
         jbAayVRtMIuqk+aCvEyCOATLuzqUuPXZMf1inQHg+1kp/jOeon8yUCfwsL1waasg9dwM
         UB1j27ALO5j60EWzcnpWkaU7dsNIClaGSd+WPf5Y4k9GG6Wq1ezR1faL1L7jaUQ4Nu5c
         rj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657132; x=1788261932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3XeY/668kVDZ4xfNnAVG7jTvY2qaZfXTD8D/1tCfTw=;
        b=bfCOIBb5UKUOKequ2GA02QB8BZSCaUCXTfZMvtuBNEvSp44TXsXpWVG5+PC8IGmbNm
         BZxbk4wlcuQAWZ9i3UuxnIsyjDXug+PUV8CA/1PnDOubrQDrrHpGXYECKWJYgQkHwXtL
         zZAgVVRRa+J+S0WCAyXqf4hcCaYbq06tZVgmDyCzupOV59ziGL+1OLSC/6Ne4C97v7TK
         fA41qntvA3EeKOiatzxwnQKEFdxvLk/zxLz/6ejNd2QYxg7cKmuLzzSlwdUM5G/2YK4G
         rnP9b/GFEeZB1ZxPLZseMT/ZuW9dc/my5zkRx/6A5iDZbX6itrHSzvHzSLYOpchLxJe/
         YiMg==
X-Forwarded-Encrypted: i=1; AHgh+RrJVGLLQCRxp6lSHYW3nvCew0oFZIOGnZK01Y9ykSNU32cbTF7Qe6pxAWkt1Uzy2Z2dnKHu6TU=@vger.kernel.org
X-Gm-Message-State: AFuF++noH/xeu5kpdc42hh3lhgJorjCAreD36AJ3Fm5R/TAmYDE8PWAf
	SbMVXFl0hb5d27NL2ngD+whDixjeyu+kRIdNHbYkRCAhoLQFvxck4zlh
X-Gm-Gg: AR+sD10pmVVZbvuxIBjAb1bFdJizM9QXJGZKI0vbMs09ep75wIFZRdc5OE6U7KaA06H
	KH6JO53xT5SkxitXJ3FhcY7wlOGKYJXXeBtY5F2nU62b1SkBKbtLs6FyEfL36ERvpk5jwbDkHzm
	c3RAxIOBBuw8rXTuUoFtp2kxMHV0NU4W3SkXOGtG2qEzUs3kPr3ze99e8A655LJ5zQQx803d0Da
	uhzhbjwlDroRoSvn0B8WBmNDV5xDGCsnE9GCqOSKPGOy5LMQC20YaHvuOdjR53tQ11qJX1ZCwKR
	r5cSNCO3IGsG5sahJHPOrX7OWHznBjUjkQyl0nLReo59YVv+krJG3yY77s2SxZQhIuvCygZx7mm
	RegihS+iSdr7SlVP0IZvIt+NJxIisamhuT3Q9PRP63S4IK9Ky7PTxRORhBo9JIZoaelDj0x2X4+
	PNkAFO5Vkh7ydrhChGNgfUjwi2prFSGFj3M/v1E6o7BFogJgH3r6xc2mHwyeqHTTCA3ej1zRvOB
	Qyd3nc6iMhrZuJj608OiqMEPYwwHFAdwHr/9A==
X-Received: by 2002:a17:90a:c10f:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-396465b298amr12936259a91.15.1787657131399;
        Tue, 25 Aug 2026 04:25:31 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f8e2a730sm38172287eec.0.2026.08.25.04.25.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:25:30 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Avinash Patil <patila@marvell.com>,
	linville@tuxdriver.com,
	Cathy Luo <cluo@marvell.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] wifi: mwifiex: validate action frame fixed fields
Date: Tue, 25 Aug 2026 19:25:23 +0800
Message-ID: <20260825112523.95774-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <anuWyiPQja6_5vly@google.com>
References: <20260723011013.76968-1-enderaoelyther@gmail.com> <20260723202257.688-1-enderaoelyther@gmail.com> <anuWyiPQja6_5vly@google.com>
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
frame equal to sizeof(struct ieee80211_hdr).

For action frames, the parser reads the category byte immediately after
that header and, for a public action frame, reads the following action
code byte without verifying that either field is present. A truncated frame
can therefore make the parser consume up to two bytes past the
firmware-declared frame length. If those bytes look like a TDLS discovery
response, the malformed frame can spuriously update peer signal state.

Require the category and public action-code fields before reading them.
Use sizeof(*ieee_hdr) so the checks and field accesses directly match the
firmware four-address layout being parsed before address4 is removed.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Suggested-by: Brian Norris <briannorris@chromium.org>
Fixes: 72e5aa8d2a6d ("mwifiex: support for parsing TDLS discovery frames")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/66f148d83eb9f0970b9abbccc85d1b61244e54ad.camel@sipsolutions.net/
Link: https://lore.kernel.org/all/20260708195911.84365-8-enderaoelyther@gmail.com/
Link: https://lore.kernel.org/all/20260723011013.76968-1-enderaoelyther@gmail.com/
Link: https://lore.kernel.org/all/20260723202257.688-1-enderaoelyther@gmail.com/
Link: https://lore.kernel.org/all/anuWyiPQja6_5vly@google.com/
Assisted-by: Codex:gpt-5
Assisted-by: Kimi:K3
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Changes in v4:
- Match the actual four-address parser layout with sizeof(*ieee_hdr) + 1
  and sizeof(*ieee_hdr) + 2, as suggested by Brian.
- Use sizeof(*ieee_hdr) consistently for the corresponding field reads.
- Audit the firmware-length containment concern: both callers reject an
  rx_pkt_offset plus rx_pkt_length beyond skb->len before entering this
  helper, so no redundant check is added here.
- Describe the out-of-frame read and possible TDLS signal-state update
  precisely.

Changes in v3:
- Drop the redundant parser-local header check; the caller already
  guarantees the complete four-address header after removing the two-byte
  firmware prefix.

Changes in v2:
- Express the action-field sizes with IEEE80211_MIN_ACTION_SIZE(),
  accounting for the firmware four-address layout.
---
 drivers/net/wireless/marvell/mwifiex/util.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 7d3631d21223..71305efb77ac 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -317,10 +317,16 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 
 	switch (stype) {
 	case IEEE80211_STYPE_ACTION:
-		category = *(payload + sizeof(struct ieee80211_hdr));
+		if (len < sizeof(*ieee_hdr) + 1)
+			return -1;
+
+		category = *(payload + sizeof(*ieee_hdr));
 		switch (category) {
 		case WLAN_CATEGORY_PUBLIC:
-			action_code = *(payload + sizeof(struct ieee80211_hdr)
+			if (len < sizeof(*ieee_hdr) + 2)
+				return -1;
+
+			action_code = *(payload + sizeof(*ieee_hdr)
 					+ 1);
 			if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
 				addr2 = ieee_hdr->addr2;
-- 
2.50.1 (Apple Git-155)
