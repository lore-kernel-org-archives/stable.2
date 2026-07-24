Received: from bjy-spam.kuaishou.com (bjy-spam.kuaishou.com [162.219.34.252])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A3436344;
	Fri, 24 Jul 2026 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.219.34.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890636; cv=none; b=Lcc/fNNL2L7BdAU7xsgB/dJcAQzq/IEDXlhHpI/ZHKZQWoCKFW5DZxrZEpeGWk9Gqz0B/eahsQAmmX+u6nan8H18EQjXnC5B1hqJMCUaffEmFSHmrp0nOuxSs9k9KUn9OZQQlFgleHXcjyaPhk33+R6qb1AMM0OhUI1y5zyoL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890636; c=relaxed/simple;
	bh=fhUm6w/1m+w1nDgLJoPuV4T1xMY2D8JfjDyLevz6aKU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pvtVVY1yGkoKJqejgdSN/n8WtslgpmmbczuANW1ha2ioSn5yhyBazvLyfYNTvarfO8hdhLlgtwSKwfwrOuADXUTtlDVU0TmyI8MOs1TMgGKJumSoN7CVCWVGY7+ggtticEIHbX9PwKFWLHqtUwfdxrUwPap+P9m/gFWZQGYP/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=Ytt5NkGf; arc=none smtp.client-ip=162.219.34.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="Ytt5NkGf"
Received: from m7-spam02.kuaishou.com (unknown [172.28.1.162])
	by bjy-spam.kuaishou.com (Postfix) with ESMTP id 6216763F3F;
	Fri, 24 Jul 2026 18:49:33 +0800 (CST)
Received: from bjm7-pm-mail11.kuaishou.com (unknown [172.28.1.93])
	by m7-spam02.kuaishou.com (Postfix) with ESMTPS id 4h64Vw518Fz18Vj0P;
	Fri, 24 Jul 2026 18:49:28 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1784890168; h=from:subject:to:date:message-id;
	bh=pGFFXZv2VY5R9IBf/PJVw9B405jyna1M621GVg30eCU=;
	b=Ytt5NkGfhDncb0MJoaP75z28SJ7INYQzlVWNhrRZgT+HEbP9D7EcNieMrk6vFuLT3YmAHXjoThR
	AbKQyRu4ybMjwpT5xUF1Pjfa12BsLOWukvoNXIpi2bJ5Yzpf5TRStBj9Ct7agzhPD4D1busrqAo9P
	H7baojviV6+iGFKyEM4=
Received: from localhost.localdomain (172.28.1.32) by
 bjm7-pm-mail11.kuaishou.com (172.28.1.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 24 Jul 2026 18:49:28 +0800
From: Yiming Zhu <zhuyiming@kuaishou.com>
To: <xiubli@redhat.com>, <idryomov@gmail.com>
CC: <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yiming Zhu
	<zhuyiming@kuaishou.com>, <stable@vger.kernel.org>
Subject: [PATCH] ceph: fix mds random selection readiness predicate
Date: Fri, 24 Jul 2026 18:49:20 +0800
Message-ID: <20260724104920.6493-1-zhuyiming@kuaishou.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjxm-pm-mail05.kuaishou.com (172.28.128.5) To
 bjm7-pm-mail11.kuaishou.com (172.28.1.93)

CEPH_MDS_IS_READY() is parsed so that the ternary expression can
return true for an MDS entry with state 0 when it is not laggy. This
allows the random selector to choose a down/DNE rank.

Group the ternary expression under the state check so zero-state ranks
are not treated as ready.

Fixes: b38c9eb4757d ("ceph: allow choose random mds")
Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/78648
Signed-off-by: Yiming Zhu <zhuyiming@kuaishou.com>
---
 fs/ceph/mdsmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index d8e46eb7e5eb..450a4dc9662e 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -15,7 +15,7 @@
 #include "super.h"
 
 #define CEPH_MDS_IS_READY(i, ignore_laggy) \
-	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
+	(m->m_info[i].state > 0 && (ignore_laggy ? true : !m->m_info[i].laggy))
 
 static int __mdsmap_get_random_mds(struct ceph_mdsmap *m, bool ignore_laggy)
 {

base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
-- 
2.55.0

