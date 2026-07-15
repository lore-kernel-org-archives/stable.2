Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BE42BC2D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079251; cv=none; b=jce67PhtnAWfEU2qEdt5a0HkawlnjpMrcjdqTHxlJV/y41km2XkpJknW71QTmPbBUsM0sH/VwrW1i12YAj0/9kyoMjqgtyhMXON/Qv5qGZ4audj9goDtWeBRL6jD5Ar9iy1KiU+Q2VQ5/xV8ug6E+RJa8qnZ1anfMAIiMxm2jmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079251; c=relaxed/simple;
	bh=hrHGYT6KctJE6w+xj/VIer9JY5sM7pRS+SNHlrA4VbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiafQCSvewRbx1c4iOsbK6Pt0Qyp1lvY699ew44pq3MA/k6phvRUadr+JUNIwgHePoDbmIlKpdRdO+63u9QEEcbk54sBDWY0AiOICZxKGZEWoe8nIrQSN7kAaQUXbv8MD/eBPHrIwfgZV9TP6SDdbVyXrzfnOj79mcgrat5tOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYbtbQjm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYbtbQjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8821F000E9;
	Wed, 15 Jul 2026 01:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079250;
	bh=IosEVQgVohH2j0Z2HIqlR4CB4erLoLrn5u/LMqxkrjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HYbtbQjmIUTldaIExQGh1puTBqlr7peH4cRdRAJwQoYLVuhQfYrYaW5kPv2NNrBV2
	 RrP25Esz0Eod4YAPTQx+HlSGMF8sXL1Z8Y9iYK3Nqx56zGT9YrNx8XLghea1QWFaxJ
	 Jd6iPrrlf7MNVxSTEwgze6DLy+Uwoqdu5N1RKhtmlnUdTddmTy5zuVG9u1HP9mMtsC
	 pO5xFv9ktFY3uhVXkCpXgIz3C/1XWFVXCOffa+vA5t6dG7sRLDPdaMAr6gHK3psuPZ
	 QO7cbu6hgvhB3BuBcPbQdMMBJO3k+DWsac3yyXjihp2JqCNaMPzQSiwLhtt8K+LIJm
	 2s1xiK8yspKSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] staging: rtl8723bs: Remove redundant else branches.
Date: Tue, 14 Jul 2026 21:34:04 -0400
Message-ID: <20260715013408.4110029-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071359-gecko-previous-ef42@gregkh>
References: <2026071359-gecko-previous-ef42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>

[ Upstream commit 4610e57a7d2edeef14aa852cd945f9920e1759da ]

This patch fixes the following checkpatch.pl warning:

WARNING: else is not generally useful after a break or return

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Link: https://lore.kernel.org/r/20220329140904.GA3566@ubuntu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 666ce2f9c5270f..8932161637a65e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -94,16 +94,14 @@ bool rtw_is_cckratesonly_included(u8 *rate)
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel)
 {
-	if (channel > 14) {
+	if (channel > 14)
 		return WIRELESS_INVALID;
-	} else { /*  could be pure B, pure G, or B/G */
-		if (rtw_is_cckratesonly_included(rate))
-			return WIRELESS_11B;
-		else if (rtw_is_cckrates_included(rate))
-			return	WIRELESS_11BG;
-		else
-			return WIRELESS_11G;
-	}
+	/* could be pure B, pure G, or B/G */
+	if (rtw_is_cckratesonly_included(rate))
+		return WIRELESS_11B;
+	if (rtw_is_cckrates_included(rate))
+		return WIRELESS_11BG;
+	return WIRELESS_11G;
 }
 
 u8 *rtw_set_fixed_ie(unsigned char *pbuf, unsigned int len, unsigned char *source,
@@ -155,10 +153,9 @@ u8 *rtw_get_ie(u8 *pbuf, signed int index, signed int *len, signed int limit)
 		if (*p == index) {
 			*len = tmp;
 			return p;
-		} else {
-			p += (tmp + 2);
-			i += (tmp + 2);
 		}
+		p += (tmp + 2);
+		i += (tmp + 2);
 	}
 	return NULL;
 }
@@ -702,9 +699,8 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 			cnt += in_ie[cnt+1]+2;
 
 			break;
-		} else {
-			cnt += in_ie[cnt+1]+2; /* goto next */
 		}
+		cnt += in_ie[cnt+1]+2; /* goto next */
 	}
 
 	return wpsie_ptr;
@@ -753,9 +749,8 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 				*len_attr = attr_len;
 
 			break;
-		} else {
-			attr_ptr += attr_len; /* goto next */
 		}
+		attr_ptr += attr_len; /* goto next */
 	}
 
 	return target_attr_ptr;
-- 
2.53.0

