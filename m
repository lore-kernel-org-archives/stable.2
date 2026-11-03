Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726367;
	b=u1VGV9abjzcjMMluWRxCyPZAPw4piNlnO/YdR3yNfadeucww4GQCq7MMYOH51t0yjVrk
	 t0HCY4GSZIRRT9nGO5RvA0uMGTCw/uIsiiZ3KRUDBA/r6cZgu7lOuc7jmUpVqPjsS4CRi
	 lWk7QcZXVM+d/LWSp5cSGJKFvFt0pUvtPMVO53mz/pHY6pCau0Mbv/ub8xggomdZ4eFkG
	 GgqVWJZJofRTmAFRaI4x5nxlREaNVj6KcCO8l4bwONX3LaY8ZQrO9wGwFbEcWee865D1W
	 fbdTGG/M9ouqN9wux/oXS3XBDobauMV7O8moHWr7uJpQYzWe/1iBTrqyx64Zy1YcXlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726367;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6pvXqxRXPMjsEETSg9LNTP6JozH1dAr2ppJVpOpiMJg=;
	b=nL9rnkpkUX+OU6pASljPp8xjhfvS9iAfUTsjegMqp6l+v86aoNrXkrfPM/RtNhOufoJj
	 RUWhBjJTlTNmaRlryrBMfqTdaldIKRzaFaNWjSgAEqtOTQBiPH5V0oj3hTmq4p9Y9mRQ2
	 vZTAkX9605P2pVp2Xi/dOM9nzvcrPSa3P9rZDwzO/QX2TvaZ0EOeipc30jWS/NMusg1Dc
	 n7+NMVlG8kAWP8p/Xam4mOOyMTd8Crv4VDagFWQ5Nf1iIhV6jGOnQH+Ft3wXJBhpDOQNE
	 pjdNCZzNKLxPBv68794qHFRBMY0ZM1hVBFOy9RaZOavG7IblvLgwu2qyijP+U4oAs+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dkeideyj;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43C606A31B;
	Tue,  3 Nov 2026 17:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED43C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dkeideyj
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32EE81595;
	Tue,  3 Nov 2026 09:19:23 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBA343F673;
	Tue,  3 Nov 2026 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793726366; bh=NkN3i0ej3cUcmuSflm8MM+RqtYaqbkaxPdwWJVsyp4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkeideyj6Sh0JkCmgr5ctazcOfhVYfazcBnETkpe79Gaea6qKPPR0ALLDtAeyUiXl
	 Na4ewsHg8KUfgIgS/MNtn5bxj50NwH6VJEoN4skBpFoYfvoEaKMnrzQ6jpBIOe0jsn
	 KQ8vPcM8z/kb1bnC+3YIzjr7U6nLvmaeaMWSZbiI=
Date: Tue, 3 Nov 2026 17:19:22 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Rui Qi <qirui.001@bytedance.com>
Cc: will@kernel.org, mark.rutland@arm.com, ardb@kernel.org, song@kernel.org,
	dylanbhatch@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: module: Use text-poke for late PLT/veneer
 emission
Message-ID: <auoXmvKObg3IWWTD@arm.com>
References: <20261010084721.2197683-1-qirui.001@bytedance.com>
 <20261010085055.2200241-1-qirui.001@bytedance.com>
 <20261010085055.2200241-2-qirui.001@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010085055.2200241-2-qirui.001@bytedance.com>

On Sat, Oct 10, 2026 at 04:50:55PM +0800, Rui Qi wrote:
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 7afd370da9f4..fa89ed014bd1 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -9,6 +9,29 @@
>  #include <linux/module.h>
>  #include <linux/moduleloader.h>
>  #include <linux/sort.h>
> +#include <linux/text-patching.h>
> +
> +/*
> + * The .plt section is marked ROX once the module is fully formed, so
> + * late (livepatch) relocations that emit PLT entries cannot use direct
> + * assignment.  Mirror WRITE_PLACE() and route the write through the
> + * text-poke API when the module is already loaded.
> + *
> + * Return: 0 on success, -EINVAL if the text-poke write failed.
> + */
> +static int plt_entry_write(struct plt_entry *plt,
> +			   struct plt_entry *entry, struct module *mod)
> +{
> +	if (mod->state == MODULE_STATE_UNFORMED) {
> +		*plt = *entry;
> +		return 0;
> +	}
> +
> +	if (!aarch64_insn_copy(plt, entry, sizeof(*plt)))
> +		return -EINVAL;
> +
> +	return 0;
> +}

As your comment says, this is fairly similar to WRITE_PLACE(). Can we
have a single macro that's used in both places (and maybe give it an
arm64 specific name if it ends up in a header)?

Also do we need the !NULL check? plt and entry should be 4-byte aligned
already, so it's an unnecessary check. WRITE_PLACE() doesn't do this
either.

-- 
Catalin
