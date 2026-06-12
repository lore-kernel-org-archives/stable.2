Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E22367B73;
	Fri, 12 Jun 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289904; cv=none; b=akLQ/1j1Y5UZTFfWzO+2E0AVClLaKcZQNoB+YqerPy09lXkAQdcYuoPJvyIrhl8d0NzHOb+yVcDIz3XnPbvFOP6c7SHOOCIZitfkxj7LA/z35GGNhpz0fdkR9+XMHRrXG10qbtrlhNj6UC7sQyisGhnzA8m14vY3Jo+2FwIzG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289904; c=relaxed/simple;
	bh=NhAM2rnivPz5BrNpOWCW6/ItHr2V9Q+DfHIs37fwR5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcR45EAV0fd/+3o1+MN1EgeYx87l/VGKHTI36j+RLoEN8GH+VVbxQXLqMvg+Ec+6DCeRVbJxetZpWk0Bz6j2pnaij1XvKhuNdGKlIY6NpWtIe+642boyJPhvfVd5PtYk0Zg96aG8SYkEe9AuNy4MqIwYs198Ov9p2MDm22I7aX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J9hiYqXG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J9hiYqXG"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 91A2220B716A; Fri, 12 Jun 2026 11:44:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91A2220B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781289883;
	bh=NhAM2rnivPz5BrNpOWCW6/ItHr2V9Q+DfHIs37fwR5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9hiYqXG85M4v/+2kHazB3TUmUJow/1MO+KGeI3+8TYKwlUASGUH7Ou3X2i+Kli1v
	 7+sVjMKPKZgLObLM6RXS3x8AKKY0tQF4IQuqSN85KEUgCzxALzOWXnAhxFW+Hq3JAF
	 SzhgvqPMKR+8MQFFg7U47dZ/eJg7C+ssHAx2VsR4=
Date: Fri, 12 Jun 2026 14:44:43 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: add hard timeout to wait_for_response()
Message-ID: <aixTm07GodS/Av9c@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com>
 <SA1PR21MB6683BAA40F52C52150D7811ECE182@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB6683BAA40F52C52150D7811ECE182@SA1PR21MB6683.namprd21.prod.outlook.com>

On Fri, Jun 12, 2026 at 06:04:22PM +0000, Long Li wrote:
> What if the VMBUS response comes in right after this check? The completion is allocated on the caller stack, and it will cause kernel OOP.

That is a fair point, I'll try to see if there is a better way to handle this error case.
