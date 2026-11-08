Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172603;
	b=apkcgCinB8Q53N91OIrL+zqQgVHpNKIwnUKLJSL2Cs/zJpi3ePBhLfbfvfAPivLP14G2
	 eKIfPWpr9BL/5mhvkNwhx4yTfTUX1cLHUTBGbR56+vLLu+Fr/zYzgwcORpbK46tO1GMfj
	 ewOXJggWvoZ/dw+fudz6kDtLvgAJdGIcV5Tb9R0qfxe3WbHwQ0MdjrfDWucaQ9WJpzT+Y
	 Jz+lT0uoBUe/u+hITl0AHuo2zACLzpx7GGa84pVKJuZOSCx88lxb4z8icBp5COsSuuIho
	 PqEbYO5IRGr7Z1xG7hnOCp5kVnaFOogkxsBl7eDnihJcmODIsmT3EBvcdZov3o+R8Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=e1VqrTz+ewActBpDHlYQe8JX54F3teV+c5WCvWWuiYY=;
	b=yza8kYnvY0v+IKvk2mKtw4/C9q7bicZCDmQf5gBW4DDksC3H2K+6c2ge+L3Nf5ZqFtAY
	 cz4n8bHPQiarxlvHkqKNvpxQwkq7xYU+8TW+aru9fbz9mCe+FY/cztLgBxpy3tWfnRCgT
	 MQ4FLS4rznqv47lAn6vhoRHQDeBkTU7HRQfmNajLfBxHo+mF6T+q38jQi5SRU5/vzeYn8
	 h1bLx/ayHoMZ8OpxeS9uy0D14IYgUN/3aJCbXjqY+Gc88s9qYv7+ojZMhEkq90IeYuqcg
	 YNYvmhHPAEnuelqWHqM+nSotWpvzC5FJlVhXvPtSa5VA6FXi/u1ZMq9s1p26bA3H/wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bU7xrZPo;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA3606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49CA3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bU7xrZPo
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6df7f544919so140596eaf.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794172602; x=1794777402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e1VqrTz+ewActBpDHlYQe8JX54F3teV+c5WCvWWuiYY=;
        b=bU7xrZPocRyvtLJVOnoXh6L/jjLyxq00tlIIGhOgVA3WaAKC17vTodxlJPAt9hWJZ/
         QP9aBjG4hZWizdAZeDa7k+KUpFxwyrU1AK+T5N8QOmmdUmUHBpjetaD50TVGG7UHhDIQ
         nj0f5khFkvExeVTERE8LJ9uYXwGNrn5zkPVcSVsVyTUoP4eVdmkc8GzyayxHDp++uFiG
         Bx7ypym1TmnccE9DhF7ZVSWQIauxUwOcWMZSNt0dC2+F/oqgrQqYCdYvAOel1AW12tSf
         AsXzOCWOmmQNOoc4cfL2RU7qZgmSfiI3JU/pD62B06cpMOCCFE79a62D92eBS4YLAoCf
         OUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172602; x=1794777402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e1VqrTz+ewActBpDHlYQe8JX54F3teV+c5WCvWWuiYY=;
        b=YCv73or8C3Z5PygQ8SVTwGF/Ka+BKdKsFNt6on67jCphjFjvWnvugcq2nLWuPG+4z2
         n3PYRBXN/n9p2SFsxf5aVjJ4KszHQ6zRVOEN2rwTcWq/HjSK9sdBWvUIpBzFMQ9RlEe9
         o6XwieIQSCrhhT7EYjMr3so6rW5a2/Nc7gG8l8gCb2J36Tx0v8LpA5zXcApTeZNFKld0
         eX1H6I5KEWTX/RL7Ha68kiQtTdZ2qXoycFc9G7r3DRv+A1umV4oZe4bwASMxS00uJxHC
         ND7mtLxTaHjO08ZtaiNDSh8SVmtBHeOKEMyOkBAz63mAfRSN5w9G/jqXqYGR/OKstkAH
         U3tA==
