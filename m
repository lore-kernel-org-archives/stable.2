Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792728213;
	b=DO3r9i9a2xogVRC8Bmq15KZCEH/phVf6ZnRMgc8ONh5+GrIu/cAeNWEJ06ICEzClFtmB
	 DLtkqay3DNd71azQQA9RiupSktrnbmGM1Gn3Q49HABVBtiVmjk7bobRfE3Z8FluGzrpqa
	 gOyjtraakyvMYmdBJFBq+qyEtCoBSHcxFg8LcgOasDuY6xY/YSkPqUYTHbePRp4aRjWhS
	 +Kpf+5tzGKM26yG5hqpzuV6HTk4ZsO/jhgZ6epvw5+NVcfxXwfBeH4xAWLwhMz23s3k+D
	 5BCcCOfbNxb7ZGNWKk60QeSm70J3vkf9yQNbWo857QJPE5VpOzogFhXMsL9g2HvXoVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792728213;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QKpbF2NYjurzhEa4kldxHAeNF3pXxzbhF88uq7GLFNY=;
	b=SkHgpmGvGgw7sDeU88H9LgDO3haqanfsFJI8FbSQeklJbk9JDM5yzeoNEMVGucFf04Op
	 LUtt6+3BA5pOm7KI1smKeYa5YxZQ5IPNbIIf7KN+gDHQrfBYBu4oSEIEdHGULZresUi1F
	 uoOxhB/qwd4k3N29j5lBPXR2kYTZRwoQyBVmLown73an+7Gz7pHTFvk9W38TxeGb9fGmd
	 zQcj993rAKJoxEV6evJ799yUKTktie5hkvqFOZjkmLr8gs3AHVCdTizyy7O3r0X53sF46
	 lqT0dnsccfJrvrY/UcpNIDi+KAxGrHnKo/u9l3htdABtmJTfHQh3Sehs6WI4smwGfyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MWzcxIgp;
	arc=none smtp.remote-ip=115.124.28.149
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34A606A319;
	Fri, 23 Oct 2026 04:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E34A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=MWzcxIgp
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792728202; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QKpbF2NYjurzhEa4kldxHAeNF3pXxzbhF88uq7GLFNY=;
	b=MWzcxIgplb0QYAvlwaFOa2ivBLWXo01f6GNYM23LNPJYPbLBhBbbpo2DxxngP7X1LsxafjByHH34OFlCT7MSYmqJcMwZHR7iaeB799f/4VotJzQPZVz386FPA8zx7QpGlA9uGNb2GFhTGLeI4waxWVEQ4hTGCx0+4rRcNbevjlk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2734637|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0703598-0.00291062-0.92673;FP=8486465230796416835|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jnx.DIq_1792728200;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jnx.DIq_1792728200 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 12:03:21 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com
Cc: xieyongji@bytedance.com,
	xuanzhuo@linux.alibaba.com,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] vringh: fix infinite loop on cyclic top-level indirect descriptor
Date: Fri, 23 Oct 2026 12:03:19 +0800
Message-ID: <20261023040319.48555-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922122955.69433-1-fangxy@xiaopeng.com>
References: <20260922122955.69433-1-fangxy@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks to Jason for acking patch 2/2.

I wanted to follow up on patch 1/2 and check whether there are any
concerns with the fix or if a different approach would be preferred.

Thanks,
Fang Xieyan
