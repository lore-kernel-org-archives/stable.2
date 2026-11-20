Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207173;
	b=rtk8kgwPdtxs9q2ZV+goAia/uK+RcxHlBlXqsBbvZhM4F563Rp2h+bUaVhYhGRFqlra1
	 xYjcn3BdpgASlWF4FCJLdwhBa/b1TvlDjVFiAZzRTMPTTscAJzLD3HDet34GW9wkGNwfb
	 YJG8Vxre6k2DG9S8BreYoUhPFWdngdOCwqingVGoWyDYNvPXqAXi1iBpEM66k/AI1GT0s
	 Mt4Gh6qbIl/JuP9jgFPsuJyGumRd+2CtlE8/MSwxz9O2snjoGL9eBwH0MrqJ1k+kxYR8O
	 H/M67I3uN2eaT1KmDYhjzc9fIL76HerS3Ubck1+nNq1QKj+jx2BaX4B9L2LGylWu+Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XY1U39d671PEtb/demOi8zVtKO7zQPG13uQld90rMJ8=;
	b=ArLb94vPVBfifZrWuj73Mtw60LNCqY1uIE+yFnRC5t/AlMwlq/8fBMEJ4UwohfwXBX95
	 bdxpqwurB0nD9EftxgEfnqkxqZ7+3j+Yjg8Ze9fT6JHMz4n30cBXJLmuHCzihkX7nIZ/O
	 2Ih7iw2bHpifa8Hg/1SnxVlnM38SditUM497KTlXwifl0EyWrgoLU6/Gdxje7b1fMWlAU
	 7AmxHtzpFUxwHwp8/im9ImeYcJ33zOLaYALUWx4NrSwv9qrSR7glbL/IuofbYFpiApBHE
	 4YAIRETmqQeMZ6Ta5+Ijnyq6Xqg7jM4bSLofE7wiIUw8KdjnE8jRowideBOsWPi8YcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iralBf1z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D1606A6C2;
	Fri, 20 Nov 2026 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iralBf1z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019F21F000D2;
	Fri, 20 Nov 2026 20:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207172;
	bh=XY1U39d671PEtb/demOi8zVtKO7zQPG13uQld90rMJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iralBf1znmULzJW9Gfc6Slyhl/R5/ljK5EqXWQ0vqQWA5QyNr7e2EQ7JssCu49Oe4
	 99E8pwmIXAXgaiPzb5k0ALA86o1z2rWA1wKsE3ucez/nZn3jdfEEnXS8Aq4HQKiMKj
	 speERGVIGqkdLifSnFgisVYuaQY/RgWrN0elBQtADEvyaXZr/mmo8D7quiICqcjsTa
	 tIxvLeXQbBPPT5PncVGKbncFRZ2l9b1+l0mluJVXEZdkYyulBCBy0o9A/xu52kvcfn
	 Fyh+xLUt5uyBNNlRzMumnLaygwLtnKDrgPUqLZPCtrJ2nUK5m8C6xLuMQPpeuMl33R
	 RayGFA3GX2TWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [PATCH 6.18.y] writeback: use a per-sb counter to drain inode wb switches at umount
Date: Fri, 20 Nov 2026 15:38:55 -0500
Message-ID: <2026-11-20-1-daily-reply-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119185222.1147448-1-ehagberg@janestreet.com>
References: <20261119185222.1147448-1-ehagberg@janestreet.com>
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

> Replace the global synchronize_rcu()/flush_workqueue() pair with a
> per-sb counter, s_isw_nr_in_flight, plus three small helpers:

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
