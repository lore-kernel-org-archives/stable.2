Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178103;
	b=UbDQ5Yxi41tLfLGVezW/mBMf2fizXDN1TgOGlqTJJpimIjo3G2arr3qycvSb1QeDqgwM
	 zOmqHlhbS2Vn4pRhzCLLyiuspkoS4WDXFhgdbjnctHKYbeaUUyhK8JvgGd0P+vO1s9mp6
	 F1Xyl+GoL1xsz5MuBxzHmu2WbXKTjPfej7DFEGpcbUUhEHPceW5TmKQwFP9qC+J/T8n86
	 JxkLrbmkNMvhdSOsA41GkcAUilBr1Maxlk0ETocN2SofPZO2/w3v/0oHGAADQcNOyoFFF
	 FCKjOf/NnXnBMwJvIiXJKpTAP+c9VOoMhv2hKqzpMWxwYexPUbJXVHKX+xFobvSyrww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=uofTIzhW5+iZlj90wLZvR6NRcqUfnbP/7W7Hv/CMg7M=;
	b=J2TvbdJNcJ/uXsAwDztIOPRLM3wlopxc/Rbl9MS6uZutjBW5B481kCYIaqKCqfVvqDf8
	 KQvSZJvO0xn+Gy09r5sPneImL8WewiRJ/ME6ryVanO6nIX9hwL592Wdg3fXRk/bUcnqqa
	 ZaoG3xO+m6tw3ufTWlppS02BECd1HOxmY3+N5ElbwvuNeW7EElFWNgusNR98MFMMfJYFI
	 j8wzWio41diNLLnHoBt0dkPCMP6fFUbaebQkqE7WYzV5U+LE9FUymWfO7E5S4GccrtBK3
	 +eEjZ69ksu5qxL+xSJ03OpdQhgYoh9JuR9t1SwcdHPxeQk0dgbfIpTAwSNnjOyfdBnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xVn9jfRU;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DE606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A36DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xVn9jfRU
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4f699fe49b3so237568b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794178101; x=1794782901; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uofTIzhW5+iZlj90wLZvR6NRcqUfnbP/7W7Hv/CMg7M=;
        b=xVn9jfRUIPFn/4JrB5FsmdWFoBxu6dJB1Nr4e/2/Z6eN6QS2nFrlEgHef9JpLYl60v
         tAwaHp3Fwm+NwwjFDcX9ObQE0Nsjaq9J7tFcqgtkgVEVQK44jsLmQj23SwtCi7N9ZlcU
         0Uetvkan7UZxOHzwGsiXdhjB4QaGIpZcAwasy4QA1T2ruhB7pcFHD4TcopmlH3PJfpyC
         NrbyWwdPDR0xQcUHYfua/Ohn+5V7OhoFCtMCT4slOjD1vu+Mu8w1O4VhWUpxMuHjPtei
         5C7UfH2G/vVmH7B+w6TDfQK8irnSKubLQzdtDbdj6nrYJwN36I2FeyrHPP3tU9RcpzCw
         I02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794178101; x=1794782901;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uofTIzhW5+iZlj90wLZvR6NRcqUfnbP/7W7Hv/CMg7M=;
        b=wdD4g5L3aLTXPbuuxF4PpAs85YMi73DhyTIeNwoer2DPh9ZybV7jUwoaPQhaHhFL6d
         2ShUKXN4Pl/Xp6lkjDQSHB6/EkCLApXTIVooR3hlc4+akdwujKnXJwY5kgNYzG6q4nDZ
         sTohC0ovR4KqyemFhykUQyjdPdq6z9CTcX4nhFjmYnkmPUL9WX2Gtt9ewaUnq0yucUDr
         hoMPx2EY5/bhF5u7CW7nK4b8D8ILfurrlbBaW4gKPPQcTFxm2F7nDe3xaLJvYqdFDmEA
         /WlofLxDWOevpLxJJBejfdPlVC1iu6Nd28bMxbJji/ikEsP6mCztvaSo8b3kJMzKeqKB
         PWbA==
