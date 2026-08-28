Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8C02ECE91;
	Fri, 28 Aug 2026 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877089; cv=none; b=CC3idNFJ912zlWBvjbVOemuucb/mEwoJAzBOomYI4aXzLUVhBuibWH9sYzkJPhr3tROiavsvgu2waMNYdRjdEB4gfUK+vMS3fgw+6Hsskkfcx3YBJ9TtIkpWYZwonM3FaVw45if/0GjwvF074y3txY+7yr6Ut+28f8vWeLMDbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877089; c=relaxed/simple;
	bh=w+KXt7U7nlboEKCXv1e9s5fOp/EMBCWexVKjRbpeOUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpx/JqwfmeAHWz2oQ0u02v/WoGhuM/aOUd6D6LaCWUCZpVqD+y1NwckrQSlBvgqe/oUZQDyrr/VhdcBlVRoumoU6gyrDKosKHu6Pe7vuXV50/qgt9ZkxzYJXBOIBU3kqDVIWCNC4NY8R1UoJrqRyZsUiv5g8RHuuvOY29Mo0ApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDIYYHYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDIYYHYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8572A1F000E9;
	Fri, 28 Aug 2026 00:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787877088;
	bh=DDs/IgtcyA2iNQshNSKoobEdBthjwqlVPbosXiUzsvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RDIYYHYY4XwrKi86et8YTt86/AiuOhLZtQg7RK0+Gi67JvIJTZusb1+7LloCvHg0W
	 Y0UvgOGEEvjyIaN3z3wPPWasYDeQ15QPzMjTkRyZuxf0wCYj0usmAhRS7MsO3eQm7v
	 uLICK7OdNixAb+4tHlnx57lpMBXyFt5SD5/ayndTNCyq3HJMMRt5+s+MZ9kJLLLj9k
	 alP8l5Z1orPKDT34SDTkqpWWe8v1cWO4JpZSmMsdSphNnbup7cZ9D0DqyFUQlYoVsk
	 Mi8OAmHDsHM7ACJAvCBNNAlyBsm69mKpMgNwDn5OPQUPKB4d1bwx9Ox8zOMvaUOD9h
	 H9LUrbGUJWdsQ==
Date: Fri, 28 Aug 2026 02:31:25 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: qcom-geni: update frequency table to fix
 timing parameters
Message-ID: <apDWHic5S1FP8dX6@zenone.zhora.eu>
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>

Hi Kathiravan,

On Wed, Aug 12, 2026 at 02:00:55PM +0530, Kathiravan Thirumoorthy wrote:
> In IPQ5424, to meet the setup and hold timing requirements in the
> standard mode, update the frequency table with the values recommended by
> HW design team.
> 
> Also remove the stray space in the I2C_MAX_FAST_MODE_FREQ entry.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 85c34532849d ("i2c: qcom-geni: fix I2C frequency table to achieve accurate bus rates")
> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")

I guess it's OK to keep both Fixes, don't see anything bothering
here. They both should enter from stable 6.18.

> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

I pushed only this patch to i2c/i2c-fixes and left patch 2 more
time to address the reviews.

Thanks,
Andi
