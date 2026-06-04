Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F631352B;
	Thu,  4 Jun 2026 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587273; cv=none; b=q29sjSkWtHIE1ma0HJ+H2Ma09zimkiN9KS+h16ULxMPKHwLhOnslAyRF0qHhUfuMz0Rdy3ZCpmQk9R+iTymD4VWf4GTVnMju881TLyd3/gKURHLhwpnNXgcA4ualca4TyUw9H+DouoT2zO6KKhpLDIjKXXllEKwTV1Ztr0HewuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587273; c=relaxed/simple;
	bh=TWwOjx0K0gU9/TmSaGF/mv8oHJmUUoMB7/HlJ/Idu8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zckt8mgkUFUdFI9tH5fH4SH5jeRBQ7b4BSR45d+oi2fBiEz3hP9bAF94FmTW4G1ZCH3TlX8uSVTQKbd4VwAdtP3Y60KDhUJXJpWx6fqSCqKfQU+tLVrSaeleOc9QSExbwFx3xtVxLEFp6YE1mTj7JDDUdmubG4Rm9EQA5M54Nsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEGNhuJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEGNhuJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747CF1F00893;
	Thu,  4 Jun 2026 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587271;
	bh=1dvuixTk0NgEAYJVb7G+lPIi4lajpXkweOWZGnVwtCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iEGNhuJgVEn3hwtSz0BqWJuhNm+TnGPN6MW2/+MQzPHc0GtuwgNkoPRNmhO0Tovtw
	 NpDL/iX05KagLsIo5OkrYZM5Avmm1d0D3XFzrMSp8chLtyDRXEXoC5cUdcsViK86Vr
	 pAl6qFq5PKyKRcowFWiqkZ70QCrhgy3K1O2usSXDr6vwabgOq0VoFZT5kZR5ZapHd5
	 QcURKV2gbNw2AxsgBG1ZNxidwxPtwz+TJFUVU38xsyMtOkISmg/V/Bu8LSeWluotp6
	 /Tnw0CravyGE8Iv9ToKoJUDAB3vPAoMvB1MsogPrrydIADw+TSCWCEu/LbA3hNtpcB
	 2yawGIaKglWsQ==
Date: Thu, 4 Jun 2026 08:34:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH RESEND net] net: mv643xx: fix OF node refcount
Message-ID: <20260604083430.2b61c2c3@kernel.org>
In-Reply-To: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 09:34:14 +0200 Bartosz Golaszewski wrote:
> Platform devices created with platform_device_alloc() call
> platform_device_release() when the last reference to the device's
> kobject is dropped. This function calls of_node_put() unconditionally.
> This works fine for devices created with platform_device_register_full()
> but users of the split approach (platform_device_alloc() +
> platform_device_add()) must bump the reference of the of_node they
> assign manually. Add the missing call to of_node_get().

Where is it released? I think it's important to note, I can amend
the commit message if needed..
