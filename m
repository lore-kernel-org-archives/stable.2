Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181787;
	b=MKU5X4vnrS9k7mV79n59qNeAe5rabtayoTfVFtGsooeHZyA0XkwQ6Bmv3LAFv5TVdEHq
	 iCSR3dNDFMNLV5uy+eNuzw7mLPb2ewflZcruiukDz8ti6iakjMq8jFNRs8k+oxKxuTDUO
	 F7RInmkWYDA/mDazzx2LDAsU3pdUBisz8rzksHH8yZCfDExPUjbWQwoyRO3XtcR3XD52M
	 sXPGk1nW20nq8rJE7hRav11qPp7Cj4vIelagSC/HFOcYg8a3/AMjhuOrnhll4X+J0VNBV
	 /Vx2X/dM5+ywovL+0JEJuaDlXnUp5KD8Ln7DaM52vEOMlijqxzzsfM+Q++FDb1tOZXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1C7NKpuGv/wKA/5W5MbBMWRwcogQYVy0tjrhwg6RUVQ=;
	b=WF0Cl4i2KkGFiA53rtAGqr43T2ajNalbcHZorBI3QfoS9vqR3cmdB0oO2oOC2T6Ra66j
	 +V+3++l7Q7kbffmhTRW95gCX0LLWnRt1BT87/1fWMsGzRSwJP0ME0Ntc509n5RE6oTjVn
	 a5uurq8y1mKNP6o/oFvfTBXnPE/3MGctWUCzWgsrKLnqE5t/dRH9LnGTLDSipJaQJGrqn
	 9JVrbfojrsAcEfDbkX2MwF81PzQI2HsFBezJ49yOLn6J9f8mE6HCyT/jYqK8vHIm3GLqG
	 mDrcniFBOeuzeo30/jg2z4wZiLeBXFF2a6QaNT+JNwNIolbKu9S0lLba2m7D4AbIBBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ewze5ooo;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53C606A33C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 23:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A53C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ewze5ooo
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4f488ba6e90so86738b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 15:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794181786; x=1794786586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1C7NKpuGv/wKA/5W5MbBMWRwcogQYVy0tjrhwg6RUVQ=;
        b=ewze5ooo5KzYuQHzCcGtVbT4jSRGv21SoQ3xYorBJLeN24N5pCG2tV5Jy05srSrsm0
         DGw6b/5TqvDmi7nTDgKFIEMy6g0JFkPvJYecV1oP9JkIbbVPhaETKopo6lqc6LKuQDak
         yLmYtZdExb+aqye9/A735J2zBPjKcD2y94cBAuYAI3hnJCVrid6H9H7vdKZWf8DMnuv3
         GUI6lum2TB8kQ9xagtXAuGdd4fFbpNp/cXsY6y4uEs2tobtIaunKl1AitGi7Wjff6i8r
         gEOJuIVuvGQ/WMUVIo3auTcj3lS8gWJ3QWQv6B+An8La3JB9oJBg+1eV1wNzDN2ThUeX
         /E0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794181786; x=1794786586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1C7NKpuGv/wKA/5W5MbBMWRwcogQYVy0tjrhwg6RUVQ=;
        b=CyvAIUszTMoBw5Q+lo309FD4DM2V1Gnj4PJ/OKvn2X0vsMLuGiRt7ZfKCkwz9uQ1O/
         p1sIid9uDRLsIX1/UjQdZyGH8hCdXvReawZOWQI0idlJLctz1AH8S4kIU3P1cYnMYaJy
         4ti67+bUORFd1NtbxJVEiy0TouK6N9AkBh7+QmkoEA4XTW7vFPHz1WtloKoysvFJEj3G
         1hlDdx4CgWM4LtSksaUkmSkaU++KVWc+VNcDYabMOMlZDJgDVc2KQZWzC4BVIwy8Y/Ny
         fIWQUNzOObIkUqLaSwVG1S+ftCAByFLLBFRzjoske9pVjZua4BlKP1vI80ZabvJu7eJZ
         LQ3w==
