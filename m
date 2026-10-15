Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B94411FA4
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049195; cv=none; b=OvPfEV2Ztqs4kiX1dXEpCz6x6H6w8ITEFJvpVSe1aKJjz2SrvLx+5CnCji675ewbnSjijTlKe2OUdkZKjMheTG/5ozLJpv/zUbRJT/uc+aV0MyYNxJXngkc97YW9JQZUwXVAnGO4xdkXA4k1dOtRzTBarSg89pdysrD44R61CN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049195; c=relaxed/simple;
	bh=hwdNJteCF2UYN9dA77ChB03VK9w7Fqhyx9KhxgEpbDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXZFtKF08LKqucLVluDEEDPU7ef5774iJe0nRpaSaGbYqWv9qL+Qut6vYVuAtWcTJ0LBb20ZJg/Kh218My0Qp164RItQIyfY6PNAVNzOpzKinCygsr8XP6+HCHH4y03d8DBBphr5m+xIQSBkb/n5U97YDQVnnmNx6lDqC2D4b0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=oZMGJZOQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="oZMGJZOQ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a813079a55so4083875a91.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792049184; x=1792653984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHVIvo7ImdizzbFTBs9Bb5lPLWEkfS0ZMEj3JexZwCI=;
        b=oZMGJZOQQ1CuzRocim424LX4Q3fvbc0PV1eEdWU16mdfeAT1jAr6Y6KjyWcMaRDj8k
         sMQqoZyTftqo022qMsUfi+YShrolBeqUQpR3dSV0UUw5ZkTdnev64JPxVgMJf/QIgw1C
         eFG+G2DhATn5AkbAUXzppRhQTJOcGx8SEGlN26ACUnr/q4vZEeC4QTS1/ts0OWsXWhIz
         tqq8LDvAeII+txAqscInuCSqcZQHZq/SRB3IYl9fo8qGQ9KHOp0Et6mZO3+XTyY5ZV6R
         GiUzFWkts2GNBdDgG5CKvxRPLeF2vcdN/x2pQsgK+isgmcp8DEDV1SekrCxJMgDNBmuo
         BzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049184; x=1792653984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHVIvo7ImdizzbFTBs9Bb5lPLWEkfS0ZMEj3JexZwCI=;
        b=lm5yyRXT1baPaZecgM9Vj5w3xNUd1va57rChFF3qwQxnXhaDUG5moCDqe+LzCQRPeo
         v5kYyf8YHW9Hh9UD7+p3Np4DuPNDLSCkwHAiqPfL+t6Mr4kTVUhj+kOIZ0LKMG9NM5D/
         TavU4ElVwIKZupKacSDcLO+7XafrXMd2kquiwqbHOi53RQ7aRPn9K+AN/2Uygajltj2f
         HBV4iIxs5nUZ3bRJNg7E2tX6trs33uSOPj6Hwf+PobPbzICVv+W0CEefivK/9fIckl9/
         i2RHT6fxcc2kEz7al15xd/hazWmrEfvtlv39fahjZz/OZSiCDJr6sOtfwLw2shFBKLT+
         VxDg==
X-Forwarded-Encrypted: i=1; AKwUvByRW4o1B/rPf/nj97xMnJpNEbGsyPedkp5L7DoY+ejpWYmeXDsOGLA0J8QDWZOgwlp3Ac7YlRY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIankw4jffIfW0M0tfGEUPXYIVeXh87p6GIucZfE+CYyS/VeMTO
	ZfxdYoVD+NSDLsaQaFPdJrg4LTXRl7XZ/IumCCDcrCYD9x5ZNSVDyUQc2ydTzCkWyOg=
X-Gm-Gg: AYBFou3IU1DBcMp6DUBoPbIJak4Gy6nsycmllMFdB3YKlYCK7SeTmI0GO2LlhYmSfGj
	cDb/A2FqUXYhqR3V5SczsqbRzJsMV1HK2uMq99Qel63MuRwWRDiem+eAcG3cAiMP9DWT0Yf+wiw
	jF7BHaoQkBeBsuEZdZnlb++TEEn7bIqLXmeP7EI3Xv6x0LhEoT8FnCpvYhY09UM/vMLn2ZY7xT0
	Zwg0Bnaq2V+rLJadDOV0fKhrKXiajsHu9CwjFIlnrxgof8jRiLEJstXSh5KLRKAsQMGcozMSPLR
	8tq8gRPdkTjK1rOU+LUyPqEGSQPwiVMyBivneK5ol7BaN4GBChmwqoATEEmwjZzsiDIFLQ6AgR9
	LEbEdS28OY5cQ1cDRXUR7mhx/UP6d3cnaCD6dXLNzdFTisxwRNl+Ppolt9XkTclOxi0Z88fE3JF
	IAw/8O/SXSd7qx8G1M1oUjW56yZ+zlBRNJugG+n67uu3BPF2kmocX3UHVCuRkiWLJcnndQrm12u
	BUTLsQ=
