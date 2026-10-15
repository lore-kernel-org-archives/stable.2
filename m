Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EB4BD34C
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055883; cv=none; b=ew/r6p7qCJfI4lM5XqRwYvXED2QDY2e6YkXVBeBE9Y8loJhMeScbTB4HX1pwKUCKvtfK3dgGimNIZC6Y4Hp72mcOGNB0c4VVmNT7FBGowsqM5b0ebL7dd/zswsFWveoJlIBD+1DJ66d+oHYb06vjD3u3OgtkYVETXvhPnypiEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055883; c=relaxed/simple;
	bh=I+Sej2zsaou8ZC5bWE8uIdgpps4InDWrIMdzXaw5pRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDLknW3/2FzVhyJVqCA2IVN4CiPx3h22eXfDQExMQo5FiVR0YzrNCI0ZQ27DcMBgHvhlVhSwmo3jS5xj6TZBIr1WBhLLx162SDdxp3YGdryCb81MpPgjHrNZvdq+rwSKErDKmE84p5x1N5BoeOULlh4/Z89Y9donA2gbdSdv5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Lvi9H91y; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Lvi9H91y"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1597641a91.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792055881; x=1792660681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n4F9I43MamT/SxqYA1QZ+SX7IAOsbvvA++4GPflnXnM=;
        b=Lvi9H91yD+0nf05Jn+od8ZyjhZVBTZ+YzRY3rCcfAedJmUDjbxyEY0NDAi0sDk9AZ8
         lNc3F36U/DE2vCj0RjHoofCQwxQO68WfPqU0S2Ia1fp01UH9YhZl1I0NllrNKuA97Qo8
         6WWfTwUG1/xHT4LBESEn04YBMX2UK9o9PcRGpApc9OgxGuzvzp9Mqxox4a93gvkbzKef
         f71jhPJenzg0963zZNfgR2ujl0YdjBTxQIeGu/cYtELof8dzeaA8pSJfsque6J2eoDGY
         YRpYHXoT3E0fa/dR7P/+4FHmp44ZG1+o+sAJCbL7FU4414yIQR3XufE8LhP5RGDTB6wk
         idcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055881; x=1792660681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n4F9I43MamT/SxqYA1QZ+SX7IAOsbvvA++4GPflnXnM=;
        b=cEBFf5ijaHwthoY2EOh0MxDmgPfIPvh+/4LjncBfzWwAl6pSUhMlczRMUmVtGxx6UQ
         CKQEcWh+BQqYTJWSfcg58Z66sn5yoALURId628uoin7FnFrFPqileNR/TDl3O0p86Fst
         L0auAIrsWUlr4iNqOTmxA/MEz/fBUB45jQpg9zmB+WADihTcAwCFPNtqOUuPF9S6re6U
         1ok0dtQ6InfZzcJc+Zpznr0LnW4Qe0qQHj6AkbkOm5D+UNsqMuEnqPb7eoVl9GErkF/H
         zUP8Ivl78DrByRRoVr/iSNtP48ib5lwWErtTEpLdfEUlq2Wb2D1xwvkwW63Qu6zCS+L7
         m0bg==
X-Forwarded-Encrypted: i=1; AKwUvBx5r95fXiKfy1KVR+o/J3NsjKBYBaYgjIAcOpuJTHT/RbEG9ln2xF/x2mN4Z7BgIE8XBIK2S38=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5XftDLYE5+GZqS5nLQZ4EQFGE5zgn/14pS+/QiTAEBWbWmbbT
	oulxL2U5rgREeYCSi6clU7blILWIkaRlP2GHC6CxoWKOnzoM3puXWsH4TETzA9fJz/Q=
X-Gm-Gg: AYBFou0yBHrctSUPVF4VJW0APyhrza5x2hCN4AKXwbPNpeJinsNy9BDaF0itGVEcuzt
	Sl3BYnFLLXdGBI9LPpxvNotk6mca9StBPjM7XOD9cjlNg9xLbXOdtUAe9HU/BbHNTs68KpQyfwH
	UO2cVL3ArY/Opxgf0i3YF/TxrfrvAh6KmJRUJEobkU3JFYbjsP+ab5H0srXgwPN0/wTXLodSNbQ
	DFQjoFGS/3bgFon5lZPrM3vTSVE78RM1EMIXTSPkZi/A8ylo9VejeM3WR2EoQeTJ+RStlyrw7aF
	7HVJU+PJgyttTD16a4+d0oDdyhDjaWFbNeccc5nm/0k+0d7sRmTbtpmvBaQgDbwwAI+ZQ2nsFlL
	7HGL/xcWsDck7+YhToS03X09IMxHvfeVnzZLYAHMM8l8R0TpcZViArlM5ecjrdsnVtDA1BZeLqi
	tO3KcPmWFb6I8IPWpvvFtoV37PES09Bd8IQnMlryLkByqVUliO+tm0nIWX1D7wZXy30IupW+wJ6
	FoUZh9wLE8tICEH
