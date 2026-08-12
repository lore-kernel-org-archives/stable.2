Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70E28134C
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493603; cv=none; b=get0gyx2R7IBXYZw0SGiCYIKEbpxmPESsyYWPyTMTN/KILhHGHqYNHYGNGMUVoPHbEdEeYtulTbjcpsufh2FGFcW5edHdACAnGEFdQfk5hulBuHQhzH7vFMqy4EnH6qYGUral27vSzRylPOgq38IyS1KC/dDo+MzE0+MRplSS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493603; c=relaxed/simple;
	bh=xQapoo5R68iqZSPtwIjQxwsShf6RN0Z6A+z8nvbOnMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPIsArmon0mhIm+zfIxgWsqdoU4z/37BUOgq9ldHubaScLqEmu2bli4gGa2Akt4ejbTfYlsGft74tqhVBNLjLBmm1sJJA+32W89oO4kLVirw/dhJWoEiCNko3k6R8l+b11E0dh4ZL2zRktTuG2cU7oYefAK7GCocn/AMK16L4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QGFuHz3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QGFuHz3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0241F00A3A;
	Wed, 12 Aug 2026 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786493601;
	bh=spQMgneVP8fEYOfgaKT1GnQKO1+Iouev1im9NBH4dU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QGFuHz3gjn5NN9NQwb2N9hZZbp7dAdKUZKbzFnrvwmVIj8V65FsZAwtiTurg0DLsF
	 NMcBRbj9leKXXOHRKkPx5NVoRe42MqazwrwS2z1Mq+iIgXAAk99LkBaOfQsi+Fj0hf
	 zp+T9OnmsSoHz8STrHwmjnEoAHyWPwwju1S55t7c=
Date: Wed, 12 Aug 2026 09:11:49 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: stable@vger.kernel.org
Subject: Re: linux 6.6.146: NULL pointer dereference in update_curr+0x149
Message-ID: <2026081227-bounding-commode-9cf9@gregkh>
References: <CAOcd+r2bxm_T5ZzYGfrYUjsbY8Kj=OgeCcdg1c4Msi01A0imdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOcd+r2bxm_T5ZzYGfrYUjsbY8Kj=OgeCcdg1c4Msi01A0imdQ@mail.gmail.com>

On Tue, Aug 11, 2026 at 08:27:42PM +0300, Alex Lyakas wrote:
> Greetings,
> 
> We hit the following kernel panic in stable kernel 6.6.146 [1].
> 
> Any help appreciated.

What about 6.6.151?

And can you bisect to find the issue?

thanks,

greg k-h
