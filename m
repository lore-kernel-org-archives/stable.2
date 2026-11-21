Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795233624;
	b=SacVV1RH6ig367Fv3durdnEWOFuAyQ4IABa85Dh96IpgCVnl3Gobj8jCXC0OLd6Esj7i
	 NUi2X7VuGyeurzAPcr1DCDuWHkg0OsyE1qfwF4+Bdt0vFtJ6FZXam6RxUDKuZHJD/7WYC
	 3HkdLzWEGMrTX7WRjPZPIiyHSyd++SQW7iR0b5CR4FzA43tXJ+oEZC9jYR0yz5yQ2zJYz
	 aEdZvw63B2QMLSpY2O0QchX2XFVnXpi4eVTWAwsE71myakNxt5IGRbHBC+DBYfpRbg9n0
	 8iOd6Hvhl7bAYL9oDtBEYijTR8n5xyGFwOp0JH+NnFH7NNwuCj+ol7d15NUV5V3Y//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795233624;
	h=DMARC-Filter:DKIM-Signature:Reply-To:Cc:From:X-Original-From:
	 X-Lms-Return-Path:Received:Subject:Message-Id:References:Date:
	 Mime-Version:User-Agent:To:Content-Transfer-Encoding:In-Reply-To:
	 Content-Type;
	bh=TD4DOOWtXLG4XrTTuyoATbkrW2K9xh29mQrnzRVMTDs=;
	b=P6nTmbAM15qDoUC7YUnnzef1LDDneu7SrXFYJKFLjx+qyEJQlmO9HXIVMmVuoH4AkI2I
	 wyN1AR0JeJbCkvbui6cngZmxkee/qU5YUX8jX7ou6einQYXDDhb2HsJ6ofZk6Z6btvABj
	 vnubjDxJCAgKcyVPZ4djCCT3mxUdotQwg6auBhfaKQznoBmwjUoFeHPPi1zancm8pqery
	 vMUyVuEWkyX+SkTpnTlanC72UALLvGEuqDRe4g8MUJrrNmxYe4W10lV95+N/cU36zJlsT
	 uJ5cgpdZGBHYZTT3nOqT1pKW+Ew8SRYJc4ev62E8KJZqg1vaV93fXeLanGqPgReWE7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fygo.io;
	spf=pass smtp.mailfrom=fygo.io;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=Y4F+6kEn;
	arc=none smtp.remote-ip=209.127.231.53
Received: from va-2-53.ptr.blmpb.com (va-2-53.ptr.blmpb.com [209.127.231.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFB606A681
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 04:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CEFB606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=Y4F+6kEn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1795233613;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TD4DOOWtXLG4XrTTuyoATbkrW2K9xh29mQrnzRVMTDs=;
 b=Y4F+6kEnXA+q6SWPQd0nkmO/yr3dcRinJviMiuBNwn3N9mjHJXy5oOInTFQM2jkZMT3nV9
 /r2Xkt0RC5Q4uhcMdHz8GnjqzqXONd4p8k8fajmORTffLFcGlFDEl+GgnJrXN8mq+vIq3k
 H0XVXsLdz4G25n+46l7YiKIk0mjyVASeeX9CiHpqofY6RMKf0afZIBKOty5XIa7FQdDExf
 hsc9Uhwer0Zxqa0oXKa3GqBw+r07q4E2TE4Yz62p6g1GNn/kiOmPVavf4PfzyCz0/I/LbZ
 +L6nVBu1TQTveeY6AFzd3FQhNllTfrerur6VmJeVWs0ixxob4aN9yEEVPCPOSw==
Reply-To: yukuai@fygo.io
Cc: <magiclinan@didiglobal.com>, <xiao@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Li Youhong" <liyouhong@kylinos.cn>, <stable@vger.kernel.org>
From: "yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
X-Lms-Return-Path: <lba+26b01174d+504b6f+vger.kernel.org+yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.159]) by smtp.larksuite.com with ESMTPS; Sat, 21 Nov 2026 04:00:12 +0000
Subject: Re: [PATCH v2] md: fix stop_sync_thread() hang on new sync in idle path
Message-Id: <df8d28a5-5455-416e-aa72-ddfe5027f9f7@fygo.io>
References: <20261113010909.30324-1-dayou5941@163.com>
Date: Sat, 21 Nov 2026 12:00:08 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Li Youhong" <dayou5941@163.com>, <song@kernel.org>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261113010909.30324-1-dayou5941@163.com>
Content-Type: text/plain; charset=UTF-8

=E5=9C=A8 2026/11/13 9:09, Li Youhong =E5=86=99=E9=81=93:

> From: Li Youhong<liyouhong@kylinos.cn>
>
> stop_sync_thread() waits for either MD_RECOVERY_RUNNING to be cleared,
> or (when MD_RECOVERY_FROZEN is clear) for mddev->sync_seq to change.
> The sync_seq counter is only incremented when a sync thread is reaped
> in md_reap_sync_thread(), not on the md_start_sync() not_running path.
>
> If the previous sync attempt took the not_running path, sync_seq does
> not advance. If mddev->thread then queues and runs a new sync in the
> window between flush_work() and wait_event(), that new sync may start
> a real sync thread, leaving MD_RECOVERY_RUNNING set while sync_seq is
> still unchanged. md_idle_sync_thread() then waits until that new sync
> thread is reaped and sync_seq finally changes, even though it only
> needs to wait for the current sync attempt to finish.
>
> Fix this by incrementing sync_seq on the not_running path as well, so
> that the wait condition correctly observes the current sync attempt has
> completed.
>
> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> Cc:stable@vger.kernel.org
> Signed-off-by: Li Youhong<liyouhong@kylinos.cn>
> ---
> v2:
> - Fix the Fixes: tag to reference the upstream commit f52f5c71f3d4
>    instead of the stable backport a17d1bca5aba.
> - v1:https://lore.kernel.org/all/20261112092634.1700963-1-dayou5941@163.c=
om/
>
>   drivers/md/md.c | 1 +
>   1 file changed, 1 insertion(+)
Applied

--=20
Thanks,
Kuai
