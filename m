Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC21317173;
	Wed,  9 Sep 2026 03:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923554; cv=none; b=miQmJfmgJpkCQQBhoJXzVja2ziiGPev0cTDO7JE8BfFk6/hrAuxSvGLDeeLyQeVwliqjjzR+l6ZNfx8p+qKUi9yetbBrNGyar+pvPdMX/KeMfi57H3fq7ixnbn24T7DyFAhyZFxAWuyTyA7+ofhbqnzNYU3jNMxP9tDEljugo6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923554; c=relaxed/simple;
	bh=RLeYLogumFQ6XJsvIWq9nwJXeI7KIoroKGT7W1Vl3UE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZOta/09D7WTqFMCUVL5Hr//79vYeCG0mbT1NQURNp5FBFAPVis6bwFIxR2PVLNDteVoszpFLUogddY1APIjxAC4dnWQlajZsIV46XzrmQ64m81nKAOD91q5GBzhB8IoMit3XnrIwW9fuzYZOKNZ++e4X5Rez6vsy7e5qX/t2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z0ANVXml; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z0ANVXml"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=f1TwHlr/HpBR52LSyzPtzCCusLmy4u97Fnscmci/Mx0=;
	b=Z0ANVXml8rYLQpFJoMTkGjk938y8I+J7bAD2bD5HQhwJZ5KBFfTFaguGmXGD4JN2K0uXTWQbT
	Uc7+XmXoDBHkpGeCuRQBXC+BGvw7ji5DIeyXaIiHCn4PzY/s096wknobqo+JkeOf77ROQpz3mPm
	OTQ5/7R6Xfq+FB9j+0RnYbM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hflvJ66ygz1cyQh;
	Wed,  9 Sep 2026 11:01:32 +0800 (CST)
Received: from dggpemr200001.china.huawei.com (unknown [7.185.36.96])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FADF40578;
	Wed,  9 Sep 2026 11:12:26 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr200001.china.huawei.com
 (7.185.36.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 11:12:25 +0800
From: Ran Hongyun <ranhongyun1@huawei.com>
To: <florian.bezdeka@siemens.com>
CC: <axboe@kernel.dk>, <bigeasy@linutronix.de>, <brauner@kernel.org>,
	<chengzhihao1@huawei.com>, <clrkwllms@kernel.org>, <frederic@kernel.org>,
	<jack@suse.cz>, <jdamato@fastly.com>, <john.ogness@linutronix.de>,
	<kprateek.nayak@amd.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<linux-rt-users@vger.kernel.org>, <mkarsten@uwaterloo.ca>,
	<namcao@linutronix.de>, <ranhongyun1@huawei.com>, <rostedt@goodmis.org>,
	<stable@vger.kernel.org>, <torvalds@linux-foundation.org>,
	<viro@zeniv.linux.org.uk>, <vschneid@redhat.com>, <wozizhi@huawei.com>,
	<xry111@xry111.site>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: Re: [QUESTION] Are these issues PREEMPT_RT-specific?
Date: Wed, 9 Sep 2026 11:05:05 +0800
Message-ID: <20260909030506.344667-1-ranhongyun1@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <63d5cd58e9b85acccdaaac9aed4a8c550cc7b868.camel@siemens.com>
References: <63d5cd58e9b85acccdaaac9aed4a8c550cc7b868.camel@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr200001.china.huawei.com (7.185.36.96)

Florian,

Thank you for your reply.

Now I understand that the issues are particularly critical on PREEMPT_RT. 
However, I’m still not entirely clear about the "performance or throughput
drop" you mentioned for !RT systems. Since !RT kernels are
non-preemptible, unbounded priority inversion and stalls should not occur.
Are there any other factors that could still cause such a performance or
throughput drop?

In other words, if I am running a !RT system, what benefit can I actually
expect from switching from rwlock to spinlock?

I`d appreciate any further insights.

Thanks,
Ran Hongyun
