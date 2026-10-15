Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12004FC33A
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055896; cv=none; b=Xil4cO3+umIYZk3vn/IOInDxCE7Wz/A4iHOOQ9RIO6vWBp6VtHqiRXHemzsyHp25f5fWUxHjycqx1lZqgVdd+7LhmxK30Ydu4EWxd6cl3FEq1UoVRA5lxUfnkl92TZOU1KTc3Qb+rL+Cbizvjjjj8DNCeYLxQJLmnLV0jfYyasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055896; c=relaxed/simple;
	bh=ugWuCtrEQC0vxyuWPSfQu7GnfazNqdWELj9G5aX8bcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/GEdJNmJesVnIdj7MR4C9MVApGE4K7vgz4MtR3OP7tO/LiXgJpSVbA4MTc4Ou2mny5/BsPw/j9oRzc8OtaSykW93z8jQSiHUtZVZQvu0/MD2Pz4bnGr+im+hhK6Eszo7fwPcCksAHGdYuvvgQQ2SkwCfc3mYBbUqqu0uuDl05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=QYzL0MKJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="QYzL0MKJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab98332238so2846417a91.3
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792055894; x=1792660694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ljLnSjqF2Nc7+ZmdD8FWQqLarCoKAOUufd8P3m6PY0E=;
        b=QYzL0MKJQZ863ZaK/LXmreQ8rJgYMXySTy3PFBgXjr3G/i9DnxLnUSqShqOB2E+w45
         QhkCo3CfXwzBk6G+vo/tEcT3i5TdkIFviHBd7CI2y5aYddLYIk1dUOnHsGdimi74Jr25
         ZwBr2Ni6rp9PYXDtmctCuqsr6WD94d0uEpn5Q5fKttA6aqoenmS3uTRSNKZ5+KWOXwRH
         zZuNtoLTWzgYlvfWeSVJe2sYSvE2K5FZmRkDEwa0oLHMXlzkB5tShr/9OVWGfpSQpgVx
         6pSh0Y1Dbmv3IEVrkB7y3oanKozBaMxkc/jL+qn2bB6mqWWOndLFAAU6sNnGaZn4grpu
         sSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055894; x=1792660694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ljLnSjqF2Nc7+ZmdD8FWQqLarCoKAOUufd8P3m6PY0E=;
        b=TNfWcLDydXpH5BPgX+N8hHydcEC58A/ofUPL98NHse+qTps/mcU39sQEqXp6f/u/ia
         BfkSUIt+FycZijd/B8uNEz09U/6xBvi9OoObCC9znXXIONCaEGY3Nc72hd5N9DVD5DK/
         RzWDThvdtou0Sn37w0fIOBuZAnyGEU44fW6z1Ev20PYIeY1VXmXqAqQ/WO5+Vx6lXYIg
         TVjyRcZLmdi6MpIvsGoFCmAjgqyLjBPMZfLHjDMiQn7WSRAbUiMk3fdiMNv55/lwew0I
         Xs0ujHRAWVdA7iXvB69Olg7GFNPy9k9h4yb/TtiLnj632uGy/QzAa8+AWwDHcIARoj8J
         nFoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzriaw+GSHcuiS/QO74SepeLZfU1OzsySCPFvABliZMkdpMu2XH/qf/7h71z5hIdSiTE8zdTjw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvlqE7GtcbuC4MJPElQS2GqP6M/EpXbFYFPRXAywuREHjf8vKO
	1zcRGYP9ndqKSbAMXAeRgyu2HOyRmeZwnvovsooGyl+g+NlGMCEs461J9TnnU9XM3QI=
X-Gm-Gg: AYBFou1oN2rpvZ2JyWiETWPRur3XWaVvMcLJoG4ELlQXRo5xh+3fjU2Lkm3UvSZyfu5
	oenVffurv08FK5yTdY9wfVtPgDqYLi3TfaMfQgrfp03U2mgyw2gaFdiwTCwyj3Hqe9XF6t8EXFB
	9Hw31pbFhzT3jyNj/fOURdjpJhCu+sJhpXBYkOXPg+wC/6zx1u1bxtH9vzhUJNGtkhoFsqZx3q5
	An82OvRfTUAw8miM//RU10rnY5YZnvPhaSMhIvbMEbM9VcTMI0z217+R3IqwxAKLWfDsJFcH+J6
	w6yHFh12LVb3iZyCzDQeDxW1/E1jRbpks0NLxcUj5eCn8jiTDK3FxKGRQIwOeTmAW3vPASHc5EM
	wOsAIwjSp+ju7tnzLeuEg4/gFd6k3TjN2ubOg/bha/KXbWCZF+8ijoVEAikUGSYj70TfURvy5v5
	K4I3O/0zS/5Y9Y4RQGmmeDejEmH2yIB7hwB5NuIOBM5e5othv3sh7FuVwPDTQJb4hrUmj+cw8X+
	I+A4Q==
