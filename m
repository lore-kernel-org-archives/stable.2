Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171317;
	b=ckChix0OJ6yCoQ+Z4WCekonAuB6Zht0K3aE9X54gX3JlTCYXEd3pln79KUo+76hPjT4I
	 x5ir/dI4vp095fFX76QYjjFWVjy/hlwN0VSEp6LLX3+RuYWDtQwDo1fTpMrEoFj/Ww4Du
	 4Cisou0xAYCKqfo0ZkDW3yVLba5wo/4ok3Euk9R22jzOwTsb0Z2hdy+UGUGUKskMzG62w
	 wOBOBSO9oImOZUBmrgKGq1H8P9Me9prBHXiHVVz4vagdtpX2sqz1EhAkx9KSWEQMnndNc
	 +zARYIfl+UeDvC+l3HHOTItf3PrjZZAg+o+iLJJYnEyDrzcDOwzBmcT2fS2rDs/PxzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=K8i6P0KFfzK6HjaSVdFTUucMIIRoYWICC8FPLMcToIg=;
	b=ySS2qY1p7HvxOAWHmLxOKk98chIcGv2Q6YMrTBu50ztjpnCKOsS21vSZCe3hVVFqFvrv
	 P0bu5HaViLS6VGz5Vm0pnsr7r6xxAjjTx0JUR8Qdqxylv1UH1XSUDyTN/L44M5rA3v24y
	 2cQD1lnZEAHamcggplZTiaYUazmi01M8/UF3uqG4a7AkMSmwULDKPz7tNTPNyIREKJChu
	 Q6HColx5y4NTrGlxO+2Cl087eBYXbAR5eA4UkyYtPzzqyQymUe6KB2OnGOaeqirWbNMKA
	 EaIRp7zXE+TF+M8ENSRK327+fI2LK/PYGSDmlEpne0tK3m0VrxcGaDOK8ncMPc/O+qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=whNDWi9P;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD79606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 20:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DD79606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=whNDWi9P
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6df0b02fe91so174815eaf.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 12:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794171316; x=1794776116; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K8i6P0KFfzK6HjaSVdFTUucMIIRoYWICC8FPLMcToIg=;
        b=whNDWi9P/wMPpOxbhJWbE+G1PIf+SUj073zHhzveLYuBL+gXp63KNki+nk2O+WS9F/
         7ZdHvZRem+eR98OQDvIl/4+Aq65lTCdN4EkYsn6wxZm0jIUzSC+ya3XbeOnTEO6rOGX0
         y9ubIOVn3LycZBFFKjRLMnZU5XqchVLC3+IlnZcxYhXqbIhuekH+76qQ0ZWErG1Xlbjp
         vUaIepV/CRGUZWHwGpdHljjcVNAjUXYMKseS6UQ5DeZKGe0wK0aj9XSJWB4viZIZHjGn
         DXxH9hCm0eZPzha2SX/hRzArUu5UH+XfqR+6f9oVaM/2TTadoOZtf3T5D8812BySsc3c
         dtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794171316; x=1794776116;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=K8i6P0KFfzK6HjaSVdFTUucMIIRoYWICC8FPLMcToIg=;
        b=QhiQt+VY0j27rRhaw/o4WGYjONuUZ+rWnynpBlo2i7TelyKpWGwWk7ubafRCvOr8tr
         Hz1JCfRnwOgAPg6GIowQv8EYfBjk88O5GTbxCryjhIE6Sp+S2enu0jtAEsJh/H8ffpB9
         EmqudDknpHea40tRUgH5t8ylYxptweixASjxHmEfpsVDXLKPnyufvca2A08UcvyZL1KM
         rNb58Cxe42s1ARhSjmJkkVzj63Tjp8NuNia0bL693XLzZagzyoqJDoCugE7uvU6oclHy
         3bfSlG4BD5Hxq9vhFVF63XX6+Fbu4B1mXVFfYb+JlWFE9Ga2iqYdQXD7XPhUN8cyrUSO
         QF8Q==
X-Forwarded-Encrypted: i=1; AL+hErGB5uKUTmjgDRFqVdqmFja3yR5zStXS2fmF0Eg4lDv/Sl+U/ePvAsQ8jhOTkBNL4SXwLQO51qA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mm3Bf+eDGnwIJEJyc4bCR8KG+hGh9neHWh2wb0p2MbQOevMHF
	ajYE/zS0IEO4ii7JvnpG1Nx4C5X5KhQkBAKB0foZLZoarTF289FbdSER69CS7Q==
