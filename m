Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610473EF0BE;
	Sun,  4 Oct 2026 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791107126; cv=none; b=ZlkNdxtKelRTC7GL68kwcnX/Bq/SOyemZuXTsi7zMhDbbK1Gjro29H7mSs8KDqICHDj+qeJwtFnwD/zJPSIeSC/J1tmGZGohEZQKhRiTbcwBAhdzs1qzqeA/75p1KtiNmGpEo22KBMxxQjLjZBJppP6qhHg4gggPaX4JLGHT/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791107126; c=relaxed/simple;
	bh=UN/g8DB98lE3dJQQGg6jY0HIsYxg5GEuJGR2hvv6i04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvdA/Djm/h9i7myGH8omGLXOYP/uobaZ5bggdEs7OdQT4Cdu/SH0devIBDKcLUMhsMcJDyi5zCAXuaPJjaiuP5ZBHl9aBt5Du4Ulqc0SaHae7yyGLgaW/kcbn3blqyxqMGQVJANgyUH0s9GyGF2uLpr40/L3XbOYRR/LGPqVASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=g0ur2Xxa; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="g0ur2Xxa"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4feb7a7ef;
	Sun, 4 Oct 2026 17:45:11 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Sean Young <sean@mess.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] media: rc: Fix simulated TX timer lifecycle
Date: Sun,  4 Oct 2026 17:45:07 +0800
Message-Id: <20261004094507.1191384-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arvlSbG0Z0FGxq3l@extorris.mess.org>
References: <20260929143105.2170272-1-runyu.xiao@seu.edu.cn> <arvlSbG0Z0FGxq3l@extorris.mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1064d9bda03a1kunm80f3e5ac337252
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGR0fVh9NQxodTUodHhkeGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=g0ur2Xxaf9Uc8Hec/53PP77AdtLpGRT8rRb37oPiyZWp0UEJAmR7XWOdf5P8wPtg9drNnE2mVbJ5wAkmtr2ASrDkBa6sKStmsMkNQrazNaw1etE+UUpib/RN2l2vljT2HNbvBHFpwrFGrzkZbyxL6zd+F30K9uwSHf7h7M4QAlE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=UN/g8DB98lE3dJQQGg6jY0HIsYxg5GEuJGR2hvv6i04=;
	h=date:mime-version:subject:message-id:from;

Hi Sean,

Thanks for the review.

On Tue, Sep 29, 2026 at 05:20:25PM +0100, Sean Young wrote:
> I think this patch is correct, but I am not sure txsim is really needed
> in the source code. Maybe it's better to just remove txsim module parameter
> and all related code.

The txsim parameter enables the driver to expose TX on hardware without
native TX support by simulating TX completion. I found no in-tree references
outside ene_ir.c and no separate documentation for txsim. Removing it would
drop that fallback. Do you consider this fallback obsolete and prefer
removing it in this change? If so, I can revise the patch to remove txsim and
its related code; otherwise, I will keep the timer-lifecycle fix separate
from that cleanup.

Thanks,
Runyu
