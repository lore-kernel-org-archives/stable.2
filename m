Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F04A8A1C
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052400; cv=none; b=SPs8pMyReLgZeDcRcuDrAaNHJvT3ciiYQRNQUs70l8DhtipyE7EkKHYOt8EsUxN9pIzxN1cYUMB4x6Ozx7AONywHbe7dMsyQpVXfx/YOkyLVOPcgBme0sNMAWPL+2OYhGPYhBkE+IEKIaPiRO/DfNOouHs/v9ncwXNwp2Vvyzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052400; c=relaxed/simple;
	bh=jPr6aHaLpG8Cv9vSXXtGXXrD3GWFGv3J7yyXdkKzLjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjPB++xxBaJSK8IKBVLZtKitcaFwyT/NmO/B9RxQRcJLzbESlRB25WG9sYTSEmqNpP6O4EfwePkm7e3gWVDuiI0rvnmSRnY8x4kj1rXOCDVTqwNfvz+FubEOQ1JC1oGDnjAY3Jt3u7r8Rj/HfgvXQDEQFR07TVM+aLq/Hxef0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=P4LOvJGN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="P4LOvJGN"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2649437a91.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792052398; x=1792657198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qvbV2vy5EWHtCEzvAlTZKYV1AJ/f2e538Rv/grJak3I=;
        b=P4LOvJGN2dKyX0feuvANyHR8De7LPksG/P0o3d2u7DBlp2E3FCPY/ydtX7OTkI7O0N
         w8Z2cBH8metioXSQfMRvdqI2kWwpjyApFGVyBdiY2C1Fm/zQ+JlY0B1b4m6o7UjkvyIM
         Hh2czmFD58lN5aAsxTW1IV/lizmckO1+9BHV42x1zuubioqfRlvfwMcZ0igUrOZSjaUV
         6sq0uJFenAEtFlcK7qia5e83faZmOmqZ1lNbnL/PBgfxRBwnKNwKzcoEul22xZTdVBOb
         pdazfYEVip797VFefWidwPEuNIDzUf5Eor0rleAR5aGEqO6tbSYx9sYgzri9RwKIBbbh
         A5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052398; x=1792657198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qvbV2vy5EWHtCEzvAlTZKYV1AJ/f2e538Rv/grJak3I=;
        b=OKvWixJxVzsYMUiANhfiQM9aXxn2JK25Q5VsJGsao5GklwbLELuS1NfR8dPPp22b1f
         D58pfAOmBb7pj6p/JjGdQyPg07nKv5Iyr/X14irXAyy6bFvp61KI58ULabyL5bjry1Lh
         ic6TYtYwiAGMkoB7mm2qtw2mA9BXfxLyOyhRF0ibl5hfPElD07Jzw8kJU+a+lJLG8yS9
         fM1EB9Q4E1HxtxEgCDNfKC1k6214uDupsLqPwIMSfe1crCIdG6iJd7d5GZKdhL0SLi1f
         Ps8elxWSUcouKHm8P9u4CvtSv0yR3ogVIwogEYsyLi8UxJ8WnV0oW51Ia5fq3hw1a1X8
         g+GQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0jlghJW6cyg/bMxAgjyfanM4y0ZjU/pxLgQSttz+wsyFrUWY/s+YO162/fpqSJn8bFawsbno=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9zIUfPQQfmFqbYjDtS+h+SpddoJmks8I2RM3QRIzUGIMC2CSs
	oagOMRAEnKf77G7gGdWJNMytoROO49Qs+lCpM5WcSLPfssjiwgCWmYrkmCwy7b865+qlLi9qKfg
	Q0g3Q
