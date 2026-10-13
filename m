Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B05519A9
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905623; cv=none; b=Kyq8ufpRjMG+P0jPAIROTAQrISq0sxC778EAg6VrlURiyWbPDkZUI8m9BpngHFxyX9u8mS5L7tDsOkskK9BnYwOXyrg+1lu+Jn7S7nXABNsdIVHuOOHh9eP2I5NE0HrODnRrEYI7Xkl+5yJOA/nsgeLmFGpRKVrSrBecSh3MqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905623; c=relaxed/simple;
	bh=BXr0rSDhl1hVDGoprcWmOpPBqW62UYFcPxUYtbjxbXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBYF3IkPMujbjQ+CbyIHBJmIaIL2VupsMvANI0uqht8wH7Pg4k0gdpbm0kkC36h5dK3bQlILVvhOS4ZDyKfCiltnfqS2iuLUqNzax9eI70T5Jh0WZp4tpGnq+lOp1oqW9/UQCmV06/iEAuXRMD6xt7qJJcz3q6uMh3W4417F5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=EdHBe7hT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="EdHBe7hT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso9516295ad.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791905616; x=1792510416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3b6XsX6coe7wQVnv95dimNXsm+R1YHHriqp/Z4dvvWM=;
        b=EdHBe7hTsr3LWVUVFl0VPWK05G/7MbVxkSbZIgAFlXvAv6vBDh9+eqREwVgBDZTtnJ
         Rw7UW7M6LbFwSbhDAeHSW0bSelupc3WcOUUzSgG/NbQ2DO9bVn8w+5fzdYK5c946iM4L
         Wl/qDWAg9jN/+mSAkPpDuh1m/+GP6UaLn/DmknSqngnHZ0B8Or9Rt9NlYgs96t+/UXuL
         6X/527ZPEaKKHAlsttY7u1YyO1iSTa7MWL3vMt8saPiqsi42vA9Tth4AXTY5JvWXqv/R
         zIYr5/c5/3wzwWwtD1febtHo6T/sFlFovMyPpW4avYENpnxNRka8W0l2EcNx88igTdT5
         R4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791905616; x=1792510416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3b6XsX6coe7wQVnv95dimNXsm+R1YHHriqp/Z4dvvWM=;
        b=n6ArJtdVW4jgxIH7RTK+My4+6gZxmcp84XqyUvR77r8vNFwDjEklt6IfwyHliiwiGS
         RcDxbiUH9elgstbSESUwu6KJU9TGNBSSl5TLX28H/jT6hbB0GaYp0AnpJH2E4MENQoo/
         YPTOYrp85z5ExDB9t3c5CxahF2SFrFvbsMT2bjg0Ha4XmIwVXX4CIG1t9pnuDiXGGJuw
         Bid3z75FWGtfiH9LGp3CFUXRTpQgoAuAncUcm5aipC12aIJyxMHFYnj54oQiXtrPzUb8
         Cpz25MvGHpTrsJO3K9XsZ6nhDsRg4y1ERfF6t2kmLlm9UtsJIVYHDJH4gXw+gXiPX4ZC
         WhaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9dgGsTvMQrSw5kjtRDA96IOo/aign3RHubZIGlYPA/qt41QwN7oKezAxyov/7HxPu2G06TC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHNgI9A+y795nrUiHej3PrplS4dDrOuW6faAd/zmPUTrIpdRk4
	aYkKcaKZeZ7U9yKtQakyaCsExbzojSd1zPMbji3pysIUaLkfN+k5vx3aDRRNBVstV4g=
X-Gm-Gg: AYBFou1aJ4GuA8MeJz8Q+V6q6vGRQsmfF1gT1EK24Afkauc/j3d+FISq814q5nTtUCI
	lgZPspXF2IcT0AzpK1vgVvnLXbeM7z/hZUxUjshb34/TEPJpRY+tWKbcS8eFElEbC0UyUKXt/Lh
	Mi/SoN5bxQDcHbKAxNrcAMKfQKTTpZ3cVOVdul9HF3Xx70LcuMUbVpf7UpXVP2aKjIoIEDf7swc
	aSMdS5x7b2ugZgnKL7cmClU9hX3WT0JvUxNwR04NPvHy9TjlkYEaKdrSiB8OwFwiNPxL1yhw5JZ
	zENI4HvE1XasWHedzEyIoEIKOWJ90pa3XXcMWAVH1qc7fO7OimRtqanlbe21++CX8u69AnszC+l
	DEkbn/rhbN5qpqaBzHgBlmjodmVd3+ADjo7R7zdvoyDwtK4A6v3fFGQf5DAD58aMuBeXAsfZ+//
	vvFuW/zH4w+z7/OykQf+kcFokAUCVjJP5Rc5mysSYpWYUrszt/EhzE0dCXnct1RcIy59pZbmHZn
	l1/UEYrJAPxJVVHfgkX
