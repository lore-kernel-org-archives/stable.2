Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BE1E832A;
	Tue, 23 Jun 2026 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205907; cv=none; b=jSH9vPJdewSGz0xMt4diI+H7FA/Rzula2b/ldQskxzOzT/goGCqSmd0dxQLfqNX76ZL3A8m97P7ATM7TXvzdBrkyX0w8Lbiuv22i1glmfGaswpFfWNWGi5qLxhQoLY3NRjNO/yhFmgIcDv+rnY6lyB6+bDfqaMNE1xNPEJkjDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205907; c=relaxed/simple;
	bh=X2KRnl5GpNyXLug8lTxyfQGxzlziXIzuqts0TorkuM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOrjZDlEA9ml6kHyVlDPdGbmJiRrgszUCQEVoXkumq+sLfeeWrbyJq9jglruT7Xi7Dk8g57oj6VK23LaDxE2c1WWcfkGAxNaGqyCSkLr9HJEdOUkvmOOxoSlBLGfsAGUKHyk/gLprRMZmfnwohiquHbv3U8hEqYOZ2hoKs/9oMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XLRP6UDV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XLRP6UDV"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 0B94E20B7169; Tue, 23 Jun 2026 02:11:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B94E20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782205902;
	bh=oV11M/7KggG59gtDIfbWlFffELRbonK8du94KMzOUoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLRP6UDV6ShSzRA0kSSd0fw7aF0coz+K4qVJASbh3RtC5V9gNfEOsPwdVmQRxUfc9
	 +q5IICdU9rhcdWFIPXtt+RwOxluOOoA2yTTkODus83+OdwbkWuHe9NG4zBASY4p8Kp
	 j0mozBglXFuNppb89TlrEHQwTyDb+SKMTzvbt59U=
Date: Tue, 23 Jun 2026 02:11:42 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 net] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <ajpNzozyQdWYyWlH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260619073338.481035-1-shradhagupta@linux.microsoft.com>
 <20260622182248.5bfc49ce@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622182248.5bfc49ce@kernel.org>

On Mon, Jun 22, 2026 at 06:22:48PM -0700, Jakub Kicinski wrote:
> On Fri, 19 Jun 2026 00:33:35 -0700 Shradha Gupta wrote:
> > Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> > Cc: stable@vger.kernel.org
> 
> If you want this to be a fix -- could you please rewrite the commit
> message? What matters most is the comparison before the bad commit,
> the bad commit, and then with this fix applied. Perhaps the three
> cases you list is that but it's not immediately obvious..
> -- 
> pw-bot: cr

sure, Jakub. Let me send out a newer version with this change in commit
message

regards,
Shradha
