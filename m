Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7015F3C3792
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701628; cv=none; b=GNWLsMDOeW3xEpHqf1/CUWvBas1BzmFdvU40CHj30/zVtj9ZYFJ4HYCH+wxEL8fsMT7uCkg0j6aVB37qqQfK+dHZK33Pk2bN1hZRYJvCR8OfytgXZ2btBaHVGwbbFwfdojS4kHfWderk7AC4lPxmbvwykwQO1yDN+TWGRHw3j7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701628; c=relaxed/simple;
	bh=6DYx5+nlK4w6shP2MsjYqXU0V4sZmY2j51/LZIMa1T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsMxzCeA0Th1/e/OneZGx3FkH+MmZWknD4SMWERwkqFvLmhLixjlvyxlClrFPnOzm6XRoyQNtEs/GCvKruNnXAr+mMZRgeFyoABjPexk3MGzc6BSet6xX/rKsGG9EKFh6DSBxU1gPBje0ysz1bMTJAqi4RnNR42+2kaBYOVs5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6hX40nn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6hX40nn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8765F1F00AC4;
	Sun,  6 Sep 2026 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701622;
	bh=NP/51iDKqO7aDphCjUTmJUz8Ia1T98x/TbDsczsddQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f6hX40nnc2bkL7ptxlgLrgu1rINsoAt/VfJIGLfpRBnxv8hjRshn5pRF+vhWEDbhz
	 XXvSKyE9tBFYSeTUUaN5zgTebVkiKHxoD19+iW/D//u0UF88d++8ls9zCOIRDnMoXl
	 qttN34TiGFVvBTIC/zTGZ2IWn8HnAS3n1X59k2eUWNxdAkjH89oJSSaQTjh08Pvaa4
	 McxMPbDzu3iFlQKysg4RqPifNwMcHtHZ7tGfmUZyE3+f5wPUUP5ifGQwa6/6aN5NvI
	 EKhagdf3DVQpaxa+rgoijJtLFWgb94yd0VoIeLrFr8y8tj0GgCqfKADsUrCGARq75G
	 EvqLbmeIvByCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	brauner@kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: Re: [PATCH 6.12.y] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for whiteout creation
Date: Sun,  6 Sep 2026 09:32:48 -0400
Message-ID: <2026-09-05-daily-reply-0018-landlock-whiteout-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904181327.193032-1-gnoack3000@gmail.com>
References: <20260904181327.193032-1-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Whiteout objects are used in the upper layer of an OverlayFS to
> indicate that the file with this name does not exist in the unified
> view, even if it is present in one of the lower layer file systems.
>
> For the userspace implementations of OverlayFS (fuse-overlayfs),
> whiteout objects can be created from userspace as well:

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
