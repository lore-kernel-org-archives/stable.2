Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAED36404D;
	Sat, 12 Sep 2026 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789200300; cv=none; b=JHF6SSww5BiapKRkdIwFFTCLlndPbs0ui/fPeCtiVxwAkyTSIne3VlpKkqiZaOzWspuMkDLC0Ix2Rq9kjgpZHx7HBKZ3xpO8mMUtzoe0iR8z/F/hSEhlE1pXiu8najZeTsaJGQk89Dv7HS3FKvVV5xZQvQC+ROXqeAy1XojR3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789200300; c=relaxed/simple;
	bh=4+THOZS0vuucX1GtvwsUqalQ26e4hn0JKpJvj3JFnU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKE/ALwnhbhDL3aftZQMWYgRtjDKHXguMyHtPcRW9ds+yFrzpMDcZErvjlkJO/kfheGMZ1fCU2Kv0XcmPSAVT9pcApG1tl/54Tex60a2hh1afWA9C68hPO7IDRHSMTDpLOs1+sPW+sY1M3C15OlWRjLbs4CvBx3q69nYilF2VOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=PA0tsTU1; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="PA0tsTU1"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d8263d52;
	Sat, 12 Sep 2026 16:04:51 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 ath-current] wifi: ath12k: convert scan timeout to wiphy delayed work
Date: Sat, 12 Sep 2026 16:04:45 +0800
Message-Id: <20260912080445.14184-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dded65dd-56df-4637-b3f5-c244651435a6@oss.qualcomm.com>
References: <20260717025602.262916-1-runyu.xiao@seu.edu.cn> <49600545-3e13-452c-8940-c3e775ac3856@oss.qualcomm.com> <dded65dd-56df-4637-b3f5-c244651435a6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa094a5d59503a1kunm70f9fefd2086a4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0xNVktKTkoeTE5LGBkdTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=PA0tsTU1+tX07cBxPpVlFFJKU5ONDffvsLfa+qV+ZEk3drZnFhvE7oAEnqYTaF71l5JVfsLuV/XPGgS56no8RnTPWGaFlgdGNFIxHydNc1SH0BCVPkxNgxCNLu1KE/Qn7pyzSJWQgKdGSXAvtp+kIbi+gtbd1BSKN17pyXE03+k=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=4+THOZS0vuucX1GtvwsUqalQ26e4hn0JKpJvj3JFnU0=;
	h=date:mime-version:subject:message-id:from;

On Fri, Sep 11, 2026 at 01:36:47PM -0700, Jeff Johnson wrote:
> You never responded to my response. However, since this seems to be a
> legitimate issue I did a little more research and now see why the
> finish_queued flag is needed. A better commit text should explain that since
> the current commit text is confusing

Sorry for the delay. I was unsure how this part should be resolved, so I
held off on replying.

> There is, however, one additional issue with the scan complete path.
> wiphy_delayed_work_cancel() requires the wiphy mutex, but
> __ath12k_mac_scan_finish() is called from WMI event handlers under
> data_lock only, without the wiphy mutex. The existing code can call
> cancel_delayed_work() there directly, but that is no longer valid when
> using wiphy_delayed_work. Instead, set a finish_queued flag and queue
> vdev_clean_wk, which runs under the wiphy mutex and performs the
> cancel. Add a check in the timeout worker so that if it was already
> queued before finish_queued was set, it exits without aborting a scan
> that is already finishing.

Agreed. Your explanation clarifies why the finish_queued flag is needed.

I will keep the finish_queued logic and update the commit message accordingly
in the next revision.

Thanks for taking another look.
