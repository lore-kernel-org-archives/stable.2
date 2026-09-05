Received: from va-2-54.ptr.blmpb.com (va-2-54.ptr.blmpb.com [209.127.231.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E8353ED9
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788575719; cv=none; b=SXCK1q+wAYsz2qrWZeQWTQYcDdb4IsI1UPaCWlSuffX4b/2TxkfgXU8NOEGZQu4943A4GzsNPjQ3lGeytXNNTQkKCE9c/kKWTrqJ/bJ1luztch8ZVAAWWJTi9s0Yw416TOxr/ObEuTBCxe4eE25M4wLS55VMqc0wO+UNSFwtLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788575719; c=relaxed/simple;
	bh=CBXNwm9vesu0knmhlW205s6GjNq/H0HmefUw+ip7AWk=;
	h=In-Reply-To:Subject:Date:Content-Type:To:Cc:References:Message-Id:
	 Mime-Version:From; b=MO8u2stYisSN7z7R7tD81wJRlTL4f0keZbGKoVUs1tR5IAFbx+JYrX55cgTS+LjpbtIST4xpPSFlM2cGudwxs1S3GNcTLxS/bQXWXMcUqLtZMMvhxX2QjBxom6xz7ofleNzj444vV40yrvmzxrSPzBvJcH8CdBCxplxWn9SaCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=mXKjQ7aN; arc=none smtp.client-ip=209.127.231.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="mXKjQ7aN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1788575705;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ZAe8AZ99IGJFH5/GQCEbo629wM2EP3I3IIgi4uALfdk=;
 b=mXKjQ7aNQI56mDXc6u0vye4o0C6Zvf6Qe+lr8ADkBwWCJ/L78teENQugVCZ9t0/A5ZnEVn
 WroBDpsarFL4Q+aiLP1Y+SUCJTM27+VcXYpQFDuGWbkxwmmzF82r8O38OgBuoZnD6TsJGf
 mkL5jXjH/CMauiAKeitheK9TN5fy2a3O0a61zD/2c4W3Z5+klwChPBnb7ybbB55RGlcxJL
 NfyvE24vIs/zDXt/rIwuu0BVDj9uxlsmg73eF8XZtnRdjmvn4qczoAxOBmvckVKurL4h2f
 5DyELrNuGz+W6Fksrh6pIMqHZ1FHJStG1nxSR6j0qiNBCtvBPiBcW4Fe6kxgmw==
X-Original-From: yu kuai <yukuai@fygo.io>
In-Reply-To: <20260827080341.112296-1-ghuicao@163.com>
Subject: Re: [PATCH v4 1/2] md/raid5: track disks array size to fix extra_page leak on error paths
Date: Sat, 5 Sep 2026 10:34:59 +0800
Received: from [192.168.1.104] ([39.182.0.178]) by smtp.larksuite.com with ESMTPS; Sat, 05 Sep 2026 02:35:03 +0000
Content-Type: text/plain; charset=UTF-8
To: <ghuicao@163.com>, "Song Liu" <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Cc: "Li Nan" <magiclinan@didiglobal.com>, "Xiao Ni" <xiao@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Cao Guanghui" <caoguanghui@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
References: <20260827063235.85375-1-ghuicao@163.com> <20260827080341.112296-1-ghuicao@163.com>
Reply-To: yukuai@fygo.io
Message-Id: <28837a31-ccbe-4add-951e-9e09bf06eadf@fygo.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "yu kuai" <yukuai@fygo.io>
X-Lms-Return-Path: <lba+26a9b7fd8+a3f002+vger.kernel.org+yukuai@fygo.io>

=E5=9C=A8 2026/8/27 16:03, ghuicao@163.com =E5=86=99=E9=81=93:

> From: Cao Guanghui<caoguanghui@kylinos.cn>
>
> free_conf() iterates conf->pool_size entries to free extra_page
> allocations, but pool_size may not reflect the actual size of the
> conf->disks array.  Two scenarios cause a mismatch:
>
> 1. setup_conf() early abort: pool_size is 0 (not yet set by
>     grow_stripes) but conf->disks has max_disks entries with
>     extra_page allocated.  The loop iterates 0 times, leaking all
>     pages.
>
> 2. resize_stripes() Step 4 failure: conf->disks was replaced with
>     a newsize-entry array in Step 3, but pool_size is only updated
>     on success.  The loop iterates pool_size (old, smaller value)
>     times, leaking (newsize - pool_size) pages.
>
> Add a dedicated disks_cnt field to track the actual number of
> entries in conf->disks.  Set it immediately after each allocation
> or replacement (in setup_conf and resize_stripes Step 3, where the
> array is safely stalled with no concurrent access), and use it in
> free_conf() instead of pool_size.
>
> This leaves pool_size untouched, preserving the check_reshape()
> retry behavior that depends on pool_size only being updated on
> full success.
>
> Fixes: d7bd398e97f2 ("md/r5cache: handle alloc_page failure")
> Cc:stable@vger.kernel.org
> Signed-off-by: Cao Guanghui<caoguanghui@kylinos.cn>
> ---
>   drivers/md/raid5.c | 4 +++-
>   drivers/md/raid5.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
Applied v4 to md-7.3.

--=20
Thanks,
Kuai
