Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63A56260D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930429; cv=none; b=hPjF1cYEr216WXWtY5eyae/V1tEf2YFWlpMIJUIkzjW7Z2nw7b5NytMt1YYl9jBTcHftp5cyj+a2vS/UNxTQW13I/KLRUAiHS4YanHImWRkNqIa7RN2AtHW+jaLftWEK1dmLWVsUFiPOow50o/suAsk0cYEfARe4fRlg5v018RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930429; c=relaxed/simple;
	bh=T1NSf2MNr7yY5v6FmworM5XrTcAJ/g6Wc19lr7YWcBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3JrAQ7EUtrjHOmDEOn8tnM0Se8CkFlPmbn19g1C52/+IbghSHNiARX7JdXVZ+thyWy4G9x2fQMHfKtCrTTr9gKsbqyGTwHeQp2XlahKkWKP2IXD5uf6d+1aryBIh1IxvX9iv433njDL3vAV3GeTe8cQvflUvm1BU7KGJkId/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Iam/ncMY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Iam/ncMY"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9144e8021d3so49111306d6.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1791930426; x=1792535226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RMXzZganarlsailXkTlaGadOuYOoIKZ53AhRSXcitJk=;
        b=Iam/ncMYTXZW/58ie4mDkpCl1KLlBAgYa/GvSK5FOilMbyAdragopzJ0mz1CNfR/of
         OVO+K6d4ZmavDcLwQSvYITgRhxteoyzipvpmN54Nf1sWqooKxL89K8rl8e0YlT8WczHD
         yd626XjHfHagDmf9ODDved9OrwS2bvJQE7Cfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930426; x=1792535226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RMXzZganarlsailXkTlaGadOuYOoIKZ53AhRSXcitJk=;
        b=pEsnntKAGXUdatNDy+ngvgZLIHRVP4LYiVCX1hKAkQabdnWKlVrdoC0GS/kkH3KTdQ
         CAvtSiKE0Fcjd8SGumJSBPUlFz5X5EXAWkaTyq7PT14GgX7LFm+vpazjVxnHydxEwnZU
         woXkPWrqPyQgeqLhmKTo8JRtqmZGeWwTqsmeeCaUZZXXl6s0/5+YcwhghVtjp/bD8Dy7
         mmvykkp/c7VvSFntBALp8EONklN21UgM0v211EJBWYHAeChJ78bCc1TQqs54viay8YtV
         MFNchtKh1AB3sSi9ne62nhj+BLdTwrjCBeLHd8wh7R7cu2mgOCSEiret0ePj2Yqf41yw
         +6Bg==
X-Gm-Message-State: AFq9FYI+qqctOYreEBE7/IZ9s7zwKMSFHCqxYQixmcwznJR+eSdYIInz
	JfTuL6gNxXlQNlkV8kw9tPykdOcxm9dVMiS3O3y8PrDpnmAgfH5V+j9qsweGfPZa+A==
X-Gm-Gg: AYBFou0MAe0belYVTQK7T2dEo2ngf/38tut1fdHYGxGSqYoh4U6ZKdIF1sEgnwkWjOA
	6o33qvJLpSlDA9umde/ZvG4UAdtPhV3KTwrKzfnWqFVukAyA/hGDZR2qvYjdRpTzFydKpgGzFoz
	9T4WOz9ZOUtBeSBq7lKMkevDh1R8xBV9PIsNwrem6Js/fc2UKNFbsuytf71p5hlqxw5tlFHjXwo
	fTxEKoHbHDlqnWi9XJM3F8sfb7dfTN1CUYYQuygTF9Cm/ZeNqArAEE4KfylMJSry80rJfdBqa6+
	Bnr1suppM1AYSYdlUWYmIgDajFUFQnVdByRe75Pwc0VSDN+9CZIdrHvDDnDQANbAk5kn/h6mRFK
	IA8Sstss65CgfWs3G0ibpXwYULgSXAVDDSFT8piFSxjFpWpxRatpEwabl8HPLON258h1EuKlkDp
	ZFq1u+jSrlgTBBrFLSxic7Iz//x3sVEVGnisMBaysT0iv3wJbfndyISwyKEuMPSEt/8dXbf1c30
	5DH9YCe7L4RTI0=
X-Received: by 2002:a05:6214:4906:b0:917:8b9f:d62 with SMTP id 6a1803df08f44-91b554f1babmr266315986d6.18.1791930425999;
        Tue, 13 Oct 2026 15:27:05 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.1.126])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b62240sm36637126d6.23.2026.10.13.15.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 15:27:05 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 13 Oct 2026 16:27:02 -0600
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
Subject: Re: [PATCH 7.2 000/281] 7.2.11-rc1 review
Message-ID: <as6wNjHH7u-zmUBN@fedora64.linuxtx.org>
References: <20261013112855.045212108@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013112855.045212108@linuxfoundation.org>

On Tue, Oct 13, 2026 at 01:35:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.11 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Oct 2026 11:28:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
