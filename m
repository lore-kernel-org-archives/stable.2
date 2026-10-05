Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B524CEE65;
	Mon,  5 Oct 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215256; cv=none; b=MpkQth62uLsaMzShhqNK3iSL6//lwlnxWBAnYAudq7gddUZtOuDluH9/BzHeCvqNO42ZcltiYimL0ClPcwUxLtOspdBJl+anNn7hU8UF4pC98XwV58HGjaZDPQ+Zw3Jknp3UiVcQ5bcKHj3zw6vkYvxt54Lz2hTLhdOduT/AKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215256; c=relaxed/simple;
	bh=dP8UEyU9wzQweZL2mPytgGZw1csTDnAAGHb9lQ1/CRo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=IGRWWRbg+AbXx4Gk9KXmonFINdd4Mqb5SB7jvuusOVu72KSzmvrqGMLpxgtLFdxbHItJI4SQOkw4Qv11pUg1pMOLuO9zv/ztbjMTT32gpFnQWOfYzKjcGla7wDGaffe4AKcJ+cTsN4rcO7vVEnTnhjg7PlpSILYPxVXDUfNiLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=TNTPjRrO; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="TNTPjRrO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=dd2geTHNEiljsufazF3WqhIB0SzJSJCWXKsYxd8T1sI=; b=TNTPjRrOyWfCVBBFnhnRO7By7f
	iSxv2IUwqaQf3LyU2GmRjv0R9ySEm04j7MiCupHpfiYbCstAADg9/9OzYLVGuag8V3trKI56MtH7h
	M30LrMtzJnGhBy02hW3f563qKFKdk3A9+nA4PSqSe2YWx2feVIJ6WXQmaRUxzgmqaJTxsF2c9Vk0y
	LFOzZTC7FzCCMhxJAfgVqktdHsFwBagjKj6FxYv8pRvM53YTr6/KwdMxzN/0cw1SMsMWozSEFa5b/
	LbHfB+iI5DE8bpWuQFN1xAOBUsFwwEg8d3Xu/GbtMVXcBlAp4LQBqkRNnlwbGwJquSgjuxr02BsNS
	EOuOYbjA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xDkuK-00000002ItV-0kt6;
	Mon, 05 Oct 2026 09:47:20 -0600
Message-ID: <4a7bdf58-1981-4ab8-b021-cfbf20044be7@deltatee.com>
Date: Mon, 5 Oct 2026 09:47:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yogesh Gaur <yogeshgaur.83@gmail.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai@fygo.io>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Nan <magiclinan@didiglobal.com>, Xiao Ni <xiao@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20261004055712.1293-1-yogeshgaur.83@gmail.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20261004055712.1293-1-yogeshgaur.83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: yogeshgaur.83@gmail.com, song@kernel.org, yukuai@fygo.io, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, magiclinan@didiglobal.com, xiao@kernel.org, hch@lst.de, hare@suse.de, syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] md: don't hand out the array before md_alloc() has added
 mddev->kobj
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-03 23:57, Yogesh Gaur wrote:
> md_alloc() publishes the gendisk before it is done setting the mddev up:
> 
> 	disk->private_data = mddev;
> 	...
> 	error = add_disk(disk);
> 	if (error)
> 		goto out_put_disk;
> 
> 	kobject_init(&mddev->kobj, &md_ktype);
> 	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");
> 
> add_disk() makes /dev/mdN openable, and md_open() only refuses the open
> when MD_CLOSING is set.  mddev comes from mddev_alloc() and is zeroed,
> so anything that gets in between add_disk() and kobject_add() sees an
> mddev->kobj that has never been through kobject_init() - no ktype, no
> kref, state_initialized clear.
> 
> syzbot opens the array in that window and issues ADD_NEW_DISK:
> 
>   kobject: '(null)' (ffff8880120640f0): is not initialized, yet kobject_get() is being called.
>   WARNING: lib/kobject.c:642 at kobject_add_internal+0xea/0xcd0 lib/kobject.c:225
>    kobject_add_varg lib/kobject.c:374 [inline]
>    kobject_add+0x163/0x240 lib/kobject.c:426
>    bind_rdev_to_array+0x80c/0xdd0 drivers/md/md.c:2621
>    md_add_new_disk+0xe3b/0x1850 drivers/md/md.c:7684
>    md_ioctl+0x200a/0x2610 drivers/md/md.c:8499
> 
> bind_rdev_to_array() is not the only way in.  md_run() calls
> sysfs_create_group(&mddev->kobj, &md_redundancy_group), and
> internal_create_group() has its own WARN_ON(!kobj->sd), so RUN_ARRAY in
> the same window warns too.  Guarding the individual callers would mean
> finding all of them; the window itself is what should not be reachable.
> 
> Refuse the open until md_alloc() has added the kobject.  mddev->kobj.sd
> is NULL until kobject_add() creates the directory, and stays set for the
> rest of the mddev's life: commit ca39f7502425 ("md: fix mddev->kobj
> lifetime") dropped the explicit kobject_del() and lets the final put do
> the removal.  md.c already tests mddev->kobj.sd for "is this array
> published yet" in mddev_unlock() and md_run().
> 
> This cannot deadlock against add_disk() itself: device_add_disk() only
> opens the disk to scan partitions when get_capacity(disk) is non-zero,
> and md_alloc() does not set the capacity - md_run() does, long after.
> 
> Fixes: ca39f7502425 ("md: fix mddev->kobj lifetime")
> Reported-by: syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=95eeb4ada2349a2170ea
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

This makes sense to me, thanks.

Reviewed by: Logan Gunthorpe <logang@deltatee.com>

Logan
