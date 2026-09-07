Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFAE3E0C7B;
	Mon,  7 Sep 2026 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747638; cv=none; b=Z4+XMQXcKcm06rNyRL25FD98LHhRttTcPCfraMFvtE7AYnnyENxCQvCkLQ0CUToHKJrvcyOM1rukJblTEbRYQqZXIjFSzw+dIeZZo/XWmtyIwhgNyJCRZB+wfIvNe55mVd2PrM758a9N4mEBp9UY5sI0dSVmouy6fjz7wKHjSFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747638; c=relaxed/simple;
	bh=X7IV/skmANaPTytsl4mXb+50drqcAchlz5L4lYMD+eA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K20cTkogVkK/y1yIrRJUjmEkNZ2FmCn1BuoFWVr9nENMmOKQ8LHpVk7FD8Ka9Zi2cLwyDpqkl3SYjtP+t6tmI+YZAIjH0rW7WZntwApCYAW/ZwhHQBnU0uNjmZGJD0GBfvXGmhIjzH0xC2n/XeieSs++kup8U3aC7G1xdsOX6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnEunOFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnEunOFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190491F00A3A;
	Mon,  7 Sep 2026 02:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788747636;
	bh=7J98PMeNTJ9iq9dARIKAaoUELhEmaK5KBEp2RtaApuc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=AnEunOFYnG8NKHCIxvyuCqEhLMggaMMvcla7zItERhLO4FPNzz2EuApK3MNd9mF/H
	 tPbt44aChCcpTu3Te74a8rbhR+BVK9X8vBqn8lHfL7YLcR3zt60hE/k7eehI4f6ZF0
	 BQJxZC64HyOWHAxkHV0egejx4Z2zQJx8yMR1Ah1H0av/NTh8oiPu1+SwSIGExvAguV
	 gAvOZP7GiUpc6BSn9jeUuvrwZ05mtPgsk1/lfbPXOVwJKRxvp9Iv9sTYCKYjtBRgUH
	 VTVU2Frpm/bvLM4Kx3TMj0NeAHbr94f8UKpo9VApm1dNaw8Mk4yNl34soQAVFYhLyf
	 biOIqDUQfhFbA==
Message-ID: <d2e1b8bd-f575-4f83-a64e-2afef5f1ce2c@kernel.org>
Date: Mon, 7 Sep 2026 02:20:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 stable@vger.kernel.org, Wenjie Qi <qiwenjie@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: enforce alias_filename to match
 device name
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260826181121.3825702-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260826181121.3825702-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/26 18:11, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The kernel expects the device alias file in the root directory to match
> the device basename (strrchr(path, '/') + 1) to identify the target device
> both during mount in f2fs_restore_device_alias() and during reserve in
> f2fs_ioc_reserve_dev_alias().
> 
> If a custom alias filename that differs from the device name is used,
> the kernel fails to match the alias file at mount time (leaving
> FDEV(i).has_alias unset and allowing pinned files to allocate in that
> range) and subsequently fails to reserve the device range when requested.
> 
> Enforce that if an alias filename is specified, it must match the device
> name. Also allow specifying just '-c <device>@' as a shorthand so users
> do not have to redundantly type the device basename twice.

Do we need to add a sanity check in kernel side as well, show warning info
if device name doesn't match device alias file name?

> 
> Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
> Fixes: 8cc4e257ec20 ("mkfs.f2fs: add device aliasing feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
