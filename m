Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD542DECB2
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814467; cv=none; b=ffs1kyeMdGMZIxn+fln0MYzDqM/sN0lj4fCf3RgZb7robPG8ZtcJ91GnezjZj21ZenMhRtMatTmrKBceI2vd+Nd4EoitwSqJFyTsr2BE1GZXiGRYqDby2EjF8eaeYAsK7A69wn6quRzKzn9QhfhmcTQF5Dg6DwSekxw+8ouHzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814467; c=relaxed/simple;
	bh=UN1Ug31Azzv9rf4QmvaFWgW/3REkOEopYBll24EcvV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9XAZvqmfzphTEYqNjDCtcMpqyJx8WxllbVSrJYsLkGfzmJp3crFJsqLtFavfBxQhFcs1YQSJBsMPZoGaUkHF0W0a8duIPMmiU4mqo2iUSMk26jSZDlnuX4DiHGoC26ozXHn0Wo2S6OV9RWTCWlZRTmhCTWp4lliEZbaDqKxflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYHV6kfe; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYHV6kfe"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-13809223fd4so2250300c88.1
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780814464; x=1781419264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8HhuuqF5LxBBn4MixHfYOj/pYBiy8lGyW0X7+8esu9E=;
        b=BYHV6kfeN18F10FCwEpv8l47A2NQO+P6n7cJeQlM9gQDrVv9f5VGmNMzZyn0W4QayP
         On3SdVpfTVxa6VDG+eCOKxj8eL5uSoyImZU8eluv0siokOUmjHT/X6ENVOI3AAN3BFOn
         eVL259FNmq67BQhZNYIGZZ9dq8gbG9XxHyXBg2wxSyI/EkJ8PUfdofiKJBSi1xXEQQ+F
         pG9pcefy920o8r5lDa0C4QqqSUNkuJ21DdZAFBJsIpZorPvyz2iZ9ZyjgUJyZlYniBPg
         DgTKNHcrpExjSoJopqg3wCXEQzE+Uve2TaceRFkgS2EphtpP5x8mKlcWg1LPMDOYjOAQ
         pNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780814464; x=1781419264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HhuuqF5LxBBn4MixHfYOj/pYBiy8lGyW0X7+8esu9E=;
        b=B/7IWXFE3vIFnA/33zCBAx4P296a14AZqWEyB+2RJUnAfjAV9p3MPIdOIWjItTGMwY
         iuKPWoR6i2jGC1Duk0oGuG48kj/gwOWVD88g9sUkoxi31UNaP3OhAq1DvgjuSkG4fvJE
         owPBJaH4oxRX60rAYEjlIqs8DlRP/GMnaTgAYEvmo3RUHfoR0NWqAtBYYqCLgnMxiXZ7
         NEpa7ynOmHOJLPFQvX1jINdiR1RtrCKQOhAL7yQcw2EhSi5YDCB0xhoHxtj9a0ZQptM6
         AtDu3uGMtNvjjXS1zm7oOroxhhr02hjEzDpNZRfzx+gr6Gm/Bi8Fj+WBiM6bm3q+dfvD
         hV9g==
X-Forwarded-Encrypted: i=1; AFNElJ/6Hxi92E1yyuDIE3b057BTPaX2Gsyu63gJlNfhXBxRtRohrR6Z2bUKGepPdVigjir+c3Z9hx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKgIM0cttxDvigaBTGM7zTYWoaLsWa2lRlSHypVYvzFF5LgGf
	w38ZFj0Jm08jPcXdE6nCcXDn4W/rzmqffz7EZ/ba5+UXqJlL95O86exJ
