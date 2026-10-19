Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443364;
	b=wPv3Cjgur/DGITvDOezdmGt3Piuj9nyAS7sLUjCdfy/1WDeYuR7UVG8P7PbZLYAtw01D
	 B/3nCj2Onp6/uZTx7sp9T7BCd9uoVpIi20eXzn0ucUHlbZZpSGW5CRctMBt/zLSX1OqWm
	 ELZ8AVWXCVLNh3koK+ZOSSGHlHbVRl366l6s4CkMJmDN4YduiqJrwMWImcqDZUoupnoQn
	 s5PfaM2y5eFBH/q0+BzRXVXmYw68D9p4ODrhCxx39VwHllnu/R5gateOmLtbC4xD7GFwp
	 H6rCfca9b/C/Rg2HDH1L98vbz1jM2+CC2CF9dznSZKgkPkNimru8vdC2DLMDzb8g8Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443364;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=frU9rzT00oGQMcXqo9FjwgSq72hMS6QjQ4wCsplxgYk=;
	b=pJETMM0hkjY7tq95MnMlwql47wXILi7DLZ0CmbLiV188kr7yin9KfGqjPXb5MCNPb6FV
	 28KK+VicE6X0PkuokmUlkvZrN9Uz4w09qijLsjCHvpYKxQuQWWUR+04+WyqLXz3jhEMFE
	 vo9GQ89vzQUujiu9rG5B0V82WCKsfvThfR4vfmCbyInBl4pMSjYo7K8WjEl7oC2ihD30Q
	 4APsXUakt/3hvOF/oVToq8PPkucEmmMhmZBv04whstssAn2++gAA/bKOf2cAZMixnwbxE
	 tXPfncHSC1j0ukTgSe6a0CpnWHW0CJSxlazSh8+sfLJhIUqJCuAYdMc1VV0keB4mJZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPeO9oGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93066606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPeO9oGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F411F000CD;
	Mon, 19 Oct 2026 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443364;
	bh=frU9rzT00oGQMcXqo9FjwgSq72hMS6QjQ4wCsplxgYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPeO9oGAtBbkvGUXnYIQnSHwqemr4xncY9RaABCeZpaNVtosztSf2ipdhPy0KCTIn
	 K26cLEBuaHLhO7pk7ouBwEXvUzMZnc0nfKhuoRTibjacQne4nkrSptxtA/8cvREZ1t
	 mSbkqMcGNThV5H07VjeM/k8tclMYifrAEUla16bDP+lObo1sGaoC6fhkb6O6NdXN32
	 g3dl89vqeVxqcYiXin9Jm7DksNQ/nOzQvJWYeEODsghC0eDqEjLB7sayF16HirBbZx
	 YkwStNI1Vb4c18Gewh61ReaHmYGBzKRKsoZ2RUKKi+dTKSwr+BOBSx+V7TgSPH7Iga
	 offf2Sxxp5tYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] skmsg: Skip zero length skb in sk_msg_recvmsg
Date: Mon, 19 Oct 2026 16:55:39 -0400
Message-ID: <2026-10-19-1-daily-reply-0014-skmsg-zero-len-skb-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019-cve-2024-41048-v1-1-f68f503fd029@bootlin.com>
References: <20261019-cve-2024-41048-v1-1-f68f503fd029@bootlin.com>
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

> When running BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
> platform, the following kernel panic occurs:

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
