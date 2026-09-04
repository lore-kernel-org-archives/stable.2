Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9E422556;
	Fri,  4 Sep 2026 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788550457; cv=none; b=SWErOYWW86eMOI07qWVf0NGPhW6Zr0kdZAdZ/xJdb6CBcNAG6eI3QEP9YmE3Ee9x71R82q5GywGNbHC/mkqUyuFkVYbG7tmxdIYeGmg6xp1vCBh0CSrPpJgHzphlohnew0sFE2ssdX1DN5rA+QsmrEx3mqhIkgzbik2h2/sci0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788550457; c=relaxed/simple;
	bh=ul2Pp845XsmKQL5GK4uGTi+u/lX7nZmo/2YJ5Kq7L3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcJgbrOY8G1MkYgV4BAX624iHuz2RMtHLyLUw7AHFghSWJqHZpvoES72MdLfNZZE8Ij0bKud8IvmPXqcndXANQaZ9fAS0mp7anFiTNrXrDf2b68xOQkZ3Vz+HL1hDCs1iOURvhhE5818jvZOVnkraVbD7A8xAaD+8ETpxDPeY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=RkDEoQft; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="RkDEoQft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1788550452; bh=ul2Pp845XsmKQL5GK4uGTi+u/lX7nZmo/2YJ5Kq7L3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkDEoQftAc6i3bh8mLGyHEPOoazbjCmA9oGyIbuUik5U5o5utl+oYIY0a2oBwS5mb
	 csRwSXCy9udULbg5wyavD3GQwoYdBopsNsgvWgwHhs7ryu5GSLPsAGvwUGjvUaPXs0
	 hIVCcvgsDPNVkgUs1UiMWEDhmQDD+Wi+sojTj+6xGBwlZkrEMthhPiCCwWhMcTSNxz
	 CIsK4GmX3iPmjx5ZJjwWjBN8z5NmMvRYtElg3RkdlvC2af7E7/Ox5GbtC24KDnm+Lh
	 WoFbPXA2WOPaf7ZPvUm9T5tivY4OzsJ9i9lqX9CetiV/+TOI4Mn5Wn55bQN8FZZ3B5
	 jFLIolKAgpdxA==
Received: from [212.42.244.78] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <n.schier@fritz.com>)
	id 6a9b1d34-2a57-7f0000032729-7f000001d982-1
	for <multiple-recipients>; Fri, 04 Sep 2026 21:34:12 +0200
Received: from mail-auth.fritz.com (unknown [212.42.244.78])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 21:34:12 +0200 (CEST)
Date: Fri, 4 Sep 2026 21:34:10 +0200
From: Nicolas Schier <n.schier@fritz.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] scripts/sorttable: Mark long_size as __maybe_unused
Message-ID: <20260904-dancing-cobalt-ibex-8a039c@l-nschier-aarch64>
References: <20260831-sorttable-long_size-unused-but-set-global-v1-1-8a96b88697e5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831-sorttable-long_size-unused-but-set-global-v1-1-8a96b88697e5@kernel.org>
Organization: FRITZ! Technology GmbH
x-ms-reactions: disallow
X-purgate-ID: 149429::1788550452-5FCA770C-C8D5CEF8/0/0
X-purgate-type: clean
X-purgate-size: 1785
X-Notice: Whitelisted
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-01  mail-id: 773A0A0389  external: no

On Mon, Aug 31, 2026 at 06:46:31PM -0700, Nathan Chancellor wrote:
> When building in a kernel tree prior to commit b055f4c431e3 ("sorttable:
> Move ELF parsing into scripts/elf-parse.[ch]") with clang-23 or newer,
> which implements a new warning under -Wunused-but-set-variable for
> static global variable, there is a warning from sorttable because
> long_size is unused when MCOUNT_SORT_ENABLED is not set:
> 
>   scripts/sorttable.c:452:12: error: variable 'long_size' set but not used [-Werror,-Wunused-but-set-global]
>     452 | static int long_size;
>         |            ^
> 
> Mark long_size as __maybe_unused to avoid inserting more ugly #ifdef
> directives while insuring the warning does not reappear, as the
> aforementioned change does not alter the uses of long_size, so it
> appears to be coincidence that the warning disappears after this
> refactoring.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This is breaking our builds on stable:
> 
>   https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/33143924291
> 
> There was a previous patch sent for this issue
> 
>   https://lore.kernel.org/20260603191708.27241-1-beakthoven@gmail.com/
> 
> but it was marked as stable only. I think this should be taken via
> mainline and backported the normal way, as it appears to be coincidence
> that the warning is not present in mainline. It does not look like
> scripts/sorttable.c has a formal owner according to MAINTAINERS so this
> could either go through one of Steve's trees or the kbuild tree.
> ---
>  scripts/sorttable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks!

Tested-by: Nicolas Schier <n.schier@fritz.com>

-- 
Nicolas
