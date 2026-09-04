Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC73B993B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511786; cv=none; b=cZcBbrqAjIANBlHwTn3BX/q6byF/gi1xsf4qxDbFFEBjA0y1NMesQ5fAcBga1E2+mMk4iHTECzgZOaE/09uYXQ5V9P/gQzVqCrjeOMyEPp/IA5NCh6x3K/2aYYGRp+UKOfDV9c5eSsGQcj9D/wHHBkuAiOh4WqmKjLxQDhWY6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511786; c=relaxed/simple;
	bh=Z8mPENNWcv1eq8P/28+Mi9OOdfEllu2+UZehW5EHxFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKpFIGp5kCR0vsM0aMoTtN4G7wozfd6wno09dZUWDH7kTID4q5RqaVH73kjNfhUB+QIEMCc/ncPmjWn20oKywIUA+LxV0JfAlDJJb+NMKHGpxQwxFHKMOKbDRb6+o43e1bg/eg3nqlDL1YgXGZ0C8ORPfersWa4sNdKjWRfRx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1lOqSst; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1lOqSst"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso13483065e9.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511782; x=1789116582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jfu2EemlakeU3G/i0hecUm1qkaXQeHbKJFBtMpImgJw=;
        b=n1lOqSstD3Dli/+SNwFHxQkCrAzROyLT0LInxHbSTlaMF0/lRvLfiJpIxgX+7hbYxa
         /FlJ3YmqBSEo+VxK84raVUghIeROORfFY5MZZT3NHfd1ZaJteHxBQPTHIanHnI8tviaQ
         QNLki2uYxRCTN/eCwzZBxG+e+JXQW+0GHuKcRbcuGlAhrlpGkIIKPdMlOVQD/8XS8kXZ
         sfD+675CKJwXrkdNElNqXfssQ2KCGkaxKfW45HBZPYV722n+h4hx63IV+d8aWGqjA+bO
         zmMfBOxmN64pMUVW7UtGcsj5yjA0sxlkStC9l0jhcUQphIm6JjWNmkF+DrBD51a7DY5t
         AwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511782; x=1789116582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jfu2EemlakeU3G/i0hecUm1qkaXQeHbKJFBtMpImgJw=;
        b=YveRy5wrZ6L/7ZHUlfaOMEbfHSqcHAGQhxPcqgTQgzmuAanV3iX6Qh17BOLYULKsW+
         E7aV1IGQD0yJjxmiveMTcTlkrnfuz7mz/+vNLsW77HaRsfBbcHRUNl6nafnG6rumVmA5
         BwiZhB9WT+7yG4gZ2+Jznqr5LLf3VOdoldrzBk9sgGQS36l5HPmE5rGoprmW2sIqVwQw
         JpWel6+gjG9Hvp/NMTrs8tnLo4LTsEdKbdeEOGEDz8BF0tfq0PG+U6H/p5TIAVyUCrQe
         ZW2EvBUr5lkUX10QkUM34cOwyJC+nNN00+wND/KZlCpl10EdraNoR8tkxlLbp2/WFmld
         SHoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHY1nRQOWCDRaBSKDqlcblrwb4rdnib83qlat/Ob69yQ8yTuwHzCHv/Kj72qhUREMdYgbw1sM=@vger.kernel.org
X-Gm-Message-State: AFuF++kjfZeWjdOJGW2FjwkSQ1Wg4tV+6dgL36khXHYlhDJA4DC1p9ZY
	hs86hkANgsaTLmHXY+kAtfSBlMhdEIRvQVFIn2vhSzX3yq4RZf67iTxSzRvn
