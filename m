Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5993242D4;
	Sun, 11 Oct 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737320; cv=none; b=Ir5rlW5HAn4ZoDixkHFjTcCHFAU56LZ/1pGLUGthbee9C/0vD6yHz2AgQcTvA6lo9FZIQ+AkHmt8osumitqF94pmId49icmR7QDWzZ9b/nVh+/36c6o6aaArxaRGBoscwzUlpzIab6j2PJzUqW+YdMNLzHqZKo/TSylqnIxrcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737320; c=relaxed/simple;
	bh=vebxmo9545QFbv0r0JsPdwlCuehSbsXWxEJpg12z7Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it++xX61nsnGSw2Da+Y1bovBw5X6tpBGBfLVC0HS8t/rQOmaGK48/AxGfA7DxzqcUp6+USyb1ymD1qZvz4s/nEWAAVZ9ZneUIzJ4J4ZxzHjNbArxBmVNFZsKCxm20bmIFtEMGrn7DMnJ0RCI05tN+HGYHCl47WazdgJ+nHpLQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkyIZwuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkyIZwuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173DE1F0089B;
	Sun, 11 Oct 2026 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737318;
	bh=mIXzk8mF12wfjncwrMp7IAHIJmhDGfBFaRfzSXzYgnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JkyIZwuOj7SjCANXbjO4UonwJl7m3x0GbIX3q+T1IM6Ha5aKzxHr+Gg6oiI0/7foa
	 0rDwHtHT5yU+4LanstQw4OISmbc+FiGXTPdNZ4S0sUgdc+OPwv/KmbYIA88wdB/XnS
	 nc2iasQBLXENkmaaSCwwomOY/tBA27fuWbbgRS9P/1p5LzpatwemMg2SVKIjLUxwI9
	 SObUynw7H7GGx/8f7lpoXBOYH/+ymJCjxp1HYmP/prlz8jljsgnyxxMl47vtA/TGhO
	 jtWceODO7gNhxcG0ItPbX1/xy5VnFGd42nO/SU1aRs7k2WJURUWNYP1Q77SS/Y9Qyw
	 IeUmpzI+oFsSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>
Subject: Re: [PATCH 6.12.y v3 0/2] mm/damon/core: fix last region handling of damos_skip_charged_regions()
Date: Sun, 11 Oct 2026 12:48:15 -0400
Message-ID: <2026-10-11-1-daily-reply-0008-damon-skip-charged-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009123651.6585-1-sj@kernel.org>
References: <20261009123651.6585-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Patch 1 is a dependency of patch 2.  Without it, patch 2 introduces
> out-of-bounds memory access bug that was found by Sashiko.  Patch 2
> fixes a bug that categorized to be backported to stable@.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
