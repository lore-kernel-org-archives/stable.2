Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851434;
	b=gqruNz3y/mrhPAqJeRTlvw7WXHOjXs0eWT9r2jEt8FlEIkAaYk5wbZcGSTujNn5KocRR
	 nTMp7axIFAnrjyHHpH71ffF5RUafduGj8EAFmfDD87dtbGm7InbHFLYUDxmNMCXD/YumU
	 09u6bKkCmCGmMx9RrBNdQBXA/WkXkuDvNhW6sjd857t6FE3rciX7jFqQdJmxjkDeAF2JZ
	 eiDXpe5JaVD/Ss1UoEGITp33pzyvcneSmjbD9WtRQ8Gm0rTDlYGnHvKc3GTbCbIAX+K1Q
	 edP2Nukg8LOUJDWahEgIEcAyyWWz3TH2zS+pYXikpHVEH/u5kkxe2norIvUuMkhSc5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HtQr9bsOALQ3BcsYqX5n4G4R1RM9GAqckMkmVBBWUf8=;
	b=d55qsE4fa4zuhTvfpf5+QLoTy3aT8dConDZAo5YErPog0b9537v2+9mgThAGf1JdIuzk
	 uCuXvxdItBaWje18JTCO6mqHx+l91Rc/5ZedGgVWP+WxeL8QuG6vQDuMcbBdqbQvPePTo
	 jtk6VeDIdnboduECXRRYWS1K9B4TUeys+NabIGyEePPrRCyeEqELsOhIGdg3K0OEPqq0h
	 zesJlaTcmQV5yY4EJf7W52LYdirelbJHwrhB0CDsO5D4t/X9tZK9oPq+nS1QGdaJDxwSI
	 I3jjSzs4fAv7RBdM90MHNZp11jbGJ+W9MEoPclIK9/vPATdfQOHvasLqNx5RAtwsLJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TGBZxID6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571E606A31C;
	Sat, 28 Nov 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TGBZxID6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229ED1F00897;
	Sat, 28 Nov 2026 07:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795851433;
	bh=HtQr9bsOALQ3BcsYqX5n4G4R1RM9GAqckMkmVBBWUf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TGBZxID66X6aG5xa5jWvvwE9VULViLdiCZdxJ/bREXgLdLzCd9cIe9dOe7kN6NSO3
	 K/3+PvqsI5wbJnTcXT/j52MDGXgPe0xeV8SD8X/JrFwcwDy2qdkbH5hHqtD+R/kpPZ
	 lYw+NhAHLaSkYuarTftD+u4ZfNZdBY9X+TZw4Gsg=
Date: Sat, 28 Nov 2026 08:37:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: memoriaru@foxmail.com
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	badhri@google.com, stable@vger.kernel.org
Subject: Re: [PATCH usb v4] usb: typec: tcpm: exempt Soft Reset from the SOP'
 MessageID duplicate check
Message-ID: <2026112831-sake-detest-afd9@gregkh>
References: <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com>
 <awBIRnc9lBkdVhEK@black.igk.intel.com>
 <1795204201.patch.tcpm-v4@foxmail.com>
 <tencent_39EF7AC456CEB2270310851AD0ECB4891206@qq.com>
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
In-Reply-To: <tencent_39EF7AC456CEB2270310851AD0ECB4891206@qq.com>

On Sat, Nov 28, 2026 at 03:17:00PM +0800, memoriaru@foxmail.com wrote:
> From: Zhang Hewei <memoriaru@foxmail.com>
> 
> Hi Heikki,
> 
> Gentle ping on this one -- I understand things are busy.

There is no context here at all, please properly quote emails as many of
us get 1000+ a day.

thanks,

greg k-h
