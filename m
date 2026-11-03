Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717550;
	b=IkBsdkl5HJZUchs+7Hz8XxSehuk5IyLs7huPR1/+jaJdA/Bb5jcZjP2d/xu1RZlwwaKy
	 1pYwj95s1/PcC/HgxtZ1CaO8bQMTcztYzBwgmI4ka9XN66bGpBA9kMTmguPpDqx4p9rDN
	 mpMU/SY5OmGrb03V920O9Q1+X/Lu19z4MdXGpuIe3905fTtddk1BfrZGwgVDrTpKgW+WR
	 BznwPNfSTceNpNr3z1VP4PAuMMIOUQWlBsMrzhRcRZBahdnAgC7ps0cpvysZLHgJ+TNGN
	 mux4RNARWz/qVHYejHqNcfjpkhxKL7o/H3f2tcXdadOFlkkNZdBx1bGblQvXyMrxRkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/wUvuGuXG/E09QKxwxEMFMdnP59gij+zVHw/PpgoP8g=;
	b=cVOPQEOOFKA7s9Ttr08m6JSUe6Fal0QfGvzw+1XYMpokTWA77Eo7FT3lf+1/I/Ir1GzW
	 D8zDXRc2xv2wSV1MaGWWbUoUcVh84m6o0rvsSEQfj9cU/yZfLotrremQFDLv1PTFAGIXl
	 sNYqMVluIXYrVIAl54fN281Dxh+QDqLhkMnXUVV7tWxRz+DvmncZvm2QBNQPaU/BVegVT
	 EHLpz22fmYTmAw8LAs+mFOcGF7I5b7i/uLBawp+I3FtWwCLEr27SBhTtVr7XWglkE18Rv
	 gmyKCbY7m+o0doABqmTTfU0GQntcTimy2z1F7YRydc70Fc6sdKN9EeEmb7eLBVuXRGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rox81nZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0D60A3809
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rox81nZ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C091F00A02;
	Tue,  3 Nov 2026 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717549;
	bh=/wUvuGuXG/E09QKxwxEMFMdnP59gij+zVHw/PpgoP8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rox81nZ1vobr3Uu6Poj9aYgPqXBNHZv4mXz5gl0BMmKYUBvtAb+oZaQkef+dezOg5
	 SJIm8DE1vdSgw5lFKTg6HR+gGhxSSjTLQkIwvQaSeiSo97IBKy8uzD3fl9pAp9yscF
	 0uuKe8z+YlJXN4SFpgEzohqMk2vyaAfaUsCLfmdzJSNbLlqDb2unTiiZjbcwtghTFQ
	 3WIiK+pTQfgGV9t6Sk5H0tYBeauNiIbVt/0Ye6r0bNhTQOi/j6wvP98r/SN5oT0kVO
	 INBgIdI3qsUP3LuxBcCBPI60gCI/qYXVilSL4TX61lANb5+kAdGEfKX9A7v6eARfC0
	 SvT7xxMNRXErQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 5.15.y] ksmbd: accept share config responses from ksmbd-tools before 3.5.3
Date: Tue,  3 Nov 2026 09:52:01 -0500
Message-ID: <2026-11-03-1-daily-reply-0013-re-ksmbd-share-config-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103110729.83771-1-mike.michalo@gmail.com>
References: <20261103110729.83771-1-mike.michalo@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> ksmbd-tools releases before 3.5.2 do not have the payload_sz field in
> struct ksmbd_share_config_response

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