X-Gm-Gg: AYBFou0jEJ6RiykkQNV8bTjfjn4ZXdKZVr0wr9j/aT0hT21mTGx9wNkkt6Jz9DgzGVH
	8x4ihA9XBz7e5G/tXTRpZOkUTeETYiqxeP5rKuzTR/zMy288ctzsK8E8gC+R4nI9EmiGNQlvwS8
	RGQD4/o/fXkYCkxxewLN7WAdjNUNc1eD8LKvA9t8Ed2z6uXjiP873Wa88FRwJQuwwi0fdgw8LYC
	IdGw/RGFf/W0VN0vmrCJqzgHNo5xYhdsWRu0ml+Zj6AgR3YuMRZg1f/gmLWI81PAS3AVq8j+NFI
	o+22V6B1q3Hj8sk+q7eUg7AgSwtU8gpf4/Yo65TtoeDpboeTT5y4sQshoAAqJfpHA+zF5gPl3mg
	1EUvRrYgJl+fw9CV8iHE5JCfm0GdCg+LG+YLfceklru4GZlzjlgu7gIRm/lrszGjZPboCOi+r/9
	GWOL4W8hFtrX8cZCV849Zgey6t6mBmHQ==
X-Received: by 2002:a05:600c:8b8c:b0:49c:f13e:e52 with SMTP id 5b1f17b1804b1-49cf893b58bmr31193105e9.15.1788511782473;
        Fri, 04 Sep 2026 01:49:42 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5941cb4sm83963155e9.4.2026.09.04.01.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:49:41 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: rtlwifi: fix OOB reads in IE parsing functions
Date: Fri,  4 Sep 2026 08:49:40 +0000
Message-ID: <20260904084940.3885379-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

rtl_find_ie() and rtl_find_221_ie() iterate over information elements
in beacon frames using a loop condition of `while (pos < end)`.  When
only one byte remains (pos == end - 1), the loop body accesses pos[1]
which reads one byte beyond the validated buffer boundary.

In rtl_find_ie(), pos[1] is read in the bounds check expression
`pos + 2 + pos[1] > end` before the result of that check can prevent
the access.

In rtl_find_221_ie(), the situation is worse: when the last byte
happens to be 0xDD (221, vendor-specific IE), the code accesses
pos[1] for the length, pos[2] for the data pointer, and passes both to
rtl_chk_vendor_ouisub() which performs memcmp() on the out-of-bounds
data.  The bounds check `pos + 2 + pos[1] > end` only appears after the
vendor IE has already been fully processed.

Fix both functions by tightening the loop condition to
`while (pos + 2 <= end)`, which ensures that at least the IE id (pos[0])
and length (pos[1]) bytes are within bounds before any access.
Additionally, in rtl_find_221_ie(), move the full IE bounds check before
the vendor-specific processing to prevent accessing IE data that extends
past the buffer.

Fixes: acd48572c396 ("rtlwifi: Change base routines for addition of rtl8192se and rtl8192de")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index 9e98c01bb90e6..9671b9247b571 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -2373,7 +2373,7 @@ u8 *rtl_find_ie(u8 *data, unsigned int len, u8 ie)
 
 	pos = (u8 *)mgmt->u.beacon.variable;
 	end = data + len;
-	while (pos < end) {
+	while (pos + 2 <= end) {
 		if (pos + 2 + pos[1] > end)
 			return NULL;
 
@@ -2597,17 +2597,17 @@ static bool rtl_find_221_ie(struct ieee80211_hw *hw, u8 *data,
 
 	pos = (u8 *)mgmt->u.beacon.variable;
 	end = data + len;
-	while (pos < end) {
-		if (pos[0] == 221) {
+	while (pos + 2 <= end) {
+		if (pos + 2 + pos[1] > end)
+			return false;
+
+		if (pos[0] == 221 && pos[1] >= 3) {
 			vendor_ie.length = pos[1];
 			vendor_ie.octet = &pos[2];
 			if (rtl_chk_vendor_ouisub(hw, vendor_ie))
 				return true;
 		}
 
-		if (pos + 2 + pos[1] > end)
-			return false;
-
 		pos += 2 + pos[1];
 	}
 	return false;
-- 
2.47.3

