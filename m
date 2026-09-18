Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7769522EE7
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760758; cv=none; b=JP3coBQ5CSdmu3VupSrsrA8Mf2yrEtkG8qhxRu/H0U1rcYYJ1e4pzea2vdBmuv0Fef2YgDxZxUeWBgMcLXyz0CvC9Cc3Ofvn1TyGOQaAdG62PPNF+PUozGfxWmADTdLHxQ+cKPauYbvbRP+ErPprJ8iiK6OIWiQMcnuPdSgx6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760758; c=relaxed/simple;
	bh=TmYMzbjQg14V364YtovL0IZ5ZdlgJxQY8LrSotY3ATo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBGGTnWYJRUcCGmhLS/i6L+5yv7BsxMaR0TyclPdGP1w+NNU/q969RflRRtJsYgBzI5xh/DzSa0xHGm6e2ii2E+cFO41d01R07DZuybA0CRgg2AprZbG6o1gZOUM7xTIWFfLJMQTXFzp2yqluV6HccPaQMrLm/ipFMshWG5cyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjRXbQAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjRXbQAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404E41F000FF;
	Fri, 18 Sep 2026 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760756;
	bh=wFgl2k6ExjZFni0DkOK/zXc7dRntcDX2BrvESWGJ9AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HjRXbQArd/p+zl7i65vgb+DQDkR42UtwFu+DPHWyvAuHlSJquPqOkC7bq77qNG/q4
	 C/cZMtdKZ12f3OUkggx0GY9BPzMbNlQ2vAYDtuP2Ushj4L+jFQ2xd2SEulesTK4ud8
	 PEZUAfscime6q5Ox81C18pzOo0/GyPDtgtQbyzPKjSx4ZletajH1GnzJj15I4EBjZU
	 PE2cm6yat+kqNK+IYlbGYTP24eKCc6R2wVPHHJoW6jvr4NotgHghZLs5LIrwTXF4xC
	 efAJJySh2SOumIE95r0Ffj1tZCJnSjNoMAMEw9Hyp4snPyqGxpZ1oJicRGYdbej0GT
	 ed0npx9uT3x8Q==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build)Error in arch/s390/boot/vmlinux.syms (/tmp/kci/linux/arch/s390/boot...
Date: Fri, 18 Sep 2026 15:45:36 -0400
Message-ID: <2026-09-18-daily-reply-0009-re-s390-boot-ipl-parm@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178966794363.152940.6540163997608818842@kernelci.org>
References: <178966794363.152940.6540163997608818842@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> New build issue found on stable-rc/linux-6.12.y:
> 
> ---
> Error in arch/s390/boot/vmlinux.syms (/tmp/kci/linux/arch/s390/boot/Makefile:74) [logspec:kbuild,kbuild.other]
> ---

The 6.12 queue took the IPL parameter append fix without the commit that
adds sized_strscpy() to the decompressor, so the new strscpy() call had
no definition to link against. Both are queued for 6.12 now, the helper
first.

-- 
Thanks,
Sasha
