Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB563F926B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197848; cv=none; b=PqQ9qMj21LW2UF8dhNYNYNe90EXjWEWZ0l/A8cF4SGsS+dgA6rZSpoTYet+OyJQYxgd4+grJ/nO7e5ftBGFIHyFS9RvlanT21CYHdueGRKmzpz9qUsPcoBMOjYsoMgWppRTjXXpnsBmhVoo3R+VVxQ10n6llFUX5719U+eq6JCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197848; c=relaxed/simple;
	bh=jHxMxHF6q+AqqNr4U2IcpOC6OPKostUFnRX9P65WGs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlZGn7eYwLmUPFohxHoV0vxkRJtLtKGNhasZr6O+xwu8ynjVO+14qIkHzWX65vN4+Je4N68BXH7zZqp9Exw9w9vAGsxXTgyk1WII1TXud9eIvPcWC8tShkx6GmnhgRp7piEEuPdsRkc5TZ9iu6gh5pRpMJGkiv63VtdwZ6bOYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=ZyY5NCGG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="ZyY5NCGG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so35054575e9.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784197845; x=1784802645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gWJAyUbafyywGmXpBH2PyYDaC3fadnaJ7OKPoatVSfQ=;
        b=ZyY5NCGGvLWYoPqJ1eloYg0DbLWDTV9g6Ds3lILfonOWeM8vrOi1P3hQINF7haqZ4s
         v4fj6LG4SzMEdgke3YPtwQPZhYM8w+HkKzrGh06khYp3QBsWD6Ox6EQI6R8hiH/JKOEe
         qtzLoQ3yq0qmklR3nugGvg1SOkecaxRNzdjrClY+Ui0pbxD02uIO9UG31jua4zc7WGlp
         DrIKIRwnG3j3VUZfn7+T2fq4VAFMNdHZI84KsvWXflIBU3JOP/dhHx7eXCJHV+u6rdIC
         vImB8AQioWFoAL3a6K+U8F3Ruv2m/+0pTn3HG+cpwqYc/vAXK7xNdUwTXReHomgr1HTJ
         x61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784197845; x=1784802645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWJAyUbafyywGmXpBH2PyYDaC3fadnaJ7OKPoatVSfQ=;
        b=eo+bS9l27vEKi0aro5Ek3aQrcNt3m7lQ0gOrBMNwLZX+pdgVySADPi5TR9od7/fcj3
         VauV2FVoEvQJDjlrsYVdtmhaGOMEfg2MHhoSW5ZUEkIzJ+dW7yZRltSdUJLQvowIuKzw
         M41O/UEiic0hfqfxIXI8lUTco5P4wrk98G4rXgUPsL3OTyJ5ZcaH35LeZSGtGXxByHSo
         QRPr9hosKl0pJbd8FCJ4nTtw6TxBsliDQ4HTrSWylLQdabH5VJxRcBhUW/Ll4RdpBYT3
         EwPxL0H9SBuqH/P6rrjZbg1GF8CHstwB4l62IkcIuLrbKw2PwQFmW/45tO0g4UhkgB7g
         wPCA==
X-Forwarded-Encrypted: i=1; AHgh+Rp87SgmaJvJv8waamUdcXnl5NKWL5MLHrO2L4Ygyd/acRVnswVl3GSqxd0sA5yagLzXIKF+LUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZoGSDGfWp06MYbL59vAuVX8UIkiqO2RfO2nyTQVDgfhBZ9j6
	SOs7/vWgkbsmOXzHzFTJm5DeAQEbldc8VrczDmfSenjY4n/B2aRRQCyi++bCLJVbPmFP
X-Gm-Gg: AfdE7clNjpCAoWitEdhD6VU1zqr18RrubJU/2Vs4zod15y1YGhBnHpLoh8UHsr+4LRp
	dIV2CR5Gs3L7GDuZ/kfvbzH79auMXsZjMOSf6pJIhyXl9zxSSslDAFQbPpGCuSWUaL8u5KjvUhV
	6/+d4RGuQEVXj/8JUx2lKW5zpW34jJnUV4lJVmaJ4pHigA6+zyehc7JQdAeCuGY3CUdyv4s8d1u
	i+lQd+eWgPUKPns0EeqTHrzhCu9xI81nRs4qxB0J9SRBRFbc6F2J91oZ/XeKWYmb9QAIIgyiW5I
	BIdOGaVslE29Td7oA4dOtwDM3MttLJJgWUT78of49vA+SY88hu9SOPzKWO7QXCAe/XquzYvgN4y
	o8AH9LhkKg8INP26+GtoZGihTaJjoQ1yMgm4UK6NWq4FoITo5BnFY3WDbdGf5lR9KcuMh353uB3
	nFiqre8RpS90PX4LqvdxpEUN1xtjUTIQFz3OEzETOCjRbz7a17f3nX/i3hqM0ajlNrMJ+byLkdI
	OwjhoKOwTaym3aE5QDRNv4z
X-Received: by 2002:a05:600c:4fd3:b0:495:4593:bcb5 with SMTP id 5b1f17b1804b1-4954593bd26mr4811145e9.34.1784197845285;
        Thu, 16 Jul 2026 03:30:45 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb85dcsm49129325e9.12.2026.07.16.03.30.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 03:30:44 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: briannorris@chromium.org
Cc: francesco@dolcini.it,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: fix NULL dereference when the AP has HT-cap but no HT-oper
Date: Thu, 16 Jul 2026 12:30:42 +0200
Message-ID: <20260716103042.88469-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mwifiex_tdls_add_ht_oper() gates its follow-the-AP-bandwidth path on
bss_desc->bcn_ht_cap being present, but then dereferences a different
pointer, bss_desc->bcn_ht_oper:

	if (ISSUPP_CHANWIDTH40(priv->adapter->hw_dot_11n_dev_cap) &&
	    bss_desc->bcn_ht_cap &&
	    ISALLOWED_CHANWIDTH40(bss_desc->bcn_ht_oper->ht_param))

bcn_ht_cap and bcn_ht_oper are populated independently while parsing the
associated AP's beacon in mwifiex_update_bss_desc_with_ie(): an AP that
advertises an HT Capabilities element but no HT Operation element leaves
bcn_ht_cap non-NULL and bcn_ht_oper NULL. Setting up a TDLS link to a
peer while associated to such an AP then dereferences the NULL
bcn_ht_oper and crashes the kernel. Every other bcn_ht_oper user in the
driver NULL-checks it first.

Guard on the pointer that is actually dereferenced.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 396939f94084 ("mwifiex: add HT operation IE in TDLS setup confirm")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wireless/marvell/mwifiex/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 845f2a22e071..c71ffe8399e4 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -215,7 +215,7 @@ mwifiex_tdls_add_ht_oper(struct mwifiex_private *priv, const u8 *mac,
 
 	/* follow AP's channel bandwidth */
 	if (ISSUPP_CHANWIDTH40(priv->adapter->hw_dot_11n_dev_cap) &&
-	    bss_desc->bcn_ht_cap &&
+	    bss_desc->bcn_ht_oper &&
 	    ISALLOWED_CHANWIDTH40(bss_desc->bcn_ht_oper->ht_param))
 		ht_oper->ht_param = bss_desc->bcn_ht_oper->ht_param;
 
-- 
2.43.0

