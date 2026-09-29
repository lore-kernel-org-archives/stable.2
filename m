Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF00519DFE;
	Tue, 29 Sep 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707869; cv=none; b=AHrGbcB1R+WHjhFdEBxqPCJhZb7OvZmiwJW6dShyAhPu2xdo3cvvXBxkGltxAIHBPZ0AgVaDkd9GCjBPEQJ1rrZt26AnqxCLohf3SwE1pbD/2mt/jl8OcCwPXZvFpDdSNA/zb9SfIJIxvW5PHadpsg+P2q7KYStSG1Nxf/2/tAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707869; c=relaxed/simple;
	bh=xeDPir2vMCg9MbVRMqqwtvHoJVl8f+7Vg9oq/nrh9/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OE91+Bs1y1B2ujmj/JpbS/XzTf1kX9ixY9UnP5WuhGgjZVJYEAtwCCBS7D9DyQXbSd4YUy2bh4VgUIqQSx/k1mG1hYBrL3I5NFGUWXTyaVgJigzUF18Go7CxWpNWMQo7Hrh/lsDTPUZuTkxZI5Iq2OE5Z7oGDVRlsFyHBHeOWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPOhFoe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPOhFoe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A221F0089B;
	Tue, 29 Sep 2026 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707868;
	bh=yNDRM42eBrQ5mbS49iPG5XFNVheP65rhrLSdNQDYTZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jPOhFoe9YCGY5pc//f/Hyaqz7yU9m89dg7Vdc4I3s8tUzEZu4taAqkCkSJTHZf5Qf
	 kKgK2UC2nGtgiY9TyCRwcqTbsLn7EOuafjJJWhjfniXOqyahlb6SvbvC6vTsq9YDMt
	 YjxY1xBjtLL9/ZP/nb2HSO71CuZ9nQQsqLHIz4EXbjHPh3KFt8xXxd44srz3NWypB1
	 CIXAYr6dv1Ap53iGxZkKUBYr9CYimDTbBBj0Ah1p+zDl6M3HyzvU2MWDc02Ak2Kj5k
	 5rBA12LaMVcgo8+pKV6YnJGzgvaRXXQ+T0KSM3IQ2L8hC21ia9VWek69iuAyDaN2nb
	 xNS2t/Ep6Csng==
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	Qingfang Deng <qingfang.deng@linux.dev>
Subject: Re: [PATCH net 1/7] net: tls: fix silent data drop under pipe back-pressure
Date: Tue, 29 Sep 2026 14:50:48 -0400
Message-ID: <2026-09-29-daily-reply-0005-re-tls-splice-read-data-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5b0a6f1a-d44f-4e7d-9931-4106172d6258@linux.dev>
References: <20260429222944.2139041-1-kuba@kernel.org> <20260429222944.2139041-2-kuba@kernel.org> <5b0a6f1a-d44f-4e7d-9931-4106172d6258@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I just hit this bug on v6.18.y. Somehow this was not automatically
> backported to stable?

Queued for 6.18, 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