X-Received: by 2002:a17:903:1c7:b0:2d8:d4d3:3fbb with SMTP id d9443c01a7336-2e842ab650cmr108150165ad.15.1791905613073;
        Tue, 13 Oct 2026 08:33:33 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8dd5sm60841555ad.55.2026.10.13.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:33:32 -0700 (PDT)
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
Subject: [PATCH v2] nvmet-fc: bound and advertise the maximum FCP data transfer length
Date: Wed, 14 Oct 2026 00:33:16 +0900
Message-ID: <20261013153316.3178656-1-yhlee@isslab.korea.ac.kr>
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
fod->req.transfer_len and calls nvmet_fc_alloc_tgt_pgs(), which hands it
to sgl_alloc() with no upper bound.  nvmet_req_init() only parses the
command and clears transfer_len; nvmet_check_transfer_len(), the only
other place the length is checked, runs later from req->execute(), after
the allocation has already happened.

The fc transport also advertised no limit: with no ->get_mdts callback the
target reports MDTS as unlimited, so a host has no indication it should
keep transfers small.  A remote, effectively unauthenticated host can
therefore declare a huge transfer length and make the target allocate
that much kernel memory for a command that never delivers the data.
nvmet-tcp bounds the equivalent length and the rdma transport is limited
by its 24-bit SGL length field; the fc transport had neither.

Advertise a Maximum Data Transfer Size through a ->get_mdts callback and
reject a command whose data length exceeds it before allocating anything.
The ceiling is 16 MiB, the largest transfer any in-tree fc LLDD can
describe (lpfc maps up to LPFC_MAX_SG_SEG_CNT 4096 segments, qla2xxx
1024), so no in-tree configuration is affected: a compliant host now sees
the limit through MDTS, and a host that ignores it is failed with
SGL_INVALID_DATA before any allocation is attempted.

Move the fod->offset reset ahead of the length check so that the new
rejection path and the existing allocation-failure path both report a
zero transferred length in their response, rather than the stale value
left in the recycled command context.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: advertise the ceiling through a ->get_mdts callback, per Christoph
    Hellwig's review, and move the fod->offset reset ahead of the length
    check so the rejection and allocation-failure paths both report a zero
    transferred length; keep the allocation-time bound as enforcement.
v1: https://lore.kernel.org/linux-nvme/20261013104038.3078601-1-yhlee@isslab.korea.ac.kr/

 drivers/nvme/target/fc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033a..55263d162cb7f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -62,6 +62,9 @@ struct nvmet_fc_ls_req_op {		/* for an LS RQST XMT */
 /* desired maximum for a single sequence - if sg list allows it */
 #define NVMET_FC_MAX_SEQ_LENGTH		(256 * 1024)
 
+/* maximum data transfer length a host may declare in an FCP CMD IU */
+#define NVMET_FC_MAX_XFR_LENGTH		(16 * 1024 * 1024)
+
 enum nvmet_fcp_datadir {
 	NVMET_FCP_NODATA,
 	NVMET_FCP_WRITE,
@@ -2576,7 +2579,16 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	/* keep a running counter of tail position */
 	atomic_inc(&fod->queue->sqtail);
 
+	fod->offset = 0;
+
 	if (fod->req.transfer_len) {
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
@@ -2585,7 +2597,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	}
 	fod->req.sg = fod->data_sg;
 	fod->req.sg_cnt = fod->data_sg_cnt;
-	fod->offset = 0;
 
 	if (fod->io_dir == NVMET_FCP_WRITE) {
 		/* pull the data over before invoking nvmet layer */
@@ -2988,6 +2999,14 @@ nvmet_fc_host_traddr(struct nvmet_ctrl *ctrl,
 	return ret;
 }
 
+static u8
+nvmet_fc_get_mdts(const struct nvmet_ctrl *ctrl)
+{
+	int page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
+
+	return ilog2(NVMET_FC_MAX_XFR_LENGTH) - page_shift;
+}
+
 static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_FC,
@@ -2998,6 +3017,7 @@ static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.delete_ctrl		= nvmet_fc_delete_ctrl,
 	.discovery_chg		= nvmet_fc_discovery_chg,
 	.host_traddr		= nvmet_fc_host_traddr,
+	.get_mdts		= nvmet_fc_get_mdts,
 };
 
 static int __init nvmet_fc_init_module(void)

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