X-Received: by 2002:a17:90b:1dcb:b0:3a4:fa1a:2b1d with SMTP id 98e67ed59e1d1-3ab3b028c7emr14927131a91.62.1792055893242;
        Thu, 15 Oct 2026 02:18:13 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e821csm3412408a91.8.2026.10.15.02.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:18:12 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3 5/5] scsi: aic94xx: check that an ESCB lookup returned an ESCB
Date: Thu, 15 Oct 2026 18:17:47 +0900
Message-ID: <20261015091747.4184349-6-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015091747.4184349-1-yhlee@isslab.korea.ac.kr>
References: <20261015091747.4184349-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asd_get_response_tasklet() and asd_get_tmf_resp_tasklet() look an Empty
SCB up by the index_escb field of the done list status block and then use
it as one:

	escb = asd_tc_index_find(&asd_ha->seq,
				 (int)le16_to_cpu(resp_sb->index_escb));
	...
	edb = asd_ha->seq.edb_arr[edb_id + escb->edb_index];
	...
	asd_invalidate_edb(escb, edb_id);

Nothing checks that what came back is an Empty SCB. There is one index
space for every aSCB the driver allocates -- asd_ascb_alloc() is the only
caller of asd_tc_index_get() -- so an in-range index can just as well
name a live task, a control phy SCB or an internal command.

That matters because struct scb is a union, and asd_invalidate_edb()
reads its escb member without looking at the opcode:

	struct empty_scb *escb = &ascb->scb->escb;
	struct sg_el     *eb   = &escb->eb[edb_id];
	...
	eb->flags |= ELEMENT_NOT_VALID;
	escb->num_valid--;

On an SCB that is not an Empty SCB those two stores land in whichever
union member it really is -- for an initiate_ssp_task that region holds
the SSP frame header and the scatter-gather elements of a command that is
still in flight.

Check the opcode, the way asd_dl_tasklet_handler() already does when it
decides whether a done list entry belongs to an Empty SCB:

	} else if (ascb->scb->header.opcode == EMPTY_SCB) {

Do it inside the critical section that already holds tc_index_lock for
the lookup, and clear escb on a mismatch so that the existing "no escb
for this dl" path handles it. Reading the opcode after the unlock would
be reading an aSCB the lookup no longer pins: asd_ascb_free() clears the
array slot under tc_index_lock and only then calls dma_pool_free() on
ascb->dma_scb.vaddr, which is ascb->scb, and kmem_cache_free() on the
aSCB itself. So a slot seen non-NULL while the lock is held belongs to an
aSCB whose free has not reached its own critical section yet, and the
opcode is safe to read; the same read after the unlock is not.
asd_tc_index_find() is documented as needing that lock anyway.

Empty SCBs themselves are not freed while the adapter is up --
asd_free_escbs() runs from the teardown path -- so this only concerns an
index that names something other than an ESCB, which is the case the
check is for.

Both callers already bail on a NULL lookup, so neither needs a new exit:
asd_get_response_tasklet() reports SAS_INTERRUPTED there as of the
earlier patch in this series, and asd_get_tmf_resp_tasklet() returns the
TMF_RESP_FUNC_FAILED that res already holds. The non-ESCB case shares
that diagnostic rather than adding one.

This is not a claim of a reachable type confusion. The index originates
with the driver and the sequencer echoes it back, and whether it can echo
a different one is not something the tree answers. The check is cheap and
the idiom is already in the driver.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 2 ++
 drivers/scsi/aic94xx/aic94xx_tmf.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index bb5094ca5de15..00addeef1230a 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -162,6 +162,8 @@ static void asd_get_response_tasklet(struct asd_ascb *ascb,
 	spin_lock_irqsave(&asd_ha->seq.tc_index_lock, flags);
 	escb = asd_tc_index_find(&asd_ha->seq,
 				 (int)le16_to_cpu(resp_sb->index_escb));
+	if (escb && escb->scb->header.opcode != EMPTY_SCB)
+		escb = NULL;	  /* the index landed on something else */
 	spin_unlock_irqrestore(&asd_ha->seq.tc_index_lock, flags);
 
 	if (!escb) {
diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
index 1ee6009d83051..c05446d66b7bb 100644
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -275,6 +275,8 @@ static int asd_get_tmf_resp_tasklet(struct asd_ascb *ascb,
 	spin_lock_irqsave(&asd_ha->seq.tc_index_lock, flags);
 	escb = asd_tc_index_find(&asd_ha->seq,
 				 (int)le16_to_cpu(resp_sb->index_escb));
+	if (escb && escb->scb->header.opcode != EMPTY_SCB)
+		escb = NULL;	  /* the index landed on something else */
 	spin_unlock_irqrestore(&asd_ha->seq.tc_index_lock, flags);
 
 	if (!escb) {
-- 
2.43.0

