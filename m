Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739823AA4FA
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540828; cv=none; b=Se+YWm+hM61Ivwgq/+FrFwRLB/yyE6dWitPhVT3WdeRCuJPYA66dbNFMpYR6rHv6P7p9RHb2t3eliScJxNrz2zRKcf1g8oGlbC6q6GnMaBk+LnHwiSFGPEA6J/zPjYuhUKjj3MgpQi05D0g6QaQ06aSekGlRriMMAp0GmNzJgLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540828; c=relaxed/simple;
	bh=/SAxxMsThDq0O9UGIQ5XY3LxNEdloDeHiKs04VUJlxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2XqK8zdgslyl/BKoZw0arhy6qu1LoNpRpI285tRY5R7KNEsPZZtv17rtc7KhINQgNBFX7sY0KKGFN2hFopwXSM1plhMgosWtU6ZWVZ62ue00Ilwev4bQG/xdPI4UU4liVd0AWJ4RKDO1+j17oupkxkm/ZBuWIZH/PDUCScVOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjL0JHQk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjL0JHQk"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso950303a91.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540822; x=1784145622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/bLDuoO7MLFyiV+1ELXwNRC5hxUInQv9JgucXzus9M=;
        b=JjL0JHQkr6ZSgGezlP/uJApZSanXGuYHGZR9v92JeaJvRma9PSPeLwlRgiolyvAqIa
         guGTG2kcSii5X8nFQdyynEkTk0KNwNzs9XcUJHgP0CmKr+tEPKrAIbYbn97jC7E1/Dw9
         Z1T3snpXPJ6Rf65hRnWrAgyAFZw/mz3RblGS5FjDrDutuTlkerehtkxnuPO9PNPEUljb
         mBaNR6Bw7fOmmsIYFw1z9lg4vv1KExsmG18g2GYoT3aZazQoCwZT1Sry9rpCyaNn3ooM
         +Yyb11J0YG5hbQdJy3N4XOqbgtBtlzHsdq/cXiaspv3h5PlNSm229vWVEsxGGzomrzZZ
         LomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540822; x=1784145622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/bLDuoO7MLFyiV+1ELXwNRC5hxUInQv9JgucXzus9M=;
        b=BeeCWxIaAhrb+bdpx8eZrvOBFORzUz5ZU8A1kEWJJ6+oeyqqDWhOg0wYxLNdcHUf79
         UJ36x0UJDu+ugvtaNJB1jACtsIBPLUHqBd/sAms5EKhuWe+jepyFYPcoX5ZU5cxtFfDj
         v2C6/BpP4z2DKiGo689iVwAWFTdMtUc5/gE4LZMj6N/By1ASHbMJZuU8zOHB4PyvEPAK
         QZk0Clxg4vFkQVdCa7cOo/ZbBaX9+wdFysC9Q6cjtt5PEVpqZOpjAPvLTysbGLfM6MEd
         o3xGd+WynqmGIz2IUNZ1EycaqAao/7iU57LmM9SxHY24T+qDtPAbI+7JlSZKFXv9Vucq
         A2rA==
X-Forwarded-Encrypted: i=1; AHgh+RpvYLVxQ3K68AHxaoZsFbmLFFMd+qYN1tbGOg+o+KBl//xhkgrjF9fpn0Uni/PUJxyHPIrxhMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJYFijhCuBQWqQwp1xEUMZy6N/jUg/j8cpVrBirfRqm0iWujP
	6RWddDnCz28tpHD79ZvJGQHxQzLDaNYg7rlyoZg2dvUV1h9fTKUEBwod
X-Gm-Gg: AfdE7cn8vG3xaiQCaguShawsKJzE5VtCsTHUtmPkFJrVDWdtdl9HDZSHkcxjA8LMD1f
	Oz0XShLEoPZi0QrBuTPkmjROEvAO1fx9e9WA+iqwoTbu8NMk1mXHkLiR4+o9CTKja4kXhZ49rdI
	QiEjzHIqexbTRSPJupKwO/6aftF03IZZ+EbLKOCTP8Js9VgCZonG/TZu5TQxal/APWH88sSdM+F
	HgyfKitShaxbp/0e1woPT1wOfy7Z0NAKjwMF78G0LywrSyt3GkFDHJqLZe+YjJRzPq2Z92YYEmq
	8VAeRzeON7JXdQq568BfD4D0ksqV8zF2qbzMW7WH8oSqHMXTgakPy0kfk7Ji6loMOoK4+WUf2hd
	OtGXdbtZ8UrJE1oL8bCDlunRhsTlxmpQpyPiJxO/7oeNgWz0Q4S9MRw6K5rWHPelM4j1TdWk/pA
	peCPtpsTaaLczscMptM3OPhTVebzXmKRM/u8SctU0jPoRmoQsJaIRR
X-Received: by 2002:a05:6a21:6e43:b0:3c0:adec:b3bd with SMTP id adf61e73a8af0-3c0bd19ef91mr4672746637.49.1783540822437;
        Wed, 08 Jul 2026 13:00:22 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.13.00.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 13:00:21 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaewan Kim <jaewan@google.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	John Crispin <john@phrozen.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 7/8] wifi: mwifiex: validate action frame fixed fields
Date: Thu,  9 Jul 2026 03:59:10 +0800
Message-ID: <20260708195911.84365-8-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708195911.84365-1-enderaoelyther@gmail.com>
References: <20260708195911.84365-1-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_process_mgmt_packet() accepts an rx_pkt_length as small as a
4-address struct ieee80211_hdr plus the 2-byte firmware length prefix.
After the prefix is stripped, mwifiex_parse_mgmt_packet() can be called
with len equal to sizeof(struct ieee80211_hdr).

For an action frame the parser then reads the category byte just past
that header, and for a public action frame the action code at the next
byte, without checking that len covers them. A minimal-length action
frame therefore causes a one- or two-byte read past the end of the RX
buffer.

Reject frames shorter than the header, and require the category and
(for public action frames) action-code bytes to be present before
reading them.

Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Fixes: 72e5aa8d2a6d ("mwifiex: support for parsing TDLS discovery frames")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/66f148d83eb9f0970b9abbccc85d1b61244e54ad.camel@sipsolutions.net/
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/util.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 7d3631d212236..e2d76c2d9b05b 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -313,13 +313,22 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 	u8 category, action_code, *addr2;
 	struct ieee80211_hdr *ieee_hdr = (void *)payload;
 
+	if (len < sizeof(*ieee_hdr))
+		return -1;
+
 	stype = (le16_to_cpu(ieee_hdr->frame_control) & IEEE80211_FCTL_STYPE);
 
 	switch (stype) {
 	case IEEE80211_STYPE_ACTION:
+		if (len < sizeof(*ieee_hdr) + 1)
+			return -1;
+
 		category = *(payload + sizeof(struct ieee80211_hdr));
 		switch (category) {
 		case WLAN_CATEGORY_PUBLIC:
+			if (len < sizeof(*ieee_hdr) + 2)
+				return -1;
+
 			action_code = *(payload + sizeof(struct ieee80211_hdr)
 					+ 1);
 			if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
-- 
2.50.1 (Apple Git-155)
