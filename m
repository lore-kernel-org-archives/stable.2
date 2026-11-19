Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795123455;
	b=gRX51OQIcuigsamBOxVF0FG+T6tzgFBf9l4TBIYKpfun/eD4D1jAPciimKL7y1Ws8kn3
	 wpgcHl3LvC7XJBLYC11N60LVOCPP+GnqkjBHjw54/C6rNr4nGEx6f+5lN8REauND6qE9A
	 DLh7Ei4zmiozjx4PTsQV2o7INV4MPCgc1UdgpQGpxzffWkDZz2VdD1gezJUE55H+dyI+V
	 yTEfPYtNLtILzoioa8PuZgm91yCaD7L0kv8Ao+joKIOYNOY/piz1emOPRyYdJWWTHPUWj
	 qw0STzF+pdCjs7+Ho63UAWNL4XWDZdGPQMOSGmUG7nyPJsHvo07jFSVkoLGaGlvZRcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795123455;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=4o1WwxWxpRB8UhJWCwwLn8HVjWB/mnjVMwmhpHPC3p4=;
	b=SmTU4UTBfYfvGHxZ87gGyDHnXRoSJvXILAlZ9s4YgupvHzJl3n9H2wfcz+GDrXyWxurj
	 /AYmMYGBL0mT7rqm7nf5C/dQN6BWGumANf6b6s72avXjG/Z7fXJAHVsibNdOTHgD15AjV
	 x5NB5WNMQaEO20IZ+XqTIyhEYmeAucADxeKK2B0GL0t1O29o7wlexxEpxysAz9LLlAZtp
	 muRv4oMu5rRxByvnW/voqHEnW7j0LDs5SKf/rU+JgEUeg26riuFWx1HmqSVUfklqXEfl0
	 rvciZQgZ208KwCSNwamENj3/YRIUkYBE+XthWna3nsg0uEoXiXAPrRqG0YkuZaZuwIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmDmkKj6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE86606A325;
	Thu, 19 Nov 2026 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmDmkKj6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C131F000C0;
	Thu, 19 Nov 2026 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795123455;
	bh=4o1WwxWxpRB8UhJWCwwLn8HVjWB/mnjVMwmhpHPC3p4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=RmDmkKj6giHitYkoiD0LE4hnFptcOfuP01uz5iBkAalmHplNmlAQNYQEWeXjyBCaT
	 +i85mhugFSi/8m7npe5EgDUX8Ht9O5FKH0Gk1Rwtfyx+1tI5DkDnY1r36ZojONdoip
	 imyICKbMHb8k4yVaMRfLNMt8p6MG4R2c86cGZC9/MzN/v8ofLkAh9qiGGP1M4O65nl
	 Gi5g/OVT2AMo44wgNDuR+QmAFHLJakCQ2a/DVtb619rGpX7ICRkz3AZ/T0d2z2UDhE
	 A1F88yVEoiBkzFDGwM8WDgj4L0orlED1X6BDAnuSUNrz8oMslOIWa4VOOMaLkdXqSe
	 aKOjRzhG7qAmg==
Date: Thu, 19 Nov 2026 22:24:12 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, 
    stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
    kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] HID: wacom: Access shared touch input by
 rcu_dereference()
In-Reply-To: <20261104010108.21895-1-ping.cheng@wacom.com>
Message-ID: <n28pnr60-p91o-2r9p-3s7p-54pn910qr7r1@xreary.bet>
References: <20261104010108.21895-1-ping.cheng@wacom.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Nov 2026, Ping Cheng wrote:

> Allow the __rcu-annotated wacom_wac->shared->touch_input to be accessed
> inside an RCU read-side critical section by using rcu_dereference().
> 
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610180015.KsRqmoTE-lkp@intel.com/
> Fixes: 9183319a5ba4 ("Input: wacom - Setup SW_MUTE_DEVICE according to the order of input registration")
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

