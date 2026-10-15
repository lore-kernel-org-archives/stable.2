Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB946D544
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049197; cv=none; b=c1gxNSvV/UGiPjvynN0elz9d+iWbNHm17i++4oRt630iy9BNdBxZyn0lBUm/Te2vsy5OTFNs2n5lbMf70PfaQqU97D13U4+gN4HmOzkG95gwzQ2IRxQ/lv7qEPC5DuKvIv97BVwEq/Y8Ev76eUuN1evZgckmMnlJ1q8kVZwLoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049197; c=relaxed/simple;
	bh=cGUUH63o5s/1u2PafCjlXAA/0SaXTgwRF1yp66SvIyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbJm5EncDeeksGIwHZJrOJwYwnCHXBCwtFQAiZJ4KbwWKqZBpfTwZEZn3k5GY9UjPFIx6ZIuAgIvqx0laCZ7wnzOvjY88UsI3tdq8PKqpmeKaqMKDS4RIPcq9CgWNbl3N3+vWZReTSvOkQ9YC3IpkWtzJgtkgwri6Ls/jt2wM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=NHxodhlB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="NHxodhlB"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e96502e447so2065735ad.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792049187; x=1792653987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uh0z9KlLSWC0E5K2v3qq0IG5YnWBPRtiWrGTJuWPQy0=;
        b=NHxodhlB1HvZ0n/CxK9q+DvGYkzZmdxHjxBOal3jx1asBcQ7rB4/ap4f6ag4I2/xGe
         gLWai+1WDW5n1/E7KEUC2HK3AIg8AqZEGRNRJ2EjklETKv0yKdtzOPxeN1O/cLXuMceZ
         /rHaHPsVux9MxJPWCqASWA7Nk61yNBnqGXyGVo5bt/kM436mhirZLj3ZXbbtBVyZ/92u
         8h0l7BvOzEGbTBoAKjhzxLsYa7PqXOVpI517Fdk3GIwfSPZkSF0QQWfQ4XD0AvxKSn84
         q22S5f7vHz5GyaJWJgu/BLGgvK+orB5rPoBJMW0rT6oOflts/mK/kwViOjaOy3H7VBMj
         Upug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049187; x=1792653987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uh0z9KlLSWC0E5K2v3qq0IG5YnWBPRtiWrGTJuWPQy0=;
        b=GvF7AUWH/kjJfLT8Rve/9Ujw+gGTwv2UegY7/lMUyMewZxQQPbu3HG2eLaXw1leAYH
         0a0HzJqb0UjzW0yE4GYigAo5K9WxO8F7pYS+NUbQ9KuG5pjcIUzUlXPPsYQQGR0e3yi6
         IXJq9pAmbJUUWfStuD3nXMAzOB6XlOnRW5DMDFxsdsSI8hdWqxAEH+VkU2kypL54hRgE
         D34tRkuYayPzoWGTocfydy+rAIA/0Qku+DtfGrcCtEUWKyUS07YoK3zqaBa/w9TTay4G
         ugLTDaoXInAAjVGlDSCIlcRrpH7TB6XtGccves2Svo4UFbJL22n9xtPaYdGqFup+QzOi
         XOtg==
X-Forwarded-Encrypted: i=1; AKwUvBzNOkfNUr1rfVJ6dI4hvUyCK0PTLkGdEyMEPryK4R9lUhR6lQELLxAA4gS1MWU9Jgwo+SJtD9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbBtqDOZczFSeh5pj6N/h3PCcSRR8Gn4LLI8h3lCWdA9Wh0M4a
	dNHG6jw13yMKLbAMwe3WLYtnvN3zT2YcmvXt3iinMJj0wWrcC7jd3fyBtKAOLfOSNeI=
