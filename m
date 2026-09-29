Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD443DB994;
	Tue, 29 Sep 2026 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790723572; cv=none; b=jmB1ggp1q6PA4uDaEEESJu8xfImuCmnEOdIuU/BZNC9NYFSQxHK6pQntk4agzZJ2QptQBnk6tyR3StiaSuhbUK+PjmBDah1e98OE0nmOMgYmT67n1UZc3sklfiXZTy5sfy5lKX5EeeQRlg6+vczp5AUUoA9MB88jH8kC4ZpUw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790723572; c=relaxed/simple;
	bh=z4PLtxqtGwCEBgSls2uKze3odixUtuWpbTV/YAG3KIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5AmIVL9cIrZqdNO2XuNP2kDmxXCwBz8ytaxSeasXeeGdXGqavuujYdXExCghx3xeTUNrfWPsQ4IeJVKiYDxvmleggyvFbl2foVcvpK8iQRRRdwtUDI4e6b26AH7D2kCKTp/17x56ZGSVxm6BJ5cmPQRG1SDa6G2C0fRSTHjF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=a6N/LBSr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WjQ2m/k+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="a6N/LBSr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjQ2m/k+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5FA414000A9;
	Tue, 29 Sep 2026 19:12:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 19:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790723567;
	 x=1790809967; bh=5N8h4cDDPZVbZ0cY4qvCL0csuOeAgz31V+uoawEdTzI=; b=
	a6N/LBSrV9poCK6KvdAdRAY2+RfNy2XWhhrVgG443xzXiMz4d4wPl1SG3IYSEENM
	nivsMv8lYNB6ozIK45JA/V8GBr224iLsrkw4okdyUQAmFzfhVA8VhQ+WWc9Ny0/r
	dK8Y/RBHEUqfSkEaC7TyuvQpqLrrBMQXZ/agrnjrRYc8MAxxf+9tmltTIBqWgyNN
	Tl9qf/6J6/ZzgZAPv56LN2qdSKeGEjpq3NgEWbXsybylwcN7KBZu5ypQ24XTGrrD
	8Xcn5x6YWFCB8kzPmZ4ytA7BAeVe9iQrxzsUZncrZ9ffsHcKMcFQTMD7eYswBXT5
	T+m8W66b4qUkeEXtrmOUfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790723567; x=
	1790809967; bh=5N8h4cDDPZVbZ0cY4qvCL0csuOeAgz31V+uoawEdTzI=; b=W
	jQ2m/k+JOr+GBHpOCjb086bC0PHeerc6wnqXfcH6MgA28lc63LRNwotxFKr39nh1
	Y1Fa84v3kg7yNqlo3Tibz1bV4BPv2xilOB7uABoByVfI3cKgSGNxF9NKg+BPMcci
	d6KNIQXxHFLtkDJfiGbLkfJx2BXLSqcIXRKa3Z9+Pll1JUdI6fL+RNHUk/tVk+Ub
	HPDu39QKHLuVmNmZe//W2mPfCC0dXr0YIgQuoLu5lQJ/27KvQmNTSt+gJ0DQpBT6
	mo6Hq2Itx2PTVAgYubv9yVYCS7OnAk+hulMuMK7dGSDycNTcTmQ2Mh7fdd2bwPSN
	vnbZAwm9ws+zgW/t/0G/g==
X-ME-Sender: <xms:70W8apYOhkXJBezxoQD7-XKKApbmNBro9gpH0ektkQ09twrF5kn8lg>
    <xme:70W8amZxeWoNLolNnwupbdiEncRXjrN0PWTMe_FlyuHMaqIigcweR24_TdQcjxQJJ
    cIki7lInl7maZAmI26jTGynNplA14ll9zNhL5rMLvxC_0NI9fr8jCk>
