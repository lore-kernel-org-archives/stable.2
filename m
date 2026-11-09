Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235403;
	b=KIS9GfPZ2d5+frharJSZ5hIKz5yFZpfy30hU5abvVPSgNZ12fs0dt50XxpFSsE3UHeCt
	 4HsgZWJAULzTemzcNR+PtOQ0jF84X+YPnmah28wq51UYRAlahq+vdjnjLYZb1+fQ/9jAg
	 YSYfODo8ot0V6J966BdNrMYSfXhW0VbwlmqMTHKHfAXWqNuYnMBhkgXrVp8dapS7+xmER
	 YpaxgogbknCfEcwkATIfgji5bfjIzs+7syyI8+ldDhkGXecW0RiUyWURvlFdwm/bun9XD
	 OvQvnJOnCRDb+myTSjAyQHPuATScE4NRZRs8ZpNJeFfU//gxjoacwz3W1P8GKODc2gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235403;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gyK9W72HUfOKN5Is+cnVETMNV5DsU6d6CdK3B4/Lyc8=;
	b=Vya1ESvaANX7/ghqr9yRsWJTiOMXzCFA/pgn85ObTl96fQJgGqwYh+Lkj5y7WyNe7p8b
	 5i050AhoWLf98VR0jn+eNjh2eooJevJvGfe+9By5mN7iIsyMXjjjrcQGPLGw3dJ6A17nc
	 /f3HqEVr9XbncuQd1LYg7B0ZcO5HFX4XTOm5//W8fJjNYBS3Ectd5iuwT1gNHZMLcfv5A
	 ZMhRCsgwmRwpBjLe3NeWQ2p6QKjUnOEYzZtlbWpoAVzcFCiUQmMdvjksuIL9ih/VvqOO+
	 s2UAvkLixGfP4TjfHEc0vjp0Qg5Kr0wrzHjQ4yILLrSEOshAN0Gqt653ZCj0Zl5mHSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XuX6nAKn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 74C83606D82A;
	Mon,  9 Nov 2026 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XuX6nAKn
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 803FE1F008A1;
	Mon,  9 Nov 2026 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235403;
	bh=gyK9W72HUfOKN5Is+cnVETMNV5DsU6d6CdK3B4/Lyc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XuX6nAKnLqyIhOeCwXwt9Le45likn+7Zb6H+OQUr4bEM0Ph5smi2CMEqBceQNMsmp
	 fO4zmTuIvQJL9O9lcicwtP1P5cdXG1bDyhEEfVYnBlw9LyoptutmNyoTIhYy6dK41b
	 fDeWTUThCA9C7qLZkfXBB2UT6mUm90DEL+xnYg7zdW7w2WIzBuNtEdITJT7/QEMP17
	 BWZ3AYp89apIgS8X1K/kF9OXnqBuj1PQriqNEDe6aZTxNSLHIGU+rHoKVrc/3vR3Vw
	 iBv6PXV47UwsLLuQ5ey76BOcW8jPvNFZskJ+iJllpX/VYNCRC4lxkvsPLwW743IHdy
	 e8XuM1tOP7oqw==
Date: Mon, 9 Nov 2026 16:43:19 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ard Biesheuvel <ardb@kernel.org>,
	Matthew Garrett <matthewgarrett@google.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: efi: reject a final events table with an oversized
 preboot log
Message-ID: <avHcB5IOQHomIvEU@kernel.org>
References: <au3xM-7onNTtgceh@kernel.org>
 <179418897414.2773996.1582380807629789288@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179418897414.2773996.1582380807629789288@xiaopeng.com>

On Mon, Nov 09, 2026 at 09:49:34AM +0800, Guo Zihao wrote:
> On Fri, Nov 06, 2026 at 03:24:39PM +0000, Jarkko Sakkinen wrote:
> > Ditto.
> >
> > For all four address validation vs bug fix intersection. I did not
> > check throughly enough to be exactly sure of all four.
> 
> For this one I'd like to argue the bug fix case, since the data being
> validated is not something the TPM reports over a TCG-defined
> protocol: both sizes come from EFI configuration tables written by
> firmware, and nothing in the TCG spec constrains what firmware puts
> there.
> 
> The firmware data is already treated as untrusted in the same
> function: it bails out on an empty log (log_tbl->size == 0), on a
> missing final log address, and on a wrong log format version. The
> unchecked subtraction is the odd one out.
> 
> The consequence is also plain memory corruption rather than a
> graceful rejection: final_events_log_size goes negative, the
> following devm_krealloc() gets a wrapped size, and the memcpy()
> appending the final events log runs with a negative length.
> 
> And the out-of-bounds write was introduced by 166a2809d65b ("tpm:
> Don't duplicate events from the final event log in the TCG2 log"):
> before that commit nothing subtracted the preboot size, so a
> malformed table was harmless. The Fixes: tag refers to that
> regression, not to the malformed table itself.
> 
> Ard also had a look at v2 and only asked for a pr_warn() on the
> rejection path, which is in.
> 
> So I'd like to keep the Fixes: tag here, but I'm happy to drop it if
> you disagree - your tree, your call.
> 
> Thanks.

Let's take quantitative approach instead.

OK, so does this actually happen? I'm weighting this based on that
mainly. Usually bus corruption is not very common when it comes to
TPMs because they are usually either soldered or in the firmware.

Is there something I'm missing out? I don't think bus interposer
type of security scenario is common enough to use it as a rationale.

Br, Jarkko
