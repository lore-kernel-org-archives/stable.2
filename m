Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158709;
	b=4/RXh88OD3qbHM3WSTvPr0YJRCT46+8QjS26Yx8SSvCanpOcM0fanHTlwKq37Zmcn1V6
	 Esfc5jKROZp6T45aoFakx4aOZGXJMFt2kl4vqEi14aJi80c3K0qplSvCW8Xh3ogZUfxlC
	 6ukxm8E2rNzZCG5e4HmGH5MzcsT24kzvN0uHVDjwJGqlWr0Y4RKkAbWYqgwcKL2gbciJa
	 Qu7PMZDjmoHrm0o9M9XdLGkspeZ9j8/GSA6/9GouJ/gIEXzAgVJ9QsSyqZay0D/GaDNQs
	 mxcpoS/NEa7QKmAYeWgBFxRz9FPUSdxRCQW3tUUjoNj7cFsIz37djqX10ms2W6LvBNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158709;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=a9BmaB1EJPYoiOj3efcL7rpt7e9jF03SzioViwlwS24=;
	b=KHl3/V4ZDFr2ejvxAqG3zOXC8QBtfAJEbIMl0MFSMiCF5kseTUiOgzYuCEgXxKZDk1a0
	 hn9aeQhewXJ0gdWjqvl0xKf8ZOK7Iyt79j4lsZbN6OxtTOitY9zwrli/X77uGcE4Ulmqg
	 irCLk1Y0lSu2h4ZN6NOnrI4Z0ZEQbV3LLBpNb6ZRpP7AMlGvLI2KeA2Vzt5ZY6Pqi1R6W
	 NYnodpk3AxAmFgfH+3NFNgwrlkvuw++avd+wAjf7qdbSqIxTcxof/vstHp7Q7WReIYTTm
	 27wLRZpQ1dngHqKWj37WF13ALuiDNTWArY44ctZHNzNVav0fJzLmDHi45bz8F8JUu2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4+6hr11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3F606A320;
	Sun,  8 Nov 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4+6hr11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAD71F0089F;
	Sun,  8 Nov 2026 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794158708;
	bh=a9BmaB1EJPYoiOj3efcL7rpt7e9jF03SzioViwlwS24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a4+6hr11zxzaXk/87oSBanVR5Ij+H4hcZj9K75Zb41mVoRWL8jZWzndQ0SVY0+G0O
	 O5UkvoFMnmfL3tNka6df5RB0Vtg2ZJ4oB+zo+C5XvvkJh1na9BDvq5jwGLHYQwHNZn
	 UHmzfg3N5YXU1BgPvdktrVDaZbRW6KqeNF5sb/GSGQLMp4rSGQFVl3zEKPk4ymb+fn
	 nR2PjmOapU5qdH7Wg2xPXzGwfJUtfzFPlUQ5UMKi70xB5hLDz5YXvXuVCGnN2QR9zm
	 pph19OHBCCmR3+JZlb/afLcLZypLwc/NiZ8MhvzXmS+bd48gD8Jsr7UrGhe9NzKmoJ
	 KJROYU3B7mACg==
Date: Sun, 8 Nov 2026 17:25:04 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Message-ID: <20261108172504.GH18859@horms.kernel.org>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
 <179405014554.994134.10719290719575125531@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179405014554.994134.10719290719575125531@kernel.org>

On Sat, Nov 07, 2026 at 11:15:45AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch fixes the SA reference leak in only one of the two
>   copies of this Rx code.

I lean towards this being a pre-existing issue that can be handled
separately from this patch. But I do note that taken at face-value
it severely impacts the reliability of the  teardown path and the
usefulness of this patch in practice.

> 
> Pre-existing issues:
> - [High] ixgbe_ipsec_del_sa() unlinks the rx_sa from the RCU hash table
>   with hash_del_rcu(&rsa->hlist) (line 783) and then zeroes the same…
> - [High] ixgbe_ipsec_find_rx_state() finds rsa->xs only under
>   rcu_read_lock() and takes its reference with xfrm_state_hold(), which…
> 
> --

...
