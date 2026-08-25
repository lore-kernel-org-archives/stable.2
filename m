Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7146A5E6
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693937; cv=none; b=afC6AQK5TiO102xBlfnuefOJFU2SR1dqB1IlCYiXn9gmm7t91Cx4bVgKz8GzuvdXjl9a/4QUjHwg68QmfO2RekrBDlqh8DhtoNQzOcEZkR/Hb8BnAuyKAj3rOZEEeFUXEkUcB7L6VfvotJSDkrR215p7g8pl6wlCNuE2lUVfIWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693937; c=relaxed/simple;
	bh=00h7okbFqgmPyvAM1n5ncVkjkrKDlt58MlCbOI+cFJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHF/yX/hotqWc50DodaWpqB42/10k55oA/3rPAn30f1aIYMIQvLpbvhApAyum3eJSx+e9BBHujL9ReyrEpFSuPrcq4wT5zOCt8Gtxw8l4nEjhhAD8PhLSD/+sutpyDoBiRdIRQT9CnsCLvUGgTXM6WAs/v0TfMLtwe6eLgJT1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=CE6sI1n4; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="CE6sI1n4"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90cc64f7f86so3288116d6.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1787693934; x=1788298734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bKDEf02ixSJvguzEg7rShr1aTUKMeAy3c/vPwS4ofl4=;
        b=CE6sI1n4pll2XqUeYEvjl8Sj8wPmF2f6K8LnR+mIIe/BTVpXClZk2riUe/QpdtKji3
         edopOmDhgxkpu2Yz7sdWNtyogTRs6n+0yVI+AXAVYK9ynu6eo7tqLxI/n8Pf81lj5MoE
         ziFSbwoRqbgg1uQuZjoo9guiNlsaj6gKuHmAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787693934; x=1788298734;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKDEf02ixSJvguzEg7rShr1aTUKMeAy3c/vPwS4ofl4=;
        b=s/n8MwupYfu/kgqr11m/iu7yXsf27q35iH5I0+mMSolJvij6poHtdw6+8Uwk5RcXQm
         9kcvyPgYWXpNzQLayNj4ej8w5RBkdUUzO1CbHuARxfZ8FSt/rR0j37Oj0Ig30bQYQ5DF
         8I3VW51Dba2PpLtLyn8wTZ5O7yaelg86FHm42WGHOekii5c15RA9e1yV/ebKQXFtTeob
         u46mv97pBAR9au8QSO+3AjjsYTF/nDZvHyTXeg8NMmH5ikVRvqa9Si+BuIWL/wsH3ezJ
         lmzHHOEB8hGrQlvTAKNA+ApWkUWuHM1UqcB0a/lLnhyOsMw/zuZpW3vIJnHQqGvpj+p3
         lDXQ==
X-Gm-Message-State: AFuF++lSICd7IRtcwXw70zBJnjggISx69vHDBAdnTV0TlOGIFZ5H3h+4
	KDnZrXs8mFx94s6FfRG7i8iuY3zUDtSskEfzq0hqHjCAaeQpQp1EQMOpIWIWNqeJNw==
X-Gm-Gg: AR+sD10FrLf7OgL771Ry/esHpEw9a4/qhVUUt8qP/issr43yZjb8dpbjTdfUxUrgfpZ
	ZyRrjjcSjdjoAxvJBzr8X+Yw6mmvvgwLR3IXehXDyTw/D4P38CzHD2FhVL5K49Ks8hKv9nHqESY
	syX7D4Dt9NDQnQbyEcqcAxLKoGeCYbks1GTT0PkYfMt94S7HJemrP2vHDRMennsFa2lP4jNx3qQ
	Ly5gZwpbviFvce7gC3MUWQYdwS+sKKTx/BJH5pXFyMDOYHZQa91h851X+6bTDx0dq2Gu3En9VMs
	rSgYVOHgdJgBsUkJqXF6LZN+XwlK6kJXILvMLV70IrF2uK/CnuhlESfuX0/WoA3dsv6utUuXDOJ
	bPOqskWk5nR1V+rRDkBmJnYq7by9ENeAGDLtQgx1c7AFq6jyEM4PveimYB5Ar8oxgP5AiD5re05
	s9TAcdIirGNLoeKh4r634S3u4Yn/QDDjUfcS6prDHDptbfx+SRDUpkxEotqB5YB8hJi2X4sR+wB
	ctW
X-Received: by 2002:a05:6214:1cc8:b0:908:a729:73bf with SMTP id 6a1803df08f44-90cc792fe20mr20043566d6.22.1787693933801;
        Tue, 25 Aug 2026 14:38:53 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.3.217])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc63e3108sm8829586d6.11.2026.08.25.14.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:38:53 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 25 Aug 2026 15:38:50 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.1 000/101] 7.1.11-rc1 review
Message-ID: <ao4LatQTBK5zThtD@fedora64.linuxtx.org>
References: <20260825132541.986300899@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825132541.986300899@linuxfoundation.org>

On Tue, Aug 25, 2026 at 03:24:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.11 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
