Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192718;
	b=yJckXfu1egtyoO3dLMlMe2BEtQvBc/bngPlQC8aTNus9RinbilWzIuH34ygnm7nU+t2H
	 kD7tmbqFJ5Fn7Gn5CMAReSvZ2Bf30Kjf6NIdsoH7I0iBZuB4t/aREYcs6Cj8rpYRbFjnl
	 X4iF/xKicRsn3BXfxCYMkvEX3dknAx65SYwgQ3VFGZ37msXZGiXvJ4QsHe0r2lZ8fPRaI
	 RLGVPaFV2DdvzHUv4CvSZhqPbVeQ3fYv4CE1u2jbISacWc2W08WMOmTz09ZQkjveM3oxj
	 TeTDFJshxfXhubiLuzhW3/44A3b6QGoyMVPHOmBww2f7Qx33s9EVpfq4kK1wOAKP9hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+ThjTfZ/MJMf53cu8iV1tYBuaT0UO+WOxcCiqTzZZCs=;
	b=G3I0Vb/FPiY7jrYrXV4iMBeNLRkTzh/hRwlacHEH9hEc2WH85MMEvi9Firz+frleCbZS
	 e+syP4LuEmcb9Nj3fQtWpFCb8EFPcfOw7GTy4Yx0MhcC8cKrFHpA+VOjO6/reNKjvbCXm
	 hJOS3n9Vv8GlW5+WyowNVvGhgnJ+na9NuqFPUNH3tQY2yELq9yU1Be7tz4COsEGteDIBB
	 iml9fUyFp30TwwJ3vf3sbjeutd3DOjttobWCEcATHINIqvDJfePo1phRs3OKjRgAn5gAq
	 wAYhFwRjR7Bj52aZqNbWrRaJ1DS+U8oac4peAIHSsG6+UtJxNwz/3cP42TGtMijprxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=R7+ebgAD;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA797606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA797606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=R7+ebgAD
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93cc1ab5f6cso49369985a.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794192716; x=1794797516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ThjTfZ/MJMf53cu8iV1tYBuaT0UO+WOxcCiqTzZZCs=;
        b=R7+ebgAD+hN4IT3q/lIQ++EVXLhiTty+ji0qMGcf4HyiNwY6sfg7abaq2NZz+QkSS1
         MvTAHnIB/Ps1mdD1tXRVQOl52uByTrXex0lUqQIvSuLrSOolkhHv7pW9PFpq9qd/OdRz
         1wcmfa89RNI4HV0+8V6nCVwqTrINwgN9P/xCFArokSTSS5hf3e3pyrcm/v3UMPstVaS2
         lu4f9M8Bm5Eh7mPuQN5uAGwqoN0RCHCKte4QG0tgmCejwGSCbqKGbu6lmlsQzs9iCz+A
         0MIvzJaP3YM7QNxXC9bTVOsD9KaKWhvyQGNNw19nZFnkFlsOSp2xYFJIdMwzzJNqNcjk
         2lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192716; x=1794797516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ThjTfZ/MJMf53cu8iV1tYBuaT0UO+WOxcCiqTzZZCs=;
        b=Ste2RqPiY0m09ZoicqUTE6GfZkjgpBRZSrifLFSNpNqokV7mpu+OsckwL7HgXnC+c7
         qGKAxKBU+IvYGvtz9fYbaQD5fNVauypzoRHFBeZ4FwcaYLeb/okqtzi/dvWefpBpuD+Z
         5naeYrmEOQQdvQZL4lGHPvjUnMIzht3zcoIQPoUU2b0Q0oihDO+0NTpHgN66QK7E1ZiD
         nRf0I2ScW+1P6/+OxN2d2YKZO2KVyCkbttRmbnV3ZqcRtTU32h2lkmgcWXWuyWiWhy2p
         Uywv0PGpjhMHEfsddyAulBKDoEim2jeEnLK/O8eyZzB8ZbSIMKOqKBNwqYpClnNTSHCJ
         fwUQ==
X-Forwarded-Encrypted: i=1; AL+hErEVTFRajZIK3hCE4N4tGe7kI6LKEd9SVA1h7ipFzsKiQ2C8q4/ZXZLYaY2YV0FSnIeRbmRNTgQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Tt5EmBKOcZWd5czNHMTjVIjQyR1SvMSRNik45r+dzBq/0xf/h
	8KIFg2uG5e+1S/7VjC7kcu/D8A9uGCeRpauHW2hwU10jf/jRUBsR1b5TvUbcNK3mJw==
