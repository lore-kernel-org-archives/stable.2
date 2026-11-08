Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172255;
	b=IGWNSMG8NVQ5TNU/OPhkcXivnVppsRPCVqMGLvugCenT+LmhQ2QiwBGycKrdEPex3BJs
	 OPrnIcdDGSIhgLHTxtoWo+B9eWfbcP8WypH6sBtKRGEW87Hg0lRG9iKuwFtdkhV3wZgbX
	 jUlBFIKPdciZVOLD9FoKgjtTRwyl7yCW5lZs5d/vhz1ES2s+BY/pTk7M0S5zWSx/UDeEh
	 8/ooRkouwv3UFtiEhA1VDdnd5mehXy/7OKIL4iP+FqxFldSBeRQAY3WQv2aeok9+xBpX/
	 rUf30nTEWkEbtSqrWV4RmPpAFdhUxgP/CdtvVQJq38dLWyELeskEDSZcv8P+DB1eyHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=OXxfToL8LXg6Oh0k9HdrHfUTYtCfhx6snQVUGjyIGDI=;
	b=OYvHEGNaW+1YKp50qNTm98b8IiUv/MwW4KwYD6AY+/r6WnJtVCVs27JtFMQUU6olI77i
	 +AhZFNTnW5oSbZHnGYthVBZITt0ngKor55wjokpQ9NELlOC+OafBsBnfmEv4y2UEogNdG
	 sHepsMHQd+l9Wn2rW15XnZroFFziZAUOBkIVR6qRiZ1hxuzJ+OaTEFSVKHKflvz0fCFDJ
	 Ro1Q5Pewd9Re0bdyCuFiOLs7OvX8BmufclxDQd5b2YUzXII8g7kyEFhEuHxp4RAQaIh1j
	 e9hg1Ob/TFdEQyhntnprq9FdC7ZmECuQb4VBSt8etK//wP8R+CE0hncco3hHT2ogsZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dk3SsZOI;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C9606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65C9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dk3SsZOI
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-55e0090c580so89900b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794172253; x=1794777053; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OXxfToL8LXg6Oh0k9HdrHfUTYtCfhx6snQVUGjyIGDI=;
        b=Dk3SsZOIKs85kg7d95K5QD4UU43ip88qGA899d0e76NpFoeDCB/mHslKC7uKiWFoYZ
         BtHy91XJboCO9PQ+umLx0xOK38sxxf9fYH9Q7DdoGENv5rHPea31zoeSvZkFUMDwVJts
         eqwM6PJjojTRFNv6ZcKKusqUvAjeJdhzWrNylmWOXaL9iZIXbix0lWDzjx/EEZ0EYMH1
         8DoRgZxVa5sxEYpZ32/zmRD0h1ELN7Zrtksi46R8qxiFAYQmEjV2KQb9iSmYINfoW3V8
         E+JWEvKB1RxKVCdxvLLJbAUtR9PEYWKBz2EMedle6M3PWUtm1J+7fNKLh+obsBBO6m3G
         Ag/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172253; x=1794777053;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OXxfToL8LXg6Oh0k9HdrHfUTYtCfhx6snQVUGjyIGDI=;
        b=XBlKX0fai7oAlGcZPFTkUkhvO5wHnhzGJg4LdNF2oXt5CEnd+mcLGEPPjwRX5i2htw
         KV97VV1Lc8ViqdLyX4s1VbdkZjKR8BPO5YBbj86rX9vWRmLz4jPIycuGiQ+MJHRtJ14m
         zHGTVIqYs5qS3SiF5CiifIYL9nIfS7khiRmyCWvvPQhreFeR98waM/B+yTLgQIvnQIhP
         p16MHsyXovKPK117io+WEbpbdOZGK6WNUC81XyZzOgyTAvPqtYJ+EZkCdz4Pjbqae5Xc
         nt9wI/AnSmRrHXFh0CXIyTIyUmm8sp1fUOSPL+gGVjBRkJaCMvBRKzM4iHPoqZmLEFuZ
         8lMg==
X-Forwarded-Encrypted: i=1; AL+hErGCdsoWNLGrFQX5V6g9JzdkFvsst9Teq8FcHTCDf0s2mMH6PCNHr3nLr7j+5CN36OI+L0ZFe/c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bYMje7i4yfqryRcWfui/lWWKPFLUx6pBfGTOG2UQoYkGE3kbG
	so5NssV7vRIG0HLr2Y3ALykjnHkPU0sZ6gwuSZVYO0t2mb9S4BCm8c20
