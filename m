Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8474B4871;
	Thu, 15 Oct 2026 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051621; cv=none; b=u7/TWvL1Q+wN4OdndBOO7HDZTkX2PKAasIF1UZGpFfYsmSZC/mNYNHiLShQoNOWK4G8nxVx2hmlIAXpG8vyaTF/cgayebDoSC+NnpLhwFTcwwwUahTGUN/IwrjKJ3qI2W2Nb+H3Uf1iUjKVYlw+EezL2nwrxvVhvV7l2rkRnqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051621; c=relaxed/simple;
	bh=b9Orik/miQkw1O9zE7Vh3PnyxvJojJBL7c/BGTh59fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HeIkf4ITiKJF+mqKeWi18PMHfziAGR6/FV6BKlGd78va4cwqgNo+ImFjsyrCRE9Rgm528W8imITu6h6R1llrvPhVoDhqhau60kun0WBHNUzIHNlfC4snBhQ18klyaVgRLR+xiKV/f5O7Yl2GB5JV4gOEwhnTVjmqmXWD4fsjRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4j50hV1mQWzpSvb;
	Thu, 15 Oct 2026 15:54:18 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D03E40579;
	Thu, 15 Oct 2026 16:06:55 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 15 Oct
 2026 16:06:54 +0800
Message-ID: <18286cdb-2b75-49cc-be3e-27c55eee9059@hisilicon.com>
Date: Thu, 15 Oct 2026 16:06:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devfreq: stop monitor before calling governor GOV_STOP
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, MyungJoo Ham
	<myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Rajagopal Venkat <rajagopal.venkat@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260721171141.1281754-1-mukesh.ojha@oss.qualcomm.com>
 <20260803181614.wk62kshvmbx6rpab@hu-mojha-hyd.qualcomm.com>
 <20260924123229.qkiyz5zo2owh5xtv@hu-mojha-hyd.qualcomm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260924123229.qkiyz5zo2owh5xtv@hu-mojha-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 9/24/2026 8:32 PM, Mukesh Ojha wrote:
> On Mon, Aug 03, 2026 at 11:46:14PM +0530, Mukesh Ojha wrote:
>> On Tue, Jul 21, 2026 at 10:41:41PM +0530, Mukesh Ojha wrote:
>>> The following NULL pointer dereference is observed when devfreq_monitor
>>> fires after userspace_exit() has freed governor_data:
>>>
>>>   pc : devfreq_userspace_func+0x10/0x2c
>>>   Code: 39402109 --> ldrb w9, [x0, #8]   (x0 = NULL)
>>>   Call trace:
>>>    devfreq_userspace_func+0x10/0x2c
>>>    devfreq_monitor+0x34/0x134
>>>    process_scheduled_works+0x1d8/0x804
>>>    worker_thread+0x1c0/0x458
>>>
>>> The fault address 0x8 is userspace_data.valid — an 8-byte unsigned long
>>> (user_frequency) precedes it, so governor_data == NULL is the cause.
>>>
>>> The race: devfreq_resume_device() reads df->governor without holding
>>> devfreq_list_lock, while governor_store() updates it under that lock.
>>> The stale pointer dispatches GOV_RESUME to the old governor
>>> (simple_ondemand) after the switch has already completed:
>>>
>>>   CPU 0 (devfreq_resume_device)        CPU 1 (governor_store)
>>>
>>>   read df->governor → simple_ondemand
>>>                                        lock(devfreq_list_lock)
>>>                                        GOV_STOP → monitor stopped
>>>                                        df->governor = userspace
>>>                                        GOV_START → governor_data alloc'd
>>>                                        unlock(devfreq_list_lock)
>>>   simple_ondemand->event_handler
>>>     (DEVFREQ_GOV_RESUME)
>>>     → devfreq_monitor_resume()
>>>         stop_polling == true → re-queue work  ← stray monitor!
>>>         stop_polling = false
>>>
>>> devfreq_monitor is now queued with df->governor == userspace. When
>>> devfreq_remove_device() or governor_store() next calls userspace GOV_STOP,
>>> userspace_exit() frees governor_data. The stray monitor fires,
>>> dereferences NULL governor_data, and crashes.
>>>
>>> Call devfreq_monitor_stop() before every GOV_STOP dispatch in the core,
>>> ensuring the polling work is fully cancelled before any governor tears down
>>> its private data.  devfreq_monitor_stop() is safe unconditionally:
>>> IRQ_DRIVEN governors return immediately, polling governors that already
>>> call it in their own GOV_STOP handler make the second call a no-op
>>> (stop_polling already true), and governors that never polled get a harmless
>>> cancel_delayed_work_sync() on an empty queue.
>>>
>>> Four sites are fixed: devfreq_remove_device(), governor_store(),
>>> devfreq_remove_governor() (governor module unload), and timer_store()
>>> (timer-type change performs a GOV_STOP + GOV_START cycle).
>>>
>>> Fixes: 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices which can idle")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>>
>> Can we consider reviewing fix for the mentioned issue ?
> 
> Change still applies on linux-next tip, So no need of a rebase.
> 
> Can I get review on this ?
> 
Unfortunately devfreq hasn't been taken patches for a few months.  AFAIK, a
few patchsets are pending to be queued up before any review can carry on.
