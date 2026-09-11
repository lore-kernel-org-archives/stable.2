Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817AA3CF678;
	Fri, 11 Sep 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125707; cv=none; b=ZCsNHCpDVniid8UiSBVLnA2Npm49l5z0a0J5QU/uJE1kC8xbS49FqFJVHgSHMxKQZSxAgLlce8naxQoeQ/jArzZU6FWrm7qXxDAQHvjrq+Qm0/RZjWiSCt2t7NMLga0ekIHKc1ElULsVrg7VTD7eXa5AwQdpy/Yfi44wZMzCG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125707; c=relaxed/simple;
	bh=t6dCFPIrrsH9aZBsktWWiFqILW3WTox8YIfoQqpNYzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dj+vBrjHMXtE2xp/07hk987O1mSsG6/pboWvXVALeIqOPctSM07jo5BFBVHM/NH9G63czU5of1IuijouMMXj83EQdnsAUgAZICHg7Cw3UPded2PcbDXY5Ao6PUb5caeVKR5BRHG9Tr9qVdMX/KPXlneY1uBJR+TR+c6fpYVy9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCz1rhz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCz1rhz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F351F0089F;
	Fri, 11 Sep 2026 11:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125699;
	bh=WlKK3nkH3tU2ettROn+pDFO7Dn+wh1zE+l3EA31qDSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JCz1rhz/ner9IIZX4YhwqQGgQZyC38UDxnlzHuEyd4/wUdY0oWTcpz/X/KGwi/3Gc
	 xOf6tDuysRDUmxtMCAjhOnNqE3TkU5K0E65ogqmownH3wDCjEv1r3glOmNVX5JbcL8
	 NT0Te8zO4WRFfQhK8rdPGXvUpxGR4+6je2L+vlN+c7Zjqu+9PykDaR89N0OKTl5RsI
	 62yKjBbS8rKhYQDEgKqTcdQ7HfdGZ41jf52fbduQwwaRwg+398tY1OCz0qoGx1PLw1
	 00bRJbyLDMcSRaJtzFdCebeyAsIEXCiyitFo9xsfdn/URlsw4X3rIluVJQLOJdkqJi
	 jtwgqopwwp/qQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/core: skip aging from repeated aggressive merging
Date: Fri, 11 Sep 2026 07:20:59 -0400
Message-ID: <daily-reply-0040-re-damon-skip-aging-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909044707.221421-1-sj@kernel.org>
References: <20260909044707.221421-1-sj@kernel.org>
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

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