X-Gm-Gg: AYBFou1/upsE2yW0Rx0aaSs3idKONcBbU34SPP2oImMs33WVDygnpenySH1BvNmnMW9
	NBqDXzXhLSDU2G6edZUwcbgoFTkBC54kaGDpUjEsXiqK1KCYdJs2wEtXLzuc1Dmf5I2AUm9V5Oy
	ptVRyZOLhjFM8/oBKZfXT92CkHacMCoX9PdQqRgdc02dOJSUNRt39jNRTqMzOQZjsilrDoQCrGV
	A+wXjFAu2izA4yZMw049QfGy52l+5Q/woHRq0VINCp2UbjW5v6wr5TN+cTOKpl9zY0ohGbhMLnk
	JBcfNFwEXlWZ5aREl1o37YvwG6wi9KB7OH4gSBQac/22sZxO14nKLCxRP9TVZ4lJpVQ/HWGF7WF
	TcWYMF9eLZGR8tbufJ9nXPbUjKFsqgrpGknbZOqdJzWqYu8XTeqtui5/55+WXGZr3B6GKzH5yKF
	w1nFpYPiyTqn0s8eLNyfnRQex5+myFTInFHZoiLvNl3SI6HPwnAmDFhX7Z5FoHeQNAGwX0hyhFm
	aKdT7DuL5htygQz4D6dmSCK8bcxmNNyYivbLxWsxkLqFFOM+KgEj6Dt9KkcvGUXFVvNJW/1MzL9
	hvZYRHyhZEZ/sId5DFXDepKj7WV9DlB0gE1xIgIHVY7sOcfQz72eN+vErsa1HXs0cXIhRlg6neF
	zIJ1ZJI+mWV+U0vzS1sZQPQ+SDdGnI0yHBAY2kg/3plKS0/8XoC4YoPQ2DojvIDFPsuXIoDdFi/
	kxGvLFeYMY04sDdKpU4bJzvYTs7SSlSQ9JWzYtix8V/2O6uW4YV3PU
X-Received: by 2002:a05:6820:3389:20b0:713:da3b:9530 with SMTP id 006d021491bc7-7170f2f0ffcmr657630eaf.44.1794171316382;
        Sun, 08 Nov 2026 12:55:16 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8b5825sm1917175eaf.5.2026.11.08.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:55:15 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 13:55:11 -0700
Subject: [PATCH] mtd: rawnand: au1550nd: fix the memory reservation check
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-au1550nd-resource-claim-v1-v1-1-8f4c694fdd39@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN2wrCMBBEf6Xss4vZSFvxV8SHXLZ2xaaSpKVQ+
 u8m+jJwhuHMDomjcIJbs0PkVZLMoQCdGnCjCU9G8YVBK90RqR7TYifJaBZqWxU8Rk7zEh2jexu
 ZcCXsqe30cL14rwiK5xN5kO33cX/8uUhe7HIV14U1idFGE9xYqyn7czChBG8ZjuMLnW8gEaUAA
 AA=
X-Change-ID: 20261107-submit-au1550nd-resource-claim-v1-71562f83dd01
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Artem Bityutskiy <dedekind1@gmail.com>, 
 Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Thomas Fourier <fourier.thomas@gmail.com>, stable@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

request_mem_region() returns a non-NULL pointer on success. The inverted
check rejects a successful reservation without releasing it, and proceeds
to map the NAND registers when the reservation actually failed.

Reject a NULL result so probe proceeds only after claiming the resource.

Fixes: b67a1a02d463 ("MTD: nand: make au1550nd.c a platform_driver")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/au1550nd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/au1550nd.c b/drivers/mtd/nand/raw/au1550nd.c
index f1e99197ab84..6796afe9cd29 100644
--- a/drivers/mtd/nand/raw/au1550nd.c
+++ b/drivers/mtd/nand/raw/au1550nd.c
@@ -276,7 +276,7 @@ static int au1550nd_probe(struct platform_device *pdev)
 		ret = -ENODEV;
 		goto out1;
 	}
-	if (request_mem_region(r->start, resource_size(r), "au1550-nand")) {
+	if (!request_mem_region(r->start, resource_size(r), "au1550-nand")) {
 		dev_err(&pdev->dev, "cannot claim NAND memory area\n");
 		ret = -ENOMEM;
 		goto out1;

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261107-submit-au1550nd-resource-claim-v1-71562f83dd01

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

