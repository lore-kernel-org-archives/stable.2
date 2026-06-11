Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA233F1AB6
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199315; cv=none; b=njccDxhcVbwbcEXMU1J8+sJhFhfK5c5E7ezMe4bd8GffSX6N1JfRgFEPW1obP0i3yYE8cXdFh3ccjiupH4LG/5FAxao/YqUyIMzC29O+FBSNYffwx/34FpBV31e1fYx4upf2agSyUbtoT0vmpc7yiyPnh283hi4ZlEk+WyaNCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199315; c=relaxed/simple;
	bh=FuQd8meff7oP6JE01DWJHh6bS3K5BZBiEhXwQSMVXEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZNIucF7L7VhpR9/TvMa+3/H0ZIkJmFgieJ714GlY/bQ0VzGYnpeH/CbtNSzGh6W6XP5jaLEqKiSsfVbfD6eC6eYPtFmLVzN3i0dyZDoZrSjIugEFE38GuHPPZ76a0mAXpb3784SA2rMjECm7/hMP9zEeoiAUv5Ne+0aYISg5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRRf6KQF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRRf6KQF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36bdda53d99so110902a91.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781199314; x=1781804114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOh4h1Jbp5Tyf36zO2G+zbdh9lsb9GzpQeGsDyR6Flo=;
        b=FRRf6KQF4azGjv6YThEWK0B7Fv1icigJzi6/4MaDWj0bv7CizKCkan3LR9Dt7w0IGZ
         9Kh5B3caJVj8y3EBgaBjU2KXelvrkCNyW75nwX3KlJo8sm55zV/2jB4bFxla3p5yIRI3
         /+zKqOGpgYpgaI3xbG07RQzPfk4i7RwKl+Rhxx9UJU6O8BiMKck0NFmZiIUMiws/IuEM
         IqUzeeFGlQE03Gle8bNNOE+yZrRd6s6uwoEscGCAYl8jcfEhljIpyrFoDDv7CxyAVQnt
         WAMmpcQRrSRI4h72ECiarOTOj65MwvmeyLSAuhPjGH2QfPzha7EHMrUevrR+tMgBppMe
         zQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781199314; x=1781804114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOh4h1Jbp5Tyf36zO2G+zbdh9lsb9GzpQeGsDyR6Flo=;
        b=j8bXm6FNw+1zIuf0nojHtR4T4UOtugXgnscsqJqwsYrM8P51abNe5xdwKdfbCkQ5mB
         XmKFHN3xD79hi1cfyh6gdGlNwfmJGM3HB5Ft8Z31mhwHrcHAgmVO6h5tp5AYm/Zp374Z
         vRvf439VDusUr4IhuBGuyy342293JB3FVNY8Ahjzuy7VaYC39j5o2gBcOKsoXOZ7oyWU
         pRBKcYMcOp66yUjj3sxCNeaNc1Uc3+kv4kKBARCuBF/Wor21tjuEZSRxaM+cM0OTd44g
         VRsXPEzJw3Y9yzPEieMsDM9q/FTYyP8llkM0Qle6imjoah6Em0A09Y5y+n0hEQnPKWra
         vgpA==
X-Forwarded-Encrypted: i=1; AFNElJ/RRBjwkFHkWDYYVZfToLwHXtP5OEWyNW2e75ve3MA5J3wLtbO4hAGCciNOOZKx2NHssVux8XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwewDTTD7L/6FdPYF/khJxiQsjv+VVeviLmEycyUBtJxI5T49co
	YUtgv05XdruNpAJfozNwNuNg4S7oK++U/4dziHocHk9fY8ubgIfLTYdR
X-Gm-Gg: Acq92OG7a2N1awM6yptX3CP8wiy4lBx0Ykk1Y3cPHFe3Cl3hFUpCZ19pyKZ3qrYDzy7
	Nhl1TzEPhNWryFtKksHSAHCnTJV611nJ01L6v6DpwxJacBqWITgh9HQma7tM2MAt9LW2XuPQyhu
	W9lO7fajt8o1KY1tc/igz3wFGVtM/E65HiL/Bxdy6RcRGenBTwlqOsZ2t7xyYiz+NBSZqJvil46
	bFAVZomIf3gN0994svZgfkwc2C32PIV2Lvj2BNBduDeRyHNO7n4rg4onKg370m7wFUi28JXssgl
	XDjhpx7/slsDfH9L8DpfW3Pit2fKIS9AxF6H7Je2LpB4PpggaauLzD30JLTRpPAi7ErjAhzjvza
	1kSG3hWDMPgzXeZbGMSD5ofD9BrFaJFqxjYREEeMjtCA0QlUJ0ZPWI17lU06xLEtGplaMXmMS8m
	34W2lPu7UmKicMSRTUFJdmLnTDHjeoio7b4SUUb8vLzbLfCzPTChBnKnd6WuK/v64=
X-Received: by 2002:a17:90b:394d:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-3778edd65b1mr4601128a91.0.1781199313748;
        Thu, 11 Jun 2026 10:35:13 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843380c9307sm2416294b3a.29.2026.06.11.10.35.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 10:35:13 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] wifi: ieee80211: validate MLE common info length
Date: Fri, 12 Jun 2026 01:35:07 +0800
Message-ID: <20260611173506.36838-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_mle_common_size() uses the first common-info octet as the
common information length for all known MLE types. However,
ieee80211_mle_size_ok() only validates that octet for Basic, Probe
Request, and TDLS MLEs.

Reconfiguration MLEs also skipped the length octet when calculating the
minimum common size, and Priority Access MLEs skipped validation of the
advertised common information length.

Account for the Reconfiguration common-info length octet and validate
the advertised common information length for all known MLE types. Keep
unknown-type handling unchanged.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 include/linux/ieee80211-eht.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index a97b1d01f3acf..a557df0088c08 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -844,7 +844,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	const struct ieee80211_multi_link_elem *mle = (const void *)data;
 	u8 fixed = sizeof(*mle);
 	u8 common = 0;
-	bool check_common_len = false;
+	u8 common_len;
 	u16 control;
 
 	if (!data || len < fixed)
@@ -855,7 +855,6 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	switch (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE)) {
 	case IEEE80211_ML_CONTROL_TYPE_BASIC:
 		common += sizeof(struct ieee80211_mle_basic_common_info);
-		check_common_len = true;
 		if (control & IEEE80211_MLC_BASIC_PRES_LINK_ID)
 			common += 1;
 		if (control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT)
@@ -875,9 +874,9 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		common += sizeof(struct ieee80211_mle_preq_common_info);
 		if (control & IEEE80211_MLC_PREQ_PRES_MLD_ID)
 			common += 1;
-		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
+		common += 1;
 		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
 			common += ETH_ALEN;
 		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
@@ -889,7 +888,6 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
 		common += sizeof(struct ieee80211_mle_tdls_common_info);
-		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		common = ETH_ALEN + 1;
@@ -902,11 +900,10 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	if (len < fixed + common)
 		return false;
 
-	if (!check_common_len)
-		return true;
-
 	/* if present, common length is the first octet there */
-	return mle->variable[0] >= common;
+	common_len = mle->variable[0];
+
+	return common_len >= common && common_len <= len - fixed;
 }
 
 /**
-- 
2.50.1 (Apple Git-155)

