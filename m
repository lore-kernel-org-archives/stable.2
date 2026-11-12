Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506230;
	b=Id6Cw/RoGK1xJWHEsGfHoy2IBZZhGsGD3BMlK4txUvFoBrxsH2gncHiOYX0ZnXVXgrmh
	 zWI4i5Mi4xWWEML/ueyUkWtUzLt9exp5mfU1gVaT7mcqC+FL+eHBe63YF2JZafbe/GwVf
	 r7Tohz1tXWMXCFrnCa7t/lc1evTep78TORRWzwuAY+naLs+Mj7CAJT8HiNengebvgR0rh
	 Dlsjkx5tkQOh5llsyg34cv43xe2UNoxgGEKepVPIKge+F38IlVCdJ/F60r1/+6g0uHlhp
	 AISGmHRiI8mp2c81mrve8Uf7+PJ5l5mNIxcfvF82de7XPp+8VgSHsGOkBKzbBpMEFKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506230;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eIMLXS4qMchIdJb9Ke98PARc4KmON9mhZsDy8D1MskE=;
	b=2tzDpdgjqiME/BJrb/RkrgYziz+PflQOB/PeRW4mqJoZAiXRnju74lbq0Q+7nM1zhhFd
	 PPZJIA3a8g0kNxeihLWVqxgv3xHaD2Gmq5MsXV0+9z+DDKr6EQgowLFjGkPri2KVsi9kg
	 9tgR8rgrWEAg423LBfuzC4yPsrpE07/Kx6uelbqcpKcDLW12WjWpC0bEc+RIiC5vuqJ1b
	 KYbjbicuqVi3MDa/Ac3XlEVfVELb/CaG649ArngUv6WwB55EdpRFP4TU09dVTVptbkyxx
	 iLbijJF2cfiwPTMmZ++n09IYRrusKH4gCNKVsHgmthR5wh+JpGDkS/Ou6uVOXYVCK6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ha2rj8rQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2F6070F37;
	Thu, 12 Nov 2026 17:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD2F6070F37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ha2rj8rQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6782F1516;
	Thu, 12 Nov 2026 09:57:05 -0800 (PST)
Received: from [10.57.89.53] (unknown [10.57.89.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3CD43F632;
	Thu, 12 Nov 2026 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794506228; bh=wHoRLMxpp6VobDxAN5qyra9zMHbwVP85Y8BlmYS7CgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ha2rj8rQh3U+VewZaJ4W/bQgp16VOjT/3KufP+5DdVFwXMBbtsrFg1Y9TjbfMlQRA
	 mY9Duipq8IJdakWhob1iJvKhGnY6WGJhrwCUHX0jKUWxwCJlWCQpLfV/Nr+SiR9B5n
	 7ibv6reHOChTjI5dkjAhkGupUPsS+Kqj6us9H2Ds=
Message-ID: <472df1c1-e1fb-454a-96bf-4a01dcd383aa@arm.com>
Date: Thu, 12 Nov 2026 17:57:04 +0000
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
Subject: Re: [PATCH] iommu: Don't let a driver bind while bus_iommu_probe()
 still probes its device
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Rob Herring (Arm)" <robh@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261112-iommu-probe-race-v1-1-8c0b986b7e6e@gmail.com>
 <CAEy9hNXRwH9qD-=Gj3NiY=ZVrVq02hAj0dPU+o8YfEmCcbSdNg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAEy9hNXRwH9qD-=Gj3NiY=ZVrVq02hAj0dPU+o8YfEmCcbSdNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-12 5:32 pm, Arun Iyengar wrote:
> Please don't apply v1, and it should not go to stable. On re-reading
> I found three problems:
> 
> 1. "A fwspec without a group means a probe is in progress" does not
>     hold on ACPI. On the driver bind path acpi_iommu_configure_id()
>     creates a fwspec, and nothing there probes the device or frees the
>     fwspec. So a device whose IOMMU probe failed earlier would get
>     -EPROBE_DEFER from iommu_device_use_default_domain() on every bind
>     attempt, where today it binds without the IOMMU. OF does not have
>     this, because of_iommu_configure() either probes or frees.
> 
> 2. Drivers with driver_managed_dma never call
>     iommu_device_use_default_domain(), so the window stays open for
>     them (e.g. pcieport with a modular IOMMU driver), and the changed
>     WARN condition can then hide it.
> 
> 3. Replaying dma_configure for a device whose driver is inside probe()
>     is wider than I described. It applies to every such device on the
>     bus that has no group yet, including a client that went ahead
>     without its IOMMU after the deferred probe timeout; that client
>     would get its group and default domain while its driver is probing,
>     without a warning.
> 
> The race itself is as in the commit message: the client's dma_configure
> sees the dev->iommu or fwspec of a concurrent bus_iommu_probe() replay
> while iommu_probe_device_lock is dropped.
> 
> For v2 I intend to mark the in-progress probe explicitly in dev->iommu,
> have of_iommu_configure() and acpi_iommu_configure_id() defer any caller
> other than the replay while the mark is set, and leave the replay
> condition and iommu_device_use_default_domain() alone. The other
> ordering in the commit message (the client sets dev->driver before the
> replay check) would then still warn, although nothing is wrong there
> besides the warning; I would look at that separately. If you would
> rather see this solved another way, please say so.
> 
> Tudor: you are on Cc because this is the same "!dev->iommu" gate on the
> readiness check as in your thread
> <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>, for a
> different case (one IOMMU, concurrent bind).

Really the dev->driver checks are less than ideal, as they're inherently 
racy with an unavoidable false-positive window. What we could really do 
with - which might now be viable with the recent atomic device flags - 
is a specific indicator that a device has got far enough into binding a 
driver to be past the point of waiting or an IOMMU. The 
BUS_NOTIFY_BIND_DRIVER call is in fact in more or less the right place 
for that, so we could potentially do the flag management from 
iommu_bus_notifier() rather than clutter up the driver core with yet 
more hooks, but the flag itself can't be in dev->iommu, since its whole 
meaning is "we assumed this device didn't have an IOMMU and now it's too 
late to safely change that".

Thanks,
Robin.
