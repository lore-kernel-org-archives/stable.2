Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804620;
	b=R+r7P599F58mxwrbwKjiSbLhKFYg6WX9AT1YdYodLE04/UV06pK6RZ+xhLpbpBWbLm3M
	 UGsS+nYixQW5CwE4dO50pKyf1ye6BSh7O/1sWcIniwNn5YXipuox9HReupdjtiyP3s/P/
	 DH+Q8OnhBNX0JgkQBSC98g1FNAKYSe+L4znuQOwrHOGX2tR4tOIXSQWNrS/BtiIHzoebf
	 2I8a7ImHWQcaeC9dH6sKMCMYVnGmIB7Prz49g64L+U9Jq/MhWbz0qhvXnP6aTiww2ebqg
	 F3Bm9HJzrLG8dQ97zYM9KeMDY8JuqUcDfhSdHv4Mmiq5j5xidHXmm84n8pduKCGLbyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=O53dPqdu9RNOBi9QllLGk9JC5vNZKIBsN7zPSbtP6WA=;
	b=OipSXET5KjThdDcIXHvL1JN8mwlPthDjSGjDSuipiktLqnYnmPYnNBGfMa+IZ08EGAzy
	 VRPWIx2TPExGo+ct79XRIYX203DkAlblVUyYLx+fTdrEyz1GGawmkyKkFQ6gs0j5IAZ/X
	 3MriWuKjoVygvZXaUfy0xfesnufV+mT0nTxNhdBQ0aAs//ozXZGEs1s55CSqofB3ZrgE/
	 ofeMev6gRkbc5jqB7qEb2cUq7q5T5ZHTZsuOgTAbj/j7n8Yb2Fve2Igmd1+GTMhFyCVNx
	 qNQkxJqzTEYmNDw4XvnjiTtRyjoDCcHwDdgfuWf42SOyPG/HHKANS8tLeJndoLzibSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOoAL7M5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429AC606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOoAL7M5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5389A1F00A20;
	Wed,  4 Nov 2026 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804620;
	bh=O53dPqdu9RNOBi9QllLGk9JC5vNZKIBsN7zPSbtP6WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kOoAL7M5r9vl/RIbcSd2cYnSgKLgzQnn6iwOHytQAkKaJJrfWocJhmkjSBLHmqLwR
	 3Q1jmY/VyriX9wLc4bymzkff4Np5qSpnhbcKqmujFQFgkG0oYpoWZ12+moZ7yekF/M
	 IQ7SQGhgUhRmlIknqSVJj4ADMOu8eV03zcG1b8z/H2h2No4+kV8D/3FN/LW4BJIIzl
	 uFeXHnex3ePh6+2Xfzl/haiE+yOmTZ6ULCwmg9chmbtL6Z0Cjgw/El3LEt6wWrfbL3
	 b0Y1z8Ek7diHlH5yGEUmn1ErhoTzNb9uKXtdWTx/syD5Y9YND8MzAy6zWfqQG0PHhR
	 Pw+Cw7CX+a3RQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jianqi Ren <jianqi.ren.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Shun Ota <shun.ota@miraclelinux.com>
Subject: Re: [PATCH 5.15.y RESEND] net/sched: flower: Fix chain template offload
Date: Wed,  4 Nov 2026 10:03:20 -0500
Message-ID: <2026-11-04-1-daily-reply-0011-re-flower-chain-tmplt-515@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104062941.129880-1-shun.ota@miraclelinux.com>
References: <20261104062941.129880-1-shun.ota@miraclelinux.com>
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

On 2026-11-04, Shun Ota <shun.ota@miraclelinux.com> wrote:
> [ Upstream commit 32f2a0afa95fae0d1ceec2ff06e0e816939964b8 ]

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