X-Gm-Gg: Acq92OGphdXfsDAE+U0JF91Gg6kgdWEv55FBc38wpDUigkwCz73uoSkWD3UZzs/aVdg
	Ixa5v0D5kvp9+YqxdyHUAUxMqi3LspLE5UuJc4hDPi+V+dtDUD2PJFqFUOewTrc4PVmBjLETCDM
	9+w2sRUKGrz9CuGOljLRMzKKvxm1TJIDZ++jk/CnowYh6THHjbxOZ5uBUJBdlC36Ur916Y1uay+
	FmOkNtVtL/SN+PXW/8vFoLNy4gRExQXUwVDjgdKcaKFeFHbvzMFOM6xyEd6yyo2gr+N/OaIzpIV
	MJX8xEe5YJDFLU8QDyVcJUdyGOGEqX4bTYQdnGNTV0AhXMvylHLXVb8vxOixBY3Db3Nxhn2jM03
	Y03yWAPAO5wqJd2BZ9bq5n6VC1RfuCUnGgqyhZtTyL16CsdKnPHObdOfPzr8O9xavK0/mJpTWHf
	yPyI0UPw202ZpKNvk2shNsv3g39d6QnklntZ3haWtCOcrvdGn+xGOpyiFwmN0Z7uJuGH5oFqSzM
	Xo62v7sqaUJ/yzhTfad+qyHXiBBGEmlzYc1plGl/0EMDI3TB38y0A26zafTFTibiF9OxcW3B6IV
	6XrggFNvB3KvJaBDRIWEJO/I0+1pL5du4EGlXwA=
X-Received: by 2002:a05:7300:d517:b0:304:de94:1c2c with SMTP id 5a478bee46e88-3077b866467mr6790455eec.34.1780814463977;
        Sat, 06 Jun 2026 23:41:03 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm18462755eec.11.2026.06.06.23.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 23:41:03 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-doc@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH] ata: pata_legacy: remove documentation for removed module parameters
Date: Sat,  6 Jun 2026 23:40:49 -0700
Message-ID: <20260607064053.195166-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
several module parameters from the pata_legacy driver, but neglected to
remove their documentation. Remove it.

Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 37 -------------------
 1 file changed, 37 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 97007f4f69d4..47bccc148a54 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4935,18 +4935,6 @@ Kernel parameters
 			Set to non-zero if a chip is present that snoops speed
 			changes.  Disabled by default.
 
-	pata_legacy.ht6560a=	[HW,LIBATA]
-			Format: <int>
-			Set to 1, 2, or 3 for HT 6560A on the primary channel,
-			the secondary channel, or both channels respectively.
-			Disabled by default.
-
-	pata_legacy.ht6560b=	[HW,LIBATA]
-			Format: <int>
-			Set to 1, 2, or 3 for HT 6560B on the primary channel,
-			the secondary channel, or both channels respectively.
-			Disabled by default.
-
 	pata_legacy.iordy_mask=	[HW,LIBATA]
 			Format: <int>
 			IORDY enable mask.  Set individual bits to allow IORDY
@@ -4959,18 +4947,6 @@ Kernel parameters
 			with the sequence.  By default IORDY is allowed across
 			all channels.
 
-	pata_legacy.opti82c46x=	[HW,LIBATA]
-			Format: <int>
-			Set to 1, 2, or 3 for Opti 82c611A on the primary
-			channel, the secondary channel, or both channels
-			respectively.  Disabled by default.
-
-	pata_legacy.opti82c611a=	[HW,LIBATA]
-			Format: <int>
-			Set to 1, 2, or 3 for Opti 82c465MV on the primary
-			channel, the secondary channel, or both channels
-			respectively.  Disabled by default.
-
 	pata_legacy.pio_mask=	[HW,LIBATA]
 			Format: <int>
 			PIO mode mask for autospeed devices.  Set individual
@@ -4994,19 +4970,6 @@ Kernel parameters
 			the first port in the list above (0x1f0), and so on.
 			By default all supported ports are probed.
 
-	pata_legacy.qdi=	[HW,LIBATA]
-			Format: <int>
-			Set to non-zero to probe QDI controllers.  By default
-			set to 1 if CONFIG_PATA_QDI_MODULE, 0 otherwise.
-
-	pata_legacy.winbond=	[HW,LIBATA]
-			Format: <int>
-			Set to non-zero to probe Winbond controllers.  Use
-			the standard I/O port (0x130) if 1, otherwise the
-			value given is the I/O port to use (typically 0x1b0).
-			By default set to 1 if CONFIG_PATA_WINBOND_VLB_MODULE,
-			0 otherwise.
-
 	pata_platform.pio_mask=	[HW,LIBATA]
 			Format: <int>
 			Supported PIO mode mask.  Set individual bits to allow
-- 
2.43.0