X-Forwarded-Encrypted: i=1; AL+hErFt9NAmZAB1GRDD7N5iT37NnqLp/HhzTDenGAJlzEuhmnUfDok+PFlU7L2PUicAX842iAuYlWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eK8xIAyzrCqYFV2wQJWx4SfmqwBZtSuPSA6oFR57yI39+DUAk
	RpBwKTwzLGP2a3b/J7EcshQGzgnw5h3pUapA0yKvy8l0iOImdJjxC5H8
X-Gm-Gg: AYBFou1gwPhUdiKe0Zp7ekZO++joUUfKdGNmkB1RINsJSz5DwsFTCT/IZLXP7nrMT8X
	Rausj1HQgIl+5M/n+MMbWO+IT+v2LYStKGw4N3Ix8tnn/dAX9Uf0wkiJVxzw1hvckN8ZSiTQRGZ
	Kcr7pZaH4uh5MSIoJB5UTxmOxY8mHeEYWaNNW7nVBJfz8OsrN+M2kfhZqL9yR6gLTjB62xc609P
	wT1ACMVJHutsewb6KafBTweVUr8cl/N8MTMu5UTTTHqbL2RIbMlGoRyIAw9gAU5431Bnua4v3xD
	rUNAmWq5U3VSHMBSOP8n9N7T3SYlF2/vGFMHzrF92K2QwfBzyf5MuQwSq7pAmhZfBv/TW5tCBw+
	8jsBcKWmWMabRXeHqXOdG7jnq26+OyKFXXxEnUcmVEfHJYnk9XHrYujlvjkzYUDm1xidbuuu44x
	N9EHRnbOF5yHYIBzwcyXLglJSrL9pf/Vw033YYb6Y2bXP4/tWA2XcTWQfrhN1O1NxjzXPN9GOrw
	nTRbFfWovLjNVmKjrE0i6UP3Rkum+iqu/UvcqCt0xGa7kkKk5EzfTwqz+v5CF+tK/L2T8PLR+v1
	ZEkuOetsc2h7OjG1lNISf4ehoJ70Erg8EPvlaLdXzMvXIkQZf9W5nCGUnJkdOJ4+c2oaH3o7eLv
	UmLy2t7ipUJUjz8r4hOJeyZN7X3l6xUpS8qQsFlgOoo9CxlM9pbl/yt4qAu7pchwjGCgrinLMGe
	YlSKgOefEtJddM0BEoTMX22S5hZzTRQgCXNpv7wNAWrktyZIDBjXk=
X-Received: by 2002:a05:6820:83c7:10b0:715:2787:e1e3 with SMTP id 006d021491bc7-7170f2b53f2mr823230eaf.14.1794172602221;
        Sun, 08 Nov 2026 13:16:42 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8fbc55sm1896378eaf.12.2026.11.08.13.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:16:41 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:16:35 -0700
Subject: [PATCH 1/3] mtd: rawnand: qcom: parse boot partitions before
 registering MTD
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
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-1-509f30a9e14d@gmail.com>
References: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-0-509f30a9e14d@gmail.com>
In-Reply-To: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-0-509f30a9e14d@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

A boot-partition parsing error currently calls nand_cleanup() after the
MTD device has already been registered, leaving a published device backed
by freed chip resources. Registration can also invoke consumers before
the boot-partition layout is available.

Parse that layout after nand_scan() supplies the geometry but before
publishing the device. All failures then reach cleanup without leaving a
registered MTD behind.

Fixes: 862bdedd7f4b ("mtd: nand: raw: qcom_nandc: add support for unprotected spare data pages")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 2d98f79b492d..f240d1effa04 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2052,16 +2052,16 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 	if (ret)
 		return ret;
 
-	ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
-	if (ret)
-		goto err;
-
 	if (nandc->props->use_codeword_fixup) {
 		ret = qcom_nand_host_parse_boot_partitions(nandc, host, dn);
 		if (ret)
 			goto err;
 	}
 
+	ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
+	if (ret)
+		goto err;
+
 	return 0;
 
 err:

-- 
2.53.0

