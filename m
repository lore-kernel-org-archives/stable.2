Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26452442B1F
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757377; cv=none; b=GNUBSdcKOB6tF0yg3PWHBr6Mx+rAH/Y2vGJ/WW/LzAwqV+2TsPzeiL8ReZeeAUmTxMsULQ21zU4Vj8aSi49UR0W5jqjY8mcIav6lf6JQIFeGWlrCWh039qmBcPEgd1mUFwUS+voLiZMsTqkVFAZYTDO019EzAPsET8ZKb2KwVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757377; c=relaxed/simple;
	bh=Jue4qQbyuGt52OHTxUjhFpfYZgfyA2mLyvy/Z8UHaWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe0tIK+f+bDyOPkSC3odC3CsVOJ3VglfJe8pnxspEMyeh0NM/Hgx7HLboMHW0rAyw6wvbmjhjKKRy/P73spvwowMjDGDw/jcMfcWrMyAlxDIhHNFgajXSavNlKIvSKY0iiBN+JNxm+C9OsVq2f6qL8nJzTpS12/utwI5/yY0WOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=CtnG7VKj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="CtnG7VKj"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c0cea8883so80442641cf.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1784757371; x=1785362171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9t0rs+W0pu6WNdNBEUf4o9pVZqycsQqI1OIg6c5XOGs=;
        b=CtnG7VKjPB+NaHeHYqVhw7HrkCUjlUCIY4cXz3FijsLvc2z490nVJY9v/EUbjumiH9
         cYqy87Fy1//Ew/T8NFvLZ8T3JOjcgQeXVakqXUsk8Ed5cPLrUZkTMIYD6Rv0ttMlNTVJ
         UpsdU/7ZZp6MWgpI8GvHmDfgQL2pUbvlS+IJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784757371; x=1785362171;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9t0rs+W0pu6WNdNBEUf4o9pVZqycsQqI1OIg6c5XOGs=;
        b=JyHvYJGQcWSO5QCuUdB+ei6Y875+prxnZrbFcVRSYBU7A2mwHeni/3WWHFawGkY+jf
         UMqyI6m4WTvIkWsgEvZrvjSuc4lHNPe7XtO9yNW8u2G8epCSFGMLCYL6Ri+U5z0Iw+aS
         AzQKvfeKqz4auVKnvu8DQET8+mdqJAwCVgoJnAGZtA+GCxUbb4yRCA2yScBQ8ij8nV72
         fJ4djFFWZg0v/73H0twjOmQQ5svuzQtpHqMGU/EY5hPc5vd16qxDWlMUw3FBJN8bvEjH
         +xZ/vXTKHFQMpOf6W71ZgvWm8kKEKuFy+K+gbzEXgZP0iRiuZ9Q1Yk6mFn05umMlNhLE
         l3xg==
X-Gm-Message-State: AOJu0YzJdPFYqNRQFucbfrBPa/pP6zUS02gSMPN9GXyBxfywdCHSVxtK
	z5co2gTW1fpNSo4IePr74UMBD2r70+RJ8JG9Lt8vzukMB7fzAqH4GIn0lj51NL5MEA==
X-Gm-Gg: AR+sD136Xlppg6TncenzhDhKy2DPtMtKQlIy6RFtx6TrgZEuuANcIYD+hTBfwQwwtX9
	iI/XNcL6tLRCkS1V5+lC0RvXeJ3pANIxGoTJCzP7dO9SrcZSB3oLPGPGPtP6+zyZtxNOjX6K/tB
	Hq6MisyOg3gEwj7gmjMZ7yH92w+YNdhYZKuquhRnWoMIUG67QzIIE5hhAd/hSgSN2AXEjxssQCH
	w3cXAeFek1NksX+2ToeHOdev9N6at3/9Jpyc5wyUXOfwhfVLRQTjI6aUa8k8Ov2JmQidwL0uZBn
	c2uj5Sfc5K3j5GdecbSFzXEjW3ZqYDimKB49ouRUjl/yYG18A7kc4Yk84uCv4/FbOXWnhcdMvVW
	REqAr1HlAWyOy45X7YubKiJImtGqEpIkT6veDRigJcHnGdvIQ9QEkguJ8f6xdpNDx9vrbUFiiDz
	zmm2yHzkJBJgsO6VOvHX3D
X-Received: by 2002:a05:622a:11cb:b0:51a:8c86:bd2f with SMTP id d75a77b69052e-5283ee15f94mr473691cf.36.1784757371562;
        Wed, 22 Jul 2026 14:56:11 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.106.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d402caf9sm23510501cf.30.2026.07.22.14.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:56:11 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 22 Jul 2026 15:56:08 -0600
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
Subject: Re: [PATCH 7.1 0000/2079] 7.1.5-rc2 review
Message-ID: <amE8eH_IAe4QX3h2@fedora64.linuxtx.org>
References: <20260722142947.085426486@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722142947.085426486@linuxfoundation.org>

On Wed, Jul 22, 2026 at 04:32:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.5 release.
> There are 2079 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:26:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
