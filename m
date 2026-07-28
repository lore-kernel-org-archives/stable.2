Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F513F58EB
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243320; cv=none; b=Sd7WOo1R3d+yRo5i4rarZTTKbSRxLgcqE2hAKggrpWdblgU61QgempbRFGlIdnEkGRXoYEst13o/tMVzLhWfeiOsXXUvpXD3pCOYtIpBQboIACmpVci1hsEcmSIXZMtZf9Y4mIV2UHYAmV184WvP6+628VPw/IFHX18Bg0QKwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243320; c=relaxed/simple;
	bh=H1uaarUT/CzOlIYk85IhS6PC1+AMvnoZlaiNlT42aGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgujzpDoRnE2Ej5z5U4zB0DzggTVRtdAOXoqDyBCh3KagpOY5TGmq9IXvZ1ipv3vvBTDT4wFsCPkz3u2JtpyJK7ASc4S4jeYs3SbyKBnTewY6GOnww9anNkGTo42xXkWKukuUvw/ja6v/T9nkm59iR8CU9cph5VR2pwknFGHXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU9dm1OX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU9dm1OX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49548e01d02so19263455e9.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785243316; x=1785848116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6Y+pKPXjSHKlGYu4KK+zrCXrOnM9HLfJHcJjmz+n5A=;
        b=PU9dm1OXqBWxrdbUB51hM9WydXTUkbliCdBifo4rocSTxeb85NlXay36LsJva0ZjLY
         HjY4Q5t5v0dY0P/d9gHXlOXXFPezCZYwyBPWpahz/MGrrszbbMEudSYjb4ELUOT+zDeO
         euSazQJqT1wiSkvv4c/uK/JVkEHf+ShMmGHF0BF8t5o5D22/3D3UrEqa7MxS68yjMZWU
         oW2AAeHGrmaW0YkYfqMQhvEubT/czV+sA8y5hiKD/F7uW+KDR6YBkuFWRc86F321q+xp
         HBdjZGuChVVO0iuj9oQuF4F0+215PhpTj+e6kA1uyLVDRd3mkBuVf0ZLVK5tMRuE/TA5
         niZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243316; x=1785848116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c6Y+pKPXjSHKlGYu4KK+zrCXrOnM9HLfJHcJjmz+n5A=;
        b=p83L6z22e8wNyxieNzPj2HPv6o8dOmoNioL9jWog09SfSh1BN4/4lIkWzITPvn5A78
         /w+wSNnF/7OSLyUGo1ThIBaKi7dk/AmLipjLmuDHM8wXeSG/1N83cW1ekmRc3FJzeKLn
         dkHLuP6yzaD/KCaWPgBNdrtdmEM27C0plI+t47EV6Q5U1jQ7wgomNsAxpvsULOjpkYao
         P1zIH7DoVTGRZXaHAB1U0ybu8PcWef4M7Aqwxg7qU8JAcqre4omcPuc8GuchmOJSNM4W
         X6EGWJDWRbUyX0G7HAvEOFK3lYbUtjD8HDqZvoc9LT9QfZJ0cmDC16ncaQK2pEimaQrz
         /3/g==
X-Forwarded-Encrypted: i=1; AHgh+RrNls5Xk0o+ZZGLfJeTsq5GvzvW7NcpW2bH+tck9pl9Z7dCtSvuPpLAJzesozONvbq1LyYRh0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGOBQcbYO/7x6j/ehXIdhl0K81Fp3Xrwwkcvt8XvcqwIoGhr49
	z2g7inZ6xt1Kb2diKnJrydJocg8FZWGmjZ5lAMz8gg5rQDH9sRyy7gbI+skOnxWBwek=
X-Gm-Gg: AR+sD11gwKipSaVvAr5RdhIuayDr4keP3dw14RTItciztFaxsDNTqqtWtfEcOKqijga
	VLS008eAgRFZGRHHIgITDN4A3Bm/dl0R6Tj6JhZ3fgJqienLXxCGwGEaxfYrLF6hHrUOXjnq8KV
	7GoGkpOSm6yQezpyNWdyibFWP5Xy0K/+ddgbVC+6/ww8nmd/ky0LbZdzCYo9igX7xQwjy8F7SVM
	cYuHdzB32zh/18RODP9sVVgmZV6PJKa9JFLSALzMO0SfNgxLqe3tCxK5R6L+BXHnBhbT85fjr7S
	8tKcvA5/1OKgIchru0U0rpEM1c4rcgBgGlFyTQTtv7NktpPj0x9alXMB3oQXOYamcRnoAxH8aVM
	ICnaD1ry/Wg6N0aC0OOsQWo386yRU71IYdqtPGgggtSet92P02V+I9JPXbUqDlnjyP3o7Yzhbp1
	Fiwjd2DhxlJo3oonoWMGph1dTRnlap9DjNXSUb3Se8npnxTNdcdNE7n+E=
X-Received: by 2002:a05:600c:34c4:b0:495:8a1:7670 with SMTP id 5b1f17b1804b1-496c657ec72mr24247795e9.35.1785243316289;
        Tue, 28 Jul 2026 05:55:16 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c444304esm74096505e9.0.2026.07.28.05.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:55:15 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 3/3] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
Date: Tue, 28 Jul 2026 17:54:56 +0500
Message-ID: <20260728125456.32359-4-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728125456.32359-1-meatuni001@gmail.com>
References: <20260728125456.32359-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw_restruct_wmm_ie() scans in_ie for a WMM IE with:

	while (i < in_len) {
		...
		if (i + 5 < in_len && in_ie[i] == 0xDD && ...) {
			...
			break;
		}
		i += (in_ie[i + 1] + 2); /* to the next IE element */
	}

When the "i + 5 < in_len" match check fails simply because i is
within 5 bytes of the end of the buffer (i.e. no WMM IE was found
near the tail of in_ie), execution falls through to
"i += (in_ie[i + 1] + 2)", which reads in_ie[i + 1]. If i == in_len
- 1 at that point, this is a 1-byte out-of-bounds read of an
attacker-influenced IE buffer built from association/scan data.

Commit a75281626fc8f ("staging: rtl8723bs: fix potential
out-of-bounds read in rtw_restruct_wmm_ie") added the "i + 5 <
in_len" guard to the match condition itself, but did not add an
equivalent guard before the fallthrough advance, so the same class
of OOB read remained reachable through the non-matching path.

Add an explicit bounds check before advancing to the next IE.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 1196ec011455..7bdc5fe6dc8a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1980,6 +1980,9 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 			break;
 		}
 
+		if (i + 1 >= in_len)
+			break;
+
 		i += (in_ie[i + 1] + 2); /*  to the next IE element */
 	}
 
-- 
2.55.0

