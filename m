Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E524DFF9;
	Mon, 21 Sep 2026 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985048; cv=none; b=iOPTT89OhphR1R3Ord30fZkU4r5VNdZxswR31pR0jQfhed7rckLM2CIw4AVcQ3Zr0qcZOwlw51qIGfk1/W4SPm8WBH6F8Sgz2G8f0ZQa3biHvh9ayJnd0Gcm5TnV29DD9sR5bmEEMYi7MdKgzL5JUBrh69fx+kvuD6qmA2UFlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985048; c=relaxed/simple;
	bh=vqe1anqrH73ZYZJ8pspdjyri3NMOBeodwVDouCv57Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLmpzi0sYVd3QbJbJgaRYNntibBdbs/xaJLZHni5DgvcEuBPThvlWgrTlWdbHtkcYdCpyRI8huYF6YkuE5PBG/dYaMVkehARdWqOtB7IUvGTmw56P4iZ++zgA3rzrYEI9ohPa2PPcBEnFwgWeLvjwIQqcFvt7RD2CYzgYIDPV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrM2UDI2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrM2UDI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5A31F000FF;
	Mon, 21 Sep 2026 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985047;
	bh=8ADuUsrRS3h/7DwUQhJ/VbGMEZuAgKj089MxrWSS3OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OrM2UDI2mSfJoh1dXQFTTXc6T0VaqMmEYx9TgyK3b1HDVuF+1BrDagMT21LxvR29o
	 qNm0asx4n198KhIpoK7eH7LfNAhrX2I/f8TgAJF3pn0JZMT1vn5fyTc8QDsQE6YENi
	 hd8ScdpPDm+bOXCnbMejmP8GW6KViHJ8n61mdeqRV/7loigxKFJ7oWL5iHPt2o12E3
	 3juyHfRwc5iYQIKKzaTHXz4Uq04Qs1+V341m/hbKr22Z7jBeR5S4fnHLpp1VquPHlP
	 802F5/J71NQgA15BHGVV/UQ1yyvC1zmGGWE8C92MPZt3gEmuOSKl10JVg8qL0i8y4u
	 aFX8Exk6Hn48w==
Date: Mon, 21 Sep 2026 11:04:03 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	igal.liberman@freescale.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, madalin.bucur@nxp.com,
	netdev@vger.kernel.org, pabeni@redhat.com, sean.anderson@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] fsl/fman: Fix clk reference leak in read_dts_node()
Message-ID: <20260921100403.GD13925@horms.kernel.org>
References: <20260917110135.2148068-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917110135.2148068-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:01:35AM +0000, Wentao Liang wrote:
> of_clk_get() returns a clock with its reference count incremented, but
> read_dts_node() only uses it to read the rate and never calls clk_put().
> The clock is not stored anywhere, so the reference cannot be released
> later either.
> 
> Release the clock once its rate has been read, which also covers the
> error path taken when the rate is zero.
> 
> Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

As noted by Andrew Lunn elsewhere, fixes for bugs are present in net
should be target at net like this:

Subject: [PATCH net] ...

Also, perhaps someone else has mentioned this, but please slow down a bit
with your patches. I see 19 in Patchwork as of writing. But we encourage
a maximum of 15, and I really would like to stress that is a maximum
to be used sparingly, not a buffer to be refilled.

Link: https://docs.kernel.org/process/maintainer-netdev.html#limit-patches-outstanding-on-mailing-list

I don't think there is any need to repost because of this feedback,
but please keep them in mind for the future.

As for this code change, it looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>
