Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A83FC5AA;
	Tue, 25 Aug 2026 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658586; cv=none; b=u0UEx//hNxlu8u1iDik57L2hRxBMif9kZTQUkVGwaobkl5wr7t1beSvMXzNdGvJajcQLlS2M6FZaf8SBG6SGNjxm1/tWn1J/fNOrvtntkk2sQr7+z/37+rOTHIXbq9pvE1NUryemGpcaGBoH8SBxU4+pBsGBs53DylmGnWliMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658586; c=relaxed/simple;
	bh=4S0A7/13HCGF4fPVBfOUMmHfwgxkkafzniXugPY3fXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwDy8FcwmQ8/u6z/LxLsujou8f6kDRfzF1EfUCEMjjXYUyUDKoo5Yu82wiVWU7jIocv3p2NACYh0H+OUkOOmuv6zrdo+i4dz+mRwbSY7Ls3PdQ39oyf37NvDV2JqH4+LGRTeL7/crXA46C5DWVgxnbH/SP/6hm49BvPlo7XMkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCxYP/QL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCxYP/QL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E841F00A3A;
	Tue, 25 Aug 2026 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658583;
	bh=pjt8gl4GYLlpu22byK/2WFcLjiAT+IRY47fwyBZp64U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCxYP/QLgFZ7ZM6a3Uv+2Gofg27Fs+Vg+xf7JWSMZWTJI5piIcrPp0+QUfCnLgxzp
	 8P76KsSNJynby33RaTQqLvaK6Z5eyoK7JVHNJuV83zV+XXYpGtrrAA55u57kebea5d
	 guBpWoxtEp8Mq5xbaGhEnD0YhDYLRrOT0wbH/YPNHgzFHiaMPdeubjfr2doAqrjuyN
	 K1NABelzBGaZwBWqlp3ZrNn1jvXB9LqIcCwbsTcZuX4pBwZ+ZixqYQqn94N8ht/Yk2
	 L6vyAyUH9mNaOoGO2hPh3g8gTEIpfvx6nFUB8YzVE7ZvcoTWB3s8SJiFHBdEFSWhsg
	 1gBZqRbOmNT0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com,
	zhangchangzhong@huawei.com,
	weiyongjun1@huawei.com,
	Li Xiasong <lixiasong1@huawei.com>
Subject: Re: [PATCH linux-6.1.y linux-6.6.y linux-6.12.y 0/1] ndisc: backport ndisc_send_redirect() cleanup
Date: Tue, 25 Aug 2026 07:49:26 -0400
Message-ID: <202608250004.f3480d029dbf1b67@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824133852.328978-1-lixiasong1@huawei.com>
References: <20260824133852.328978-1-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 24, 2026 at 09:38:51PM +0800, Li Xiasong wrote:
> dbc3791e3b24 adds "if (!peer) goto release;" inside
> rcu_read_lock()/rcu_read_unlock() in ndisc_send_redirect(),
> which seems to leak the read lock on the NULL-peer path on
> these trees. This cleanup drops the pair (callers already hold
> rcu_read_lock()), so the leak would go away.

Correct, and confirmed here - ip6_forward() already wraps the call in
rcu_read_lock() on all three trees.

Queued for 6.12, 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
