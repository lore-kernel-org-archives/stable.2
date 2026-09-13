Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B33537CE;
	Sun, 13 Sep 2026 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789280540; cv=none; b=ljnIzDkXzKBBLtc186+e00BIviI/5Q2s3A+TDmUxZN7O2VQEWulflsibBt78+PodYrtQsn79LpeoxSG4crZwVme3Nd8cgjdAWEA+gPvSqnG0GNE1FZT34eWkRS6kdR72kKbLnnU5h8k+AcAKEWt5sq6emtH4uhuCURKwPlGEM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789280540; c=relaxed/simple;
	bh=8BDEnjodhH2RB7P97lubsAwOpEGrZ7oiAzrRN7Ben1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPqd17wcCG/DH3rNd+Wcc8XCEMIq2ulNl+k3e+wkgv1xyjAQgVHAbQOixpYwQHXED+nkDGIozkLP8sbPTgdcrfijHEXLfBmKSJSUQj/Rp7Hej14iO98FnqfU+41UBu/9+PR5zdHjCRTjdqKkjRWN7NZREkrtijNXOtgkUk/5tAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy+aDC9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy+aDC9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966501F000FF;
	Sun, 13 Sep 2026 06:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789280539;
	bh=7O0ijmU/63M3r27RIHOfPvuoO9Nzvs8zYyUzoD6v4J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sy+aDC9JoaxxV0w0LSHTaYGkr5Sp7dyL5FC3zlcdJX62ZYbUjU3JLD31BP6TkO/f4
	 fUkrlG8gPnHUKLzKyug7JboVFMkUlJTY+xCfnlvu/DPp0Z/gCCeZO5kQg35wU/Czbf
	 sPwuQQ6Xf/VG67+lrmJPbqmvxAcD6VgBGoWvtPdOUZlorJQo3ZSEKlPqTCZGY1wz8N
	 FXpkLJhzlGSu1zoHCXd+zfhcF3UmupNg5QbhVRIppoMwuzu84+jrIiwN2rx8nKYyha
	 oKbIYdx9M6OzwbJkJrZPT9tebELeaKhcW5eDIVNdfLoN+JlT5SVm2E4IrIN8IU/ACz
	 FqcYQfHX6SRMg==
Date: Sun, 13 Sep 2026 11:52:14 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kathiravan T <quic_kathirav@quicinc.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	Manu Gautam <mgautam@codeaurora.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] phy: qcom-qusb2: sort out register layouts
Message-ID: <aqZBFvKu24Ed_IKj@parshuram>
References: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>

On 06-07-26, 16:53, Dmitry Baryshkov wrote:
> IPQ6018 and MSM8996 use the same register layout, however for historical
> reasons ipq6018_regs_layout ended up correctly definig TEST1 register at
> 0x98 (because platforms using that layout didn't use autoresume), while
> msm8996_regs_layout used TEST_CTRL offset (0xb8) for the TEST1 layout
> entry. Fix handling of the autoresume register and definitions of those
> regs layouts.

This fails to apply on the current code, can you please rebase

-- 
~Vinod
