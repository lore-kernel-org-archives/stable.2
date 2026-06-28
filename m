Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2111A5B8A
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782639776; cv=none; b=RrJn7UtTAauXGq2eLi0e1v8rGtUIpJ1L6sW3Mf1ZIFUaK/0IEmRfGEj49YLWXmpg+wVfI2uvjw+iWKyI0Gxyk3HtRIxBrzAQpvZeshVy6gv8pJkGWTr7JUHkuE3npRihkZKRAVsbK+YzV5NUZt9cwkh42BVg1lP0pyYiNyoDCW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782639776; c=relaxed/simple;
	bh=mhmLXscI6NQQEl70eju7+aXlhtGYE6nMOBb0I5fNLNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9FQS/XWn5t+MV0/3omu8DAF4AwviQ5QsMYctBR8NVfBhqGVUnC75UGjnOhgDJwwKw5FDLfdxi1sorUHgVa4h+g5RAmkg/3iIljQqpz/qTsiIsOExezZH8U+bc7qyJfgBVmPd29ZaoAZCpYLQ284F6hMFo8shDTCBh7tn3fMlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlOB/FPY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlOB/FPY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49249707788so19338975e9.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 02:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782639774; x=1783244574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UqVt+RIteYYvNTCyf7JhD0K57WM4+XbG2izcVTYOpIA=;
        b=SlOB/FPYrV9b2whuUJSJc+ra4YuukppavegQRSdIaCA667GrgMn7BRmrnmcbbxCU1S
         Mwy0bWmhoQkB4t9Z9ZS5WNIdZxG2/sjMurfrk/tuMSeCF/NdfZdR7bVZ3FVckoGfwNAD
         SFWK1QfMVcf53nTThG2QH986ZlcXUnSSLRv3s8mbNxueI1/Boh/+qJOR+/x5CNCkrUpb
         u1uxm8P1Rq49ruEG1L9ZN2MsjVFFy21gHx2MV62B/vk/kAnycB5uRABnL/h+gCTr6VOP
         Mr3V/bfq5MPSwYwnbgYVEN1+AibVaFjRirO9Xs+NqjiFScSBO84kenigy4yykRWhs6RV
         99wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782639774; x=1783244574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqVt+RIteYYvNTCyf7JhD0K57WM4+XbG2izcVTYOpIA=;
        b=O1zJFp5YJ3YBPfOyLrqdTZsUnzWKSJuOt0kj4sVxCHYlX6RYbvqK2UoZpuwi6hnL7P
         Pi/SRcPYeaISpRzTbilZEOk/niEQGs15tUIq3WK5X6WjsDsL5wFAbz2ayUwocQHoMGo8
         peJ+C/bje2k+R05Cvl5LaxanpEUBFB9ZFQ27ONHLj1a0GJLcWGc9Jbw06xlNr450TDzd
         IqZUZ9/LWWTa+7hpO1QMug7XkiWxjCZ4LMnz0UwwVSs4JyASdfwt3V9PpF2haFG3/IQF
         2YBLI9X5UK7hltzuxUr62X0AG4rIL0IidZqLarbb07F513VJYIqZPs1npYA5l1X/qQga
         josA==
X-Forwarded-Encrypted: i=1; AFNElJ/D2e414YZwjiCMjljExG+uoumBOM6jibHRipawa+qUkxavIhWJ1gKUMX2qA15/xQa/ILxsgbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5YDJZmUpgre1QtEpkDwrapydxbK+7BPtRpsGIvw7VGn95HmF
	g9I85IVbqou5wQmsNwyV/wN0z3JFuhGT16wn5q0p4c1XdKabYALJ3Z1x
X-Gm-Gg: AfdE7cmTm7EdY94TFeKsciYytbb9gUkcjyPKNFfmBzKmAoPQ4oIdygPpG6U/XAxD4AJ
	I9rZdC7bs8l9q1pf/x4KPKSlMkthSsRiW/c9327rirQ+otV4xvF5wJYnV27HbMrt0NJY9730qyS
	X4NlMP6ooZIzadIhNMYxeC9mKjmmETZ8TfZnrqB+K8toiLKk+LCG9gn1cht5qWJuHVSb8Y77lYR
	oWwveduWQjOa2y0DsE+Gei573c6ISnNSiYnPVM3kFu8BCAsW57bA/ZN08NQkUHeQslV5TChk7XX
	W1BitsFms4ZG5AS8kjvqNQfum/Wm7Jn+7/9NFu/dRIiYEmw+4Qcjfc8y9MJ+C8UI9VzxL9FOn54
	rZLmCrhynxrGcUYAx1SQeh8XVkrxzPsFp73HYpdfA8eJDfWkMUEDOlf4KAtugeyD/kr+BlKTlS4
	I0I6AtUgLmw448fkYhTZfgCmyhAA==
X-Received: by 2002:a05:600c:4f83:b0:492:d8be:2c0f with SMTP id 5b1f17b1804b1-49398cd4600mr62591975e9.36.1782639773581;
        Sun, 28 Jun 2026 02:42:53 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28c51asm121739045e9.2.2026.06.28.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:42:52 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+ae466a728017ec940b41@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] media: dvb-core: pin frontend device through release
Date: Sun, 28 Jun 2026 11:42:05 +0200
Message-ID: <20260628094205.44981-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_generic_release() drops the reference held by the open file. Device
unregistration may already have dropped the registration reference, in
which case the call frees dvbdev. dvb_frontend_release() nevertheless
continues to inspect its user count, wait queue, media entity and private
frontend after that call, causing a use-after-free.

Take a temporary device reference around the generic release and the
remaining frontend shutdown work.

Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Reported-by: syzbot+ae466a728017ec940b41@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ae466a728017ec940b41
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/media/dvb-core/dvb_frontend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 7aebaef18191..1276fe704675 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2912,6 +2912,7 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 		mb();
 	}
 
+	dvb_device_get(dvbdev);
 	ret = dvb_generic_release(inode, file);
 
 	if (dvbdev->users == -1) {
@@ -2933,6 +2934,7 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 	}
 
 	dvb_frontend_put(fe);
+	dvb_device_put(dvbdev);
 
 	return ret;
 }
-- 
2.54.0

