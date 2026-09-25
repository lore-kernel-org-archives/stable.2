Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873B45FFCF;
	Fri, 25 Sep 2026 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343754; cv=none; b=KLA4vwLLqu7TpkS6NtVOtTAptpbqR4autay+KhtM+tJpM3pCIYmXRdsgQXPmKRThthvjoVoJtnyt/dCn3hav7JndlaAMveLMelXMk2xNYN7/kxVz7OUTrCLs+Bw+FV6EfpSoMyaVPLAoA+xeB+oCnx3dxHIa+Pk3aBodKUunNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343754; c=relaxed/simple;
	bh=iJ7TNJ/ug0NcqO3N7ZkSMzQES60viCnFf/CkcPwx9l8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ihikZBJWRfXru6ay3mv6eqjxXHX2dTDRduCgxDAAFV9w+jFZtPAWtxZOhegJyek+MPFHhOc5LC++3zOOHyXoh9Ioo5u/BQMN9yC+3+hBTDx23HVxt1dzsJHo2x6UH++DiVqCupNEOiAYa7Gz7stxDyBsGo65jvg0vtah6weTHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=CwCN206s; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="CwCN206s"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AC6BA4198;
	Fri, 25 Sep 2026 15:42:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790343746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ug79woZ3Z9IIUzpdxRqB1992tp4BJxKEhXr+fM0eftU=;
	b=CwCN206s8w80p00o2bngz3+l14T/L0WUJlC5wX1Q8+2L0xvWeJoVKmHZ1gQ6fEJ232HvX6
	sIsuptAMSQgdCZ4Zi7IPuNDvVqE+6LIRJJIrTo2YmSeZIS1AyiDdetp9mwezObNn3uIDgf
	ayJoJsQnmf15QpatppycqUJ3ekX0lD/3yPzL8LVpMwNQ4Vg9bo3YRT6sYfNY+YIcW6eSnP
	57ed6bhP6xc2a0AK5yxtPsUoZMRDrIowNz4+nCfYBagEy7hP6TIiU7ilTnC/+oMZJuCZBN
	zgmfmsJ9OFJbxXnYP+seBIGPuW9D2cCN9FGHZ/8Cfld//2gV4X6dK0o3a6doSA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 15:42:23 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, sashiko
 <sashiko@sashiko.dev>
Subject: Re: [PATCH net] net: macb: init workqueues before register_netdev()
In-Reply-To: <20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com>
References: <20260925-macb-netdev-register-race-v1-1-752f90ce1c39@bootlin.com>
Message-ID: <abd06220b7909c1feeb6b6100272c787@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Théo

On 25.9.2026 15:15, Théo Lebrun wrote:
> register_netdev() exposes the interface to userspace which might 
> trigger
> operations like close on it. Those access the HRESP/LPI tasks and
> might therefore use them uninitialised.
> 
> Fix this race by initialising both `struct work_struct` before
> register_netdev().
> 
> Theoretical bugfix. The main reason for fix is to avoid future Sashiko
> reports which triggers if we grow the race condition (by touching those
> workqueues at open for example). The likeliness of this bug sounds
> tiny, but I've not spent any time trying to reproduce it.
> 
> Fixes: c5092ba3155e ("net: macb: Convert tasklet API to new bottom half 
> workqueue mechanism")

IMHO the "bug" was introduced in 032dc41ba6e2? But this would generate 
more
backporting without any real use. So let's keep it as is.

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
