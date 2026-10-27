Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097884;
	b=Iv7Z8vN6HFfAMi3cPy0wCCnVwAJURv6KjooBFHmhdmemS4Hbnn+6qPGJfzeSI2/hH4n7
	 2Zl4YEizifjlgHKACMb42twcoFcDdy0W/TkzFAzAQrCrCWy3pteb78i820G87ApPist2j
	 FU9GhSvUDaFyy8qdC/essjse8Rtd3Zm/csxJ1W5dgVKylV9u4Mxy400gmx1Jk+Vpq62s9
	 3SPbFZqUeBwgC1KcmH/f0oFakQbzLC6vEUUS4h5gQdmzs2JJN3nes9kdGBkji25HkFd4R
	 x7TiHKdQBZ95sIs9Ur/MJxNFYPXQ7Mmkb09qj21fs4q5RcxLB2W8NljbwgurLs+KmIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8S+4Ca6+ZW0dJ/5s+MHcKgmRM457g71lb2YWMXhZ5MA=;
	b=tr1qY0TX1qpEwtsBr7j8l+E50g3M7jq5NjV9wvpC++d7RT7mLIIb34IIrwmGQfiT50Tq
	 t7+s9+EGvj5b2q+VpgjlqGQa/izlZUQ9+ZtfY7qaqPQowmNX/eLgDk+R0T7uvTygEwhyL
	 nt7Ygj5rdZTief0Zz1lyl+vtfSpJXTfTTVVbr51YVFKl9BkEehR8j1b06096bAyFetdKF
	 u1X2sXNw6RnjaTxpVRRzRcyA+lEq0MZ/VnRaWdz22xuA3XbPY43gOtg+IRRoxXUfz0n6t
	 RcFunUNr45d4DRACGm8ryH++blS50SyRXI4VSMCPF59MlF5/T9GsgxnkRyPxEdvIGDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jj75lsKv;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084560A260A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3084560A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jj75lsKv
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535a54bed9so6130558eec.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793097883; x=1793702683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8S+4Ca6+ZW0dJ/5s+MHcKgmRM457g71lb2YWMXhZ5MA=;
        b=jj75lsKvrp/82SYp8I910Zvhw1BiUzMi4/aySvDv7UKE5qE6p72n12Q2bCCt5lwfei
         kEi7ttXSmxq+BXiEbdPnEVEv6PtZwORshp7mFbBIIBg+DN8O4PvlyJrJN0kidjqAYqZG
         vVXycfaUYl2K5V08lvSSYkSf6ldSJ6TVBnnWcAylJO2ouSCpj96/v+7Eb57sLdQpEXzb
         QyRrBI0PeU2YxBElYp3BXy1sc5SvY6IbB6chH68mfcjMimJOrlUhg9MIpm2r9d1nY3jG
         Y1PNk5AEfxkJOdesREog/pc4d2fjTZhk6VZF59zTXPM1qyt/x+p4R7e8AUfThF2AlGsn
         S3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793097883; x=1793702683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8S+4Ca6+ZW0dJ/5s+MHcKgmRM457g71lb2YWMXhZ5MA=;
        b=UrqYjHmdnFNdk4P8NDCua+r2JvXeCk5rDZ2D33kyJ6j+j2bM8hBZnhaY6ufc+CkSeF
         qvt5cnDqwavWWkV4eRGxhj9G9iORkeaJsaHBgFKRGaCe4MzuF3vulqoebgU9krCfIzuN
         g9SPBtJUaqCq1VYs1YcXnmqRaciNj2H3GAdSExaE/B73BYTdZhXP3kcvxBzpDwlxcOLo
         7ASWa0Qi3c/juLhwyUjcaGDSfNzfuYn4YqWmoTzlXb9Ti9/Mr134WzGnACfr8ZxAeRPb
         9n+KIrfFertvR45cWFd1GPiIBhEl3wW/+ZmzrDbrHf/BDRVHJLzHitYKYsdrjKG67j1J
         Glvg==
X-Forwarded-Encrypted: i=1; AKwUvBy6yIR23aKMAKNkwlIebRZ/SZdIXmluWx1tfLQ0jodS7uR1VNj23T80PWoojX5xFavyMiG+U9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7jVYv+NNBwmqIQGGHlfSsyTqpYeZvEnt3m/SeynXlLZkV/X4G
	SICxnidvYofe0o2PZzx+ghW2RylV7ggzYxosq306dUCXqNkX5PjkhhwR
