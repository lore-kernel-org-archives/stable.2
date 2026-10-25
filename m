Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892091;
	b=J6Ir+ObTIYanyAZuhLo9bqvatjP1iwd6sM3Nz310IPLcD9rsPzZIZSyRFHmmFbFx9N5s
	 t29JdEGIbmniyF2f04L4oh3IXeO3jnuzfq7QypfBz5kuO1BjgMyH0U69xbc46gNOK7y2N
	 aj5W6+q8+wZfK7HznUuiu0AF8o7mEuMAt2FIb96KOvBpRKcsC0vTDIdUy6YyzuEmfIHuN
	 S19WOu9asgA7OujmCE66hN2Bnk8G1JgLRgK/LprtVXDCpiuE6arM4TWCeFB1g99XTG9Ag
	 KXOaQXzYP3usMQ3ArWmiUsXPOAGw70jfp1J7Qlvpi6GpH/MwgTG76uncFD6XHq5QXEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=TbTnRMCBQfYC7ayg98MKoycTzmcskJPrU2RjQTzdnFM=;
	b=1Y+BMh673YYdO+7zdv35M/WCyIubjAHZiuL0QQi6a4i0i3joQzx5kRZGeYdaWUSnEHVr
	 1xbO/hXvdzYZApVXvK9LRWCF55QuIERshJ9DWWYAz4GLvHV50gan2K5TivF5Mk+shFwkB
	 565559UXsmuG7NAwHtG53CDazvxwX3ZLdkg55R1f9I1zk1kF38PsHBTjSWjFXsURrRL54
	 lYcYKVTwuDZnZbz3aV0SfZxu2Oy63A2pyzquxIGzDu4iuT8NKVv4h3bc3scqv4iLB44G7
	 uE+pZc8+7w9kh8Q2i6T7TMogfsE1POyogFfIOT5XZu6AhWqHx9DxTkMJGKYbXLPeuCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="oV5/SFe2";
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621E606A32C
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B621E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oV5/SFe2
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e987ec84afso18131905ad.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792892090; x=1793496890; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbTnRMCBQfYC7ayg98MKoycTzmcskJPrU2RjQTzdnFM=;
        b=oV5/SFe2NFxYfbRwtu6Y38/yXzEQMRP6yK7JEBgNnKY68YkDw3XsBqiO2RZGFAmHDQ
         5nJL1UFs2QqsT56wZIcgpcpdgA9B+xI+mij8t/izgrnl4YuAno+OYbFTaEHhkD+4JjRq
         r7+pX/yBPpKSck5nQEQnMPyLIrKCh97Nv6U1piYiMmY9Ic8DQBmKO1VJS3QzAVeDm3ye
         OGRooGiVAmD6zcWqP7Mqpurt6T+RpQVxxuRTETwfhimK79KU76NpjDD26sMLaly8rnkC
         rj5c+B+4l5GWPMQ+rDd08Rtr2wi3u548gIuMS8Gwl9+OCedEeRPEeC91JJi+uovlAu8k
         Emsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892090; x=1793496890;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TbTnRMCBQfYC7ayg98MKoycTzmcskJPrU2RjQTzdnFM=;
        b=X7KlU7d7GLtIcMdfoql4iQQo7s3aeHapZwFtvIh0L09G4amp9GJxGdxJe9uSZ5Lw9N
         ApIE4EmtvgGQq8GvO1UxYJpyT09aJjphS+4XxNlsgIZOe+yjSRGFu+9Qy/OhdyKqnB8Q
         0KRAb7sxlOcySlwcQkEjhB98bFgc0ykeH6OoMYrufSfQfBuHLiNVSl5Z5vaR6/fmfM2d
         +MVFDQ1qePlTy2vgk8RnZ/KNUYfohVbFZ5x8BcZ68LpfNDtb5+c7F1jryaUMPuQQghI9
         Fi+zKBAdxYash9HF/cRqv66QWR3fFjjKImSl1k0vDEi5U7SJoT0mFveJiZs3+L0qqilN
         RirA==
X-Forwarded-Encrypted: i=1; AKwUvBztX7zmxrwsXwxB6eo6VBNFIjsUJDYHT/lBgNRJ0bkBfqHt2FCet+Q42K1dTpUwfFV3p4qd1Mw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIGI3oVWeizjvo+Cx9Ate4tFwGdeklljdVmVD4fkSgEV/oxRRM
	nmyUy/nyPAKlO4N3m1IWS1xjK4u7VO5uVKoTjRPC0dZZE997f3vcib9fQcU8wXktYxTFhJDb9Z3
	cnmZJHWDAQplAqEjwE2c2WQ==
X-Received: from plv18.prod.google.com ([2002:a17:903:bd2:b0:2e8:2820:a41c])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d551:b0:2e9:4b32:fc6c with SMTP id d9443c01a7336-2ea9c69f27dmr26583275ad.26.1792892089910;
 Sat, 24 Oct 2026 18:34:49 -0700 (PDT)
Date: Sun, 25 Oct 2026 09:34:42 +0800
In-Reply-To: <20261025013446.345974-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025013446.345974-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025013446.345974-2-stanleyjhu@google.com>
Subject: [PATCH 1/5] scsi: ufs: core: Restore jiffies conversion of device
 management timeouts
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	Peter Wang <peter.wang@mediatek.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before commit 08b12cda6c44 ("scsi: ufs: core: Switch to
scsi_get_internal_cmd()"), ufshcd_wait_for_dev_cmd() converted the
millisecond timeout with msecs_to_jiffies() before waiting for the
command. That commit moved the timeout to the block layer and assigns
the millisecond value to rq->timeout as is, but rq->timeout is in
jiffies. A 1500 ms query timeout (QUERY_REQ_TIMEOUT_DEFAULT) becomes
6 s with CONFIG_HZ=250 and 15 s with CONFIG_HZ=100, and NOP_OUT_TIMEOUT
and ADVANCED_RPMB_REQ_TIMEOUT grow the same way.

Restore the conversion with msecs_to_jiffies().

Fixes: 08b12cda6c44 ("scsi: ufs: core: Switch to scsi_get_internal_cmd()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ee643830a57a..5193be703752 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3390,7 +3390,7 @@ static int ufshcd_issue_dev_cmd(struct ufs_hba *hba, struct scsi_cmnd *cmd,
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	blk_status_t sts;
 
-	rq->timeout = timeout;
+	rq->timeout = msecs_to_jiffies(timeout);
 	sts = blk_execute_rq(rq, true);
 	if (sts != BLK_STS_OK)
 		return blk_status_to_errno(sts);
-- 
2.56.0.307.g5fe7bd680c-goog