X-ME-Received: <xmr:70W8amxVXwNH7tnpI3Fywv4Isw2ofxiW1gWOYO5c4QgRYNJSDyG5kt_jH4fm6w>
X-ME-Proxy-Cause: dmFkZTGzkRVwE7IVkz7bX/VwLuT+4AbufLz94UjH4E0LDN3MKrom4+IChXgf+oHYLo0Ur4
    dlevciSILgkCgvVzC0Y2VaN/E+vuQG69hPuFUyKi04WZdzhd76RboE6vWPmHthYEXxKNkG
    5i/nSO82SPN3EQvxlcFZbHOJVtpvQmqtCodFq8B7sOdQGmKEOxICdt1JnarA2otuDbTxOS
    PZZERuSmBKZGMgesXxEiKa45q+y4idVmAymZ+JVuQY261e2UsG+ekqbZSKsMtc6w8Hwvlq
    VmA6Arunx2zuM+IZeAoR7mrwxgGTBJXNul+PXG9JCj2XZqNp9kvfiA1sYWEFTL9+ksKASL
    qzKJwwemRAMQg8uQ3vYD2A8k9E53bYKqPn/4ErnDV2mZlbxVkpB2dL+KXd7UBKL27gKm0T
    cfp/p4g5i3p3BVidBv+kTv58k4jdmy4YALIlRgzj6wDsLi4Oht4cy5fpkaXUpoRdlDwL04
    2OuX422sR7yi12b4KXYgaQJ+L3t5KrhVajoi4ofhXzWmVq1APG4U4f3UaEd2ERGVD80QD0
    TC53u+9eJf0O/8t4bnCl1NYaVxsNF3WgDPrF08qYwL4Q31sChn0Y8bOJ3MTR/K0f4/1OhA
    E0OLkyoHUsG2YQQaXlteVYdFovLSVyxYgM14+z5oTFmtuavMiYBJx6b67utg
X-ME-Proxy: <xmx:70W8aqd3WEAFS3CRLad4RrmZMcGJsaRV_3UY4M6tWeyudSvL4_8p4w>
    <xmx:70W8aj6-mYqMA_tX9XUSYK84VZgly9uKc9lWDw9qau5DL4NcEibNcQ>
    <xmx:70W8anI6AqwONJ0_uxh8h3PJyGp-guQzORBSiIEOu4TuSanDTLnt6g>
    <xmx:70W8ajyS2_EKXxdBdrVf6y2TlCDBNZjqCft4gaYkZ1nHspAYDlW5dw>
    <xmx:70W8aqp1z77twTCNsKk8uT76DfPXOs4AKddvkmf2afCtF9a2lGg_sfZy>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 19:12:46 -0400 (EDT)
Date: Tue, 29 Sep 2026 17:12:44 -0600
From: Alex Williamson <alex@shazbot.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Matt Evans <mattev@meta.com>, Kevin Tian <kevin.tian@intel.com>, Kees
 Cook <kees@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Ramesh Thomas
 <ramesh.thomas@intel.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Restore 8-byte ioeventfd support
Message-ID: <20260929171244.172f0b3d@shazbot.org>
In-Reply-To: <20260922040013.2188-1-lirongqing@baidu.com>
References: <20260922040013.2188-1-lirongqing@baidu.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 12:00:13 +0800
lirongqing <lirongqing@baidu.com> wrote:

> From: Li RongQing <lirongqing@baidu.com>
> 
> Commit b44a06bd28f2 ("vfio/pci: Remove #ifdef iowrite64 and #ifdef
> ioread64") inadvertently converted a conditional 8-byte rejection
> into an unconditional one.
> 
> Originally, 'count == 8' was rejected only if iowrite64 was undefined
> (#ifndef iowrite64). When iowrite64 became globally available via generic
> fallbacks, this rejection became dead code, allowing 8-byte ioeventfds.
> However, b44a06bd28f2 removed the #ifndef wrappers but left the nested
> 'if (count == 8) return -EINVAL;' intact, breaking all 8-byte
> registrations.
> 
> Drop the unconditional check to restore 8-byte ioeventfd support,
> matching the original intent.
> 
> Fixes: b44a06bd28f2 ("vfio/pci: Remove #ifdef iowrite64 and #ifdef ioread64")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/vfio/pci/vfio_pci_rdwr.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 7f14dd4..df88480 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -423,9 +423,6 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>  	      pos >= vdev->msix_offset + vdev->msix_size))
>  		return -EINVAL;
>  
> -	if (count == 8)
> -		return -EINVAL;
> -
>  	io = vfio_pci_core_get_iomap(vdev, bar);
>  	if (IS_ERR(io))
>  		return PTR_ERR(io);

Applied to vfio next branch for v7.4.  Thanks!

Alex