X-Gm-Gg: AYBFou2CGKLsrSu9sU/AZUPj+LTzpnPM430lcu0mgcTEJvL0CI9yomnTiNJ8iR6LTZV
	DDiAG6ZOcrJCOOHWlFG5AjAo2zSIyqEI3wTAiWTKv/uItoF94/KTwlQVpcZhw3HdrAWFQhFkyKh
	ckfiwGuJztRpLlaZXBxQ5bfxwuqRpX2r/jlkC4G1NGup+c4FuA584M2+Cqy1DFckWmCnCb+Wosn
	n+7o2dBVLIEAeDBaAm/CGto4jluuJXydJOhmqbmp5OeMO9pQcTfhl19L/V6yAX+umTnj+gc9vlJ
	VUO0TVykVRSdbAPxzC+cNPUWEYB4k2rdDDsd35kxYkYkXHE4SHe8CVOQOivBeWgA8eDmUngdRvQ
	0e5DnyO1L5Uh+WfGrswhPGPY/t/pGTASCIvrfq2iwURn8sFaTRWGijuty6ya6A5qxpsyRncxuM0
	j+swvQvkedEe3vlKtleh2tCX5sg4jJD1e9vwf4owUhBsZSLcK852+ev7YBHNjSgfpfT60lIMx0F
	fshS4228MANFw7NkaW37f9Hmya5u56jhP7aD3J07RI20eASOwW1kuZi+rlSA6l3T4vV7wSv1Ex8
	4IbU7cy4
X-Received: by 2002:a05:7301:1828:b0:369:f9c4:1fda with SMTP id 5a478bee46e88-369f9c42405mr10913555eec.27.1793097883083;
        Tue, 27 Oct 2026 03:44:43 -0700 (PDT)
Received: from Zoro.lan ([2409:4090:2022:b00e:72eb:d31b:8aa6:1b54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f27d5bf8sm31955745eec.4.2026.10.27.03.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:44:42 -0700 (PDT)
From: Vishal Satle <vishalsatleit24@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vishal Satle <vishalsatleit24@gmail.com>
Subject: [PATCH] mtd: virt_concat: Fix device_node reference leaks in mtd_virt_concat_create_item()
Date: Tue, 27 Oct 2026 16:13:45 +0530
Message-ID: <20261027104345.172612-1-vishalsatleit24@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mtd_virt_concat_create_item(), several device_node reference count leaks
and lifecycle bugs exist:

1. of_parse_phandle() returns a device_node with its refcount incremented.
   The validation loop calls mtd_is_part_concat() directly on the returned
   pointer without releasing it, leaking the node reference on every
   iteration and on early return.

2. item->nodes[0] is assigned directly from parts without acquiring a
   reference via of_node_get(). However, mtd_virt_concat_destroy_items()
   and mtd_virt_concat_destroy() call of_node_put() on all item->nodes,
   and mtd_virt_concat_node_create() drops its own reference on parts in
   the next iteration of of_find_node_with_property(), leading to an
   underflow / premature release of parts.

3. If kzalloc_flex() fails for concat, the error path frees item without
   releasing the acquired references in item->nodes[0..count-1].

Fix these issues by releasing next after mtd_is_part_concat() in the
validation loop, taking a reference with of_node_get() when assigning
item->nodes[0], and releasing all acquired node references if concat
allocation fails.

Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>
---
 drivers/mtd/mtd_virt_concat.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 40b300021..6abc88251 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -163,7 +163,11 @@ static int mtd_virt_concat_create_item(struct device_node *parts,
 	int i;
 
 	for (i = 0; i < (count - 1); i++) {
-		if (mtd_is_part_concat(of_parse_phandle(parts, CONCAT_PROP, i)))
+		struct device_node *next = of_parse_phandle(parts, CONCAT_PROP, i);
+		bool is_concat = mtd_is_part_concat(next);
+
+		of_node_put(next);
+		if (is_concat)
 			return 0;
 	}
 
@@ -178,13 +182,15 @@ static int mtd_virt_concat_create_item(struct device_node *parts,
 	 * is defined is the first device in the list of concat
 	 * devices.
 	 */
-	item->nodes[0] = parts;
+	item->nodes[0] = of_node_get(parts);
 
 	for (i = 1; i < count; i++)
 		item->nodes[i] = of_parse_phandle(parts, CONCAT_PROP, (i - 1));
 
 	concat = kzalloc_flex(*concat, subdev, count);
 	if (!concat) {
+		for (i = 0; i < count; i++)
+			of_node_put(item->nodes[i]);
 		kfree(item);
 		return -ENOMEM;
 	}
-- 
2.53.0

