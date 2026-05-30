Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEAA30674D
	for <stable@vger.kernel.org>; Sat, 30 May 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156102; cv=none; b=rNuPYlKfVHMXWODhFR+XykHvKf1U3jxILK9FW5rBcZd5L0Nx4Rc+vfxe/SdWNGmklejuoareAYDPx6Ut1auSDTJ61m0QsWOTAQuZvIeJWqcd4cfbiKBjg2vQRv+BhOdpHlsdC4Xy1rmgIID1AstNQu0JbxEdBvpvG6pqNMprRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156102; c=relaxed/simple;
	bh=KK5trfHvQP+eLuUaa3rCS/v+f3tqRJ3ZdeYUUatbILw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRmtquTcgcm9KSii4WUxYaVsZWpHr9D3DByujFhbkZpySdNUDZsNi4leoBUFd2U0dj+qMBkrXm8bIqwEPyUBixeo8CuBfM2Z9LZMRBURysGd7BIAo+IUCWWNvVdBt51Dd4KL4GvNbLhIl2PKKEM6PSioPlj/Ca+Dp8zIyoP2XNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsZoIXBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsZoIXBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFFB1F00893;
	Sat, 30 May 2026 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780156101;
	bh=KK5trfHvQP+eLuUaa3rCS/v+f3tqRJ3ZdeYUUatbILw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FsZoIXBgTvB5lVzQ+Ynh/AMfTc2melNO+DKt4h+Ut2x8cnA5gkbXh8NjUBHPDGbmP
	 4diH3SG3+gzlOg/9QugKEsuAt4DHihEmTP57V8hmpYHF5w95ulURcDakYzVrhmsVMu
	 FTwQNOLAXBTM4UWrKsosAg57IBt1oaoIY8q9QNmFIj2b0gHTMRDFOU8f76dqQrnIZj
	 /4Ch/aLCtAIt9ragvyMt6BQg7C/xWZ0JXa+VXu9LSu3L2+SlrsCwcxL7FpmDyY4ejA
	 HBlGvIrEyGz89XmZMdCdJS4I8VVVQGTSGf4L7OOzApohNmXtFiY0/O6oxHOsLsU75t
	 GBhXIG1chuKIw==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	gus@collabora.com,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-5.15.y: (build) mixing declarations and code is a C99 extension [-Werror,-Wdeclara...
Date: Sat, 30 May 2026 11:48:17 -0400
Message-ID: <20260530150204.sun4i-decl-after-stmt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178014594367.7862.7999857847041901052@330cfa3079ca>
References: <178014594367.7862.7999857847041901052@330cfa3079ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> New build issue found on stable-rc/linux-5.15.y:
> mixing declarations and code is a C99 extension
> [-Werror,-Wdeclaration-after-statement] in
> drivers/gpu/drm/sun4i/sun4i_backend.c

Dropped the offending patch from the 5.15 and 5.10 queues. Thanks!

--
Thanks,
Sasha
