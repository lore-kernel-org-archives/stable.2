Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AF4B04A8
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380893; cv=none; b=Nl/355o7B+bQgsn/bs6B3cKAK88p0h70z/Pf8ea2mJ2lZ9Np+xnY1+LcL61ZKqK1RCKqhdYys90o28KRfdQPAd5xnchlJ8eJ6wE1gEHkUYHw5WS79eG1WPnVHf0Ohhjg3n0yVRfRhtZ2hhGxXxrpLwsRlFCD7RvTqisijqCoLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380893; c=relaxed/simple;
	bh=I4PeQi4SmvyrZYhDDUSHgIx+IfnvBhcHBkpar0jUK/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+JCkrQBcUAS1/CEGehTO201uKGEn0M51EMhjLH28+yLqJlnYrp2DTNqA6v1Zdyfi72HK4zXr6mOvGjqavNm3yb8x3WTYZaKRu8tm8V9stC1XXAqu/l1wdAfcz5WNplANpQv+7DBcBJKcB6OAtFUQSeeclXMQ/sjdlcY2NsddFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY8YODyU; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY8YODyU"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3115c4451c8so3308312eec.1
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791380882; x=1791985682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TOZ68Zqd5ykdIjDqMFf3hngPNxsHC1naKT//wwj0pqw=;
        b=KY8YODyUqIOH6CB81p5ahuVTAWYy7ma6MLfPnyTHm/wykJ8UtkyBD4vXkRgwpe1VHK
         ckVnWcY+6pK8LJKxWW5HUcbYe42KZdTs4XE0MeEbmIMmCBnsy1e1YAecrgLiapmz7UAi
         cDer4XRGS7bUjsRfpMEe9YiENbK3jG3aFp+p81pqH7hhVLqlVpLXRlwKoaSjRqBhUfay
         6L6HjOaGSxvhd6Ds/10GkWquQAs5uBeYGhc//Lezng7/kJGAB4NNRZXkWxXoUNYyHg+U
         ZZKblWCDpokzfaqU+7iVgjJepFEWCLXmFFhhVNWx8hIUa2C1yUeDr0k/V8OIj/a1SEii
         3S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791380882; x=1791985682;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOZ68Zqd5ykdIjDqMFf3hngPNxsHC1naKT//wwj0pqw=;
        b=reNRWUqXihTqjeQfJvpUzDbWdp/s9HrTiXvV8M5P+6RKyoGQuUlaFKKClZ3PsA6r78
         Bpi02aRIKL5O1tABFxl6kCbR5dyrUhukv2vVAzztJ06p1wccyoSbpGmV7ZE/H5SQe7NZ
         aYIcr/lk2U5GgrUgVFgXEIMNjILqNflHcfoIhFxJ5A9nw1kBTUFwZWcD8fEWIyw6b8Q2
         h9yn7yo7mqgaCEwPFj5Z7aXFOqS6WznT+xJLCjESLd+lLGa2xob/UAfOYOnHmk3DwpKs
         OmNQoYGpeTn7Y7HTXEfssr2WNefT8iyi44NCd4nesoWb2zn0xkNd3paU+pea6HzxNkvD
         z0ag==
X-Forwarded-Encrypted: i=1; AKwUvBz21IokoyEwof1lfsJ7XKgvYagxRsSHdCcrbyIgZsV/3XQ1G3bVKR5SXstd1zgH0vazDG2vhYs=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0w+sss9Dj2WFMd7QsyfpKwAEKthx2F0N7UPirpNlYGlMfVX+i
	52V3IpnQ+ctiPHrHOEUcO59Ww7lj96Ud2H+HMs8X7LXl1sDmcMyE5BGK
X-Gm-Gg: AYBFou31jUDePkFXcJdeo3XCNb508qJV8TXtGKLOBE9dk7BNzNyLT+laPIVNfmXiSpl
	t0bCEgxOOW0FH3BgKVNzn4+aQGh60zl9VyrcBJ7PJjGEMRDg8auxRKZqKPw+eVUcZ40wpS5B0fd
	XJDwHuj5/BnNdxm5bQ/ri6lAdYiKA9KB+pT5/0RkXUCXKtvR/cuvMcaocrf16LoCG/Ue2iZAu3e
	JVO3RnM/lZjH8ZUKkL0ueoO6SxIknot00MuGRkJL7sf8AAp9c8Vmnv3lkO7G2LwvMS9fs55lPgy
	wDChaLQRZzDw03P6xhkUlZ1l/ApSo2sDxsshzisSN+gmH3Z1MgQAHUH3HTFIHamr4pacdQR5xib
	0dTGj2bnm/VCgEHNDMZz19Peq1gzuPdw8RVE73WF/Y3M2RZFg0ikJIiSXZsUfBzxDOlm9dDgJqu
	MJsdzAJ3X/1LofQIreWo43cwMvtVdl28HZ8XUvB3N0T9entfrCmgq6sdoDpDnuo2eTj8pR0DcCd
	XBxFL2qT9N2N62EcFSRTu/AGk9anKy/7ly8Lg==
X-Received: by 2002:a05:7300:de47:b0:350:c7e7:57a0 with SMTP id 5a478bee46e88-3514530ab4cmr5957045eec.24.1791380881436;
        Wed, 07 Oct 2026 06:48:01 -0700 (PDT)
Received: from fedora ([2a02:6ea0:c803:3091::12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5c2esm7304472eec.10.2026.10.07.06.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:48:00 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 6/9] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
Date: Wed,  7 Oct 2026 18:47:08 +0500
Message-ID: <20261007134711.473857-7-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007134711.473857-1-meatuni001@gmail.com>
References: <20261007134711.473857-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The store handlers copy the input with kstrdup(), which stops at the
first NUL, but pass the full write size to
hp_enforce_single_line_input(). With an embedded NUL the copy is
shorter than count, so the helper reads, and can write one byte, past
the allocation.

Writing "A\0" followed by 4093 bytes of "B" to current_password makes
memchr() scan 4093 bytes past a 2-byte copy. On an HP EliteBook 840 G2
running Linux 7.2.7 all 100 such writes fail with -EINVAL although the
input has no newline, so memchr() matched one in the heap. A userspace
replica of the helper under ASan reports a 4095 byte read, 0 bytes
after the 2-byte region, and is clean with this change.

The input is a string, so only scan up to its first NUL.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v5:
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 754ab03bfd7b..84d75926d768 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -166,6 +166,8 @@ int hp_enforce_single_line_input(char *buf, size_t count)
 {
 	char *p;
 
+	/* buf is a string, ignore anything after its first NUL */
+	count = strnlen(buf, count);
 	p = memchr(buf, '\n', count);
 
 	if (p == buf + count - 1)
-- 
2.55.0

