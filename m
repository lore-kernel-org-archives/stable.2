Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04573A9851
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496505; cv=none; b=nTRIDhJRP4B7kwhzVBlKGWlxiZtS9r5swBiMjsHgsWIy8p/HFTMBwRmPlfLcnyhnlyCZiXbN8jBkKBl2xkpLRBOxcZiYDoQ8oBOsHf2L+DSA3YM85KVFJMY3oNkwFlmUfD4wncnIGaj4xE8g113q2Wp9lofdQfW712xnMRUpAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496505; c=relaxed/simple;
	bh=PvkNmZ8aXYyrA9y5a4yHNaQ34eLBVWHtv5sxJEmjNeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR1PrFilQlqyL2VXicV+w06aR29BroToyfUhJOHxM3W4DANyKV7TtyTKLrBrDXFbFk8h99rwMHfBkgC+MwUERgHNCzQLpM4sLSPMidQfF9nIvTu2wyyyqp/khYFwSsNkBAgMdA2l9zNNJdqXIzVKUO4PBrNfZ2jEEoPGus+a6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=how95+WC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="how95+WC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4796F1F00ADB;
	Fri, 26 Jun 2026 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496503;
	bh=Pdn0E5Y5Nj/fQCduvqhoJH4aFkxsGQNt0zWn1FUQEuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=how95+WCM80h3Igw2zPYuF9DZ8HIv6DQ7fZT7He4ckFBCPVeFgmhPmCqy1cQpshhd
	 sOpoD4eL9YjqTWwAcVLV9pp2PnmQKTgFnM9QK35D44DXG71ApvwhTjU7Vabvw/WrQz
	 M48wuO2KJq95CAWgYdJpHfE3jV6GIJ7T3sbrMpQT50Tv/PJcx0rgeAeZ8r+d8o+b7n
	 sDqmFhy1LLzohDpmPjYXclNY/1eEw6wFBuO3Lq44IOgyLWYAlALPDjm9XdVRu3e/Ir
	 aPmO/daj6P8uBjV9ht7ga1Exz+1e78LGk2RXdTFOuCBMWkRGEOoiNkeOoTMxx2bBxt
	 QUBeeq67HeH9w==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	stable@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 6.1.y] Revert "ptp: add testptp mask test"
Date: Fri, 26 Jun 2026 13:54:30 -0400
Message-ID: <stable-reply-item014-ptp-revert-61-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <07d9593140f9b608272e5f2ae312d94f9d9a743f.1782381059.git.petrm@nvidia.com>
References: <07d9593140f9b608272e5f2ae312d94f9d9a743f.1782381059.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] Revert "ptp: add testptp mask test"

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
