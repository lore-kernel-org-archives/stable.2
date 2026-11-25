Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.227.220.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628813;
	b=w4ZRgRj/TyUEbj0/1O8TJo/tnhy45UD7cgRn4/0Wv+Qt9vStEh7yaaAFKzz6KQ16swTO
	 wZtrOnOr6UAQA0zY5NdkaQ9m8vf4SqKNDt+7O8iH9qeNE571DKUxVhu2BUZUDOi4CnsiX
	 8A2sMUglQ34VPB0rkYk/c78YHfOW7dB/ytv0Sih9dJTVlAa5ribux8Bm+cOR7I0WnEZYI
	 Ccqnw+Z5nzwuqPlTprVZpvWSB0bpB5YzCGCYRGT8SuLgqTK58YibK8QbePPGgs5ByVe55
	 tvT+1lWVyis7SPtoE+vbfLCpixXdVrBmmuWI1VaXaCBu919aMv2VwALFmm7FRiIAF/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628813;
	h=DMARC-Filter:Date:DKIM-Signature:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ygo03uIlk4kdcjHf0vuPvvy+UzzYe9zFGhqQ5pIQmyE=;
	b=bPEDHT7/NaTYBvSKcXHTtFi3152LzRR4CWGkJyvI6jgv86mvt6C2ijhuMULeFWeCxlom
	 07wDB1Orvhcm3H4t3pi0rUNcVPlR9Cwo/IpMUvAaR7KnJe5EvtdjbWEDG21KiiKVtkFM7
	 mBLrtRmq7ZDGEU+mAxkZlT7YTZJ2Vt975DsnNdgWsbr7MYGw7HhBT/VlQ4ea/4un78/Ea
	 6yahMA9dKvkkGWGDZm4tjaD/kaQrcL4E9sIt6dLrZx2iYanQCGLjBrK9jH8xfcKsyH3A1
	 lvRpQiUB4levRVwnpkPisMrgKdO/NqzXXPg6qgVSQkITPZGuXLHjTLTeV977INfkr1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mareichelt.com;
	spf=pass smtp.mailfrom=mareichelt.com;
	dkim=pass header.d=mareichelt.com header.i=@mareichelt.com header.a=rsa-sha256 header.s=202107 header.b=DWFE33A0;
	arc=none smtp.remote-ip=91.227.220.155
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14640606A31E;
	Wed, 25 Nov 2026 17:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14640606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.a=rsa-sha256 header.s=202107 header.b=DWFE33A0
Date: Wed, 25 Nov 2026 18:46:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mareichelt.com;
	s=202107; t=1795628803;
	bh=Ygo03uIlk4kdcjHf0vuPvvy+UzzYe9zFGhqQ5pIQmyE=;
	h=Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:date:
	 author:from:to:subject:message-id:in-reply-to:references:
	 mail-followup-to:openpgp:mime-version:content-type:
	 content-transfer-encoding:author:from:subject:date:to:cc:
	 resent-author:resent-date:resent-from:resent-sender:resent-to:
	 resent-cc:resent-reply-to:resent-message-id:in-reply-to:references:
	 mime-version:content-type:content-transfer-encoding:
	 content-disposition:content-id:content-description:message-id:
	 mail-followup-to:openpgp;
	b=DWFE33A0gw8qIbWy3Lds1OKbdPjABZua/yF/Cx0ODVD67/XD5QTfBVG9laKvTKktD
	 +DgxDs+1hYKcgSL2oCaYyNf+y2NogV8+5S/+EZck1kGkVW6SR0YQsXi49omrh84fS6
	 f6tTRn021XUQbxgo7d8HIzopHBBb4uSkLjx1NuJ1SjxnWj9g+hGiAIxY42MBlpH2Hk
	 vpi2uvnPiG5gj9Zt+b4ZnioEsC/Si82URmTnMMY+sRYY2nbctHmgRLTRVrXryrRrpm
	 P8Vyxo+7utFrg/SJ96ftQGHCxsy1qokF50NjHpyOwV7NoUUfqT/s6McxZwwCPGqzxn
	 AgOQYqdRSsIpg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/1005] 7.3.7-rc1 review
Message-ID: <20261125174642.GD32322@pc21.mareichelt.com>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
References: <20261125143821.729802100@linuxfoundation.org>
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
In-Reply-To: <20261125143821.729802100@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 7.3.7 release.
> There are 1005 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Nov 2026 14:36:53 +0000.
> Anything received after that time might be too late.

7.3.7-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (Xeon Gold 6142, Slackware64-current).
No regressions observed during boot & my custom tests.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>
