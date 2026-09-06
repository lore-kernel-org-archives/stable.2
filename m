Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A43CB907
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666662; cv=none; b=Z66Gla4gagvo5gKH9NBYLZ3SXYZLgkHTbgG7Wo1EOGP6w710Kd7zuCwm/m5ECC9+B1M5Z6TvoGDyKWnZR2kwq3bdJ6YLb7A5XWZlGPlHEaGCaGxobp1QC6OmhyMpElObCMDbSM9kWxysNpfSZJxBpSTWCiVd0pZ7dg+jXfp6So0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666662; c=relaxed/simple;
	bh=U8xHrBZ7Q3BQXgnr2L0uMBgk7gt6wGxE+ax6mXKRsWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8+cwCO+l3PpsvF5+WArTGNLCIpjsUByULXvvovUJY4epzLJelmT6tl0j5LmgMRLW2r5IljVdd2jJBzDqsh9m9W3f8/3JV43hR7qGKFX0cgnrkp1L9qzqJbh6iag+A5Y4FPFR2R7QDb97zPedmZb3iMnGIJufBBinKi6RzOleYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=stGPQdKV; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="stGPQdKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1788666650;
	bh=PQxvNMzas3x+IlCCh6neBcmKorR8pDTgu0p5/v3lP/I=;
	h=From:Subject:Date:Message-ID;
	b=stGPQdKVIWfYEdn1rYiNENvHvUAfk2PaCzUkbfBKmfVU1vxqp+rg/z8m3+iDi8zow
	 Tjhxk7Aywrp/7J2Df7MMQdzc1sH8WN8OxO5Q0kF1B/f4HBDaYrSgTWUndEzrrzIcjj
	 qAzJuJKYT7+ve5dOIyRDFiztabh/6Wk6tLj6uG8g=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.32) with ESMTP
	id 6A9CE30D00007E2F; Sun, 6 Sep 2026 11:50:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6954354456958
X-SMAIL-UIID: 553362F731704953BFFB61FDF2BADA41-20260906-115040-1
From: Hillf Danton <hdanton@sina.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>,
	Ye Liu <ye.liu@linux.dev>,
	lirongqing <lirongqing@baidu.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] mm/vmalloc: Use dedicated unbound workqueues for vmap drain
Date: Sun,  6 Sep 2026 11:50:24 +0800
Message-ID: <20260906035027.2106-1-hdanton@sina.com>
In-Reply-To: <20260905152717.11711-1-urezki@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 5 Sep 2026 17:27:17 +0200 "Uladzislau Rezki (Sony)" wrote:
> drain_vmap_area_work() function can take >10ms to complete
> when there are many accumulated vmap areas in a system with
> high CPU count, causing workqueue watchdog warnings when run
> via schedule_work():
> 
>   workqueue: drain_vmap_area_work hogged CPU for >10000us
> 
> Move the top-level drain work to a dedicated WQ_UNBOUND
> workqueue so the scheduler can run this background work
> on any available CPU, improving responsiveness. Use the
> WQ_MEM_RECLAIM to ensure forward progress under memory
> pressure.
>
If the dedicated worker will run for 4ms on CPU2 before the tick irq kicks it
off cpu, the system event worker on CPU2 has to wait at least for 4ms to handle
200 events for example in 1ms, the net effect is the same as the current scenario
where 200 events wait for the drain_vmap_area_work to complete on CPU1.

Different workers does not help to dramatically decrement the micro seconds
the drain_vmap_area_work takes.
