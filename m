Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267A4AA1EC;
	Mon, 12 Oct 2026 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821203; cv=none; b=QCqOizyhDCuY4LzSmEFJxR7Hg6g8sd+3P6m5csWB/UaZbo+StiaO/xsYFona7Hr99O9pZh/f/AWlbNdNHTu0U6NlMTztOD3W3X8Gs/8P9UuWXrSEiXlwt4yhU0LBG3EKr7ERNZj8DxfidnC/CYS94uwTiHvRZB4Ul7N1eLY027U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821203; c=relaxed/simple;
	bh=Uci4dSrAsW9R7RQDC5CuvNfZlHHYLHM41JACXezrLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoC8DhqAxpYbWs7yxwQjqxuw5ZAZDERNfD1c6Ct0w9lkF4NfyCcRvyEcpvQDm+ypkf8jD+xGpB8z+yFUHqM6EHin3kdqRPNM9F1W9BM90EL7EMAvGYP9F8glQeXZ/wnbyxAiDmwHIc7JuiG4LxtRlOKLw49m2iiT2vvph19DgGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV5NNIbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV5NNIbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775731F0089B;
	Mon, 12 Oct 2026 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821202;
	bh=gbkr106sXoUgppdlb+ZSrU2jd/q9tIoiewjkowRaRfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WV5NNIbuTCFo2kzEUuJ6x5ZlINuthEvhTZcd0TCNpHCT8VL8HYaUDutljPXQTsuZ/
	 nUinJb59wS/oEfnjqewdH5z5pOAF+drVl/KdPdcrysY3veHHzvoTSEa02z1La5iNom
	 CBxSbvhqoQ0GGfW6KnBslU5jJH9rtNMtSR0v0mDeItmqpPWwgG4A7robOD8dZ3pON8
	 9/SPVIV70l2CKnR1kwVhuH8cqpHwpTFhNFxr0w9uSUS9SsQxYOd4K5HPPP3opZY4Qx
	 84BPioSvsOVkL0QKlQ1KMxVU7+80i5/FYoGvAAJ0uutSjCzv1Fuf5v1VW8VwbAXUgA
	 vquhjicD63Vuw==
Date: Mon, 12 Oct 2026 21:36:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	mchehab+huawei@kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: HiSilicon: Fix PCIe device reference leak in
 hi3670_pcie_get_resources_from_pcie()
Message-ID: <as0Fef-JdS-fVBLI@debian>
References: <20260917133935.2153674-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917133935.2153674-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 01:39:35PM +0000, Wentao Liang wrote:
> hi3670_pcie_get_resources_from_pcie() gets a reference to the PCIe
> platform device with bus_find_device_by_of_node(), but never releases
> it.  The reference is not stored anywhere, so it is leaked both when
> dev_get_regmap() fails and on the success path.
> 
> Drop the reference right after the regmap lookup, the last use of the
> device.
> 
> Fixes: 73075011ffff ("phy: HiSilicon: Add driver for Kirin 970 PCIe PHY")
> Cc: stable@vger.kernel.org

Please don't CC stable for these trivial fixes.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
