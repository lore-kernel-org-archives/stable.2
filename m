Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1203D45F7
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701644; cv=none; b=S1r2g3eTSkoM+uuZp5hk4IwCchOuYwB7c1SOXo/8sGGnSGeZHLF9mw/iUGm20W9PKV/SbUttYjzvqdb0AXebvEZeRaQznZlHD41rGTAKDoeB7tiX8Wj+U6w8i8k3ymPRmd9biGeesYBLo0kHbCJ7b4LMBAx7kbML3lfEthEI15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701644; c=relaxed/simple;
	bh=p28ySr7l83wjeEJOhKFMb7w1dSV1dYpMSnBKN9MhfGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozeg9pigFyoirvXEQXqjYsxrsN8oEG1Yzx0b5RGlbxT97pPG3lmnLDubXUT9IOxvCC52BNy5qVV+kX4lhXndSqOLQKADk4hCJ8tGJNMoRwO2PyeziXo4o5ipKRfLVq0aTiGTIh9LVKNKxbOezqOXUVvYJYG4VuwoVI5lsqedC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huqLPZAJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huqLPZAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5641F00AC4;
	Sun,  6 Sep 2026 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701639;
	bh=QYh8mnxB6ea6Xjsn9oayzWY5WrIaQgVq1GYaVU9A75Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=huqLPZAJr3oGc6I/RPlgvcbJTzhV7DWv78gW3gYujvXTpFHEyD3SsNLBkPRQBbczB
	 6zfp6YE24FyNTc+1tOO9mTR/4jbBEcoy8PZ5rvl4dCCJSFb3wormrN0fvcxEbh3qn3
	 KUyQIMjpYOwkjEVf+cDxwF6YOnHSBFtGdBXqcmMW5AFs4LY10wySBgVHwEiX9PI7KV
	 P4CkWUyt+UFtXbE7aq/AsIGxS7HzGTx2qrcqOdroNN0ahsyl5S9I3HM7DEQ7BTmZl3
	 HRrHerxZ+Smn9AXHpfmUmaNsB5k/miIpU3LhzY32ByaFUfcm1m7i4X2dHiMi2vod9h
	 UvGDhJSxOisqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	leitao@debian.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	riel@surriel.com,
	Guillaume Morin <guillaume@morinfr.org>
Subject: Re: [PATCH 6.12.y]  hugetlb: only adjust reservation during unmapping if mapcount
Date: Sun,  6 Sep 2026 09:33:05 -0400
Message-ID: <2026-09-05-daily-reply-0035-hugetlb-reservation-mapcount-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apsYuFimfru7WaJn@bender.morinfr.org>
References: <apsYuFimfru7WaJn@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is a backport of 5120b1e048d48596ffaec1a8412012a91adba73b which
> failed to apply to the 6.12 branch
>
> Since df7a6d1f6405, __unmap_hugepage_range can adjust reservations.  In
> the case of folio mapped in both a parent and a child, if the parent
> unmaps the range first, the reservation adjustment will result in an

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
