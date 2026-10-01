Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B83A3815
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865757; cv=none; b=DWaxbBF6hjXVLnMfWyFixi7868F8tvFEMTy2U4sv1GHwei9yQWTBxb058FM04cRpMKqcHpcnusJnXr/ez9vQGK5O3vyZRMnUsjgvlMWmzli/c/HgGlehoxRiIElpt6/h7W0idYXGAeigODq74OLcX0sn+AILU1CHazNrvErjscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865757; c=relaxed/simple;
	bh=L1X+aSQgTpevDtKgf3igo4ZbONRtN9Jmbh5rvE0+7AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGDDPuXND9djuK2V3pylJuhw6U+X/yN1wNbt8Q010SxYCOW/PbFhWIaxZfYUq8za0B3cMKaKs9jJO/dV9Av5TiB8lI3JuwrvuDYnSPbqIZU4+mUqqPF9jdrIiHkVps3ohKl8aJ2BScQXv/C7YEDp9zYghp3sdArFYXhxxMpODEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JCpNOy2X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JCpNOy2X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72335497;
	Thu,  1 Oct 2026 07:42:27 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92C83F85F;
	Thu,  1 Oct 2026 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790865750; bh=L1X+aSQgTpevDtKgf3igo4ZbONRtN9Jmbh5rvE0+7AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCpNOy2Xjltm6Qc3UpPgw4WUoIgP7FJad5cJXaiHBs0uevpNhfD4qM0765KhBb3R3
	 7sHQ70+QbenrikJHpHq6c/+5iUHSV+TiBLfrSFYQIbnGXQDxbhTZYZxVQqa7mWGgke
	 nw2WxCU189mCRGVbi6jut3tZeu01/y5ICn7Dkd0k=
Date: Thu, 1 Oct 2026 15:42:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	stable@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH] arm64/fpsimd: signal: Forbid non-streaming SVE payload
 on SME-only systems
Message-ID: <ar5xUENHCvhAnUX3@J2N7QTR9R3.cambridge.arm.com>
References: <20261001130836.1410888-1-mark.rutland@arm.com>
 <51351e42-60d1-417d-b61b-6011bfe5d2b5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51351e42-60d1-417d-b61b-6011bfe5d2b5@sirena.org.uk>

On Thu, Oct 01, 2026 at 03:25:03PM +0100, Mark Brown wrote:
> On Thu, Oct 01, 2026 at 02:08:36PM +0100, Mark Rutland wrote:
> > @@ -443,19 +444,33 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
> 
> >  	} else {
> >  		/*
> > -		 * A SME only system use SVE for streaming mode so can
> > -		 * have a SVE formatted context with a zero VL and no
> > -		 * payload data.
> > +		 * Non-streaming SVE state may be preserved without an SVE
> > +		 * payload, in which case all state is saved in the FPSIMD
> > +		 * context.
> > +		 *
> > +		 * On SME-only systems, non-streaming (FPSIMD-only) state is
> > +		 * always preserved without an SVE payload, and with VL==0. On
> > +		 * such systems, only accept non-streaming state without an SVE
> > +		 * payload.
> >  		 */
> > -		if (!system_supports_sve() && !system_supports_sme())
> > +		if (!system_supports_sve() && !fpsimd_only)
> >  			return -EINVAL;
> 
> This means that this function will now accept a FPSIMD only SVE context
> on systems with neither SVE nor SME, but that check was redundant since
> we already reject anything with SVE magic in parse_user_sigframe() on
> such systems and should never get here anyway.

Yes. The commit message explained that:

  As parse_user_sigframe() rejects SVE signal frames when neither SVE
  nor SME are supported, it isn't necessary for
  restore_sve_fpsimd_context() to handle the case where neither are
  supported.

> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks.

Mark.
