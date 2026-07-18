Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF093264C3
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400924; cv=none; b=kJ+D5C0cS543aDnIA+TYdQrVzt45QtLyGYyvAi5VRfL8WU39N5cqp9t2dsYRMbwFGJcLgpOqlWa5mOQ+MMxzodjqcLNEhkDKQWWoA77t217RHoih8Ahn8zCkhk/PO2GvwifV0X30vuWHjj1zcRTJTAjGhbcIS+nc4IqC55FTtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400924; c=relaxed/simple;
	bh=H1uaarUT/CzOlIYk85IhS6PC1+AMvnoZlaiNlT42aGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEZ2eehZ4tX7aX2drhTp4eyljXpj7RmOVqWW/G+7Aqp6kVhW4zwZ7mNkDYTuA3HiSdeAqSkRSriUuNB6PkhWxkdKdzMXaCMbwl5zF63Oai38cZ8sdq93i4NaMmgvsG2NwPBBGe1kE5yBPehKe98pIq8sOqQD9cd9sAE6Qr+eH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSIcEWuD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSIcEWuD"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1691e4ec40so420504566b.3
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784400921; x=1785005721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c6Y+pKPXjSHKlGYu4KK+zrCXrOnM9HLfJHcJjmz+n5A=;
        b=eSIcEWuDgeaUsxQ+td6Kf+TmFn+sBYEr6v1YAcAuj50lpv2h2Yld0xwejTwlYlPM/N
         4OdvtSCb9fz49BQQd6NLeGYdIMBVJuTCB0rFBIw440imAiKWCzyGPHUrqpMXMKmp3Vg1
         LCvp/kyOmodllosoU6kBGqzLwP0AVnKhDZEvo90VVXXTo9178rF7eYIfuCXggOLlg7kb
         UsXuvD2NgiWEbOWqzHsym8WtatwJ0KdTD32GxOadQdP9VM8dk/dpq2e/NidtGdp8f576
         0TFFzPm00Am/CkmD96bek2unxAfSRdl1uKm/z8Quo9hO04F1PJKEYtdItyIfbMhTSJn+
         ReNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784400921; x=1785005721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c6Y+pKPXjSHKlGYu4KK+zrCXrOnM9HLfJHcJjmz+n5A=;
        b=G4Wnul0bzyICHaBDDx/YwIh7wu3s6DGOrouSk8PQPQxjBBg/NhP4HWcKe6WsI5+Jzi
         /q+5JKmf9TO3G1lxnjNYgIrDlivYjyzrnHrRPi2JLrLf9rtlmWXgl6TMfIWb+/sKW8N5
         nXdiXYbAsLZMJE39GNrdg/2vM+W9kPKPxAf2NIQJ4ZeQZDZe6fsNJ6bSt9KPS0IQmbD0
         ElQ5FljJpgEVGRTC60Q7DMenoguc8WckXT/8cMcKE2RLXdLW22pUB4Z0e+SaeINH5M1/
         JYkiUeGob7xnYTiRAlANzekGgOL/7m/tgcEim60hnH2PtxUFwyNuHA996NN030OcvqLY
         G52Q==
X-Forwarded-Encrypted: i=1; AHgh+RpdJo9jwiBDheaf6We/YQmASHhVAwMqW2wGwJcY4+scdwWT/oLt8H3COwLkzu5oJKRIIAeeyP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMYCCxrKqvhfBQqbwjQ/HgP68zSlb0B1RqQDy8hv3BusGpiXA
	awL3Wg8cn3H1wRUuUWnwD2dwO9FAWjwfwZRWnAVDkLDWKArCathmk1k3
X-Gm-Gg: AfdE7cmCvr5Wpu/os7JywsgbNEyk3gi8GlNXbFFLSpP6dm+Z5czLsIkrr7sNzP5kMww
	uMprmzptmlUwstMFM3fcdlW1YLpN+o3TZGPXuxinrms6z7S5Cg1Ins8BXmUsJogLu0nH2I99zEL
	e2irVOn2XynM2YOt8Ja2beSB9B8u+Gr5wlwRzKaOiaNJwoXYemRxgE9NWZio6ky1vpaWnQStdzU
	B3JFQMDMGfBbrSGMWjlgFYvz5zDL/jSjDwkEyvttG0Nbcaa6yYn1vobWUL2aYnz5SuN7i9wnbpM
	8hLIRF4GwpRp5693kbEDhvfBXephjHYj1wB0uf60zN/85YFA3AwIK5fmBj/UoraLFMQQ2RaH8L3
	l071Rb2eihmnLLbPApYEzDWDFtCRwh90inYF5nlyg6N39ASwXGVTR6WdVHkJXcB7hTMPKG5Jgza
	ttPKf3hcxi5LqcKC6neOMKURE59aqgdJJyhyawPw5ftvywDdyxnWet5Lo=
X-Received: by 2002:a17:907:d11:b0:c16:5ae4:77a3 with SMTP id a640c23a62f3a-c16b4702bd7mr341127066b.25.1784400920942;
        Sat, 18 Jul 2026 11:55:20 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1712a5f837sm249151866b.32.2026.07.18.11.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:55:20 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 4/5] staging: rtl8723bs: fix OOB read in rtw_restruct_wmm_ie()
Date: Sat, 18 Jul 2026 23:54:44 +0500
Message-ID: <20260718185445.63070-5-meatuni001@gmail.com>
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

