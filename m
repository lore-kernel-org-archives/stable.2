Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680333AD9B;
	Tue, 16 Jun 2026 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629133; cv=none; b=ZhnrY/0y/IEPy6u2LVBtDpaePmcxYVbS3WwA0amZ/u3cu2RC8FeQs8GPtS4d7e/3us7qP3s58bnmXTO6oiAAmJdCrCSm3U/3X24K3rP5ZvpEIg5LNocYvlEa7rKDECIUluDVWNId+Qal7zV+ORUFM8Di1NRqiMwWRJLeDMbb1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629133; c=relaxed/simple;
	bh=NOa+jErrqRQ9MsrhxeSAQuk330n+fUDgahzWLv2YT/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DROHjhcjhuypq11IeTvUxE6hdeaxNfcRLfIIpoIu9oJ3ceDbTXdceTNGjW4Rghvph80/qtP8K0AkFpCUNT9o3V9hmBnvoUt7hVUEjmQlKg1ezWlhpMdgjgA1qpH+IdgNiXp2U/vjpjavq90edmUxuDm5uQ9VyHImJVsUpY4XmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRWhfbGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRWhfbGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4261F000E9;
	Tue, 16 Jun 2026 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781629132;
	bh=dV8hOhSlOi61DCP5xtI7L3O3/t1hOJPAET4rF0DveJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FRWhfbGDnBCYZFp8lka20KY54w2nc5KLEQrwkZHK0br5hGxPmTuDCDBYOxBpbFWL1
	 D2N8t/YWJu/6qo87CeJ0dzQqbSooi+E++sb/2LNi9I0885aFVjSuBD0/RSoYzgTXmU
	 pCU5tZfIvKoRE2LeJJqljm+e8b+jXnGb6DPPV7ZLQ3mwktAPLZAqyZ9y3w23858hy9
	 EHxNROGSNQYmtzs/VirEbecx9TgfAaHS7lqWKR9kgIloHqk8IxOjhwfZLngBV4Lrz7
	 atv4MfPSW2tC5RcR8SQWojsRNJV8CxbKet3ROrAeO1m3hdhkf95JIK65XPLIP1UeXC
	 5EnMLlHFqmWKg==
From: Simon Horman <horms@kernel.org>
To: doruk@0sec.ai
Cc: Simon Horman <horms@kernel.org>,
	jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done
Date: Tue, 16 Jun 2026 17:58:31 +0100
Message-ID: <20260616165831.831231-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615114618.71249-1-doruk@0sec.ai>
References: <20260615114618.71249-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done

This commit attempts to fix a slab-use-after-free read in
tipc_aead_decrypt_done by taking a reference on the network namespace
before starting asynchronous decryption. It mirrors the encrypt-side fix
by keeping the reference across the async return and dropping it when done.

> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
> index 6d3b6b89b1d17..84a6489da0360 100644
> --- a/net/tipc/crypto.c
> +++ b/net/tipc/crypto.c
> @@ -941,12 +941,20 @@ static int tipc_aead_decrypt(struct net *net, struct tipc_aead *aead,
>  		goto exit;
>  	}
>  
> +	/* Get net to avoid freed tipc_crypto when delete namespace */
> +	if (!maybe_get_net(aead->crypto->net)) {

[Severity: High]
Could accessing aead->crypto->net read freed memory if the namespace
teardown races with packet decryption?

If aead is a TX cluster key, its crypto pointer points to the per-netns
crypto_tx structure. During a concurrent namespace teardown, tipc_exit_net()
synchronously frees crypto_tx without waiting for an RCU grace period.

Since packet reception (tipc_rcv) executes in softirq under rcu_read_lock()
but without holding a namespace reference, dereferencing aead->crypto to get
the net pointer could result in a use-after-free.

Because tipc_aead_decrypt() already receives the struct net *net directly as
its first parameter, would it be safer to use maybe_get_net(net) instead to
avoid accessing the potentially freed aead->crypto structure entirely?

> +		tipc_bearer_put(b);
> +		rc = -ENODEV;
> +		goto exit;
> +	}
> +
>  	/* Now, do decrypt */
>  	rc = crypto_aead_decrypt(req);
>  	if (rc == -EINPROGRESS || rc == -EBUSY)
>  		return rc;
>  
>  	tipc_bearer_put(b);
> +	put_net(aead->crypto->net);

[Severity: High]
Does this put_net() call have the same use-after-free risk? Could this also
use the net parameter directly instead of dereferencing aead->crypto->net?

[ ... ]
