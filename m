Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250633A70E;
	Fri, 18 Sep 2026 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710550; cv=none; b=Y5ZwNzqFvYjCdUXCxpVV/bL/8nNywMZDWgO2uVYVDLPFjBR2KOFiTCJq+hgIFHbNjbqqTZK7H9SUMRK3uJy3+9HZ6XjbdsfcGrsaxrJdYxpt4kVt5E4Z6MsmPlszgDDxn01kh3yu74Nb910Os8bMxrkXbTunzdUltNAbLcTzMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710550; c=relaxed/simple;
	bh=HSIiBjEF6kVr4lDbSOyfO3M9sXDCs9uqCTKciOy/8K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCRRiR7fKtokxUNdhbzeQSoMVFl2d+RDGeu02I3TXTsQU6E1d9pLMsrzlmJstJi7jgLCtCsF4rcb0gKeCPweerGNAIY8paZq1z2Sst+z6hflClJ18mkSqNphq0O3K2x6r5jRNK4zX5Bx8/GNSXfKuUlt2nOmd1tPFh7Lsh4uzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gTDeCzmt; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gTDeCzmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1789710509;
	bh=m4i0jsZ3JLyaXEppMzJNMR1oMWhkh8P+QnRqNLoQkno=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gTDeCzmtJ2nxYAPBKbKzReHed/WJL1Ckgs6sMvrpk+0i4F0r1ACgagxI1NZskqt1U
	 6SNx69hh+KqVFsq29nmZb5+K4aRmcW+gUkQXcyinpMMNla/9bvxQ4rwPQuQcnyLu0q
	 TczLnwVLll3sA0706cxQYkWfUTVug2TTYBv7Os+U=
X-QQ-mid: zesmtpgz6t1789710491td142aa3a
X-QQ-Originating-IP: AW4kLNZweyOKyPAkMy6G5POI4gszYncYxz7WTpxrRhU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Sep 2026 13:48:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12507322500606360400
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: kprateek.nayak@amd.com
Cc: guanwentao@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	ray.huang@amd.com,
	ronforever@outlook.com,
	scardracs@disroot.org,
	stable@vger.kernel.org,
	superm1@kernel.org
Subject: Re: [PATCH] cpufreq/amd-pstate: Do not fail init when auto_sel cannot be written
Date: Fri, 18 Sep 2026 13:48:08 +0800
Message-Id: <20260918054808.48999-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <748cb8d6-174c-4cad-98bc-ebb985e2eced@amd.com>
References: <748cb8d6-174c-4cad-98bc-ebb985e2eced@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MaOFYie8xFshjyzlZsZ1Q1GzyFvXo1rCrQ0ozdiWGslxSdeohdVWe9Iw
	0VYSCmsTtqBKUaG5SQZIGmDxhPXBxaZdGaYmYrvYarC6aASFykw7QPTkQRbmL0BG4jrGYmm
	90puGyO1K7E385AvBnNbm0SCF6a8xKWRe0N0HtIMDgfsN8U3vfmOe5UiLqoZ5WFf+s08ccC
	b3shRvIy1u1y1jQ6cK8ZT1OPXuv1sAGokR0jMl8a1obEnQutXoo598E4nBAzCvqh+Y/tvRh
	ntWeNtTPn1HkRqDrK0CLOHt3LzYtJk4/FbfgT+naInfSZsE0sXj8ZObTpcaY1Fn8xE+AA0X
	pUTnXI9v0CM1v224Z1STcOi6ShLYX7TobKCz9Ta7nCnqwqI+Yzb67kXx004RIAnKDbE9fwx
	nKDWH8uRfNqLkd0BlwqPPC3Wq4FviMtEvY7+KgdvKZcBF6aveJQWUFbs1PkMWKJ/SDmt3Yp
	thk3Zf0SU6SmsGXnFUXhoFiEr+oYuNvXt/eO6bQ0Hu1Gv0oO1qHnqVn5iRqu8UIk+WwTkZK
	7ea+tsszk2hiimDPrR9RLL+7M4Q2R+cbimamcZVEBAeaOndl8lR/7ctyG2rXd7ZDiVXIJhO
	7hH87IzYyHKd23tTbh7z33gIKaPwZZtL/BDUvOYIXdz2U71rw4YaGaGFKLacKvnYcnDwrBm
	+qsWjM7mHyeiAGaidmri6vjRTofCAXODfs3dl2cvKQbEbcYpgSsoftgkdtby4YerumYFtvy
	7pnLELn1X1C1/o5hvem/Wp64Qo+jSWIuK9xtXPdL6oLZoI18CMvnNuqBeTwBbvEMVsUfaBr
	i9D+h+/VHwL6fkDFJipYUt1D92qZKIWYFtrv1/xAkAQqnPqFqHyeLSLSxssuYfTCnedI2i6
	EPINzNmaXuzQ6RNJimS5kldjUOvoNs8bsx6KhZZ0JyljH8Cnqgbtiw0IPnvtJeBWCMVoAnC
	dY1tYmiCuqifzNFoYqc3vkn0MPC11VlmMjHS1gUf6+5hvXWkkAArK762RBLdTfJoX0Y7IPU
	vKJymtV3ffGJBqYIcUqpEE5+hkXNJL896mm/24gntEPGKROk2nu6Jk0sWLjR52c+ER9Z/+b
	4JrjX0RkOB4pkFx3ZuA+Jyk+46NsYDVWq3sk3e8UoUu
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Hi,

