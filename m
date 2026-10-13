Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A64734F4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888052; cv=none; b=JWW3gfLLJie+wTcTvqvkDTIzoP1JrXKK07qBaYW/xB0w4y3xTxmOROKsrPAVmNQauPZ2g2e3qF3rhJrMhS6ZcfA3OS4kpJICQw0y+97LSuPdsRRGGnWTjPKzdH6ZQynD5B0qhFdTX88cUJwWgvYJX1acahRrnvu6bv4JKGzcgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888052; c=relaxed/simple;
	bh=I4Ems3vL652kUBJ7YrXNoMXu+UN6uhhl6YM7Tg8At9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YA6/zrbvXB657h9TkP/48ca1NKoHEv6AEv9x6LjBCNoNqCTL1DahTTgD4aiaudwt5gVdgLgMU3BbsGVJtJB5E+qGfy70wK2qz+rLFdrGoqJ/RZVpd0XEgFAdaHsyfdilFws132o+a4paU0ppG+oMjk88lcOf9ZuGKA+p7CeKZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=O5/rRv7F; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="O5/rRv7F"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a8af3a704fso1316443a91.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791888051; x=1792492851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LoNEcPDXDDbnlveBeeC45rD3sgSjJXZHddsvFQD932A=;
        b=O5/rRv7Fio7rOnc+2uxlYD/kL+Mobc1n9pO+zJBIJegCF1nU+L/yfKNtvRtdbbaJyq
         Ne2mYLYKQgQqYynH0jf/SHHyLv/zjOyQR0ftcsv4pXNTe8KZkctfunYZYJ1nKnKBQesS
         drbsJC8epyDJgIooxsWmL/iVSGyuxEL5f7dPgLPRtB24vzOy+FVdlBmOkqYxzoRnN6ZM
         yUA3LOtA5ovLWkTq6lZBUuXtpM+KLMtO7oSLoOmD1ztbH9W9Rz89Y3PdwupR1xcGJL06
         72m654Ag0f/TOF8Gwf4qk2qtLpdveMCAEgTvEPWCpJIy6SQccuLNk5l8rwidbHDPMmNx
         kEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888051; x=1792492851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LoNEcPDXDDbnlveBeeC45rD3sgSjJXZHddsvFQD932A=;
        b=HrcD1IWABOr+qDsvDOsw9MmQfbuiu2WbfT3o477O3xI2JFZFhsCQhxd0DjBZbhMhK9
         aegJB6nDWLh30zzpOt+AjPkR/V4XnFGF8WczIR9ZQZgTI5nmtEDVYytIk+eZg9YGSsfk
         7amM/dyRJKsnH/45Lit198vLuUomEgGhQpPz6+kIkZQ9yczlN1jdd8vyqZ3NfVEWgK8t
         5x6PD/7U2T+Rl1lmUGKHZusXqWfPgNigN7lCDL9osGviPN4FuuU40IwBYuwsc3y/2fVi
         ahGMSvA7Rjq+KSxlD1xgRP6rf+ZRpu/WpR3lpZlikIGd4D/tCOXycCUl+CF8fW8u9qzG
         nPEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRRLbCW5U5FtM6NQMLc0hN6CrR+IBwifDZuN+bcgxg63Zv6fifEuBc0w7NYKKD/dlIwGr67w8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWSfFnaXE2OP/uV8tQ9Al5erSUzLmVNkC6VF7RY71ek92u/fb3
	7iVtKsfzjcR0iBXPphXEmwnVlMRxqXarc22J1PaVp123vkF5gkuy7JybiiZ6yI1/uAM=
