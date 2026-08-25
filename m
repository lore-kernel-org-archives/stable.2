Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88317BB21;
	Tue, 25 Aug 2026 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624215; cv=none; b=ONQ53u7/FYhJ5L3a1VsrXeC27Eo8+cbW+aAiyJpEqujwOFvz3/Azfa14pMpzcZ1FeSfMYkWTeg4V8kZgV/xa+bayUSO0zpYgubI6kXLUI7J2yZu9ZUjThzgVhKV7Ft5NWFAaqhXM8HJxj8o42ouiNZ3UqiWoRtC1OjLUj0W4zfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624215; c=relaxed/simple;
	bh=3QrODI0OhU0tUc7wY4FA8Ex+UsljceAaL4lf8or1/Bo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QU8F431SnKIBGVSGd70It9QGf47lPflMSc4U4RvtqjJtR63yKP/GZ5qB60fyywgDu9E9u1bwEVzAY2tVwOXVeNB7jHmsKZTOb8aNsqAKOxxCbMx4IsDxi/HEMq5S7vmBqYz1AbPE7emRlV95vmJuVm9kPGjeCLm1ivAtInbxe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5vQETZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5vQETZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04321F000E9;
	Tue, 25 Aug 2026 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787624213;
	bh=JaAYopV+smpZ/PTT7dIyy5UDYcqaHAGEoeEaFiVVvcU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=C5vQETZk+dZhFSxK6Z7kMl6dZ1fJT55+sY+lnYbNqX7kouBS8dj02RAX02WiliOvG
	 +jbZQijhIdO7/JB6q//9y1zLgpbOR2uGQuGALnzFZoXW4HVs6oqTWNVmDooWBubCpB
	 wctSKpetc0OEXzhU5Ui8xJ/AegkTX3irggGmLhTtF75hkO2pobe4cFY2NAk7JC7Uyc
	 twAmv3O5Z6RHeMS2ycUvGB8OYxaYQrcyiYCyVFOIxug/ndfPdBhXQlFhBNcYbHjCfv
	 DkfkFS/A7PAfICH6GvbwKXomSMXbJpqfxnHGUQjH41AV4qlWx6mSsujG/bMJLRyTYi
	 nT0TZazqIzyfw==
Message-ID: <73847857-2460-48c6-9bb4-343f043c2b82@kernel.org>
Date: Tue, 25 Aug 2026 10:16:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: accurately adjust free_sections
 during free_segment_range
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260825015303.2082221-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260825015303.2082221-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 09:53, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In free_segment_range(), MAIN_SECS(sbi) is temporarily reduced by `secs`
> to restrict block allocation to the safe remaining main area while valid
> blocks in the truncated range are evacuated by GC.
> 
> However, FREE_I(sbi)->free_sections tracks the total number of free
> sections across the whole filesystem. If any sections within the
> truncated range were already free upon entering free_segment_range(),
> failing to deduct them from free_sections causes the filesystem to
> overestimate available free sections in the active, reduced main area.
> This leads to inconsistent free section accounting during GC data
> migration and can trigger unexpected allocation failures or assertion
> errors when space is tight.
> 
> Fix this by calculating the number of already-free sections in the
> truncated range, deducting them from free_sections upon entering
> free_segment_range(), and restoring them on exit.
> 
> Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
