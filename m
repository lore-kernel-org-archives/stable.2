Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.135.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795342881;
	b=u4KE+NxoImcnVf4+Jm2jrIkSZaza2YgTGkE0nvKLjvWznA677gSBdURWit1Zw/UAJPqd
	 KfnqWLtzZZG3FTmGQONTFJf9BfRIKJYDU+fYE4/Wx8hI7pwz6QpzXqAsTVoL+Mu2hSnn/
	 W1x3EZ7SQKrRw9WPYak4n83KFhKKo9lSvgMvsOPgnEZQAi5mIO++vOLXZFUaX75COLK6t
	 IFYAIGpan3qgyxHsPw4B6kRzYjZ07JII0e9QeGC9pp2ZEaKmG23YvuOOGseg3sYin7SB0
	 H0iv7OF7Wrs+0Id3NAwEpiE3JcgDRnx07TDQJwLHBc4sZqYTqQAiKQePdgSsVinpigw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795342881;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=MoMi+T5dU+9FbuOgiDkfYbZ8uJ+mlUtaemF5OVD/pgY=;
	b=MWiydW3D/0GwDHUCxtpAvj6EfiYxoCbMYo+vklzctZNqM+te9MXcWZ2I9GucEye7pP8m
	 K22CF1u8s/RrvQl9pyygG7B9dJCvd3ZHj2B3TYtuJUzUny7Le/91pH4DwkqZqmqMERpP0
	 B7nXaquPn6WIhJZamppyBQzlE2ihaqB6WNAzYMJQaq3Idfz58VSWba8pRlhUgH5TY2ik+
	 triGah2f6jO8/UyiInzM7rVJjEhmF4AJeUY7w3mQBKYz2+DUb7NQjeIzigRBVJ6p/zx/2
	 dWv6glcEJ+CPcl/g2QwRgT2WSEBJNh7plzXNUpzHLBeKzQ7eJ+zcySsuU2Hw2FJeiZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tsv-stahl-riesa.de;
	spf=pass smtp.mailfrom=tsv-stahl-riesa.de;
	dkim=pass header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=FsqFkdQU;
	arc=none smtp.remote-ip=85.13.135.14
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE464606A32C;
	Sun, 22 Nov 2026 10:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE464606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=FsqFkdQU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
	s=kas202608160020; t=1795342878;
	bh=MoMi+T5dU+9FbuOgiDkfYbZ8uJ+mlUtaemF5OVD/pgY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=FsqFkdQU2MuGs4LfJXpH3oHSyVtZMaQNekaHNUjQupXYLWg47aBjsUlfXpZrneypJ
	 c6mGX0w6UnAdLf2ReZ6VgAk+cB0Ga1GfZsqsxcN/0ZvInSxmDGwClPBkrNdIqUcVOr
	 HIWnW9R3Bd1pApwIS2xKYRaZmq/OUxH3frl3YJCLm77dqGHhDhnOVBu/aqgYRfe4WR
	 EtjEACD6laqjbYboDQDXyMDwTQXkk6ASl6ppA+C0kAe5+0m1ePtQiTam9Lijjzchj7
	 vNqdYAhoBXu+7X4jpQ8rM3BMPNHrz1otmmK/ZrU+1MJ8vAJjjgNuTvZB98NnY83tkA
	 HWLNM0wq7dZuA==
X-KAS-Sym: v3:f51bdf72230551df:qJ5uOu2tDOwck04l6ZZT5ZgS9yYs6RwmRLkVQ2e11W2Qg
	xi4Fjh2AYzKKX2gAyElm3p0uCqidYfZPAU5b1CzV46YKHzkqvcvF9ccxgCloMJKvslloO6MCVfr
	6QdObSfYmUNWJ/0ucr8ReMwDqZqTusb+gYriedhqiF3fS0N72iVo5FfV8U+j8sjgdQrvg+UEGp/
	pMFOz7n2SOuS/Di7sMFu5a52da6xM7KbRWb1W+CP2vGKw25C/j+ejlSDMMtN0jrrQDY3+AOavU4
	QcErcPgCm854wBnsoLaG1yVxs1QYz+HjGQnrwyrtb2YfxTOOrtB2rQBg75sAG60ujUMzYTiA==:
	MjVxFkVcOFUItxuneoAiSada4ZD+ZGOu5XniYzG+8WmY8bIEufFopQoXTUXK74DRDE0DOnNzCPZ
	xp1npeJVtRp4U9ZVZ3cSKFjIsnPpGCz689q9ChBkoOG4KRZXaXoDGpxr/KXQCSQjD61ALCKu/V/
	EQc5aoPvFJ0eWk0QgM3aPW8+hW7hZO++P2QmS6yhndW9/dryGr/4ya9T2vSIjGnPNaBpVwSv7P2
	AFaKv01ixGz5hah6FNkL3Bgk8KlDrPfmI4BbclcVpU85Kc88bfg4X7Npb5ZWV9O+koFM+7MC7EO
	BECU1Oz56/8/Obb7vHNQO5JklZGGnu0P7CgMUMGGWJe8Aq0Uq0GOoSEzQB2AhoaL60AxL2On24q
	Sgdyo6N2NZVyOljscUn7yqbQIu+l+B3xFdFlzM4rtUYPShWlaXF9ToWmnZqwJQVa0qlEnoJIbgC
	VjyRcX8qSE9XXhx3NRIDcrEV4GPhWa/nbcVADM9INGS3Ad5YMo+qCGHD1Rbs04M1yHN+OAMZSA+
	2gxrenPllvnBaFZ/LRxOnSmkjNmEHpauHZxAb4YrQ9JXpMur7UCOu6fGdNK0YTfPEXfbRqmj1Oq
	oZMsHcTC/hOANd6FY74=
