Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357038F49;
	Fri, 10 Jul 2026 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642928; cv=none; b=MZP1RjqltR50W3MGpcXzMdo2pbq3TmTLe892MhutrEkgBM74j8rvwvpRMNR2REg1nFNLao4GDAwuVZTWiO8YN2eD47Cwp20FrSYZrW5kXBqwt5cBvsFLx+L6lhjDGDrJ4V5RMCpHdHndvvgj21cZPa1ohEx9Y7xlSp0MuRoQCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642928; c=relaxed/simple;
	bh=opgJIFordh+M/pxvBiI4T1kMfINnO9SjvLQvned9g8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2sP3ZrPS/WBsYPLu98iv/hyxvDgnpopnHnjdu/OL9Y86Bg1LBQmSKPm/NfY1haGrLFYLTUcYaWH7V7paO0LsteLqSw3G7X75pKXRtg3mHQIUqHZPILulBP6Oj18URiLG7YeCIzfjC+OhV/7kBgbMZcAlip86WMC5LELpy7kja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtOeDckx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtOeDckx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC35F1F000E9;
	Fri, 10 Jul 2026 00:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783642926;
	bh=lmQWlN7Kz5M6UY5FUGwu6NbTNS6eWxT2irEIyuN7w+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DtOeDckxRN2LfawyPY4MdU4i1CMLbaSt7Ou0Z+fB4aFnCdhghlxlyeY9LWMhxWMb4
	 rszXpag/6Ww3QsUXWZWFR8mJnhw0DvZGRD5KyjU/GFXE3eO5/vrxpGWwrZk726islP
	 iBZqpn7X2N2gOCcSxOjBZAyHb9vX1/Lw6OI5ZoEe0RG2JuKQCsmsUtd4GUhCdilnpC
	 uTgYaB33Zcyn0/3kX+bpaiCbEqxfbKwQQ2M1sOURVWiXd8ut7kXCuUco1YeFAKMKlz
	 cDI8gAkKBonFZuMD1uiaZ4zbzs5vSi2PrZInK36yu1PVelvTa9Acgkqwui9wTMJcbM
	 yHuYpkZvKQDiw==
Date: Thu, 9 Jul 2026 17:22:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Dakkshesh <beakthoven@gmail.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/sorttable: guard long_size under
 MCOUNT_SORT_ENABLED
Message-ID: <20260710002202.GA1577616@ax162>
References: <20260603191708.27241-1-beakthoven@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603191708.27241-1-beakthoven@gmail.com>

Hi Dakkshesh,

Thanks for the patch!

On Thu, Jun 04, 2026 at 12:47:08AM +0530, Dakkshesh wrote:
> clang's -Wunused-but-set-global (a sub-warning of
> -Wunused-but-set-variable, enabled via -Wall), points out an
> unused static global variable in scripts/sorttable.c:
> 
> scripts/sorttable.c:452:12: error: variable 'long_size' set but not
>   used [-Werror,-Wunused-but-set-variable]

Our CI also notices this in stable kernels, breaking our build due to
-Werror in at least 6.18 and newer.

  https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/28937469245

> long_size is only read inside MCOUNT_SORT_ENABLED blocks. In upstream,
> it is implicitly resolved by commit b055f4c431e3 ("sorttable: Move ELF
> parsing into scripts/elf-parse.[ch]") which refactors the file entirely.

FWIW, I am a little confused how b055f4c431e3 avoids this issue (even
though I confirmed that it did by a reverse bisect). If I preprocess
scripts/sorttable.c before and after that change, long_size is still
only set but not used. I think that this change (or a different version
of it, see below) is probably still relevant to upstream, rather than
just stable, even if the warning is not currently visible there. If
folks disagree with that assessment, the commit message should make it
more clear that this fix is intended for stable only.

> Cc: stable@vger.kernel.org
> Signed-off-by: Dakkshesh <beakthoven@gmail.com>
> ---
>  scripts/sorttable.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index deed676bf..674b24a97 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -449,7 +449,9 @@ static inline void *get_index(void *start, int entsize, int index)
>  }
>  
>  static int extable_ent_size;
> +#ifdef MCOUNT_SORT_ENABLED

These ifdefs are pretty ugly and Linus did not love them for a different
patch upstream:

  https://lore.kernel.org/CAHk-=wh9eUk9+BOGwP7ni4OZPZSCfgZQ43n53XWuh3rHhMxwfA@mail.gmail.com/

>  static int long_size;

I think it would be better to drop the ifdefs and just mark this as
__maybe_unused to be done with it. It should make the diff more
stomachable for silencing a warning like this.

> +#endif
>  
>  #define ERRSTR_MAXSZ	256
>  
> @@ -1311,7 +1313,9 @@ static int do_file(char const *const fname, void *addr)
>  		};
>  
>  		e = efuncs;
> +#ifdef MCOUNT_SORT_ENABLED
>  		long_size		= 4;
> +#endif
>  		extable_ent_size	= 8;
>  
>  		if (r2(&ehdr->e32.e_ehsize) != sizeof(Elf32_Ehdr) ||
> @@ -1348,7 +1352,9 @@ static int do_file(char const *const fname, void *addr)
>  		};
>  
>  		e = efuncs;
> +#ifdef MCOUNT_SORT_ENABLED
>  		long_size		= 8;
> +#endif
>  		extable_ent_size	= 16;
>  
>  		if (r2(&ehdr->e64.e_ehsize) != sizeof(Elf64_Ehdr) ||
> -- 
> 2.54.0
> 
> 

-- 
Cheers,
Nathan
