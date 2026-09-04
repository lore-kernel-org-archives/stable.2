Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7D46AA9B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518038; cv=none; b=Vp1oLzNcMKwtFxHMvfe+m+AptfFIgy3vv2KNJEUlQnjias6AHMx5Lwwa9XVv3E8HIvTXjrg94PjU+fX7AdH/IPk9byzCGXX8Iladhe7OWs31SFhUSp/fFdW0AH3jzpBj7xq49mwKowq0A+zSQG2rXeXkFlnnT89AzOzy9fEKRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518038; c=relaxed/simple;
	bh=lnOd2Cu+mfYC06hiaS9xwajbcEsrwnQBxbyBPrBJXnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/nCU2n+9riV4xDY1Giplr/4d8o4Bxebx7FaA5BVmJAGlpt+CkVPF6AyWHkYXXdh39pVHiBUebKCSJMaiFDGDpfqP5kAFNFFQaB5SHU/y8B7VJTbEmKMZuME4rOt98xThch57hXOz4Zwug9TE3VxrN8tJbxpQWqDWFUvb+nwC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dHQE+2sJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dHQE+2sJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso9320415e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 03:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788518034; x=1789122834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CH4/K0wijj7OtRSv4HcTF7FzgieNSCBLu9edWOGkVVg=;
        b=dHQE+2sJcyvfOvlxjN8MRvfSKb0YVCp2Nh2xKoUKmKqESo+yJSxQBAsUf4e92TLuAr
         n64RhNIAl4NCmEMxs4TGKEBlcD+cs2LDzMxNnAQ6uLiI2USwrp5n4dFWO2cA27irnjr6
         unPz6FMFM0xsqSgN/V+6P0WgZ9B8NmkIIf8AEqazeu1v1Tb+Gig8CVynvrA+K36ICWNt
         NkIapDGIiOqLxbvKmK7uIrrgGzmHv7/Y106KsDsbJfxtmitQCnvSLpsAHtvmPw6XvrjM
         qbxW2gH9Fd4kovWnkN8DzC61cziSH5C7aB5c1GDdND+NT/DGT9VcRZBm+Fj1wmtOLIpZ
         dmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518034; x=1789122834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CH4/K0wijj7OtRSv4HcTF7FzgieNSCBLu9edWOGkVVg=;
        b=iNr0uXKNPwtGoDAoP75pBwxAGA1JM1bwzeVh+ouHU2Gc+xTtPdd+axnf9sP8ikLwKG
         ONxWChb31Ad1itfnriZQrivMKtItjbQJ3BkC8p++DDMEL+TRdxJUFE9/7Z38CSRXTbx1
         5Zesv5kQ1P6Jm1nwnb0+6a/x5nDZLOmpuD9aaOj1/79jjUNvZZ68Iu7gQ8c7CmHaYNeC
         2R0e3G6q9+dnFTzmG4AyEJfAxxsvh1Gix2Q07kbOwzPqn+10WQGHMfXP4BKRxA3t7M7p
         rdPctWL3qX/ZySSdV5hjhZVfs9Bgb3qyEEB9hxUhYrdN7chB3BDQv3dv0jlgQFzDBPB/
         rkIA==
X-Forwarded-Encrypted: i=1; AKwUvBydw8iqZEIl1p5RyYNP7Q8+hYJ9BiRZdyjY4gNF5sq1cy7icePQ7JIg+OIt6IYjiiflDlhkSS0=@vger.kernel.org
X-Gm-Message-State: AFuF++kqDC7NraalUcsdKxYpZH2rEzorNxI4qXjtuq6zS61dXHxOLI2y
	4Eg3gDy8vi+k5HCBKOI/poac3SBs0f95/CnrYgEAqqhVG3gdpmOq/kY0PNQInABPcZo86eB+Ne+
	zI4SS1QQ=
X-Gm-Gg: AYBFou0pcrOcRuxlqoe1jfU4qN7gCTtDJnDLKDMbbruN/dPgGRZyu0hfoIRhNfvqov8
	9RSVg2wtDuknsRW/RsOGaSk9jWFByQWH7cc+31YuWrnVX/zP2l55vGtbFxR6P0ghus6l0501DV4
	/9/lw17zv+2elcFId2zL/+Pa5fx6MhsxN//R6eSs6mz0spDl9NT2MtmAL4QcBAc4qM5CX3vJ9J5
	WeUSYDr1d/GgF65Ed0eA4v6TRATEKg99MNENytAumwL7OQXoZ9ThoKf2iQL/8hckpZ0Dn8EbV27
	B6AIGsHA6uxSFRI/0NQCt+Nsi1aCqLHOlIO2UUyxb+hIkPbD1UgLTVmT8Ay1I2FoC1F7eeenK/S
	I0s9UT7hmg0XmYz8yIZPpmb3cDSQr7ZCU9WDudxx6/dwmK/Z89N5Kir008QIeh4DLCnoBNUbgQD
	+T0XjBiEFnSMpMxaIcb4WveFc+nV0RTnteLXcaZvP/Y5mTq1aA93k7JueDmK+bOpnBlegpj5ms2
	8dPSB76oeLOg4wrApx2ivI1JRkltlr7V/pDnIL7is1U1GDq0kU+4MlLINj2DggL
X-Received: by 2002:a05:600c:1914:b0:49c:ff23:a6d5 with SMTP id 5b1f17b1804b1-49cff23a70bmr3661865e9.0.1788518034477;
        Fri, 04 Sep 2026 03:33:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm141003045e9.15.2026.09.04.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:33:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: avoid pending truncate during nonblocking cap acquire
Date: Fri,  4 Sep 2026 12:33:51 +0200
Message-ID: <20260904103351.15357-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Readahead acquires caps while the folios are locked.  This can
deadlock when processing a pending truncate; truncate_pagecache() can
then attempt to a folio that is already locked.

Return -EAGAIN instead when `NON_BLOCKING` is set, causing the
readahead to be abandoned.

Fixes: 49870056005c ("ceph: convert ceph_readpages to ceph_readahead")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index bcb04c6cb92c..86e195c5fd32 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2889,6 +2889,10 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 	}
 
 	/* finish pending truncate */
+	if (ci->i_truncate_pending && (flags & NON_BLOCKING)) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
 	while (ci->i_truncate_pending) {
 		spin_unlock(&ci->i_ceph_lock);
 		if (snap_rwsem_locked) {
-- 
2.47.3

