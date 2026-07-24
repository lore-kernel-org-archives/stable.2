Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837F3AC0EB;
	Fri, 24 Jul 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892170; cv=none; b=HvgXDnChSS6sKZlWQJ1mcfAC2Fs+bketZjOnw1GQ/P0+sL+pzCRbIStPn6hm8uEMmObq8LGNuNe4H4CLn4Uu6ybfJLsqxGdbCwt8d3AZDgknt07HTVhnPTZqmGU1HxcolMNjjCnBmtyoU73CCqHYo+obKT1B5XuMfBsK/tv9KkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892170; c=relaxed/simple;
	bh=Qoi1ARtmFfgZWsGx8eRx48vOJTkhtLJb1+GuuvirLGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzYOzqE1r2s64f4mATEhMjOie1WvgtNIG9kJ1J+52/L4Jin05TNmaXTz4kq4YDbXb74wJfnxftIHXKwghOT7EYpzHPz4SCTsF+tU+HNu8FYE2mS5kr8v7wr8c5dKBXukNCprtYpL2+OAP6xPxPE+xAlJD4gCfpzAE556SzaeB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNb51Hlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNb51Hlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DE21F000E9;
	Fri, 24 Jul 2026 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784892168;
	bh=n2HpMIjNvLrRh9jT9V5Jw1GfuA0FNPTbW6GXsK7+KXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNb51Hlg05loYe5tcl/uoReqSoRtdLAGuCdZWDUz1mZI6PV5JWRnTcnrdpCWm7plb
	 j+/LsYIpKd5gDXTmivDpBvKG86rCi+CIcDk/EnxYPUoP6e7gXM1STfj/X8qTuHL7mE
	 NBWpbLryKXKRS+BmjPHv5rOOGddguuwc+hoFsxLh3rxyL/vyvBu4JSEvQzrIA3/J6E
	 CIbg5p6cUQ3wwsT92MJz8hy/3kybSn4HWarepvHD0Lg723dElTDEmcq3VU5Eh5NbVI
	 8NU3aC+EqmmDO0p3f5u4nHPPwS2GLOF0GBATziLHPrUaAlJmvaevLYdIHjktwalYKO
	 5zUZS3PcE/YeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	info@starlabs.sg,
	ast@kernel.org,
	lulie@linux.alibaba.com,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	dust.li@linux.alibaba.com
Subject: Re: [PATCH 6.6.y/6.12.y/6.18.y 0/2] bpf: Fix ld_{abs,ind} failure path analysis in subprogs
Date: Fri, 24 Jul 2026 07:22:33 -0400
Message-ID: <20260724105500.stable-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722073908.72382-1-lulie@linux.alibaba.com>
References: <20260722073908.72382-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport of the CVE-2026-53090 fix.
>
>   1/2 ee861486e377, the CVE fix.
>   2/2 e0fcb42bc6f4, selftests for the fix.

Queued the series for 6.6, 6.12, and 6.18, thanks.

One follow-up: the Fixes commit 09b28d76eac4 ("bpf: Add abnormal return
checks.") is also present in 6.1, 5.15 and 5.10, and the fix is absent there,
so those trees are affected as well but were not covered by this submission.
They likely need a further adaptation. Could you extend coverage with adapted
backports for 6.1/5.15/5.10?

-- 
Thanks,
Sasha
