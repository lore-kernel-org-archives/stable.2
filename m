Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71033A6E2;
	Wed,  3 Jun 2026 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780458090; cv=none; b=JbOX/KQD4fj5wUmGKvGe1D2x+fLlpIFCyd1XJZzIUhZ2a/B2DVxNisizaR8z1zb4VGzutL0fJsgPAifrR10WSgXCRcE1Py/zNopDvrYyc2QXP1kfOm8CGf/MstaCZ5cg84AIr8Fd9s6se32tCNu+CYl+8UO6296b6CRLR/QfU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780458090; c=relaxed/simple;
	bh=ePqkG4+aqZWYSgkbVYdRKbx5qkYAZ17OAIqbuKBIW0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mA1icvdYsWagYdf/Hu3FwcFxCR9EAB/VXhJ9d1BHLGBwcSPPj7nGQLTwDetBmFVofTqb3XIWYvpXecIaHO1DtXe1xvGm2rdf+3I6zxxtHqtD6p2ko5QdyXkpeseLj1bZN5837A34huPXI+yXVHTHmxwFCcpeC8xhA0O7U/nk5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=HdWWbMLv; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="HdWWbMLv"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40db11920;
	Wed, 3 Jun 2026 11:36:10 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: dakr@kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	cornelia.huck@de.ibm.com,
	tom.leiming@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] driver core: enforce device_lock for driver_match_device()
Date: Wed,  3 Jun 2026 11:36:00 +0800
Message-Id: <20260603033600.3491226-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DIYPR0K2CZW7.254R8K7ONBX5D@kernel.org>
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn> <2026060209-virtual-sabotage-bbd1@gregkh> <DIYPR0K2CZW7.254R8K7ONBX5D@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8b8d8e7003a1kunmdb029d751a9c72
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTh0aVh8aSRhPHkxNHhlDSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HdWWbMLvtIXq71C5TajaYY2wU8VPCUBLHfnAZgZSqE0XrARDCab1HqOwZtS0X47QqF0Sr0ye51DQuAPWJw1QWVrA50lPXG4lR7nsY4qILDVGZOEH4rH2ZOaydV1N4waknmZi5AMH0lykJ41X1joQ9mMGUkTcxSrtErWioR1HK50=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ePqkG4+aqZWYSgkbVYdRKbx5qkYAZ17OAIqbuKBIW0w=;
	h=date:mime-version:subject:message-id:from;

Hi Danilo, Greg,

Thanks for the pointers.

Understood. Since this is already being addressed in driver-core-next
through the generic driver_override infrastructure, and the
device_lock(driver_match_device()) approach was reverted for the reasons
you pointed out, I will not resend this patch.

I will retest the original issue on the latest tree and only follow up
again if there is still a remaining problem with the current
driver_override infrastructure.

Thanks,
Runyu