Received: from [192.168.2.174] (dslb-188-098-197-218.188.098.pools.vodafone-ip.de [188.98.197.218])
	by dd13108.kasserver.com (Postfix) with ESMTPSA id 5F51178203EB;
	Sun, 22 Nov 2026 11:21:18 +0100 (CET)
Message-ID: <57a7461f-8c0f-43b1-83e2-e2867cb35e0e@tsv-stahl-riesa.de>
Date: Sun, 22 Nov 2026 11:21:18 +0100
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
Subject: Re: [PATCH 0/2] thermal: tegra: Fix SOC_THERM temperatures on
 Tegra114
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ----

Am 06.11.26 um 21:31 schrieb Patrick Fischer via B4 Relay:
> On the NVIDIA Tegra Note 7 (Tegra114) all four SOC_THERM zones read 0 C
> with mainline, in idle and under load, so throttling and thermtrip have
> no effect on this SoC. There are two separate causes:
> 
> 1. tegra_calc_shared_calib() sign-extends the whole fuse word instead of
>    the SHIFT_CP field. On Tegra114, where SHIFT_CP is not in the low
>    bits, this distorts the calibration of every sensor.
> 
> 2. The hardware calculates THERMA * capture in 24 bits and discards the
>    result above 2^24 (TCALC_OVER set, TEMP_VALID cleared). With the
>    calibration in 0.5 C units a Tegra114 sensor is only valid for
>    T < (2048 + THERMB) / 2, which is far below the thermtrip
>    temperature. Patch 2 switches Tegra114 to 1 C units, as the
>    downstream driver does. The fuse calibration stays in 0.5 C units,
>    as discussed in the review of the Tegra114 series [1].
> 
> Patch 1 is Svyatoslav's fix, unchanged apart from the Fixes and stable
> tags and a sentence on why the other SoCs are not affected. Without
> patch 2 it gives three zones that work only up to about 45-53 C on this
> device.
> 
> Zone temperatures on a Tegra Note 7 (P1640) in C, idle / after 60 s of
> load on all four cores:
> 
>                mainline   patch 1      patches 1+2
>   cpu           0 / 0     41.5 / 55.5*   43 / 63
>   gpu           0 / 0      0   / 0       39 / 55
>   pllx          0 / 0     44   / 52.5*   43 / 62
>   mem           0 / 0     39   / 50.5    39 / 53
>   thermistor      -       34   / 39      34 / 42
> 
>   * the sensors behind the zone were already invalid, the zone stayed
>     below the real temperature
> 
> "thermistor" is the board thermistor on the PMIC GPADC, as a
> reference. With both patches all eight sensors stay valid and thermtrip,
> throttle and trip thresholds are programmed as 102, 100 and 90 C.
> 
> Tested with v7.3 on the Tegra Note 7 P1640 (me) and P1988 (Svyatoslav,
> all four zones work; tags to follow from him on the list). The series
> is unchanged on top of thermal/linux-next, but only build tested there.
> Thermtrip and the hardware throttle were not provoked on purpose, the
> highest temperature seen was 98 C. Suspend/resume was not tested.
> 
> The series is independent of "thermal/drivers/tegra/soctherm: Program
> throttrip with hot trip temperature" [2], which is still pending; they
> apply in either order.
> 
> Tool use (see Documentation/process/generated-content.rst): patch 2,
> its changelog and this cover letter were prepared with an LLM coding
> assistant (Claude Code). It evaluated the SOC_THERM register dumps from
> the device, recalculated the calibration from the fuse values, wrote
> the code change and drafted the texts from my measurements and
> instructions. I reviewed the change and ran all tests on the device.
> Patch 1 is Svyatoslav's own work.
> 
> [1] https://lore.kernel.org/all/22816196.EfDdHjke4D@senjougahara/
> [2] https://lore.kernel.org/all/20261020-upstream-soctherm-throttrip-v1-1-c67f8a02ec3b@tsv-stahl-riesa.de/
> 
> ---
> Patrick Fischer (1):
>       thermal/drivers/tegra: Avoid SOC_THERM calculation overflow on Tegra114
> 
> Svyatoslav Ryhel (1):
>       thermal: tegra: soctherm-fuse: Fix shifted_cp extension
> 
>  drivers/thermal/tegra/soctherm-fuse.c     | 17 +++++++++++++----
>  drivers/thermal/tegra/soctherm.c          | 21 +++++++++++++--------
>  drivers/thermal/tegra/soctherm.h          |  6 ++++++
>  drivers/thermal/tegra/tegra114-soctherm.c |  4 +++-
>  4 files changed, 35 insertions(+), 13 deletions(-)
> ---
> base-commit: 32cb06b34701827db0ff34244d84fc74e40ca350
> change-id: 20261023-upstream-soctherm-t114-9591c6b779d6
> 
> Best regards,
> --  
> Patrick Fischer <admin@tsv-stahl-riesa.de>

Hi Daniel,

gentle ping on this series. Without both patches the SOC_THERM
sensors on Tegra114 read wrong or invalid values, so thermal
throttling does not work there. Svyatoslav has tested it on two
devices, and it still applies cleanly to 7.4-rc3. Please let me know
if anything needs to change.

Thanks,
Patrick
