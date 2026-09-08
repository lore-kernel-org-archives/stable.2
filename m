Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8B3B3BFE;
	Tue,  8 Sep 2026 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788910627; cv=none; b=Xj/W3m0ZQBUGto48ickVTUwWWyLS/XghjymZW5NCpDLT6TtyWNaxShYXILWXSSOetfZvkZaSR2U7IhsHXoEIxkqlfdg1JUfAazDyfnTe1pDB9n9o986kEaV/6teZLOW9pOpoM8+L/dAvzXdjruAArSqddIUREJQ/uHzXKsRaAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788910627; c=relaxed/simple;
	bh=PmI5JYqDAr6kqZUNDONtc9Bkd3a2Pp+lpXvkLMJQeKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o93vmKjP4EN27u5n7BPb2xhFa7j6TlboVIllD1XsPf5OScfflUyM5DS+O3Ffnrm7pVqc3hzz7LM+PsYOXzt8ZBAV6gD0pmZcaRu56wX+/NtSgJ6ZzOrI3ZctABXJTyebNa2AXlos3sapmWLIJZJh1nYz10ncKhZex7PyStb2tIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN2w7uZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN2w7uZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06201F00A3A;
	Tue,  8 Sep 2026 23:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788910625;
	bh=NIND0ZuAk7r7GYUUeAEPwFBj/DONkZ4qN7mVygC9p7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oN2w7uZ4bZ9BL+HKcS8ScXRPFPke59x+bPP21lyXGXJgpoCJlkSUYGVvBg61tPu9z
	 /RSjkJNaOd5JMApP2UHiF5OgeiLu/zBTKzA9JEqJq2+B2iTo9/An4bIBtcckJ6PBqS
	 aCEzbTXofkCOfM5tfIInbL+/8xEmQBohzfXM4YHiVc6lpk7S9s+CKrDyKRZQskyO8M
	 7xJ+7pwDaWDe4qCCZGzDPtLx1Qk0DlH92TuIJTFLmtC1YjF6Mvujr9dDcND9qPUIi/
	 GrdfH0nvhsaMTXQAkZulIhvVfWOcDumNOXV3yR0yvr31trK4g6ZyhPEoC5ofNK3IaX
	 7EKbSn3HAHVhQ==
Date: Tue, 8 Sep 2026 16:37:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <n.schier@fritz.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] scripts/sorttable: Mark long_size as __maybe_unused
Message-ID: <20260908233701.GA2981326@ax162>
References: <20260831-sorttable-long_size-unused-but-set-global-v1-1-8a96b88697e5@kernel.org>
 <20260904-dancing-cobalt-ibex-8a039c@l-nschier-aarch64>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-dancing-cobalt-ibex-8a039c@l-nschier-aarch64>

On Fri, Sep 04, 2026 at 09:34:10PM +0200, Nicolas Schier wrote:
> On Mon, Aug 31, 2026 at 06:46:31PM -0700, Nathan Chancellor wrote:
> > When building in a kernel tree prior to commit b055f4c431e3 ("sorttable:
> > Move ELF parsing into scripts/elf-parse.[ch]") with clang-23 or newer,
> > which implements a new warning under -Wunused-but-set-variable for
> > static global variable, there is a warning from sorttable because
> > long_size is unused when MCOUNT_SORT_ENABLED is not set:
> > 
> >   scripts/sorttable.c:452:12: error: variable 'long_size' set but not used [-Werror,-Wunused-but-set-global]
> >     452 | static int long_size;
> >         |            ^
> > 
> > Mark long_size as __maybe_unused to avoid inserting more ugly #ifdef
> > directives while insuring the warning does not reappear, as the
> > aforementioned change does not alter the uses of long_size, so it
> > appears to be coincidence that the warning disappears after this
> > refactoring.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> > This is breaking our builds on stable:
> > 
> >   https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/33143924291
> > 
> > There was a previous patch sent for this issue
> > 
> >   https://lore.kernel.org/20260603191708.27241-1-beakthoven@gmail.com/
> > 
> > but it was marked as stable only. I think this should be taken via
> > mainline and backported the normal way, as it appears to be coincidence
> > that the warning is not present in mainline. It does not look like
> > scripts/sorttable.c has a formal owner according to MAINTAINERS so this
> > could either go through one of Steve's trees or the kbuild tree.
> > ---
> >  scripts/sorttable.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> Thanks!
> 
> Tested-by: Nicolas Schier <n.schier@fritz.com>

Thanks. Given how trivial this is and since it needs to go to stable,
could you take this via kbuild-fixes?

-- 
Cheers,
Nathan
