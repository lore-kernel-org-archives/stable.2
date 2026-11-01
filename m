Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515095;
	b=V8GA8ag8cF530Tq1ZIYMlSzPeaqHU6ipplA9B0VnnLXqmRmKNUHhoWffXRzMx76W44px
	 Pwm9/VCbXwWdol7SjXkeiZiHOLw/mqWDgLgt/1d55FQJnH8S9ktv8T7CpoIWge0BAixm1
	 VJzLT5eXe0xBitMfQ9VCYjT4GSYxupERiV6KkVBjR6cGKph2p/QD30o3Wgj40glfy4/b/
	 6qMf+fSexnoSGJl5QTD3pN9KzdOa28HTEhSNiHchcKWIa2IKaUbq84dQVkB7VE6WShvj0
	 SBxDtqKzeFmiZ2kC+Cp9UmFku7vJV2n1w5r5tcqojqg+fKk3iBFTT4uujEqx+sDY+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RWO+QUyZGGT9JFrisetKTbapr5TrQxiyv48XC9q2SJk=;
	b=O++7DzLVEgr3PUo396xvsBHpiSGTbu6Ru+rheu1jz2BXncgTTeG8x3gkSXVV4v8YPD9f
	 TZaOVrpZMHCkhMWXkHNlAAZsZ11hFt7yLT+sRjv/e9XBIgTzkxwJiSJbD79oYSvhTIgXh
	 us9W1DhlVSxArXX9jCyewuj5MstG6wJ1TfPgR0TQsmvTyPps+F8aQqHCjsKB8ICVzRTA8
	 PLYQRLhYl7MBHUWfAR+OQEjJJ4g298CfvSL8jpMDw8Zsv4Ou0w8j5y1nyYqQfa/7LBcIa
	 JDwj/NvpVsutCJqPKLuKidFMBZaVMsAHplwTyX8u+VMbnN27kn77S31xTC6Mh/R5MEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRNw301s;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC828606A327
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC828606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRNw301s
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so1459047a91.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793515094; x=1794119894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RWO+QUyZGGT9JFrisetKTbapr5TrQxiyv48XC9q2SJk=;
        b=NRNw301s7/fyH0SOi6Xnd1gRIt61R/gpMLNfP/dtdxe7cN54Yt03X48wbjZh9GWkdb
         UGIXoTe1KlKn7LTMuo3zIhA5tMAzmFpiO3RdmD+JygbFJfOUNBIf0SK2pBTtXoZDjz+P
         LLA6XX1Y8+D0GMixI5NLTS6Qr+4r/ZOYC2wG/xqJOLzO10n7OYXDpGoBN/fq56flFDlD
         a+JrQB2b752icPtg6zmV63j3gy3DSni2aHGauyt7ZKdKraDsVcOx4UhQRc8pqr0OFIrw
         SlPdiqtZA/o/5Mvgl4MWqXhl5++nDh4AxTEmpAqRv/C9YVjh0CyOxmxT34l9aTnvIc0T
         2GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515094; x=1794119894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RWO+QUyZGGT9JFrisetKTbapr5TrQxiyv48XC9q2SJk=;
        b=btU+s8ZucEIvy9lChkWmgX84sUVk/uTwdHv3uKfqr5RaGPGvkJ8NHjzxDJ3+m1SRBb
         JhZmyv4vFb/7FLV2+ItB+sB4Zl30ZDUZUyOJU4UbWF2HEZiu1VKslb3otGAUlpTLw2mY
         5JKe9nOAq1Vl7NURq83FpHrPxBLI7nJ3eCzd0+cCEX5q5puLU0j9a5ywVmAIYF7Uod+7
         /otFm2qdtxv6PX6v77nZGexv+9MuIKrm+VdSbQiYzv4eQtEeTgzx1vSdeRJb4qEZBr+E
         kkTk3HyUbHWK4yf5nZIdDsu/Xcl5VAhlluOH12+O7b62jA2CSOvuR8MvBPSScEGuPN1Q
         kkBQ==
X-Forwarded-Encrypted: i=1; AKwUvByUI2k6h2h/pn0IGg6EeY348ywwHDifeyEmSY4USUXmrnu0y9lPcIBcZgXGvxMxgejb0fRuOlE=@vger.kernel.org
X-Gm-Message-State: APuU4Z96DWUKkek465Hwk43/iNhGTdA5ol9r7T7NhHTlGqkBwbUS2UkQ
	AeRXM8lo8gpaMIPdjfyP+YHykgdCr0zPsMaeqt6RiJ2KYzjiHvORw5D2
