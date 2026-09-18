Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF773D967A;
	Fri, 18 Sep 2026 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699187; cv=none; b=KEiW+PQHWKkw4XOLE39nzKFSPYP+BmCfLASeE6ZtOtE9rdp9t2s0u6ZFrvzh7Nqy6ZYGQKXLM1niRmtSruUEW4G9TBIzUNkzi76FDrzJpavqe+CRBa/YGuaqZacQ7qun4hRXPZvg6mayLI+xKXBAfUhO0uTxzBNdMAyu81eCgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699187; c=relaxed/simple;
	bh=LHxvULIjuhzzrdmod5Ti349waN78Al8eYLLBzfZPFxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvMZeDSf/pR13bnQNzcmRgMq1VaBu13P3kj0N5dRys9dTx7I1cPUXX7rNJ54BjwZRX0/99wiRY++CfEiDta/FR2LEqKww7XJACBqUM3NwBpBb4Q+4fVwf4q2fSXyOO79KWV2+0eql0ORTeRVWX1mm1MGwdriboJ3Xu2S9hOJDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjAbvwLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjAbvwLB"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 69B041F000FF;
	Fri, 18 Sep 2026 02:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789699171;
	bh=iXQ8/FN2HIWNxcjvM/55UBFKrybyLV2KJVEHMIIV2fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZjAbvwLBHpr5Esdtq4I/8X7Ar3v79g3g2Pu1HaqDD2XU3sGOiKT0tjBa1Ktlrnk7L
	 vIs9W/spDzkf8WkMVswAkaEn/5G+2+gkXeJoXZXLQn0++O6VzXN8d5r+6Ie+2oIn5x
	 WJ0C5C2NdHNQMo0XNYJpcp+yKZz+UlFv1ePMNpLZB2OdJS5DF9lLU/KvQXCuuPJmmC
	 dpFDOTK6YJ+iLOiO/0uXmgpk/T5CmcNK4ZCjBIDeRCRtu5NuIRPVEy89C0jXoJ5XxV
	 ik5zjSt+QQ+FTpTed14gOfhuFl51QKUHn9hAGI1wYX40Q5vZ02/xDFAlHdcbTieHhr
	 tCjqFzhqeHzGA==
Date: Fri, 18 Sep 2026 05:39:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Surendran Kanagaraj <surenkj@amazon.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefan Berger <stefanb@linux.ibm.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, nh-open-source@amazon.com, graf@amazon.de,
	gunnarku@amazon.com
Subject: Re: [PATCH] tpm: Disable TPM on null key name mismatch
Message-ID: <aqykXxFybNMB_KSv@kernel.org>
References: <20260918000731.48657-1-surenkj@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918000731.48657-1-surenkj@amazon.com>

On Fri, Sep 18, 2026 at 12:07:31AM +0000, Surendran Kanagaraj wrote:
> The null key name check exists to protect against TPM reset attacks, so
> a mismatch should stop the device from serving further requests.
> Currently it does not disable the chip when it finds a mismatch.
> 
> The mismatch is logged:
> 
>     tpm tpm0: null key integrity check failed
> 
> but the chip keeps serving commands:
> 
>     / # tpm2_getcap -c properties-fixed
>     TPM_PT_FAMILY_INDICATOR:
>       as UINT32:                0x08322e3000
>       as string:                "2.0"
>     ...
> 
> tpm2_load_null() where the null key name check is run sets the chip as
> disabled only if the rc is non zero. When the mismatch is seen, rc is
> zero at that point and it returns success. The other issue is that the
> caller expects the null key handle to be populated when the function
> returns 0 which it does here without writing the handle and proceeds
> assuming the null key handle is valid.
> 
> During the test, I noticed that tpm2_start_auth_session() uses the
> uninitialized stack value as the key handle since tpm2_load_null()
> returns 0 despite the integrity failure and proceeds with
> TPM2_CC_START_AUTH_SESS with this value as salt key handle.
> 
> Set rc to -ENODEV on the mismatch. The error path then disables the chip
> and returns the correct code to the caller.
> 
> Tested in QEMU with swtpm and CONFIG_TCG_TPM2_HMAC=y by making
> TPM2_CC_CONTEXT_LOAD fail with TPM2_RC_INTEGRITY and changing the name
> of the re-created null key. The chip is now disabled on the mismatch.
> 
> Fixes: cc7d8594342a ("tpm: Rollback tpm2_load_null()")
> Fixes: 423893fcbe7e ("tpm: Disable TPM on tpm2_create_primary() failure")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Surendran Kanagaraj <surenkj@amazon.com>
> ---
>  drivers/char/tpm/tpm2-sessions.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index cf8f1fd6790b..ca1e2bf424e1 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -975,6 +975,7 @@ static int tpm2_load_null(struct tpm_chip *chip, u32 *null_key)
>  	/* Deduce from the name change TPM interference: */
>  	dev_err(&chip->dev, "null key integrity check failed\n");
>  	tpm2_flush_context(chip, tmp_null_key);
> +	rc = -ENODEV;
>  
>  err:
>  	if (rc) {
> 
> base-commit: b5f1b25b21f56c9fff87ad0235791883d1bf01a9
> -- 
> 2.47.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you.

BR, Jarkko
