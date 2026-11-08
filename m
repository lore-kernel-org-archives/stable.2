Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173037;
	b=ZT7/fd8LoXcDpmgstcqyd7n/d/eE40gjQr53mTVj1Po8tdVSqBzB6khiP7Yi0W1pXwHP
	 AFdTovC2XJxWmdYH8HDfzOb/36Spplz5MXpmM2TJGRIzdup+Cu16/IU2K5qRcwW6oNXsR
	 DaeC821irLYJO1mw6mYpfFGyj7J5wz0a9uP3HffNHiuOqNu1AdNT/2tHdKo8KkIt4Wif/
	 IZ5QtSbgVsigRyjtzBuDiuI9GCGWTcAdQVur8ITx4/RXRimSoF39kVL5mcjpgDQZPjemv
	 8vSdUlU1U69d2CcXfXU+sI50ers0BtklzNgFWQJTIvjS5gTsRnWD9visUWN29gN+t7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZzgA6XGsC14IAPU7geG6In3ud51Yu9iRbZaXfcFbd7c=;
	b=koW/YTHkapmXwCHd0DqlD0nG3PPFIj5G/BDFVOVLlSnFYmAH/I3AFGDgmRXB+YA9cxeE
	 bnOfTc41aKZ8QgkhJYuVSNMwPlJs+EFdh8as6335/sTx2aXY2cJ8h6s3pcXGUD8KY7Z/f
	 x/Fw887+c6bSOqr/OBTtnGiXpSHQWhgS6BWOemlo2BtqfqJ69uS2jhV7/DEAhXXEblOue
	 H999hHF+4NU+TNp6vwCzhpBMcLmqFpxprDdnGjkekJXKjvrHKZPI1QY6bJlul/iwuEmcd
	 Bp7kHxJDoaPeQFdJWzOHYL6KLX5kj7MFDo4/cOoEi/K2E6RSfZD87IYZU7eimoNM+nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKzzqonh;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCC606A333
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BCC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nKzzqonh
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-70b875f6f13so227345eaf.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173036; x=1794777836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZzgA6XGsC14IAPU7geG6In3ud51Yu9iRbZaXfcFbd7c=;
        b=nKzzqonhuTczE+W9bGIwkLJyyKjvwX6yUNWjBmlV+pC3fMUC5Ndhus4phkjHf1o7fn
         h0gvh7IV/0PbOM3GmRndI9HBVX8xf3p71CgqL5P5y391hdDBj04MqgQCO52yQLtmiC60
         hk7DhnWuSgijVsq4bubMnr2LbV97AvnDSUjAYYxiwxtKU5JIlrQh0r4vEEnmog/0+snH
         R4WDYedlHd5MEKgniXVTg6h3xYVAe2U5I68e3KqsnyQtX6GcUfWvVw+BGJWhboFlBzvz
         0Z0O4Dn5Irnff+UChxmR8kr/EgddIpheahTaBzhf76YdhrpInUObe9tj5Fw+kShZklIZ
         s/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173036; x=1794777836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZzgA6XGsC14IAPU7geG6In3ud51Yu9iRbZaXfcFbd7c=;
        b=WusV47qU5uNlSdvLOYfmyGK5a4Mk7TJjq/svrBcRolhYZNVuG1s2qVjFvFxiE6aLF/
         R5j++n9pz77DPH/fDtSBnHdPSviXYwW7qv8XQxrItPisdS57Gc598CsxdBNzOLy5fgVr
         kzr7Qs5MdVIcr3EkKxoMeFkzTDKkTv6TSqjNMBQzll9OFnU1nXbFr8lchb+FWzQHmJWX
         twyNK9TH/mAk4UGzKGoj6tOw1JfT35g99Bln0alkH/zW4+AnukTyKJirZJ59Q5jut051
         BMZsDw5SdJ/IcIe7Ur9pS1vGp4oKkrWIn6PgW78gjHmVh6Z3DhjiyMueS7MRsmgwO4K9
         N7VA==
X-Forwarded-Encrypted: i=1; AL+hErErWTlIUYk5ZlXkqDIAnYnlRkhoIgJiaq96szjFhl8KwAlbrpeM4lUmAzMqeUl/ad8c5hxwUzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2mF6xIJ0s3i/B1mc9koZMh0coVq0dgMgz8JVfwADJT+y9dZIO
	nunI1dE8QvDRodHGFAyUgi42Vsjf6fc12GDGw6Qp8S11dGnkAu43/F32
