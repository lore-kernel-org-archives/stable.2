Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4463B6344;
	Thu, 27 Aug 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817863; cv=none; b=A5SkkjBh4vgf7ckLtMiqm1bszLk1Q2EJ+G+/B7JdqDe2F82e93GY2AdYY5qZc9gUoCStf/j8W/0dfnIp9dOP8BMMphlBv1QTeO60m1tb2Iqrp8SH7HYwrx4TDPpbTKBtc+kwI5VUQg30STY6N2DSiNRyJWTusOiwBsL5uBl7pQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817863; c=relaxed/simple;
	bh=ef5P4NbGxhl4+Uk1F0KDET9+Ox/yvMBq5hL20NFEXW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVQ6Fc3q4JwBxLNQsGmwEifDdXX1Kn0LOxx3OZiVL8aB6ouo34da1zsYhWSYpcpJgIpu2ySmDbVqTwIVE9hpuXVMguAFmUz5dDXsQrwpP1fSbfcQ6ZmEC8UnOKj9pH8vB2ImIYrRIarEF1eeBKiZeQ7neckhIifyGuqTfgzFmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IclEnoYL; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IclEnoYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=11
	Gtp5Lb3rQoJvuk/TZT1JfLzY2fuTvHNx2t9ky+IIQ=; b=IclEnoYLn3LzHMnA+5
	ATZ/rAs3S4xWlMqJmklkgfalYLDIjzF3DsdDkJklqo3WMalPQvQfFHbJ+oJkrw32
	Y19O/bgforKyYx6rBV7T8N7cS26gMmkTxViC+CBtjLKAUtpgFphijeNjwrq/UzsS
	zf3HFeMcO+iScuKpbiokOt7Ds=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3_wxe749qoz9pPQ--.29344S3;
	Thu, 27 Aug 2026 16:03:44 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v4 2/2] md/raid5: fix NULL pointer dereference in raid5_free_percpu
Date: Thu, 27 Aug 2026 16:03:41 +0800
Message-Id: <20260827080341.112296-2-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827080341.112296-1-ghuicao@163.com>
References: <20260827063235.85375-1-ghuicao@163.com>
 <20260827080341.112296-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3_wxe749qoz9pPQ--.29344S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury7Kr1xuFWrZw1fKF48WFg_yoW8Ww4xpw
	4DJr4Yg3s5AanYk3s2vw4UuF15XwsrGrW8Aas3Ww4rZFs5ZrnFywsxZFW8uFy8AFZaqayx
	J3s8XrnxJa1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5AwxUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC4ACSJWqP72CvhwAA3V

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

Guard the removal with hlist_unhashed_lockless() so that the cpuhp
instance is only removed if it was actually added.  The lockless variant
uses READ_ONCE() for the pprev read, which is safe here because the
actual removal is synchronized by cpuhp_state_mutex inside
cpuhp_state_remove_instance().

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
+	if (!hlist_unhashed_lockless(&conf->node))
+		cpuhp_state_remove_instance(CPUHP_MD_RAID5_PREPARE, &conf->node);
 	free_percpu(conf->percpu);
 }
-- 
2.34.1

