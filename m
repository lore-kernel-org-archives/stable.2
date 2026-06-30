Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EC25332E;
	Tue, 30 Jun 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782783942; cv=none; b=c13isEgbu7NDYh2qDz83v86m5IDQOoxepJvw2EW4ftAHOudzGvo8o6C6TyolvezkdIrWAP52h1QMEqncW0Ph8DVA3RUKqKlXtSYWOTeM958Ty044mHkM1tnxfQx4q1b/VbyeRwbAtrpNlRhNYi2pw4gRE6R4OMIemPtE36SVLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782783942; c=relaxed/simple;
	bh=D94q21odBhNf5SmUDYFZ7h+7mfurDN0SNw/pbDxsQNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGIgnMla0jcRUhKX51TOW2bWSFyngUHSfbAerBsW3Zk2LcdElYJ5ZVIWTZPtUtiit7XoL0zbV31zorVJs135hMPXBPLQI5ImktSuuemYd3uhq6QGK56AAi3OUvhnLbdjUhyejAu2tW9cSDZWonlm+1iytc49RG632wrLpLGpj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqtuBAKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqtuBAKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D021F000E9;
	Tue, 30 Jun 2026 01:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782783940;
	bh=kgpqgyIQx2BD+vAJtEmQ4KIj0mfEfZD8qoHQYPrvpj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JqtuBAKF4iG5BAwrNz+A6oRJJzs7RMs+uY/Pn/Ibmo0J5xgyV3eQxUyZehcb9x2Wc
	 Wh4Kyjyg91w6iDLAxtoZaF24Oob8Qgi1aaNsOHzo/E8vLHW2FoAy19DhfRGwETX5t/
	 anzl+PxjmuRoUoaVRNm2ujbmkIPhQc+1+MFORvVEjh4QflJWAETBVlQ4lmntovIAST
	 9OQjTSQXeralF4LuFUXItVuPHVuiIuLnGnItS14E4KBeC5kuovyE2NcbCk6jBqpctK
	 zDs/ikqHzo0y0ZQMjykAn2Yagm9jFHwq3CKF3XhLJx0w6bJhi7izCuFwZhfwnexZ2n
	 L62KmsLijcg2Q==
Date: Mon, 29 Jun 2026 18:45:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jbrandeb@kernel.org, richardcochran@gmail.com, amakarov@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn
Subject: Re: [PATCH net] octeontx2-pf: fix SQ resource leaks on init failure
Message-ID: <20260629184538.353a477d@kernel.org>
In-Reply-To: <20260627060350.2544241-1-dawei.feng@seu.edu.cn>
References: <20260627060350.2544241-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 14:03:50 +0800 Dawei Feng wrote:
> Subject: [PATCH net] octeontx2-pf: fix SQ resource leaks on init failure

patches does not apply, please rebase and repost.
-- 
pw-bot: cr