X-Gm-Gg: AYBFou3lP4biimE9SjK5mJEtwrttAACH84fvtvqZCs3vWt9ec5QxB1Sh4G81imxmZQI
	g/p65/bgkkbi0+2IJ0gR8JG41nHUnI1U5B03WNYY7qwUhoekBvMIOvByH/ek4o+YuakBoXR1AXg
	J71xXyweNuM22Wfej80/1mKeIJ/0JqTFAPPDSlbfyADHUpcij6wMkEx4GFnFzD0f9jeDjvOH7px
	ocbsRKFq/kp63/vXhh56A6+qeF1z1PvSAk+UFxuRjUqxAKgabzyO682BHxP8Ei+FD/Aw3XaqyEI
	aXPf04/9sMrPaURrEEsSlr+yXO0LYZHfs16/sA/9VZuw7QnLBwH1rZZHL3qn00sIzbVXS7qLhNt
	u5e0iwICV3UxAqqp5lep4we+rSZTxYW5S9WPzymwkDatjGxmpgH6crSFQ3cGKZxVPAnfKbrBGgR
	qkRwUhzjekLqBr3XJioeDl65U5mxbL2LfwXUF0jfIKXjFuXoUfvynfJV+WZUcGHeHvcFbKs0YXv
	KE0fe++zN1lUbT/ywop2iaWXl3pOc7rpz1F+sbCYhaI/pPwaENILKrTQhKJR76ezvUaU/86OVe4
	R7tOsy1G6y5M02kpY+gMkdfZ525jvj17fCca0YAq4TWMg+nFVH3HDaBYEEP22r26VKAk0s1LLSP
	6ytTchJ52hnhO4uLNSINm//Cd5c0roh0RG+fQH/ix7HIkOITz10lp97TT2bIs8vjWPYO7oZQwCR
	mpEFoKW0cmgUdaxQWjMgibTK+My2ng2JRXDEFNhaBVUR+rwgU6wfE=
X-Received: by 2002:a05:6820:a29c:10b0:717:f38:c6aa with SMTP id 006d021491bc7-7170f38cb27mr789245eaf.35.1794173036399;
        Sun, 08 Nov 2026 13:23:56 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8fbc55sm1908138eaf.12.2026.11.08.13.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:23:55 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:23:23 -0700
Subject: [PATCH 2/2] mtd: rawnand: serialize bad-block marker writes during
 BBT recovery
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
Message-Id: <20261108-submit-rawnand-operation-locking-v1-v1-2-565010fc5f8b@gmail.com>
References: <20261108-submit-rawnand-operation-locking-v1-v1-0-565010fc5f8b@gmail.com>
In-Reply-To: <20261108-submit-rawnand-operation-locking-v1-v1-0-565010fc5f8b@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Kyle Roeschley <kyle.roeschley@ni.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

When erasing or writing a flash-based BBT fails, write_bbt() marks the
failed block bad before trying another reserved block. The erase and
write helpers release the NAND locks before returning, but
mark_bbt_block_bad() calls nand_markbad_bbm() without acquiring them.

A BBT update triggered by a bad-block marking request can therefore
issue the recovery marker commands concurrently with other NAND I/O or
while the chip is suspended. The chip selection and shared page/OOB
buffers are not protected on this path.

Take the chip and controller locks around the recovery marker write,
as nand_block_markbad_lowlevel() already does for normal marker writes.

Fixes: 10ffd570f117 ("mtd: nand_bbt: scan for next free bbt block if writing bbt fails")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/nand_bbt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index b0e7592a2ab7..51fe991358d6 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -720,10 +720,12 @@ static void mark_bbt_block_bad(struct nand_chip *this,
 	loff_t to;
 	int res;
 
+	nand_get_device(this);
 	bbt_mark_entry(this, block, BBT_BLOCK_WORN);
 
 	to = (loff_t)block << this->bbt_erase_shift;
 	res = nand_markbad_bbm(this, to);
+	nand_release_device(this);
 	if (res)
 		pr_warn("nand_bbt: error %d while marking block %d bad\n",
 			res, block);

-- 
2.53.0

