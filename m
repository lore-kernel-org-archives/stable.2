Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177743;
	b=yTUmlRmyQd/pjOtbrmKEnZtJz4FSMU0yjUZZLThg3QOeqkVPsj8m3VQ0a5BYhkWCKvbh
	 tbU2810GN98AfXaRf4yr76wuwXoCyRwbDvCJGbuFtKhip1W/7yFwGJMsn4pqNTRyNzBaR
	 WVUyzoi2flxalO9ei+eEHmQNirEBW4t1BJj7tcYkw9P0NAGExDvvEpRgnQtvP6U7wQtCB
	 I9ufPv+08I/oYHut96gRXMVyKUVHrLUbb/8HilgfnnyMZjsd9of8//wbIifbe1cOl7rzC
	 JzC32RP1LQC7+mxZihB60KMjPQgHbuq1yq+e9zPghFsZnmq+GNTsB+MrXdzWUML3OHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=e1VqrTz+ewActBpDHlYQe8JX54F3teV+c5WCvWWuiYY=;
	b=JawejseNJuZkI8HC0kIwPmUVxVUZ1A8c/OAS7kbDFs9fBqsuYqF8/nYgpbEPWmfwad7e
	 HZ+SFqfEqzSuV2+3xddbLykXruLots1DAyyNk333P6c+5H5lrkwFSilne/II/IfX0CByf
	 oAdV/aPVJApr+GqJshtdUOZUD9ObDdoTwlij7tGWbe4KE3Hrd7rkiMoOLoN+e+U9ymcLT
	 golPK98ztTHmLNlXcMFDdOR29IdIuKirAr2PpH++VfmBTS5EeAk/Bj2Jn+pKEyw5r5vA9
	 2u2pTFfv9fEAeme++8nB6MT5GtDn3atSvNOGd5oqQKj+nQm4hLrxgcooWX4ISUyZ3xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIQVU5h2;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC9606A334
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DCC9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIQVU5h2
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4ed6d69bdfaso151618b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177742; x=1794782542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e1VqrTz+ewActBpDHlYQe8JX54F3teV+c5WCvWWuiYY=;
        b=VIQVU5h26tv3OKc7TWsATktTWmtgYJAbpgl/p8DcQdl8UEZ6AvTVJSni42N9dJo/lT
         DjZHWlI8NzZgqykUXGdy69BPtqWcHHwqwL+hsadvwI5FU7gchQY4iLM50zNnDXFI+Hgp
         jjfpWblv6FnJFfv9wnIg7Of+7QSbBjcrzUg2RCgGSKH3dJABG0tbM+EdVOYQXfqIrzrg
         Tm7ozyMPMvY1YsCKfbf6ZyJIxaXGoZw+eMKhqIwVOqC2Sj0rKY9yN8O7DKyUb7aZrpmU
         koGwC58ejA8Qm+zHrxT4sDSzMiFWybsT2ImwEsF3pDa5p19ENyJtQNnUOCr25GvUMmF7
         bGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177742; x=1794782542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e1VqrTz+ewActBpDHlYQe8JX54F3teV+c5WCvWWuiYY=;
        b=Xdpbtg12zyyAzgJIp9EkZpQFbVdSehOA/3RqjYTU/1ZTEFNa19/0TcKVCmqTh511K+
         zKzE7N7bLeRtMh0cwKw1YJI5AtLkLcHyMII+vjMSV6h4rkBp6yaYlbbb21o2SRsBsK9e
         0NWtDpHTylUU2nh5wVT7+XQN38xP5dZgRZJL6b8upLv3gyj/RJP006aaL7BxpO7BMN6u
         qQ6XdwTa5cP42Xequ/Qoj3KfoTDVckocq80G8jPVHBo60dwexq27oeyFn/NdMrgp5maH
         +RmGh3x9ef26RCpyGLGAUH1fUsfzLZeosrO5yIaPIQbKuy4n/oRNRwxfGj2M23Fx65D4
         tyYQ==
X-Forwarded-Encrypted: i=1; AL+hErHCqRVkq2npOwZN2Mvh0u0edTVCAtwu9VE1cVBhbxrCiEaJseE0a2N52sDlJh1lDkD7dNPwnAs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9B1r90nyYSLOmPnlD5mQJbxd0jUru0a3IgCWmXrUpX68T2+NBf
	19s4+Er5DjRNgMTEIHqlHLVQL9t30qMIHB61y3y6UyI2xWUUMlb52MZ3
X-Gm-Gg: AYBFou1i4mzpouj+Mln97hEmiy4WZRUGmfcKyf0jXTQTbqdoOLA5ALXt/yFzYnFOMho
	wXxxihfyUzqU2cAg7OOSlGbi19rDU/v0CsP7fXRmnVp1Q1mZfghkJWAI32GObvtCs/TQeMxLWTU
	mef5OJKt+rJEC9AqRRfElCiOMp4pi4ajSGrIv6uJYG6T9ByXcqmjWlL2cZq1d827ZAzDqczMA6M
	hQlZ8uNOPl7JbjTHiEP+P1rXAxvAtxDvOtKWBsWLD98eFQLdeYZOmmNKtDDPmdX+dC3J0P2aLhF
	BVhAxR45hPWvl4gTu7FmI46BA994xR/lbzJZeq+LTuuWjvjOzdJe+BF6/W5hN0UIaN6JLnZT4MP
	ZJGAnwlInfsb/tWki376oqwM3ycVCjiIiSmNGhzb6JEaQ+qo4y1W2jhkvNIWIEfedDT7qvgMvgp
	qmIYtDegCDmMg685xd6GQypqP0Wc5Vs4EFWVryJgpgL7rMVi5dH3F4trAkijIxvzLjjr4IyvhFO
	SWoXgu+/oLymHLHxc+ezuA8FhiBXE9ZqRg8jaIX6lXxZPdLpXL3aw8zMqe8muu1y9ySYSzm/d4l
	zs23wjJeACEIWMsAsk1JwsHLPuys67o8j2hA+vrMLPypA9Au3KP5X5w+0N8B73CQYwFtBFPZWlV
	ryLN0KMHIyp8PnPQhMDgpnoRRWMvC6cJY+ZjTJ8Jz2wHX3CG6+Vnspna5JJ1fNU1e+q1TPwBLLL
	ewrp9i3q0w4HnGt0yZyw6jXOdpx7y2FMsmvMU8vzTElPGseBm+VY3b8WVC1rlmkG47AKJ8x5/xE
	Q==
X-Received: by 2002:a05:6808:1514:b0:4c1:5614:acab with SMTP id 5614622812f47-568143a9715mr1370591b6e.37.1794177742300;
        Sun, 08 Nov 2026 14:42:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54e39sm2859944b6e.15.2026.11.08.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:42:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:42:08 -0700
Subject: [PATCH v2 1/4] mtd: rawnand: qcom: parse boot partitions before
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
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-1-4a8704cbf7b4@gmail.com>
References: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-0-4a8704cbf7b4@gmail.com>
In-Reply-To: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-0-4a8704cbf7b4@gmail.com>
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

