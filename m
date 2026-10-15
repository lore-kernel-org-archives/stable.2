Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE04EFFD3
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055890; cv=none; b=nS6/l9nJ1mhVtFx7EmXP7NQyUjXscOq8dNVwGjh1qjNMA1QNhOn4KMtglNWato78mbgcgih7Xl6nognoXe/hBNk9dHUbMG/YSnHjQlI7zRohbZuzi7Z/qGPCLNq7XkIvOIWaZOahrHTYgJp/a4PvKacSOuBSN6VNoa8WrCn0Q/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055890; c=relaxed/simple;
	bh=cLnGrFj4fZ5QbMee1ofZJxYlwDb4ml+Hkm+YEE7tfAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROZVoLgWxEg0bcjN/KuoqXNQy5+LD1Rt5Y8FZ1IVd0NJfAzWcUOHUI0DMmr+XK3iipSoY/RCQy+EPCa/hG5vE5LAZnRN5rVfmU1pk/Zgo3HlGHK1+s5ad7BL/dOLE9g2PDr+SMuc9HklPwSzWXnpF43Cl7MUPkl+Fg7Dv7Os05Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=gdMwCfDT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="gdMwCfDT"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so620361a91.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792055888; x=1792660688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG1zhfPiMXRFUFNZwJgHDsR7OhzfKqj2uZPWv/pDLsM=;
        b=gdMwCfDTRWaMX3ZCdeq3sQn3wNITUY2teqZufHQ4H96Obxe8R/tHPcikaCz2CHQvBu
         RDXgegv/DY83hqm9Q/AO6AKYz0/BiN4WFz6lCLa0m0BrIS9tzxTQ+JxOrRbFBypOBxkD
         EOMmmY6dtXmm4nBcCxdPw9io+1q6ESUv2xdt4ZKQuyV8LJqKvAYhtKWNX7f1rubWlVA+
         F05b4VgZerjrJn/e6/4aIAmNKhLUDkRC0Pmk5fMZg1Ji3Pk/XGUXuCQ+cLK0/hI8dQSJ
         gKI7sQCmQO98dzL3F/Y47eyrY3l504HfC7SxA9uOYlPKGHZO87zwTna2OO+SrWyh6qI0
         1bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055888; x=1792660688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HG1zhfPiMXRFUFNZwJgHDsR7OhzfKqj2uZPWv/pDLsM=;
        b=0rvS7IFxcnW73a5Th/OSWOcULbenrCXxpph88MxnyvbdYHLxk4m6E2x8mSaTBJH5p1
         NczgvIxv5CnV5ij5sPgIXnW1/88PgbZ8hS7OkTtYrhegMIOTOLWkVVUSm8gNJA8m/NlW
         Ur+Ca4sGi1bO+LAKgLL20HsXv++3XtzM8PKsN1VJe1gF5VFitRADUN2wTZx4vR0M+W52
         2ldTemT99N9b3BJtIvTHmSk+u39EEIafkSZAw/lwKkYs3TDnzhLOi80zC0+2kYTGtTHM
         gZCHf1NJQSJU4mFv+BorfHGcrL594zBTw8I/ks2Xb3AeM/KNCOQiAxIQbLeX9QIgyQmV
         4yIg==
X-Forwarded-Encrypted: i=1; AKwUvBzGWITM8+j6v4Re1/9o+KbYlobMEvPnc+mKDzPPeiUH03+Wlbg/fnk7d6eXe1xnqcKY0yNR0Ik=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQZmoVjB907Q05Re3QgOV+bdDD7sfJ442kYaBmtdpWO7jkrSLT
	OnOxJEwmEBnQpoYKWKpm7ZfgHa1x5COhJETL8CcgxEKR8ECZsgA0GXGASynrH5edL3w=
X-Gm-Gg: AYBFou0wAZaiAKmzUVudbJLgkXDFLBNB5riwqW8BaAVaOzXWeUKQ877HP6LGgDEAO+i
	B4n6MbEOiGxbRWCToByyQgD4ceVMLAt4KMFlvGydryUia+tpLqQzRk+UCxUivns/TN9K3OqUeLb
	Yd2G7OFUVGGGUNT/twyECroQEGqIg65KcKy7kTMV8rcF4kJEx86/I9sQI/ZgL6PPrHy5x+xoVzj
	jvM9XL/1dT1vWPiHPqax42lQivp94v2yrc21UL6NU0mlhlB6+XnnMYDkrKjYt/w2vlCrDbidU8D
	jv4Cq+9ij7iiQXDzVIpnhxwhOTxre+zsAwr8xNObbrD7GGavd3xdRx0b4tlk1BX949w83uLRDbZ
	SrF0FNq5MiwIDRhh6dT2BlfL3Xlwp0EMcIYYBOjz5+ntsMxV+cKi8m8QY6htAk93mwKwHRMKB0E
	KGFEGkcddSGGM+vDa22rPg4l2DoFYKyS6Cy9aWIYAhbq4OWArLi5usKfU7LA1y3rozaHPZgGjlR
	LNBB9opOm+9ZeKq
X-Received: by 2002:a17:90b:57c4:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3ab3a95388emr15934233a91.24.1792055888192;
        Thu, 15 Oct 2026 02:18:08 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e821csm3412408a91.8.2026.10.15.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:18:07 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v3 3/5] scsi: aic94xx: validate the EDB index in asd_get_tmf_resp_tasklet()
Date: Thu, 15 Oct 2026 18:17:45 +0900
Message-ID: <20261015091747.4184349-4-yhlee@isslab.korea.ac.kr>
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

asd_get_tmf_resp_tasklet() extracts the empty data buffer index from the
done list status block exactly as asd_get_response_tasklet() does:

	int  edb_id = ((resp_sb->flags & 0x70) >> 4)-1;

and indexes seq->edb_arr[] with it unchecked:

	edb = asd_ha->seq.edb_arr[edb_id + escb->edb_index];
	ascb->tag = *(__be16 *)(edb->vaddr+4);

The field is three bits, so the value runs from -1 to 6, and the first
ESCB has edb_index 0, which makes seq->edb_arr[-1] reachable arithmetic.
asd_invalidate_edb() at the end of the function uses the same value
again.

Apply the same check as the preceding patch and return res, which is
TMF_RESP_FUNC_FAILED at that point, the way the lookup failure above it
already does.

The caveats are the ones on that patch: the sequencer is firmware loaded
with request_firmware() and nothing in the tree describes what it may put
in this field, so this is not a claim of a reachable out-of-bounds
access, and a response dropped here leaves its ESCB uninvalidated and
unreposted.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/aic94xx/aic94xx_tmf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
index 28ac92b041fe3..1ee6009d83051 100644
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -282,6 +282,12 @@ static int asd_get_tmf_resp_tasklet(struct asd_ascb *ascb,
 		return res;
 	}
 
+	if (edb_id < 0 || edb_id >= ASD_EDBS_PER_SCB) {
+		ASD_DPRINTK("edb_id is %d! resp_sb->flags is 0x%x\n",
+			    edb_id, resp_sb->flags);
+		return res;
+	}
+
 	edb = asd_ha->seq.edb_arr[edb_id + escb->edb_index];
 	ascb->tag = *(__be16 *)(edb->vaddr+4);
 	fh = edb->vaddr + 16;
-- 
2.43.0

