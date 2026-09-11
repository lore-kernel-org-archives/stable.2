Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923F439F71;
	Fri, 11 Sep 2026 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125703; cv=none; b=pJquxz7iq8mn/qG3XA+MfQyWqR3UmX8GKa0D531HnKFYzXaJRzft0VbkohrX2xJtzhafTRWpB4JSnQNlnhohPEvbqG3pQe74EqHsnoqhDPdoX7W5w+B59T9eoYtyir6nINQzMevzq966AzNl/pV1jn7NQF1+M2JNdgDD8zAO53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125703; c=relaxed/simple;
	bh=bekrlqQVqPRuTIUwvrNQSu9d5liRX6k1ah+vVi1I1xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RskbiPveYttDHsaUrkPP/1E9WH+Hk6ohgCFaN7NaDSEAXpUrcLAhKMA6fEk7jWU8tEOQdaFVUs9rgaXGo9WIwKSl+Kz8AvQjZ0PrscCstlTttN3kO4ta1DkaO+dals78e5j+ANPv2SZkEBiyRZg4XfJGZf3Slwx98pSwvFLyo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oADqEpDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oADqEpDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95C51F000FF;
	Fri, 11 Sep 2026 11:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125698;
	bh=sTScGWNAojtkTc8Iew6ZHgZf3U5JUuDHpOPa91/e8AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oADqEpDPyDzt4gf9i7yeR95UUi6cUoAnubbzuOzPkH8mZoqlsDDx2qhoacQ4NsXx5
	 jbwMwBXBt09BvAxiolJIamCLaNR34cLoOpJpssewd3ZJ42k6g+lUZXB2uShpKC4ExW
	 V7uMblRITP+NeO98QPURxBbVGEy9Hz/RLK+vOmTg7dEpSeFG8eNvMJjoupAEM23eUD
	 M5OL8I/dxENLA69GHgfNZbH4kcvUEGXHEIGr+K3mTzBk1/w0NTNaoKc79p7CCdISxJ
	 eUuwzCjjCdxjIRmDgAnu1UCquu3lXTF6cXvZ1338ot/YLPEAb7VDeDI5jG9w7M27w9
	 QDOdzroqkIoUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Fri, 11 Sep 2026 07:20:58 -0400
Message-ID: <daily-reply-0039-re-damon-skip-aging-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909043807.210326-1-sj@kernel.org>
References: <20260909043807.210326-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The number of DAMON regions could temporarily exceed the user-defined
> maximum number of regions limit for corner cases.  For example, users
> could lower the limit via runtime parameters update.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
