Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD142A7A4
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243315; cv=none; b=mFJuOLD4OtyXk1HuKw1ayv2wQiAUAdCdFtqXmQqV5v34vMLDYz1RSK/UskH+nEyUWPduo1QFQM7ssSA8GdxcdyKnpIAP6QhGm5oXhngh8y+0FO0+b3TySlFy2TwTDPViWYHENoWCnCK9sIYzTxmSsnr5bxPtQFN6KyrmMN3jxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243315; c=relaxed/simple;
	bh=bCImW5FveOgLSFMnd3wYiHnrEIorbTiPRBOU3dDrN38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td0FgyoFtA7jH9LvjaEMHvCFVjLkMi/8uaPG9i6lGiqTco514tWmCaiVVuZr9uYbZIv72IOyLEgTHkhuFxtF4Z2E8aZnbFsjCCEAJL8g8+x3EZtMTS1O0sujSmbPASBNtesn/rphug6OfEoFv4XmHbm6phc+tV9KddMaZbp3E48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf9Chai5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf9Chai5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so22847465e9.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785243312; x=1785848112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3K1t70zaHBwvr/zd5QGdCAYVOIE1pLnv+eQf2gzB8Y8=;
        b=Qf9Chai5CLSPFKHqzb054ngzSh2uKymBymacvVJHABedOsmISR+GNz3q2zQRGnzcLq
         Y6GD2ymN3zj3xqd9La8T+g/gS+T5I09/7Y8L5N5uTJqDVuJQT4I8iPFaMCq3HyDg6B/A
         Sg/fdYmOFyKDYhuwPMxPhFgFFpmt5asbDFovUIlVWpkTVOTVMrL8lqPjrQyyTzaVolH7
         nSsERi7vHh3/MCjxO1GFqtg6TQRqE+Hsh38HcaW8yn7/4nM0KLq9ijuIKGqa/+rAv1sU
         6Ad3hHSCZXuOyQ6BEu6kr34/Am1q8H5n4qjIypeqKVfEjeHYYAv4R7g1qm13j6yFVjEa
         29sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785243312; x=1785848112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3K1t70zaHBwvr/zd5QGdCAYVOIE1pLnv+eQf2gzB8Y8=;
        b=mGpOK0xPX0OiVOLzgBWjQgZgWYLjINoI/8PmJ4+IXLFH0ZQySOXaTWT/1rkUkSCtfw
         VmgFhQcPiwqCWQgQMVl0vKniYU2vUuKkW8gY4N7qieoTh96OWgFle14iqRZLcA1dRi9O
         zGwaA8Ybgf4DEPUwH34fZOCwmu01D0AYp6CoQt7/Pr3JPHQNJ/8mffRiEVu1wkYv/v0I
         JPHwQpQHl52CCPt0sbBL0ES5Uw61JX8LjX2+DHn9lSfVseUYUQe5TTM1fEQpqwFUr2wg
         em5cU+ubhioqPShAEvncSnjoPB+Z6TynbKuhg8Euc/eM7SBSgM7y9yxKq2J2TCAwBi52
         3Q/A==
X-Forwarded-Encrypted: i=1; AHgh+Rrj44/kd1BpuSi8E1kZV/Ncyu64j1UOslsfr2Jt1wGLMnGVUpGlVfUXFHSqSSRVlgoekCJqBcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEi9E7c/idtGlAn1TUXNE9X8dnf9jNi4KB40OlEgGubytWZIH2
	AOqlTn7OvnfusS9GBypXN2kyGgx76fETlF2lgQNmg7EIhLJ+t9ywdxKz
X-Gm-Gg: AR+sD12AUsdQm18WYpts64FXzIAWfrA9zSGeyxrA0tPe9pqH1MjDbaN4xJcx+UxoMOw
	2HsvTZoZFryI7jqNrzYvqv6oHNrTJZ+98R15QiaDHuzdRMmOIb7j6G/gVFoZtRurospIif6oql5
	zvXxI7ojOUNIk97jVe05177aEWvEfU6xZPBKxvycNGhMb4FamPtckE4/NLT0udyoCbBX+Nc76DK
	lpdPQmmd6MGA/1otPA+3lk+FM5AbBuegVlTUxFq4AjXFH54VDMxlC3KkVBn0PqQtWq3ngH26kY7
	k5FID4NcSCsKWTO0YVtozdkVMzcq9blbZ2by6Jr7iKDJ2BG3VYZ0A02tzppcq00Vu4jJ0XflJek
	V62EwmfmGy5VAN3/jCOGKhVBQW4OTtAWIhLcUSLGnT0LYIVIRzdB//No/9ynZzY/IRjUMrsHj47
	YodTsVKKGQHPqjgvyB0IM4tPrNDywHp7yZwvN7O77xTI0smfVRmDzo+cmKmY78ew5pDA==
X-Received: by 2002:a05:600c:4744:b0:495:40f0:e77 with SMTP id 5b1f17b1804b1-496c6415054mr25043505e9.5.1785243312169;
        Tue, 28 Jul 2026 05:55:12 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c444304esm74096505e9.0.2026.07.28.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:55:11 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 1/3] staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()
Date: Tue, 28 Jul 2026 17:54:54 +0500
Message-ID: <20260728125456.32359-2-meatuni001@gmail.com>
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

rtw_get_wps_attr() walks WPS attributes inside a WPS IE taken from
a wireless management frame. For each candidate attribute it only
checks that the fixed 4-byte attribute header (2-byte ID + 2-byte
length) fits inside the IE:

	if (attr_ptr + 4 > wps_ie + wps_ielen)
		break;
	u16 attr_id = get_unaligned_be16(attr_ptr);
	u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
	u16 attr_len = attr_data_len + 4;

attr_data_len (and therefore attr_len) is read directly from the
wire and is never checked against the remaining bytes in the IE
before being used as the size of:

	memcpy(buf_attr, attr_ptr, attr_len);

Since attr_len is fully attacker controlled (0 to 65535+4), this is
both a heap OOB read of wps_ie, and, more seriously, a stack buffer
overflow at several call sites where buf_attr is a single-byte
stack variable, e.g. rtw_get_wps_attr_content()'s callers passing
WPS_ATTR_SELECTED_REGISTRAR into a stack "u8 sr"/"u8
selected_registrar" (drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c,
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c). A crafted WPS IE in a
beacon or probe response processed during scanning can therefore
smash the stack of the parsing thread.

rtw_get_wps_attr_content() itself has no independent length check
and simply trusts the attr_len it gets back from rtw_get_wps_attr(),
so fixing the bound here also fixes that caller.

The "attr_ptr + 4 > wps_ie + wps_ielen" header check above was added
by commit 1463ca3ec6601 ("staging: rtl8723bs: fix OOB reads in
rtw_get_sec_ie(), rtw_get_wapi_ie(), and rtw_get_wps_attr()"), which
bounded the fixed header but never extended the check to cover the
variable-length attribute data that follows it. Add that missing
check before attr_len is used as a memcpy() length or accepted as a
match.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 2fb5863dbeef..be374d222c55 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -733,6 +733,10 @@ u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id, u8 *buf_att
 		u16 attr_data_len = get_unaligned_be16(attr_ptr + 2);
 		u16 attr_len = attr_data_len + 4;
 
+		/* Reject attributes whose claimed length runs past the IE */
+		if (attr_ptr + attr_len > wps_ie + wps_ielen)
+			break;
+
 		if (attr_id == target_attr_id) {
 			target_attr_ptr = attr_ptr;
 
-- 
2.55.0

