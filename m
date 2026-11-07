Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794028846;
	b=liRTc+v9jm5yuRWDO/Izk9h9INapVAwybFtH4Whs91qVL+zCjeJaUWx8ZHjdU5YTawkx
	 qHsdcmsjAuehaHeCHXRk5X5enHn1UufPCEy8Tj7yq2833VKRSuIzXQzea/XhibNAu5Qfm
	 IEXec8f5Hg3oHz+kB2Tkg67V/IGdspikdrdBfVOejwWDeSnkNpcdREPZpuuJLyPWaxrIq
	 7xcYh1LXkvVUQ1w3BE43FIxSOw5xPSyBjve0lIZPzonvhjssIjRU35agRcstmYp3p0Klw
	 n1bptGwzFzBmPGBzuG0+mPrZh17IIeikzHQrEd32rlRg0XhEvK92Erpio8L3oHRVIog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794028846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1C7NKpuGv/wKA/5W5MbBMWRwcogQYVy0tjrhwg6RUVQ=;
	b=VPjtfoEGHuCiFT162oWxrXX27oU8IEEHlYpyBpXslA/JOWTcsa9RHkHcK99+mmKGoUDy
	 M4blOLmzYgw+aCUPZ6Ui79M8+Nn+nX7t5nUmQEODzNVqsG64/HPq/Dff64+KUXM6RUwqc
	 5N22tNkSxeHRoaiWuAtakXZeHhKaz8TQ21+NvfP1O7Sq23+1Tz7sas/zoxjoO99AsCUbH
	 dToF7nKWAIcAB4NmyzNh4lb3qf8Q49ol+f/0Ol1PhT+hGta6yXc+yfCvsZ+YNo2UBFsos
	 EQfkiyILrdhFkKztN0F72di9+KAarABmzXBjZX8MHjrFk7RAq56AgeG07QQEYJVY7Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s7SrH/my";
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B1606A335
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 05:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D21B1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s7SrH/my
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4f55a53898cso683656b6e.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 21:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794028845; x=1794633645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1C7NKpuGv/wKA/5W5MbBMWRwcogQYVy0tjrhwg6RUVQ=;
        b=s7SrH/my3/aCBubYnKNX6Vr1kLtOLjg63USFilh/1DnLB0dMpLYbFb/EaAwMPcVnvZ
         OXYnfkRuRx+8eGqEr7x+rujQ9NY30yWyA7PIccWIn/EP2Loa5IFWTLtBGT5N8DfXNdhS
         UnnYEbRovoChfQZJAsvFszCQk+0v5qlTuH8Jtm6Sd082bSMRI6no30r5SmZidxvrF8Mg
         +iwRu3HnY8naxMqezJKDnRnLUjAniN0J6THfyfMJoyrM22P3f5B7PmIFAJCcOFSHpfzR
         CFsqy2nyKIKfaIm/QnJcmtCjlMxz5NRChb9vnzGvw8I20hRAJdWhntDy92pWD/3mGuHN
         NRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794028845; x=1794633645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1C7NKpuGv/wKA/5W5MbBMWRwcogQYVy0tjrhwg6RUVQ=;
        b=hQQnB/QKsXcp/vOCatB+zcKkUgGmEHwsqT6ykktPx5ELt1GpNHXWMwdQKmsNrtY6FC
         CWxHtrS75oxMSGRIDiR6uy1mxUus5U7cQUreUa2GutHas9WCgGPo1Pg7zwdZB5lejYqW
         RV+EX+UkMLO68skNFJvd7Q2aPRC1Zvxr5YygTTaDdRjSjJCPMK77/E+rCjHVxxCAXFZA
         Y8GtIxvZPYx1fvPTCTDtvrI6RPbuIl60BqvHuGxRnNGasHMYGVACmrgFmp49SWR2uo1e
         PuQQO2y0/SGN0O7JD0Dw7WP+UUdKd5kZO5zdzyF6aRV4FKGE8xGHKiqYCjNWeE0vrdjS
         X/2w==
X-Forwarded-Encrypted: i=1; AKwUvByYh68ocgGEXdfane/oU9KPK94FaWpzBb2ZnaLby/K3FAg+nwNI2bQMe/YC54NMhSM8MC5647A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yvwzkI/Zro7+FfzD9U8DJy9uqXgUOEbQ1lWBji/DVNyOeNOns
	r5rV/NQ3WwcMCvrHzDKFIBy6DtLyoo6dxquGg/APbQ00/Wl6MDd2xr4h5bOksA==
X-Gm-Gg: AYBFou2ddLBur7grl/L6oS7J8wENYAmy/tlTxDnh+7wwFfdOqZt4aTa6AH1lFgA0R4l
	7QTf7RbiSqandhiHmujxkHBrecU111IyIODhJ7BNa287+TTCbIIdgF/mw/4Rs+H+PnH/jUX+lwh
	G7J4u1WLUfV9JdhaOGAAlVbclJr/DHJkUHClxLtFmsXuOtZd93bd2ff9YK3cXQbaTeNayFoq5iU
	L5NLIEoV/ZDBhves/L3hI4ji1ZjPq0fTHlaXg6mf3o2A6ryU0Lrp6szhehMsYxcAbykq+1B2TuW
	kIQFODsZQqWtzwcTd7/EDNkh719LPDcmK9V2L0CO4cE3bxUmvq9UNjFKSDgX/k35wVqsGqjXiiK
	W5I/BHj/HHmYbRNm33rXObgEhcFgiX47NjF2snNV+dy0HnGlbIAGSU3vcAWzFWTrmJdWyn9hvgW
	djNvov6GLmEpZumbrCkV3eU2yMtsFkP64McdmTV3e1VCQw11ou5A+97rOlEUgw5YeZXZsjgM9JU
	Qmv9MPNCFXF+hTg33BL5qpm3A+i3jCwk4AZNab8cg3zHuKX+dhlWd8fF7cWlKSWE8Wpvre5E5Ki
	fpmxDF5IGBk3XxJFC6W/gfLGiW0x1Wuo68clBsNQ2JB8b+Z2NXkXRG3C+l9yW/0o/e6cwhp+5FN
	RIQmpQMpFkh/hXMvBUecpcLnwbdsy9ixMa/qdZhj8dzGdJ51g+t0dzpyMOdfsv9c0l6qJLiZ9cX
	UuydHZVcmLQxv60BLN49tB/DQbJjUGMbwGEhUjwP/N9nONPXvMgkGqfw==
X-Received: by 2002:a05:6808:1244:b0:539:4d53:1708 with SMTP id 5614622812f47-567e15e074cmr3293716b6e.49.1794028844621;
        Fri, 06 Nov 2026 21:20:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7ebf4edsm3059846b6e.13.2026.11.06.21.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:20:43 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 06 Nov 2026 22:20:40 -0700
Subject: [PATCH 2/3] mtdchar: bound OOB reads to the data in intermediate
 chunks
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
Message-Id: <20261106-submit-mtdchar-page-chunking-v1-v1-2-2973a03531bc@gmail.com>
References: <20261106-submit-mtdchar-page-chunking-v1-v1-0-2973a03531bc@gmail.com>
In-Reply-To: <20261106-submit-mtdchar-page-chunking-v1-v1-0-2973a03531bc@gmail.com>
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

