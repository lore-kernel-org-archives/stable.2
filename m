Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3433EB815
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339162; cv=none; b=MPyLZLWupsdVIRweCV1aNExT/D/dQx2DvsIXVi0uwU7q0KFdpfLJ1KfGHL1MNqSeFJuF16Uu+/KSwyhZxjWtEGzSAwdkfdXGLKbQ1zOvvx1HTvYFGF/wjwUtAZnLEJL7riPt7QDzrRNsMO49QbNrZyl1PIVS2MzmTjPZWV+c3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339162; c=relaxed/simple;
	bh=gUU55rnPa2yoR70v6DkK3q8d87edYW/3hRo7Mo58p2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACvIhGGIc69cHEWfSj/G/0U3EzLnvxiY9j3LgiwsOSsIijAslgQKLeJbJ+knT/37JT8hlPFhgwKsAQLWy+JNXNvr7l/+ie3YcTWnfiiiWszyenqJQbvH8L/PoC2Nt0IjSQFueAAVo2Ee5Qw7C1eZfP9AjU7ukK1QSPD4CzpgfWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jj7rrpzv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jj7rrpzv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so915156a91.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788339160; x=1788943960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v3FkXABhM9zrrvqkbDsCZIOIRL6LKHNZMT148w1DCsQ=;
        b=Jj7rrpzvvoretNux3pPV1vKkc8t39ml/4MZ8XMmHJ02nbc/x0aGL/i5nr6Xx/YPFYs
         2HKwUgZEeqwbvFXf0VbXuROzwMvALGGR7nVxUMpiMow+N7lztrCRvwppe9bOeVSgDT4r
         NUpnDkRM3Oh8Xa1wj5bzEdTXDGsPCnX/Q7f8UCAg+mck3h427DCuv2hWFL3IV1f44lEW
         tIGi92ACWLOAA0pmjzhB0n1MzkYcUQnLv0cRHGtyEdpEqn9msm8xkKVdJZc4q9onwIG7
         1QAhh9JyY9aVq3X4PJPKxCEmPP238jaMG8Z7H0MOsJ0hEm1V+ceWIkUmS1XV6Ue363VW
         8bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339160; x=1788943960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v3FkXABhM9zrrvqkbDsCZIOIRL6LKHNZMT148w1DCsQ=;
        b=WwIXkayi3aW3BDJugoaC4eYNvZT1NFQlmnl3FU3QrcASptwtNG1Uva2DRS73T5edNT
         iRH2dHb/zEh4PCqbfn0VmAp2AsCmoAdv1CyPv0gmxR0ssuWEyR990Hjv5Ds4bJVp5kcN
         rYcgSuBGd4iLmAeojpvqkbTV3zsNiW1PaYk9OG3dQzFcHKIv+EMLMXSP5phcbN4n7rWp
         Rj7FM7HtsUF8gz+7N0fTFYrXFPLsOKJJ9xk5FUlCFXKTOs42UDS14dNn82VSyLVwKPg7
         2RFVYcVltt6XmFuyyceflApRoPZj5tGmeAYCOrU8QoNRyQp7NMS3XdTBhvDJ/xWKLukN
         RXKg==
X-Forwarded-Encrypted: i=1; AKwUvBwHCswpVssvUG3DgCEP0eXe8wat08MBU3JbWZw7U7Xe6c0LiZMv2p2ZA53sKiQp1GYClein/Oo=@vger.kernel.org
X-Gm-Message-State: AFuF++n3cXhlulzpqQroZLvj6AjFfwsqy8r82ENhDSN2TmQgWu3zS2ds
	Np7+mFyzx7RW7X7hm0qhkoVPOJSijYvuggHq7LYWsWTqPUzL8NCoEH96
X-Gm-Gg: AYBFou3UxEtOnWvgfq1+MT+geeV8gIRe3m7rhptgdumJyD6hkYk01seFhxyTMauy2EL
	MSMuci0tV6SZ/bPnROJ3HbAq8gVdqpSa2ja0gjDN/b+EQTyxn0L5t/JaB3vxqjOT109hYPMLdnn
	i5bTZsKr8Inf048CCdFAl9R7fAdc4zKW1E4n7PFKa+l1ZzymLnrg1wJRpBL6YKnaVq79o44gADZ
	YojMglrpWsMYwJQoS2khY0HuVnJbdV36YEaunIuLmyAjAAbGBrIv+OaUtAdYuFW2l7jJhD6zzj+
	0/bJNHIVTdgZoyRZJ9Ntwxdc/LJXSIlyn0SE2CA3dGxZyB/XR6NzNqXBizj5bZHW9AR2yA+dZnY
	f66nmTqxWrg02PtNLykDtLHFDL2k/noMAPx0CVLxsDXQw8ew7JU6+l5l7kZg5ywPVsXPLBEBGfj
	1EOIFoyKE5tWbukC8tLKA2LVr+fEQnr++ctOfpST9/kyQUqK+CtRAzb1tGYmdpfwVvKIrpRKKbm
	29f
X-Received: by 2002:a17:90b:4d87:b0:398:e436:370 with SMTP id 98e67ed59e1d1-39aedf66692mr4193494a91.2.1788339160457;
        Wed, 02 Sep 2026 01:52:40 -0700 (PDT)
Received: from Default ([2409:40f4:1028:3142:b3d:c633:7dbd:1e80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079ee369sm4927157eec.7.2026.09.02.01.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:52:39 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: jgg@ziepe.ca
Cc: leon@kernel.org,
	kees@kernel.org,
	Tatyana.E.Nikolova@intel.com,
	roland@purestorage.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	larrystevenwise@gmail.com,
	pj.waskiewicz@solidfire.com,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+bd317784d628820741b5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/core: fix refcount bug in iwpm_get_nlmsg_request()
Date: Wed,  2 Sep 2026 14:22:13 +0530
Message-ID: <20260902085213.145312-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iwpm_get_nlmsg_request() initializes refcount _after_ list_add_tail()
making it accessible to global list where another CPU can kref_get()
on nlmsg_request causing a refcount "addition on 0" bug. Fix this
by initializing kref _before_ list_add_tail() so refcount for
nlmsg_request can be incremented/decremented normally.

Reported-by: syzbot+bd317784d628820741b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bd317784d628820741b5
Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/infiniband/core/iwpm_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 990cf928b32a..5d07c5756987 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -313,13 +313,13 @@ struct iwpm_nlmsg_request *iwpm_get_nlmsg_request(__u32 nlmsg_seq,
 	nlmsg_request = kzalloc_obj(struct iwpm_nlmsg_request, gfp);
 	if (!nlmsg_request)
 		return NULL;
+	kref_init(&nlmsg_request->kref);
+	kref_get(&nlmsg_request->kref);
 
 	spin_lock_irqsave(&iwpm_nlmsg_req_lock, flags);
 	list_add_tail(&nlmsg_request->inprocess_list, &iwpm_nlmsg_req_list);
 	spin_unlock_irqrestore(&iwpm_nlmsg_req_lock, flags);
 
-	kref_init(&nlmsg_request->kref);
-	kref_get(&nlmsg_request->kref);
 	nlmsg_request->nlmsg_seq = nlmsg_seq;
 	nlmsg_request->nl_client = nl_client;
 	nlmsg_request->request_done = 0;
-- 
2.55.0

