Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8A3246EF
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400917; cv=none; b=bB7ufuMDOY8ISn+cmvITlh9U5AH1hYBPjTPmlyUV1GyVlKC+ExeKnwX6K7p5gWrhsmRN7w6pD0mHSxkiyN4v3SNBJRy8kdicOi0JGTF+Dn7C0OqSLnDEGyRH8ZYSgTmcHrXniPbru1YMIZr8EurhA9hTV6UHsCOUmdYkKwtxDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400917; c=relaxed/simple;
	bh=MMU5B/GSFrKeMMnz7n6SPGe1UFSUE/LdaDBaAFkUHxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LimPLQf/fIuygi2EHXLjBGYUPTmSsbPbU+HrN/aXG2Qb4MwHdl1nLEthdr34cX7C4D1/fdKtqTtQ9111lzdty6KbnabSAG2KtVhG9V7azMxHLF0fiUjlkuvEUeb+L9uWn96ABb8teml7VR+iELkmid5oVoL75q65bkvutvYoXEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk2zVezU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk2zVezU"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1600d040e4so409217366b.1
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784400914; x=1785005714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Vek9VNoLIBJqK+DxbiXTlmLiZQWFsJV5wa/eMhmj0g=;
        b=Mk2zVezUEiJqhe+W4LL/Zif1zT61ZPnAU33qFqrY4pUqJbsINE1tLnWIzToTaMuCx9
         jJ8Wl+CDwtJmNGmfoX1RaWPi7PSpdSyj63isF32I6qqQZSM9Q2djiwkzYqofiyujSPLB
         eP+EnFFUSIkgBcHW5rVceNw77qNDI+unA01fidFbO7imBpA64epttHerJjh6U5WuPjBd
         1zHu+fEPOwa01qkxJrwELY5cJ4wypvfG8ySUdTcImamQqhgJQuvFtWDHNXNdjWgw9ZNT
         SrNEdVLRxwkV9RDAVGa1pLSsCiFCLj0wwtHmh/zbU2c2Bw0QaKDY+umJ615G+Y+bpB+0
         kFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784400914; x=1785005714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Vek9VNoLIBJqK+DxbiXTlmLiZQWFsJV5wa/eMhmj0g=;
        b=JHZMW76kJBOHiFhMjpPgRrReN3YEOCJBfFEUNzcW1uCdC1ROCUKsxTFX4ORl0DDxah
         +WzbkTOwOwpOmrxijF6O5FwDKqFYmLjbBi0oYJjk3irMs4fzDxwjSboQS1aqGqBT3IEB
         u/VyESypYqCl+Fha4HIv0b3csZkf5K7P7/Il90zIlUMr9P9lht47tOIMpzu21CWiXbVh
         vqGFqARPKPVKScoH5uwtq63SFsLNv9L12WTDb582Ku/bkOGvD/frw7B/YCb6YMCyrxSH
         VtKCx1hZdbOQkxaan6gU2nZYHjqsqGdBdm53NsYCaBRsdMZKCPkgfSyQjT730nTU4qcY
         Gvmg==
X-Forwarded-Encrypted: i=1; AHgh+RrjhWh3J5m9kTXpYeNgyqsWSj+/pF6k0PNn/uJPnJzdcIWRdMAdA3Kqgt4S4lsOpQ9t6Oo/7AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+Kc6SjFk6oxAZktPwVWo6uruwdAcQr93Vfir8npGZPfmXZPX
	61Z6RxkT7Qxo9EuzXhXr36Elsei8JFuRFeUI/h3YatT3/himA2n/V76B
X-Gm-Gg: AfdE7cn8Xxv9ZzVN313cG5lLh3Rogr5mIXC/YYnoEw2d7q0mOUBOS5he4mi8CSbWC3g
	YQ105zN/GPb2NTM3Z7HlC2OfroewALYxSb0kv32KZqlEnu+jCWL+A8bfqxqjNMg7EYA1l9sYe4J
	sJeIzol5EluyqSBwmsDpbWzdl9X/Z3QXclUzAeSQOUNntHZS0mcJlixV7uOkP0VvY49X/jDRoCv
	zR9gUyFdaL+w52gF5NqyCnnUuE5wrZpQnMsxmHr/F8WjnngTXtaEF/hxchXsQvXwda/le/htyVj
	92r74X0gfyC7vesB9uGbkdClaBwQSnkD+WcKBkmF9DU1+WU403o7LdGzwmbCL5YrZE60lxvI9Bo
	9YU/oatCYVdGgG8Qy7zYm5YD9ZhLXsBPdmq0bYW5987u2lmSZth3ygaqR6Ic8I7bfvG0isDDfEq
	BpkfVXM2mqssRq8vk//i/bGNrQz/13muxlIbwSNKFlbrkfNfSZLe/ezp0=
X-Received: by 2002:a17:907:1903:b0:c15:a7b9:2ae1 with SMTP id a640c23a62f3a-c16b40031acmr390800166b.6.1784400913719;
        Sat, 18 Jul 2026 11:55:13 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5f837sm249151866b.32.2026.07.18.11.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:55:13 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 1/5] staging: rtl8723bs: fix OOB read in rtw_get_wps_ie()
Date: Sat, 18 Jul 2026 23:54:41 +0500
Message-ID: <20260718185445.63070-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718185445.63070-1-meatuni001@gmail.com>
References: <20260718185445.63070-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw_get_wps_ie() walks a series of information elements taken
directly from received/associated wireless management frames
(beacons, probe responses, scan results). The loop condition only
checks "cnt < in_len" before reading in_ie[cnt + 1] (the IE length
byte) and before a 4-byte memcmp() at &in_ie[cnt + 2], with no check
that those offsets are actually within in_len.

A malicious or malformed IE blob (e.g. a truncated vendor-specific
IE placed near the end of the buffer) can therefore make this
function read past the end of in_ie by up to several bytes, both in
the loop condition path and via memcpy(wps_ie, &in_ie[cnt],
in_ie[cnt + 1] + 2) when a spurious match occurs.

The sibling helpers rtw_get_sec_ie() and rtw_get_wapi_ie() in this
same file already perform the equivalent "cnt + 2 > in_len" /
"cnt + 2 + in_ie[cnt + 1] > in_len" checks, added to those two
functions by commit 1463ca3ec660 ("staging: rtl8723bs: fix OOB reads
in rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()").
rtw_get_wps_ie() was simply never brought in line with them. Add the
same checks here, plus a length check before the 4-byte OUI memcmp.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 54f805a6b5ce..2fb5863dbeef 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -668,9 +668,15 @@ u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 	cnt = 0;
 
 	while (cnt < in_len) {
+		if (cnt + 2 > in_len)
+			break;
+		if (cnt + 2 + in_ie[cnt + 1] > in_len)
+			break;
+
 		eid = in_ie[cnt];
 
-		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
+		if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (in_ie[cnt + 1] >= 4) &&
+		    (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			wpsie_ptr = &in_ie[cnt];
 
 			if (wps_ie)
-- 
2.55.0

