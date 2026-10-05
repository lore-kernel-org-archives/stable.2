Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497712E1EE0
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219753; cv=none; b=Kdkg3y+TYjqaorAGB17X9+TnmNHFfqIKbpftf591yOaxTy+cRSeGH4JXIq400ueAEq16kSgbFmHxckm4DBBUvvsAy2F99KZKTny9/nWbORBtiM202Zf/fuYHxjolzbG8fzj4dOOi0Qwz4uRwuNB+3TjuJkpskABad4Vao3sWOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219753; c=relaxed/simple;
	bh=Fbzv8yDM0VkFzJyVWmyQ4yf3QgaTqALVYscqe7fJ0zA=;
	h=Subject:Message-Id:References:In-Reply-To:To:Cc:Mime-Version:
	 Content-Type:From:Date; b=F1WeUs8FJ2Fi39V5v2f55NWFKlITidJRMHUacQZDVT+aMtBT3oeAM7fcIIpeNplnYbssOF0jfTas2Y4N2TEtjlqVT2MXzRSRHNF9+09QLhmG8MoAlUJzNK5iUI9WEKFjrLcdLuVlz0V91iXX247ykkxWYn+BaCPO7n8co2FHJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=lI0sZV5r; arc=none smtp.client-ip=209.127.231.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="lI0sZV5r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1791219740;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=X4Gvcf+R5aAfrJIPwztiC9I1x6Y02SwTPFLotN7X9mI=;
 b=lI0sZV5rx2953+OuAqKN1eFTaSZE8fCihyzU9Pg1TH8IPZzeAIxDd7pvys0hQkjXVmqcf7
 Ndaw21CYgkeIL4P7uFD/V+Iyp37FJwk5+QInMcQqZiGJq9JcE0ZCNjdsB6wJPIsl58DOqA
 DIM3R24ihie0SU/ZKOMnl30aLwE97aENNqcKl1CvTeF61a2kt3cecCJB2WoaZ4YbK78PNX
 sZKZgs6+dvtSHuQXwfSDGM69DG4cRW2jVFCT2VzpTwBxByZbXqZWdXJbX83WXAwNIwIyB6
 mRcKhjzQXnoiNpJgi+AXD0K1K8pleKnwOV1tyzLlZl6akOK37Lrk8MGtAQU08Q==
Subject: Re: [PATCH] md/raid5: set conf->mddev before the first setup_conf() error path
Message-Id: <4dd02c5d-a1c5-463d-a678-b06c7f9d2f45@fygo.io>
Received: from [192.168.1.104] ([39.182.0.177]) by smtp.larksuite.com with ESMTPS; Mon, 05 Oct 2026 17:02:19 +0000
References: <20261004060203.1379-1-yogeshgaur.83@gmail.com>
In-Reply-To: <20261004060203.1379-1-yogeshgaur.83@gmail.com>
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fygo.io
To: "Yogesh Gaur" <yogeshgaur.83@gmail.com>, "Song Liu" <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Li Nan" <magiclinan@didiglobal.com>, "Xiao Ni" <xiao@kernel.org>, 
	"Christoph Hellwig" <hch@lst.de>, "Hannes Reinecke" <hare@suse.de>, 
	"Logan Gunthorpe" <logang@deltatee.com>, 
	<syzbot+270624bb31d478afe62e@syzkaller.appspotmail.com>, 
	<stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26ac3d81b+b33c75+vger.kernel.org+yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Date: Tue, 6 Oct 2026 01:02:15 +0800
X-Original-From: yu kuai <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2026/10/4 14:02, Yogesh Gaur =E5=86=99=E9=81=93:
> free_conf() starts with log_exit(), which falls through to
> raid5_has_ppl() when conf->log is NULL:
>
> 	static inline void log_exit(struct r5conf *conf)
> 	{
> 		if (conf->log)
> 			r5l_exit_log(conf);
> 		else if (raid5_has_ppl(conf))
> 			ppl_exit_log(conf);
> 	}
>
> raid5_has_ppl() reads conf->mddev->flags. setup_conf() only assigns
> conf->mddev after bioset_init(), but five of its error paths -- the
> pending_data, alloc_thread_groups(), conf->disks, extra_page and
> bioset_init() failures -- jump to "abort:" before that, and abort: calls
> free_conf(). conf comes from kzalloc, so conf->mddev is still NULL and
> free_conf() dereferences it:
>
> 	BUG: KASAN: null-ptr-deref in raid5_has_ppl drivers/md/raid5-log.h:54 [i=
nline]
> 	BUG: KASAN: null-ptr-deref in log_exit drivers/md/raid5-log.h:128 [inlin=
e]
> 	BUG: KASAN: null-ptr-deref in free_conf+0x81/0x5d0 drivers/md/raid5.c:75=
49
> 	Read of size 8 at addr 0000000000000028 by task syz.3.20/5681
> 	Call Trace:
> 	 <TASK>
> 	 free_conf+0x81/0x5d0 drivers/md/raid5.c:7549
> 	 setup_conf+0x1720/0x2ad0 drivers/md/raid5.c:7885
> 	 raid5_run+0x8cc/0x2560 drivers/md/raid5.c:8129
> 	 md_run+0xc3d/0x1cd0 drivers/md/md.c:6779
> 	 do_md_run+0x35/0x720 drivers/md/md.c:6880
> 	 array_state_store+0x958/0xe90 drivers/md/md.c:-1
> 	 </TASK>
>
> The faulting address is offsetof(struct mddev, flags).
>
> conf->mddev is a back pointer that is constant for the lifetime of the
> conf and does not depend on anything computed in between, so assign it
> as soon as the conf is allocated. Nothing between the allocation and the
> old assignment reads conf->mddev -- alloc_thread_groups() takes the conf
> but never looks at its mddev, and the rdev_for_each() loop walks the
> mddev argument directly.
>
> All five paths are allocation failures, so this needs memory pressure or
> fault injection to hit, which is how syzbot found it.
>
> Reported-by: syzbot+270624bb31d478afe62e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D270624bb31d478afe62e
> Fixes: ff875738edd4 ("raid5: separate header for log functions")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
> ---
>   drivers/md/raid5.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index b91545ce090d..f98d3bdd3484 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7675,6 +7675,9 @@ static struct r5conf *setup_conf(struct mddev *mdde=
v)
>   	if (conf =3D=3D NULL)
>   		goto abort;
>  =20
> +	/* free_conf() dereferences this, so set it before the first goto */
> +	conf->mddev =3D mddev;
> +
>   #if PAGE_SIZE !=3D DEFAULT_STRIPE_SIZE
>   	conf->stripe_size =3D DEFAULT_STRIPE_SIZE;
>   	conf->stripe_shift =3D ilog2(DEFAULT_STRIPE_SIZE) - 9;
> @@ -7743,7 +7746,6 @@ static struct r5conf *setup_conf(struct mddev *mdde=
v)
>   	ret =3D bioset_init(&conf->bio_split, BIO_POOL_SIZE, 0, 0);
>   	if (ret)
>   		goto abort;
> -	conf->mddev =3D mddev;
>  =20
>   	ret =3D -ENOMEM;
>   	conf->stripe_hashtbl =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

The same patch is already applied.

https://patch.msgid.link/20260915081731.122933-1-chengzhihao1@huawei.com

--=20
Thanks,
Kuai
