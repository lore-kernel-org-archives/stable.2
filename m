Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F504D597B
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646098; cv=none; b=ZYCcxwyvA6wdHcmiUI4iCpsJQazj06btrSU+Tj3lR7GvBoz8rT5r0z8COr57GLfzdVLiqrzOPptjfYffme4K+446sLGNXqrusXW+NWCEVy4ExVZOKcSDcy4PUMT3WCNj4krNETmQa8q0MS4UY/MEqrZ+PFWHiA7yKUSoAbLaIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646098; c=relaxed/simple;
	bh=85JVcOr6HuJbaIMeK8NVisM4coW05UJmyCf/iDAwHy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfEb1N78y9mbtTGQo8xjQ/LMPqOLWytVno4DW6aIWOH+/XBNLPjmEeyv61AzmAdIpmk9e7W0ls9psDKULAGVeWg6g6QhVCxlZWNfWdy/Yy9wJ2qbvhC5xa3HHMS3J/wGBHtBdROJAuwD/R+QrKM6ADe1b9A6hv/fcmI0luwE46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=b4EtPqDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNYK+010; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="b4EtPqDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNYK+010"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E923A7A00BD;
	Thu, 17 Sep 2026 07:54:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 17 Sep 2026 07:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789646086; x=1789732486; bh=QJ/isA5HV5
	7im4vjkFUsLDiQblQJHGKgwUCYurcYTEE=; b=b4EtPqDAsZ9kOnJaWjFNeAAs5f
	v1Jgp2TlsdLBqbw3lVidheILlslpK/XzQUo953l6SoN1GAcYG0dxTd8pFlcHFPM9
	MQlPGjmZ4LFUcYMMAWq59ASQghY41C48mbrVdu82ax3m6wseE8ZluqNGGBOjnlmK
	F7h8LRElbvtSNrbsUtnagbOG0B/gRDsUogp4Ebz8kdC/h26iJyKgm+aBOF+waLAt
	Hm+Pyfik76VtMZVPiEME0g1mELG0pKqZwz3EhMk6QeYjYF9K2GaiJzURb4wJIS6i
	fOZIuWf+Idm+TEB8n0DWqOAtoz2QkYDxBmg0ZGA669KeQB0VgOjcCuOis8mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789646086; x=1789732486; bh=QJ/isA5HV57im4vjkFUsLDiQblQJHGKgwUC
	YurcYTEE=; b=PNYK+010hTyN3lBG7TnRKOZpcWKRHxm5Tuhb+ISstqlF2jncbfs
	gM9BeUzd6mC9dZU4vlx1giwJepAkzo5wtVnmyiY7/8Fl5O85xwT1/a32htvAfQlE
	BqdVpWegKys3gqt9yytWthR+PI7VkTJanLPgvSJ2Vs0PziAiZVI2/V/CM927LnuR
	iMyi3vkz1EiG+Yno7pvAfPMu6x9Tq7wE08dCekQhjoUev0FqW4nc1nEL5ZKD8HLr
	fnXZyRxsyZ/CfUfU+WAj8w7W75fhW+eVO/OXJLLQMxVBfDHwc51iBHQtwSfIILWX
	5jFJn5hCLJPK6iFn9UqpAyU7sxb2ITDxLzw==
X-ME-Sender: <xms:BtWrau6MLEKFR9WWbeVSn7r9a-aJsjaF-Fd_MBz3DpcFJwnDMTyM-Q>
    <xme:BtWraq_WcrP2YwiMQnCtrf7sgIqqloVM7UYABX6UPBCN5uR5BXYBcUfsgebFv4wTB
    YNNm7rikS-Sxgq_dspAH5bgpx2eKvwgeCE5SWJtDaEHSzEPYQ>
X-ME-Received: <xmr:BtWraoF6OJz34OHmtWFPf-m3171C7kdhNseYDZi5Kehkjzk2MiRxKuiLXIHH>
X-ME-Proxy-Cause: dmFkZTEQ5oUVH/+6iniP7mPqMrhqRHb7JlTu/s/7qMJxqovoHjZ2vIv9mMD7xpVFV/Ohlo
    9WvUY5hXCSmPTix0/nTItiYgNjlgxMFYxNWFHZ8obVimyO9K2tCuPsmykHWaC8QA0NFfL9
    sNrzRn9TLuf+ijajzVmiNGkI5WO3mVsVZIoC67i+nEciXDsbCpd/XK7SSCDSP5clAvHSOh
    F5BAwoyNsocY0DNDfk6dM3lRZx9AtFtuEtuvj45lfUQiFPBV1qHMaZ3PFo323BZlxcsG2H
    mZQmyWn4qeB1PpiSCPxgmldbkn8/1kexYJG/i+0cdX+7MgBdzYXuwi0CGhZy9QKbSbxstq
    P7eVdKFQOn6zt/Y78YWo1lYnxnnqs493qmGRPLHEfgLUFFiEOy9JN2B9dNChcsPC4E+yaR
    gXid/rAKMV2pNgzDXHqmSUfTgVdcLVlYimr29AnHuptCKUXB4BPgilT+tOwyHU1AfLNy0m
    HPnpsWoDJTckq/L0eWFTfkuS8Xg3gG9yCWst8mLW4Dst6n80gHYQ/tYte6UyZ+3AYLHMI1
    yEDvXufKyQhHX5pjSgnrYDlw0iqMPac5Tp60Ik24tBs0iW7nCX7GQy/VWD+iGyHxOSiQGs
    xrprJZ2UvuXRopxAu6WuGWD/bZZfGwPjaekonNfXTm+z6kmYPk7T+ynKTaTQ
