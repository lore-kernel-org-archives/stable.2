Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF44B8297;
	Fri,  2 Oct 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950805; cv=none; b=q7V5+R1kcfxE7YVJYMvZeGxPANzTCOB0LLSONDx9yxAWKQpcjzAtLRfkf+iFDj47YW9BIo8nIoejJ19/0wyWdAnvWPRzL2FLfqm4bYrniA8B4loCT6WVkFzDynhJ2Ftza/L8zaugdWXT48k3qOA5Ch0etq3l+oWAR5OldfNuZFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950805; c=relaxed/simple;
	bh=7gOJyHLaIMmDMt8nqbc+YdFlIER28XnlFAIXZ0nfHAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0K4dPZhvJNr+lN+By8Pc4tIcbmGB75nF2WBjuRr3PYLxNxRpnO7zom4nz/3gUOXbNQ/mxSH3Wjaaj3PqJtAQ4RORqnhru4WLoxP8kFxRTXnTfk42qq3CvduKtc0KX4rLJfh5Ul0r61jxBLhqjTuoVpjyn2n01FYvfSWqMg/dVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWJq+0Ug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWJq+0Ug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB13E1F00898;
	Fri,  2 Oct 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950803;
	bh=xvFbLm4shiZQBRVNFW9jKmEZ+on+Ade9e5YyyaQILZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MWJq+0Ug9PYdhB4mMG4indk5DvD7OlmRAQV5EoCpg4xOsp2dVLPNLeo0ttjtpCQk8
	 pXNYEm3tWX+3CFBCiZoFqkDk5BJYkDdWmoFwtLQ13XuRjQoQKbbiA0nORUm8GwxsjT
	 5xvLj+8/wRLdOme0gxJ6IlGHWS9YzAExuxs1vkrKxydDP8RA3ANAsP/qeKX7q2iJ8F
	 hrUBso47D/4WTwpG4lWGrYwhyGLlQG3kzU1dKVlk2HYiSf2jSKEn3iP0Pl205Ha8w2
	 gOLN1mmmfoI897sliF7YdFQlRAbGDMuS3yoZOgzepesSjhNDfFihI944YBLub5pCDH
	 vLAXDhC4LeRMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?HE=20WEI=EF=BC=88=E3=82=AE=E3=82=AB=E3=82=AF=EF=BC=89?= <skyexpoc@gmail.com>,
	Nikita Nagornyi <nagornyi@amazon.de>
Subject: Re: [PATCH 6.1.y 4/4] fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()
Date: Fri,  2 Oct 2026 10:19:47 -0400
Message-ID: <2026-10-01-1-daily-reply-0003-re-ntfs3-attr-list-oob-6-1-p4@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001114549.162469-5-nagornyi@amazon.de>
References: <20261001114549.162469-1-nagornyi@amazon.de> <20261001114549.162469-5-nagornyi@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: 6.1.y's ni_create_attr_list() uses a `goto out` cleanup
>   convention rather than upstream's early returns, so the new `return` error
>   paths were rewritten as `err = ...; goto out`. ]

[...]

> +	if (!lsize) {
> +		err = -EINVAL;
> +		goto out;
> +	}

On 6.1 the out: label in ni_create_attr_list() is "return 0;", because
14f527d44de6 ("fs/ntfs3: Correct checking while generating attr_list")
isn't in 6.1. So this error path reports success. Please return -EINVAL
directly here, as upstream does.

Could you send a v2 with that fixed? 1/4 also needs its upstream tag,
see my reply there.

-- 
Thanks,
Sasha
