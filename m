Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A8242D6C
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537846; cv=none; b=AiAioNejdze9nCfkvVLyNbW6EMxnj8lnWVyPXx9hIRfiE3w8I/7/yz8QlNJpa+OF/q4ivIIu+VJDCq+HDS5luXSpHaxRcuaDxM9bCqDLZoB6m0Ntr23sh0kPhjnsGVAno6GSDleO+D1En7YFJdurlA2/iBxAN0oQuHAz48JcEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537846; c=relaxed/simple;
	bh=kBaky05/bWEVwGI5MJ9Md+7nCGhGs2CIFcJwiy5RU+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qQGDrnBrOS+iDGxTJmiNU2sFc3y9mwQVsjp0q/iUnBw+wSQiMOS4fJM5IENjNDe01qFjr/OPNyDVQ/Ws+ePJ6q5Fvr+n+RO2ACro/xHS9H5bCovw1dEKzCafTAXSqhFXDWx9vzLkABtVeYsV4hnoxEx2LT94f+eOyyKBp4PdQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYXsOOYJ; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYXsOOYJ"
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-59ccf81e6feso40396e0c.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780537844; x=1781142644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZjw5LqBCsF6LARZeB6KcPRWHBTEy3/2seNDJkjrDqk=;
        b=cYXsOOYJaOGQCQCqVC2/0B6Zj0I8qnnTf9ZVsLjqUedyxnfuXxsv6IQK2OgUdGtuMf
         8wNT/syE2DDugJ+NqkJp1MrSy2HvpUVkxbFL85Kv6PzOvketUiEs/a4SWlaXoIKDnXIZ
         bh0UGD5wA0cATHPACD9ditmVTPj7LTJOQXP5TREPu51bGndIX4BginFyqi6Cl05iYM1Q
         6/0k8Ai08fBnl1AE/tQ+3ZU+ZZZxLwiFkzcFBrAw6F26IRV/YS18KHlsSkevaCM2VJNq
         hSd5+wKg/2VcNvtokZ1foPYiVbmsl0MUJr5hiwRIsq6Tv4jTTl8ahDoU0OUoSzH8wx1k
         zDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780537844; x=1781142644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZjw5LqBCsF6LARZeB6KcPRWHBTEy3/2seNDJkjrDqk=;
        b=hiFoSUIvoOcm8ouI6F6vl+3w2jscxTsXy8Ezo1Y7eeZAiFGHSdaHqlZpcv/h8Uu2VO
         qfbaN9jkCrF14XtR39c+imro2rn7ZlsUT/KtlZfNASONKVFh3JI67+iXLOEoT944Rplu
         kXxl7Tr/1a6ElHij2dAQ5RZrVg56LKuXFoMLG2bJUFNDDmNvX3tUT4vA0Bgs5O89rXwR
         aIIO4/Xx7FRNLWpQZUHJ4wjTU7N52wW8joatLwgLxrLlobXMs5TOdpt0wZBHoMnPvoGx
         tS8splclxFP15BhgB+ezksN9DeU6JuA+L5AyF5mWC4R9B8JUI5A0334lV51yLBJ4mS/h
         rkkg==
X-Gm-Message-State: AOJu0Yykh0GmGzRsZ1pDoQeaq1KRjq5IaoPuXq2O9q34XXMsn3vEIE6g
	aQiT2vO04mKCwsMEBEy+tBUaxe8ryNjY3fuwUjyGpcQacAQcN/slg7+N7P4NOPQe0qvh
X-Gm-Gg: Acq92OEFr8jaYMk4jGKnC+QOaCKwbda/VCGXmrEd9ZkRaaC4886+tBy10LiS7HP+hKA
	61FJRLu/bCgRLquRt4XbOH3ziiqxxJNgF1xTDZSvlt2DUC8/JBEuDMfvClC3imN56BZEaAyxznQ
	PGblo2A+3Zvl3YOZnk+0odJcFemUjEoMVLFkGlv9KGNbWW5h9RqAQGfszVlJ+dECVqAtsWdoPFr
	DbLBmJytC8laVD/aWnPZSe7FuxXyunaAEmw5NYXXgwW41v6I5yWvanwEEMLUgmdXLaFdyuXUMMP
	4GMcQx4USaJuvLEOe9xhXq6lHOp83AU0vsCSpQ9cVFR3w0mGwRBErweoEvy4hkMStZZukD0sD6o
	nhUtmTvxxnXjNQkjJdAuobsKK2ygumW6reKP0EiUTA0NhvB7DF0TfGM1ct5hYWGDifp/e85H4tE
	KzQMoBKHM7pR0N/6pfCsipU3TgNLyzj7e6kX2KOJO+XcjsQw9CEiaajJG5H91Pzj/ud1CapfCv0
	NGJmrXgyO7HV911YSnlEtvyDQ==
X-Received: by 2002:a05:6122:1c8b:b0:59f:4c56:9d0e with SMTP id 71dfb90a1353d-5a6e5417d1cmr3590696e0c.5.1780537843926;
        Wed, 03 Jun 2026 18:50:43 -0700 (PDT)
Received: from rainbow (2603-900b-4600-2f85-a2b6-fdfc-263f-5578.inf6.spectrum.com. [2603:900b:4600:2f85:a2b6:fdfc:263f:5578])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc1696d0sm4045908e0c.12.2026.06.03.18.50.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 18:50:42 -0700 (PDT)
From: Jordan Walters <jaggyaur@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] Bluetooth: hci_core: Fix UAF in hci_unregister_dev()
Date: Wed,  3 Jun 2026 21:48:09 -0400
Message-ID: <20260604014809.121934-1-jaggyaur@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit eec3deaeaafe upstream.

[manual backport: 6.6.y uses cancel_*_work_sync() instead of
 disable_*_work_sync() which was introduced in a later cycle]

hci_unregister_dev() does not cancel cmd_timer and ncmd_timer
before the hci_dev structure is freed. If a timeout fires
during device teardown, the callback dereferences freed memory
(including the hdev->reset function pointer), leading to a
use-after-free.

Add cancel_delayed_work_sync() calls alongside the existing
cancel_work_sync() calls to ensure both timers are fully
quiesced before teardown proceeds.

Signed-off-by: Jordan Walters <jaggyaur@gmail.com>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 824208a53c2..b0e0a553892 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2701,6 +2701,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	cancel_work_sync(&hdev->tx_work);
 	cancel_work_sync(&hdev->power_on);
 	cancel_work_sync(&hdev->error_reset);
+	cancel_delayed_work_sync(&hdev->cmd_timer);
+	cancel_delayed_work_sync(&hdev->ncmd_timer);
 
 	hci_cmd_sync_clear(hdev);
 
-- 
2.43.0

