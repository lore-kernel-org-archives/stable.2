Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DF346A0C;
	Fri, 16 Oct 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135407; cv=none; b=gspP0Tp/5we5Ygf4+qqG5wsApWkSmHKVGBtVqDYmGFVWBhJmJDib4LAdzsmg0231PjxWYTJfMNLQxGtpLQ1rD3VhejoJONM90q/ueuW1azQ++3cPh8xRFWP66t2hgBecSFJWCGP190AX09PnV09UnLph45gzdNLLsmMCXGFi9lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135407; c=relaxed/simple;
	bh=Fnsui3PlbcaixNQ4vqlonQ61DbXao20gBaaEXYCb4WA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8lO3soXagLSgeZK1Sa+2PWarsRtoHH3lUNjfXS4bGSIBRo7B5sbmnizT8XR5YOThLtHbxk85ZmkiDSLmR3z3hCJkdEFYUPmFKsnrYzo5VBXV1mWe+TZ6DEnnwsRCSC27YN35OrS116CiFL6MYMkisJN81/WfgB9o1Dk7IX/FeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fJLgk2Y9; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fJLgk2Y9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1792135361;
	bh=idnwnnaMWLUiVW27yfjxXo4AL8hev6zUmPFBKigDCtE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=fJLgk2Y9PwKYrzt5n4EfEjEme1AdfV++1f1MkVRvwtiNtLLz8/wyAcM8r8Jq5WkM+
	 IoRVQS7D48W1+3027X1OofcPnd+RhzCPwiaSVQYf74J5Ja6Dnre1jeuCsMHHALFyHM
	 nvuQniwDcoJTRY+KWDbUa3UCn5YFHP4/5iXDkLes=
X-QQ-mid: zesmtpip2t1792135342td7ce2847
X-QQ-Originating-IP: ZI24zA/GpPR8bf+XnsilAI7oWLs1kgHyGd914T96prc=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Oct 2026 15:22:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9258648051972908772
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: kprateek.nayak@amd.com
Cc: guanwentao@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	ray.huang@amd.com,
	ronforever@outlook.com,
	scardracs@disroot.org,
	stable@vger.kernel.org,
	superm1@kernel.org,
	mario.limonciello@amd.com
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Skip auto_sel write when it already matches the mode
Date: Fri, 16 Oct 2026 15:22:18 +0800
Message-Id: <20261016072218.303219-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <5469c745-7b9e-4a71-8d04-8716c5af840e@amd.com>
References: <5469c745-7b9e-4a71-8d04-8716c5af840e@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OJqK+P4eZhTxBDMgGX/1aU+2ioZ57Z6nQV7+tGOsU2uzsgeop8Oy4hTa
	CuD0LNsqWvNl58NSIVAFmvOpNPeZwuy03DU/uXz+DDPTspKFxP7u4Xfvme9sIq50dA0PXAJ
	E65iH1E+USSM+p17KmUq1cJHDB7MEIY9dPTTI/+Z8EhgcAoiFqzHPdBWYOROKXdzADrWpli
	sLZJzt+Gjvu8Pz/W/Mtx2fOoWncloqWOxN26U39LW9RkrLtsYpqhKFJeqlTK1vq2H55d7x1
	DEFVQH36ixmeDewMG3kuxS9CzNM1yoBW67lawbgnCfgn2kqlFcrtu8hncqrSmyo7FHcJDUS
	NSkRVs3IVf7XT8lRbRaILUDT32Xot10fH6FgirKzCAizCv4BHjnpuzgRrp+uITy6l6amJrn
	b935LE5GoIjOS8+atseurkbJHKGsvRONMuRODJfSJqaGoF8THUE7MXLnmxa3Uf220VPiULB
	XpaubnxM2b5o/V+RkD0p3Y0rBm8wL5PDiOEgDmxjewNs0UN2ijBfIz3mEmM02f1JDW6VK5X
	4SDyvT4pl9wiUd0tew0d3fwMJaIemzCaTSYgpqlB3jD4RsDrazsy8XZsIluv0sUGjnOA7fQ
	N62NjzClTVDq1NxU6cE+OlCKQeh76HYnR1rYT3IeoD9lk9uScgpv+nbFTvRv1z6N8dGOWQy
	f10JeXNi+hP8wrUuHR+aTK7auG2xm/NfGJGj2xEKTaGF7oBZAZb3purBQBjso+rei8tbWZA
	b/BEuOs5TpnP2Ht7ttwBjA3bAgae07reti1nO/b7IEm/j30xfN7FE8bx+t/BAm9TzSpPb1E
	hAHcGTKt7oRT/sW8CUMt436OlFfT/AM/YDzHXkMY4XLNZ3b4fND3xW4NB+CwpRnX84I5EEt
	SpZYC70R5W6llQIZjr+QRU/jHEkIm+4tqbQQNgsOhK37LYUVnVN8dkL+NC/Z65ynQ3HeprQ
	UVfMyI1m7kJ+DW/iu8QLbomnz3g+r/ogjfJd1cHOD3TenGCmCpbMM3bGzvFjXfVyhuIfH40
	akq4GOsAsZD3lEQ/P6H0/QuRt1v6gmnF0gEmAypWApjsRT6J4OC0bM1F4GvODaoaxFlmBeW
	CURIrsTFBsxNPdwWrac+BUPwTU4NtA8LLM2cdX1esZDZuatG2QX9ZOpyMHSSZb5RE2BmPzN
	PmKyKkIRgCY6AbE=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Hi,