X-Forwarded-Encrypted: i=1; AL+hErFUpoJlK/DLzdi+PTxMdVcTuBZmV6NetPjZ5ziqSMJKrolq9jKG0bWXHOgtDqAsQQMfnEsBg74=@vger.kernel.org
X-Gm-Message-State: APuU4Z8F2o36hHzayraj9eYr5qk/nJUrEyk+6HVe2ykaM3mcj9fkg7h8
	ZFnLTNM6U4kyuZlCtKLaPJjqDLHLYy7QG/q0d6qOE5qKi1Z4zstAyZgG
X-Gm-Gg: AYBFou2td2OZ695eNJdG01p9axyyTEVzZ6FXUYdH/LgnPSwvQWcEoKo8dNwxPUKj0Yl
	mWewWdobmsUHEmJKGQj/8brNyF70k3QRDG+a7oU9G6BiBhkv+W1gKSIEKA3RLU7jR1/g8pu+F8c
	jSwND6d0ODeIR7Ec527R9qdUCleLAwqUIbyyQzAeZCmqxkwWmlkM9XSKXO6oT149DeHp43M3tNv
	KL7QfT0nF5kLLCWDwXAAgFKDhkZIkIu8AJ7/hPlCRbsBn1N6CaUt+ZZmukGSdVDCqXNLJraioG9
	DXYbcJeHKVI7h3IYJdegqhGuFYYjJe7oivMrPkTk/Jvi/NcLNOqZdir/vLL4BW24PpfWysBUzdz
	0MCu3Yzj6VXJdmvdOtBTJK+pDEzxkBiWm/i1jWAS+zAcYyYYuh0YNT8CNntSkppctQD0Xu1ULvm
	RiZIsjWmRWHqWyUOOrl6J5NbEY/tM00hxoQYs/SXamQdxrEtNqFiGoWENwv1nLO/q+YI5FbLWBL
	McLrUw8R02XVtjB+Az1OIyg9RlQQLzbMvjHVjJATzoroGR3q5UlkcFEJbDRE+yVogTZjpfCbdUt
	sFANhfbK7RQtVLs6xpdHXxvcZpgBITp0QB6keSKavY2zFTKw9wK/cT7f2FI7/tBkQ7CeK5ZC6+y
	yelyG6aHY0GcYmlhJwhsrrqZrwz0k8KjclSFkXThrhPaX4yRc7Pv1MyBEr2lKf+HGrLnHq5GYAC
	esS/7I2y+QyuK3msh+FAAwf/xmEnNMZvtep8ud16jX7VJMwRAq2i0=
X-Received: by 2002:a05:6808:4497:b0:539:596f:6623 with SMTP id 5614622812f47-5681464c020mr1356594b6e.64.1794181786514;
        Sun, 08 Nov 2026 15:49:46 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac6352sm3019435b6e.1.2026.11.08.15.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:49:45 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 16:49:13 -0700
Subject: [PATCH v2 2/4] mtdchar: bound OOB reads to the data in
 intermediate chunks
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
Message-Id: <20261108-submit-mtdchar-page-chunking-v1-v2-2-838cf8934ba6@gmail.com>
References: <20261108-submit-mtdchar-page-chunking-v1-v2-0-838cf8934ba6@gmail.com>
In-Reply-To: <20261108-submit-mtdchar-page-chunking-v1-v2-0-838cf8934ba6@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

MEMREAD limits the data and OOB lengths independently for each call to
mtd_read_oob(). A backend such as SPI-NAND continues reading until both
streams are exhausted, so an intermediate call can read OOB from pages
beyond the end of its data chunk.

The next call advances by the data bytes transferred, not by the pages
visited for OOB. If OOB remains, it starts again at pages already read
and returns their OOB a second time.

Limit OOB in intermediate reads to the pages covered by their data,
as MEMWRITE already does. Leave the final call unchanged so SPI-NAND
can still return additional OOB pages when no data chunk follows.

Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdchar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 19d33dacb62d..189e462a9df0 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -769,6 +769,9 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 		if (ops.len == mtd->erasesize)
 			ops.len -= mtd_mod_by_ws(req.start + ops.len, mtd);
 
+		if (ops.len < req.len)
+			adjust_oob_length(mtd, req.start, &ops);
+
 		ret = mtd_read_oob(mtd, (loff_t)req.start, &ops);
 
 		req.ecc_stats.uncorrectable_errors +=

-- 
2.53.0

