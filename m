Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF1411A0C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430700; cv=none; b=JA8iGuPr3TD6jkapkqDbn4be2NXT4t8B0BDwYZD0m6lFrPT7+9Y8dZDmjDEq3HlP5VFa5/Av9ky3OmfG3HbfmWxQqZouqlyxkiioUv4wY6s5yZ3sIXYjZObROgV5dY1HaQFeJMD/7NcvWSGYxMaRopc4axBeq686+Xs304pG8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430700; c=relaxed/simple;
	bh=nkJijpibfrqgdl3VNlBSmGDYeRp7RjJg/vx3pVX/fCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oov2DwUeYNX8Oiap415pZGNTL8dcDdvLNn+PSC5hhZPBevufibpb3DFceJIu5BA7vy33fq6Yq6dkmK+eP01ggd9DPwJ3cPdBcLyRM8uBZdtTzM8Fj7c0/hqqbms8v1oNprXZiFipfOpEOKgk9NLK9+d5GNLHrQmke4fY1dZX9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWJkcBAs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWJkcBAs"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso1778889b3a.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788430687; x=1789035487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7T99HEkan7KgLe3r/HM6KiSk1eXB+cQcUYwvOC4cMw=;
        b=HWJkcBAsu95hlx2pBvbtSGuHrlLwVhkwVTvnpFTRZxufDMpanXCylGnqjUV72Ee4Kx
         IHupsghYfZk45lzWRZD1Byx6LgtUt+0WqAhutEVksnDn5Z9Tp7mYOFRznLWnL+XdNRR2
         pYK8XYrKdtb+hG+RWWZ6LZxYLyyIVdCNxmrDF7uX6ZGYJi2NrvJ+zoY5SUi9Dy8AVOru
         wlRBwGU2gO1f3lZ7ErbWvUJXEe6es2P/BLdmJz5toMVBdTI9A3pjDeJsmhTqCzoKZ50s
         IlZ7XBXI0tEAOyeEFYeIM35BH8vth/209X0x0DQfCHVmtxMw2MB8sJtMlAqKCiVC1+KR
         dZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430687; x=1789035487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7T99HEkan7KgLe3r/HM6KiSk1eXB+cQcUYwvOC4cMw=;
        b=VeDEvSSyV+Oh7d0L0SYeVe3G+pGRzpMF4nkfwcz7sg/GREOKjBNieIdOaS9LTEtqMJ
         ATnu1q8PkwB3aMhglnoQatvJg7A1isIHRWHLyg14n/jbpf+CdaNgZXjcyrDnwCXanoeR
         1ck73KPInZ70hrBy7TT6kPqTxM1KwbMaIihUo9j6x8Bh+hbr1HEAsQxkBo8gl9SKQVOC
         fU/bzULs4LAI9J3LFhAg83kZnGA+NZo+aiNYGP+AUnhW8TLC0ZcLVQ6n5x/tQZzrzJj4
         e+FhweJK4dHBIF5MPTeii/eIxdS2L3HDVvpT6ze90gwQaQpCgfFQikPMXy8WnTHHddp/
         m0kA==
X-Forwarded-Encrypted: i=1; AKwUvByap1txuJNTzytSvWxSQI8nFWh20GybrnNMjS5CgIhrfriSxxkAT8STG3kd/XkA4eVcly6PW9s=@vger.kernel.org
X-Gm-Message-State: AFuF++lVTsNEuAql21FPwuvE60C2R+7AdHmeyuq4VdsYF8DmZKay6yrK
	ad0snQbb/zN5mWFLrz9vpVhE+LneGXxg8swjQaK0RPEy4BS5IAPEkCiL
X-Gm-Gg: AYBFou0keT9pznDsOKQSfWelSe8q6jt+MRBrrdeATtsvdNzVMRQDvlMH3JHTOtOqCVQ
	iY+9zqDUyM3K++EBntmzOe6g1oNoSXIkwVVabnkoYzKHzTzH1csIoMKE6Ph1+fhQsCZQjkltuss
	6DXCbsQr5m2yvSXEwC8r9Ynp/pIWxC6OcJ6lNKZD9qsZ6TMTAZioa6w337w4mF7aiQWVSmmvk5B
	1yYjM3cqHwWzv9F94mzszO5qdmEtO6ftYBmEN2dJXmTvBUDzD7liiDW5Fd67VW/wDEYWMw7qt3P
	+7+63KH2/CrZgXLzpVVVqja1Ui/tH68hhzPOzIeJW2rjE5KpnDlkXOVVujg3Z2NlJ6s54c+HB3i
	hwvF4l98VrH41n1BduNxXnyt4c4V5KBrY5+YTcjiTj2rPcbJFRfhal+sU9wBuh38fBgyO3oVQWh
	CfVym70itgFQewZs9gXk1g+H8kPmTyndOvcfDi4Ke0WMT19OdNqJbdDOLHF7I7Q8qlOhaS2Ks4G
	rN+cw==
X-Received: by 2002:a05:6a21:3393:b0:3cc:3d08:da3e with SMTP id adf61e73a8af0-3d9ad570762mr15626344637.2.1788430686494;
        Thu, 03 Sep 2026 03:18:06 -0700 (PDT)
Received: from Default ([2409:40f4:101d:3568:cc14:1945:50bb:8f16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325534cd65sm6078036eec.6.2026.09.03.03.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:18:05 -0700 (PDT)
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
	jeffinphilip14@gmail.com,
	syzbot+bd317784d628820741b5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/core: fix refcount bug in iwpm_get_nlmsg_request()
Date: Thu,  3 Sep 2026 15:47:42 +0530
Message-ID: <20260903101742.214304-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902085213.145312-1-jeffinphilip14@gmail.com>
References: <20260902085213.145312-1-jeffinphilip14@gmail.com>
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
nlmsg_request can be incremented/decremented normally. In addition,
also initialize every field before list_add_tail().

Reported-by: syzbot+bd317784d628820741b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bd317784d628820741b5
Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changelog:
   Changes in v2:
      Add list_add_tail() last after initializing every field as per Leon Romanovsky's
   suggestion.
---
 drivers/infiniband/core/iwpm_util.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 5d07c5756987..51af8c1c49f9 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -313,19 +313,20 @@ struct iwpm_nlmsg_request *iwpm_get_nlmsg_request(__u32 nlmsg_seq,
 	nlmsg_request = kzalloc_obj(struct iwpm_nlmsg_request, gfp);
 	if (!nlmsg_request)
 		return NULL;
+
 	kref_init(&nlmsg_request->kref);
 	kref_get(&nlmsg_request->kref);
-
-	spin_lock_irqsave(&iwpm_nlmsg_req_lock, flags);
-	list_add_tail(&nlmsg_request->inprocess_list, &iwpm_nlmsg_req_list);
-	spin_unlock_irqrestore(&iwpm_nlmsg_req_lock, flags);
-
 	nlmsg_request->nlmsg_seq = nlmsg_seq;
 	nlmsg_request->nl_client = nl_client;
 	nlmsg_request->request_done = 0;
 	nlmsg_request->err_code = 0;
 	sema_init(&nlmsg_request->sem, 1);
 	down(&nlmsg_request->sem);
+
+	spin_lock_irqsave(&iwpm_nlmsg_req_lock, flags);
+	list_add_tail(&nlmsg_request->inprocess_list, &iwpm_nlmsg_req_list);
+	spin_unlock_irqrestore(&iwpm_nlmsg_req_lock, flags);
+
 	return nlmsg_request;
 }
 
-- 
2.55.0

