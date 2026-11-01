Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793543768;
	b=T0Be4Y9Ys2GQu15ErMf5gOHYhqxzFCTbXKnwGIkdwsOAxDOP73J/A3VNg+/t0ctoPaHw
	 NUGMdTvPZ8jWmvwz2EAw6rWImmA29+m8J4atvjRiPtC8CngPu80xV6mMsRICS1iMK3Csn
	 l5oFtaO8fimT3N9LFSVKiMVunbs6oJbDhpAvrmz5QGZEx8ndQbH2nnUcezjdxArNxjMr4
	 xa7hMKpIK19Rxa4kNT45TrXmR21Rq2ud3kRi+vsnX1cDXn7Io1eii2+mqCyqEBb4aJCSn
	 7dNzFpOnFvKvCN+7+giHjnSJGTfr8aXR9rLkyLhJLaq0oUEOFfFd2ooc6mKlZmeOIKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793543768;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TtCuw5OAlejnbWX7yfP4jNY16ZvlKW+4tbQpuNqdmXA=;
	b=XpV8zor521LpO71Se7Jk9US/bP12/TAYwTXAFyLOdTr7l04TFCQRgVvYqv9aInwn3Gsm
	 aDmh7asMvo7h02Q+8T9jZoXVu+AWpK5hyhF1TRN8EIsza7zXp6iFss9z0tdn47yPkIeuA
	 K5BZ+UnWxsCGBlLbygatFfbnAdm9l569TJrKOCtRgbGogR5/tBhXGpUIJOl0g6cpi3j7O
	 6QIrFrxuWbUt300LS+1ZewFYXim/0qeTMb2hbmhggjXD0aGT9Dym4NmY35j+wzYUPdOcH
	 W4AzSpF/OPxcZFJyEtawUgFBmtk9K+S+up6PyfPoIHOiFH2fGTVABwS4nbhIAh30xfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72848606A325;
	Sun,  1 Nov 2026 14:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D141F000C1;
	Sun,  1 Nov 2026 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793543762;
	bh=TtCuw5OAlejnbWX7yfP4jNY16ZvlKW+4tbQpuNqdmXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2EpUlGehsCooSdemrOtmIMvmxUaMOZENo7P2UT3yKiyH/krwK2YBXh1/sOHeiC7nB
	 SN0LSdEHH9V8ybSCc4NlJRPp+eH6VAPs0Tig86TkJ4X1CU2AXL+G9Betc8nBc34y0h
	 rGpyzTupEdj3+sW7VhRbyP6F2quXV4caykXZbgBA=
Date: Sun, 1 Nov 2026 15:36:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mihalis Haatainen <mihalis.haatainen@bountyy.fi>
Cc: "Cc: security@kernel.org, Matthieu Baerts" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"security@kernel.org" <security@kernel.org>
Subject: Re: mptcp: use-after-free read in subflow_get_info() via sock_diag
Message-ID: <2026110120-trailside-subsiding-030d@gregkh>
References: <VI0PR09MB826157A34A2FAC52B1F1A0409D6B2@VI0PR09MB8261.eurprd09.prod.outlook.com>
 <2026110106-gallantly-footwork-3d9f@gregkh>
 <VI0PR09MB8261ACE161A38DACF76BEE2F9D6B2@VI0PR09MB8261.eurprd09.prod.outlook.com>
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
In-Reply-To: <VI0PR09MB8261ACE161A38DACF76BEE2F9D6B2@VI0PR09MB8261.eurprd09.prod.outlook.com>

On Sun, Nov 01, 2026 at 01:28:48PM +0000, Mihalis Haatainen wrote:
> Greg,
> Sorry about that, fixed. Maintainers and lists below are from
> get_maintainer.pl against net/mptcp/diag.c. Patch inline below,
> applies cleanly to current mainline.

THat's not how any of this should work, sorry, please read the security
documentation again.

thanks,

greg k-h
