Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A44E5353;
	Thu, 24 Sep 2026 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286875; cv=none; b=ec+ijKAKItGkA0Kx2hG/hhcMDoG8+uFIO+RjqKGiju3iES5FWxr84dbpbOphZoYQXAy0dHleZ8I51yjZRzr2Vzm8lFl5DMdMRLFc0gzquvcgAYKMOILSOoCVWGeM2OAQ/iNq8dACScdOVRdben4ENpwp/5IgrLVi04PcFn5iIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286875; c=relaxed/simple;
	bh=XPiNPavZBbP9Hpbl6Z0ey2pAEAUn+toDVQatE5Q4aAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7pnObw7CDYXblkoOIXryu29w+QgLWiWIcjMhVmra1kCoIMEi9rg6PMcT87C6oz7HBcQWHWJsvdCiNYOtLli5TtefDlenOtAiPGF8VmAAyiNTtWspQ0qGBv+dwqkIsVxJRfMHMmfDcXCm6FzKBRq/oF1CchcckKSHDLoIklbpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=HDW00wYN; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="HDW00wYN"
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 68OLpumq3984646;
	Thu, 24 Sep 2026 23:51:57 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 68OLpumq3984646
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1790286717;
	bh=XPiNPavZBbP9Hpbl6Z0ey2pAEAUn+toDVQatE5Q4aAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDW00wYNRzlXSK3ZL7vbwupsn+6wB/4VyHPXgST3rxlr02EDp/tizZzZgdb03/fmq
	 pP0pakuvgSQvZcUTBBuv58aF8fMKf0ezRUeFiguFkiWjY5QO5BGqK0iFmyI8u1Vy94
	 JoEtqikg6urFa8L1lyb/6ioXS8VDCt6ET/XO2RnY=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 68OLptTT3984645;
	Thu, 24 Sep 2026 23:51:55 +0200
Date: Thu, 24 Sep 2026 23:51:55 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Denis Benato <benato.denis96@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Petr Machata <petrm@nvidia.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Message-ID: <20260924215155.GA3984640@electric-eye.fr.zoreil.com>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
X-Organisation: Land of Sunshine Inc.

=D0=96=D0=B0=D0=BC=D0=B1=D0=B0=D0=BA=D0=B8=D0=B5=D0=B2 =D0=A0=D0=B0=D0=B4=
=D0=B8=D0=B9 =D0=A0=D0=B8=D0=BA=D0=B0=D1=80=D0=B4=D0=B8=D0=BD=D0=BE=D0=B2=
=D0=B8=D1=87 <r.zhambakiev@prosoftsystems.ru> :
> From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
>=20
> fealnx_remove_one() frees the DMA rings before unregistering the
> netdev, while the interface may still be up, which leaves a
> window where freed memory can be accessed.
>=20
> Call unregister_netdev() first so dev_close() stops the Tx/Rx
> engines, deletes the timers, and frees the IRQ before the rings are
> freed.

Fine. A single line of code needs to be moved.

> While at it use dev_err() instead of printk() for the unknown-device case.

Unrelated stuff.

--=20
Ueimor
