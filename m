Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF621FF2A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805281; cv=none; b=VocSNbSFFC/XhvAOHVJD8eJ+SXrm69Vi4QwwboC72ImpX/BOY6tpStajtA5s8u+TYsdm620i6XsH6xVu8yqKiEx9nNq2tMWmZD1PX6XBQ75Jt0Ioz/nNPd0b3+9lQtPlbFmM4qae5iwweNg2pWe2sRf80FS5wTKii2XvFh+baIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805281; c=relaxed/simple;
	bh=9f1qP22E7ACqG8t1APh1XFdIVpv9e3uZVhIP8YPFdKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBr1YQDi/HZAyN6tj999Ni6ycijCILARpYLQFAU08GF6ccaSVsB1zGA0DXlKnkz3YziSd0Oplk7dwpMrhi32PhQXJdzx++5bV0kL6zgWCmMklAfsFT6wRS+v34x0bJO9p7H5lodHLoVMBwwQJ0+FGXu5XBj0qVEau7cSbmFhLDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=zO+WFfWh; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="zO+WFfWh"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-170135e43c7so793222c88.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791805278; x=1792410078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aa4X8EZIe6RRJuWAcoODb4Shn92a/60HzOzQllDMN1g=;
        b=zO+WFfWhDdnmruaoe1lkfDrhV/Qm9cyhgfimNCJdksBOKXdztg6CEQ0reZHIsbcITs
         EXhzq4hLSz0+/JIDUdb9PHtlxHUaOrtkMbvQJdeTpcKMfDmF4V7D7wMc+f/g+on23n9K
         bBtt/M+19nSVdXka5/pJYZLsUkQ/gRln20nRUmt1iw0pRyLYrE/3KO98jA/4DfXrWch2
         +Lwm3A44EW3mthVNglpjSh/bIU4hGhUIQ39txQ+glrUrwiB+3Ij6lK2tPNml0BiTyWRx
         HUNy2jFoqu5bBn5sOHI0FxQOce4IP2VrLY8prRJpOrw6jEy7f/eRwWcrW84uGhrm2HvT
         i8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791805278; x=1792410078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aa4X8EZIe6RRJuWAcoODb4Shn92a/60HzOzQllDMN1g=;
        b=xGqz8kGMYd+Y1gQHguBjY0st+McNe+1cWzadI0g/T0bd0MQe70U+ym/y+JKq7Ahy4e
         vqSLedfjsKvDu1mubzYzHjKF7FMm2MqfLwdRFNZxMnRQPY4zgBMul6NlCTsAglUnJttw
         /in+oRghUu6Xen5YhohNHWGr0uexBUYFME6DeYn0QRzs+XrnH0JmUzJco/LFIauo/1PL
         XxojwqDBiCxuap9oPu4m6F8Kpq6R7dPC2T+ZuWZD4M3ql/STo2671OKIfSQqj1g4VrOE
         z8Pd5FjtdB0w1+ukiEXV63Kcik8+5I/tP0cIoRzULb3HhBKIBOuCvtcTRo+6eX1BkHwO
         ytRg==
X-Forwarded-Encrypted: i=1; AKwUvByjWI9pnL7SH+owJIq5PFqwl+R0V58ptUM27bSHcTQmjL6BNFud2jBCHy7PDzZ6YLQ+GsNKdN4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLh2kSBa8ZMm3OPSMRI5iOJlYWE9cLDhY+sIMsGRe/p9w2STL3t
	TJ3/NXF4/b7rXhit/8xLQQNND5h14D6+7+g7LJVygAh0fGp9kqPsdLD5oseJHPjx/eM=
X-Gm-Gg: AYBFou0FC7ZNOYPu46o99kol0IQq5+X+I93+G5OoU8Jj+cxhk1k8MjnCxRO+RRS3aDp
	Ivo+rHhu+bK1jVGGpWwQhuuZxaD7wyS39wWhOqrY45r6b+U1Y0ClZuDu1DPzvNgVRRQobkA4MWa
	uDWBpwDn7zODQqekuLNXEwhdW9B4GpjKz7PQuFvM2sJCWDo9/pq0KAG3oubyTSaWc9phWwfPuFm
	UNdn/K/y9iqqqy1L/CewA8zvkvrowrdeR/EzIeMbBmjfEgB7tRL0SuYz1jeOWhxjpB3/1cdwLWd
	JLOoYMIT+H9sJiCvJdxxzbP+LEA9mNl80rHusrSPx04mGTVonam+PE222ohZxcXu7DsSA0jlvd+
	thjoZcHVzGAlROu0G8g/NxLM9rMGj0B6f65SIt2t/f46Tem+YEbCgwcXnEZwKJxcMnLH36p0N+Q
	7SJtAqqwwaYLPdz0KRhjR4MsrqoshUF2MiWv9t0I8LXjuyiLKxluJYEkD/vkKpWWu/eA1r1d8Vu
	vGowHNm1UH9cANfJxgDrQ==
X-Received: by 2002:a05:7022:7f07:b0:152:91d0:dfc3 with SMTP id a92af1059eb24-16a62eaa220mr14745427c88.23.1791805277782;
        Mon, 12 Oct 2026 04:41:17 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:7bd2:1202:246d:44ce])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm8725533c88.13.2026.10.12.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:41:17 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v3 0/3] scsi: arcmsr: bound adapter-supplied completion indices and message lengths
Date: Mon, 12 Oct 2026 20:41:00 +0900
Message-ID: <cover.1791803953.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arcmsr completion and message paths take several values straight
from the DMA area the adapter writes -- a completion slot number, a
type B completion-ring index, and an inbound message length -- and use
them as array subscripts or copy lengths without checking them against
the array or buffer they index.  A malfunctioning or malicious adapter
can therefore drive an out-of-bounds access from the completion
interrupt or an ioctl.

Patch 1 clamps the firmware-supplied message length to the staging
window (heap out-of-bounds write).  Patch 2 rejects a completion slot
the driver never handed out (wild pointer load and dereference on types
E and F).  Patch 3 wraps the type B completion index before it is used
(out-of-bounds read, and an out-of-bounds store when the word read is
non-zero).

Each was reproduced on a KASAN build with a crafted DMA area; the
per-patch changelogs have the reports.  The three are independent and
carry separate Fixes tags.

v1: https://lore.kernel.org/linux-scsi/cover.1791789900.git.yhlee@isslab.korea.ac.kr/
v2: https://lore.kernel.org/linux-scsi/cover.1791792888.git.yhlee@isslab.korea.ac.kr/

v3: patch 2 -- bound against maxFreeCCB (not the pool size) and clamp
    maxFreeCCB to the pool at init, so the index cannot hit an
    unpopulated (NULL) slot; v2's ARCMSR_MAX_FREECCB_NUM bound could.
    patches 1, 3 unchanged.

v2: patch 2 -- bound against ARCMSR_MAX_FREECCB_NUM rather than
    acb->maxFreeCCB, and on a reject release the entry and step the
    queue index instead of stopping, so the consumer index does not fall
    behind the producer.  patches 1, 3 unchanged.

Yehyeong Lee (3):
  scsi: arcmsr: bound the firmware-supplied message length
  scsi: arcmsr: check the completion index the adapter reports
  scsi: arcmsr: wrap the type B completion index before using it

 drivers/scsi/arcmsr/arcmsr_hba.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

-- 
2.43.0

