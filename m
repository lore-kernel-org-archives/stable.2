Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088C3E6DF4;
	Fri,  4 Sep 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509872; cv=none; b=iasckS8mML2N/u/YsjsfSjHNCsAHi/egO8SunkR/sjtZ/t3IHQP9YHn81txFZU1hINxOhELrWUYx7L4Qwjeo2gFvt24bBXjOUZKAhMOY1SmSxH6XJF98JCKsi4sOuXDXLcrKf+bp2Djs7wcB/pDZx6WdJEg+75ust7XdWoT0a1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509872; c=relaxed/simple;
	bh=HNmXgmoAMksoht/4i8CVRwcYdk7auDsaJ38L54Gwr/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKMp19YJhGp8jJ2PKbTyPHIhOLYjPQsRX6604t2vRGuXje5ayHiODUv5pnnX3/9mgvUp83nG920tH5gNBN70kH3ax0Uz64lb8KtTZLuH9FlS5yeDnEm0Ax1jygXtq9vl+xxlASNZNNQuNg0wqwZgs6ePGY3tqAhTj160t2qnUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wspXO/FI; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wspXO/FI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RRZfaKoBvhh1M5ju2v6XxhyN2vsiPEHeXEVYqH14rsk=;
	b=wspXO/FIwLnA579VlStpAUmo08I2COkXywCT/q8Xt98HVj95yxLy6jmtLGLRaOul0TnZ9L9Iw
	bKRvIbk93pU2PEVjwAdUAqGzS+h8pNYmhnrNWlc9qcGOv2AiqcxVzsZnkjCl4YE8varVs6XAx8M
	yqBDr4gq9l40KtfqQ/8q5nc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hbpvq3ZNQz1K96m;
	Fri,  4 Sep 2026 16:06:47 +0800 (CST)
Received: from dggpemr200001.china.huawei.com (unknown [7.185.36.96])
	by mail.maildlp.com (Postfix) with ESMTPS id DAB12402AB;
	Fri,  4 Sep 2026 16:17:38 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr200001.china.huawei.com
 (7.185.36.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Sep
 2026 16:17:37 +0800
From: Ran Hongyun <ranhongyun1@huawei.com>
To: <namcao@linutronix.de>
CC: <axboe@kernel.dk>, <bigeasy@linutronix.de>, <brauner@kernel.org>,
	<clrkwllms@kernel.org>, <frederic@kernel.org>, <jack@suse.cz>,
	<jdamato@fastly.com>, <john.ogness@linutronix.de>, <kprateek.nayak@amd.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <linux-rt-users@vger.kernel.org>,
	<mkarsten@uwaterloo.ca>, <rostedt@goodmis.org>, <stable@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<vschneid@redhat.com>, <xry111@xry111.site>, <ranhongyun1@huawei.com>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>,
	<wozizhi@huawei.com>
Subject: [QUESTION] Are these issues PREEMq:PT_RT-specific? 
Date: Fri, 4 Sep 2026 16:10:33 +0800
Message-ID: <20260904081034.2995593-1-ranhongyun1@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
References: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemr200001.china.huawei.com (7.185.36.96)

The commit eb0d280c2751 ("eventpoll: Replace rwlock with spinlock") aims to fix:

1.Priority inversion – On PREEMPT_RT, rwlock_t readers lack priority
inheritance (PI), so a low-priority reader holding the lock can be
preempted by a medium-priority task, blocking a high-priority writer
indefinitely.

2.Stall – A reader (p_read) holding the lock can be throttled by CFS
bandwidth control and scheduled out. A writer (p_write) blocks waiting
for the lock, and a timer thread (ktimers/n) needed to replenish p_read's
runtime is blocked due to writer-fairness (286deb7ec03d). This forms a
circular dependency and stalls the system.

Are these issues PREEMPT_RT-specific? 

Any clarification would be appreciated.

Thanks,
Ran Hongyun

