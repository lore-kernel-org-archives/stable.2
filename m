Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67D4AC17E
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052397; cv=none; b=g36UzaLZhPNg6I3q9crb57xTyZ2bJEJTBaPjXYJVmeHnVMnnoYrjRaDgkrnbpw7dUMy5CtZ/dfsrQIHP4rvtbxeyuCUDTA/L8nsKmuqmn5vI0CunVremJFktIX0AV2ddeYdpydcdNzw/JBVdhou1fj12Oy6IKAzguWONpiuzuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052397; c=relaxed/simple;
	bh=cLnGrFj4fZ5QbMee1ofZJxYlwDb4ml+Hkm+YEE7tfAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkuVYvTDqMyKGQ4iw0I6aUCWG8z5BWdHg1Rb0fLv003RfyiMONrknd++2tiXI1xLkqlGqBwMcMQzYUPww+4CJB9ITWbFI/wXGq6vwMVYsKWI92cBCJoaAgFE7+jng3ETXO/ii6hylxqlhjwWfedBYiod1hzeH/geam5HmUYDCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=pC1zgxG3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="pC1zgxG3"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1068840a12.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792052395; x=1792657195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG1zhfPiMXRFUFNZwJgHDsR7OhzfKqj2uZPWv/pDLsM=;
        b=pC1zgxG3Bqw/RRp2/Et4Cvqg/mdyORE6JqhA8Qj/5Ci64YxumBvVkA3YyXmRIh6Nar
         yqQ6suPM8GT/kSiHHO41ZEC9CjGywaLi8BoRpMSWF/Wq3VtIfkTPdpz25OZwcame5I8x
         xwuiaf28KyLSwTIBKIrwZwE1N/7ZAKRYJG2lD+1A1+xO4IXqTMhqcmlNBrQN9QDlUWXH
         wWd3zqlhQSMG8F2CMxi9aSUIC6UsmehIuMYJ39j6duZSYiiwFl6MJzRCcTftAes1NzzY
         4YH7St6O+Fp5ZmfO1ai2EtNqjN1MjmnEe3P9dMdcKOOUe7Y6wFIEsrzZEJiYaVmuoRyJ
         Xnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052395; x=1792657195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HG1zhfPiMXRFUFNZwJgHDsR7OhzfKqj2uZPWv/pDLsM=;
        b=nM/KtkTGPlZoxwJ4vroO5Fh5RkAbIPhMzbS09Fw8cLnar+NIdnkRKUW/qjvhru+NJv
         wTmns+WYjo00r3o53M+8s9TVpM8u1c/Nk9nME+lMkyhLNFIXdL/TT7J0kHYN+o5Q0Pco
         vuRaEB2xAOIPvEAQYIA/dG8JRjSzX5+n0G8SR5tFXnUE7heoLUyzwF+eYwWc8/6vHv88
         oIBifs4sUH1lPs0EXGWJqDYoWZa8nAA8546TCn0nfy0eMjDHFgfjhoeXvgkjDDsTexQ+
         dg7k0/RNr+yOqgw5V2Le+QozZL5YkeXhnqHbZMd1Nv7w5I85kj93W95/1x47D5T+MAio
         hrbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwU0D/35ApJu+xGd9msQXyQQ3wHhB72Pt20j1eQ9wKGvAw+H2J6vKuAWPt6IayFs6nAGMu3uoM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2WEBXrJDW22k777bJDbjnK7bzpYoKHwgIDp803TAtDBegx4vC
	DzWW+NT7sSi+M9NdjA0iy7GrgwurzeR3keQdpl2mIRfthpjNtBlypQwBU6lKiqlNhZk=
X-Gm-Gg: AYBFou3wJpm3uAgCoOCzMDrfzBnXGzeTOa4f2SJtsr6POtr8mdonPWtvRcv6+nxoCyN
	X4Hz6qQqJJLHRnECrQelq7290FSTTwqqJZN98uqs8GqpBcV5a0IxFDUoKdZPMhlkxoHtd6dGy83
	KqN5ESJddVfeU8E24LZVOla/pKCpar8b1FTJMwh4u5Kg9zt68nHuefFtD8m7xPUpUaOIc+rzatj
	6NSHk+AXj3fjttzI6DqT5+Ny40LPSe9ds4otEJYBw6nq7y+6He23Y5MYTzoT79rqQDrtwbKRvYA
	AXC2duCCa7/4F8eL7Wy5hH53PQQktnZgBWU2KSyNgRs7bDSLFYKX0+/m6cZUZSICg+/eiwhczwM
	ik3zvzr9VdDJofgdTuQwyb7XaQVfqjfRXDxEQ0vziayFk+wOs0waDD5R8lQMsLftrDYbCKdkBOk
	X0GiXRRnB7kMIEOsXdTZvEZ0qAksYRJG8sJZD/8KIZw0NYxviWu8GTKJyYY1/IhoY+ws3yapSmZ
	5l/v8nOjtlOlKcS
X-Received: by 2002:a17:90b:2d86:b0:39e:359f:8539 with SMTP id 98e67ed59e1d1-3ab3a90b5f4mr13911476a91.15.1792052395457;
        Thu, 15 Oct 2026 01:19:55 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e755bsm3319784a91.2.2026.10.15.01.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:19:55 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v2 3/5] scsi: aic94xx: validate the EDB index in asd_get_tmf_resp_tasklet()
Date: Thu, 15 Oct 2026 17:19:32 +0900
Message-ID: <20261015081935.4168771-4-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015081935.4168771-1-yhlee@isslab.korea.ac.kr>
References: <20261015081935.4168771-1-yhlee@isslab.korea.ac.kr>
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

