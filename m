Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5419C54E;
	Thu, 25 Jun 2026 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354316; cv=none; b=BKMcCR5Vlfu4UYQUPT3wPCeLJqh34MH9m7NwD3TjR7W63ZxrQxRzReVnpq/CMNx7lgp+RVVyNqvgMGv5urWOkCQJP3u1IIq59rJIQsHJeC60Rfj9BEvT2qFeoAmwZkneGty4tN2IpJtUVVfwjfTM7Qh6JpBz2oAZjONH2dDTsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354316; c=relaxed/simple;
	bh=fNNJnh667D4SGrad3vyQ7ShgISCq7vKlq7l3BQhOo8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beQFOR7XjReEGKPq0sTnp9xC4h2jR8+5B31993E6e7z781bMV1dDE20rKLnXq42xhmYnhrEax4ir1jPwf4YKzuRAwpPrWTbXgH5G5tzER71fBkK0TgPrAtIt9lJlNjoS1PzDMs06csCouMhmfLqLajCEuYvahXMNunJo0X0iG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhzAUM+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhzAUM+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449C01F000E9;
	Thu, 25 Jun 2026 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354314;
	bh=tGSgxbQOZ/A/Rx2qFngn3z7HrOY74eUjampP2chvJqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VhzAUM+yQqbkWsU/q0sNWkuc3rOVIrO3s4DOLtGKCfMjSFNHUuJMRK3z2JRDDhjs1
	 GSdnuNMzSMXJs+FT+JPvW/No/ZAL8Si7hlOxBs5nJY/PcWLWzadmrKSG9jSD8fQUOw
	 gnbrZaK2n1SVU0BrAKtcJJy1xBHgKM13TqvHKPsGeNNgd9oj0M0q8I+LUzby5XYkNc
	 RvTLEXMy0S4uT1yDzurCf95S0hA/dT6CkmEC/HQFedQmORGCXD9/tFNInmsjJnOmJP
	 /zmrzM90mb0a+1LY5aRf4m8JDYMzaWfO7iT3ejRFFpSlu9eH+WvGBGfbhhnsx5Ogvv
	 Yykm/b407/77A==
Date: Wed, 24 Jun 2026 19:25:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Amerigo Wang <amwang@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vlad.wing@gmail.com,
 asantostc@gmail.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net] netpoll: fix a use-after-free on shutdown path
Message-ID: <20260624192513.33023e54@kernel.org>
In-Reply-To: <20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org>
References: <20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 08:01:23 -0700 Breno Leitao wrote:
> +		 * synchronize_net() does not protect the worker
> +		 * (queue_process() is not an RCU reader). It fences the
> +		 * senders -- the real RCU readers -- so they cannot re-arm
> +		 * tx_work after the np->dev->npinfo was set to NULL.
> +		 */
> +		synchronize_net();
> +		cancel_delayed_work_sync(&npinfo->tx_work);

Maybe we can avoid the sync_net and the comment by using
disable_delayed_work_sync() ?
