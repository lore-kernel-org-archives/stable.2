Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E84A4836;
	Fri, 16 Oct 2026 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155021; cv=none; b=HlyJN2p1KejBu8A2BmFR0rXM7AerQP5GXTklPq2l6tz2uKPokNgR5IJU+2yw5hCoTrAGFWdnasCXtzB9H8HyJYieCyQiUKlhVH+T0bM0iY3nSXTWDO86HF8SSJrt9kDQpBxGfHgsP6x+Q0wDe5hI9rcGMkIXkCMtKO99g4ZLpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155021; c=relaxed/simple;
	bh=qKqkBlzuhzGDRUMe/fpdt9YqLvt+//yIo/tc4unfU9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=untjnQoxdZ1w4GucWBrth/CNfInC7LCPnA91oHj8BvC04E+LGEOl+ehhb5lGiBIX/fsR+WJu6A4SFDmseiQNDPJghUEmnB7bL/r8f3NH6p+SftA2qB6deBLH2zWPxr+xp9c0lEgj5oxGmWPZxbeh9f7yDrq5Jq3646GE950vwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=2/NjAVX9; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="2/NjAVX9"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 71DFC1A03F1;
	Fri, 16 Oct 2026 12:50:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 456626000C;
	Fri, 16 Oct 2026 12:50:06 +0000 (UTC)
Date: Fri, 16 Oct 2026 08:50:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, maz@kernel.org, oupton@kernel.org,
 kvmarm@lists.linux.dev, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v1] tracing/remotes: Fix TRACE_REMOTE build when
 TRACING=n
Message-ID: <20261015180004.2f7da6b9@gandalf.local.home>
In-Reply-To: <20261015112814.332084-1-vdonnefort@google.com>
References: <20261015112814.332084-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 456626000C
X-Stat-Signature: e5qr4q1ej99h7j4dzuw63ahkdrw36wzt
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19G+JyMcFu5/yHZATxzznAdFi8WUYXiNOk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=9nmW7sQ0t25U+FgT2eKiTRK8REkWMAfVAFLVtrkPv/E=; b=2/NjAVX9tWfUGk67YzdKFIz5v94pyPF8ZICYhiJV1zcK1C3RGf1fLXacFTrRUuOfevXv6a0svEecxfLE7khhxrLAeNl4XuqjLG+lSGeaiGNBLeZHjUFSStr/oUveyl2qxDbWcu1un+GJ2Hd7xIaym1UI9yXKg/xIY7ian2TZpSI=
X-HE-Tag: 1792155006-3091
X-HE-Meta: U2FsdGVkX18mly2Uv4cUx2B1eIyDr9rJ+2Lxe5r4CR0HcwTwPmv3pvIqGd+mqRSbO7hMWuHUKINtnv1sfU+62+3uM6BgA1/I4prCMwSIr4DUrAniDktwTBNDQ7FYmTwcq4olH21Z9LRmRRgN1abxl/krqEqWIFCzVWYOk3W9PHROXuTPB3dEEA3ALC2Dg17PzTqqnjBSCveQZILiuTAXwyy7qSKXUn6422PPBYoPBpNiFelgNLzAnhNYin51BT5ut6bVzgvoBNYlTpdxUeGOXnWzeV8Rwru9o4GOpSSMZSx1uGM2Oo1x+8QO3dWhGey41hdskym1Rp0kiOUQXpaqAeORqLYih502qfSSiStK+WGvBMiuwCPCiym1fFsGZhkhqUkAu84Auob/HEKxG3KSVzElgMF/ISzK2yrRtv7k44od721KDEx1dtNI4GeMNChWxdt3YYGoo1I=

On Thu, 15 Oct 2026 12:28:14 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> TRACE_REMOTE relies on tracefs, eventfs and ring-buffer which are only
> built and declared when TRACING is enabled. It is however possible for a
> config to have FTRACE=y TRACING=n and TRACE_REMOTE=y.
> 
> To fix this configuration, have TRACE_REMOTE select TRACING directly,
> just like other FTRACE options do and drop the TRACING dependency from
> NVHE_EL2_TRACING to avoid a circular Kconfig dependency.
> 
> Cc: stable@vger.kernel.org
> Fixes: ea908a2b79c8 ("tracing: Add a trace remote module for testing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610142301.GBepPVmS-lkp@intel.com/
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Acked-by: Steven Rostedt <rostedt@goodmis.org>

This can go through the arm64 tree.

-- Steve

> ---
>  arch/arm64/kvm/Kconfig | 2 +-
>  kernel/trace/Kconfig   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 449154f9a485..e179b8ad79e8 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -74,7 +74,7 @@ if NVHE_EL2_DEBUG
>  
>  config NVHE_EL2_TRACING
>  	bool
> -	depends on TRACING && FTRACE
> +	depends on FTRACE
>  	select TRACE_REMOTE
>  	default y
>  
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 0ab5916575a9..6587450cfcd1 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -1329,6 +1329,7 @@ source "kernel/trace/rv/Kconfig"
>  
>  config TRACE_REMOTE
>  	bool
> +	select TRACING
>  
>  config SIMPLE_RING_BUFFER
>  	bool
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

