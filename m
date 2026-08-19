Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BB31E84B;
	Wed, 19 Aug 2026 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787102311; cv=none; b=kooBXjROe1MLTGxv7+wKmkCm2WleEUuEWWU2W1EKI7uIa9h5+g9mdGQylu3232bMPviRl/s3fh6iE1jE13VeG+rFZzPYnAKatAKKj0G/RenHK1/Pb+XsEq6s3q+DUHZIFZn0pCiygtqVFPElLD4NTkvhOQEekhAxa3XSdKS7FmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787102311; c=relaxed/simple;
	bh=AK+9ZMuDhO2AHryYl9xfvrRIkaq/YSlpctdZHtD0PQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMj0wNehsvcrXC6kXFdV8TsVlUW/pL1wNsAsJyMU5Q4p2aA00QazKyMBDrvgARn7E+AdpOvcGklhgqXt0N59YNAd9sNOgyoX2UAw0XwWxv64Cz02Au//WpT3xrT6PUuRL313t5pejA26cvi26qY+XyM/9DmGG7De1nzWfWd/e+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFoO62Vx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFoO62Vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F811F000E9;
	Wed, 19 Aug 2026 01:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787102310;
	bh=fyBWUSZTxf1Wc73mhhhzdlsZ1DiZ8l86OoGcYppUzgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QFoO62VxpYFfrC7WwPpwVGPW7LoVg5eerJ5jEyRv68azOv8gjE33mLe3IBREP9ehV
	 k4nzykYaDfGFcYrcpcmIcOZ7hoJfyy07MD49HBY/8/3vcoW/h9fXy70Jo4HUXDsBF8
	 6sJyNxPEDKO+rs2t5TLsxIoHPNzqDH+7u3mg46ZrPO7rR2onnV8hW0nrbrZ6tUgs+n
	 Q6gpMDdSdmgytexiZxVU9jYUF6/UUZVDat+hv0yx7Fy7mYdVCnbk09MPV9fg97VBkp
	 rUrHCNjNCp9XKrXSBLMXhlwkp2nuGjERnxC+GoHyXI7Xwqh9GV6w3+Vg4IdOUkmNMn
	 s9kv+Xn4ZjOWQ==
Date: Wed, 19 Aug 2026 02:18:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>, Hans de Goede
 <johannes.goede@oss.qualcomm.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, gwendal@chromium.org,
 swboyd@chromium.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, "Joseph S. Barrera
 III" <joebar@chromium.org>
Subject: Re: [PATCH] iio: proximity: sx9324: Correct proximity channel
 resolution
Message-ID: <20260819021826.702ceeaf@jic23-huawei>
In-Reply-To: <aoQXPzFaMBpD2eC8@ashevche-desk.local>
References: <20260818072803.463864-1-zhangjie14@huaqin.corp-partner.google.com>
	<aoQXPzFaMBpD2eC8@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 11:26:39 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 18, 2026 at 03:28:03PM +0800, Zhang Jie wrote:
> > The proximity channels were previously defined with 12 realbits.
> > However, PROXDIFF is read from RegDiffMsb (0x65) and RegDiffLsb
> > (0x66). The SX9324 datasheet assigns bits 7:0 of each register to
> > PROXDIFF and documents it as a signed two's-complement value
> > (Revision 3, Section 8, Table 8, page 43). In contrast, RegOffsetMsb
> > explicitly marks bits 7:6 as reserved. Thus, PROXDIFF is a 16-bit
> > signed value.
> > 
> > With realbits = 12, sx_common_read_proximity() uses bit 11 as the
> > sign bit in sign_extend32(), causing samples outside the 12-bit
> > signed range to wrap into the [-2048, 2047] range.
> > 
> > Correct the realbits value to 16 to accurately reflect the hardware.  
> 
> > Tested on an SX9324-based device: a phase 0 DIFF readback of 0x7fff
> > was reported as -1 before this change and as 32767 afterward.  
> 
> Yeah, there seems only Chromebook devices (in ACPI world), MediaTek and
> Qualcomm (in DT world). Do we have anybody from Qualcomm to test this?
> 
> Hans, I think you (or somebody you might know at QCOMM) might be interested
> in this fix.

Looks like the actual dtsi blobs were all from google.
+CC Joseph on off chance still involved.

Applied the patch to the fixes-togreg branch of iio.git.
Note I'll rebase that on rc1 once available.

Jonathan

> 
> From the datasheet shared I see the same as described in this commit
> and since it was tested on real devices I'm quite sure this is the case.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> > Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>
> > ---
> >  drivers/iio/proximity/sx9324.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> > index 36c45d101336..de6176fd8d47 100644
> > --- a/drivers/iio/proximity/sx9324.c
> > +++ b/drivers/iio/proximity/sx9324.c
> > @@ -223,7 +223,7 @@ static const struct iio_chan_spec_ext_info sx9324_channel_ext_info[] = {
> >  	.scan_index = idx,					 \
> >  	.scan_type = {						 \
> >  		.sign = 's',					 \
> > -		.realbits = 12,					 \
> > +		.realbits = 16,					 \
> >  		.storagebits = 16,				 \
> >  		.endianness = IIO_BE,				 \
> >  	},							 \  
> 

