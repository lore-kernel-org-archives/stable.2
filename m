Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA10279DCC;
	Tue, 22 Sep 2026 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040231; cv=none; b=qAAFqHIXAauEC3AXQTx0n2cO6XvVSmJB04uDcJBxgom4fE+QN1NtRkkHbaLi+mbZcYDEc4wC8q89V7gjoMTGLGCDmFUiwU3XWowXIZgFZml6f3e2zUSJFtglvezqwRgXtba82WMhRyDKezHWTnhlmp5sIamHcCZQqove37w5DAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040231; c=relaxed/simple;
	bh=A1fjSibPhH96nCA08fsJ/7+P64t97lktpS4Xfl4ILvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuCSnLghVB7W3Rqh+8LiEd0si6tzJdgIDTyPGkeePVySXzX7QXkAJU5Vdx3HxH/YTf68VYBzT7qkxGJp306O0+tBlftPJ9llujiMTIL69XSPQkDmECNfn+Tch2AN9E4et4j9pa6brzCBWD+baKFm6UfHOOTJJLW3k1QB5+thg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmpAokHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmpAokHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4793A1F000FF;
	Tue, 22 Sep 2026 01:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790040229;
	bh=A1fjSibPhH96nCA08fsJ/7+P64t97lktpS4Xfl4ILvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OmpAokHSzjoJu8vc+77CsYLHwa5qvvRxB+jUvxcUhMIQjzWigA57Lir2o3shb1Q2i
	 H/QJQrv4/RH9ybEbxnQPb/H/z7O24u6sO/OxZ72e8T7FnQm5D5ckfk3SOvniQ//FTr
	 aHC33Wm/xGUsbXip1sWYaEcDY8lYOQswoit+0sfK6BHGyZfSc9k9wpzePSDp1vcw7U
	 O+aCTRYxBdFuyI85bvNqCaS6wMKfMg4Sx4tPbzPbyIhCyZ8tmpDOABTSo/AQQ0fWrl
	 VW4/7Hi6fI4Gg7WWaQ/w8IqnKH+VS9X6JAbwQeQn8SQ1+FY3jTlFHzGHT4vaDbk4LH
	 OqItjXI1SnndA==
Date: Mon, 21 Sep 2026 18:23:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, edumazet@google.com, jiri@resnulli.us,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] ptp: ocp: Fix dpll device reference leak in
 ptp_ocp_probe()
Message-ID: <20260921182348.3b7b60e3@kernel.org>
In-Reply-To: <20260917142337.2156652-1-vulab@iscas.ac.cn>
References: <20260917142337.2156652-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 14:23:37 +0000 Wentao Liang wrote:
> ptp_ocp_probe() takes a reference on the dpll device with
> dpll_device_get(), but jumps to the out label without dropping it when
> dpll_device_register() fails, so the reference leaks. Put it before
> returning.

AFAIR Sagi already fixes this in net-next
