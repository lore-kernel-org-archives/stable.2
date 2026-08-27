Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1989313527;
	Thu, 27 Aug 2026 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810792; cv=none; b=uvTBxIu6RB4XgOVZSOoAzWKFSOzRTcgVgKO37kM4Ekct2uBUKlbimgpEe7RK4eztCXMAcBeZMX6NddBYTdG9cGTWcYRJnSUQNiECAjayvB93lKLmppR48qb7v653rukRZ1ug+DvHSugTvDIR42IhmUMPtulBOyduipFgC1ugE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810792; c=relaxed/simple;
	bh=bAruQZ0cIRVmOCmhEQYA1wQoiKdmxyMg6Rgx4pWc0MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0ErSUVIaULrWHk0nsO1OMzYu3SMMb9C5QQlbLt4WywwwEvZ9XeCknHHq65J6kAF6FpO7E5q4YKc5HcoXE4OnGjtapQIdErdpXRlkhdPCqjXk8AQFky1tspDH83dCgrBYYn/TQydcnw8EymHegpts2i6buicq94V6XkgPwc0NbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZWd9ZSo6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZWd9ZSo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o2
	kY95xCwNWCpsR/iyxyWE5K4DUXGZxG7v6ikeJdzPI=; b=ZWd9ZSo6zbsyrAR05x
	4hUbeh7XAJHX1oXcPv2i7D/30y9Q/kE5D5Nm8cnNY1TYq3JKOhjaZXey6Ev351sI
	8Qwcq5549lkLu0y5Fw5lByYs55MkcMcArtQwawgP94sDS1XqtRfGD5mzDfQM1oYV
	OsqQQ0o21YYOe4fkJq5bmhVnY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnFyvF049q9Y7gOQ--.42204S4;
	Thu, 27 Aug 2026 14:06:00 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v2 3/3] md/raid5: fix NULL pointer dereference in raid5_free_percpu
Date: Thu, 27 Aug 2026 14:05:54 +0800
Message-Id: <20260827060554.77849-3-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827060554.77849-1-ghuicao@163.com>
References: <20260827023803.36602-1-ghuicao@163.com>
 <20260827060554.77849-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnFyvF049q9Y7gOQ--.42204S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury7Kr1xuFWrZw1fKF48WFg_yoW8Xry8pw
	4DAr1Yg34rAanYk3s2vw4UuF1YqanrGrW8Aas3Wws5ZFs5Zr9Fyw45ZFW8WFy8AFZaqayx
	A3s8XrnxJF4DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYrWrUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC-AmlOGqP08mQ4wAA3k

From: Cao Guanghui <caoguanghui@kylinos.cn>

If cpuhp_state_add_instance() fails in raid5_alloc_percpu() (e.g., the
startup callback raid456_cpu_up_prepare fails due to an allocation
failure), conf->node is never added to the cpuhp instance list and
its pprev remains NULL (from kzalloc initialization).

When setup_conf() then jumps to abort, free_conf() calls
raid5_free_percpu(), which checks conf->percpu (non-NULL, since it was
allocated before the cpuhp failure) and proceeds to call
cpuhp_state_remove_instance().  This calls hlist_del() on the unhashed
node, which dereferences node->pprev (NULL), causing a kernel panic.

Guard the removal with hlist_unhashed() so that the cpuhp instance is
only removed if it was actually added.

Fixes: 29c6d1bbd7a2 ("md/raid5: Convert to hotplug state machine")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/raid5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7539,7 +7539,8 @@ static void raid5_free_percpu(struct r5conf *conf)
 {
 	if (!conf->percpu)
 		return;
 
-	cpuhp_state_remove_instance(CPUHP_MD_RAID5_PREPARE, &conf->node);
+	if (!hlist_unhashed(&conf->node))
+		cpuhp_state_remove_instance(CPUHP_MD_RAID5_PREPARE, &conf->node);
 	free_percpu(conf->percpu);
 }
-- 
2.34.1

