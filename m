Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BC188713
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782638371; cv=none; b=IlwRUlwv6AYFrdLUBp3c4NzlPnj4JKnWuJd7haCFMSqm0wvIIjw5GGKcsh5Ya6HnBhjHGtYfbzGQb5ZKgIEVjLetHzBuYKGJ4+1JFkRAjwOdz6VELvKaq+4Dqxs7H/y3xE9dWWRuvYNGnj/SEp/FgtMtOz6G87tv+ja4HFT8rVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782638371; c=relaxed/simple;
	bh=+TMcaHn5YQykUzQzJACoD9w3PjSFRZHmSBneHv5oR0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cT3IGuJkch54gCVZmhA+lLdJD0jTIsmqNKVuBBZNF8dawdiuBC3K9nolfxjsV0FN7JbWa9Zs677OB+CbIgWkBvjBbRaKVN4fcpouuxt5ymTx/AjWcknoLOnvUlZ4lVbOd4v6eQ1hexQBjBZIZH3YwbHX5I06RM5uUOe396hgUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/sfpgFt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/sfpgFt"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493a285ff0cso2861305e9.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782638369; x=1783243169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMFPxxbKwC83QNnr+scrjS2pM+xu1i6gm24bZDXkabo=;
        b=S/sfpgFtfzoyqQAOh3BYPNNmOys4f1KeDYChh3amm9XmUBoLv7li7uOQyq3tXfGQn8
         HoLBKdMXbUrjxzixHNxRPGi7FlAz+4vYWPeB+BqtXCL/ANG4qYGKX4AiJvejPwuczhSx
         fZB4HM3xOrOPvE+WWnzWbVLCqLfr/kwBl0brQixDxbTuzOUPTEpHSswCzXn2dmDWRZ/2
         wv/Fhz+n5LGmU2RWUF+zQe5dak9WbYjA79HUjjn8UHQFMbp3Tpk3bjiD5R7ftIGIsJCn
         pgF97h8Z1VgycAYkh4oW6xHMiN815WbetsFN/q2UqiemI1RC2k6SpuB4BHK9DAitGbso
         HesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782638369; x=1783243169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMFPxxbKwC83QNnr+scrjS2pM+xu1i6gm24bZDXkabo=;
        b=E/5wdGk1WlCpWFlkE7trs5/OW47d+PNHDvTYuLe5mFV7Iitr8H3kVnSprHi2PT5L9f
         ayF0OYp1+nTaIzLVPt8+IdNZyvfXsXbsoVqmt5nmesngakPaJJ22D86y+3mJzd6Ghk+n
         lG7UYDRphtI1vo1hHFvkhQyBUw1RefpkrRPtV/ded72jqJSVokGYn4EB1sulzeJ5exqy
         1teYj53iv7BMZADx2eLbCu5ZtPOhjKt+wAjh3HNB737IaOZLRpqNyiL1HvXmBLUWSGXR
         1STHD+T7XeCXpf+pfWB8V+4fmUUFOMWGHw4VR8m0V7+cvV4UgwcKKZrHPFKO3r8zwzQz
         yb3w==
X-Forwarded-Encrypted: i=1; AFNElJ8SWC2gqXv3jmSK9P9ojCZ40nMCVF0Wg02leALo2eYYu09S9HmiA0Eq2sF4JDcjIPiH8itCzA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/vkxaYA+olQcXI3lcpvZHJtwEpwU3EUQk7vCTtQFnfscD4FkB
	DqGsq/G0P8L8W6dxJ6eVNw4tSMMTFqgpRSjcSvniNpf0w6GuYaYAH+JGrxEfNEOZMVoOnA==
X-Gm-Gg: AfdE7ck3X931pGck7A01ttEEPOKmBteJdN82kWR4Iprtx9TRVMZtqMTgOg+OFKgOatX
	uNGtLo9IZ10I8VwqP+Bi6Ea4Jk2drnS/BuCTfHVsHihzoI7oELi6myQPtapPH+hTjjERGvxM7jh
	pvOYX9WXyVPJHFCFiX1nRguEPk+aOYAzMIYTKe68BZipBlQd69vnSIKoBjR2bIDNLqm2lIfY1Zs
	iImoEOmggtnHo8uMzk5k5oLuKBJl6bWExgKNF2wSn7XTDk7BeqxyDUPaIZyGpzljZqsVIqlNQsd
	1MaJtFunjvy1g/CjLeMidjTmosh0F+3YaGzo8lOEGSIEizZxFtfjTckNiFtnx5xLGP+9iEbFfnV
	nMcTn3kl2qpHXU4qZPVbczleRM4hDZD2LfQ6yiSy4cKvURUMXtkh7JzUVPZnpchjqguKaXd992R
	zhA2cTpzH6Q7HabPYd54kYuledsg==
X-Received: by 2002:a05:600c:1d1e:b0:492:2f3c:d0ed with SMTP id 5b1f17b1804b1-4926688a528mr186302095e9.30.1782638368707;
        Sun, 28 Jun 2026 02:19:28 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm187757565e9.2.2026.06.28.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 02:19:27 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+40339ea82afa8184ad5d@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] media: dvb-core: avoid dropping device ref on frontend open failure
Date: Sun, 28 Jun 2026 11:18:44 +0200
Message-ID: <20260628091844.37577-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dvb_device_open() takes a device reference before calling the frontend
open callback and drops that reference itself if the callback fails.
However, the frontend error path calls dvb_generic_release(), which drops
the same reference while merely trying to undo the user counters changed
by dvb_generic_open(). A concurrent device unregister can leave this as
the final reference, so the subsequent dvbdev->users access is a
use-after-free. The outer open path then also performs a second put.

Restore the writer and user counters directly. The reference remains
owned by dvb_device_open(), which will release it after the callback
returns the error.

Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Reported-by: syzbot+40339ea82afa8184ad5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=40339ea82afa8184ad5d
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/media/dvb-core/dvb_frontend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index d082b6c57c76..7aebaef18191 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2887,7 +2887,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 	mutex_unlock(&fe->dvb->mdev_lock);
 err2:
 #endif
-	dvb_generic_release(inode, file);
+	dvbdev->writers++;
+	dvbdev->users++;
 err1:
 	if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl)
 		fe->ops.ts_bus_ctrl(fe, 0);
-- 
2.54.0

