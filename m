Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862C563FAA
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171315; cv=none; b=mJvXlL6L9SKNYgild0Qcsd4VUPK3j9+POWKpHn1JyAPwUPuHYKn+LEWQHWmJ2iZ9BP19kLzKkOPLQ8DJyTfvbuXPc5LfGpUrkncxQKpZn/C84KTUA3AIdBitt2pKME/a9XjA967BLvzbIpQQFa+z6zmtRC0/ZDSw/a9qZWOtyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171315; c=relaxed/simple;
	bh=zLf4n78l1h3bFu2neIcXuiZTO4IVRDeWTVRUwmBGKyI=;
	h=To:Subject:References:In-Reply-To:Message-Id:Date:From; b=uUrQXcmG+EynmT6vMbVn0Vg4yfQ31AMLJ3F1VlNp239qz8ltAv51kQuPQIk2Xelq7SJ8rpZ+9V3tI8Rg6xpu2lo20yuR85vWjHwPIiam+tlLJO0teMvncV9AdjdyEI32jkpo2pD/kIC5usdLGRQLBB1w75n7q9uLoxVRvNTDyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=C54FsrnE; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="C54FsrnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1792171313;
	bh=zLf4n78l1h3bFu2neIcXuiZTO4IVRDeWTVRUwmBGKyI=;
	h=To:Subject:References:In-Reply-To:Date:From:From;
	b=C54FsrnE4mXhAwwlYZYyg+Kwmcb8KcOypcNrbe6esBhNGrhm89EYt1ybKV6yzgIe+
	 ZZPTx5T+mwfxo9pYw+9IPERtfvpVzehesgQ1JKehLH3iT0SI1cW+6c3xA80TvzYqL4
	 Hch3cJ/Ln8+scnbjsIDrhDpYk/FwLm92Vm1WN1s0=
Received: by gentwo.org (Postfix, from userid 1006)
	id 9DD2540B13; Fri, 16 Oct 2026 10:21:53 -0700 (PDT)
To: stable@vger.kernel.org
Subject: Re: Patch "slub, kasan: improve interaction of KASAN and slub_debug poisoning" has been added to the 6.6-stable tree
References: <20261016172149.3999437-1-sashal@kernel.org>
In-Reply-To: <20261016172149.3999437-1-sashal@kernel.org>
X-Loop: christoph@linux.com
Message-Id: <20261016172153.9DD2540B13@gentwo.org>
Date: Fri, 16 Oct 2026 10:21:53 -0700 (PDT)
From: Christopher <cllinux@gentwo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Christoph Lameter <christoph@linux.com>
Subject: Email address change

My email address has changed to christoph@gentwo.org. The email at linux.com will be decommissioned on May, 1st 2026.

Regards,

   Christoph


