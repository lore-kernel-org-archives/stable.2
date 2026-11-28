Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861010;
	b=Uv+0hYgPAyTdvow0jFREZwNf0qXUP/t8DB4VJiPgE0H9URZJrtQo8cuD4417agUgDIBs
	 NsjaowexT/q6A4XVN/JV7bl+pUVkiwUqawVYlNTn1rGZPQTf3BENr87/L5+MLNEkeXUob
	 DB2B3eju0TsL1oJPj3PXAY045XcEBN4Ea9qIV4oYRjzGnwtB9WZO92z7Dp2zBkgrdl5qP
	 3+Pcs+4qFU0dpUiGR8SaCKgn2wY3zHSdCKUZIvmbwqfrs6+l0vh05t0C9nVtBllqmP1W0
	 tXc2uHlEYfkyu/vP4h+h4ByE/I6U8yctEq8jGj09RJmtjM0Lwqamx180d0LK6d2Lmzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861010;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=a19TK0+SU6/Jn4mvBvBHcDnmBupvTyQGHJGLuscEEMU=;
	b=lps5xuK2fOwQSfOdLwebSxqKNLzxOWblsah0mfAanTq6ro5DNpTUeyqw5YNhlxIypXBf
	 Mlg3nPkNNzp0/yVjRTDt7TvaoVZnMDaGP1th7OYYjc3DbNw0vNIqDSyySuN2gET55rC/A
	 9fF7DfkW0oUJWEnDsTvzeUQBFvQ3XYNss/reNGbLxW1NNTNw0LZ31Li6muNEjObvj490w
	 mr88AkBCaK7yNcbv2//XyNogVxXsNj0BGsIokCu6kCOzBJXLzVVCHS61aK00WKGEmxGpH
	 8ryX0b7hmSgYlNDiaTbXnQfh0FpLOHxN8TO8QsNbAM/kn2IvkDI4p2pSU5Wnj+67ang==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=h-partners.com;
	spf=pass smtp.mailfrom=h-partners.com;
	dkim=pass header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=li7jUiuR;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A75606A31C;
	Sat, 28 Nov 2026 10:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=li7jUiuR
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a19TK0+SU6/Jn4mvBvBHcDnmBupvTyQGHJGLuscEEMU=;
	b=li7jUiuRoEUn+xXvDsNI615hlT5X3pFQJx+66NUvN3SPZZtn0y3SUZMmq5KFlZZUk5rlB8aay
	Zro17kNYWz/ZYTxCJj0APtSIZIMRYeeVMnKfyk6gJB8jIJva8YYMNSTwiY99Zsr8ottcOx3FbqB
	ZL/4I6I7aTcfIcFjbUqwvnE=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jc5m34Y6Kz1prKt;
	Sat, 28 Nov 2026 18:16:19 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 7393B4057D;
	Sat, 28 Nov 2026 18:16:38 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 28 Nov 2026 18:16:37 +0800
Message-ID: <1b5e72f9-007e-4b99-b452-a57e8767b436@h-partners.com>
Date: Sat, 28 Nov 2026 18:16:36 +0800
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
Subject: Re: [PATCH net v2] netdevsim: fix rate node leak during reload and
 removal
To: <netdev-bot+sashiko@kernel.org>
CC: <kuba@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <pabeni@redhat.com>, <dlinkin@nvidia.com>,
	<vladbu@nvidia.com>, <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<syzbot+bbd81e1e2276c534dea1@syzkaller.appspotmail.com>,
	<gaoxingwang1@huawei.com>, <huyizhen2@huawei.com>, <xuanqiang.luo@linux.dev>
References: <20261121110858.1337003-1-xietangxin@h-partners.com>
 <179560577028.3135.18386607599971206035@kernel.org>
Content-Language: en-US
From: xietangxin <xietangxin@h-partners.com>
In-Reply-To: <179560577028.3135.18386607599971206035@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100001.china.huawei.com (7.202.195.168)



