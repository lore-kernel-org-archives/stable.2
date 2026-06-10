Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF2428859
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106193; cv=none; b=f+irTYaSJBLptIas9K7aqy07TOqJVrFK4JsufPQRzKztEb2EHcNpJSpZw8oM8BESzwccdBUnQIESxNfXSB5laXLqBFpgiE5oRf1XIW32s3eUOljikGboqeAKg5c5lgAgJwtpaL7ClNLfX2K+Pmz7YwiObM8ufAYBLvd8JiJlQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106193; c=relaxed/simple;
	bh=xqZfYDYPDBPN7aKZCdWGjnvMLnaV5O+1fNS2MXClDPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMuM+NDHr2hFCWmswkeGhGW2Pcq2CkDwHXeel+amGBGNVQx+sPWNa3L9MYkHeAToO7L2tZjB/lmlaUWiVCP/MzsnJlP8Sw8CX/AZzME22Re38rjMpu4f1qZ9+LtnA5gFcf75FlsHlaXvAgsFT7gLdwswxdb0LAI3GDTFPRsqQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqTl75qY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqTl75qY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c855599a77aso3515323a12.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781106191; x=1781710991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XDGbUf4iEhNvwcof5vdLMuCB999+9vu1yeTxgx41Mo=;
        b=NqTl75qYL4rVakJ66OV9nA+0nOuFRfU4qnWPcxbMPT4q05LHakfYVq6OahMxifGPwk
         5BjFJn/G3EHoAEO7RfL23QYrroGqaYHiI5DuBgxgMlIat2fbJyyvZz4twZnZ2gUwXxub
         oGdTKqe8W30GCc0v5+IYFDBSBIe4NtzBOPUXYCLlkmZBHPol/jODAXeHq1/62aSmcH9i
         23wG+A9Xs7r6bxd6aKuAcmQHBWpF3paknj0rvKw/MRSuM+OmHZauQdsk0VVFcBHdDkTt
         tS7y43FGqI+6bayXkH0BS6CitJ4bPfaNl3bW3c19jFhQnU1fkYB47O17ksXjUcywMe2y
         VYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106191; x=1781710991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XDGbUf4iEhNvwcof5vdLMuCB999+9vu1yeTxgx41Mo=;
        b=lSkqS+JjalJbFrCHvRe7okeZ2sXReul36E0u1zYY4vkUiuUETNmN5DmN0VoBgSbxzw
         LXKZZdCtYUoa81G0dIRGO2KN6bLbG6kWLKTsrUiJ54c5sK/ISc56moJJbR5nzeybxZet
         BgKdUpV0oW71pGctWULi028tIiGVASrXvjIUMuSuqp79LtT3OXeYEuEgQgVwUwg3yIYq
         ImHmeMm/CeKnZitgH2AY3H9NRCurmo7sZcXtjyuAMl1Q1EFF7v28vPeRpwQ50aWN4LLN
         zZe2089YwYMPQ3vjwCqbUmomxhcpYIE6rZyPy7hBw8L6stbgv+IXDVL8wRbU1YIGYBf7
         QLPg==
X-Forwarded-Encrypted: i=1; AFNElJ9vdBGnVaArRq7DDW5dHAshfxRECM25BWMDcNMIIkHrugg3Hq/uBwhR44GDt6zh67KKCWmD5tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBTfibnSEMQokJ9j/aFVqmqY64PnWifY9L8CTs6zj/1YnayvNp
	YxLPIwB/OoyDFZp4VLSt6/dLPXmC0CUU5X8IpXH3Ejeyt9g1VJdi9ffz
X-Gm-Gg: Acq92OG0bytmVFDJ5gERnj9axfse8IzvlV5sH4LhuPsJcfvWPR3mnl63IyCnBLUzso3
	31eeCF8JdwKAeRPK276eXwt4JJT3SC+Q0uW+SkFzYiPXjWXTrAD1FSOHRF1xU8bqF8F1hr7QifR
	8sv0Q4maK1cealzphHGPflLrxR8+XZxbCzIeM1HMn+5nPT4lXQCtTJ+Rdm9lnkx/cxP1Q0Hb0xn
	fHWymaA8VaUxflIJXRgPE87nIHjGp81uEXQPJTwUZHA806hnbqdHeS4vFhb2zi1kAbdQEHmHTDU
	SAaAHZhJWm9NvdoNXWnqyx4wH/MgwUGE1A744OKHToYcqbVNQh3pXkFme0k2DcBlEOgv0YrUbFd
	Hn1R82iCJOQtheSUFdme8+JXc5XBeUHIpaAOu4w5Od1PN6gxWUQQTYkogjKiBYwSLCMwPHy1rWc
	Q5Wn4m222BBE2tN4g9YgAz5bpo/kH8ma7yggDRky2dwJ3L+y6ItDz/EO9Bmzu8RfH7aUJ8/413U
	A==
X-Received: by 2002:a05:6a21:7a82:b0:3b4:85db:1bea with SMTP id adf61e73a8af0-3b4ccd1b486mr31060842637.5.1781106190947;
        Wed, 10 Jun 2026 08:43:10 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b26bbsm21482885a12.23.2026.06.10.08.43.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 08:43:10 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ieee80211: validate MLE common info length
Date: Wed, 10 Jun 2026 23:43:03 +0800
Message-ID: <20260610154303.37079-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_mle_size_ok() verifies that the advertised common information
length is large enough for the fixed fields that are present, but it does
not verify that the length also fits in the containing element.

Reconfiguration and Priority Access MLEs also carry a common information
length octet, but currently skip the common-length check. Reconfiguration
additionally fails to include the length octet in the minimum common size.

Validate the common information length for Reconfiguration and Priority
Access MLEs, account for the Reconfiguration length octet, and reject
common lengths that exceed the element body.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 include/linux/ieee80211-eht.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index a97b1d01f3acf..d875045abf6cc 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -878,6 +878,8 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		check_common_len = true;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
+		common += 1;
+		check_common_len = true;
 		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
 			common += ETH_ALEN;
 		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
@@ -893,6 +895,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
 		common = ETH_ALEN + 1;
+		check_common_len = true;
 		break;
 	default:
 		/* we don't know this type */
@@ -906,7 +909,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		return true;
 
 	/* if present, common length is the first octet there */
-	return mle->variable[0] >= common;
+	return mle->variable[0] >= common && mle->variable[0] <= len - fixed;
 }
 
 /**
-- 
2.50.1 (Apple Git-155)

