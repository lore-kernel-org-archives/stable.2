Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4A308F39
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206779; cv=none; b=Ylrtl6gY5AY9MfOQhbKEboZ+1nLaFdKu6xzrWFyqk5YHfLNPnOl82qYQuRzMXRqhi9Yra6e3YRCC0a8PEF09agGInLDPzViELsG1ud4NNCFp6KFZbNpEV7dXTSxv3CIlGdVURwob2+8MO1GevtOo5HD1MR5cN1v6l6JSWMMy6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206779; c=relaxed/simple;
	bh=dPPmbZJFJxzrWYSDuXE7kGzcSYpHD4ORg0AHFTCWQ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6MqZ1I7AgXpCvZLTrZ0XqECmlxL649EhGg2tvBjDGbtqWx8GiUHJCLjeU378dTJXiXSpAirsyiLMcxgfiCB79WDAT4clq2NjsEeCwnLnCaIiIUZkQT903+lVdsF22Zh6E0KniRwjawJaz/U8bTeWLE/dSzpKUNDSlpg4OPAeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T98839EH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T98839EH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3169F1F000E9;
	Mon, 31 Aug 2026 20:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206778;
	bh=iwyqnNP5Y/Wz+bMIA97jmI11l80IXqTUWKtdOJQ32PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T98839EHa49kysVpJ9Xb97ObglTnVznVKjqIiUpTgyEEO5dvawxqPockgtz+MaZQ6
	 l0OoV7IaWFTTYZ9omKrVO1Ojekzs++OWrxlGIRF+fLJqqOOFh8/chHAMHBi+861vrx
	 j6Rk3WuPeypiuNuSoxIHMQzW/UbXA2bc04L+EXTbiwjIPtmm58EPIqa+oZgF7hqsHE
	 JIxzyklPEujrbp+TasWlpuks1zkyJY/H07vdKc6CYrHgs4Wwyj5PyE/DWyWJp9soa7
	 UEgxxf1p6rz/Q0+7Sh5BKZzYGuIhRVdLSmaPOZJ6OPQ854OM1bZVB7IhgIu7E+utvy
	 s0R9KPrN8AS+g==
Date: Mon, 31 Aug 2026 13:06:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: gregkh@linuxfoundation.org
Cc: dmitry.baryshkov@oss.qualcomm.com, herbert@gondor.apana.org.au,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] crypto: qcom-rng - Remove crypto_rng
 interface" failed to apply to 6.12-stable tree
Message-ID: <20260831200615.GC86114@quark>
References: <2026083146-squatted-debug-8f6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026083146-squatted-debug-8f6e@gregkh>

On Mon, Aug 31, 2026 at 03:00:46PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 2ecdf5c9910e20f73639bc322f0518a3439d17c0
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083146-squatted-debug-8f6e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
> 
> Possible dependencies:

This seems to have been added to the stable queue anyway, despite the
FAILED email.  So it seems there's nothing more to do.  Also, please Cc
the subsystem mailing list.

- Eric
