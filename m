Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BCD1A682A;
	Thu, 13 Aug 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632573; cv=none; b=XDW7amDBBW/thoM3OCG1+Gl3yf3PXbh4gAkFl7Xh8zIVVVTYxFY67vhe7D6w5kANSJt+4pzBo6czSP6CwxH7D51SKMtz6NlF0TuucI/EGery4vK9VJW/v0DrddN/yXhFQIEIg5anBvIOhs9kwDLNykwrPt9FXT77iAwgdGemaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632573; c=relaxed/simple;
	bh=i2Lf0otTxzL7ZXq7oLVeJkeS3ELMENmBrm6aELALQ3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsCfWkaxzYa8W63Go8wLycOajayejaAgs8O7jUlEZMgwGCar5MsU9XY56Pbz/IqPo28LOYJ34sIMlFvEBjoPHcU5WtYJ5NxXTeLu906Gm2FqerFxgu+gbOmZR7CSLXzqv5faqGgP6ktskVdvnzAkOkfHD2R6RKmWZ1QXUNw+97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lQKQfDoa; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lQKQfDoa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i2Lf0otTxzL7ZXq7oLVeJkeS3ELMENmBrm6aELALQ3M=; b=lQKQfDoaauDXshUnlMkwJxHMQO
	wAjgykvLV49ACjdokVfd1y+am1ZmQks/L1XJi8+wi6PTHNUp2KEPdJCzDQrvujUY+NdGMUipZQOeq
	Lb2qdTA6JgWezGRw04JDm7uW++nCb7H4iY25cG659adSElW91+mRUScWP80KfhprSuMbPYIwSqtUW
	DR7wAuE1JCeEJ0T1v3h643airYaaT9vPrbbroWpIJN/BDUakg9f9vUPk5XxgfaLJW34hVpjRI8KSW
	X5gT2vheXhByXfZwN5W9Fi9Lon6SEzu7lVP4XyRbRy/ISMd2tHJ6NoTAOryrhFs4RADO6DTLdTu2Z
	95QuZ1nw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wuWkE-005BZQ-0y;
	Thu, 13 Aug 2026 14:49:22 +0000
Date: Thu, 13 Aug 2026 07:49:17 -0700
From: Breno Leitao <leitao@debian.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Message-ID: <an3Y2JUyT-DNcYar@gmail.com>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
 <20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
 <20260807174402.2dfc12d6@pumpkin>
 <anm9gImFEz6EkUZ9@gmail.com>
 <20260810222159.409357fa@pumpkin>
 <ansQ8gHcKdS_Q_ji@gmail.com>
 <20260811081543.26d18828@kernel.org>
 <20260811185127.0343b75b@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811185127.0343b75b@pumpkin>
X-Debian-User: leitao

On Tue, Aug 11, 2026 at 06:51:27PM +0100, David Laight wrote:
> I would suggest (again) that these changes be done starting with the syscall
> 'glue' and adding an extra getsockopt_new() to the function call table(s).
> Then changing the protocols one by one to provide the new function and
> finally deleting the old entry.
> That way each protocol code only needs changing once.

Isn't this basically what we're doing today, without a new syscall?

> I'd also wrap the copy_to_iter() in an inline function so that most code
> doesn't have to care about the implementation.

That sounds doable. What would this inline function look like?
Would you mind sharing what you have in mind?

Thanks for the discussion,
--breno
