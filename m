Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42C331EB3;
	Tue,  4 Aug 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817587; cv=none; b=gFnC4QzAM0ibYVyswkTTD1KLuB155DdFP+mrFABaKD1aGMrvrlUzGIfpecc1NCp3ViqYoi8nD7FTF2ucXEJvBFRjuJ0MKkOBV6NQBnBcEJ7Uf3iz6wZmxcZTrtgHXfbv6vwPkSz669u+R1ToONd4VbTumSoUQv1M/uJT4JL56KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817587; c=relaxed/simple;
	bh=NDN5i+21ZiXNRpVcLgM8HNqRRa6JSypSrTNYWNCtqCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5G6zdfyycxBdlgRwH2/5u/27ly6kdUbSDqDsb44QxejiVr2jPnzx1GQSulIn/hJPfk+V4D72n3QMABr5JU+kiDpaq2OT6zd5Kj5cxUWg4ZzYN2h5S/Edq8LSIVMVxZrTc0XesBFordjYAqe91jTiJelhecJrRlLNbKk65B0mYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZTiM29G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZTiM29G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C8B1F000E9;
	Tue,  4 Aug 2026 04:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785817586;
	bh=VnBJBJMIDrb/JKr4D5tBdD125cHurgOHJqMUgwB/roc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oZTiM29GC8RZGnmXsuMCRqhiFleK0rO1lFw0Ij1PxSzm1SUVda3AWZ/CVR8rUh06A
	 YFeN1AGmYjLjZhhIGfXcvhQ8rItKQX6Z1dGepM5x7S/vtxnk1Pdd5qGCerck8VaPgT
	 qSiBcZG8j+omeDjEo+6/bNWMkbxaVTAjKXagCY/dgX3OC4uSOyC0xmGLLRSkJ8g6Cx
	 LX1PnCqCR1QrSSQBtMFfsmaHijL/p40nO2lr7tHDm6NY3TrVAWAgT4J0cCASEQkzi+
	 k0loXjjAK2d88WKoakgz5k9vOD4OBz1m3pPwWXrV3R20rJ+Tn4LJAhaklpamRq1jV+
	 YSLFXcV28LXqQ==
Message-ID: <3a6a55c1-65c1-4fc3-a511-b962b4d29190@kernel.org>
Date: Tue, 4 Aug 2026 13:26:24 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zloop: truncate finished zones to zone capacity
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <78d0627b-e711-4ce2-84ac-6e501898407c@kernel.org>
 <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 11:34, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The size of a sequential zone backing file records the amount of data
> written and is used to restore the zone state. A backing file whose size
> is equal to the zone capacity is restored as a full zone, while a file
> larger than the zone capacity is rejected as invalid.
> 
> However, zloop_finish_zone() currently truncates the backing file to the
> zone size. For devices with a reduced zone capacity, finishing a zone
> therefore creates a backing file larger than the zone capacity. After the
> device is removed and later re-added, that zone file is rejected instead
> of being restored as a full zone.
> 
> Truncate finished sequential zones to the zone capacity, matching the
> persistent representation accepted by zloop_update_seq_zone() for a full
> zone.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
