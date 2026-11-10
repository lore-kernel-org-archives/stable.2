Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316267;
	b=X8P9ixKXuZfYld0j6LAqBkFcRDZbcnPxrAmHCDKnHoDdCqbgN9oLe72Gw8h3dpz60rwh
	 yitYxTGiR6myKylCUOGRDOH/Q57/DiEcBefwoG3m7Y+abvga8rSdM3u5Y4WZFgqY5TLKS
	 EnKIP9TaxYF1m8STgkkvcY5rg8l1Jl+Uaj9TLTf+OWCmv91QN+0FgcxHQqSOzxPhl7suy
	 J3dY+Tzkai2bOZ8N4CDxn1nxukusbiLf6JvA08kQJMPU4gtypg6rLYSUjUnOzqJcUlCN5
	 Jh5WybQBJQfTeHAshycLYUHPX3wcyI5JYPOQaPkLplz0LqESkdVoDkFCru0tB/0htoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316267;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HVwTPv0aAkMcnMSXVyynB+Ri9xfpkvP9QwlW++M+nbk=;
	b=fmbcX41UWTIGtqPDAnJ9dP4Fpc8nq1UnGuJAIL1EoO7Z39vhiSFmo9qZBDr/GVByE8/y
	 NPETx3DrV3z1wQK62JmygkrbjFtjfHpEwVwKPlTh0BAKUQB8p3BAsSdGMEwnbn6dTQIA8
	 3SxFAZu2AwNLoyQ0m5GTw1/WlmmBPPg0xoejo8AuyNe6jnammyQhCQWl3hPqE9zjHjOGI
	 aHQLJ/g1SQBLjnMghGtsPyaPI1S+U1hEW0ZsM2/m4bO6DG5gvthfmRLGRoCYoG4eQTXk3
	 1wk7uzS8czudnrzudSCuo0EyWS2vRCk8Zpy9dSdFBhZ4k2N8PhenySgghpJXmJR2cHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AfwVAG+u;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B003606A7F1;
	Tue, 10 Nov 2026 13:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B003606A7F1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AfwVAG+u
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0086339;
	Tue, 10 Nov 2026 05:11:02 -0800 (PST)
Received: from [10.57.10.132] (unknown [10.57.10.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DC9B3F632;
	Tue, 10 Nov 2026 05:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794316265; bh=thV59Vj2cTuwftZJRbXLZrc4Kc/P0jvK+3eu/9gZEUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AfwVAG+uI+ZgDWDEdxSg5XkJOwdNS/aY3MlutxrjVZp/Q3XZRJygBOXhxIwxGXAN3
	 RRh3GxhbgiXoKOLWs8CEFT71TotYUP6HcbQoLq/UvtUPJYte9gSN1yQuenqv9rkngA
	 GKltRZkoZPILdMvyX8VbrXZ9yX7a0oIf0o5PRseE=
Message-ID: <4f0c8581-a8fb-4bc4-82cc-d30f2f56d2ce@arm.com>
Date: Tue, 10 Nov 2026 13:11:37 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency
 ranking
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Guo Chen <guo.chen@oss.qualcomm.com>,
 Vincent Donnefort <vincent.donnefort@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
 tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
 <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com>
 <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
 <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com>
 <6b0ee061-38b9-413e-9a83-90446b484859@arm.com>
 <CAJZ5v0i8a98rjFdQ2Jhu_Xk=qCGiNafMfhzNs26cEJNCYB6Xdg@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0i8a98rjFdQ2Jhu_Xk=qCGiNafMfhzNs26cEJNCYB6Xdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
> On Tue, Nov 10, 2026 at 10:58 AM Lukasz Luba <lukasz.luba@arm.com> wrote:

[snip]


>>
>> That's fine, please continue.
> 
> I have a couple of questions though.
> 
> First, why is the ondemand governor mentioned in the changelog?  In
> the mainline, the ondemand governor cannot work with EAS, so it
> shouldn't matter for this issue, should it?

The ondemand is affected by the EM setup code and set 'inefficient'
flags for some OPPs. The EM is also present for cooling devices
and can work w/o EAS and schedutil, w/ just ondemand governor.

Because EM marks the OPPs kind of 'globally' as inefficient, then
they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
In the EM code we have:
cpufreq_table_set_inefficient(policy, table[i].frequency);


Then ondemand check for CPUFREQ_RELATION_HE will skip them and
pass to __cpufreq_driver_target() with that flags as well.


> 
> Second, why is the issue regarded as a defect in the code and not in
> the energy model?  Arguably, boost frequencies should be more costly
> than the non-boost ones.  At least the idea behind the boost is making
> higher-cost OPPs temporarily available.  If they are sustainable,
> treating them as boost OPPs is rather pointless.

IMHO it was a bug in the commit mentioned in this patch fix tag.
It is affecting more than just EAS or EM, since the EM is working with
all generic code and all cpufreq governors.


> 
> TBH, I'm too comfortable with looking at cpufreq frequency from within
> the EM code.  If that needs to be done, something is amiss at the
> design level.

I think this edge case is special, as I described above.

I'm happy to hear your view on this EM influence to some global
setting in cpufreq. Maybe it was too far to establish this
'inefficiency' flags in there for many usage?

Regards,
Lukasz


