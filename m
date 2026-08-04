Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4447B413
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879456; cv=none; b=S5fYUoYr/tiORwwotN2EQz5zb0cm5w3EfsRztWaklvMm2T2j7Yj0R+XyqE38YXHXV+SZp+521Cpnd9i1XgoT4zVpJFupeAqhn6xYD6aqpO9judwb60sbmbpyGE9eY8eOra9c453Gy+BhtcjiEOw+U2D5I5TInTd4XzwOwx7h0Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879456; c=relaxed/simple;
	bh=hK4xPGY2IK3gul7IpcA8bnueNq7919WPVp+ViX9mklk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lrhSkduu1Mf493JurmihYKlXfzw3ukG6YTdlf5KxANV/iHklLVjLRC2fdB4lSQb1X1fCVfjaqqjo5DZmiGB9OeSKjWTPuRmRT+cOscXWAblD0a+Czm3UX6ocl3IyoJqhiD7KrIxEtx3OXZ1MnQ1KfEXH0psy6xd0NeuXkWYA0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP//a1VQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP//a1VQ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca88130e09aso187679a12.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879454; x=1786484254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JOJcT04MAKZ1R+76HgJ67upFnuCPH8VuW68e8b3zSd4=;
        b=FP//a1VQLkR01akOee+BfgGu0DLtvpJ5nNcfey3y5ZbeaaSQmH/RcmX75DbfFPVLLD
         MxxtgvvP/p3HaiO5uMRQjjyhYR03yEiiTL0usmgEINsjoXZRd5RQFFuXQaHgL6tLh4wr
         Teg2XwXLvw3G0QWREJX+g7Zbubbquuf8uXkgYC5EiG1zmuV/k5oZBIELlD8aA1/AUId+
         oXfG59JQAWxIcwosJ64/n9Vso7VU+C6t5o7C2Heg/RvwO3WdqYVtzIdAHF41DkJiiK+I
         Dj+CPgXbzxo1P44btva8E6+01oDoG2LtpQxTUNESUnJJ5TTfFvjiWJZORGW7Tt9N3ewE
         /SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879454; x=1786484254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOJcT04MAKZ1R+76HgJ67upFnuCPH8VuW68e8b3zSd4=;
        b=qgZqaHQZpSMvI65Ww+psa2eiyaO+1ksAO36zphXM3TBgZzFNy4614PKuVAasiHe17Y
         A3Mi4ezsZsFEc8HStQYCqctDcKl7/y9KIzWaK8AiA2onB4i1zTTlakP6iyyhE1nPEULp
         zGHhuei0Rdr2uDojEymJbkTyePmQ1wwsiHzeOtB21/4R67r9Deba3Tx5qM7elfWXMWNf
         FLIMkqNa7QRZF0pxOmoTSV4jzrBfRWb4LiLiYvt7yMo/OABMysy79fFk5a2qD/roPhLg
         525FlB8wtaDlh1olBfvpjPqdRqdauQdK0ulm8QZ+mNdaP4BbFkztTYb+lY4DAU/bFL3T
         5wAw==
X-Forwarded-Encrypted: i=1; AHgh+Ros+ParNf5aIsWDqDiKAS/upICOShdgwUcW8vzwOaaeFEh26LJCcg+eqx8rJjwd4r/Bu0py3B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0YWXxNjKuIqQki278GGfIDMfnKrWzMzZhWgrL3c0sRjjuCFG
	l5btg79BbyfphnKPctxfX5VsqRALPG56xlitv+QPMN8FKYUPWPNdwF/0
X-Gm-Gg: AR+sD13G87ZWWr5LFKsoQJ9PHv5uDMkFiz34OcnwOOlu35kOhZJ9hdRUy3B0XuRg3sQ
	ddBswPInjWOYmDGIbBLiOX+pee9n9uHgXdZ3tohLVFMHUwJ3y+PpA1OdqKYXJsm7rajm505VhAs
	Eicn/4MvCZut+/3sOsx9Zn1XXH9A1TJy8lh4aQaPFBj7JnPnPJR3z+OfHxOSehkCE9/yM7gbg20
	wf6M+jjOr0t0Kyb59vszG4AWK8lFHLw/5NrxKM5GWIray7wh9iEnULrsK28yMu2raF1iLM3yAXo
	Afv3MSDJcp5BPtmpVQUt+Zs9B48Wu25y0acwhdgfewXVRxU5zD/bNrsFlh0xhc3AZjRjgzGXT3i
	tu04zBC4ro5VOYEntgC1n234H5NHCT2rC7UX02heGPCrLzcyhPpuOACItRkUZjIPZ5BYE6Z4Zdh
	K2TVgEu54n8znW2O0bkIvVy06pcHgBryrlYk4BfFcJVmKeRPAnVg4OFZaeFIkWRzAIsU5bjRmbQ
	wCR+POIOtX/zYsEszO4b2v+Mrt7hC/2zB7+o8/aiek=
X-Received: by 2002:a05:6a21:3392:b0:3c3:9595:57ef with SMTP id adf61e73a8af0-3cb85ffd1cemr1992015637.31.1785879454517;
        Tue, 04 Aug 2026 14:37:34 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673a9e4sm9532563eec.18.2026.08.04.14.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:37:34 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Cc: Nicholas Bellinger <nab@linux-iscsi.org>,
	Hannes Reinecke <hare@suse.de>,
	Mike Christie <michael.christie@oracle.com>,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: target: use kref_get_unless_zero() in core_get_se_deve_from_rtpi()
Date: Tue,  4 Aug 2026 21:37:25 +0000
Message-ID: <20260804213726.3411698-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

core_get_se_deve_from_rtpi() iterates nacl->lun_entry_hlist under
rcu_read_lock() and takes a plain kref_get() on deve->pr_kref for the
matching entry. The disable path, core_disable_device_list_for_node(),
unhashes the entry, drops the final reference, waits for pr_comp and
frees it via call_rcu() while holding lun_entry_mutex, which the reader
does not hold. A reader racing that path can revive the kref after it has
reached zero, defeating the pr_comp completion barrier and leading to a
use-after-free.

Use kref_get_unless_zero() and skip entries whose refcount has already
dropped to zero.

Fixes: 29a05deebf6c ("target: Convert se_node_acl->device_list[] to RCU hlist")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
 drivers/target/target_core_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 9db2201aa553..bff97c6efffb 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -220,7 +220,8 @@ struct se_dev_entry *core_get_se_deve_from_rtpi(
 		if (lun->lun_tpg->tpg_rtpi != rtpi)
 			continue;
 
-		kref_get(&deve->pr_kref);
+		if (!kref_get_unless_zero(&deve->pr_kref))
+			continue;
 		rcu_read_unlock();
 
 		return deve;
-- 
2.43.0

