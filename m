Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177747;
	b=BCnXnug3Nk4jo5RRdZ3MUWVRZIIL79cDZMVPSVdL3RmEdyx87vdX5MiB45XkqYE0r/tT
	 7PpVUoriX6b3SO3YvhE5w0bHMiZbyZmeJrEJ5/ga3m0WbuuGfuwWIKMlVl6AN/N2Te/Dp
	 Z7BBoBbhXrNGpDOn0pQK/GbCEMxueSWoRFwDeC5RQ57ZOiEsow1wQuv138ISykry3MGwb
	 0tkoFLnfA6EdkPUXhYcGf4LRVSJsRBVfcXcSOfA9rrl5ZycDmaT8BrAapSHznurfnBR8e
	 z8hweMUVbVwte8Zg4LjGX9lYmqbWNIl0wAgU4Lacnxvaz4FqL/NsMWj5rgAyF0DXTjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=qzHeLZPhDy5sgZl2YeSaSSmwqxhMbI/xK+PxVybiOB4=;
	b=wPKP97SNk5j3rJzOsRvuArFzgV6DXxjJf8ZtwH4jnD4G4JXy0VItd5jd69aRIRw2S89M
	 bSzsDFfXVAaiwy5bBkReMDZrD8WIkbGUCV2hhSjv5aUAF80B6r+MG6JX+MWOTqPqCowj4
	 7/W0pj1gQTPtiN8AwyKjPs90rrNyEmXDte8b+30d4bhhZG7E87yLaz6hENv2U8TGA3Rwx
	 eUQlApBLiXG2OsYbmbGt9sNDDfTX54Pz1Ty+46DEMX31Ay8aID7SWYEmxkCz8i05aqqGg
	 i0fG3kWJNktA+SeDBE6zz/fXCHJqALGcvKPyrNZW6tVRIfA2NhLvg8Cpx9PWaF1n8DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hlj0fTXC;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A333606D826
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A333606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hlj0fTXC
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b28d9537bcso210397b6e.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177746; x=1794782546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzHeLZPhDy5sgZl2YeSaSSmwqxhMbI/xK+PxVybiOB4=;
        b=Hlj0fTXCxV8yCmwJu4LjUB0Vf44qEZjv9f6NNP1IhwPrABj9WbrtEtvAgukZfSHY+w
         f5HN7SmaIRAD0bhEdfqrkxdhUi19dq8j684KV/LQfC7iix3CTY6KWixYQIGNXh8HEHRe
         j4P0KG8khsAveciJJb04vvPBlrdLxW+9kTQngCnNjb5Xqn70S9WMgb+q1zGlERTiRZ2+
         ua4AqZh1SCdJuFn2MupfyXvdW07UlJv8gm+5KyxXYUned/btGRK/S6xof4qsbIgsKuz0
         D/bjSfK4bYjoJ5kx7kdLI9NBtsWsvxeuCI10TBcklcce+M0iztRb1v9zbD8duP1JdPc9
         CelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177746; x=1794782546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzHeLZPhDy5sgZl2YeSaSSmwqxhMbI/xK+PxVybiOB4=;
        b=YkVLMeMl62Hom+jpVF4UdnFev3KGEFbE7jiWyGS8KM3UaqCJb8fiWDQuRJc9pI2tC/
         GTyYcn2WzCDEyOND242ntk1XVyn1uyiwggokTkLE2CnIY+S9tWwg60VldXKKlhNxmcGL
         boknRXq/YZrQ5e5H4K4a7seetYBKWPcdQSaZUxmCtINu3ZhaeWPPDwa1201u8e9NqUig
         gsTE0BRRc5xACMHBS7ujrK3nk117kBAYRL3vaJGc9EamtA3GYwqFtqo/oIiD6ydxLhRd
         t9DxWrdq2aIK/6OwZ2GrM7wFoq0YPdIGGNbHxwvJ75NC6jziH37jfzuwZxCQb/CDqArb
         EpLg==
X-Forwarded-Encrypted: i=1; AL+hErGWCEYPXN0opDMXEk4WCFqdMZv6aqRIhLRg9dTEMg2MJPraIJlTjzQR7Lrco2ntlwZKQjljJAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tozMzq/QigfQFedxuLaNtfg3RLppKvtmEQ0lyvktxVI/07rp4
	Bows4jIvy5Yx7ho0dhshEya58dHaIH5dRFwnO6dIcz/sLM1d+kb4FgFH