> On 9/18/2026 10:12 AM, Wentao Guan wrote:
> > Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
> > mode on shared memory systems"), shmem_init_perf() programs
> > AUTONOMOUS_SELECTION_ENABLE unconditionally, including in active mode.
> >
> > On platforms implementing CPPC v2 and below, _CPC reports Autonomous
> > Selection Enable as a plain integer rather than as a register descriptor.
> > Such a field is a read-only capability flag: cppc_get_reg_val() reads it
> > back successfully (the firmware reports it as enabled), while
> > cppc_set_reg_val() rejects the write with -EOPNOTSUPP because the entry is
> > not an ACPI_TYPE_BUFFER.
> 
> Ah! So it is one of those platforms that fall into:
> 
>     Platforms that exclusively support Autonomous Selection must populate
>     this field as an Integer with a value of 1.
> 
> as per the ACPI spec.
> 
> >
> > shmem_init_perf() propagates that error, so every amd_pstate_epp_cpu_init()
> > fails, cpufreq_register_driver() ends up with an empty policy list and
> > returns -ENODEV, and amd-pstate refuses to load at all:
> >
> >   amd_pstate: failed to set auto_sel, ret: -95
> >   amd_pstate: Failed to initialize CPU 0: -95
> >   ...
> >   amd_pstate: failed to register with return -19
> >
> > Failing to write auto_sel is not fatal: the register is either already
> > enabled, as reported by the cppc_get_auto_sel() call right above, or not
> > writable at all, and active mode worked in both cases before the offending
> > commit.  Downgrade the failure to a warning and let initialization
> > continue, matching how the cppc_get_auto_sel() failure is handled.
> 
> Can't we just skip cppc_set_auto_sel() if the auto_sel is already at
> the desired value? Something like:
> 
>   (Completely untested)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index d4ff8b228f86..ed540da818ef 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -524,6 +524,9 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  		return 0;
>  	}
> 
> +	if ((cppc_state != AMD_PSTATE_PASSIVE) == auto_sel)
> +		return 0;
> +
>  	ret = cppc_set_auto_sel(cpudata->cpu,
>  			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> 
> ---
> 
> That way we fail for passive mode switch which will operate under
> incorrectly assumptions since these platform only supports autonomous
> modes.

> Thoughts?

Thanks for your review, full agree with your suggested patch.
I will send v2 after be tested later.

BRs
Wentao Guan
