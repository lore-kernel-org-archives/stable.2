Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E145C715;
	Wed,  7 Oct 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367472; cv=none; b=EMu2oaUI+QGQXVUJ0OMwgYleSQTT4g4y1PE+8ilgjkPxsWMVIevDtEQkNVJJZIBOPesNA26BQuDM3kx1f+GC25ujzvl8GXQqv0GARmux+KFOpL6LVKA64OcJRWATJkkTTdKRY/IySSEZ6N3JU6vLZnAvpQjjKoufE1ZExBsSmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367472; c=relaxed/simple;
	bh=bAJUbUCeGXOZz8I26AnwsliiSau6S47B3Olne+maCi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZSH4psi4yosZPw3h7MYcy5Lv0JY9yAuBXO+uPDUY7XFaekJ436wzCtZD1KW+cz2RYLEQEWxq94bY/Ud600ZveUX/moHN8D5phnmPvoR6L0kqvSYnfM2+O3Izi0rJTR43f5sHRxIcmScHYDreXXsTopCNgptCAMGz/GE0zo8Hpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0zVdfXMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0zVdfXMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4A31F0089C;
	Wed,  7 Oct 2026 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791367461;
	bh=WoqAIkm+xY42LFTwP6HEJV+/LOvYIfvcjYvfB00PeLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0zVdfXMWw7dDhMUdBr/WnXVVtmuMgQsDB6FQ+HKqluTinGAKjNfG5F6CswPTgBRDF
	 2vexbzWKZiW/Z4X3nkaTl2EnBuGoTypNTd/Dq1d8hTjL8YWKSwKeymlH3AxrrHNNrT
	 kOyfGwFTrWQacykNZ7nPyFvPpX2iTOjUSiyH/J/o=
Date: Wed, 7 Oct 2026 12:04:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gilberto Conde <gilbertorconde@gmail.com>
Cc: stable@vger.kernel.org, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	netdev@vger.kernel.org
Subject: Re: Request to backport "net: usb: qmi_wwan: add Quectel EG120K-EA"
 to 7.2.y, 6.18.y, 6.12.y and 6.6.y
Message-ID: <2026100709-marine-blasphemy-82a6@gregkh>
References: <CA+rCdHiuoYZbg9F15+_9AzvY8go0zfHJMfwdTgV_MhHKfCvQ-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+rCdHiuoYZbg9F15+_9AzvY8go0zfHJMfwdTgV_MhHKfCvQ-g@mail.gmail.com>

On Wed, Oct 07, 2026 at 09:57:56AM +0100, Gilberto Conde wrote:
> Hi,
> 
> please consider backporting the following mainline commit to the 7.2.y,
> 6.18.y, 6.12.y and 6.6.y stable trees:
> 
>   0f2fd31f63c6 ("net: usb: qmi_wwan: add Quectel EG120K-EA")
> 
> It only adds a USB device ID (2c7c:030b) for the QMI interface of the
> Quectel EG120K-EA LTE module. Without it, the module's data interface is
> left unbound and LTE does not work on devices using it, such as the
> GL.iNet GL-X2000 router. OpenWrt currently carries the change as a
> backport on these kernels and would like to drop it in favour of the
> stable trees.

Now queued up, thanks.

greg k-h