X-Gm-Gg: AYBFou28H3LIfu8zwE1rA6d2rHVyOWux3gVaKC22FAFD1J6vYjaHKnC/+z6GoRQP41a
	RLjs1aGONsEkKMUkUwW4AWCn3P04UPdnxCKt+6bLY5k+3zcBbIOcK9ItIi9KsIXmhpTyO4+PGAE
	csyS9sik+YPJCdD7uAASHqsKVas2BcsWjtyTo1zGrJmGT5DI5Ia+3RoI9yABWq7kldh5U0PZcAC
	I4pUILk5pCVqyxJ6oe2BHL0HrwGizQ2hioKcjCdTSe99sAX9wDI5RO8Uz5UgifpSxXjBKisAWHL
	kvwO3WVOHE93ze1W6gAw1DrBspmr9MbSXBueKjD19MRjAqQBLclfu0sEyacJBRKB653T7ItQvNm
	+2chmUMcYvHpOx99GffdRB5VTsOcOCGXcRls+0oytGgc7dMlY+7j1n3KQfQAS0o7evTHzKBTvgR
	vo7qrrOiYoFcI6DmTUju1LcWojlAkI/IK8OkyFek4eXZ1DsdlWjCHllTkNIe7IfWi46VbO3aKT6
	UOyFGfJd9aaG5dSmAXg2JqNs/4j5ZaGkjW9oB3rHWY6kqosEJsep/ajRd71mDkvdvZxikz7KapB
	QgPVEieB5mHLFaJ1VgN6QHe83ERo
X-Received: by 2002:a05:620a:684a:b0:93e:5e2c:8c12 with SMTP id af79cd13be357-9478429958cmr426106785a.60.1794192716567;
        Sun, 08 Nov 2026 18:51:56 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecee18a77sm32225636d6.26.2026.11.08.18.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 18:51:55 -0800 (PST)
Date: Sun, 8 Nov 2026 21:51:53 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: kayano050408@gmail.com
Cc: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] usb: gadget: gadgetfs: fix ep0 request lifetime
 on disconnect
Message-ID: <bcb55195-2ed3-4b20-9afb-44b5e0efaa61@rowland.harvard.edu>
References: <20261107-b4-gadgetfs-ep0-v4-0-86bdfd684b54@gmail.com>
 <20261107-b4-gadgetfs-ep0-v4-1-86bdfd684b54@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107-b4-gadgetfs-ep0-v4-1-86bdfd684b54@gmail.com>

On Sat, Nov 07, 2026 at 09:46:13PM +0900, Jing Lin via B4 Relay wrote:
> From: Jing Lin <kayano050408@gmail.com>
> 
> gadgetfs_unbind() frees the preallocated ep0 request after disconnecting
> the gadget, assuming that no I/O remains active.
> 
> With dummy_hcd, disconnecting does not necessarily drain ep0, so a delayed
> userspace response can leave dev->req queued when it is freed. This
> triggers the warning in dummy_free_request() and a use-after-free when
> dummy_udc_stop() subsequently drains the endpoint queue.
> 
> gadgetfs_setup() and ep0_write() can also race on dev->req and req->buf
> while a control transfer is in flight or while a completed delegated OUT
> transfer is waiting for ep0_read() to copy the payload to userspace.
> Overwriting req->buf with a descriptor pointer causes clean_req() to free
> the descriptor buffer instead of the request buffer.
> 
> Copy completed control OUT payloads into a separate setup_buf in
> ep0_complete(), copy control IN payloads from userspace into a stack
> buffer before preparing dev->req in ep0_write(), and reset req->buf when
> control transfers finish. Track whether dev->req is queued, reject reuse
> while it is queued, and dequeue it without dev->lock before freeing it in
> gadgetfs_unbind().
> 
> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+c73e1942197af9f54ca3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c73e1942197af9f54ca3
> Cc: stable@vger.kernel.org
> Signed-off-by: Jing Lin <kayano050408@gmail.com>
> ---

Quick question...

> @@ -1781,15 +1842,21 @@ gadgetfs_unbind (struct usb_gadget *gadget)
>  		usleep_range(1000, 2000);
>  		spin_lock_irq(&dev->lock);
>  	}
> +	queued = dev->ep0_req_queued;
>  	spin_unlock_irq (&dev->lock);
>  
> +	if (dev->req) {
> +		if (queued)
> +			usb_ep_dequeue(gadget->ep0, dev->req);

Suppose another thread wants to submit dev->req, and has got as far as 
setting dev->ep0_req_queued and releasing the spinlock, but hasn't 
called usb_ep_queue() yet.  What prevents it from making that call right 
now?  Then the request would be active -- same problem as before, right?

> +		clean_req(gadget->ep0, dev->req);
> +		usb_ep_free_request(gadget->ep0, dev->req);
> +		dev->req = NULL;
> +	}

Alan Stern