X-Received: by 2002:a17:90b:35d0:b0:3ac:450a:fa46 with SMTP id 98e67ed59e1d1-3ac450b7738mr6163126a91.10.1792055880554;
        Thu, 15 Oct 2026 02:18:00 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e821csm3412408a91.8.2026.10.15.02.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:18:00 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3 0/5] scsi: aic94xx: validate the indices the sequencer supplies
Date: Thu, 15 Oct 2026 18:17:42 +0900
Message-ID: <20261015091747.4184349-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This supersedes

  [PATCH v2 0/5] scsi: aic94xx: validate the indices the sequencer supplies
  <20261015081935.4168771-1-yhlee@isslab.korea.ac.kr>

which should be dropped.  Patches 1 to 4 are the same commits; only patch 5
changed.

Review of v2 5/5 asked whether reading escb->scb->header.opcode outside
tc_index_lock races with a concurrent free of the aSCB the index landed on.
It does, so v3 moves the check inside the critical section the lookup
already takes, and clears escb on a mismatch so the existing "no escb for
this dl" bail handles it.  That is sound for a specific reason:
asd_ascb_free() clears the array slot under tc_index_lock and only then
frees ascb->scb and the aSCB, so a slot seen non-NULL while the lock is
held belongs to an aSCB whose free has not started.  It also makes the
patch smaller -- two lines per file instead of a separate bail block in
each, because the NULL path was already there.

Worth saying, since the review framed it as introduced by the patch: the
driver already uses that pointer after the unlock.  Base reads
escb->edb_index and calls asd_invalidate_edb(), which dereferences
escb->scb and writes eb->flags and escb->num_valid, all outside the lock.
v2's opcode read sat in the same window, and in the case it is about it
bailed before those, so it narrowed the lockless use rather than widening
it.  That older and wider window is still there after this series; closing
it means either holding the lock across asd_invalidate_edb(), which reaches
MMIO through asd_post_escb_list(), or giving aSCBs a refcount.  Neither
belongs in this series, and I did not want to bundle it silently.

The series as a whole: aic94xx takes two numbers out of the done list the
sequencer writes and uses both without looking at them.

 1  escb_tasklet_complete() already noticed a bad EDB index and printed
    about it, then fell through and used it anyway.  Add the missing
    return.
 2  asd_get_response_tasklet() never looked.  Bound it, and report
    SAS_INTERRUPTED on the way out rather than leaving the command looking
    successful.
 3  asd_get_tmf_resp_tasklet() never looked either.
 4  asd_tc_index_find() indexes tc_index_array[] with the number the
    sequencer echoes back, in all three of its callers, without a bound.
 5  the pointer that comes back is used as an Empty SCB without checking
    that it is one, and struct scb is a union.

I have not reproduced any of this on a controller.  Injecting the bad
values through a KUnit test on a KASAN kernel does reach seq->edb_arr[-1]
and tc_index_array[] past its end, and does leave a non-Empty SCB
modified, which shows the arithmetic and the missing checks are real; it
does not show that the sequencer emits those values, and nothing in the
tree answers that, since it is firmware loaded with request_firmware() and
there is no Documentation/ file or MAINTAINERS entry for this driver.  The
commit messages are written on that basis and claim no reachable memory
error.

Patches 1, 4 and 5 carry Cc: stable.  Patches 2 and 3 do not, and I would
rather a maintainer decide.

Yehyeong Lee (5):
  scsi: aic94xx: bail out of escb_tasklet_complete() on a bad EDB index
  scsi: aic94xx: validate the EDB index in asd_get_response_tasklet()
  scsi: aic94xx: validate the EDB index in asd_get_tmf_resp_tasklet()
  scsi: aic94xx: bound the transaction context index from the sequencer
  scsi: aic94xx: check that an ESCB lookup returned an ESCB

 drivers/scsi/aic94xx/aic94xx_hwi.h  |  2 ++
 drivers/scsi/aic94xx/aic94xx_scb.c  |  1 +
 drivers/scsi/aic94xx/aic94xx_task.c | 10 ++++++++++
 drivers/scsi/aic94xx/aic94xx_tmf.c  |  8 ++++++++
 4 files changed, 21 insertions(+)


base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.43.0

