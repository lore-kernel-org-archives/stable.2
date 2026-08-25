Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D83F7A9F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658597; cv=none; b=Z+h4BhdeTHwu1YZssumQm4LPMjSOmjroM0Je7HJDnVCsjuA0QMEtwoKEI8QokhdrSZhDr2rmGg9jJGEaYBQvmyGt5ndIa6Di59/UPfLjdCBelQoUNtQsElY7XoNvIFaC0Nw2JF+wE9ZpuOkPOhbElDxd2fS6S4RNiXoFmGYR3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658597; c=relaxed/simple;
	bh=Y3AwAmXdcq0bRMdOL+DcaKwNkGhmgrcUAVM7xrb94PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iK8m0+Xzok66lhhjSf6N9mcyK54vHAKA48h/kjqRd2CuxQCTsinjJ90lOESU2rOYwSqLRQB3ipLl2p1a+0MKylq3f5GGTxV9rq3IFe7t7g7WbdsyEqmojJdUTrinSKRMsAch0Fos1YNkKz9xtnFQl5DcR7/viNaVGQTt5VkjolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvlEzMms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvlEzMms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4361F00A3D;
	Tue, 25 Aug 2026 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658591;
	bh=bgrWmaWYtWDgJWs9KY17drQtEHUF7poADXNbRVDd8NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvlEzMmsQGfWLXk0BhXBC2Dxhei1Rg8yej7/g7a+wyeDzY5QFJqMdeoWl5Yr64dfz
	 tUPAL0hwSAhAQl44K8ptXd+WUau31n3GYuGzS2V8TNjIlx16A1RUKuNTVKORcjn+oZ
	 RVph7wDw95uhj6KJpTsAK/M1tLEEraSPi2aegIKHUdhnt54J1SZuShkaYYyiCyZ3O/
	 +t1mWW+155BGQlQlCRaw6oG7czQ0Kw7sgwpocpDgFnTsgSPXmIqd9hFavyQ2SsVGtd
	 1p5vGRmXN3pRjsPqKWRKVXzq8BgLZVUa6EKc5H9Rbh0zY8HnMKNO0nxQ0i0S+ah74R
	 OelSVNQETPD7A==
From: Sasha Levin <sashal@kernel.org>
To: Jia Yao <jia.yao@intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Tue, 25 Aug 2026 07:49:32 -0400
Message-ID: <202608250012.1a23d959422d0fa2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082417-chill-banshee-11e4@gregkh>
References: <2026082417-chill-banshee-11e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 24, 2026 at 08:10:49AM +0200, Greg KH wrote:
> Ah, it needed to be applied after a different one?  Can you send these 3
> patches as a patch series, as that will tell us what order to apply them
> in.  Same for the 6.12 versions.

Jia Yao, on top of the series formatting there is a second problem: the
set as sent does not build on either branch.

Patch 1 calls xe_guc_using_main_gamctrl_queues(), which has no definition
on 6.18 or 6.12 - it only exists on 7.1. On 6.12 the same patch also uses
XE_BO_FLAG_PINNED_NORESTORE, which is undefined there.

-- 
Thanks,
Sasha
