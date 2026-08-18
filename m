Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D323D7F0;
	Tue, 18 Aug 2026 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028450; cv=none; b=uToQrKjgzV40SkeEtdsd2rmcteqEGzuUfbMA2MlZ+L3rG/lEF+Lv2sg9loC4pDd2CXqUXMvDBgttvBpg7JNqrYfGp6mJPOHO7nF25EgGYBoaQQg2Fo9g/OUHweqIcvnlsaAd5uPJxhFSP+NbIJ+TMJo1nucqgJFuhAWnn1HZqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028450; c=relaxed/simple;
	bh=CwHyacFbu+Kyy9CF4ozacw335KBNHHWjFpPwFMPtdr4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Pdr8hMs8IEObR0zFJSAlqAJRmH2tLwU2vo4SSWvxO786YfVJHSfqrG8UVQDRVGDOfPGivIBM0k3SIMCMjEhK7YQFkhG/sxSv6yufBwNRUxBjr3ZBJLOtJN7a77dVopLu/IOElpS1wDhtDC8LCZQhF3unQw7kXsgOLsIhNmrF2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bZrjObYt; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bZrjObYt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fKK3qATimt/wdTrHhSiowrHjAlFSvKzysC+KCiLE/Z0=;
	b=bZrjObYta2T0FDnulsERsW1si+rQd/pk7mkgsfzu0o8uM6TCCfNlHvLadtSs5VmiXdPetltEh
	Bz/iRH4Kjd/HhIUElGccZwIj3BVw5hQvo4VeZK/Smfs+nrL8eY4bRDjceTmFN3R0BA1Ne/4WuEd
	nsylu8DfVrU+CoaZ0ZCimIY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hPH3H4876zRhR0;
	Tue, 18 Aug 2026 12:36:43 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EC7640575;
	Tue, 18 Aug 2026 12:47:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 12:47:21 +0800
Subject: Re: [PATCH v6.12.y 2/2] ubi: fastmap: fix ubi->fm memory leak
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	<stable@vger.kernel.org>
CC: Richard Weinberger <richard@nod.at>, Miquel Raynal
	<miquel.raynal@bootlin.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Liyuan Pang <pangliyuan1@huawei.com>
References: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
 <20260818-ubi-backports-v1-2-324d6816d2ae@atmark-techno.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <819387b2-0fb8-4cb7-5645-181619eb6fc3@huawei.com>
