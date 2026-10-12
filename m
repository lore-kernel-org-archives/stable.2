Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098E4AA007;
	Mon, 12 Oct 2026 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820988; cv=none; b=B4KNoVYQcpUZaix4neD6YBEaBKe8NOD9FZfr2LodT/r8+FMiy5IW6b0GEBTuFjzKaH1wML63kpMzbOvsb8Vo8N4U/EjqrWM6GcQS2f7lpybO8+zMAoFSvO0r1AiBjeqKcYN0/q4w82rGsajBFt0bnR8v1O7IflINkTAvItMFlik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820988; c=relaxed/simple;
	bh=gbKXfQfbfJmGGBLIpglxM/eZXBaXAZSeNL1gQQ+vIMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtfUPwvSrE1XJ2VEGwjeHUyIBVR5Lwo6ocyt4zCMICs1umHO2xu6tlguVAS6k1RezwQyAEVKL0glKV7YClnUwep+OBjAUCtWFU8Uu09pSkhCMSddorADWZNu5HHX3dCwpYd65UUQ2k9In0k+s/8am/gxwaPk4+lmxuuYBOyA6Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvPL/Vjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvPL/Vjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629CD1F0089C;
	Mon, 12 Oct 2026 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820987;
	bh=HmTB8TMkREzovBL97ThcNv5qR/kUGxn6VCu8bZGRhe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CvPL/VjqX1u95JcrKme/8j+/yWrPu8VV1CMOo2tVEu7XKPpfN5PbPJjcr3DuZojw+
	 eEANxikdntlfTSuyeiWtt0IGr6crOGcxyAhP549dk/uqbcqdevtKrXK3DgOVLm8TwK
	 RhKkR+x44yPxhSiw7N21PjxOTokWe+dYE8SRSjjPuCQGC8GG0pE/Ji5B6lpN4VxUfo
	 A7+v0Uoauj8854yUfJZ4nrRYka86+V6N7xks/tKdxqf/7gXE3GvKFAzQKi0iDX91Vg
	 eLmKKw01ASLoOWcoQjlgluohLW25/l6JjKG0KrwcaQmgXqGXer4W/o1+yQISVsnklB
	 OWZi/CbLdMafw==
Date: Mon, 12 Oct 2026 21:32:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	justin.chen@broadcom.com, kishon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: usb: Fix USB 2.0 clock reference leak in
 brcm_usb_phy_dvr_init()
Message-ID: <as0EawoNAbEarKAT@debian>
References: <20260917133510.2153560-1-vulab@iscas.ac.cn>
 <as0DR2jcw2mqnxKA@debian>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <as0DR2jcw2mqnxKA@debian>

On Mon, Oct 12, 2026 at 09:27:07PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Sep 17, 2026 at 01:35:10PM +0000, Wentao Liang wrote:
> > brcm_usb_phy_dvr_init() obtains usb_20_clk with of_clk_get_by_name(),
> > which takes a reference on the clock, but several later error returns
> > -- a failed clk_prepare_enable(), a failed devm_phy_create(), the
> > -EPROBE_DEFER paths of usb_30_clk and suspend_clk, and a failed
> > devm_request_irq() -- return without calling clk_put().  No other code
> > in the driver releases it either.
> > 
> > Add an err_put_clks label that drops the reference before returning.
> > 
> > Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> 
> Duplicate of https://lore.kernel.org/linux-phy/20260913012956.16443-1-mhun512@gmail.com
> 

Sorry my bad. That patch was handling clk_prepare_enable() leak. But there is no
point in different patches doing these things. Just handle all clk leaks in
probe in a single patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
