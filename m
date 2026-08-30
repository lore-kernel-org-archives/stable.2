Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163432D2394;
	Sun, 30 Aug 2026 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788058911; cv=none; b=tJXVuIzU4pbThMgDzUIGHu4V+Vltn4Ts3BLTi0pKDy2sy5YNOwK6ZQTuN6MYi4GyTrvZ77TI/XQiXPo0qRe0WbsP0pfbVh8beVTDOG3oLj9WNcGFtCEBlivw4smBxvfqx3AH1lQ0mnUWhWYs9wY2Ux+JnogJHa52Pq/7gbiwO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788058911; c=relaxed/simple;
	bh=bBdDh+H/NIRJGovU9yBjizdRutNdseXwNvZ9jXGQtoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8UPe7CRa3zQ/ljg48AEaWppy+QvqiZRutRmz+xsqq7mWZyfGLx+wmtEKKW7oCjbDmxd0F2BEffg0K/0wm/FdFBYqvt1sFTr6KMsaPrbNC0mjg0rc2M37s1f6+5iieII/NVuQXMShO8O+jES4KWCbPSChvO2TnU9c1hD8mVvhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfBnoyog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfBnoyog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E61F000E9;
	Sun, 30 Aug 2026 03:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788058909;
	bh=+wQICZzAaK97ni9rTt8zgo98Z3moaMjbD6J5IiWROao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfBnoyog3k6fbev1IF/AGp2FKXbZxRCPFHOyjAwJi5OhKkUXqYJ+6uzwh099xsTDv
	 RaFz7PgSodCgLn7QPUb4CsGvj+pGba4lsZ+uXim4fPQSglVF5j+CJ1KdH8UM5WYACm
	 svrnClPf4B8npDbIqgztVG5XpjpSiG9BML0vedzCl56mFGazgZbvfxcgt/1e85COBK
	 xEpz6wGeolY8KYQ1wFcKsCYCOtKeKOIAc9w7AH4BkRSbnwL5ZGi+U+EQpE9Zc8Zdiw
	 wUTrm92VmdSznoid8nUZUtGWvQtuh7qFhpUy/2OyhSzCTgu5xKQ2M8dTOjg0cdzukP
	 DKPjR4AdcAAOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	ameryhung@gmail.com,
	joannelkoong@gmail.com,
	Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH 6.6.y v2 0/3] bpf: fix dynptr release handling
Date: Sat, 29 Aug 2026 22:56:46 -0400
Message-ID: <20260829-stable-daily-0006-bpf-dynptr-release-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829102618.105116-1-xyx2021@mail.ustc.edu.cn>
References: <20260829102618.105116-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Aug 29, 2026 at 06:26:15PM +0800, Xu Yunxiang wrote:
> This series supplies three stable-sized equivalents using the existing
> 6.6.y representation.
...
> All three patches preserve Amery's upstream authorship and complete
> trailer chain.

That is the problem. By your own changelogs this is code you wrote for the old
verifier, not a cherry-pick of anything, but the commits carry tags indicating
otherwise. None of them wrote or reviewed it. Those trailers have to go; the
DCO chain must name whoever actually wrote the code.

-- 
Thanks,
Sasha
