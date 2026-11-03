Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701541;
	b=DoiAE0s/32vWgNynkEWI2oLQVvOZ1Lw46VIOGdJlsnDnJhrokPZhz+qGPbH1dAJZMDb3
	 7KutFZin1RhgvRfU11e1gAL98YLLNWef/LOfge97Ka8gjU3Az2r1d/FV78DEdEhuK4Ufp
	 gEQiIEbtWFMxWGT9MlQMhaYqXCKyBFWAGItaXQhWNEki7Pwi8QCup7hiZ2hHeWs5fqfqy
	 /6A/Jm1t/kZNjDvbCeRJ94I+nl5TfG0t5guOEKeALwiQnJ/5Q7bclGGytjAjsCxshUXGD
	 yefeYiO6NIoAAjiKfPEfMirajYLEphYy5t4/sBWmeSkAVYKKJxxKFL2UgmOrQBqCG7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701541;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=s09cCW/s1X0J7CJ+rjy7aM1fbbviBPnk1bCW+56V/Ro=;
	b=D70YVG06huTdqTwr5si5bQdJ1fM/KFGB+fWRTA9bBkHsvZ6AsWkrkxkVm+bM2JgR+luv
	 S3ANumf2U8mDEvwV/B+fQozrDOtwBZf0TVZP3M5rA2rbwi5ibqQnsxmvhjMSNBdtx7iul
	 q4ivBt+XmET/dIkivXHPBeDQJ+Dwb/2hZ6YaWSEIal9AxXBl8A/QHrNIAepBCSwuXknT+
	 JnOWgYs8OCfj0nG4K1KpCyRsCmtJdNij5Z51pquH5J/B1Xnb58k9MHA1q4565mk2qI4rH
	 jUMn5xWG+reOwAU637MjqtQq1o/5WjMuLNkzwvJEo1UsBScFjnbNjPuY/w2+z2uQewA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfSdkhnV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21C606A335;
	Tue,  3 Nov 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfSdkhnV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16C01F00A02;
	Tue,  3 Nov 2026 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701540;
	bh=s09cCW/s1X0J7CJ+rjy7aM1fbbviBPnk1bCW+56V/Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bfSdkhnVwkhceDHXC74zgzm/aZWlTICgn7pULQ8atfWCJaY0TqWDu9Zr3PwnVGB+O
	 2qmpPlQ8tAfl9Ig3ipx9Wr9aoOuwfn7cUuRrJfMafRJIol0Gyj2JZCCTksqR5SKDOa
	 5RAAHDmm11w9t7Sq1v7+L7+pl/hxv450c2Nc3C00GK+BnfvLNAvphy42l+fvYyPdEt
	 /uHcwef9giEu6vXag0J9U1rOgWxhYM+IgK/JFUFx6tLfNbkV5HuoA/+EyIEBHw9yB+
	 8ffmej69zT+RdQEDCBUIZWm6+22Oxleg6nrMMWtytYWQ7EQadbEYFoxlsBbFPK8fNt
	 XgC8+ZRmbGG6g==
Date: Tue, 3 Nov 2026 11:25:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] net: mvpp2: free pending TX timestamp skbs when the port
 is stopped
Message-ID: <20261103-poised-ambrosial-trogon-17f02f@quoll>
References: <20261103100535.1310088-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100535.1310088-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:35 +0000, Wentao Liang wrote:
> mvpp2_tx_hw_tstamp() takes an extra reference on skbs that need a TX
> timestamp and stores them in port->tx_hwtstamp_queue[]. The reference is
> dropped by mvpp2_isr_handle_ptp_queue() when the hardware reports the
> timestamp. Nothing drains the queues when the port is stopped, so skbs
> still waiting for a timestamp keep their reference until their queue
> slot is reused, and are leaked for good when the port is removed.
> 
> Free the queued skbs in mvpp2_stop(), after the interrupts have been
> released.
> 
> Fixes: f5015a594c50 ("net: mvpp2: ptp: add support for transmit timestamping")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
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




