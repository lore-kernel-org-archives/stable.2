Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896837F739;
	Wed,  8 Jul 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505028; cv=none; b=aGxr6PwVNji3XD7yY+cDWrpSkmzrFQZYy8UsrjuRUWY7uipNYJD0De6gDCXNs96Aqc5eJCh/zlHWFNx3okY2Njv8z9mftYbywbNjMDtXmv+UjsS7/vcLqqyRosknO+1oTjePLjVBC7sDgBsIMHuHx9mtxiMaC4z4CgtrxJIuGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505028; c=relaxed/simple;
	bh=99VawtomK1HW3/fySWTZPlKvsLK3E35s/W95572iyQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOBSrFVXLGdw08FXlRQ1devwXquu0tbcOGFpnThYtXaZUrOguEUC4xb+4df/eNOLKtU1eHRDoMys0PstyxtLLefm16mRE5QqwyaI8UCYPbidbbdnLbZfnRUiXG6PV8C9tuhVZlLDJRGVEHqeB0g6l7/sCd/AsaDVVY6o3S6UdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 816D51EA685; Wed,  8 Jul 2026 18:03:38 +0800 (AWST)
X-Spam-Level: 
Received: from [IPV6:2001:8003:8810:ea00::9c4] (unknown [IPv6:2001:8003:8810:ea00::9c4])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 193981EA67A;
	Wed,  8 Jul 2026 18:03:36 +0800 (AWST)
Message-ID: <ece47e97-0287-4e83-b9fc-294407393f82@davidgow.net>
Date: Wed, 8 Jul 2026 18:03:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bug: fix warning suppressions with kunit built as
 module
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
 Albert Esteve <aesteve@redhat.com>, Kees Cook <kees@kernel.org>,
 Alessandro Carminati <acarmina@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 brgl@kernel.org, stable@vger.kernel.org
References: <20260708095459.12111-1-bartosz.golaszewski@oss.qualcomm.com>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <20260708095459.12111-1-bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 08/07/2026 à 5:54 PM, Bartosz Golaszewski a écrit :
> CONFIG_KUNIT is a tristate symbol but the warning suppression code in
> lib/bug.c is only built if it's built-in due to it using a plain #ifdef,
> rendering warning suppressions broken for kunit build as loadable module.
> 
> kunit_is_suppressed_warning() already has a stub for when kunit is
> disabled so drop that guard entirely.
> 
> Suggested-by: Albert Esteve <aesteve@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning backtraces")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v2:
> - drop the guard entirely instead of switching to IS_ENABLED()
> 

Thanks very much. Works well here.

Reviewed-by: David Gow <david@davidgow.net>

Happy to take this via kselftest/kunit, but if you'd prefer it go in via
mm-nonmm, that's fine too.

Cheers,
-- David

>  lib/bug.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/lib/bug.c b/lib/bug.c
> index 292420f45811..7c1c2c27f58e 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -219,14 +219,12 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
>  	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
>  	has_args = bug->flags & BUGFLAG_ARGS;
>  
> -#ifdef CONFIG_KUNIT
>  	/*
>  	 * Before the once logic so suppressed warnings do not consume
>  	 * the single-fire budget of WARN_ON_ONCE().
>  	 */
>  	if (warning && kunit_is_suppressed_warning(true))
>  		return BUG_TRAP_TYPE_WARN;
> -#endif
>  
>  	disable_trace_on_warning();
>  

