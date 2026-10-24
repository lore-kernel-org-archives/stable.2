Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872702;
	b=FqAJx1kp1wfB9baOI1hJ3Ejgww0cta1qd8I/WpeP9TCSYGEgGkUUKkLmv/fM7DP6m01D
	 +1OzKb49rqV4qQx09MYr6/pwJ+hMFATeW2jzp7ur6BAOS0wca633aJLFHWDVCUH9HhoFN
	 RSoWeqFZpm8c2np9kMU486kmFQV4pUD3kWCgmjzlAT09nTOM9ke74JmjvIV/LglUxoZEO
	 YcptNuUe4qHIKXwyxzVfSRlvZRpafPUrkjFMa/l5zNZPdVaPqiBnOA5qYdAsXn0ccCabN
	 QQsJWVmSxh3QAQcAupfNLvpL2KDM+zewoZ9i/6AKM41xz4HLH1JPZ+MLZahsK58bWGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jFRXlATkzcRy6jqj3ZrtXPU5A2OOg6tflsIP3MVwHMc=;
	b=CEaQ07jUEBpjB2xrnjYpohu4gWACrZkLoAhXOFPHq6il6tUCt+FvYy6/uN5euCtPcSJq
	 Rwd6JowalOz8ktXcm7ncKjUqbQngFiJufXlAWstfRR36/8qrBxbmymUhuvIKYd2Sq1ObO
	 EdqLniTIu2ttBKgj2jRH3buALz53e/ztcjxU9VUZBNHWJsaZwD9a9qrTFwBu3Ajs9QToh
	 tVo5QA1WRWpF1L24JTfiGF9xeAd4msJcJi1TemPcEHC8ybBIwdPY2nL8Y26lg/h+SuSH+
	 oAEHudAHRDyEdJkio4HG2fCs6FCXR20YHtjs064kNJDU9KHJUNrkf8Mh+f/WP2QfLgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeZSGwLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B0606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeZSGwLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90501F01825;
	Sat, 24 Oct 2026 20:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872701;
	bh=jFRXlATkzcRy6jqj3ZrtXPU5A2OOg6tflsIP3MVwHMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeZSGwLEUXbwNqz5oiwXh6e/bUJp0n32q74EIbBVjVwtf9zSVPohtxNqaMm5+9khv
	 iE1whh31BqmrSxxHOTF5GqLorI22xtGeVd7HQ7gSXuVtcwXkDv+Ny3IXWEgxhbICNl
	 hjw6rKRCvB550VNP4DoTnA6R0jJsiQ8bY3NGPFYn+4p74NP36An9XFP6hUhEQZ3cn9
	 Fn592va2LZt8bZViYcmhc66xMHsUfrie2PBYZVTf5gxs7J+v9GKMGibnUvCo+TU+Yg
	 804mHI6NeKiclQWTu9b9hlJ0LuITNoyp3iOwy5xzYP8maVL8f4ONfDAoWXsf0JQZD1
	 Zn2IEVRz6Pwng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH 7.2.y] sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs
Date: Sat, 24 Oct 2026 16:11:14 -0400
Message-ID: <2026-10-24-1-daily-reply-0017-sched-ext-wait-dispatching-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024092515.22657-1-yphbchou0911@gmail.com>
References: <20261024092515.22657-1-yphbchou0911@gmail.com>
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

> A task can be found on a non-local DSQ while the CPU which dispatched it
> is still running ops.dequeue() and hasn't cleared SCX_OPSS_DISPATCHING.
> The DSQ consume and move paths don't wait for the dispatch to finish and
> can operate on the task concurrently with the dispatcher.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
