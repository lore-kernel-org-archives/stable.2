Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C993D9DAA
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701649; cv=none; b=faEWy5i5/+d617opOmtD3FMKOwCL6brP1hRKeOENLvYo1dySdsDIqGhyyAsWKyDPwCQI3Z1Q+gunG7oP2LnA578/AFMDHv9EcGQ/TCSibKeJCtxPnjL/75VPezDR4yJr9izBOMwOCcPJiYm7bO1pkNiEFnfJDHIz6J7vdmc0DLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701649; c=relaxed/simple;
	bh=5prqUyGNN93Ve93ttcm0pCwfWNaDkAHNH9ppghU/pbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZS5XNMy8Mglfzqkqd2xDyOagvRx3ytYVtWao5lwcSafNGVQrxtLkFCmqA2jO2xwL5eXtWC42FmWQ9vKWeGkOsacrZiAMFlSBmib8+bRH+IgaH4R94dZ35WXZTOnQMxRUnIm2wt7KIw46zEjpOiAt1dsOxYE1yB68Y5hH1V2j9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF/RaldQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF/RaldQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD2D1F00A3D;
	Sun,  6 Sep 2026 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701645;
	bh=cIQ5F4g/F98vLWZwf7xPpCeLgiwUKGXB1YmrqgsjV0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aF/RaldQNZ+90YTHTv3Yzl/F8UM/1Ol9KhATKHxXmGlN8elSe20+r4MgVvwsRqh/C
	 Po1n5z1En2OQU4LSu0NcFuuvq5dEbvNnUtGY/uKJGEyD9bSlcjbMJ0j1IWdGolQRw1
	 p7j5eFgvoO9+SmfMcyn6Ysbz9Np+lUBMsVvsDlBcUT+dgAq0XFFY6hsiOehr8VlDNF
	 aZh+UTt8C6aBRDvfKkD77aF9Ulbx6v5OH5E6gwcrh1e5NhiBrbboMIPueiK0Xtz9Mp
	 vAxdDYx7Pd3o/Ah9wC3fPk60Y/IBRDt5C8822jtpyHjlYI4LL3PVRDmDvYTO5xlIR4
	 3n9Q2SdturuDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 5.10.y] fsnotify: Fix stale object mask after concurrent mark updates
Date: Sun,  6 Sep 2026 09:33:11 -0400
Message-ID: <2026-09-05-daily-reply-0041-fsnotify-stale-mask-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905024422.3925571-1-yjkwon0026@snu.ac.kr>
References: <20260905024422.3925571-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When a mark gets a new event bit, fanotify and inotify may avoid
> recalculating the object mask if the cached aggregate already contains that
> bit. This is racy with a recalculation triggered by a concurrent update to
> another mark on the same connector.
>
> The concurrent scan can read the mark before the new bit is added, while

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
