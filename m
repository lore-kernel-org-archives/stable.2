Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343392;
	b=eHKUezXHE+DbD5NNjnXSugOXOT6efktu76b4I9hGRbcXCtuUneeMAlDZZ9L57tbkPLZA
	 8I+f428JVLbELZeO6GYSsfIA/IG0AbsrZhTUTJxkGFu6lCyzQADGEyfi2+DiSO/rDMxeo
	 ZjuS2dOEGt+uVpXFvGDzMVpp43FyV3LOqKAttJBCn6v4IYkGnzZzLOeKQdyKJriXW3gr1
	 nRYovPeNZF26ppwxZrhab6vDwwjUKofhwDWLbqYnSMK1s8Tpc/fhWkSqrbSIjc+BNfdnX
	 JXzVUnc0EWI4wFU/1CLbXFtr5/jOp0Q1kVhBOFklxVZvBYqwo3zOmR86Jlfkg75SOwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343392;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rUjkintENFjczb0yzi4H2OiT5338qC8kzJyM2nN2AD0=;
	b=T8zmGxSEtNteQEyMT+nE6N9ocJaOZC0/AkEpJMR0rJqwFzQeOCza9ljVHul0rPvApdNi
	 gKVmCwEo0NqpFGANjcxp+fc2e5HKqhIp8drh+IJl0hPQwDc35PkRtyTX4ShyR0L23V6dm
	 GmyMWL0KiZpxnKd0mmMANbsYX3BQgmky+qelbOFekpMNwRsk/CefahpRMj2nkkNlCFHt2
	 e4Wtoo0VISICCaNfs0L4hON8kvC2bqFfl6j9PbZWpzo0R5CJXaLb/ogtrixKGZuUvE4gr
	 RVn8BTRSHd490iyCpRqLUYHQ5bKDBIp8OR7mSzoKwW4J/6oIOygcD3u3WABwXjuHMJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KQ4SSOJ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B3606A320;
	Tue, 10 Nov 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KQ4SSOJ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3671F008A1;
	Tue, 10 Nov 2026 20:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794343391;
	bh=rUjkintENFjczb0yzi4H2OiT5338qC8kzJyM2nN2AD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KQ4SSOJ+iGITna1hDhGVHrxuffra82Iyq2TNo2Ym+mps5PDp6UU5A9ohk6L60WGni
	 i5DysZIA3OgIUnLf+Z7aUC7cHdKKhpLdss11RsbMhCe5M/Z5gc5ZcBJD8uRCerHNsh
	 Wq8YyG3AYC4CB4Pddb7v2k6oh/Y+o1T7SPA9fSnE=
Date: Tue, 10 Nov 2026 12:43:10 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] fault-inject: fix boot failure with fault injection
 boot parameters
Message-Id: <20261110124310.47c2e447b5726ce39b6dc56e@linux-foundation.org>
In-Reply-To: <CABFDxMGtYLFSiCLHsXn_ihG3cv-oCgo01FW6e+9aYN2gvM+W_A@mail.gmail.com>
References: <20261105160209.1504867-1-ekffu200098@gmail.com>
	<20261109213346.634e83b158ee7086e64f9cd5@linux-foundation.org>
	<CABFDxMGtYLFSiCLHsXn_ihG3cv-oCgo01FW6e+9aYN2gvM+W_A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 20:36:54 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> 
> Code description is correct. But we can easily find how the code works
> without this description..

Yup ;)

>
> Andrew, is it okay to send an extra patch based on your suggestion
> with your co-developed-by tag?

Please do whatever you prefer.  There's no need to attribute AI stuff to
me - I was just sharing in case someone found it useful.
