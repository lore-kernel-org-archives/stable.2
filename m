Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F0473C65;
	Fri,  4 Sep 2026 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539261; cv=none; b=m/tsrj7BMbhPDGd4OvTEZdA6/+lFUzvnjIGUvsiqEVU1xXnNgkBsl0nosSg7WGM3w643oRvpaZdJVU4eVhgD6+EavjTpUQaUOODNPKRi35fp/m17re2vm1oZIE8OPy/RvOGMMEAsPsw3cofocV8A+q/WaqZKVLPfgMQ5hU09Y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539261; c=relaxed/simple;
	bh=x4elf8yNPJA0v5b9x3Z1EMG5dwZtqIg0e6XMDVweATY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T198Y6bOztEuMewRR8hpnalbQSLlVRtW+O9DD5MWhV0YZBPGj89w4Q/iHYCh5hmlVBLD0+6dcpVwzwDn+pqJJfllrhjyBdnZS5JdGlu9bBMeslLOkbpfh/EdzcO/M1HLLK5CdpTi6GN/d/3OobW/8t4EGjDAEqNDcdNVc2yuJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OKEiv/ZI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OKEiv/ZI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9AA7E1A19AB;
	Fri,  4 Sep 2026 16:27:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EB026057F;
	Fri,  4 Sep 2026 16:27:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E210611C783E9;
	Fri,  4 Sep 2026 18:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788539257; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=EiAdr21m+t8nZuiLRogn0ySzF7tcNXTsG+HSx+JU1Bg=;
	b=OKEiv/ZIX5iP6wlesIEB5HlxL7FtN/SV0CXjKDqhX9DE0yp/CEZizmv2uN6I0bYWq7P4HH
	VZ8qNwi6pSHdHMrS/k9rmq2DF1MLsw8Ej6xFH4oC9JTQsMtjUZzb/jdD/2EeLXdD9CNTZ6
	oVBh9MWxCkBSTzeHvn2BZdAVT/7evpkrLpUJVzfRLY8WyQvPSXm4TahBxS+PW0oYSM04Lu
	7BPuHpfrEWQ8bX6i5nzB/OHHZ1T9mx57unsFT+LE7YvdupG5eWumBxl2ddt2ohP6pS9ynr
	TUCHHO6WuG+KmmL0xBhUwymrc09v4e7dIXN8qiO66zGPEBr67CUugbLOwxO6Tg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  alex.aring@gmail.com,
  stefan@datenfreihafen.org,  david.girault@qorvo.com,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  stable@vger.kernel.org,  Xuanqiang
 Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v2 2/2] mac802154: pin netdevs for queued RX
 descriptors
In-Reply-To: <20260903123202.60152-3-xuanqiang.luo@linux.dev> (Xuanqiang Luo's
	message of "Thu, 3 Sep 2026 20:32:02 +0800")
References: <20260903123202.60152-1-xuanqiang.luo@linux.dev>
	<20260903123202.60152-3-xuanqiang.luo@linux.dev>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 18:27:35 +0200
Message-ID: <87ld9hyoaw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 03/09/2026 at 20:32:02 +08, Xuanqiang Luo <xuanqiang.luo@linux.dev> wrote:

> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
> The RX path keeps the receiving sub-interface in queued beacon and MAC
> command descriptors after leaving its RCU read-side critical section. An
> interface can therefore be unregistered and freed before mac_wq consumes
> the descriptor, leading to a use-after-free such as:
>
>   BUG: KASAN: slab-use-after-free in mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
>   Read of size 8 at addr ffff0000c6db0ba8 by task kworker/u16:3/61
>   ...
>   Call trace:
>    show_stack+0x20/0x38 (C)
>    dump_stack_lvl+0x78/0x90
>    print_address_description.constprop.0+0x88/0x398
>    print_report+0xa8/0x278
>    kasan_report+0xa8/0xf8
>    __asan_load8+0x9c/0xc0
>    mac802154_rx_mac_cmd_worker+0xc0/0x498 [mac802154]
>    process_one_work+0x334/0x8b8
>   ...
>   Allocated by task 630:
>    kasan_save_stack+0x2c/0x58
>    kasan_save_track+0x20/0x40
>    kasan_save_alloc_info+0x40/0x58
>    __kasan_kmalloc+0xa0/0xb8
>    __kvmalloc_node_noprof+0x1e8/0x588
>    alloc_netdev_mqs+0x74/0x7f0
>    ieee802154_if_add+0xac/0x630 [mac802154]
>    ieee802154_register_hw+0x31c/0x3d0 [mac802154]
>    fakelb_add_one+0x250/0x318 [fakelb]
>   ...
>   Freed by task 652:
>    kasan_save_stack+0x2c/0x58
>    kasan_save_track+0x20/0x40
>    kasan_save_free_info+0x4c/0x78
>    __kasan_slab_free+0x60/0x90
>    kfree+0x194/0x478
>    kvfree+0x44/0x60
>    netdev_release+0x4c/0x68
>    device_release+0xac/0x130
>    kobject_cleanup+0x84/0x248
>    kobject_put+0x98/0xf8
>    netdev_run_todo+0x3a0/0x5e0
>    rtnl_unlock+0x18/0x30
>    ieee802154_unregister_hw+0x48/0x90 [mac802154]
>    fakelb_remove+0xe8/0x148 [fakelb]
>
> Hold the receiving netdev from before a descriptor is queued until the
> descriptor is released. Since sdata is the netdev's private data, this also
> keeps sdata valid while a worker or scan cleanup accesses the descriptor.
>
> Fixes: 57588c71177f ("mac802154: Handle passive scanning")
> Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