X-Gm-Gg: AYBFou1l1IyMUpkZ6CRVzQ4R6J6Ccp7wYLVMd3fffdmQ0NHI7olj3sEoYEEOzT13vea
	4ZqdaZZvbdW9gmV2EdCbTL2yfcfUpujLduM7WYlKuINABdL0BBb2fEBLX2/X58frZtqbqlzb82Y
	AJULeOdlcxj2ULk9PiIiJfFY9vgOkzD+f8kdlJSTq8LKzLbx3gsgHGknLifpv7OSwMVVwmrtdwh
	vmoCtVrGg2QygYBtyNPKQ/FL5frGL4vinNiqbSzmxqLBNCPBSEkKS7mlpEl4ur5owwCF0jjKAP1
	Hp/GW/kiPLgMIiaS0c3/VUMIarRrf2X7mphseP+eLsDNR69blF2SbjTEEIQzyN5/Nok67h+BWqW
	PXy/Ekg5aUcfskI4T6v8o//b3YizKZmCqw3DZ9REtq1MuoILDFzNVJbuUMNZVYrDsHGar9h2D3N
	oR/uxolgaUqnEn1mPaUGSlTbliGozz0j3muZgoqEJDpd84FTlOhaQwUW2+E+XgNjaYZEwHrFDX5
	NJkDFLCWpCBM6NGwChY+iPrWxEEPsOoo/wUez0T9h26R89O5iIQGkhC6bAWx8aRp/uOeyADJmVu
	exd7MSTueFnAbGo0ZtC0rTgMSq7pvoummQshrI3EvFKQpxY=
X-Received: by 2002:a17:90b:1b0f:b0:3ac:9f24:44be with SMTP id 98e67ed59e1d1-3ae897f55e5mr6520493a91.29.1793515094108;
        Sat, 31 Oct 2026 23:38:14 -0700 (PDT)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm14036712a91.9.2026.10.31.23.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 23:38:13 -0700 (PDT)
From: BeaCox <0xbeac@gmail.com>
To: Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 2/2] scsi: be2iscsi: bound the WRITE_FLASH copy to the DMA buffer
Date: Sun,  1 Nov 2026 14:37:54 +0800
Message-ID: <20261101063754.89598-3-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101063754.89598-1-0xbeac@gmail.com>
References: <20261101063754.89598-1-0xbeac@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WRITE_FLASH command derives an offset from vendor_cmd[2..4] and
copies the request payload to nonemb_cmd->va + offset. The allocation
contains only request_payload.payload_len bytes, so a nonzero offset
can place the copy beyond the allocation.

Check the offset and remaining space before forming the destination.
Bound the copy length by both request_len and the payload length,
matching the existing scatterlist copy limit. This keeps requests with
request_len larger than payload_len valid when the actual copy fits.

Keep the existing u16 offset interpretation; this change bounds the
memory access rather than changing the firmware command format.

The analysis, draft and validation were assisted by OpenAI Codex.

Fixes: ffce3e2e8ce4 ("[SCSI] be2iscsi: Adding bsg interface for be2iscsi")
Cc: stable@vger.kernel.org
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/scsi/be2iscsi/be_mgmt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index 3b8551a1f0..1b95161cf0 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -41,6 +41,7 @@ unsigned int mgmt_vendor_specific_fw_cmd(struct be_ctrl_info *ctrl,
 	struct iscsi_bsg_request *bsg_req = job->request;
 	struct be_bsg_vendor_cmd *req = nonemb_cmd->va;
 	unsigned short region, sector_size, sector, offset;
+	unsigned int len;
 
 	nonemb_cmd->size = job->request_payload.payload_len;
 	if (job->request_len <
@@ -66,11 +67,19 @@ unsigned int mgmt_vendor_specific_fw_cmd(struct be_ctrl_info *ctrl,
 	switch (bsg_req->rqst_data.h_vendor.vendor_cmd[0]) {
 	case BEISCSI_WRITE_FLASH:
 		offset = sector * sector_size + offset;
+		len = min(job->request_len, nonemb_cmd->size);
+		if (offset > nonemb_cmd->size ||
+		    len > nonemb_cmd->size - offset) {
+			beiscsi_log(phba, KERN_WARNING, BEISCSI_LOG_CONFIG,
+				    "BG_%d : WRITE_FLASH copy exceeds DMA buffer\n");
+			mutex_unlock(&ctrl->mbox_lock);
+			return 0;
+		}
 		be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_ISCSI,
 				   OPCODE_COMMON_WRITE_FLASH, sizeof(*req));
 		sg_copy_to_buffer(job->request_payload.sg_list,
 				  job->request_payload.sg_cnt,
-				  nonemb_cmd->va + offset, job->request_len);
+				  nonemb_cmd->va + offset, len);
 		break;
 	case BEISCSI_READ_FLASH:
 		be_cmd_hdr_prepare(&req->hdr, CMD_SUBSYSTEM_ISCSI,
-- 
2.43.0