X-Received: by 2002:a17:90b:2644:b0:3ac:860e:1af9 with SMTP id 98e67ed59e1d1-3ac860e1b6emr1889099a91.41.1792049183653;
        Thu, 15 Oct 2026 00:26:23 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac937c4e7asm1754279a91.3.2026.10.15.00.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:26:23 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 0/3] scsi: aic94xx: validate the sequencer-supplied EDB index
Date: Thu, 15 Oct 2026 16:26:09 +0900
Message-ID: <20261015072612.4144043-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aic94xx derives an index into seq->edb_arr[] from a byte the sequencer
wrote, in three places, and subtracts one from it:

  aic94xx_scb.c  escb_tasklet_complete()
                   (dl->opcode & DL_PHY_MASK) - 1
  aic94xx_task.c asd_get_response_tasklet()
                   ((resp_sb->flags & 0x70) >> 4) - 1
  aic94xx_tmf.c  asd_get_tmf_resp_tasklet()      same

The field is three bits in each case, so the result runs from -1 to 6 while
the designed range is [0, ASD_EDBS_PER_SCB). escb_tasklet_complete()
already notices -- it has a check that prints "edb is 0x%x!" -- but the
block falls through, and the other two do not look at all.
asd_assign_edbs2escbs() gives the first ESCB edb_index 0, so for that one
an index of -1 reads seq->edb_arr[-1]; for the others it reads the last
buffer of the previous ESCB.

 1  add the missing return to the check escb_tasklet_complete() has.
    This also covers asd_invalidate_edb() at that function's out:
    label, which indexes escb->eb[] and seq->edb_arr[] alike.
 2  the same check in asd_get_response_tasklet(), which has none.
 3  the same check in asd_get_tmf_resp_tasklet(), which has none.

What I cannot tell you is whether the sequencer ever writes the value that
makes this -1. The sequencer is firmware loaded with request_firmware();
status_block[] is an opaque u8[4] in aic94xx_sas.h whose layout appears
only as a struct declared locally in aic94xx_task.c and copied into
aic94xx_tmf.c; there is no Documentation/ file and no MAINTAINERS entry for
this driver to ask. So these are not fixes for a demonstrated out-of-bounds
access, and I have not written them up as such. What they do is stop the
driver indexing an array with a value it either has already decided is
invalid, or never looked at. The driver clamps a device-supplied length in
asd_bytes_dmaed_tasklet() a few lines after indexing seq->edb_arr[] with
a device-supplied index and no bound, which is the inconsistency these
close.

Patch 1 carries Cc: stable, because completing a check the author wrote
stands on its own. Patches 2 and 3 add checks that were never there; I have
left stable off those and would rather a maintainer decide.

Worth naming: a response dropped by any of these leaves its ESCB
uninvalidated and so not reposted to the sequencer, because the repost
happens inside asd_invalidate_edb(). That costs one empty buffer per
malformed index. Recovering the ESCB instead would mean picking some other
buffer to invalidate, which the index does not tell us, so I did not invent
that.

I have not reproduced this on a controller; injecting edb_id = -1 through a
KUnit test on a KASAN kernel does reach seq->edb_arr[-1], which shows the
index arithmetic is wrong but not that the sequencer emits that value.

Yehyeong Lee (3):
  scsi: aic94xx: bail out of escb_tasklet_complete() on a bad EDB index
  scsi: aic94xx: validate the EDB index in asd_get_response_tasklet()
  scsi: aic94xx: validate the EDB index in asd_get_tmf_resp_tasklet()

 drivers/scsi/aic94xx/aic94xx_scb.c  | 1 +
 drivers/scsi/aic94xx/aic94xx_task.c | 6 ++++++
 drivers/scsi/aic94xx/aic94xx_tmf.c  | 6 ++++++
 3 files changed, 13 insertions(+)


base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.43.0

