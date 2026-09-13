Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070A3A1CF8;
	Sun, 13 Sep 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294093; cv=none; b=dvNTHioEtcue7GcJ90vRrdSyGfVl1/SAI4H2Q6AmHLHVcxgxqgKOcmNeqaeDPP9rwtzBwthGMwHt/fBPoq5/dWISnWmAlInT5bFO6NaaZ64ZdVvGOMZ3+ST0WNIx8yqo0HchQjxdlE2oHEMlHTPKnMrHBhwSQBAN/29GxseRwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294093; c=relaxed/simple;
	bh=Gb3/zPNzOJ8+HmL/pQCNBADqxfw5DDZ1QW3EE1KcpaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXC/uIehPTMDb9DUMJk1D2Y+6GB9K+LXbyDRSs6sDD6ntwhOUe2nFiHFgKjk08nMJJrWkldD4iXUadGByBAZDGsummKUbijTbGkbGR/qfOLQKiwvPr5LfeUvboCOECTUFB3lqTuIl2YFMud62GCMRpWNS9WOWAtScmgGWNYdYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4hjP1Z6y8nz1sQD7;
	Sun, 13 Sep 2026 12:01:06 +0200 (CEST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4hjP1Z4gNZz1sQCr;
	Sun, 13 Sep 2026 12:01:06 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4hjP1Z31lpz1qqlS;
	Sun, 13 Sep 2026 12:01:06 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id G3_6kDhvQpuv; Sun, 13 Sep 2026 12:01:04 +0200 (CEST)
X-Auth-Info: hZuWXuxmAMBF4jqiz3eCx+bgQlFm0g8Ams02iyN9wMj+of5Sae1sjibNaS2ZIbBu
Received: from igel.home (aftr-62-216-202-155.dynamic.mnet-online.de [62.216.202.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun, 13 Sep 2026 12:01:04 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 9FE472C09A5; Sun, 13 Sep 2026 12:01:03 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christopher Lusk <clusk@northecho.dev>
Cc: Greg Ungerer <gerg@linux-m68k.org>,  Geert Uytterhoeven
 <geert@linux-m68k.org>,  Kees Cook <kees@kernel.org>,  Andy Lutomirski
 <luto@kernel.org>,  Will Drewry <wad@chromium.org>,  Michael Schmitz
 <schmitzmic@gmail.com>,  linux-m68k@lists.linux-m68k.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] m68k: Fix seccomp filtering on ColdFire and 68000
In-Reply-To: <20260912230651.461269-1-clusk@northecho.dev>
References: <20260912230651.461269-1-clusk@northecho.dev>
Date: Sun, 13 Sep 2026 12:01:03 +0200
Message-ID: <87y0d5a2sg.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sep 12 2026, Christopher Lusk wrote:

> diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
> index c257cc415..093be0a66 100644
> --- a/arch/m68k/68000/entry.S
> +++ b/arch/m68k/68000/entry.S
> @@ -81,6 +81,8 @@ ENTRY(system_call)
>  	getthreadinfo
>  	btst	#(TIF_SYSCALL_TRACE%8),%a2@(TINFO_FLAGS+(31-TIF_SYSCALL_TRACE)/8)
>  	jne	do_trace
> +	btst	#(TIF_SECCOMP%8),%a2@(TINFO_FLAGS+(31-TIF_SECCOMP)/8)
> +	jne	do_trace

Perhaps it would be faster to combine the two conditions (which jump to
the same target) with a single AND?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
