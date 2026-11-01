Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515091;
	b=PEyEXZCSHiu36sgkorJXzlcfjxeDW1Le8UqJ82OA9DxyxWrhUVmA0erbZPdTM0n4Ne1o
	 2rggWKj5rfidp0PNSApiRiGfzKt/PpcOlzEvNUDpw3l/GUk5gXlZIAyS4H+V2RC/beTDt
	 0AsxNyfK70j6d/lb7xcge+lMmyMyvWVqe6mNWojjqeluaIb9kFkjH0d/nlqDb3lpKc5Kl
	 ODppsncdUaaGf3yRbu3nQ1NDUnzmHYYKklrZvV0mmWTaTE10B+eJ4atvHberkATiKUQM8
	 dErFbeMnetpd0NHHW9QnOUc4+7ZV6/OWH7So2Psrltz1eR+jTCUbjkZdJZ3lZWze7yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=14x9vk9vqr2toSJvl/cMga8+z/V3rFoujSUlXXEXROg=;
	b=tNRpBdXtFYHXquKf/M8fjEqzo3h2qzk3kMcNUmAgBTP6Q1R8hjcibtLEbjDrktliVmu/
	 TwSJDJjAS2+X0ey7viEIEPZ1LC8ozJDo9yFvE6CNCOCCqtKFegUQkX/6qg5CxL/7P2t8H
	 Ytg4kEQY/klAOz/+a/e+XsH5XdZJexvHDl+DWITfOTE21tGrVVJvyogwVpRLumcA1zppM
	 dnPHOKWHFR2nEmWwXrWunz2jO7tEnomxcYG4iCc7uKtKFOgy8+Jk+4iesfix2P/WlWPKG
	 PZuvBlsnZTMkpk4wTTvs63HZoVQ7i3xtocRFnTcG0XxZTS9miwFv6a52jynguGq0SdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jaKbRs8q;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAA606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECAA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jaKbRs8q
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so1604729a91.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793515091; x=1794119891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14x9vk9vqr2toSJvl/cMga8+z/V3rFoujSUlXXEXROg=;
        b=jaKbRs8qDefvyjJnGr4taFgormkQZjV9UOuZ5l57Dggjjs0zqQPWuFXSxxxays//UZ
         6UNPEhubBJoB28MYY+j7JRhufn7fO2HisNV6L7NbTWTVDwAk1y34KPmA+BkGAS8/RrM/
         tc4WKkGrXYn2p0a/rpKX6eqMXbZqAbnK5okTpm9TJXAegQrRiOmG8uvEkDzOhNWhK7x4
         TCr36tWRlgJUF0AZ/AmiUF7El0gVn4tRzDje30WD28aE5N6csGwP2uENypBdTRe66Sf8
         jL9wPcGtiiF+M0vFE9u605IRqlsh3TdidX23X6r2QBhhBqKfJE+Q82hsdaM6dgl/DTgS
         9Xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515091; x=1794119891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=14x9vk9vqr2toSJvl/cMga8+z/V3rFoujSUlXXEXROg=;
        b=jQp4mAGv74ebmbg/pcMxixuWIwo+No2h/0lWm3i8utnNQeVEjAUOVdi/X8i0yw8VO8
         cGkY6i2lXd/AA0qGR97szRn6CyXYHbaylg89ikrmBWKg0PasqklEMepyEDIb3dlH+dsC
         X0tJZGQODRHmYKLNor+s/+Ok5TdIbA/aEySR/v+TtRKqeJ5MmAbIyarT1Bc47Fsbvzns
         cLXuCXJA9Iuq+mvODU4Xmx0JRER3VRc/My1CCQ/fKjfu9uqXLQNhk0H7D6xS4d72+a13
         YF7DTnFh17SodbyfG8m53cXCSw1vj6cRIoYmmJJ7c+hxs7V4IyPFkwssYXbXZL8hqWEj
         1+7w==
X-Forwarded-Encrypted: i=1; AKwUvBws6z8Roc6Env35FN4n7MR+IyACjs1MPUhEVfyxEOegDW0/fHBqbKTmQqL6q8dZY8TuNYixQzE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwAU33/G3h0nyRDrqs12WHtB6Biglmyw3Ivq93XlfOSZstZXBs
	NlrJsNdxqDvCf/PZ3//gjDg5MrDfRY80AEufxtLXmAVWdyeRvOZBK2PPe7MbLEOtL1LqdUMu