>On 10/16/2026 11:21 AM, Wentao Guan wrote:
>> Hi,
>> 
>>> Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
>>> mode on shared memory systems"), shmem_init_perf() programs
>>> AUTONOMOUS_SELECTION_ENABLE unconditionally, including in active mode.
>>>
>>> Platforms that exclusively support autonomous selection report this field
>>> as an Integer of 1, as required by the ACPI specification, instead of as a
>>> register descriptor.  cppc_get_reg_val() reads such a field back
>>> successfully, but cppc_set_reg_val() rejects the write with -EOPNOTSUPP
>>> because the entry is not an ACPI_TYPE_BUFFER.
>>>
>>> shmem_init_perf() propagates that error, so every amd_pstate_epp_cpu_init()
>>> fails, cpufreq_register_driver() ends up with an empty policy list and
>>> returns -ENODEV, and amd-pstate refuses to load at all:
>>>
>>>   amd_pstate: failed to set auto_sel, ret: -95
>>>   amd_pstate: Failed to initialize CPU 0: -95
>>>   ...
>>>   amd_pstate: failed to register with return -19
>>>
>>> Skip the write when the register already holds the value the requested mode
>>> needs.  Active and guided mode are fixed on these platforms, which report
>>> auto_sel as 1, while passive mode still fails to load on a platform that
>>> cannot disable autonomous selection, exactly as it did before the
>>> offending commit.
>>>
>>> Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> Tested-by: LFRon <ronforever@outlook.com>
>>> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
>>> ---
>>> changelog v3:
>>> Include the K Prateek Nayak reviews to remove that ternary op base on current
>>> condition now have.
>>>
>>> v2 link:
>>> https://lore.kernel.org/stable/c3eb86bd-70a6-4bb2-8eff-b2a3c0817514@amd.com/#R
>>> changelog v2:
>>> Accecpt and tested the K Prateek Nayak reviews.
>>> v1 link:
>>> https://lore.kernel.org/stable/20260918054808.48999-1-guanwentao@uniontech.com/#R
>>> ---
>>> ---
>>> drivers/cpufreq/amd-pstate.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> index 80d99ba1902c9..2d1f5292d1738 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -532,8 +532,10 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>>>  		return 0;
>>>  	}
>>>
>>> -	ret = cppc_set_auto_sel(cpudata->cpu,
>>> -			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
>>> +	if ((cppc_state != AMD_PSTATE_PASSIVE) == auto_sel)
>>> +		return 0;
>>> +
>>> +	ret = cppc_set_auto_sel(cpudata->cpu, !auto_sel);
>>>
>>>  	if (ret)
>>>  		pr_warn("failed to set auto_sel, ret: %d\n", ret);
>>> --
>>> 2.30.2
>> 
>> Ping? Nearly a month passed, anything update?
>
>On a similar issue here
>https://lore.kernel.org/all/851316da-2cfa-4a22-947c-1838532d05cf@amd.com/
>Mario had recently pointed out that this might be a BIOS issue on
>systems that may have MSR interface but running an old BIOS that does
>not advertise the CPUID bit.
Seem same issue.

>
>Could you please share your system details here and check if you are
>running the latest BIOS from your vendor?

Emmm, the user report that dmesg showed running on this laptop:
DMI: METAPHYUNI MetamechBook01/MetamechBook01, BIOS AHP958_V00.01_T015A5ME1 02/22/2024
which vendor not ship new BIOS,
but it is verified in AMD Advantage: https://www.amd.com/en/gaming/laptops/advantage-premium.html ...

He also helped me to test the kernel patch.

BRs
Wentao Guan
