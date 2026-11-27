Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793080;
	b=o2RgwBcgCtkNcSqyyMb9uU5jYVVJ+Zn95rZ9gMyvscAfMvOeZhG+stZAD3R8DWkmhLy8
	 xDbAAT4lPvMf0B8qO27kaGLfAcP9FW1yQ8CKQzKIwbbqbM/1Jw44hejY4sG+FRkjCtYCU
	 u4g0VVWjl+R34b6R9uYEoXipwDwDxibQOR3dqgVogR9Te/ELeOM1DXUYpiPPBRxjvT8AL
	 gjM+IpWCbmHD0d2/u2HXdDdGI0E3xVUt3NIq/l1qVMurCsc4A0zFiBfmG5x5yjc41yOwu
	 ehC74igNeQuuHmNn03WOrVlKQB7eWq6m7bq+7SE7WNNScK9yoPtBl0xifY3l8QQzMuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793080;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w46lPKdDZuz+yasVArT/wiplTje3J5dokSU77xqqMi4=;
	b=su7BOBExFI0wrpdWNGS0468+dkdm5jEMRff/SjG12duNnmIHC/3fi7bHvFzlqI7J0wEx
	 FP8KPJ/BnoOoCvRv8Bv60zK+isfETJjS3umC+2T/rq+AGSH1ohLyZEtyKCSwIO2pIM/TR
	 s0T1HKHRGVMNSjOXJFR47nqeQjp9G0ZZLe5VXYaY0PIIzTVDKAUYl8ImpjvWcTkBqaTGZ
	 YJYUtiIhK9y8hiuiPA28qFxyn2xPcrunRTIlzW76+Ps9t6nXB3HAEzmm3ZraDyHXQ5mxP
	 x7TMkiOBRq6P8oOe9abHEqahfxxSFfv3oLg8UFFherpnqCtLa6Gm7aKkfUbbWXxy1nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ce/7JmhM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F244606A32F;
	Fri, 27 Nov 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ce/7JmhM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AA41F00936;
	Fri, 27 Nov 2026 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793080;
	bh=w46lPKdDZuz+yasVArT/wiplTje3J5dokSU77xqqMi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ce/7JmhMaWBK3DgK3DD0Ozh3QLSoA9Xvt+KOdMa6gPyAOjhVBUO/9UDY7FWR2ZlG6
	 Qn7g8LeKTavr/tjs7mtAxNNmEjFLZgRtcxvQEFdJCBRXLt5a7v9V+kv2H6cT0V316y
	 +uVrBxhQxfWrJI6qzG6OgT4mqgyFjGQ6WTAur+qJ5fiZUDi+bVwukPoOW0MlfN2JqT
	 GMMkdV/NWdCetVEERBZkPMLUvrA1SWCS7gCevy9LwDiTDCNg1pn/o+xM0dEVlQBJhG
	 FBWarQivAZQCbDNA3DIimJhoJrFYDQTrUp8baWgX0Bs2cHBHp7KUchpIWXAMTajdrR
	 wF0/snaNYH5/Q==
Date: Fri, 27 Nov 2026 17:24:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
	Alex Williamson <alex@shazbot.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] media: venus: use dma_iova_size() to check the
 reserved IOVA size
Message-ID: <20261127152436.GA774860@unreal>
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>
 <20261127115849.2780625-2-m.szyprowski@samsung.com>
 <20261127142912.GK114472@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127142912.GK114472@nvidia.com>

On Fri, Nov 27, 2026 at 10:29:12AM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 27, 2026 at 12:58:45PM +0100, Marek Szyprowski wrote:
> > The IOVA reservation code compares dma_iova_state::__size directly with
> > the requested chunk size. __size is internal to the DMA IOVA API and may
> > carry flags in its upper bits, so use the dma_iova_size() accessor
> > instead.
> 
> WTF is this even doing?
> 
>     Fix this by reserving the 0-600MB range, below the boundary the
>     non-pixel stream cannot address, using dma_iova_try_alloc() so the
>     IOMMU-DMA core never hands that range out to a real DMA mapping. This
>     reserves only IOVA space, it does not allocate any physical memory.
> 
> That isn't what this API is for, and it isn't how it even works! It is
> pure luck that the first call to it happens to take out the lower
> address space.
> 
> We even had a long discussion about this driver and this need in
> another thread and this is the hack job you guys merged?

You should also mention that NONE of the DMA/IOMMU developers or the authors
of that API were CCed when the change was merged.
https://lore.kernel.org/all/20260818-reserve_iova_in_driver-v2-2-5005a1154408@oss.qualcomm.com/

> 
> And it couldn't even use the right APIs??!

And proposed for the stable@ :(

> 
> Jason