Date: Tue, 18 Aug 2026 12:47:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260818-ubi-backports-v1-2-324d6816d2ae@atmark-techno.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/8/18 10:09, Dominique Martinet 写道:
> From: Liyuan Pang <pangliyuan1@huawei.com>
> 
> The problem is that scan_fast() allocate memory for ubi->fm
> and ubi->fm->e[x], but if the following attach process fails
> in ubi_wl_init or ubi_read_volume_table, the whole attach
> process will fail without executing ubi_wl_close to free the
> memory under ubi->fm.
> 
> Fix this by add a new ubi_free_fastmap function in fastmap.c
> to free the memory allocated for fm.
> 
> If SLUB_DEBUG and KUNIT are enabled, the following warning messages
> will show:
> ubi0: detaching mtd0
> ubi0: mtd0 is detached
> ubi0: default fastmap pool size: 200
> ubi0: default fastmap WL pool size: 100
> ubi0: attaching mtd0
> ubi0: attached by fastmap
> ubi0: fastmap pool size: 200
> ubi0: fastmap WL pool size: 100
> ubi0 error: ubi_wl_init [ubi]: no enough physical eraseblocks (4, need 203)
> ubi0 error: ubi_attach_mtd_dev [ubi]: failed to attach mtd0, error -28
> UBI error: cannot attach mtd0
> =================================================================
> BUG ubi_wl_entry_slab (Tainted: G    B      O L   ): Objects remaining in ubi_wl_entry_slab on __kmem_cache_shutdown()
> -----------------------------------------------------------------------------
> 
> Slab 0xffff2fd23a40cd00 objects=22 used=1 fp=0xffff2fd1d0334fd8 flags=0x883fffc010200(slab|head|section=34|node=0|zone=1|lastcpupid=0x7fff)
> CPU: 0 PID: 5884 Comm: insmod Tainted: G    B      O L    5.10.0 #1
> Hardware name: LS1043A RDB Board (DT)
> Call trace:
>   dump_backtrace+0x0/0x198
>   show_stack+0x18/0x28
>   dump_stack+0xe8/0x15c
>   slab_err+0x94/0xc0
>   __kmem_cache_shutdown+0x1fc/0x39c
>   kmem_cache_destroy+0x48/0x138
>   ubi_init+0x1d4/0xf34 [ubi]
>   do_one_initcall+0xb4/0x24c
>   do_init_module+0x4c/0x1dc
>   load_module+0x212c/0x2260
>   __se_sys_finit_module+0xb4/0xd8
>   __arm64_sys_finit_module+0x18/0x28
>   el0_svc_common.constprop.0+0x78/0x1a0
>   do_el0_svc+0x78/0x90
>   el0_svc+0x20/0x38
>   el0_sync_handler+0xf0/0x140
>   normal+0x3d8/0x400
> Object 0xffff2fd1d0334e68 @offset=3688
> Allocated in ubi_scan_fastmap+0xf04/0xf40 [ubi] age=80 cpu=0 pid=5884
> 	__slab_alloc.isra.21+0x6c/0xb4
> 	kmem_cache_alloc+0x1e4/0x80c
> 	ubi_scan_fastmap+0xf04/0xf40 [ubi]
> 	ubi_attach+0x1f0/0x3a8 [ubi]
> 	ubi_attach_mtd_dev+0x810/0xbc8 [ubi]
> 	ubi_init+0x238/0xf34 [ubi]
> 	do_one_initcall+0xb4/0x24c
> 	do_init_module+0x4c/0x1dc
> 	load_module+0x212c/0x2260
> 	__se_sys_finit_module+0xb4/0xd8
> 	__arm64_sys_finit_module+0x18/0x28
> 	el0_svc_common.constprop.0+0x78/0x1a0
> 	do_el0_svc+0x78/0x90
> 	el0_svc+0x20/0x38
> 	el0_sync_handler+0xf0/0x140
> 	normal+0x3d8/0x400
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220744
> 
> Signed-off-by: Liyuan Pang <pangliyuan1@huawei.com>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> (cherry picked from commit d133e30aabc7c8eb8206827f8fbe0f3679adb911)
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> ---
>   drivers/mtd/ubi/attach.c     |  4 +++-
>   drivers/mtd/ubi/fastmap-wl.c |  8 +-------
>   drivers/mtd/ubi/ubi.h        | 12 ++++++++++++
>   3 files changed, 16 insertions(+), 8 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
> index adc47b87b38a..884171871d0e 100644
> --- a/drivers/mtd/ubi/attach.c
> +++ b/drivers/mtd/ubi/attach.c
> @@ -1600,7 +1600,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
>   
>   	err = ubi_read_volume_table(ubi, ai);
>   	if (err)
> -		goto out_ai;
> +		goto out_fm;
>   
>   	err = ubi_wl_init(ubi, ai);
>   	if (err)
> @@ -1642,6 +1642,8 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
>   out_vtbl:
>   	ubi_free_all_volumes(ubi);
>   	vfree(ubi->vtbl);
> +out_fm:
> +	ubi_free_fastmap(ubi);
>   out_ai:
>   	destroy_ai(ai);
>   	return err;
> diff --git a/drivers/mtd/ubi/fastmap-wl.c b/drivers/mtd/ubi/fastmap-wl.c
> index 9bdb6525f128..e2bc1122bfd3 100644
> --- a/drivers/mtd/ubi/fastmap-wl.c
> +++ b/drivers/mtd/ubi/fastmap-wl.c
> @@ -530,8 +530,6 @@ int ubi_is_erase_work(struct ubi_work *wrk)
>   
>   static void ubi_fastmap_close(struct ubi_device *ubi)
>   {
> -	int i;
> -
>   	return_unused_pool_pebs(ubi, &ubi->fm_pool);
>   	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
>   
> @@ -540,11 +538,7 @@ static void ubi_fastmap_close(struct ubi_device *ubi)
>   		ubi->fm_anchor = NULL;
>   	}
>   
> -	if (ubi->fm) {
> -		for (i = 0; i < ubi->fm->used_blocks; i++)
> -			kfree(ubi->fm->e[i]);
> -	}
> -	kfree(ubi->fm);
> +	ubi_free_fastmap(ubi);
>   }
>   
>   /**
> diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
> index 1c9e874e8ede..450a7b9a5bd7 100644
> --- a/drivers/mtd/ubi/ubi.h
> +++ b/drivers/mtd/ubi/ubi.h
> @@ -970,10 +970,22 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
>   		     struct ubi_attach_info *scan_ai);
>   int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count);
>   void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol);
> +static inline void ubi_free_fastmap(struct ubi_device *ubi)
> +{
> +	if (ubi->fm) {
> +		int i;
> +
> +		for (i = 0; i < ubi->fm->used_blocks; i++)
> +			kmem_cache_free(ubi_wl_entry_slab, ubi->fm->e[i]);
> +		kfree(ubi->fm);
> +		ubi->fm = NULL;
> +	}
> +}
>   #else
>   static inline int ubi_update_fastmap(struct ubi_device *ubi) { return 0; }
>   static inline int ubi_fastmap_init_checkmap(struct ubi_volume *vol, int leb_count) { return 0; }
>   static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
> +static inline void ubi_free_fastmap(struct ubi_device *ubi) { }
>   #endif
>   
>   /* block.c */
> 