X-Gm-Gg: AYBFou2ZkR+e0SXiMwWODxH0E8BHKgcRwnAqBQ/m3GXHUAqHN32uhvzM+jG/cdzWHz2
	aN2rzCt8nTMCkXuvv13plzJgX3V8Q2jdU6W725ns5QAFDAuEQYIHjqdNY5gYj19Qxj5Q8eHT+fv
	5EX1V6V0akCg8Qvhw1J5lW8nMSULVaR09AqQ1myUZLSwod4ahUSgCRjyKj//GnlCiVM2VOL9eFe
	f8WJu9hoCPzRfNiKOmJWNvFmMvPIe0y/e1VMQvOkqgmoVGu9LBAWJJa6RgPTzCIciF8nkTH6OUK
	6u2T64LOwY6Rjh2NQcEb8kePb9GpELuJnFWd6WFiJL5/fFsshgS1982oylm1TRFYwORza4TBwsn
	khPnA+k9zjWQSvUd2+PLl7RJyYHsE0ryvJaT1es9Maex1HIp+nZkEQxr+1U9YvkZXHf0A6IXXY/
	fWIAbhImr4WWqfPYo4rj9hwu7A9u4kVX5HCS6L4olc6wuhgihpahkCgN8ZZlmWeFu3hV8HPXDlp
	ewEzkCfAOREKWGySbXtWKyG5dbr8ymLaVg8vvp19ql6ArLFjS2NDNgAfr/woia0x2uEgHY9XhUj
	m1HmiCBNpron9MeLEl78PglLNPhi1jbSA1k7b/3a6watdotpdqfYfAVWceVdtmVfV0lVmJJ0eoF
	+uq0N1sCfmL5Z1mC1vIAuwauV+p2Z+LBtYh6bPhK37iLythPoAVkWKx/xyRVD9lWux2EXqoijaZ
	Q2eJLbcYMUVcTqsGsZ3EU6vT94K7QkhkA27ToOtoiXAQPYCd4K/fTMq7zcxzRvtOjT7NsmVzE+
X-Received: by 2002:a05:6808:f13:b0:567:cbf5:bb96 with SMTP id 5614622812f47-568147067d9mr1423302b6e.44.1794172253510;
        Sun, 08 Nov 2026 13:10:53 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813db1b41sm2618100b6e.8.2026.11.08.13.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:10:53 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:10:40 -0700
Subject: [PATCH] mtd: retain the partition node reference across device
 registration
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
Message-Id: <20261108-submit-mtd-partition-node-reference-v1-v1-1-ad30359569d4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw6DMAxEr4KyrlVCf6JXqbpIwlBciYCcFFVC3
 L1OWXjxbM+b1SQII5l7tRrBwomnqGAPlQmDiy8Qd8qmqZurtfWN0sePnGnMHc1OMmcNUJw6kKC
 HIAbQYqltEfqAsz9drFHZrFf+/osez53V9EbIxV4+vEsgLy6Goay04FhmT23bD0+Pr+eqAAAA
X-Change-ID: 20261107-submit-mtd-partition-node-reference-v1-99ecfce4b351
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

mtd_check_of_node() obtains a child node reference while looking up a
partition, stores the node in the MTD device, and drops the reference.
add_mtd_device() only takes its own reference after the helper returns.
A concurrent dynamic DT removal can release the node in that gap.

Return a referenced node from the lookup helper and transfer that reference
to the MTD device. For an already supplied node, acquire the reference in
the same helper. The existing registration unwind and device release paths
remain responsible for putting it.

Fixes: ad9b10d1eaad ("mtd: core: introduce of support for dynamic partitions")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdcore.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 491a27d0315f..f7fa895ede35 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -636,7 +636,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	return 0;
 }
 
-static void mtd_check_of_node(struct mtd_info *mtd)
+static struct device_node *mtd_find_of_node(struct mtd_info *mtd)
 {
 	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
 	const char *pname, *prefix = "partition-";
@@ -644,14 +644,14 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 
 	/* Check if MTD already has a device node */
 	if (mtd_get_of_node(mtd))
-		return;
+		return of_node_get(mtd_get_of_node(mtd));
 
 	if (!mtd_is_partition(mtd))
-		return;
+		return NULL;
 
 	parent_dn = of_node_get(mtd_get_of_node(mtd->parent));
 	if (!parent_dn)
-		return;
+		return NULL;
 
 	if (mtd_is_partition(mtd->parent))
 		partitions = of_node_get(parent_dn);
@@ -679,16 +679,14 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 
 		plen = strlen(pname) - offset;
 		if (plen == mtd_name_len &&
-		    !strncmp(mtd->name, pname + offset, plen)) {
-			mtd_set_of_node(mtd, mtd_dn);
-			of_node_put(mtd_dn);
+		    !strncmp(mtd->name, pname + offset, plen))
 			break;
-		}
 	}
 
 	of_node_put(partitions);
 exit_parent:
 	of_node_put(parent_dn);
+	return mtd_dn;
 }
 
 /**
@@ -805,8 +803,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	if (error)
 		goto fail_devname;
 	dev_set_drvdata(&mtd->dev, mtd);
-	mtd_check_of_node(mtd);
-	of_node_get(mtd_get_of_node(mtd));
+	mtd_set_of_node(mtd, mtd_find_of_node(mtd));
 	error = device_register(&mtd->dev);
 	if (error)
 		goto fail_added;

---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261107-submit-mtd-partition-node-reference-v1-99ecfce4b351

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

