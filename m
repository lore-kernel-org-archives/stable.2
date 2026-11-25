Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630024;
	b=hDj+QD65tsV05Yj0sV8qoIQ8XF0FeQK3rindEZ0m+pFKqukj9WVeg25lj2pu1D6fu8ms
	 yT9FqFcWB7Oo8kxI0AnJeq7Vck6rjbW82znulcyBkYlmO0DddaD91wpJIZxvwysYv68CF
	 KVXCNwJCK8ivk4e9wC0YL5GNznK1Ibdn9S1K1r87QIJkTdtQrsDrfLS4etNlqeVtTJjnM
	 5WeoRjIwLGdrQEapuDsq/8Wv+A1YB59gCIraKJfzw4me9+KMMuEjbVgGafew51BeNJtvc
	 C5O95x4VJQCWP9cJGu3RSfRHxkCnhsc/VfXta1d/fb1h/EzgrsrfcsH8toZcwPZNGEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630024;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5rDJEQuq5aoXZZTKghQTHAjQc/NKeZ9MpEc+L2E7giI=;
	b=drKxr7IHxw/s/8MGPMR82D9iAgcSIOGpn7gVnehnwOmOJ04atw5scNCdwWL8zdXGudOT
	 7MDlCTtQ/li0x04FFTPIeeN/SZ0MG+41cF1+aUayCMLAzmXu47dReIQFp5L1fAOib2ICb
	 /v0n6Mlhcxzr3FIQX2OEt06jY5Ncoab9HV8DYbeuta3Yny9ZJIM2iV0/vfMQqDw3wO9cq
	 GPk3DNiBuFtnRyBX7US4zHDV0My5BsKD/XjSxnytf0pgOQFiJ+6ILWqfMml3qV5wE+ok8
	 rGJ1wTbVFmA7TVaj4OgB1qdkd7pKiECRNuHkaMOqPWNg9KCEzwtmji0fxeASqMJTvEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5PbfBoz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651460A2604
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5PbfBoz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613C11F000D3;
	Wed, 25 Nov 2026 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630024;
	bh=5rDJEQuq5aoXZZTKghQTHAjQc/NKeZ9MpEc+L2E7giI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5PbfBozslrJmNl9t5f4zikrdwR74X+Hw5GqAdjlRjXQcaYkxneQdvqNxTG9z6Ino
	 7LyOCIYquQ0kcQqQaZ2W/7bu2rrk9UmCOnwOmQ6b32QBEVusTa8u2yaUmgLgftWHlI
	 cwchBz50lD9RakXb0SCd3SdRQHtBffBP6mx+Bvj8dih7k6wTIbyAd1BQuXEV1phCwY
	 uLTdFyKWHnRHrBVHOW0fhfAF+HjwAw1/o60A2Mnou6+aap+6K5X8/fPXsLysPqNGof
	 B7C6LIJn5yR0D9MkT+2v53nFbvLuPQA1Cko723JWsXjGb6JpAgMAONS5+nN3NCcPX0
	 GxBj3QuBt0VKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/6] s390/dasd_eckd: fix virtual vs physical address confusion
Date: Wed, 25 Nov 2026 13:06:55 -0500
Message-ID: <20261125180617.1129141-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125180617.1129141-1-sashal@kernel.org>
References: <2026112516-sculpture-facial-ba8e@gregkh>
 <20261125180617.1129141-1-sashal@kernel.org>
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

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 99aea41a4d11506c634000e234e0e1a707bd402d ]

Fix virtual vs physical address confusion. This does not fix a bug
since virtual and physical address spaces are currently the same.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: 25cdc1f63227 ("s390/dasd: Re-initialize RCD buffer with "V1.0" before every start")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c |  4 ++--
 drivers/s390/block/dasd_fba.c  | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 49901c4a2abf4..1aefcca10769e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6302,14 +6302,14 @@ static int dasd_eckd_query_pprc_status(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - query host access */
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*pprc_data);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)pprc_data;
+	ccw->cda = (__u32)virt_to_phys(pprc_data);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 045e548630dfb..3be974d65f50e 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -701,7 +701,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
+				       ((int *)phys_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
@@ -710,18 +710,18 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 
 	/* print failing CCW area */
 	len = 0;
-	if (act <  ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2) {
-		act = ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2;
+	if (act < ((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa)) - 2) {
+		act = ((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa)) - 2;
 		len += sprintf(page + len, "......\n");
 	}
-	end = min((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa + 2, last);
+	end = min((struct ccw1 *)phys_to_virt(irb->scsw.cmd.cpa) + 2, last);
 	while (act <= end) {
 		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
+				       ((int *)phys_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
@@ -738,7 +738,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
 			len += sprintf(page + len, " %08X",
-				       ((int *) (addr_t) act->cda)
+				       ((int *)phys_to_virt(act->cda))
 				       [(count>>2)]);
 		len += sprintf(page + len, "\n");
 		act++;
-- 
2.53.0