X-Gm-Gg: AYBFou13DyNYn9IBKWSt3UQv/xr2rm2rOQmUFp2SD+lXcFzOrxOxNk1p/3kIMncKEb6
	dn4u+6COyNqjo0cjm+x5/+0lALrtqM9jMYv6eZY3yLNwjHsfyeVKvc1IqrqEm6pchfge2RGmEfS
	tITMfqKl5VSD8OsOi+nfCZ4CC8gz/T0nnHvxeY8mM+yXUa1rB9BOfitJlzQhbidHLb1KwQlMO46
	xZFWlH1VZv/P25TzuT+ZEvxmn1Kwozc65JQ4Hro8gsVx9QYLz/c4LXOLEuuIMFLGbrDorp/uK5d
	4otOuqqr2TdAgZwXHcWIguDL18xthGZnqqcth20LQw47xI6w1gpX05HkfujGn6h2Hq3FZJpyX9p
	IvgvWjxTW5LtgMWxDfeg+jg07mWIOiravXRSQCoStSWhcXFNCNP9nLgIMbAnWrTBK0XUh7EhoDf
	LgKBp2/UoCHunKekJR1IZEGfl49hYpVFyBQ1zoczcuzzjJ1WgCn7tSFNmGM1e6T0l/5OT0p0BK4
	buDqA==
X-Received: by 2002:a17:90b:4d08:b0:3ac:8fff:5a1b with SMTP id 98e67ed59e1d1-3ac8fff5fefmr2498686a91.34.1792049187499;
        Thu, 15 Oct 2026 00:26:27 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac937c4e7asm1754279a91.3.2026.10.15.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:26:27 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 2/3] scsi: aic94xx: validate the EDB index in asd_get_response_tasklet()
Date: Thu, 15 Oct 2026 16:26:11 +0900
Message-ID: <20261015072612.4144043-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015072612.4144043-1-yhlee@isslab.korea.ac.kr>
References: <20261015072612.4144043-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asd_get_response_tasklet() takes the empty data buffer index out of the
done list status block the sequencer wrote, with the same arithmetic
escb_tasklet_complete() uses on its own copy:

	int  edb_id = ((resp_sb->flags & 0x70) >> 4)-1;

The extracted field is three bits, so the subtraction yields -1 through
6, and the function indexes seq->edb_arr[] with it without looking:

	edb = asd_ha->seq.edb_arr[edb_id + escb->edb_index];
	r = edb->vaddr;

asd_assign_edbs2escbs() gives the first ESCB edb_index 0, so for that one
edb_id == -1 reads seq->edb_arr[-1], one pointer before the kmalloc'd
array, and the next line dereferences it. asd_invalidate_edb() at the end
of the function would index escb->eb[] and seq->edb_arr[] with the same
value.

Reject an index outside [0, ASD_EDBS_PER_SCB) and return, the way the
lookup failure just above it already returns. That check stays as it is;
this is about the other value taken from the same status block.

The preceding patch added the missing return to the check
escb_tasklet_complete() already had. This is that check in a function
that never had one. It is written against ASD_EDBS_PER_SCB rather than
the literal 6 that function uses, because the constant is what sizes
escb->eb[] and, through asd_assign_edbs2escbs(), the stride within
seq->edb_arr[]; the existing condition is left alone.

Whether the sequencer can really report zero in that field is not
something the tree answers. It is firmware loaded with
request_firmware(), status_block[] is an opaque four bytes in
aic94xx_sas.h whose layout is described only by a struct declared locally
in this function and again in aic94xx_tmf.c, and there is no
Documentation/ file or MAINTAINERS entry for this driver. This is not a
claim of a reachable out-of-bounds access. It makes the driver consistent
with itself: asd_bytes_dmaed_tasklet() in aic94xx_scb.c clamps a
device-supplied length,

	size = min(size, (u16) sizeof(phy->frame_rcvd));

a few lines after indexing seq->edb_arr[] with a device-supplied
index and no bound of its own.

As with the preceding patch, a response dropped here leaves its ESCB
uninvalidated and so not reposted, since the repost happens inside
asd_invalidate_edb(). The alternative is to index the array with a value
the driver cannot place.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index b26a468ddc981..35cf61f541d1b 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -169,6 +169,12 @@ static void asd_get_response_tasklet(struct asd_ascb *ascb,
 		return;
 	}
 
+	if (edb_id < 0 || edb_id >= ASD_EDBS_PER_SCB) {
+		ASD_DPRINTK("edb_id is %d! resp_sb->flags is 0x%x\n",
+			    edb_id, resp_sb->flags);
+		return;
+	}
+
 	ts->buf_valid_size = 0;
 	edb = asd_ha->seq.edb_arr[edb_id + escb->edb_index];
 	r = edb->vaddr;
-- 
2.43.0

