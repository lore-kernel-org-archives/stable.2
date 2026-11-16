Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845208;
	b=UoPIJQeYJtPTAaE2FARWkB6EpQ5DqU/uvLr5aIdemi3XRp5eUxh8PcGJNyZLcTMJoosr
	 9I5/UY9buDZZ1RRQv7MFmQ3t6b4+SCjs1yAfR7H/DQWZ+nAzg3zY6wKA07kgXpK7Flkc6
	 UgTzYDoEU0/YmQqYFPkuJLyPim6Cza1J+fDj0vbnVQEJ5gZB4mqRlKcDifAJukVW36YHz
	 L4Xa2jojSG3Pq4Wh2XTnbXX5SIckeAF7XUITJAm7RhRGVWrvyIfOnE7HllRm6Yc2l76vO
	 ORS+4yb689HfcX/Yvu5RDKoBsZ3iXj9Bfep/+VGczsZmhe+d7MObUkLmRwLgC/2FQ/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nklN9Tr7HO3qS1T76huvfSJQ56j3iiCUfJGPbXum0HM=;
	b=SYZYOh9LnlVObmr3JizOwkjRnfz6QPbCiZwXrZEcl1nNRuwmaA+qhjxUHP8zCFtxVCSZ
	 mRuttWL/wO38CUr6Qs66TublXWa1CgsUcZ9ONIhCfLhu3QTswauSIX7jX0de9aPPy/Rx+
	 IADgwQtXeF34ljlczOaKCVk/dFW6RdtUEuAfYZqAV5d9twlQZeWrcRDutApw9T61ybunc
	 oRg2QY1cnp2H7zeO6JhqT04suvurFFfirq2CrHQjZnJQkpAG7ZG3H9qcsLlPnDVD1UcR/
	 tggpTOFA2qq72kPsFMBZODHyBmn61+A+gUbKEZuHcBCc+WdEG6JwMxavkJ4depjEq+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNmoWag7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0AA606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNmoWag7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4124F1F000CB;
	Mon, 16 Nov 2026 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845208;
	bh=nklN9Tr7HO3qS1T76huvfSJQ56j3iiCUfJGPbXum0HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gNmoWag7lHUKkQP42UeFwESKoLCPTtFnVvlm4ECNnK+C2DMQMaF5i7UaGM4KtQ6hj
	 WVvotIqVYljFy9Qkli2+/BifwlDyGiYGo/2T7Y3AnQ2dvHfwGT5grMNYRG0wbjquOD
	 VFt3iol0dfbs2RsTrDY1bYquswvL1f4CrGLPvOeckoYefvlFrfyjhrkAEXKMAx1/3v
	 Ehe5/7M+j6kp8yG/QIvQi/EXz3D+0F8e+jYzu7+7pN9HtxAkmWd6/GFIuruB6a4L+8
	 5/plUZ7pWOXr4qQaH3xy5uMOpacU+WnGFaQ9jYvm4MH8BRbj7IsuC3K2HS/M0WQhjw
	 QCYCLrXjtbkEg==
From: Sasha Levin <sashal@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Joerg Roedel <joerg.roedel@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Update 212c2020833b ("iommu/amd: Force device table to maximum size")
Date: Mon, 16 Nov 2026 11:06:38 -0500
Message-ID: <2026-11-16-1-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116080929.108901-1-joro@8bytes.org>
References: <20261116080929.108901-1-joro@8bytes.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The stable backport for the commit in the subject line lacks a hunk to
> match the fix on all relevant hardware generations. Add the missing
> hunk.

Thanks. Since the 6.18 backport of 6e2213dae78b ("iommu/amd: Force device table
to maximum size") is still only queued, I folded the 0xd8 ... 0xef case into it
rather than adding a separate commit.

-- 
Thanks,
Sasha
