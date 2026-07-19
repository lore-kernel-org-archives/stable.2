Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036FEEB3
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 04:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784434526; cv=none; b=ZB0rIl+Gqalo1VNUITQUQzlFDJMH0NKOYhKNzf0BfyIGQ2LZoeEvKLWufj3gNRd5BGEuQ7ipiIx8r3EeTUmJIaZAfHSFLpJiATH5/6vMP4EJ2fGAeSfqXsfk2ETVCPhhf+D36KAbwdW3rWt+e7t6VNMK609dBf5zJzt5NmHBNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784434526; c=relaxed/simple;
	bh=rZ4Py+ivJMlFzHb67uuRBdEEPBg+t0H4JAPB4QTZC20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+8z++Bo/nA7RkFRGOm1QdoG4pJOeXwI2VILEU52BKiAD8qq2z8L5dkHUoaHVw/W/UFcysQh8uI5a2nUxNkIkS7BniWYAbcHmpmx+dX4vT3Fk8Qk2u2rrXHPGvSD7wqweIK9h7JUUz5mzi66tT9Tw77utr23OcilVKsAfQks6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIetQMqx; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIetQMqx"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so9477290a12.3
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784434522; x=1785039322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0iYqMAXukoKru3oUtjQbgbaZB6TaGAonUKvli9tEDbU=;
        b=IIetQMqxc1lPqdBwgpN7QaETUc4eIlponjg9YzLYdNmF/855ZtIKtFzQzjwRzoF4oB
         1Xm8E3R9KXihwtj2ugTqXw0thUYfor+0e0o5N2Ux5sSA1lOz0WL2LZ0PUrkwW0fbPzld
         PSOsPo2vCXTtI6fw+xMfJOUmFWxtx62eWeNcPr8RPgfeWqlpr9VqJLZMbLojzESOah0D
         fk4kgPJGUB4wQYE7AeNZf5bv/G4Khx2rNP0/T1p3XrKKYkOI6fS4MyQ90HJOnCSV6yMY
         ywBY+7L5A5CZBLU6QGJ9x3aVsmlJx1cmrB0qHslWIgy7TNBvZ5XB7AuV0ZjeDtxYi2u+
         /W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784434522; x=1785039322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0iYqMAXukoKru3oUtjQbgbaZB6TaGAonUKvli9tEDbU=;
        b=tMSiM98NRELM/NFo4WRSBOuuUHLiPZecYg12gOG4YxihvX+be8TxOlTrgIGoT19NyS
         JyJ16ozKRp7Ub+Sa2UNDmrFrPzM+TQMS3r1J9jF9IzZRlZhiqHqgormWI7RfcwKU7seE
         UflUx6tF4sA0TrID/VXxId0x1OYifgYz75OnW0B2cdHC/vlrHCQDD5BOFGfJ1/HoAxef
         RZz8TGGQ9FZIn9CtudJu6nkKPR8NQp1pU/pxejbp8EXNhRToK7L2WrnR0HwfGCevAFba
         oqOfiHpDAU/EanVcjDtnd1i4uvap4LoxImf4+jLYXqWdPHRQEGyG4gEfUBzYOUiRrxW3
         IMRw==
X-Forwarded-Encrypted: i=1; AHgh+RrFs7NG8wWl6rK3NLZX12RvPDMiEnHnRYzXjkvaA1P9L//JItKyhc8a7YgL+mszokKJPzjUs0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA479R0hdm8CSpgAmMd8u+td/ForRWRp0yc2wztfPM8JmSLByc
	nCKvZGEVh8DnxkVjxPul04wMtA6OMOSsnqEAEfS9MU7ZrunPUKI9vqYv
X-Gm-Gg: AfdE7cm1VpdSpsFCEzK5kiYFsqW35WT1TSZ1LNBP9hHI8oLvNuDW9ScXJ3U6tz9sVQA
	pbVK3eEooFKeFmdPIZ8D5eFyYuWcQmcSKpOMsSIZjNT+foSFCG/ahQDr5r1gpoOp3Gcn4cw3k44
	iMnH7eyR39ofb4XBjTO9k8epipppW0lV5F62b5wtfwU+OuwCee+UT3ev0P+QXfuIwunzWEarYve
	cEq6OABD5JA35lC5xFyk6n5x4fFlX+VJ8cU6ZzLCJkQZFQgFfA3KfDhHErprpAOA8eR9069KXF8
	JOkapJcI5cR1vhDLwpvJw2p4LUYrpxNyMcwscOdiwgyLkuq5xTjJlH8LVURi/Tu8kvlB5GBq7FB
	/JZdEFUC5qS8qPoqA2gnF7+IU70+4rsQQhCkgcBp9MdPqMOS+4OywQRZyYaVpK2eKSAUEO3fFvb
	85j7oOps1Ldpjey5FsgbVSSwov527mLA15ECh2brgE+3OEzOYnn8d4WV8=
X-Received: by 2002:a05:6402:52d6:b0:698:9be1:4a48 with SMTP id 4fb4d7f45d1cf-69e65327816mr2986159a12.33.1784434521961;
        Sat, 18 Jul 2026 21:15:21 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fefcf2bsm2928064a12.9.2026.07.18.21.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 21:15:21 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix OOB read in WMM_param_handler()
Date: Sun, 19 Jul 2026 09:15:09 +0500
Message-ID: <20260719041509.97894-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WMM_param_handler() copies a fixed-size WMM parameter element out of a
received information element without checking that the element is long
enough, causing an out-of-bounds read for a short WMM IE.

The handler reads sizeof(struct WMM_para_element) (18) bytes at
pIE->data + 6, so it requires pIE->length to be at least 24
(WLAN_WMM_LEN), but it never validates the length. Two of its three
callers reach it after matching only the WMM OUI: OnAssocRsp() in
rtw_mlme_ext.c matches a 6-byte OUI, and join_cmd_hdl() matches a
4-byte OUI, before calling the handler. A vendor-specific IE carrying
the WMM OUI but a length between 6 and 23, placed in an association
response or in the IE blob handed to join_cmd_hdl(), passes the OUI
check and then makes the memcmp() and memcpy() at pIE->data + 6 read
past the end of the element. OnAssocRsp() parses a frame received from
the AP, so this is reachable from a remote peer.

The remaining caller in rtw_wlan_util.c already guards the handler with
"pIE->length == WLAN_WMM_LEN". Move the equivalent check into the
handler itself so every caller is covered; the sibling IE handlers in
the same parsing loop (HT_caps_handler(), HT_info_handler(),
ERP_IE_handler()) likewise bound their accesses by pIE->length.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a4de538722b5..c614c0b4c792 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -666,6 +666,9 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 		return false;
 	}
 
+	if (pIE->length != WLAN_WMM_LEN)
+		return false;
+
 	if (!memcmp(&(pmlmeinfo->WMM_param), (pIE->data + 6), sizeof(struct WMM_para_element)))
 		return false;
 
-- 
2.55.0

