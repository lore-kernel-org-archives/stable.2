Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185474;
	b=dDDj28RNOkb6bkFT+uiBK6OX5kBm4EROrtst8bWz85uFZPaCrZtbFcBaTph3EFp1MzOC
	 uMShJ+9uEwsC2q5bcYWsCj5K3q6HdyifrczRPmpQ6SfSaOMxGNNNosn8tE3/eL7BBkie8
	 BbLVqXb/bLQ/r0uCulkCSEbVKvwwEFm3WIoNxRx55H2IkLxvFZhZkH6dBEzgptVpjocSc
	 sRZZEvez2FHQ2o9EnoOhIWq4fHRRfPZBe9kb9M1FvwNAfmoGTCBTxLpj6rjKzz1KYbbMk
	 lJESPkhjCMdcKdBIJSjgcpfCt80sLaerW4OSeWy72RlaZmkkeaJ1wURJAJrqccivPzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vNYpZVkWRff+ctPGTKbnjtC6bk8Ke3uAIy1eqQ5b3w4=;
	b=r1NZrR5Iy7wx3wr5vGlrwbzB5/LsZZylugWbQADDy2YDASPTlOOnZ8wttKGWUyMPpGTv
	 FcywI7ZhSx5NK9djxWEb7JreVeXjjNyaAi6HMPkIIoZubavqZ7GK8hZKQyhiVBIAzOOqB
	 YFevk+9OMVpqZoSqhKGz45nSRkjy0QUr7sjyFG7rh+i2Js0Cj9Zx29/w4IlEh1KAu0YAu
	 BQ2qmD34pZXeh7rk3R3pKLl5nGtzutsY35nKz9Cv1OfCP8lBRMF4IUEDORlz4h6NOzoH3
	 ABV88w4Ok3uozAjuEElr/ZdOTiM8SMj0JIGK7C+s5b/rFjSvnBrCXJYCZc66K1vH+vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cx99pLE7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C520606A31C;
	Mon,  9 Nov 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cx99pLE7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CE41F0089F;
	Mon,  9 Nov 2026 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185474;
	bh=vNYpZVkWRff+ctPGTKbnjtC6bk8Ke3uAIy1eqQ5b3w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cx99pLE7MNZnSiz/V0Tbf7PqC8O606hcv/R77eemET12NiNbuJcvEwfNi5Y392ske
	 Rb00uWu/d6PXLd/TjB1ipe3rFPsJTgxsOkFWujKrxiVUOOuJeEX4KDQjyMC5lzmr+b
	 zy77UvQNNqVRPOIawUAU3Emg5wmputEby140cq7NmjElo3Zi4xURVC6HFOmJBnP+d5
	 Eejm/plWqt/UucnDNHebAjOI0yBMmV6XTtxp7gjksAwr4+jhZX4j8PClZTTZa5Ch5l
	 DUo1q3n8v6jJ5OvuPVxUxgP4LenHLXoAMHKqWxUakHUM4r//xH6SxsJq55oNdqvRqG
	 zSFvJfUqTUnaw==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.18.y 3/5] mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
Date: Sun,  8 Nov 2026 16:51:05 -0800
Message-ID: <20261109005106.77748-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026-11-08-1-daily-reply-0006-damon-6-18-sysfs@kernel.org>
References: 
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

On Sun,  8 Nov 2026 19:34:34 -0500 Sasha Levin <sashal@kernel.org> wrote:

> > DAMON sysfs interface reads the user-provided size range arguments for
> > hugepage_size type DAMOS filter twice.
> 
> Patches 1, 2, 4 and 5 are queued for 6.18.
> 
> For this one, af19aff38d6f ("mm/damon/sysfs-schemes: read
> sysfs_filter->sz_range only once") is also missing from 7.3 and doesn't
> cherry-pick there. Could you send the 7.3.y port first? I'll take it for 6.18
> once 7.3 has it.

Thank you, I will do.


Thanks,
SJ

[...]