X-Forwarded-Encrypted: i=1; AL+hErEMexXNmFi6yDhwJUyg+tQsnBJqkSYctggLwZoP3w4RISJpbHXkmtO7nXw1LVLCCLumQiVYPfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZcEyCJgu8JzvcHXW9iKGGOKXvGeDULEPJ9WL8jj78nH8Q2jBy
	ccRCds73oAoaudxo/MCOtSw9IwWM5K7NSbyTJzeuQvX9diFb+NFaK0oYbQybXQ==
X-Gm-Gg: AYBFou13nI0ZkhQBVaDZGlXn33ddYYHX5RP/jMWPukYqAhNwSjyiD2af/HQJQBsfTZg
	W9WAPSfvCw5jeoGH2PD/QTluwKa6JpGIYiUiK+Cr1Y2W91ZjBI69tcAWAxRJ4ByrLx6BXf5S36h
	XhLmFH12qf8Uq2Vrk7+A6jTtvY4+mTC2vm33Mb//FMs4IOt3CwfW07S/HTnz1hsGZhuCuT7Q5t4
	EsEQIiQPspIYr7AMp+KzSAfe+bhCAfWeeo9FDJUpIXB6VmVp0NMYoMB2QdQHCJNK5ZHRamuQVCZ
	FVjcEWLEy9mBlqG3F0XHn9ft4Zq8rtAK0YUMwoezEKcXrEvT8mSAZ8X7a+PktnvP68arMFSIemi
	Vb639wANyR7MI/S1Mj2KFJde4R0h6sVEnm9Pv/kvKab2nWtQNaoMCGNhD6IJDS+S6S7tPxFCP7O
	ExnJqkj8qssjo8Ld3+wvty28VAT3g7scZ5iGA96EvK3UNi4+h7FK6JUNfIZYEYraMlUsYG088cQ
	TqF+Rel81lRovJdeSvE+KxezG01lNHNxj6yCbaSP09tRAn53hhf2R1vxCJZLLnHB+WtBYV2uxTr
	Cy4dAE+WvDVFgVZf5xSmUPsP49gZcTMZBGg2JSPH1PfdUVxGs5ixKp/52YTNNnukrppjeA7KZb8
	qhx1oZFkSG2DJrb1qAQZVnmL5kc28qooSCQlxGvJ+ZHOq6HnSdoOdJbGfPJpazyLWzo9vBr+SvS
	QST/PRpKRDOCZInFRtu9J07V707tnhvK/ciJsj/lOPjo4IDti9DRtD
X-Received: by 2002:a05:6808:1302:b0:4fb:ac9b:b06a with SMTP id 5614622812f47-568143e3ef4mr1605617b6e.48.1794178101544;
        Sun, 08 Nov 2026 14:48:21 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e010cfsm2738303b6e.14.2026.11.08.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:48:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:48:16 -0700
Subject: [PATCH v2] mtd: retain the partition node reference across device
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
Message-Id: <20261108-submit-mtd-partition-node-reference-v1-v2-1-73e93921db68@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/41OSw6CMBC9CunaUcpPceU9jIvSDjBGimkr0RDu7
 hTi3mRm8ebN+8zCoyP04pzMwuFEnkbLINslQvfKdghkGIsszSop0yP4VzNQgCEYeCoXKLAA7Gg
 QHLbo0GqESUJdo241Fk1eSsFmT2bpvQZdbxtmpzvqEN3jR6M8QuOU1X08ccAh7qZivicfRvdZm
 04y+vxKnf4txSNBmTzNy7qsalNcukHRY6/HQdyWZfkCAh9vUw4BAAA=
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

Fixes: 5ab9bbf6c678 ("mtd: Fix possible refcounting issue when going through partition nodes")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Correct the Fixes tag to identify the commit that dropped the
  partition-node reference before registration.
- Link to v1: https://patch.msgid.link/20261108-submit-mtd-partition-node-reference-v1-v1-1-ad30359569d4@gmail.com

To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
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

