Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF06318ECD;
	Fri, 28 Aug 2026 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881609; cv=none; b=ft3n78We0QNAEKDDEl2qia2SNGxEJVJK+M+YR8JYCfZpCd+VwXfdWge7pxIIIVOA8IYxhfDoEidePfNhYZDTkNhw0pM0RT3sTPkeFT9oWnnFA8NhJwmoCMlAwtyaCIpWwE7FLERrTpNatrPQ2HgwcwVn6+nV69grFkuPj8J8jBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881609; c=relaxed/simple;
	bh=TGLYN5UhOPi+J5hXnPejpOpuLM5GBizIr3i7eudv2X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja4bv3tKrhes461K1HbEu1feGDUwO17it2goAilSs4UB9xsNkIRTdb6s+aQnsQB51/bx1pUykS6JHh89SRlql7YadChCC61xFJnaKiJm392sXTWoHRvKVGyyVas6YXxOx6ZNRuDo0HjJ/x8DLuXJf2pXA2kHNlvfe9jC7y8BC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjiHt2HV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjiHt2HV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E943F1F00A3D;
	Fri, 28 Aug 2026 01:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881602;
	bh=Qt+bF5TzEuQN+36UvMpXpU9btc2Zv1gpgcpc/DoEptU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WjiHt2HVmrk5hQW9TMNowoLxzdiiIwL5q/rykBvaZWrKHQotnDXq6DT2/ljyM3daa
	 Icd49ujQRaCJLZbzO+wVuJE3fowX7GjAXLezBk5tJ3nkha8vCJVHM4QIBvokFG8USI
	 wGcZhXHit7SLSe6gHvDwpRab8WJpy42MC11+SZvqXDUJJcq0fay7wYm5yBd+rvrj6F
	 vp/h6LPPo6/V0nYQWNMXFptaAncxD4Svgf+5WO1n+iDGWHDiA7YdnKjdLmcpapGSLf
	 6oyFjZrvATKuxfuCupjVTT/x92K4z9qcDo6kQhth2sl/+D5D3n7cow3khac/iqmYAe
	 HZvXZ0zIeclYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	io-uring@vger.kernel.org,
	vrazdan@openai.com,
	asml.silence@gmail.com,
	axboe@kernel.dk,
	krisman@suse.de,
	gregkh@linuxfoundation.org,
	Vishnu Razdan via B4 Relay <devnull+vrazdan.openai.com@kernel.org>
Subject: Re: [PATCH 5.15.y] io_uring/io-wq: fix worker accounting when canceling creation callbacks
Date: Thu, 27 Aug 2026 21:46:26 -0400
Message-ID: <20260827-stable-daily-0013-io-wq-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825-stable-io-wq-5-15-y-v1-1-a37209dc29ed@openai.com>
References: <20260825-stable-io-wq-5-15-y-v1-1-a37209dc29ed@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Decrement nr_workers only when the canceled callback is not
> create_worker_cb(). Continuation callbacks still release their reserved
> slot, and both callback types retain the existing running-count,
> reference-count, and create-state cleanup.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
