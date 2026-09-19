Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712EE3AEF2E;
	Sat, 19 Sep 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780261; cv=none; b=fVBCMmhOQrRdHvyxVmM7krGVcsT3dsGEu9HFNBFtLfeiBoo4icREpUHWNU9WunJNNnt/clGI8zC0Yx2rggVyHOhSc0xKmfc3nAGZN1RqjP380fMeVhAj7xLxgPLujLQjqXbHGF9vYFnwFyn08d3HzqpwWGwl1t5dyLL0/MTUduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780261; c=relaxed/simple;
	bh=/uFvDU0eh29LSha4tX/8NfQlZ8H3dSXMwwqga3OqBNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sby5lu5B8/cj6HoJKrzCPpW6lbnQV6op8PlWjCALSLa9IapD9Y152tiR6zMJeu/VXjWhWvKHwPM9yZ92YaaUJByuvSOfpnCjh40jRYoALdsL9u1pD8pA8FCv58rLYU/1ca2bw7XU6c/a2FdlT8kfcHNEJDYWtepZ0vsN5wu498A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=WW1fcCZ/; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="WW1fcCZ/"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e57bef79;
	Sat, 19 Sep 2026 09:10:42 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] media: microchip: isc: Initialize DMA lock before requesting IRQ
Date: Sat, 19 Sep 2026 09:10:13 +0800
Message-Id: <20260919011013.3383669-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <77440bae-7381-451f-861d-1399bac4d925@kernel.org>
References: <20260830023228.2054498-1-runyu.xiao@seu.edu.cn> <77440bae-7381-451f-861d-1399bac4d925@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0b7372f1f03a1kunm3e30bd173c544d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHU5JVhhKTEhNTk5DH0kdSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=WW1fcCZ/BhtAK9Thi5+jeYyF6SRlRv2/jTmkwr1+L0aAEHVRBq+c//Oe3hXsLcdDH0+kIk7b/9V9VfRXCys4RwsDqkPO8DaDZISwHF0kOtvnC873DlOssV0IWprxPC+5b/49nTeMuWrGh95Bg3qxzKFWAKgkZgfjN7Ga8b1ng4g=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=/uFvDU0eh29LSha4tX/8NfQlZ8H3dSXMwwqga3OqBNw=;
	h=date:mime-version:subject:message-id:from;

Hi Hans and Eugen,

Thanks for taking a look at this.

On Sun, 30 Aug 2026, I wrote:
> The ISC interrupt can run before asynchronous subdevice completion,
> but the DMA queue lock was initialized from isc_async_complete().
> Initialize it in each SoC probe before requesting the auto-enabled IRQ.

On Thu, 10 Sep 2026, Hans Verkuil wrote:
> It's dubious to just init dma_queue_lock here but not
> INIT_LIST_HEAD(&isc->dma_queue);
>
> I think Eugen needs to look at this as well to see if this is actually
> a valid issue at all.
>
> In any case, this patch doesn't look right to me.

You're right that moving dma_queue_lock alone is not enough. The interrupt
handler also accesses dma_queue, comp, and awb_work, which are initialized
later from isc_async_complete(). I also need to confirm whether an interrupt
can actually be pending at this point, and whether the required clocks and
hardware state are ready during probe.

I have not established that yet, so I'll drop this version for now rather
than send a v2 that only moves another initialization. Eugen, could you
please confirm the expected reset and interrupt state during probe? If there
is a real probe-time path, I'll revisit this with the complete ordering.

Thanks,
Runyu
