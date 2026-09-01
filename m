Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BF6476071;
	Tue,  1 Sep 2026 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253629; cv=none; b=Wx71FIFz5O/mVY1Xhi4vDMPY670jIXsn/SIVyrUMpoDNH6f56EIm9fgjq1nDWgcAuQev0y+qrTYgUpic+GIjsFVocxxsS9YmFnl70NAlqQuSxqItj2kpDLMpBpoaHZTMSetQKM7wjmimaD4sqnim9v0MP8UqkoQYLQ1ffTHssLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253629; c=relaxed/simple;
	bh=PH+z7x/8j/MbwrToMZEUmvlyOqBTpNPjslwEPmDA0U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L977RFTH8kPzaGpzTYhr3UTdLJF1fbnh3ESCOORQ13AW59L/f8sQKMf5/EhMEdq1tJhbnvoZPimr2jXR24ZMB5WJb9qKG4nR/x6IeooD9OAdL1f/nHvp57iAArQAs12DtrKtQxdAVTVBi19HA3JA0EV6bUNKZhHITlfOhtGYeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLv9z5Oz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLv9z5Oz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE701F000E9;
	Tue,  1 Sep 2026 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253625;
	bh=m/wEGTF4f7C70SB4/q9aIKOMg+2fN6lt/IMX6OVr2GE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZLv9z5OzoD0fx0iYaQYmDawsSdPZZbIEG6BC3Nio+WgHgZj2R8fnHzPnvWo4SiKZY
	 /Of7JDUDx8RQZgRNlPu0NMl+oU0rov2ViyfmzazCwUqbQpeZo69AS03Xjy9Nemwvue
	 1yd5pahrTxqSacJKWqYwwBEhvHuyLxN4szUq6g1IGkgOBQQ2rRzpZlMNZqSA3pMN7y
	 9oKHA4EG0gWAE+gdrMw9AHbwa86VqFfe4W3IbtjZzYeugQGBgYYg7s5d8PTa6YVPqS
	 ghMwkdjf4ELQY+uSeA09R38BT4sRW+FX7EN5XYlSdHAo2SkFeBA2pRMj6C8CVEc4vT
	 L1yofrhBrittQ==
Message-ID: <2e433e8d-a71e-49e4-8dea-659a94c8143f@kernel.org>
Date: Tue, 1 Sep 2026 11:07:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and
 VM_BIND
To: Dave Airlie <airlied@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
Cc: David Airlie <airlied@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yuhao Jiang <danisjiang@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com>
 <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
 <CAMwc25qozGSRw8KKNzVhakH1jCNWsFS_z=mFn9hswxjdNNX0GA@mail.gmail.com>
 <55965C34-9026-4EE7-B2F0-1D5D9807D682@outlook.com>
 <CAPM=9txG6wEwx_L5RsB+3gEuT6dYJQvrPpQnHHF4V1gFZpWNFQ@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAPM=9txG6wEwx_L5RsB+3gEuT6dYJQvrPpQnHHF4V1gFZpWNFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 6:05 AM, Dave Airlie wrote:
> On Tue, 11 Aug 2026 at 14:00, Junrui Luo <moonafterrain@outlook.com> wrote:
>>
>> On Mon, Aug 10, 2026 at 08:43:50AM +1000, David Airlie wrote:
>>> Have you run a complete Vulkan CTS with NVK across this with no regressions?
>>>
>>> I'm weary of those limits being too low, but I think the only app that
>>> might push them beyond CTS would be Forza Horizon 5 or 6.
>>
>> No, I have not. I don't currently have the hardware to run NVK, so I can't
>> offer a CTS run or any other regression test for this.
>>
>> Is there a better guard that avoids a hard limit here, or does this need
>> a test before it can go in?
> 
> Looking at xe it also has 1024 limit on number of syncs, but it
> doesn't have any limit on number of binds,
> 
>                 *bind_ops = kvmalloc_objs(struct drm_xe_vm_bind_op,
>                                           args->num_binds,
>                                           GFP_KERNEL | __GFP_ACCOUNT |
> __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
> 
> Maybe nouveau could do the same.
SGTM, I'd also be hesitant to put a hard limit on VM_BIND.

@Junrui: Can you please resend?
