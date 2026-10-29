Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299421;
	b=SySpty/trUrPBRj7MSs16m6uFy3U+pacZvMs+rneegX/OTM+cWI/WYaT1v/saFVkEVeA
	 DIPRMnbjO5ewcLbPWGPN5NSZC4ZVu7uLjWh8AS+nEAITF5JEzyWtw6nkp/nfnpLy82AME
	 +/kDLAbdQfPrizIZbcwF7rVEkDHzBy4L0k3SVD+wWJD+UTsojO0Paz18uYDDj/SD3wCQS
	 lGAD9oxaaWkam8j3uej63XjQ5jMksJe39wvQOguozN5MUNZM7edY5OfHcHXqjE+YDGst5
	 5Hu9Z9RW78Bd9RJDVtSQMvkth3zlIfpXFGVdmIyjE++NNjJn7fMwOoehsa3zUUYhHSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZQtjgZdsv1mA0GfFT4rMZ7MBtyEPd/7QJ+ypGgkNGBg=;
	b=WuibjIUrzH3WPDvsb5/U3Kj/ovBLBX6P6+J5EyTraxSFCCMxhXWEjCnxng1KU98aeMk0
	 gCot/HJnL+msgDWcj+V2iSvP3hvnM8f1Z6Iy/S+2v0tX7VJ+KGQUt9+wbGJCgBsGUkbcw
	 2J6fBFDNivYEjJ2OZVxPIWOlCTd739h5PbgGkyEHFrW6fjped++A7K22SmnyGnSJYP5rk
	 izFCx2b0ysB8EMflrQ2LsszdEXmbK/Z5kHmbdR6Y22cZ9u7Pxk4jkRbLJfdbqzLAPlKGF
	 A65zaFBGx0RvngOnsPw9ETwpg4R+Rq8uBhBCaxozcmsxabvMYd0QKnLl67qwYpOnMhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVHPoaNW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD68606A321
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVHPoaNW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F30A1F01829;
	Thu, 29 Oct 2026 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299421;
	bh=ZQtjgZdsv1mA0GfFT4rMZ7MBtyEPd/7QJ+ypGgkNGBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GVHPoaNWh42/L6jZGk/8DXer8bWpCjKjt9qJjePddkWpRKhv8XKz9DGby7LjZLoza
	 eZdv7mpr8t+Jrfnw1jcUgMLZFT62pBOS9a9lOXh/uy4Nx2QAyMOEtbrANenPN7G+tf
	 8ljT+VtDxKX7/9w8oMYYMsq65UE4O57lXe1xmMBDzThQKUy5voCScLBBsAEKUcpJsn
	 n9Vz8Y6e0hXR7RIFSIeVFZlSCVl9lrDYHu1TILpIyRDh5uCdJV4VDlaQYN6PpLgi6L
	 KY8B1TKJR81GArzERMo6ye+54FvWBWSIb1oAJjAo0m5ldWNGbBD/DLtauOtGqfFw53
	 59nuTP9wDHBww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Hiroyuki Katsura <hk590@cam.ac.uk>,
	Vincent Donnefort <vdonnefort@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH v2 6.12.y] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
Date: Thu, 29 Oct 2026 14:43:14 -0400
Message-ID: <2026-10-29-1-daily-reply-0007-kvm-arm64-hyp-stack-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029022308.2620922-1-mkbund@amazon.com>
References: <20261029022308.2620922-1-mkbund@amazon.com>
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

> [ 38f9e4b905a0 ("arm64: kvm: Introduce nvhe stack size constants") is
>   not backported because it converts nvhe stack code in eight files to
>   NVHE_STACK_SIZE, and the hyp stack here is one page, so PAGE_SIZE
>   replaces it. ]

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
