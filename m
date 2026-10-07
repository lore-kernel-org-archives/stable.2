Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB542334374;
	Wed,  7 Oct 2026 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336781; cv=none; b=JjY0Bcq7KN6kaYuNp8kr0ZQ9hho2KRaXBOGtJL+KCz+0d6yBmbth6p2eFJZA67RV2dmRbENQyHE8b5LlKVSObjjYL0JG34J1lZ3lVy+EDyWyf0SaGIE+1CT9LqODelL1k6mY0itwOp7tIGO2dhHewOn00+HtOvb7OA5bzEuuT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336781; c=relaxed/simple;
	bh=YP05KzIeagJ2youbYmtiU2EaIbEeJCuofif7wFVzynI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNBwYeu7m9+dXrTN9M2nzTm9W67gVBY+IqDaHDXO+6wjY+5ZQ6odSFF1P6DXMnW/m2442HuQ2kNfnTBn89OtF97pWBSG64CMkit1xCut+5EYqVdWLrdCvJmvPvYssZzRmcvvY2XaYYBdz6hrQz30PRrRZwSP/dlZ5u9OKHn8YQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K756IldR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K756IldR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3C11F0089B;
	Wed,  7 Oct 2026 01:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791336780;
	bh=LCgCNrcUTPh0ubv0G7P0dQu6mDrcyG6IEo2IPGK3xaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K756IldRHlywZZzVr6QneZ3kWboAJxhMvtr0ds8D74BRzW8bqGc4XpeFYznacHsRN
	 axB9CLQQg+uhzcwQRNDhIGGNwmFRExxVvOpMc9+RUpSnbnvwh43sf8vYkw7ci+I1ye
	 w3XWJjfGA2bGwr691LkFm/LA8nBq3+bfZXWv4fGXQSgSOn6jYvESxklhlad0PIn7Y4
	 gXLMcUcP4enUMX+Ps02T17ygW5oUK7tuXsMvLqZV/Gb6CW2QtmCmSUHG4KIxsCs7lm
	 f18GwDzS/Aoo2xbnSDXoYbYY2XkFU/xT9zTyey1IwgNDnCp2vKXu8EQa6npntfp496
	 e4xv4uf+wIWFQ==
Date: Tue, 6 Oct 2026 18:32:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] strparser: make sure __strp_recv isn't running
 before tearing down the parser
Message-ID: <20261006183259.02cc66b5@kernel.org>
In-Reply-To: <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>
References: <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Oct 2026 15:50:02 +0200 Sabrina Dubroca wrote:
> -	u32 stopped : 1;
> -	u32 paused : 1;
> -	u32 aborted : 1;
> -	u32 interrupted : 1;
> -	u32 unrecov_intr : 1;
> +	u8 stopped;
> +	u8 paused;
> +	u8 aborted;
> +	u8 interrupted;
> +	u8 unrecov_intr;

I gotta say, wish you held off on the cleanups a little longer 
