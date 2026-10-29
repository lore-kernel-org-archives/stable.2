Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305958;
	b=Gh5+VopF3DiYfTOKqAZrpssU3j/VZ/eep6plkY7zrwN+szcZea83SnMcZP74OmLPmCse
	 vxmnrpODPr3R4zV+moj+DeGdGwPyV5FEh9NJHo+tK0WRaG+TeKvE7G9EhQi8QL9A5m/Am
	 9dFZaZUVethvgmnyAhIfTVkYcA5/pZQvgc9lfOuhTIrVhw4zD0ocktl+QI9+Ld2UDKV2o
	 6x0y4ERi8f4ui24r+HSUrlVDSzcU3PTuKZIImtEfbIPMUZtI4lD3+QzeOdwXeYx+ZCRBU
	 3/dLgi9l4+QuiM39GW/EiE1zZsVWNWhcsG6uyBBFEB3l2eeE3xQKUYDFIn8t8qnq76w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305958;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=+0OsAHylFzDUlbd5p5ZlaNpNPdERBBYFM+tKrSywm2M=;
	b=uLXu/rZMcDc3VJoKnB1UPTr/d4fSwLqzxi7v141OaYM8Gax/o/j3BUw7kwiUdKZ+RxqV
	 Fp65G17cO5oipSnCVgbEk8f76RhlIRoGADYOxiUjOtkCOqyaXIe1pxrxIjeccMmFTuHI+
	 Ux22KiYT4836kPLKcXtzZvEuLUhgTbXy6Vlpmhgc6vn3ywTb3NWD8mtMsUpOQeQihTBQV
	 GZczMFXjHWct4WRzPOJ2L74+wY9M2OuSSt29jQzrcOYh0V10IER9QB13nfo/Fy06bwoAh
	 QUdAAZnXd5ibozoUvkSdlC4Ks1kI5WLn92ednChvkkUs2eksGHYsrGyARTAbg+Uunsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Li7rfahO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51B9606A31D;
	Thu, 29 Oct 2026 20:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D51B9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Li7rfahO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88DDC15A1;
	Thu, 29 Oct 2026 13:32:32 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE2213F673;
	Thu, 29 Oct 2026 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793305955; bh=2WuktTPKKDQ3u4/hHWpfo2hpVmbUd7vtqE9LCZohGME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Li7rfahOEUIhxJmzoArHCiIA1dylePw/t0GV2JJyyUzIad+MbSCPSWUdetPKIJBPc
	 qlTbPHjL1rAg02sPWWBZ636MuKumFSBDG4q6ghmrDGFmpUtg6deKyAnazMxC1Rhow6
	 ActmiJn2WiK3ZZlsN5n5RLb1Ho/RsilrbfagWnSM=
Date: Thu, 29 Oct 2026 20:32:30 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: =?iso-8859-1?Q?Iv=E1n?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	James Morse <james.morse@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Zong Li <zong.li@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zishun Yi <vulab@iscas.ac.cn>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] arm64/gcs: release GCS on failed fork
Message-ID: <auOtXvGD1RHsU-dy@arm.com>
References: <20261028154315.1272705-1-ivanrwcm25@gmail.com>
 <20261028154315.1272705-2-ivanrwcm25@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261028154315.1272705-2-ivanrwcm25@gmail.com>

On Wed, Oct 28, 2026 at 12:43:12PM -0300, Iván Ezequiel Rodriguez wrote:
> copy_thread() can map a CLONE_VM GCS and still return 0. A later
> copy_process() failure calls exit_thread(), but arm64 did not
> implement it, so the VMA stayed in the parent's mm. Wire
> HAVE_EXIT_THREAD to gcs_free().
> 
> x86 already does this via exit_thread() -> shstk_free(). The separate
> x86 TLS leak is different: copy_thread() itself fails after the
> alloc, so copy_process() skips exit_thread().

Is the x86 TLS leak relevant to arm64?

[...]

> @@ -503,6 +517,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  
>  		p->thread.cpu_context.x19 = (unsigned long)args->fn;
>  		p->thread.cpu_context.x20 = (unsigned long)args->fn_arg;
> +		/* No user GCS alloc here; drop inherited tracking for CLONE_VM. */
> +		gcs_reset_thread(p);

My LLM run noticed that this fixes another problem, unrelated to the
failed fork: io_uring and vhost workers are created with args->fn and
CLONE_VM and they inherit gcs_base/gcs_size from the creating task
through arch_dup_task_struct(). Without this reset, a worker exiting
normally unmaps the parent task's GCS.

I was wondering whether to have a separate one-line commit for the
worker thread case but I think I'll just add a comment in the commit
log, keep things simple.

-- 
Catalin
