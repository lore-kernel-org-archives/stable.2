Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA047A0A6
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049202; cv=none; b=DgJ/OqpDnqQjqrFLiHL/GBvtYNmSTvJKrLUzWzD5hXffQLN/LLCuuF+XsMOo30nOsdYcbDExt/wVmQDBKV8nfnhuZnz2RrtMlTSSPpViNMaq3w2zQZMwUWDrrxDtkAA8qbzbN5w8i5WNNGJWZZ3eDETcY2eQjAZOoQ32ADrsxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049202; c=relaxed/simple;
	bh=cLnGrFj4fZ5QbMee1ofZJxYlwDb4ml+Hkm+YEE7tfAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7htvbb4I6Cu8RWl7s+bvLYMCVPYqvqL8pL0t7ALVXp9DvZgsgcgdbKkD4mgeiv/bWdTW7boswAlNk4mKKEslMXIhQU/UHe9BMCQz8+EriYIDUXkfx6GWjqKkNZ3zYuepDRPnbrytlMpI5WbnJpWk1XY1bCgze6DmBs4ezKZ5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Pk7wIxIU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Pk7wIxIU"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd3310348d2so3294012a12.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792049189; x=1792653989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG1zhfPiMXRFUFNZwJgHDsR7OhzfKqj2uZPWv/pDLsM=;
        b=Pk7wIxIUJJVaUiksAKOmdYrq2W8OmYoKRenvc926fRBZPfECfFaEFVFSzbYeyYevwg
         P6JYsEbZPr2b9NDPh6GC04SEla51UYv7KUckg3P8iwPbRjgi0sFYrUqP/02nQ9fkRdPd
         mIbHlDgbvEdEqp+KQ7juYbewoi7djGgW5CdIVJcax5bItX3NFtl80vVOK1+EGVPIzcAL
         OHQDbcXeDwrZjabBJn359RahXociVYmN7MB3lJ1GBsxSK4KwjtFQkfxfUnGjlS15PM8J
         4hmlfVzhBSag/rbkl1WhwwSS6pT7wQ4PILZhBaIhh8bWcMZGExHpBTO1z70CLbIN4M02
         oQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049190; x=1792653990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HG1zhfPiMXRFUFNZwJgHDsR7OhzfKqj2uZPWv/pDLsM=;
        b=hn441uBjyEg9/+lWf2SdVyRZiKVVHBYElk51JcsGEl02z+4JojSfpwFFfxw3fKEGEB
         t0bXwhiwXD60vsVQM7yZODRM7ONt+iVa/kDC1xxjjUSaX9g/kC8NuG7v3Su1nkai7K2G
         ONT0ELKGY5YF3jJZ2F2DmCdDxtlgJgnNrrM/vcppSM25Kbk/JYklj1C1zWQZWOGATCPX
         D+s80JaWvi6Cqej4QbpTfIfBQDfjXjYBnxEGUv6RqrIDVV43ljLgs+PfvZOCdpHPGekV
         vBcOO+4TG1R/e5rxpE7CmS0dlfBKPCHbaYSxu6sk1N9WS0pjXRzZetyIhfiqQZThafKX
         55wA==
X-Forwarded-Encrypted: i=1; AKwUvBxvAbVU/j2xJv4ii3AGg21Tt2F3uERgB/s/1W7DIyN5WOPQSndgK72qAnujuU76ytDoNddlPuA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJy/cTxOwSac1LcKJtJl6702gkSh7dU3yvdYT4fC5vpRZnBsYJ
	5Uu2PN6ntzGVqI3wiCV0mPdL0g+MwW3abu1jDFUu5mVgdh10kFBv7cBPwn9asyZYD/4=
X-Gm-Gg: AYBFou0HzauIO3PaJ0suwAMfJgyFUZR9Dm8AdY/jBuXta5gKsn8PFO9mSjkDWRbXbIW
	6pIFDI1X+3N3xwDOPYLbz69O+uGRELL8EY1bLMhl20wj7t62+2oHgsxccyp9M4/bNk8sDOZ+2UN
	DsFt0CNhTIAS2IzvM+IwPtZI5MsgJKZzcf8+0bxLEASpvoejpcQNrl5MFTEKqc6+iWDmnquaqu/
	yqoFy2tzOFhW3iM/xE3M2o27VMQQPgfyHcd+bYB5gteQ2f7v3lZJe/QgIedfKqT+pFhK4Qn0xlS
	eTEt0PQYopvmYqmByVmRi9Rx7erlvWKyYzvAoh+4oGq1NMWWBAvxQqWO4PWHkv8lJ3jJE5nbyU6
	gjnDY6BUk3qaVwn0cWZ/4MS1M5c5uqgX/O+DcUnlCZSwL1x8S//jqZtkfbCUnOVfi94BHsIpwMG
	gyOKKBOM+dX6JzQaKOyFfySOhrQmayjMBPObaQGYYKHN5ekJhY72ru2cE0hb5bMHYrxgFEJGUlU
	LY9alg=
X-Received: by 2002:a17:90b:224c:b0:3a7:a3c8:8f4a with SMTP id 98e67ed59e1d1-3ab3a9a8dbbmr12756043a91.18.1792049189573;
        Thu, 15 Oct 2026 00:26:29 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac937c4e7asm1754279a91.3.2026.10.15.00.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:26:29 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 3/3] scsi: aic94xx: validate the EDB index in asd_get_tmf_resp_tasklet()
Date: Thu, 15 Oct 2026 16:26:12 +0900
Message-ID: <20261015072612.4144043-4-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015072612.4144043-1-yhlee@isslab.korea.ac.kr>
References: <20261015072612.4144043-1-yhlee@isslab.korea.ac.kr>
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