X-Gm-Gg: AYBFou105wRKN/QD7NDx4Ivl9cEgtv6SayXSD7RXm3FIt3JHqUnKnqHe2UxGmidRfxz
	63+X0fWEY0gfHe7hde2zd1DS7fJBzDVi0aRRLhe5sBXbEwIUpXuI7mjWmplUo3uWvtM3bj5zPRq
	Id2cFfAhnYd0DE2DYM5uWR606NPVtfyynVCQjpLi6+ug83At8pNnoLRPb3fT6BoAJDoI5HQaoT/
	tDMNZ1E33pGtaIVSpcHrAlowBBAS4UrNX28DydyFJ43WaFWK+olhja4edfncvZyGlENnwoa32X+
	FhYOMCf7Pp6Ws4r5FiBHh04DLChP3JJj3fZuZpDd60tPp6jtUzS/OHDReMa0BMm18DeezHEFt1i
	qGKAswsPYo+bMBmuGqgn55C3EmaVCOkexTUeumpZfC+m3xVwpthtMcc7ufhCdnmidONFoWId/Y0
	54CiO5a0W4PefbQe3jhg0O8Hfq0CgmLoNWp5b5Nc9rvFa9rtEl7Oh0cqiS3Bge5ywZ4/9kQqsq7
	7IkKMJ6Vmll6eRFUo3s0Ef5IVSJu/W/emk38v66W7uF3ih2518Vg7IxVD1I4czxZ2xmRtemUS+5
	IyREu9qbr7CD0BbdBGU49FytlWgNHhA09KtW+Soj3SIGS44=
X-Received: by 2002:a17:90b:4c4c:b0:3a6:d2ac:74ce with SMTP id 98e67ed59e1d1-3ae8972b662mr3606936a91.19.1793515090638;
        Sat, 31 Oct 2026 23:38:10 -0700 (PDT)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e949077sm14036712a91.9.2026.10.31.23.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 23:38:09 -0700 (PDT)
From: BeaCox <0xbeac@gmail.com>
To: Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 1/2] scsi: be2iscsi: validate vendor request and payload lengths
Date: Sun,  1 Nov 2026 14:37:53 +0800
Message-ID: <20261101063754.89598-2-0xbeac@gmail.com>
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

mgmt_vendor_specific_fw_cmd() reads vendor_cmd[0..4], but the iSCSI
BSG transport accepts vendor requests containing only msgcode and
vendor_id. Reject requests shorter than the five command words before
accessing those fields.

The DMA buffer is allocated using request_payload.payload_len. Require
space for be_bsg_vendor_cmd before writing its fields or command header.

Keep nonemb_cmd->size initialized before returning an error because
beiscsi_bsg_request() uses it to free the DMA allocation. Return zero,
the failure sentinel expected by that caller.

The analysis, draft and validation were assisted by OpenAI Codex.

Fixes: ffce3e2e8ce4 ("[SCSI] be2iscsi: Adding bsg interface for be2iscsi")
Cc: stable@vger.kernel.org
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
Testing: x86_64 object builds with gcc 13.3 and W=1 for the first patch
and the complete series. A userspace harness extracts the actual driver
function and uses hardware stubs with ASan/UBSan. It detects out-of-bounds
accesses in the original function and passes 2593 boundary cases with
both patches applied, including error cleanup and lock balance.

This is function-level testing, not a kernel/BSG reproducer or HBA test.
No be2iscsi HBA or firmware operation was exercised. The BSG entry point
requires CAP_SYS_RAWIO; no unprivileged exploit is claimed. The local
harness can be shared privately on request.

 drivers/scsi/be2iscsi/be_mgmt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index b1cba986f0..3b8551a1f0 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -43,6 +43,15 @@ unsigned int mgmt_vendor_specific_fw_cmd(struct be_ctrl_info *ctrl,
 	unsigned short region, sector_size, sector, offset;
 
 	nonemb_cmd->size = job->request_payload.payload_len;
+	if (job->request_len <
+	    offsetof(struct iscsi_bsg_request,
+		     rqst_data.h_vendor.vendor_cmd) + 5 * sizeof(__u32) ||
+	    nonemb_cmd->size < sizeof(*req)) {
+		beiscsi_log(phba, KERN_WARNING, BEISCSI_LOG_CONFIG,
+			    "BG_%d : Invalid vendor request or payload length\n");
+		return 0;
+	}
+
 	memset(nonemb_cmd->va, 0, nonemb_cmd->size);
 	region =  bsg_req->rqst_data.h_vendor.vendor_cmd[1];
 	sector_size =  bsg_req->rqst_data.h_vendor.vendor_cmd[2];
-- 
2.43.0

