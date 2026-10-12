Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5324A8FDD;
	Mon, 12 Oct 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821408; cv=none; b=qKxfesE1SSXdh/2VbQ3Edez7sOf5Yr4JFFUcsQm5OZnzpRAGEmCYdHCiIm9rTDxQC5Alp5568BZTRRU27PiM0u7w0ETGCdIPDOAXsmLhMqQ+NjLLhnpXcTPN+UKS5Zr9EA9H8gXXLb1jmpWiFnvQPyABrNY6o6fXkrqkjQBa76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821408; c=relaxed/simple;
	bh=FBtcCoxXM6YzZS+Iz4opstP4BKO8buZiSzZEHbDK8qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+yNuV6V6S6A4IE2RFNHTlZpH5Om6XwFqA7Q7mRazF1jhNDSV+nmFms4qSNqZnpZd35fsfmils6ldGuUnimNaF/Pth9cG3208EGmlQ6Vplc14e3uBlboHFafs3E5KV1Bp5qvcebRfCQ00QvvySOdh47PDJRlc0c6OkHmE+2jPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2kIGQLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2kIGQLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119031F0089B;
	Mon, 12 Oct 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821405;
	bh=7KAK9Ha46yxLOafPMgOcsQUsdwCoqPNAXO5r2ANiEQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z2kIGQLb7uS/hU7K6MupmDTHy6YNB2rPp8yAil8KxKP8Tn44p84DOTVQjndtMwRhk
	 NriywCKuuT8jALq9NWpLq60bLDOZlcF4HnVWbUZfmHqKHnpB83P4ee1fY8YAi0fxpy
	 OfYEb+7Gv3MXbkNddTfJTRT9K6tXi1hfdCmhdAX8ONT5ZSIgRDJcpWmRhAqQC2XYfM
	 9ek4nOX5ol/A6C56sVB3mkdGKXIkrdJzNzWjDHtNebez1yluWQW/0zIPr8JqzLF2AE
	 nH9LOROEhdqFmFcQJ7ZE6LllAawk5JnZXqBw+Nxfm3npb262e302DBhKerCGXh2PVY
	 drOQx2Ubi924g==
Date: Mon, 12 Oct 2026 21:39:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	mchehab+huawei@kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: HiSilicon: Fix device node reference leak in
 hi3670_pcie_get_resources_from_pcie()
Message-ID: <as0GUIYPYYoyq00T@debian>
References: <20260917134144.2153731-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917134144.2153731-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 01:41:44PM +0000, Wentao Liang wrote:
> hi3670_pcie_get_resources_from_pcie() obtains the "pcie" child node
> with of_get_child_by_name(), which takes a reference on the node, but
> never releases it: both the "Didn't find pcie device" and the "Failed
> to get APB regmap" error paths, as well as the success path, return
> without calling of_node_put().
> 
> The node is only needed for the device lookup, so drop the reference
> right after bus_find_device_by_of_node().
> 
> Fixes: 73075011ffff ("phy: HiSilicon: Add driver for Kirin 970 PCIe PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
