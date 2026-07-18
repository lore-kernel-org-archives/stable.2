Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A832D0CC
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400920; cv=none; b=kdHKdqWJW0F+UJb6s14T+p2ch1Td9LPrEaudXWCDvQCFu7V3XDqwoRMJSemiPI1gDi9nJxZpbUFzpGE12xcFdmzK91qKq0pGuorfo94+FPqVsajUVhAmMO1A/sWIqqmF40bhXeSguEpvwF2jl2e6atT93XPHnNQoZP2vy1N4i8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400920; c=relaxed/simple;
	bh=bCImW5FveOgLSFMnd3wYiHnrEIorbTiPRBOU3dDrN38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+V3gt0fEMEOMWagA8iCG6O24kPb7tBczcvGeg2yeg4ETXjN73/wI3eryYIlkudxeRlferenhA5JWha74QkI6vHVcihFEcLhLp6MQo5uMoJARbP7ULPEh/j1hS4fBZFuE/WbL3p7ySLfkGWUgTaYNJPlmC7/PMLpwTaNIeSOehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaXp5b78; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaXp5b78"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15d47266baso672462466b.3
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784400916; x=1785005716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3K1t70zaHBwvr/zd5QGdCAYVOIE1pLnv+eQf2gzB8Y8=;
        b=CaXp5b78v2KEwdhCOQk9mhJ5weT7AFV/JVUsWY9taRCRwz+P/ejWJunMtbnQJPc7cr
         r7Cum0Be96nqVXwlida+RkmcFHss8PspHa+4gMrBgthqcNMrzdK9psi8OOTm2EsCFRTW
         ys2bEYO9Ips/y+mrU9Rd8Zx/zmV3xSpJwrFXLreRM6G2yqKtQfSParWJXDqr0mmbXa2i
         RcQILc4JAGftE4KyVE6eQ//7FqV1zf+vPTnk9o/BvNB1QOpAiHsowWlPqChoHj2SxUKL
         u/BNEpXN2j4G49dGLQGIsIHHcUzCdMWWz+jo5OUDa/Zy40SIYvATeiRf0lxqAQKL1Mky
         J94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784400916; x=1785005716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3K1t70zaHBwvr/zd5QGdCAYVOIE1pLnv+eQf2gzB8Y8=;
        b=NGNj1epiVFTNJmaoHu1D8+Jrw0oDeGprl0LBExBOCHeu2p2ViMgovIRL3cE3NdBk1W
         AidrCcXTloig4NbxqxdwsYgaflRZ0dgGlqYi0eTTpKrlryDMa2MKCY4OI0dmfzaXf5Gn
         WhsvH7SL80DHBgaEr0MIVl58AvlFAI3LCcD77HfUrrLu616cRsPas4HOy+XeFmoOGTkA
         VqsnjkddDkza5mJLDnQOQ4Ijvabjr9xvFV3yMAXvUx0i8TyQLWdJvyweqQ2ftJaWrjHe
         FGn6pCYNqV67UKLMQw/NvNtdMbxpIe3Rovno54yI398yc+iYVjOb6Xs7NHEVi5bDOyjn
         vNbg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6cDMi9F8/cFOKuZqvyysi0mBGpr1/+2NAZvkbODz6GN5NZmKnjudfScT929e9J8fnAAKzwV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdntEAE2c0o+jY3UEmJu633G6EPEcYqfnkGxUQQIPrYaGCfXi5
	p85paE4TnyxRNKOtTWUOqmbSdBRXEQjdVG+UQR9k9gJR/F3eCNq7Bvti
X-Gm-Gg: AfdE7cmJ93J+GaEIp9kHa7eRk2tvr1tV1iFAhtgyduvu/G3qcG6LT9c7ShJ/sIdl1wL
	IHpZYMb7Vyzz23Xn3154MYdzqVYzK4QvsmUuhAVqWZjqy476tVUrd1pFEV1HvSBCPKAH1AdFeCL
	+9FkqKswAy6G9lMKznFxAWh0yH1zRD3FC1J9GmarKZ+Z9NesPwNyN8+WsO1mu+scZlXqwhyybQI
	KvepmrM8TxOU4uwZ8X5OV7p10d1X1ibo5cRUnBH3jzqjmXyL6tpBVH3SQIHmNbzfKFU3cTPUrl+
	mh6nMXWPrEJ0sfXRjH5TSLFIICM9zTNUtzeyulkhcv+F0t/YB2KV6kCU1YLLlyRu4711oUNPjgV
	+KEVVdzl6GWzSGE4o5kpAlap0KpkXbGxDcbevjmT/5hE21qmnQJlqD/DNcHbHmiaby29strCS2n
	aagWzRsFlrIlBU0kBUiuD9kOwX9E2xZBK5VzbmXO7pgGDIuJ58wz6nNJc=
X-Received: by 2002:a17:907:c8a4:b0:c16:af70:f981 with SMTP id a640c23a62f3a-c16b48551d8mr273271766b.32.1784400916066;
        Sat, 18 Jul 2026 11:55:16 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5f837sm249151866b.32.2026.07.18.11.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:55:15 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 2/5] staging: rtl8723bs: fix OOB read / stack overflow in rtw_get_wps_attr()
Date: Sat, 18 Jul 2026 23:54:42 +0500
Message-ID: <20260718185445.63070-3-meatuni001@gmail.com>
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