X-Gm-Gg: AYBFou3nHt7JsjqbV6y1exmsXyzJd8M+T2+duHRTdKEfH3no1aZGtdOVjCrhde+3OIT
	vEAOnEBq1alfQ293UlDANeXPq/Yi2hDbXcrbHLZfuF+tOyBByNOGFLYXiuLXvfrQr6idRuKPicm
	CdROFNqak+xf2YoEZ1KhI0/1n7x6aQSBZbqv1bt/S9TJucZMSjLkVo9Nr4GBkdPrkydUfQW1JJf
	mRmcJvOkAUXiAdsC9btlooOSMd4Yn/jEZsIqY7muXZPakp6MBIt7dk0e2A402Yjhpi4x9znQnQQ
	wuY899eJE7BeDg40f0SdDOLBSE88adXF522mWuUSHg1JffSUmaRwhRy2vL+iOKrLRYUY2o5Mwbf
	EocQJvAw3GTRwzV3+Ge7jJbX2GSg8+wBYwQHBr+IAQHUdTCo1ZFRT2DHofkUjVfs9VcnuyT0fON
	pew3XGriz61gth159mlLb5xyJQxZM3sqJF8eLJGhDSF6dJNf/tbPCFfMHJoc/NTaahb1tBg5uua
	zMOwAkVTRAFcxgs
X-Received: by 2002:a17:90a:1196:b0:3a8:a1f6:3b32 with SMTP id 98e67ed59e1d1-3ab423f7336mr6083299a91.38.1791888050617;
        Tue, 13 Oct 2026 03:40:50 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3386ba90sm12332028a91.1.2026.10.13.03.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:40:50 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH] nvmet-fc: bound the FCP command data length before allocating buffers
Date: Tue, 13 Oct 2026 19:40:38 +0900
Message-ID: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvmet_fc_handle_fcp_rqst() takes the data length straight from the FCP
command IU (cmdiu->data_len, a 32-bit value from the wire) into
fod->req.transfer_len and calls nvmet_fc_alloc_tgt_pgs(), which hands it to
sgl_alloc() with no upper bound.  nvmet_req_init() only parses the command
and clears transfer_len; nvmet_check_transfer_len(), the only other place
the length is checked, runs later from req->execute(), after the allocation
has already happened.

A remote, effectively unauthenticated host can therefore declare a huge
transfer length and make the target allocate that much kernel memory for a
command that never delivers the data.  nvmet-tcp bounds the equivalent
length and the rdma transport is limited by its 24-bit SGL length field;
the fc transport had no such limit.

Reject a command whose data length exceeds NVMET_FC_MAX_XFR_LENGTH before
allocating anything.  The ceiling is 16 MiB, the largest transfer any
in-tree fc LLDD can describe (lpfc maps up to LPFC_MAX_SG_SEG_CNT 4096
segments, qla2xxx 1024), so no in-tree configuration is rejected.

A command declaring 4 GiB reaches sgl_alloc() unbounded before this change;
afterwards a length above 16 MiB is failed with SGL_INVALID_DATA before any
allocation is attempted.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/target/fc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033a..5ec581780454e 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -62,6 +62,16 @@ struct nvmet_fc_ls_req_op {		/* for an LS RQST XMT */
 /* desired maximum for a single sequence - if sg list allows it */
 #define NVMET_FC_MAX_SEQ_LENGTH		(256 * 1024)
 
+/*
+ * Upper bound on the data length a host may declare in an FCP CMD IU.
+ * This is the largest transfer any in-tree LLDD can describe: lpfc maps
+ * at most LPFC_MAX_SG_SEG_CNT (4096) segments and qla2xxx 1024, so 4096
+ * pages covers both.  The length arrives from the wire as a full 32-bit
+ * value and sizes the command's buffer allocation, so it has to be
+ * bounded before anything is allocated for it.
+ */
+#define NVMET_FC_MAX_XFR_LENGTH		(16 * 1024 * 1024)
+
 enum nvmet_fcp_datadir {
 	NVMET_FCP_NODATA,
 	NVMET_FCP_WRITE,
@@ -2577,6 +2587,14 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	atomic_inc(&fod->queue->sqtail);
 
 	if (fod->req.transfer_len) {
+		/* bound the host-declared length before allocating for it */
+		if (fod->req.transfer_len > NVMET_FC_MAX_XFR_LENGTH) {
+			nvmet_req_complete(&fod->req,
+					   NVME_SC_SGL_INVALID_DATA |
+					   NVME_STATUS_DNR);
+			return;
+		}
+
 		ret = nvmet_fc_alloc_tgt_pgs(fod);
 		if (ret) {
 			nvmet_req_complete(&fod->req, ret);

base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.43.0

