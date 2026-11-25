Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629693;
	b=yRfP2LqJrZc0nB9/0Kb2fterl9Jh4cK1d5rY2XAUSuK3WPdNsb69zOC4Kaj/u+hp5OS+
	 5KRuMUvzBZBB2/EOm3w8eeouO4d57eBPf4RfSQaRauqxLhL2svEsYFkFZKqppDKc4Bkvs
	 TaAYglhyvAulqsqoGfhORePv6EWRZIDOieMOdxKASZmtpWP/GTH2tG7pONJxxZ1ha6/t9
	 v00PED1GUyJ1OCkBibE10QVmDHfapkaKFpIjE0AnIljwrneUx77WuaQF3/Y5sjnrFdnVy
	 ZU8OmEqLfB7kOCnpIj13NClxSqs6TUb8cP5glNgDmlktImXyTVPEoOb61Rzl8UstvnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J+XqSGsctqfVClx187pC0+1lerYiJfVr1oiWQkLmfWw=;
	b=4lS07DTrHHky0/dEXKi93sZFmSZQIuONPpc07OY8/SC56n2R4EJJnwr/86xf9Mu/4ali
	 wVDWTkCmmhGaXhbsUoXKZ1hHC6g7Fkcvq8TIc8d43qxChRX+ilA1P4RygZh9QLZSeEHS9
	 mhWh+sljABB0LsOJ1Ev2MsW+iLIZ9hCrFIsF2epd33VFMj97BjzvNrDdHs9B4KAXUKcfM
	 /2Jv0WJSsKRANavnTxalZ8j0JZYvmIBNM4AZabGkiYYr72mWXdHHvqRyttCxC8IH7zJ2+
	 rko2wmFn/jPebgAfoehSWdLWfEOrDJ7T2v82YreRjCO+ziMeynxumfUzPY0DjL/9Zxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmY5d3sv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7351606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmY5d3sv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692C01F000C6;
	Wed, 25 Nov 2026 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629692;
	bh=J+XqSGsctqfVClx187pC0+1lerYiJfVr1oiWQkLmfWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmY5d3svMk++fyYxpNkV1lbloaNJQ04DpCOG2j3WTcgbWBqH/hMOQ+kuSBMzzH4Qu
	 ymtVMwwl8XVddaCreWT6uqFjqeReFIzBkkXz0tX6RtJp/oXGq5EI+Ctaz52JQTZNWj
	 Ba/xwLFt9fFBp817uV4TSlSQl54Kus4dL692eNxQIp6v9TlYuwzJieUgJM6yVhKahV
	 k0XY1w93T7BxUqAxMwj3eI0hp9CqFh08HLJ5tkr6YnYAi6rHHuj4w42j5QeUvwf3CC
	 YsWwpNs2ez8NZ7Hkc9Ml+zm4lXzCPP/8SUeyLFBk532EOEkggazBFmnNM2qupq3lcp
	 SudwyHoUYFyhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] s390/dasd_eckd: fix virtual vs physical address confusion
Date: Wed, 25 Nov 2026 13:01:26 -0500
Message-ID: <20261125180055.1102849-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125180055.1102849-1-sashal@kernel.org>
References: <2026112515-random-remodeler-3b18@gregkh>
 <20261125180055.1102849-1-sashal@kernel.org>
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
index a599a23afed7d..d1722be091396 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6303,14 +6303,14 @@ static int dasd_eckd_query_pprc_status(struct dasd_device *device,
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