X-Gm-Gg: AYBFou3iSKG8AbRcA4Om24hHHdus6/KYVZZXxejB0ETOdMxxgPiHvzbGITr2uefYvNo
	ad2SXfSWbvOg71JVLuyjee5WDgJCIHpjUsPBY69TqK6rFSneATnDvCCBuzAz/SotcyqiNkZOREm
	PZjf7pYF6SwOncJ2d0WeH62UoRPhsQKqjMLhIc4sTzKrFB5R7QAwgOVrctf+WHdmignVJpvOwcN
	SC5FUAHHcEMGR9Wmtb+WBvs/RSErhWWaqq5jtW92Q6YPLhGjcQz2OOlD1DdZQfk4Oag35pbkiXE
	VNAZYsSx6Ky0Yv9YCBpnfzE+RusQTEHe/kcw5+bMpBDn6id8QUUz9niI4HLuMYIT4tBd1HpfIx6
	s0LcXR4oAkTg1COZN8DJoMRassEN6ZkTOdTEJR1Vt4xXSBZWQe8hjNZsOoe5VVaB3ywb/CSjd82
	OPzBnAXbsmVZkR///JNwovxrrX6dhxToDtnzN6za0D97a9YQyPQPjfmQ8O0KR3OIg4qHw7oGDZN
	oL2GZ1eiinOK8JDJFyWYxxhmKKuthRr1ts+riFcPn0uIm3L6yi83HcCk1B9drMWwgsL24gMNBa1
	4RpIUN1xMPFFUTgI/GD/7ntuSt8/4qwUE2VNidTwJev1t1467V6MrdB1zjh/nM1Robhm7fQYsi5
	PGTv+3sldrKvOx8ZF1KWIIzHOg+CCBX+6RKQN4DeZWc9dlbwmCDgBrnvGckzRAjOL/l9j/ibtAK
	y1gwDREB3XwxeFZw/rJQr5A7u9aa/u028O11AXuDZUK+Oq8hPCsoR8
X-Received: by 2002:a05:6808:181d:b0:53f:b2f9:1220 with SMTP id 5614622812f47-568144741edmr1029934b6e.5.1794177746301;
        Sun, 08 Nov 2026 14:42:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54e39sm2859944b6e.15.2026.11.08.14.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:42:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:42:11 -0700
Subject: [PATCH v2 4/4] mtd: rawnand: qcom: scan all chips before
 registering MTD devices
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
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-4-4a8704cbf7b4@gmail.com>
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

Each NAND child is registered before the next child is scanned. Once a
chip is published, its MTD operations can run concurrently with the next
nand_scan(), which does not hold the controller lock. Both paths use
controller-wide command buffers, and attaching another chip can replace
the BAM transaction underneath an active transfer.

Initialize and scan every child before registering any MTD devices. Track
which chips have been registered so probe failure unregisters only those
devices while cleaning up every successfully scanned chip.

Fixes: 6a3cec64f18c ("mtd: rawnand: qcom: convert driver to nand_scan()")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/sashiko-outbox-204074@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 14bb7f3d6c36..978fa84f051d 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -89,6 +89,7 @@ struct qcom_op {
  * @use_ecc:			request the controller to use ECC for the
  *				upcoming read/write
  * @bch_enabled:		flag to tell whether BCH ECC mode is used
+ * @registered:		whether the MTD device has been registered
  */
 struct qcom_nand_host {
 	struct qcom_nand_boot_partition *boot_partitions;
@@ -118,6 +119,7 @@ struct qcom_nand_host {
 	bool codeword_fixup;
 	bool use_ecc;
 	bool bch_enabled;
+	bool registered;
 };
 
 static struct qcom_nand_host *to_qcom_nand_host(struct nand_chip *chip)
@@ -2008,9 +2010,9 @@ static int qcom_nand_host_parse_boot_partitions(struct qcom_nand_controller *nan
 	return 0;
 }
 
-static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
-					    struct qcom_nand_host *host,
-					    struct device_node *dn)
+static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
+			       struct qcom_nand_host *host,
+			       struct device_node *dn)
 {
 	struct nand_chip *chip = &host->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -2059,10 +2061,6 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 			goto err;
 	}
 
-	ret = mtd_device_parse_register(mtd, probes, NULL, NULL, 0);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
@@ -2082,7 +2080,7 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
 		if (!host)
 			return -ENOMEM;
 
-		ret = qcom_nand_host_init_and_register(nandc, host, child);
+		ret = qcom_nand_host_init(nandc, host, child);
 		if (ret) {
 			devm_kfree(dev, host);
 			return ret;
@@ -2091,6 +2089,14 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
 		list_add_tail(&host->node, &nandc->host_list);
 	}
 
+	list_for_each_entry(host, &nandc->host_list, node) {
+		ret = mtd_device_parse_register(nand_to_mtd(&host->chip),
+						probes, NULL, NULL, 0);
+		if (ret)
+			return ret;
+		host->registered = true;
+	}
+
 	return ret;
 }
 
@@ -2100,8 +2106,10 @@ static void qcom_nandc_cleanup_chips(struct qcom_nand_controller *nandc)
 	int ret;
 
 	list_for_each_entry_safe(host, tmp, &nandc->host_list, node) {
-		ret = mtd_device_unregister(nand_to_mtd(&host->chip));
-		WARN_ON(ret);
+		if (host->registered) {
+			ret = mtd_device_unregister(nand_to_mtd(&host->chip));
+			WARN_ON(ret);
+		}
 		nand_cleanup(&host->chip);
 		list_del(&host->node);
 	}

-- 
2.53.0