X-ME-Proxy: <xmx:BtWranWGCuje9GSztggkkhxnZGE4gXR0zA2kelkVu2tdg542jMWhyw>
    <xmx:BtWras_G5D5vCJRwGDVDHbaa8_U1iAG8V4ui4_x_K0wCSgdUinJsBw>
    <xmx:BtWras6wTN0eIohP6Xk7VRpXC3KDrdMyLVJAtG1usx5tQlnu7Ncy9g>
    <xmx:BtWratkd40t8mK-ZW1CG3CWxb7vep-iyRUCKygzmO9h1TGMcFJhQfQ>
    <xmx:BtWraoJej6rTWSmoAK4vbNIpJwxB4RWlWLWuCCJ6ga88kbqwJ_GQtMET>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 07:54:46 -0400 (EDT)
Date: Thu, 17 Sep 2026 12:52:21 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Christian Loehle <christian.loehle@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 6.12.y] ACPI: CPPC: Reject desired_perf reads on _CPC
 revision 4+
Message-ID: <2026091717-synthetic-smashing-c681@gregkh>
References: <2026090308-suffocate-napkin-a71b@gregkh>
 <20260908122009.2049812-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908122009.2049812-1-sashal@kernel.org>

On Tue, Sep 08, 2026 at 08:20:09AM -0400, Sasha Levin wrote:
> From: Christian Loehle <christian.loehle@arm.com>
> 
> [ Upstream commit df5a1d4a8cdfda20eb2581a85e81c7d436866534 ]
> 
> When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
> calls cppc_get_desired_perf() because some platforms repurpose Desired
> Performance to report actual delivered performance.
> 
> ACPI 6.5 defines _CPC revision 3 and lists Read/Write as the Optional
> Attribute of Desired Performance. ACPI 6.6 advances _CPC to revision 4 and
> lists only Write, so invoking that workaround for revision 4 or later would
> require a register read that the interface no longer specifies.
> 
> Make cppc_get_desired_perf() return -EOPNOTSUPP for _CPC revision 4 or
> later. Use the revision retained in the per-CPU CPC descriptor rather than
> the platform-wide FADT revision.
> 
> The _CPC revision may still not accurately describe the implemented
> register semantics. If a nominally revision 3 platform implements a
> non-readable Desired Performance register, a read may return zero and make
> cppc_cpufreq_get_rate() report 0 kHz. Treat a zero read as unusable and
> fall back to the cached OSPM request, just as for a failed read.
> 
> Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")
> Cc: stable@vger.kernel.org
> Suggested-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Link: https://patch.msgid.link/20260803203531.1268651-2-christian.loehle@arm.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [ preserved the original CPPC revision while parsing only the supported v3 prefix and retaining cppc_get_perf() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/acpi/cppc_acpi.c       | 13 +++++++++++--
>  drivers/cpufreq/cppc_cpufreq.c |  2 +-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index fd6a83e3d4301..2f504034f321a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -764,7 +764,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	}
>  	if (cpc_rev > CPPC_V3_REV) {
>  		num_ent = CPPC_V3_NUM_ENT;
> -		cpc_rev = CPPC_V3_REV;
>  	}
>  
>  	cpc_ptr->num_entries = num_ent;
> @@ -1220,10 +1219,20 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
>   * @cpunum: CPU from which to get desired performance.
>   * @desired_perf: Return address.
>   *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -EOPNOTSUPP for _CPC revision 4 or later, and a
> + * negative errno otherwise.
>   */
>  int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +
> +	if (!cpc_desc)
> +		return -ENODEV;
> +
> +	/* _CPC revision 4 no longer specifies Desired Performance as readable. */
> +	if (cpc_desc->version > CPPC_V3_REV)
> +		return -EOPNOTSUPP;
> +
>  	return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 1abedcae50b26..d49753e88c79c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -807,7 +807,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>  	 * value first as some platforms may update the actual delivered perf
>  	 * there; if failed, resort to the cached desired perf.
>  	 */
> -	if (cppc_get_desired_perf(cpu, &delivered_perf))
> +	if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_perf)
>  		delivered_perf = cpu_data->perf_ctrls.desired_perf;
>  
>  	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
> -- 
> 2.53.0
> 
> 

Does not apply :(
