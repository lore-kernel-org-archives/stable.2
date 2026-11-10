Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329270;
	b=lV4R+gLsn3B4aPsCmfPw6wP3RzdOgusa4bunvGVtPdHsZhH6lZm8n2bLzDlnsv7dNtRK
	 9hGq8PRv88zcqXNSTTmXzMx74ujf7GX3DmWMGm6gsOwapqd3+7kvV8YhqBKHXhUy5RlV6
	 xytSdtOLqR89zYtCGyMjgOPHJKIyJTnyqDo4OcHGub2XH8BCVMOHsVn9hApeHIRr+7ySh
	 b8H+gSIGyYdjBriW7Y6iUcyT9xo+yOT2szO83Yq01cpUTUFGVxwbWG6m0X+gSkzedPfdj
	 xQWZYpZD/h5mJOgPdyQzYWBYv9OQla7NcHRgt4d/ScJ2uxYSI+rUABULI3HoMFvpVIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ebmyXy0NycGoNtKM2+8c0u716/QOVyCgQosp484QW/w=;
	b=QffUlTuo8J4srDqmYZID995MaWs9YREHLmrQYhbHiJwOswSIl90tfLfctqF2vpN5gHwC
	 M7Gc1aYno6/aPDJRnKr2MoofYyyh6DbwXSK0s8orz3N9brHcUjinl8MlWCw+d4JXQQXvt
	 0uwrOh2bwSDpwoev+hi+fs32woIVzP7OI03bLpMX6AIRb1TRzIsWwGrfIHTFZvZBgy+ug
	 DPZfvVMmIDVtBcfaoFD8ykRRXGIaxiJAiq9GNrrZTrnXK8Taenss7Uspz+5Y8JbkwAiqn
	 NHFsRcjSE8+d3EDBzCvJVCEg6iJaD9i12EpAYV+cG/OFUKnHjG+62ly/i0tI7oSxnCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b3TbTLxJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B14606A32A;
	Tue, 10 Nov 2026 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b3TbTLxJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37451F008A1;
	Tue, 10 Nov 2026 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794329269;
	bh=ebmyXy0NycGoNtKM2+8c0u716/QOVyCgQosp484QW/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b3TbTLxJaEo1DMI3T/reGwVTLPNZJAcOQVRfhRvkG4cmykc1VKNyR8wuAyMFP/HYL
	 ipvMwqIqzlsD6Vm4Ns010eY+fqDewC8T6mmgabn4JIBYjF/6+PXZpCNtoqwlP1gAyg
	 dDNExUKVx5rW4flE7AikZH2IJkFaVLgGf6sUMwhs=
Date: Tue, 10 Nov 2026 11:47:46 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Artem Novikov <novart962@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: serialize mux configuration
Message-ID: <2026111056-nerd-plunder-5aa5@gregkh>
References: <20261110075538.51452-1-novart962@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110075538.51452-1-novart962@gmail.com>

On Tue, Nov 10, 2026 at 10:55:38AM +0300, Artem Novikov wrote:
> From: Artem Novikov <naa@amicon.ru>
> 
> Concurrent GSMIOC_SETCONF calls can both decide to restart the same mux.
> gsm_cleanup_mux() releases gsm->mutex before gsm_config() calls
> gsm_activate_mux(), so cleanup and activation from different calls can
> overlap. The activation paths can register the same gsmtty minors, and
> registration rollback can race with another registration or cleanup.
> GSMIOC_SETCONF_EXT can restart the mux through the same paths.
> 
> A 5.10.246-syzkaller report shows a NULL dereference in the unregister
> path:

Unless you have this hardware, and have tested it on that hardware, I
can't take any patches for this code, no matter how horrible you get
syzbot to abuse this driver (also that is a VERY old kernel tree, always
test Linus's latest.)

Please see the archives for why this is the policy here.

thanks,

greg k-h
