Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64E456E04;
	Wed, 30 Sep 2026 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790807908; cv=none; b=b8LKZLyDgk2lEQSVmrOqziRCdBO4Zwq77OaKbrUKlpGJ37CJ1Lp7u4j0TaMgKt030nqoNqJDcyJM4EMjsZSOWkETu+SAwFtPUs8qegoWVuK/OsutjSHsojzpoeesEB7OTh20YdW3NHwD5k3UP1j7a5Jhb8tlUT/SCtq05iv+w2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790807908; c=relaxed/simple;
	bh=q0suR1lGlrOna49oJDINOjHl+zO01XTt7MXFUGviMoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwA3y0Tt0lZ5+uwE8rFRva8Kk2WlbxHxbc2TOLVdya99ToYWxq6eQanflPBlFoB7LB0THGSRjqh838b+oOjmQpJWAaWSn9n8RbxjpwRfebbe60nw0hQWllPIfpgxmBWTs2gRewWWHmiQ1d3RcTU6lEnMZd4lYHkWMmNlYlvdRMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=FVkcWOq4; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="FVkcWOq4"
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 68UMbMHh094932;
	Thu, 1 Oct 2026 00:37:22 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 68UMbMHh094932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1790807842;
	bh=q0suR1lGlrOna49oJDINOjHl+zO01XTt7MXFUGviMoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FVkcWOq4ItcKBVVyo3YmV62jm27APOmgKiknxHwAHNKrQbkokm64FTihJBZVtczcR
	 hEgfFC9zZscHA/1VDU/mMhQwnpNTNnnC1l0WE/wgQxZtUC+/6ZiW4ovr6vV7i7pOGI
	 8bnB+cfr1rCSzNP2aBKFMMStJWUh1TKMengEI0To=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 68UMbKPL094931;
	Thu, 1 Oct 2026 00:37:20 +0200
Date: Thu, 1 Oct 2026 00:37:20 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
	=?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
Cc: "benato.denis96@gmail.com" <benato.denis96@gmail.com>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Message-ID: <20260930223720.GA93976@electric-eye.fr.zoreil.com>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
 <20260924215155.GA3984640@electric-eye.fr.zoreil.com>
 <1e36eb653106cee3a5294e0cb052fe6b9719d638.camel@prosoftsystems.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1e36eb653106cee3a5294e0cb052fe6b9719d638.camel@prosoftsystems.ru>
X-Organisation: Land of Sunshine Inc.

=D0=96=D0=B0=D0=BC=D0=B1=D0=B0=D0=BA=D0=B8=D0=B5=D0=B2 =D0=A0=D0=B0=D0=B4=
=D0=B8=D0=B9 =D0=A0=D0=B8=D0=BA=D0=B0=D1=80=D0=B4=D0=B8=D0=BD=D0=BE=D0=B2=
=D0=B8=D1=87 <r.zhambakiev@prosoftsystems.ru> :
[...]
> Should refactoring part be proposed as a separate patch/patches or
> dropped completely for this series?

Removing cosmetic debt or redundant code from old driver for legacy hardwar=
e ?

If anything, it's less 'net' than 'net-next'.

--=20
Ueimor
