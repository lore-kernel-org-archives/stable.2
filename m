Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927183BFAEA
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622238; cv=none; b=fjf9rn28eq6rDxSu4vt1b2Y97Gbr32txv4adHj3lx1hKEMjbo5iizj2CJPLze+PB9Sq9r3omeS8Awcj/p7oNR+IMCCYyiYGuH+N5onhIDIPsyyIomUAQORCeVWgVkvjxe7WbfzPXpV6BS5U0RtRTrXWq9iaHVdZQJay6Q2lzHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622238; c=relaxed/simple;
	bh=zmckEySf1bnjvXLe1y8S3JJ1K511ztr3Ub59I4P4nRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAKdrHfFpOyCVsaF1qwb7Xg95gmgdYUrfOWsDRAc+rh1mFBUfRonSAeCg7WSgVu8BKoYOBeuHlIlZpsYLtbqJ8SPY4A0g0KSBJs31mOHulcAi9PSW6Iao4DqDmSvkmKMytkFc8tk4LPG842Ue3J8mw8U/XGAC/w6whgfO5Rl4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxuxQKYj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxuxQKYj"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa5ce4904eso4683410e87.3
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781622235; x=1782227035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArrqTfPT5xZYsqejdLAgeANpi6axW0WX5h4i9zN84Ks=;
        b=RxuxQKYjpx2PZ24jBuUopI2SIHSL5Yr9F6fN0fRfKXKF2ucR0eyPIF9P5kBnUkLdWC
         hCHBIoXM3OBHGbTiYBOaKr+ApndzERiqsX3JZCwMEzKoSVeoDsTNp0EeGBFYvJL77yUS
         LK+jFwI2pehPaM6Ooo0tNo7xNOyHTMDmc57vJXFvua3V+iwSTfISC5VvP7QLbWb3yymi
         R92LuGeNEOPEn9oE78uAOly7qwA/2TdohghpL/xbqYIBZxDGJQia82Vorp+kBAPZY6T1
         TNSGBlnkwNbTbEKBtXhK6oJcVjri9tuGESoju2d387mdDXFsOcyV1dMePXhw3AvhRE/G
         Q3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781622235; x=1782227035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArrqTfPT5xZYsqejdLAgeANpi6axW0WX5h4i9zN84Ks=;
        b=rYXi/1orgvo3iEqgWZAsswL7rMByzJcGUP3qSMa6t7sEwcsBoaPQEEdPiMibbSi+CQ
         dfZrgQiS5T1SnlDfzQzV3j08ziSqUpa3FdGPf4fDGwOND4Qp0LpSHZdZaXSDOxL+UUok
         9zVZ01GcDddaPAtQpsxX1iUuhRZQ5PCCtayX9gGWGS5mvrRQCqilWi3AfDW3Ru4yIKKr
         dSi2zfC9G0fayd3n33CBbbG/OXWjWLZDXEj3hkb9L39Zc/Iztx5E4RlQcqrlrz7aATnk
         EK7b4Ql6oj2j3SopFdQ5PsDuCJr0bn+yySUT4jYQkbIxo855rmfte0HAl945aPsi2iEl
         Ck6Q==
X-Gm-Message-State: AOJu0Yx4n2HO6YJO1Bw9FZgxUfw4ZMsqAI4escoOMVV2G1RjKZDkibrm
	NyyOmhVh/GvaY3ILj/QBtKnGqWVhlaTEF7lx3VcFBq7joPOF1TzWbNvFBTxU1M4dibM=
X-Gm-Gg: Acq92OFV40h5TOKTD6Cxcuckv+RqYzWHLI7hjKPopWCelZsaOu+uwKdxloZQ3NeZJla
	z2aGxkIK4vjI6C5HO3NFqgs5+sTRntLLpU+TTeyt7nprfWskgh4/49onDfoXvRfcpZpfUI8UquP
	Az2hnzrj2wUnn5CoQA8Nrqc8QWz8xbmt9fIzIXgs8vTIJxFimSiO6ZIMdmrKs8QspSg4CiAIpcg
	IPO1GJKYogSOBI7sjJ4SMg/OenyE8XM+mERHF+ylZ62FMeYrCjP/KmKIInPiYYMmpMG4YmPriKO
	mW2WmxfrIPP5+qyZBVVeK/R0RY8AsFjWbhWaDPfpp5IoW0prUD5sWtxfsPQ6DGbXNfKhffzUJAO
	aAxmLlVDprgRcSn+tP0NBqfKrW2MX6AbSR1qK9BmAljuyAkrztIMCCaY2wDNbsH0PrKwM0mio+N
	N92aaWaL8S1SLP9Zlh15tMAmdTWcOQp8xg7xPc92RKE7eYzhQ98dj7wDc59EprhyIeCls=
X-Received: by 2002:ac2:5fca:0:b0:5ad:3035:c2be with SMTP id 2adb3069b0e04-5ad43759ce2mr1020836e87.51.1781622234324;
        Tue, 16 Jun 2026 08:03:54 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1adae5sm3650988e87.56.2026.06.16.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 08:03:53 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Christine Caulfield <ccaulfie@redhat.com>,
	David Teigland <teigland@redhat.com>,
	cluster-devel@redhat.com,
	linux-kernel@vger.kernel.org,
	Alexander Aring <aahringo@redhat.com>,
	gfs2@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.10/5.15] dlm: prevent NPD when writing a positive value to event_done
Date: Tue, 16 Jun 2026 18:04:05 +0300
Message-ID: <20260616150407.810370-1-nazarkalashnikov0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

commit 8e2bad543eca5c25cd02cbc63d72557934d45f13 upstream.

do_uevent returns the value written to event_done. In case it is a
positive value, new_lockspace would undo all the work, and lockspace
would not be set. __dlm_new_lockspace, however, would treat that
positive value as a success due to commit 8511a2728ab8 ("dlm: fix use
count with multiple joins").

Down the line, device_create_lockspace would pass that NULL lockspace to
dlm_find_lockspace_local, leading to a NULL pointer dereference.

Treating such positive values as successes prevents the problem. Given
this has been broken for so long, this is unlikely to break userspace
expectations.

Fixes: 8511a2728ab8 ("dlm: fix use count with multiple joins")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
---
Backport fix for CVE-2025-23131
 fs/dlm/lockspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 5394c5713975..5072e81603ed 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -638,7 +638,7 @@ static int new_lockspace(const char *name, const char *cluster,
 	   lockspace to start running (via sysfs) in dlm_ls_start(). */
 
 	error = do_uevent(ls, 1);
-	if (error)
+	if (error < 0)
 		goto out_recoverd;
 
 	wait_for_completion(&ls->ls_members_done);
-- 
2.47.3