On 11/25/2026 7:22 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The fix is incomplete: rate nodes still leak, and the same
>   WARNs still fire, when the device has been left in the devlink…
> 
> --
> 
> netdevsim: fix rate node leak during reload and removal
> 
> nsim_dev_reload_destroy() now checks the eswitch mode unconditionally.
> Rate nodes created on a zero-VF switchdev device are then destroyed via
> nsim_esw_legacy_enable() -> devl_rate_nodes_destroy() on both reload and
> removal, which avoids the devlink_free() and
> devlink_reload_reinit_sanity_check() WARNs.
> 
> Link: https://lore.kernel.org/all/17cc4251-04ae-41a7-a872-fc5cf525b58f@linux.dev/
> 
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index c6b17b3873271..b483c25dfecdd 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -1700,11 +1700,10 @@ static void nsim_dev_reload_destroy(struct nsim_dev *nsim_dev)
>>  		return;
>>  	debugfs_remove(nsim_dev->take_snapshot);
>>  
>> -	if (nsim_dev_get_vfs(nsim_dev)) {
>> +	if (nsim_dev_get_vfs(nsim_dev))
>>  		nsim_bus_dev_set_vfs(nsim_dev->nsim_bus_dev, 0);
>> -		if (nsim_esw_mode_is_switchdev(nsim_dev))
>> -			nsim_esw_legacy_enable(nsim_dev, NULL);
>> -	}
>> +	if (nsim_esw_mode_is_switchdev(nsim_dev))
>> +		nsim_esw_legacy_enable(nsim_dev, NULL);
> 
> [Severity: Medium]
> Can rate nodes still leak when the device is in the reload_failed state?
> 
> The new unconditional check sits after the early return at the top of
> nsim_dev_reload_destroy():
> 
> drivers/net/netdevsim/dev.c:nsim_dev_reload_destroy() {
>     ...
> 	if (devlink_is_reload_failed(devlink))
> 		return;
>     ...
> }
> 
> When reload_failed is set, devl_rate_nodes_destroy() is never reached.
> 
> Nothing seems to stop rate nodes from being created while reload_failed
> is set. One possible sequence:
> 
> 1) devlink dev reload runs nsim_dev_reload_down(), which resets
>    esw_mode to legacy. nsim_dev_reload_up() then fails, either through
>    the fail_reload debugfs knob (returns -EINVAL) or through an error in
>    nsim_dev_reload_create(). devlink_reload() then calls:
> 
> 	devlink_reload_failed_set(devlink, !!err);
> 
> 2) devlink dev eswitch set ... mode switchdev still succeeds. With zero
>    VFs, nsim_esw_switchdev_enable() only does:
> 
> 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
> 
>    No devlink command in net/devlink/ checks reload_failed.
> 
> 3) devlink port function rate add .../n1 also succeeds.
>    devlink_nl_rate_new_doit() has no reload_failed check, and
>    nsim_rate_node_new() only checks nsim_esw_mode_is_switchdev(). The
>    node is added to devlink->rate_list.
> 
> 4) del_device leads to nsim_drv_remove() -> nsim_dev_reload_destroy(),
>    which returns early. nsim_drv_remove() has no other rate cleanup, so
>    devlink_free() hits:
> 
> 	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
> 
>    The devlink_rate and nsim_rate_node allocations and their debugfs
>    directories are leaked.
> 
> If step 4 is a second devlink dev reload instead,
> nsim_dev_reload_down() -> nsim_dev_reload_destroy() returns early again,
> and the WARN in devlink_reload_reinit_sanity_check() fires.
> 
> These are the same two WARNs the commit message describes. The early
> return is older than this patch. However, the subject promises to fix the
> rate node leak during reload and removal, and this case is still
> reachable.
> 
> Would it make sense to also destroy the rate nodes before the
> reload_failed early return, or in nsim_drv_remove()?
> 
>>  
>>  	nsim_dev_port_del_all(nsim_dev);
>>  	nsim_dev_hwstats_exit(nsim_dev);
> 
You are right, the case is reachable. I confirmed it on an unfixed
kernel (v7.4-rc4):

  # echo 1 > /sys/kernel/debug/netdevsim/netdevsim10/fail_reload
  # devlink dev reload netdevsim/netdevsim10
  Error: netdevsim: User setup the reload to fail for testing purposes.
  # devlink dev eswitch set netdevsim/netdevsim10 mode switchdev
  # devlink port function rate add netdevsim/netdevsim10/n1
  # echo 10 > /sys/bus/netdevsim/del_device
  [  962.254414] WARNING: net/devlink/core.c:544 at devlink_free+0x18c/0x26c

So a rate node added after a failed reload is not cleaned up on removal
and the devlink_free() WARN fires again.

I will respin. Instead of destroying the rate nodes before the
reload_failed early return, v3 will follow the approach of commit
39c23556e79f ("netdevsim: reject port addition and clean up ports after
a failed reload") and reject rate node creation with -EIO while the
reload has failed.
The respin will also be posted targeting net-next instead of net and
will drop the Cc: stable tag, following the routing of that commit.

 static int nsim_rate_node_new(struct devlink_rate *node, void **priv,
 			      struct netlink_ext_ack *extack)
 {
	struct nsim_dev *nsim_dev = devlink_priv(node->devlink);
	struct nsim_rate_node *nsim_node;

+	if (devlink_is_reload_failed(node->devlink))
+		return -EIO;
+
	if (!nsim_esw_mode_is_switchdev(nsim_dev)) {

Rate nodes cannot exist at the moment reload_failed is set: the failing
reload's reload_down() -> nsim_dev_reload_destroy() destroys them before
reload_up() records the failure, so blocking the post-failure creation
path closes the leak completely.

pw-bot: cr
-- 
Best regards,
Tangxin Xie

