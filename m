Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF57374A08
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407040; cv=none; b=DHjXNiF79NtzmPJhXNhIeeXw2CATIBr7cDXgJTb7ZyWFeQ8qL0fC4ezkwsjxzn0XJdK7r2Ae6q4HbiV2C4EeRlWxCtFjj6Ojja++15hmluqWymjR5Ifmug7TmfH2FMGmqhRH+O5dKB/1zLUDHZDFV8k+aWQXhLPQmXkDOfPnoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407040; c=relaxed/simple;
	bh=pdoWe9GCwerp3di50gOer8JSXB6skZEbPGiCfeZGSSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8/NqzuYk60XFUOOZC03GnKcNMZs5p/lAPzP+lBLgW1jq42kRi4/7aBwXpaUry8+w4FTh2Hsgz+56l0O1g3nE5OTyL6Q8lw/bNaK1rlFrOVFKjcOOhB5C7PBK0Gj+OwY6Jffriw/cvUwC1L8l5dAJoh/gYpFat8XXC17rlgsZzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJcfm1x1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJcfm1x1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E950C1F000FF;
	Wed,  7 Oct 2026 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407039;
	bh=IoZEv724+zKjIynCwK7fjdrNJAV+f/9GlVLa4H4W2BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJcfm1x1Sa0gfh+935ZgnxigIqus4/dPhLCid8EgDH/hU77p2xO8knT/NzYC7IiHP
	 p4E9iKYOkzkhocESAZ3xvQEqtnmnBfYcIn9QCAayQHF6zpU69otywvGnBW1pHbqE4j
	 KqttYvWAjFup1C0R5Jx/FfeVvqkzs4uzoijMVosp4dAKIid/SUat7NbAzJ8wZxQADg
	 ZfGHmuSU1r1I/SSQHNcvrKn42/quOKL9+g+uZELWig+XMtYGQnhUcEInJxD5xBkNYN
	 6nOdMs89keZEKoKB2+rUUqZ2wc3QOYQI0WYuI0xE26v0cl+9GW+miUFKeEpylsS5ZK
	 44gwNs1jVbu+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Andrei Matei <andreimatei1@gmail.com>,
	Hao Sun <sunhao.th@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shun Ota <shun.ota@miraclelinux.com>
Subject: Re: [PATCH 6.1.y v2] bpf: Fix accesses to uninit stack slots
Date: Wed,  7 Oct 2026 17:03:25 -0400
Message-ID: <2026-10-07-1-daily-reply-0008-bpf-uninit-stack-slots-v2-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007101541.979395-1-shun.ota@miraclelinux.com>
References: <20261007101541.979395-1-shun.ota@miraclelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Privileged programs are supposed to be able to read uninitialized stack
> memory (ever since 6715df8d5) but, before this patch, these accesses
> were permitted inconsistently.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
