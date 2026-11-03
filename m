Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701554;
	b=kvCD1LLbPS6DOyXnSbLgmusFA3jUYFjkilaHjbCvS2CJb3qHPNDkn7yuaCOO/ghBnDbc
	 aOA0Yc/VmVuT4LR9q9SsqWP57kkL3PlNt1uFijqKhVnlM51NCnDsI++vj/rk3TPzXq+Tj
	 wa7mmzrGCIMFttGSnK6r071UxsL9DQH3jbfIE0Je76YePzqB1tvEU40dUIkBAobWlk9ic
	 FwqbMxOZikBL+dl7wKWcX3gr5Ojxxznj9mTNQrGJ5b/ljPC/ZeFjIFPX60VuNLrkvEygQ
	 bkDnXGyqiAD6zMhwHj+1Q8H+nMr+pHJ7m2WgMJAv91Elo5l4yKKjJigdEnohD3+soqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701554;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xMnmfPB2x1ONdx8H/7UeU0nSjR+hb66yayecZ+DFW8k=;
	b=NlYjSbKhhDSXxzE08nQtGrFxXwXfljxaovfBTIkdLKCYqPwPnn0tdiO2pysIms2Alc39
	 N/zsaAiCK1RMCeEdnBJMF0U8q/6kDod3VdXvmZPvHDoT9eGG3Qc2wDi7cL5/TljTfwM1v
	 58Xbd5RlvHiNcnBynsgpn4VjCcbTyWQ4IF5hCF5WCFUxNgLEaWXU9ulgElW2EHZlarkBj
	 8CBT0zHaHWwYgfoeL+KTIgMZaYhIHD58jrKvzoDyk/gIz+RfdsB2/Ct1ku7yNaVKNQFo3
	 RQQMaQOSSVD0juJTATmDTmompa2mGtNPCk31cBifGJGniMJoZhpYhbnwhjZb5SQ1JzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhM18OIZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE78606A337;
	Tue,  3 Nov 2026 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhM18OIZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECB91F00A1B;
	Tue,  3 Nov 2026 10:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701554;
	bh=xMnmfPB2x1ONdx8H/7UeU0nSjR+hb66yayecZ+DFW8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EhM18OIZurDB9UMxnBQ2+8Y3bdlSXHVCebvL6B6JCwTJaui7KXf2IgyCg9tJekK7h
	 kghIfpSXgSlq97jcXy/B9/sdy86knrpvJU7SyLr5Xe5RJEljE2w21iFE2rbgwaBGBJ
	 xv/tAY3gm34kHV+t6XLP76+B2xi+fZ/ujXq6eHyFyRPnlImQOWpqz/ci776QsryziC
	 au5E/DHUdMQy9WRv3xFiKzCPwyLKxTytIoPe+pCNvfUYi9ac3V48dX1yuEcD1/bU4q
	 Hia0KTNcIGXd8uopntqp4eVDOGyffvZtLIR3AbElRaq68xLDTfUrpQZX2ymvFZ9wLZ
	 lH59lJZVAfvDw==
Date: Tue, 3 Nov 2026 11:25:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jijie Shao <shaojijie@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jian Shen <shenjian15@huawei.com>
Subject: Re: [PATCH] net: hns3: destroy the page pool if RX buffer allocation
 fails
Message-ID: <20261103-melodic-translucent-lemming-6abaac@quoll>
References: <20261103100533.1310018-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100533.1310018-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:33 +0000, Wentao Liang wrote:
> hns3_alloc_ring_memory() creates the page pool and then fills the RX
> ring with buffers from it. If filling the ring fails, the error path
> only frees the descriptors and the descriptor callbacks, so the page
> pool created a moment earlier is leaked.
> 
> The page pool is normally destroyed by hns3_fini_ring(), but
> hns3_init_all_ring() only cleans up the rings that were set up before
> the failing one, so the pool of the failing ring is never released.
> 
> Destroy the page pool on the buffer allocation failure path too.
> 
> Fixes: 93188e9642c3 ("net: hns3: support skb's frag page recycling based on page pool")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




