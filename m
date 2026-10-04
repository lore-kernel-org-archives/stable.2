Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01143C7DE;
	Sun,  4 Oct 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117576; cv=none; b=KwTDbdu25hENpSB3EZnbhyGMM86kxdyD10NyZ8durrCiVjJMsqpi1ihFGvH64rs7qOT+fNLSffUOWelNXWZ9lo1y2UpqIfhoNOD4WsXzwYNE+PLWEpMWer4sqIhhKYepThGDOvk8xFU7pa/L3k0A16YGez98iIqDwOO+t6pJLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117576; c=relaxed/simple;
	bh=Fl5KYsKPC6oKKSa9VHl4QZzrSQn2typJJOIHX4Tpc48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCACJW7Agc4Wvua6IStBgy1JD2WCA/tRhbixq2vt7KXZxh+Fk/9rNKQVaQu1I7uDUAjcYsRnkMD1B8BOq3izXl9CA3Dv9UysqZCO4ucAdFioQPrQZRS/apoh8oehmKV1V1ECqfsVOBtPQ+JkYGRkAAvchlRnegrWHqIF5MLZxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fSn9K34I; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fSn9K34I"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fec26901;
	Sun, 4 Oct 2026 20:39:29 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: mediatek: vcodec: Initialize context lock before firmware setup
Date: Sun,  4 Oct 2026 20:39:20 +0800
Message-Id: <20261004123920.1251165-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8ea77a207f6f99d4f20610670e5f88fc56df3faa.camel@ndufresne.ca>
References: <20260830144827.2701887-1-runyu.xiao@seu.edu.cn> <8ea77a207f6f99d4f20610670e5f88fc56df3faa.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa106ed2c2803a1kunmfd0fbc3733cf0d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQkxKVk0YGBgeS0pLGE1DH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=fSn9K34I+kGIBaWGMJPHZSX6pI/ityAq1gaD/2tnLIauokW1HPugd6uQEYajWhjwnSHWx0cHYJQKDXN7i518M5ko3NyLRSHRtqg9NUjTZPr6v8xuTWIzOWdqIYj/i2KfiayV5t1ZwygDLKTrgp/sR4rLJuNurd9b5WPWW5kFfTg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Fl5KYsKPC6oKKSa9VHl4QZzrSQn2typJJOIHX4Tpc48=;
	h=date:mime-version:subject:message-id:from;

Hi Nicolas,

On Sun, 4 Oct 2026 07:17:43 -0400, Nicolas Dufresne wrote:

> The very first place the lock will be taken is in _open() and that cannot
> happen before video_register_device(), which is kept last. Please
> demonstrate what the issue you are suggesting if you'd like to see this
> merged.

The normal encoder open path is as you describe. On VPU-backed systems,
firmware setup registers the encoder reset callback before dev_ctx_lock is
initialized. A timeout on the shared VPU while another client is active
queues reset work, which invokes registered callbacks. If that work runs
before spin_lock_init(), the callback takes the uninitialized lock. The
context list is initialized but empty during probe, so I cannot claim list
corruption or a user-visible failure. With CONFIG_DEBUG_SPINLOCK, the
zeroed lock fails the magic check.

Thanks,
Runyu
