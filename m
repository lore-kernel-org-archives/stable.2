Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BF73F1678;
	Sun,  4 Oct 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092381; cv=none; b=IbP/hYi1pvF/JivloKpgP0xgCX4aJaDOUrvOKvNJtcHAwbFooLZ3CXa2+fq5ebGavbX2wvt2rxhJ0ANwt7FNVWKbxLU/RMLghRQyQuBr7KXr05oK45Kz4o3i0VrioUHB/GcTDyODlCGr59ub3XxwHHSNHWVdxlzekk47OD6VmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092381; c=relaxed/simple;
	bh=jijZI6yjjfQAW806ygd+9VJR4IpenAUBuh0SyWcBtpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPdQQkHP7rc7S4Yds8E4AeqZG5CaS54s+urXBfhcy8uvMoLXSSIDpZ0x3t1jPxMTVkLpb9DjGBnJqoCcFA9VBcKzm/8seS2dd6iTGCrw1fKAHhJx5HbTUErXVgUpe00hJOsVq+UQEe4r46mpCnwmdIuNsKBUsqAgzYLfkOdrIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=CRivSCvw; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="CRivSCvw"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fe9481fc;
	Sun, 4 Oct 2026 13:39:21 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Andriy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Karol Wrona <k.wrona@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] iio: ssp: Serialize watchdog timer state changes
Date: Sun,  4 Oct 2026 13:39:15 +0800
Message-Id: <20261004053915.1138888-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arzdLtzXQ4cvObrL@ashevche-desk.local>
References: <20260930070319.2933744-1-runyu.xiao@seu.edu.cn> <arzdLtzXQ4cvObrL@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1056c889c03a1kunme3c6fad532f25b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUgeVhkaGEwdQh1PS0hKH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=CRivSCvwjjmYzkDdE7uOkhgn1RGYo/GvIXsY4jJ/Vpxv5LN/PnIs7sDchS5dFC3w1bNivRhy51znhEXYxcJVXatgVK0BhHXdWC/rxtNdXjnW22DsOg/IolEboduq85iSVzlUAbZfyfohxg45mM0bHEXCe6q1c1Z0N0cFwOVcF/o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=jr8ygInJZtEsQ24M0yOeUUNt6jsYaHcKOuwaorNywJI=;
	h=date:mime-version:subject:message-id:from;

Hi Andy,

Thanks for the review.

On Wed, Sep 30, 2026 at 03:03:19PM +0800, Runyu Xiao wrote:
> The SSP watchdog timer rearms itself from its callback, but the driver uses
> timer_delete_sync() when the last sensor is disabled and during suspend.
> Those operations do not prevent a concurrent enable or callback from
> rearming the timer after the deletion has completed. The final remove path
> also used timer_delete_sync(), which does not provide the shutdown
> guarantee needed before releasing the device state.
>
> Protect the watchdog state and enable reference count with a mutex. The
> callback checks a state flag before rearming. Reusable stops clear the
> flag before deleting the timer. Use timer_shutdown_sync() for the final
> remove path so that any later rearm attempt is rejected permanently.
>
> struct ssp_data {
>     struct timer_list wdt_timer;
>     struct mutex wdt_lock;
>     bool wdt_enabled;
>     struct work_struct work_wdt;
> };

On the x86_64 build, pahole reports wdt_timer at offset 16, wdt_lock at
56, wdt_enabled at 80, and work_wdt at 88; sizeof(struct ssp_data) is
816 bytes. There is a 7-byte hole after wdt_enabled.

> _mod:
> + if (READ_ONCE(data->wdt_enabled))
> +     mod_timer(&data->wdt_timer, ...);
>
> What are we going to do if just after this wdt_enabled becomes false?
> (Is it a possible case?)

Yes, that is possible. The callback may read true before the stop path
writes false, then rearm the timer once. timer_delete_sync() waits for the
running callback and removes that rearmed instance before returning.

> Same Q to all the below. Hmm... It seems they are all protected by the
> mutex?

All process-context start and stop paths use wdt_lock. The timer callback
is the exception because it cannot take a mutex; the state check and
synchronous deletion handle its in-flight rearm. The mutex serializes
operations, but a start that runs after a reusable stop releases the lock
can arm the timer again. That is expected after an ordinary sensor enable.

There is also a suspend interleaving. A pending work_refresh can call
ssp_sync_available_sensors() and ssp_enable_sensor() after ssp_suspend()
checks enable_refcount. If the count is zero, the first successful sensor
enable can arm the timer. The first version did not close this path.

In v2, suspend state is tracked under wdt_lock. Sensor enables can update the
count while suspended but cannot arm the timer. It is restarted only after
resume succeeds, or if suspend fails. Watchdog work is synchronized before
the suspend command. I will send v2 separately.

Final removal uses timer_shutdown_sync() to reject later rearm attempts.

Thanks,
Runyu
