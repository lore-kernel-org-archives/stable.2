Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDA1E260C;
	Fri, 16 Oct 2026 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129971; cv=none; b=jMZdSOJlIHmgmCIkCwsVBq7uNyAVH7lj2GmqsW2YVVDdmBVlYLDqOIpmuv1ErpvTPPr61J71YczVn3SYoda6VXM8JSI7PR5RVhlafCyttLJaLamb1UwKe/9pmQbmElLquzehH/AsaVUKjbLy3lry7MMcsEd+ZRzS8EiAnYy+wR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129971; c=relaxed/simple;
	bh=NADZTaYXyQNPpcWo5h/7WJa/jrNFw/QeJt5uX3c9SAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQymGWcdKssF4+C4Xi3uw++aoSz9m0DFBXTFnKNJIKpSM5jyx+4hpsM0PgVRrrGONS5WQvQEM58Z7tZUOp126XqH0NuGwSn8It59QLOwneEau2tkaqWJnRy1QKMvMhm8elNrU836icL1B/vVjdpdk6kcUeEa40QFppN3Ry4gjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=h8cyG2G3; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="h8cyG2G3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1792129924;
	bh=04uaEat7Rr9Fh2I5vVv7mmMDg23ieCg9+MlV7gYX9Hk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=h8cyG2G3v3vkRH9Y6L7nxZGaRVCGovRDobwT3LSscZtaM5IqDD56cWArZArXGMm06
	 on5Vj2RXLpnbeVflJ7q64JmEN+bF6mgDq8qqsFREOZgTpaGMaoFjaXCxSDAwtmaJ0M
	 ALIO9L3ZmVLXtOXG27YbK8wxGvu0W2J9/FPS01sg=
X-QQ-mid: zesmtpip4t1792129900tca8e34c7
X-QQ-Originating-IP: zPMoIHAwRxYqDbLfIG4E73d8/iPU3SU/e4u7IJwVImk=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Oct 2026 13:51:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1068374382040432612
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
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Skip auto_sel write when it already matches the mode
Date: Fri, 16 Oct 2026 13:51:36 +0800
Message-Id: <20261016055136.286138-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260918090909.86544-1-guanwentao@uniontech.com>
References: <20260918090909.86544-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mr5D3cXX4TfKS5Ud28CIOpDrNTNhokKRjd6UvOqkZ+Ff428Ur5wwXahD
	hToEbrwevxIiOSSJg1fPuia5kp2IP2BDHKBxuNs8NggCI29lfjjfLr8P7jweomQEtVNNNwf
	463wF4diL+bDCEB62lTHxPDcDDlgWyPYXKla/BOjpt58o72nzzbzvf3lQupKNlxy7/+KVxF
	C7SNqYhh8gsnQfMezZX+iXWRh9oZHYzZoItUQz9iNqyqgQrjnpD+fm29IPwX7z452xYB6i2
	/6iLdaTV2bO88WJ6thSZCWv/loSohxd0NHYFbG5uBKhf9CIgJ6o36ZeCY62TqjLySFQ4ETg
	17JPLUUaPPUBXfE3/k7jIXpJmFNwcwgB4SOtNqRsScqzhebO66eRsnV3db3VT2V+3Q/bYD4
	ztPmckKfdlJX/cNHIUBJGy+EjplXVx4PaPnX4vDw6xhFeVQffxFajeutiMq4q0F7txpBPlx
	LGXVeZ8tVlRQg3DK/xD1/2hbkD6jDUvOiwiSi58bxHduz16Oyo1eehXibKt7RET/Pk7CM3H
	Ez5uLytspRiDrLoSSoQqNtPh82McI2rSFIpdrlRajUWdSyoxR++EoKIZ+D6nZiTa/0IaTlO
	wKHbBUGidiwImf1QqJznlk19/Hag9abX2m1ogxxvdiXdHu3yX+m39aIA0knyXBy+dTMWPva
	FJ1O1uG58k6nNbaUDHSkz27TjU2nUgkYLmCAThg2Z/vI0x5twq+7fTHlIoF7slAONKAutwe
	0cDuQIJ7yr9DvXq93e803LAU5PZ+FfEoavvaZ0tZ6Zmh24SYqXzlPun0/qE9XFTxHXaqXZZ
	hGEuznr2fJePQ12Cv1Ljf3LKxEUd9wr5Fo+ks+sxY51Alk3eDbRuYPADa4thk+fhtzSJ9UZ
	8j9c+ju0vL4HG2AeaEp7uZddDjI1WGEJSNgsCX8GD8TLOVnVYiV/bEPlAe6DwIsPXVTjYF2
	PEoU6GaiYoTnaoNx2FD9z0D6+xYqgpi4DYs8oDEydoQR9pZPnVSE+Ml+hpCWQjysMi7oQiD
	QDacGUEhZM9BiTF7rfHGV2QxL7c59MsX9BYo93/RTR8g7Vypb/V8yVRyxBZB6i334SQtzTW
	b39dZPUEnMM
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Hi,

> Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
> mode on shared memory systems"), shmem_init_perf() programs
> AUTONOMOUS_SELECTION_ENABLE unconditionally, including in active mode.
> 
> Platforms that exclusively support autonomous selection report this field
> as an Integer of 1, as required by the ACPI specification, instead of as a
> register descriptor.  cppc_get_reg_val() reads such a field back
> successfully, but cppc_set_reg_val() rejects the write with -EOPNOTSUPP
> because the entry is not an ACPI_TYPE_BUFFER.
> 
> shmem_init_perf() propagates that error, so every amd_pstate_epp_cpu_init()
> fails, cpufreq_register_driver() ends up with an empty policy list and
> returns -ENODEV, and amd-pstate refuses to load at all:
> 
>   amd_pstate: failed to set auto_sel, ret: -95
>   amd_pstate: Failed to initialize CPU 0: -95
>   ...
>   amd_pstate: failed to register with return -19
> 
> Skip the write when the register already holds the value the requested mode
> needs.  Active and guided mode are fixed on these platforms, which report
> auto_sel as 1, while passive mode still fails to load on a platform that
> cannot disable autonomous selection, exactly as it did before the
> offending commit.
> 
> Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
> Cc: stable@vger.kernel.org
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: LFRon <ronforever@outlook.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
> changelog v3:
> Include the K Prateek Nayak reviews to remove that ternary op base on current
> condition now have.
> 
> v2 link:
> https://lore.kernel.org/stable/c3eb86bd-70a6-4bb2-8eff-b2a3c0817514@amd.com/#R
> changelog v2:
> Accecpt and tested the K Prateek Nayak reviews.
> v1 link:
> https://lore.kernel.org/stable/20260918054808.48999-1-guanwentao@uniontech.com/#R
> ---
> ---
> drivers/cpufreq/amd-pstate.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 80d99ba1902c9..2d1f5292d1738 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -532,8 +532,10 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
>  		return 0;
>  	}
> 
> -	ret = cppc_set_auto_sel(cpudata->cpu,
> -			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
> +	if ((cppc_state != AMD_PSTATE_PASSIVE) == auto_sel)
> +		return 0;
> +
> +	ret = cppc_set_auto_sel(cpudata->cpu, !auto_sel);
> 
>  	if (ret)
>  		pr_warn("failed to set auto_sel, ret: %d\n", ret);
> --
> 2.30.2

Ping? Nearly a month passed, anything update?

BRs
Wentao Guan
