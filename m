Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421359;
	b=H7A77fWz/Rw1TleXlgRXoDSYU8kEc2NH49K1UNRPxadPxOm6i4GH5wbXZK+Pw+ZLTGjn
	 WX6JMqSOX856MSxG7ZJyiQosOqW+OppFn4g8QT5W0GLP5tj/SG6DLajLoeP3los/6hGH1
	 JP/uL+8ucC2MRPsGRWcCdC3Df7yF4ejAD2gZOSNdFvzighXzwOlFI305eGUQJpNlgxogw
	 Zbha5XWZ3yZiAKv4CCnn0m2SOTjkS4TEa1qpF7VtfUO1rmIfD07VMxhhKkHhzXyTWc9V8
	 5fzdwLwcROJCdWXfkUpk82WoTIuEXXy435IFjgKxdq9mj4uaAv8z7viuBOAznkMC9ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421359;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 From:Subject:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rkqgWRc27otdpALibzeS4RLFb3XtiaNFEPnkvU5rUjI=;
	b=b/cM79/ep+5QoWb2ujx27O4RGifEweiL9r5WzoBCJdcOIQ1rl9XXRfyDkxJPSBdAMNkF
	 saPzUgfjOq4MZ0eXsXHbCysv+KDHlsEIDYGF9nRYwoTZ/pgFGRIzs2cyrP6PdED+UmNPk
	 RhlTJcyaZ6Z6/DRZq5nB3AZ5G1cOmbE4v2BiNpNJHMs7ms04EJltrClbgAYgDgZOLKCs+
	 5OJ66HCHq34b0yFmtHzPVdJaFPrVWZhf771Was9V/ykiUS70363+f8UjMFBGlYb5VQsYz
	 LZVg9t4IcI92jrMSHt9NlC0NnWnQRm6pXFZvPwCMc4Aq9jCUkyGoxpTGk6TC5DI5bPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=olwXCStX;
	arc=none smtp.remote-ip=91.218.175.94
Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCB606A32E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCCB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=olwXCStX
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zWleqOppfklU2qNEH6k+5t2FcbXOtb2beCUwX3nqER4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795421355; v=1; x=1796026155;
 b=olwXCStXy49nUlzv6HQvVq6PwDpcsomzyY8/4Os/qqxWAOUFcly0L+zNDeoAccToCKARwMkc
 uA75nhXiBN7qhaq5n5dZiBkcIcXRxZAIPpzTumsVzxkzqDenBbEyC7+hJjSRgwFrrMzh423DaF4
 dRXkvqgj5cqlGb+5vygyoaRo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0cf66a178946746f;
	Mon, 23 Nov 2026 08:09:15 +0000
X-Mizu-Trace-ID: 0cf66a178946746f
X-Migadu-Flow: FLOW_OUT
Message-ID: <037c23b7-7b9e-4a9a-b608-552e419fcec5@linux.dev>
Date: Mon, 23 Nov 2026 17:09:06 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: Re: [PATCH net v2] netdevsim: fix rate node leak during reload and
 removal
To: xietangxin <xietangxin@h-partners.com>
Cc: Dmytro Linkin <dlinkin@nvidia.com>, Vlad Buslov <vladbu@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+bbd81e1e2276c534dea1@syzkaller.appspotmail.com,
 gaoxingwang1@huawei.com, huyizhen2@huawei.com,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20261121110858.1337003-1-xietangxin@h-partners.com>
In-Reply-To: <20261121110858.1337003-1-xietangxin@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/11/21 at 20:08 xietangxin wrote:
> netdevsim allows switching the eswitch mode to switchdev with zero VFs
> and creating rate nodes on such a device. However during device teardown
> nsim_dev_reload_destroy() only drops the eswitch back to legacy when VFs
> were configured, so the rate nodes are never destroyed and trigger the
> WARN_ON(devlink_rates_check()) in devlink_free():
> 
>    WARNING: net/devlink/core.c:544 at devlink_free+0x18c/0x26c, CPU#2: bash/5032
>    Modules linked in: netdevsim ...
>    CPU: 2 UID: 0 PID: 5032 Comm: bash Not tainted 7.4.0-rc3+ #77 PREEMPTLAZY
>    Call trace:
>     devlink_free+0x18c/0x26c (P)
>     nsim_drv_remove+0x9c/0xb4 [netdevsim]
>     nsim_bus_remove+0x10/0x1c [netdevsim]
>     del_device_store+0x110/0x190 [netdevsim]
>     ...
> 
> The rate nodes are also left behind on the devlink reload path, where
> they trigger the WARN in devlink_reload_reinit_sanity_check() instead:
> 
>    WARNING: net/devlink/dev.c:437 at devlink_reload_reinit_sanity_check+0x110/0x148, CPU#3: devlink/5205
>    Modules linked in: netdevsim ...
>    CPU: 3 UID: 0 PID: 5205 Comm: devlink Not tainted 7.4.0-rc3+ #77 PREEMPTLAZY
>    Call trace:
>     devlink_reload_reinit_sanity_check+0x110/0x148 (P)
>     devlink_reload+0x218/0x228
>     devlink_nl_reload_doit+0x3dc/0x5b4
>     ...
> 
> Evaluate the eswitch mode check unconditionally, so rate nodes are
> destroyed whether or not any VF was ever configured. Note this also
> resets a zero-VF switchdev device back to legacy mode on reload, like
> the existing VF case.
> 
> Reproduce by:
>    $ echo "10 1" > /sys/bus/netdevsim/new_device
>    $ devlink dev eswitch set netdevsim/netdevsim10 mode switchdev
>    $ devlink port function rate add netdevsim/netdevsim10/n1
>    $ echo 10 > /sys/bus/netdevsim/del_device
> 
> Replacing the last step with "devlink dev reload netdevsim/netdevsim10"
> hits the devlink_reload_reinit_sanity_check() WARN instead.
> 
> Fixes: 885226f5680e ("netdevsim: Implement support for devlink rate nodes")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+bbd81e1e2276c534dea1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6af9824c.920b2b3a.148c65.0009.GAE@google.com/
> Reported-by: Xuanqiang Luo <xuanqiang.luo@linux.dev>
> Link: https://lore.kernel.org/all/17cc4251-04ae-41a7-a872-fc5cf525b58f@linux.dev/
> Signed-off-by: xietangxin <xietangxin@h-partners.com>
> ---

Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks,
Xuanqiang
