Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EF44F569;
	Mon, 21 Sep 2026 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983648; cv=none; b=c8ZvuHnSyqGapIg1o2AjulpMG/lQvijN752pchAxTWEC5f3e0v9Ow1fNhFIS4hq78EIuq7l77jY8mnr58BwF8aY3aO8KtQW+mACYhQyizbd7rZcT26IvvxxWkMxGXZb8n6LaRUPFk6WMyCJRIgMCTzfLx2fVkIczuMAXJvuamv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983648; c=relaxed/simple;
	bh=Em0PuIVR4leeHS3RRP4B9eAhCfxTjs9AMXPU63x3Q5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jd6W64AlUDdTgxi8Fyl5UYtBiO8szRhL4jv+4lMFzESHWDt1OCYdHtrvQTY/yjsbTHWVemYzrXD5FtE/tsoLSP78kTIQVLcj5ZHYC7jRoi/4g6UD0GJo7YbSppqyX98HRugbITGbsx8w11usPly5pOIgQrc31fFIJqeWhCKd2ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=L7LF6Qdn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="L7LF6Qdn"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8f73ae4;
	Mon, 21 Sep 2026 17:40:40 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH net] ptp: ocp: prevent watchdog rearming during detach
Date: Mon, 21 Sep 2026 17:40:35 +0800
Message-Id: <20260921094035.48634-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904064308.4044677-1-runyu.xiao@seu.edu.cn>
References: <20260904064308.4044677-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c356cc2b03a1kunm1927346a4336e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGElCVkJDSkhLTh5OHRlMS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pOTE5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=L7LF6Qdn6uXxFKqiS9hIuKI6pnwRSBMXWVVNi552vLdYeitOGvG773fFBtJZ30FdypLKOUx35A5cBdk7+pVSQ0SlJn5Q72lP0+Dj5HUq4aWYbkU+nwHyiHPVno+Y43m8hg3wjNuDlj/iWQ3M3pij7xZSksoAd3px1wg6ruG1rfE=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Em0PuIVR4leeHS3RRP4B9eAhCfxTjs9AMXPU63x3Q5E=;
	h=date:mime-version:subject:message-id:from;

Thanks for the review.

After checking the timer implementation, I agree that the original bug
premise was incorrect. The watchdog is only armed during clock
initialization and rearmed by its own callback. timer_delete_sync() waits
for the callback to finish and removes a timer rearmed by that callback
before returning.

There is no independent rearm path during ptp_ocp_detach(), so the claimed
use-after-free is not reachable.

I will withdraw this patch and will not send a v2. The Fixes and Cc: stable
tags are therefore not appropriate.

Regards,

Runyu