X-Gm-Gg: AYBFou2NlRXBDv0lu7rJu1iHSxCecVK/16IDGiU9fus8j1F9Ei40xAdmVbtYS1fyLOy
	If3eDPRgJwW3SHGTPbNSRG6i8pQljDSwBuJNUSaQcmYSj4rB0JoDs1cdPgaix+i18ErjY1lQtRz
	W7Bo7RtewsuWUBiITaioDa+nUy9vgTkczJEtS+KKPRsecDCEagapDayOk+7twRmjRCvpRThpkyI
	deWldZAivefR+g3tw5QDjjcflDIymAtO5uUT9IMth2G3kcPiceJkSeQZLA52P2llTNQ5vcBCBe9
	pRz4lhc85d4d7Yx7VADLiCjA/2mcgVXHijXETJkcKhVXGX7zHw45FKWLb3Rb391IBpBoUOKNeHA
	GTCTIxdtSlZ5seo/IovV2Wncz31HUSA4fKx8NXx+K4BF6gq+W0U6NswzQ9tcMXvct8AJYITwNiB
	WDKruLHrZ78LsFhJc7nyx6JLHXCldqjXVsFU/ucbzO7WCBntVlbtE4eri4ulx/OSBCQC0jHKXnp
	H83bg==
X-Received: by 2002:a17:90a:d2c7:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3ab3a99aa95mr16029643a91.22.1792052397731;
        Thu, 15 Oct 2026 01:19:57 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e755bsm3319784a91.2.2026.10.15.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:19:57 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 4/5] scsi: aic94xx: bound the transaction context index from the sequencer
Date: Thu, 15 Oct 2026 17:19:33 +0900
Message-ID: <20261015081935.4168771-5-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015081935.4168771-1-yhlee@isslab.korea.ac.kr>
References: <20261015081935.4168771-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every aSCB the driver allocates takes a slot in one shared index array,
and the driver tells the sequencer which slot it used:

	/* asd_ascb_alloc() */
	ascb->tc_index = asd_tc_index_get(seq, ascb);
	...
	ascb->scb->header.index = cpu_to_le16((u16)ascb->tc_index);

The sequencer hands that number back in the done list, and the driver
looks the aSCB up again with it in three places: asd_dl_tasklet_handler()
uses dl->index, and asd_get_response_tasklet() and
asd_get_tmf_resp_tasklet() use the index_escb field of the status block.
All three go through

	static inline void *asd_tc_index_find(struct asd_seq_data *seq, int index)
	{
		return seq->tc_index_array[index];
	}

which does not look at index at all.

The array is kcalloc()ed with tc_index_bitmap_bits entries, which is
hw_prof.max_scbs, which is asd_get_cmdctx_size() divided by sizeof(struct
scb). The two values asd_get_cmdctx_size() can return are 32768 and
65536, and struct scb starts with an 11-byte scb_header, so max_scbs
cannot exceed 5957. Both numbers the sequencer supplies are __le16, so
either one can name a slot past the end of the array, and the pointer
read from there is then dereferenced.

Check the index where it is used. The three callers already handle a NULL
return -- "Uh-oh! No escb for this dl?!" in the two status block paths
and "BUG:sequencer:dl:no ascb?!" in the done list handler -- so none of
them needs to change.

This is not a claim of a reachable out-of-bounds access: the index
originates with the driver and comes back echoed, and whether the
sequencer can echo something else is not something the tree answers,
since it is firmware loaded with request_firmware() and there is no
Documentation/ file or MAINTAINERS entry for this driver. It is a bound
on a number that arrives from outside, in the one place all three users
share.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/aic94xx/aic94xx_hwi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.h b/drivers/scsi/aic94xx/aic94xx_hwi.h
index 930e192b1cd41..841769a8130a9 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.h
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.h
@@ -306,6 +306,8 @@ static inline int asd_tc_index_get(struct asd_seq_data *seq, void *ptr)
  */
 static inline void *asd_tc_index_find(struct asd_seq_data *seq, int index)
 {
+	if (index < 0 || index >= seq->tc_index_bitmap_bits)
+		return NULL;
 	return seq->tc_index_array[index];
 }
 
-- 
2.43.0

