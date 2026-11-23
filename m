Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417366;
	b=e0osv883AC2x3McaCdrwfNArC4CSOaAAK/exH2Isp0Nqg7GR7ypJkj4CzjKlrkukAqkg
	 r14jJqFXgwsZE2SF3NuRXTmOAIrRb4GeLXrD3yRtXA4RzkEa3F14nqLaSfytMn7WDMnLS
	 TdOcYNOC11bte1vCNk6kcO58uJyE+ocWiBDovfi9Fe4lmO7tMcR5hNM3lBkqGwS8xWAcU
	 iI6HwkoDYUX+wIgrP/b8+9nHRPSKDar2sgercYLyh9r6Yr6PZKM6tIV3W0T+gu+6l7KfU
	 6RD8uv02lbAc4de3/4MF1Mh43NeY1B7FcBJuuYbtHdv/j9Z03CY2EZDMS7K1wnAKO7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=lzg6yvDK6hoxLbtSWI/0wE+skjzyKpWF8aSIoXfC4rtBd6BjHjSOY/U/Hq8fUx5f3cJZ
	 jg7uwhYhQBrDKVxJ9JyG93zbV3N+Se/ymfUxAl/MoQteO5a+n2FZ/w5ubB1WMeHZlx9q9
	 lDWEyMbytdvQQGcsL3/yzwj8QsuIcTQse+Ait4WzhILhEl2x3z6Hbs6PbO0seRkRMisqh
	 8GjR6BRx7xsGJdErEpcCnNSkWMLu8fRP54uROARcOFWZ1viOxHJoWk4dYpPcQYbkzZ8Sl
	 dkMyb3N4/uR/ilzUgPx4S/ZL9FhEB6NV4/NRLKdTfqtTDEMD2hAeXKf4u3viFHoHvsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvwcQ6FE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF31606A331;
	Mon, 23 Nov 2026 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NvwcQ6FE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECE61F000CF;
	Mon, 23 Nov 2026 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795417365;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NvwcQ6FENv4r7ncMblWneLHQbu9M233lp0URy+8x2mSmdL98kzRorB4nbn5bBfLim
	 dK20V3Otbix1m0diDhghVTY5sXp5cas3k+RplibKvYIYuafHl7ALTVxtekK1N8NYT4
	 Qn8j3wR1Sjz29WsjJha4jG7TmyzG15t0bG8GPeQyuC0ImzljIalYUfnPlKM5fSQ9TS
	 36fiSMxk1SPUgEfKGvOFpbvZEKqdNAbQ4A8FqQqC1VUKvF+UDfewJm6Sw7kYNMDNCt
	 XRXoHPPDIPIPCSvwLvXSRTLLNOEeVl15o48NIriTqpBjDSdB2mFUy6C2W7Dy8kU0el
	 B1kcrUH+daRow==
From: netdev-bot+sinfo@kernel.org
To: Zhou Qiuyue <n0ps1edzz@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Hangbin Liu <hangbin.liu@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: 
 Re: [PATCH net] ipv4: route: fix use-after-free in ipv4_confirm_neigh()
Date: Mon, 23 Nov 2026 07:02:44 +0000
Message-ID: <179541736475.3294.5409888301831078050@kernel.org>
In-Reply-To: <20261123133000.2.n0ps1edzz@gmail.com>
References: <20261123133000.2.n0ps1edzz@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
