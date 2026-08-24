Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394E25B099;
	Mon, 24 Aug 2026 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787533070; cv=none; b=NNfQvYhY5dQsvZ76NAS/i5J2NGJBQNXImquo/qlJgfuuDdkS5Xehq10Mt2Xn7wRH8MvRBDz2VdaShyPZHuOauy/sorD1oMMY2eY2ijj7JrJVw8AdnREIpzYQ4nVH95crk/+Ge7zbDosrjzqXO7TkR7+G6rfQ1XbK3+l05J98Pmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787533070; c=relaxed/simple;
	bh=ZpO/+clBgbyZIhZucYi7sQRaqwpub2ZTVJ/+FdV1dps=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hEAD0Yi8IPgPj5RgiOxQcyTh2zkKaXJ+8ODJHQBXC4FZ2jz68DOJOq6qwmgrMY0sOR0bOnyDZbQHsPvRMXVZiEc8FJBz5iOgx0Zhv/mzwFVbh230THkutsUGlt3ImumbleSCyphRzqrgLn6cvZAvViv39szGFtStsXuN592E2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx0s+QsX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx0s+QsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40E01F000E9;
	Mon, 24 Aug 2026 00:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787533068;
	bh=hDlgbjhSR4ai6RtZNkwjoZhpTUzRuGdgR34nn3zo+7Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=Rx0s+QsXwKJTFdh0Ne/Cim3ZdgLMn3myynXUE1Hdt5KYQfr//5Qpo0wxy/2x58lnc
	 cz6Qz3PIV3xD4m3afEvVpyvSZQ5RdTXygP9jsy/6BQHLr5zPUCry6d1UrBcQJkVUS0
	 NB/LMqukgV1hqfwOOl6rNEBphrnQSp580QAFxBkPhG7d0qWA9h2QV+2L/mfuE+HtwY
	 rm81XHhf6LHtg0EVJ3SPnUdGdK5KALkH23mLAYHHkWgtK8NE6AWQpk/wRRaLk+9ujL
	 N2mMuZ3UKOANwTyRLY6eDXodykkJgzjZnA3H6tCs6gm58JbOFwzCTW0YtKtjfjZW6L
	 pW0MeDbOhNqXQ==
Message-ID: <39e2934d-7155-4a55-bd55-3006308b810c@kernel.org>
Date: Mon, 24 Aug 2026 08:57:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, hongbohbli@tencent.com, guochunhai@vivo.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] erofs: skip sufficiently large global buffers when
 resizing
To: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>, xiang@kernel.org
References: <20260822140017.8119-1-nikhilgurudasani314@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260822140017.8119-1-nikhilgurudasani314@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/26 22:00, Nikhil Gurudasani wrote:
> z_erofs_gbuf_nrpages is advanced only after every global buffer has been
> grown. If a resize fails after some buffers were enlarged, a retry
> revisits those enlarged buffers.
> 
> Retrying the same size then returns -ENOMEM because alloc_pages_bulk()
> has no pages to add and the unchanged return value is treated as a
> failure. Retrying an intermediate size allocates a temporary pointer
> array smaller than gbuf->nrpages and copies more existing pointers than
> the array can hold.
> 
> Skip buffers that already satisfy the request. Once all remaining
> buffers have caught up, advancing z_erofs_gbuf_nrpages again describes
> the guaranteed minimum size across the pool.
> 
> Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
