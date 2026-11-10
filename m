Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331713;
	b=5OfNKnYje78sySFUvjPwEm3/RRfqDI51G8CaKjeClkf1z4gxFQwugfpNyFLWdmcMEw24
	 NJO4NraYUpNDvk9+YLwOSLDb8qw2DXizv21X6N/SonWWy4UwJ2Lk40s2BBsN45KZvAomt
	 niZrAJx4O8Y11AGv7H2s07qmYe6vx3s1OFUQj+4LL6fBd3dLDzk2sw7FdOjzsvQBEoxQe
	 rGSFDRNwvvay7eH6SK02LYRdqBbHPLF6Oso1pOu5cyrD4I8uWVPLzEe6/9NEAE9KfhRK/
	 dYV2B7k8D32c2syTNWB2GZpMc5V6Rai2mRDXb+dBzy6h8agNsvnFR1TyfgM+Bk0uQiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331713;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BQiR9KXvsTVPL/1Zqbc4KD75wts+2IaCB1iOX6lOykw=;
	b=Ut7rdsUk+ZV3epjyBE6gG7K6cX32Oip5b0qPHtoJIpAXi9GyhdaWiB9JPEP9913NuYxo
	 kcEJDXHI0IjnE63uoZIzyOSNO886EQMsovj4iIXHd3trvf1twUe8yOvq7dvLRhG44qzFV
	 6ZwrGF4jn9vaCy5HurLJwnGcuTH7l7sgoEbWrGHHrSjBRQHuGCh1WNoak5mn432yOk9RK
	 tc1z7OYelIeaC+hKnxNv0SNtNMK6YVKQ3Z8oMvWS3qOvoQHN15IrNkSJQKMipgskdeoDo
	 /Z+++576JfnZj61AoXfysGRPxjUNBw5d+nG3FfzlZQ6izE2723Vvsohkk+9zXxWLP/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJKdN5rp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D66606A31C;
	Tue, 10 Nov 2026 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJKdN5rp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C5F1F0089F;
	Tue, 10 Nov 2026 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331712;
	bh=BQiR9KXvsTVPL/1Zqbc4KD75wts+2IaCB1iOX6lOykw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BJKdN5rpa55lEEPJYQrOjgPM1OQE6kUdh/XIzMMV6OhbiI6mq9mEq/1Kf+5QuxV/i
	 k2M3yJsNqHypSOOAeTBQRdv2th46Z522hRZbedoRZSMAra8qrKN/wwziBh1BMwHeLp
	 sDTAg2d+4nBAfWfduZoXZI1vXfUy3B9pf7XZOGjRp+uM722wWUVbWg16NeIq/q2VnT
	 l7mdCuaT9Rm6Wu3EqyRn54UqEGqifwecwFVUUkyzIij1Kb0ioLaLnZXRe62PWibiIe
	 hwpmsRjs2F65DTLK4RnShz/NbI6pqXHiD/ZfwT7UxrE3jHVO4uoHx3XKWlqrPsDj1X
	 nRSsJRNqWqeYQ==
Date: Tue, 10 Nov 2026 11:28:29 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
	virtualization@lists.linux.dev, devicetree@vger.kernel.org,
	kvm@vger.kernel.org, linux-media@vger.kernel.org,
	iommu@lists.linux.dev,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Eric Auger <eric.auger@redhat.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	Saravana Kannan <saravanak@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
 length
Message-ID: <179433170801.751718.12828883568888640225.robh@kernel.org>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>


On Fri, 06 Nov 2026 22:44:25 +0530, Vikash Garodia wrote:
> On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
> region can be larger than 4GiB, but its length is stored as size_t,
> which is only 32-bit there. The length gets truncated.
> Use resource_size_t for the length so it matches the width of
> phys_addr_t and holds the full size of the region.
> 
> Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/amd/iommu.c       | 2 +-
>  drivers/iommu/intel/iommu.c     | 2 +-
>  drivers/iommu/iommu.c           | 2 +-
>  drivers/iommu/of_iommu.c        | 4 ++--
>  drivers/iommu/virtio-iommu.c    | 2 +-
>  drivers/of/address.c            | 2 +-
>  drivers/vfio/vfio_iommu_type1.c | 2 +-
>  include/linux/iommu.h           | 4 ++--
>  include/linux/of_address.h      | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

