Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D2233149;
	Sun,  4 Oct 2026 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791106316; cv=none; b=sDOVsb/SL812JUnLiXQuUEV5PCZW/T3CbtBbd/78QbPGGNmR+OlNOnnW8Bd+fdj1/8Dh7cCg7/Flb0y7LTl8l5T8WC2FnwbTEAVPU3KbWVtPwYxhix1aTuewXV+Y43nWw5st6Ki6svCPs9s17oQ/snZ37+4D2Ov5Obzl0ltcnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791106316; c=relaxed/simple;
	bh=gA1c2dBQnXcQowlyNF+ZjWvhmL8AaxpL/xXnvowpW8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C11p2EE/x/qNSyiadBrHklTbqQQdNk5DwAi8+rPtnkRMQv7Yt8FakFwe0fiKinltuCqhzZ2Iox2rugNbBhRyapLMbtEhBjfJr33IGRcvnH6XZsqPtwYt0PdXouPqWodk5fo99uXk2vtGB4vjGNiaY6R8mq/6AdDpagbkol3uWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iVCXeo9b; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iVCXeo9b"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4feacba8a;
	Sun, 4 Oct 2026 17:31:42 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-omap@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] mmc: omap: synchronize clock timer before disabling fclk
Date: Sun,  4 Oct 2026 17:31:31 +0800
Message-Id: <20261004093131.1188081-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAPx+jO8fr+Jkb9u8bx6a7cv0=oD0jUGqZpAamw4j+LVFnqSw-g@mail.gmail.com>
References: <20260929124522.2141124-1-runyu.xiao@seu.edu.cn> <CAPx+jO8fr+Jkb9u8bx6a7cv0=oD0jUGqZpAamw4j+LVFnqSw-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa10641411f03a1kunm0241a43c336b3c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkxOVkgeShpJGEJOTE5IHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=iVCXeo9bh5S0qQweG/yL94blzVQ2wtndjQkz/Z2u3AXUnL61PoKvm+DsiJkCEbvVXeNWGTYiEIfIST6nd0cMBOyTcWxJ7cB7I0L+m2/nBKaQ4qBjedzQLSA6ozhSU8dX6Ad2Tl+JRuPIMqsJJygJwgkldE6Fnt3Y0llszFDeqn0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=D59k84+8qgFdzoVqOD5G4ei3FrOGQa1BN9QWG8/4t/A=;
	h=date:mime-version:subject:message-id:from;

Hi Ulf,

On Wed, Sep 30, 2026 at 06:01:02PM +0200, Ulf Hansson wrote:

> On Tue, Sep 29, 2026 at 08:45:22PM +0800, Runyu Xiao wrote:
>
> > @@ -214,7 +214,7 @@ static void mmc_omap_select_slot(struct mmc_omap_slot *slot, int claimed)
> > -       timer_delete(&host->clk_timer);
> > +       timer_delete_sync(&host->clk_timer);
>
> At a first glance this looks fine, but I am slightly worried that this
> could deadlock. Have you verified that?
>
> > @@ -273,7 +273,7 @@ static void mmc_omap_release_slot(struct mmc_omap_slot *slot, int clk_enabled)
> > -       timer_delete(&host->clk_timer);
> > +       timer_delete_sync(&host->clk_timer);
>
> Ditto.

I checked the locking and calling contexts for both changes.

mmc_omap_clk_timer() only takes host->clk_lock. Neither timer_delete_sync()
call site holds that lock; mmc_omap_select_slot() has released slot_lock,
and mmc_omap_release_slot() calls it before taking slot_lock.

The interrupt completion paths pass clk_enabled == 1 and use mod_timer(), so
timer_delete_sync() is reached only from process or workqueue context. I do
not see a lock inversion or a timer_delete_sync() deadlock in these paths.

Kind regards,
Runyu
