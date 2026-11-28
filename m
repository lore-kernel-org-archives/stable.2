Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795856126;
	b=j9PJNR6PAvpQOVQ0dnp+jKUrwBQlRtd/yoTxIXl5aimz6wkBbhAbZ9Jd5p5mmKVLn5pm
	 fB5a+umlreKv7rTvxWUCggqPf1ITQ4mNk+Bv7AW53vGyaMkdN3gz3/JWZzqBa0irzU8aS
	 0vUkzv1QthKozayFQz6R0DD4+jyOtuh89aaAWHLype1B2yAd/wwUieMQPmSXBmcvNDfJH
	 uSvEW0mrnQcKWJnDi5g1seEqPiTVqSmVyESqvyuuB9nUE4KZn/LBXkFZ1XiAdp+uLIX/V
	 CTx/NSgh59wNJ3b7Fq0/ONAvEpXsjkjUrZj8AqCTX680vPzamKtbV/Wz77gJzEr1u0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795856126;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pT/Ty5tDobukfZnRUpr1Lr4sCBOaNehiDx5qlqzSLeI=;
	b=QirWoE0lPzw9/kWtzfU+XeN5RbaOmHtT4FKeaCktLAOkCYLvEQGDaggB8F0tll4RAcqn
	 VwsTYgWckJw9Vp57hlO4s5r1YrnZsMdLq36nRwubh5d/Cdcgl1GAPlmNbvWJAP+Sbt/+o
	 /ITYf80oL/Cyo0Gou7KnIdGqUM0uJoBN7W1CluKqpU8nBOuk30HTxfKUc2wDVp2JnbAAG
	 v9UU3S+JI9h1ggAS147QQVeamcmnLjU4Ua+2Fi9kXWG5+LXOpnv3JmB+NVRX54vh9kEzU
	 4hSQQMNrQ5lkn7xW6t9t3p7MZ24BKTZydrYbsTFmWAwuqpNwUO4QABTynBaKT1H5U7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a82/5EW2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF011606A321;
	Sat, 28 Nov 2026 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a82/5EW2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A991F00898;
	Sat, 28 Nov 2026 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795856126;
	bh=pT/Ty5tDobukfZnRUpr1Lr4sCBOaNehiDx5qlqzSLeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a82/5EW2OfNfsbisNQy+guLQbVhsz1qVvMs9F/Ys2r1NWSxIjxVbgPNIiLIyTxawm
	 63d26N+kWSNTDaBQegZGajx2fig+KoU4kZ6MJFXA8xTGp5jZQuqLJcVzWeUN6NMd68
	 gJEgbBgVvqFDeLfePo5ijOI5qMds/3InSMZ2LRJ8xdXF8u4ktAUYNxB/odGZzEjJIX
	 VPKS/iasFIp+DR9UFQif07K/JL7CsGKiY4SS5NZSFz2WIJgqSgI3sGfEex1In37MPf
	 IDTTVTRJQB7nCush8kTC4mSsgfF5xkIEtZ8BzlkdzXW0eZYIpMO2XvMT+Qab2tjfUv
	 Uz67ViBQU+w5g==
Message-ID: <0d77ebaa-fba4-4047-a43a-18b3c1ae242b@kernel.org>
Date: Sat, 28 Nov 2026 08:55:20 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: venus: use dma_iova_size() to check the
 reserved IOVA size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Honglei Huang
 <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
 Alex Williamson <alex@shazbot.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>
 <20261127115849.2780625-2-m.szyprowski@samsung.com>
 <nohVXMHveO5nQuD8sOn0QoENkIUC-GQzMCh8HTX6v2eezbtW6OM5gX5JwJ7_MSwfWj3bC4Zmfz1CrxTDKJeFGg==@protonmail.internalid>
 <20261127142912.GK114472@nvidia.com>
 <dcc8689e-41bc-4a18-87fc-2fa76e11eab1@kernel.org>
 <1MLPCyQ6FzkBIjdEja1y1xlc1P6WofGan08C2FN5E6caYBo9uKTCVFZXVujGWTLFgNm4nIXZGke0kdpRd8Z_BA==@protonmail.internalid>
 <20261127172626.GQ114472@nvidia.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261127172626.GQ114472@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2026 17:26, Jason Gunthorpe wrote:
>> It would be possible to reserve this IOVA range in DT so given what you've
>> highlighted I think this and the Iris commit should be reverted and the DT
>> constraint implemented.
> That was the other thread, obviously using DT to describe a hardware
> issue is the correct choice. But there was some problem where they
> also wanted to split the SID space using DT and then the DT mechansim
> doesn't work because the whole thing becomes too hacky :\
> 
> Jason

Actually I've been looking for some resolution on this.

https://lore.kernel.org/linux-media/d0e76f09-a360-4c1d-bfab-c5658f2a69e0@kernel.org

There's been radio silence on the method from the iommu maintainers so I 
haven't merged the DT that would come to depend on it.

If its mergable with changes then grand, if not then the approach needs 
to be rolled back.

Either way several series in limbo and now this rollback.

I would like to do the right thing _once_ to resolve.

---
bod
