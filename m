Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE44BEE5E;
	Fri, 11 Sep 2026 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169245; cv=none; b=aNe7Gl899cD0SgtbHNktvwV63kDx69bp3hAAVllX3I8qg+bKQmNRj/TWdsfqck7mmZLSB7iz88wiLKEsIpJD7acQ4psuSs0lNtXSFAs15QNOG630K4F55z+VLjHyGt6kwC8UharINBIB9O2p5TaekLSDUZLEb/HjoWlqDwYt3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169245; c=relaxed/simple;
	bh=txwkjZR5uhSGrgvEw04tIA/LZ+8vARupr2LkHK4DrP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3osQoBR2VINhvNtxCGXbnLTbDvHsVy4V8N8hbj+Qsf/dRyxGzWtucEbVUhiaBMpryVpOyfKT79ZBUEp3yHVSsQlSqs6yNeCA1lLWoyNY4eDoClhwVN/gHZ9IOgbde6GTi7FEX0tzauBLSHhE7ceFfoTVtSoAKazgUz/PZlE9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPmRsJsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPmRsJsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BBF1F000FF;
	Fri, 11 Sep 2026 23:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789169243;
	bh=iP6HlC/Z67nOWKohbG54L0qbVAkSweHxblnJSAUpQJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cPmRsJsxydZcW8QAfsyc9MLmE1/XaKT+cQenKHs4R9NcVg3VUyPSa+Une9POO6hkh
	 6qsXCeF6trrPzr9vTrUAaWSsqfeOaUUtiBR0P4ZfBaGEEymO7U/O6pEWgSoxLjy4Na
	 mk/ohgsipeYwu91etgbW1FWr2KChghrkrsinyN+2vBKVdnAWROy7R2rRqgWUS1CD2a
	 qA9Px1s8ohe8iLn3qEWMfCBe/TtlgSq9mzIfSX4YirIRxo2HaQV3BNnaZLUrUK2/BA
	 ntrkfg1vw+7N2xXyh+sT6pttu0EK6DbX8h4SwxKKfBhzKvO3klSfxyp+y2lHfmpqSR
	 tJadGnGcqCiqQ==
Date: Fri, 11 Sep 2026 16:27:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vega
 <vega@nebusec.ai>
Subject: Re: [PATCH net v8 1/1] llc: fix listener child socket leaks before
 passive open completes
Message-ID: <20260911162722.6d6a40e7@kernel.org>
In-Reply-To: <abc8b115321dbd417b8491d9e51f1988998ff50e.1788707641.git.zihanx@nebusec.ai>
References: <cover.1788707641.git.zihanx@nebusec.ai>
	<abc8b115321dbd417b8491d9e51f1988998ff50e.1788707641.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 03:47:51 +0000 Zihan Xi wrote:
> +			if (atomic_read(&llc_sk(newsk)->incoming_state) ==
> +			    LLC_INCOMING_PENDING)
> +				llc_release_incoming_sock(newsk);
> +			if (newsk != sk) {
> +				bh_unlock_sock(newsk);
> +				local_bh_enable();
> +			}
> +		} else if (newsk &&
> +			   atomic_read(&llc_sk(newsk)->incoming_state) ==
> +			   LLC_INCOMING_QUEUED) {
> +			if (newsk != sk) {
> +				local_bh_disable();
> +				bh_lock_sock_nested(newsk);
> +			}
> +			if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
> +				if (newsk != sk) {
> +					bh_unlock_sock(newsk);
> +					local_bh_enable();
> +				}
> +				goto out_kfree_skb;
> +			}
> +			rc = llc_conn_rcv(newsk, skb);
> +			if (newsk != sk) {
> +				bh_unlock_sock(newsk);
> +				local_bh_enable();
> +			}
> +		} else if (newsk && newsk != sk) {
> +			if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM)
> +				goto out_kfree_skb;
> +			local_bh_disable();
> +			bh_lock_sock_nested(newsk);
> +			if (llc_sk(newsk)->state < LLC_CONN_STATE_ADM) {
> +				bh_unlock_sock(newsk);
> +				local_bh_enable();
> +				goto out_kfree_skb;
> +			}
> +			rc = llc_conn_rcv(newsk, skb);
> +			bh_unlock_sock(newsk);
> +			local_bh_enable();
> +		} else if (likely(llc->state > 1)) {
> +			rc = llc_conn_rcv(sk, skb);

This looks pretty terrible and incomprehensible.
Clashiko has some comments but it runs out token budget trying to make
sense of your code:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/abc8b115321dbd417b8491d9e51f1988998ff50e.1788707641.git.zihanx@nebusec.ai
Which again, strongly suggests poor code quality.

Please do better, or maybe post a patch to delete the LLC sockets?
There was a person mentioning using them in recent git history
but I emailed them a while back and have not heard back.
