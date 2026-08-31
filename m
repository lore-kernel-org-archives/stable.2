Received: from va-2-57.ptr.blmpb.com (va-2-57.ptr.blmpb.com [209.127.231.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9243451AA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174054; cv=none; b=CnMdm8SU9PRvXtJwlYeTmceJgtStLgf6DxkYOdZ5ewezlXtWvXVzEMYxvd0m1C/biDfOm1ODQmwVpADjxTjSnRRpsM0fJrteoYMb8ifdYsbFk4wrzYgFphinLWhye/lg3QHWa6J10vULWFjwWl2nSUOL6AFqPfJIqb2wDu3SU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174054; c=relaxed/simple;
	bh=dGQbrBmhQS0x71Wh94RlSbsiKuZn5xVs6SzWfWQuRnE=;
	h=References:Content-Type:From:To:Cc:In-Reply-To:Message-Id:
	 Mime-Version:Subject:Date; b=ZkMhQ9zvlB3PlGbFYq7/nxZezpn+EN7FqgtqEFkl/OSMPAN4s+wvADFDpWOZXvg3mq5AVdCdc34RVkOieK/4ov9t8GNIHB9gYdeQ8nMPWORBZwcKMFjFUrz4ek5RDiIACZNU7KqbnIX7dCEQ4exAf0HUMaRwF2+IBOE/RYWFNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=bTPIQpTN; arc=none smtp.client-ip=209.127.231.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="bTPIQpTN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1788174037;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=oj9pT49fkgayCGX3SEUyRMQPTGIlIhlnZO6FdcY++Ts=;
 b=bTPIQpTNDtnkToWPcIBQfN2zhLMbnW7CzuwXSsZPP+7nJzalRaE+9MbMhXNfsF4F0SJg6O
 RTJsHt/kyT6cygfCpXvQL7+Wx8u/eK0G64B8Qi2h8EX6eyRE+BsR5ecncWEPglg/3a990q
 gsdztIG1T2aL0eJsJemdytKXlWh8Gg/lu0TWLaBXNBsaLykPWt45Qan3pKw6Ld+ooaSXcA
 ynkqc9pUvW+i+939QKzXkxRPTOBUYnNCpWD3jTXtFP44N5z6/ek2o8tayK/4QwJ7RmW1yI
 36IU7ARPImQN0TFVOJ5RAFzIkqpWHcS7N6+KG838JqrfftMEjKzgG1v9Hi7hQg==
X-Lms-Return-Path: <lba+26a955ed5+a79bb9+vger.kernel.org+yukuai@fygo.io>
References: <20260831055716.773354-1-tao1.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
From: "yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
To: "Tao Yu" <tao1.yu@intel.com>, <tj@kernel.org>, <josef@toxicpanda.com>, 
	<axboe@kernel.dk>, "yu kuai" <yukuai@fygo.io>
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	<syzbot+144a1c0e22e53a08ef5a@syzkaller.appspotmail.com>, 
	<stable@vger.kernel.org>
In-Reply-To: <20260831055716.773354-1-tao1.yu@intel.com>
Reply-To: yukuai@fygo.io
Message-Id: <371c8526-c50f-4ca9-a9d0-7bbbd9991d63@fygo.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.178]) by smtp.larksuite.com with ESMTPS; Mon, 31 Aug 2026 11:00:36 +0000
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] blk-cgroup: use GFP_NOIO for radix tree preload in blkg_conf_prep
Date: Mon, 31 Aug 2026 19:00:32 +0800

Hi,

=E5=9C=A8 2026/8/31 13:57, Tao Yu =E5=86=99=E9=81=93:
> blkg_conf_prep() allocates a new blkg with GFP_NOIO after dropping
> queue_lock, but still preloads the radix tree node with GFP_KERNEL while
> q->blkcg_mutex is held.
>
> GFP_KERNEL may enter direct reclaim and acquire fs_reclaim, which adds
> the dependency
>
>    q->blkcg_mutex -> fs_reclaim
>
> This completes a circular locking dependency with the existing path
>
>    fs_reclaim -> q->q_usage_counter -> q->blkcg_mutex
>
> and triggers a lockdep warning when configuring blkcg policies.
>
> Use GFP_NOIO for radix_tree_preload() so that the preload context matches
> the rest of this allocation path and does not recurse into reclaim while
> q->blkcg_mutex is held.
>
> Reported-by: syzbot+144a1c0e22e53a08ef5a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D144a1c0e22e53a08ef5a
> Fixes: f255c19b3ab46 ("blk-cgroup: Pre-allocate tree node on blkg_conf_pr=
ep")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tao Yu <tao1.yu@intel.com>
> ---

This problem is already fixed by following patch, the radix_tree_preload=20
is removed.

[PATCH 1/3] blk-cgroup: use a request_queue rhashtable for blkg lookup -=20
Yu Kuai=20
<https://lore.kernel.org/all/20260823133045.970199-2-yukuai@kernel.org/>

>   block/blk-cgroup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 2b5c29434e426..27e00180e4cc1 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -873,7 +873,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct =
blkcg_policy *pol,
>   			parent =3D blkcg_parent(parent);
>   		}
>  =20
> -		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
> +		/* Drop queue_lock to do new blkg allocation with GFP_NOIO. */
>   		spin_unlock_irq(&q->queue_lock);
>  =20
>   		new_blkg =3D blkg_alloc(pos, disk, GFP_NOIO);
> @@ -882,7 +882,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct =
blkcg_policy *pol,
>   			goto fail_exit;
>   		}
>  =20
> -		if (radix_tree_preload(GFP_KERNEL)) {
> +		if (radix_tree_preload(GFP_NOIO)) {
>   			blkg_free(new_blkg);
>   			ret =3D -ENOMEM;
>   			goto fail_exit;

--=20
Thanks,
Kuai
