Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC848F010;
	Fri,  9 Oct 2026 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578286; cv=none; b=MLHwsN2FPgLQSi0LHTw9XE2lKHLa//bNoNUzfEZgTtIKElS2Mu0XWaJjBCznXt/Fcd/6sNLFet1puTDByCyNTyZ5ENnBuSvO8ySnjXoo+SEhzcR97h5L3eSVN74WvAkEDNxudI4KKcQHj7BzM+pV5C1TCzOHnIgB7Q0ZZAL5SNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578286; c=relaxed/simple;
	bh=YktzTOyfvWAmqwXJmdGMuIxjdvwEzwFF82hFEM943bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A72ntxrqGsEZv8O4iHJ6d1TDieNdLBLGCSRmOOdgHVKhfWdkb2Pvcivr3BYmCQ5n/lbh/zO31QefMT0DbseusRgvUaUA4z9LaPyvIQnM+C5fDSLykjd1ButCqIrm8oD7V5KRUGKB8O5gW51cmOqP6El55c93vj0lh51t42sMzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTK4emPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTK4emPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D001F000FF;
	Fri,  9 Oct 2026 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791578285;
	bh=AunY85NC2tuR3TivcSehZQCk3Ioj7yk6wgF6kC4VZK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kTK4emPZfS6GpLkto6IDLQqCJiq2Jji9n5vdQsj4b6CTPOJaoHkUWrIM8BrbP6KN+
	 sksWs/YwcLAyq5scNwmw9XYIjO2AOm8ljVFfaSyuA0UcJwlhUi0Soe3cF6l8SDUCoW
	 DE9TQ9g9nAnX2PPgUDmnmFRbggyiictYqBLpc3wH2VrTLGkbVSfYma3CTvW6HoSABK
	 ccakjJG/84Oy3id9DFmh8w0PrnCUviK8UrE6XoTCBIXQA/GQONOM0TPEaqCgmrHvTe
	 4nYc8JJ2SPWCP9HcJ280APOXWp/BmvF7PNMxiQ6W9cOgT0iqMDTWl0A9G2hKA9BYbj
	 PbdkCMR3r7+EA==
Date: Fri, 9 Oct 2026 22:38:01 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] lib/base64: Silence clang-24 -Wconstant-conversion with
 diag pragmas
Message-ID: <20261009203801.GA774682@ax162>
References: <20261008-base64-silence-clang-24-constant-conversion-v1-1-0858b60b23c8@kernel.org>
 <askdVfevxztHMyGN@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <askdVfevxztHMyGN@google.com>

On Sat, Oct 10, 2026 at 12:59:01AM +0800, Kuan-Wei Chiu wrote:
> Reading the issue comment in the link, it seems somewhat subjective and
> controversial whether the compiler should emit a warning in this
> scenario. I'm not a compiler expert, but from a user's perspective,
> it's a bit disappointing when we have to deal with this. When we are
> confident that the code is correct and have provided the compiler with
> enough context to determine that there is no runtime issue, suddenly
> getting a new warning after an upgrade is a bit frustrating. But
> anyway, let's go with this workaround to keep the compiler happy.

Yes, I 100% agree. I have tried to make that a little clearer to the
clang folks, I guess we will see where that goes. Thanks for being
pragmatic here. We can always revisit this depending on how the upstream
discussions go but I would rather get this rolling on our side now, as
our CI has been broken for over three weeks and has missed other
regressions in the meantime.

-- 
Cheers,
Nathan
