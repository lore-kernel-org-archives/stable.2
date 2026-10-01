Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC23B52EE;
	Thu,  1 Oct 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862746; cv=none; b=uvfO4171JWNerxvRKP+rgxnQIrVD9Xq9Ix7cx6T7m23TMjBUqWm7eLOwIHM9J6YROPh2NlZWK4eOlO4GOa4761uUH3vjiW5UoyaXI8kuVGlaSosgn0CgyApcUC04PQHT5fcwP6qmf4WWWoBOYOyS2UBT96qvA1DyCFfturGp0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862746; c=relaxed/simple;
	bh=AEQJ3btd6krJ3wgq4GaR63IDiNx1Wj8BLrgp1ziR5uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9r9PwHt1pUBqiNM3CXhHW+zLvqSdZN0TzHdXi8E3H8sjgdyDTnaSRmNCHLhJz9ZXkfZfBxyeTuGrSrksYtw2xJD6+vX0lmzDrQDBfBxGbskCAZuOk1fhEc0bQqNEcstz6CMxfFOJC7Hgh6RS7zePXgftbjZchOqOsoLrhHeSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+XpBbbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+XpBbbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171B81F000FF;
	Thu,  1 Oct 2026 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862745;
	bh=482YBBk0sZV98ECNDE6HHN/1C7/DQ1ojqfY7/UTrLzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+XpBbbxscuTnO6vLFzWf1nuvfrskQY4TdzlS926JFfXpBAaYOwO9dn2BXGQFWzHp
	 iaSqjP5tZA6CZLvwZvb8NdLn8FLbR+pfG/wGhljHpPuZ1d/hBJKCNDLOEtjzeTYzf4
	 yVGHtafh7UGBk1YaHYnJ9TepBY/1CL95njUYsAA+lxCrdliZ+Yo2t1U3sGRl7MknSz
	 cfGtoNQ23zZx/W1k1NP9tIkglZlRplCLUEzY1vTGNWZ1gT7YHH28kQ+CF1v7OdaeDv
	 3IYcC+RIxUCOAvNfrCZPO+shJDLm4pnf3TBx3aTpXrFjEFhskYvY+BUT07hra6Ih2O
	 TRISsoNj+s3Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	raminwo0202@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@linux.microsoft.com,
	Tahera Fahimi <taherafahimi@linux.microsoft.com>
Subject: Re: [PATCH v2] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Thu,  1 Oct 2026 09:52:05 -0400
Message-ID: <2026-09-30-1-daily-reply-0001-xfrm-policy-hthresh-v2-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929235256.1398309-1-taherafahimi@linux.microsoft.com>
References: <20260929235256.1398309-1-taherafahimi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Mainline commit 29fe3a61bcdc ("xfrm: prevent policy_hthresh.work
> from racing with netns teardown") fixes this issue using
> disable_work_sync(). That API is not available in Linux 6.6, so the
> mainline change cannot be directly backported.

Queued for 6.6, thanks.

6.1, 5.15 and 5.10 have the same bug and also lack disable_work_sync().
Could you send tested backports for those trees as well?

-- 
Thanks,
Sasha
