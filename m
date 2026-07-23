Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE43BD651
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795668; cv=none; b=aRr56RjxxkCAUNCrWtrLYwo18yFlgmYKhp6KuP3UqOUykpq004xnwNrQkwwHtZdScs4lAKr8UIZ0fYu6Mq5JlUC47N0aex/EVNm7JpzeeFcyUEHoqvJSNut+WjV5S8P1FL4h1MF7W8PGWTKTrEdLFfDN0hZokmgj/ei6MXzMMqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795668; c=relaxed/simple;
	bh=eDcM7H/qX1tb9OEYMsB+e7w3gjgm19H+kyxAAgQNGko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiZy3Mz9GB9tMTawuLssYfv3KZgL8wrGrZNILAcU6zflgnxBxu5mWd1ICNOhVvHFHoWoOJvjPT+4V69Yd4wfp5mtS90xS1me3wvG41dAIH6R2Pp5P00JMjEZKXpq4KH2fgDT/HYgRY9Z7diDdBrv9uS0AnPoOA4csR8fSHlmekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JINYEE0r; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JINYEE0r"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c166aef4f02so27193366b.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795665; x=1785400465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WM4LrVEAVbzwFnCna7mTJoAGomEWS7gZwnhfoNmmkfE=;
        b=JINYEE0rD1U0rh7vcAzlOZPMDiyy7iTKhX85o0zK7fqwTgzM/dhAV+jH3YMfFRwdG6
         CZloid6DMWTBvB9BVp3FM/sSGZ39PnfSwNcZgXTyrgBHdY7esbroXjj01zELS+Z/YlGM
         b92LQDa+qrtc2DYHmxnvcsCiDBtKkqZ2PfotS3BS3xpqJLNal3T1Pdd6lKh60IhJTmX6
         dGKeQqNucw05eJFoFJSPC8soVQHlYZegTajGRtHC39LWc1GSjXS0fEqXMmWR88X/3iqI
         KDtxYAcfFgsRIdafDRUBiG85EZSAH6OFNLO/ILr6sfUXqsdQvYdMUiYpwuQt0rreDQ/P
         O8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795665; x=1785400465;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WM4LrVEAVbzwFnCna7mTJoAGomEWS7gZwnhfoNmmkfE=;
        b=tNWPSPpmZ5lYqB00f3t2nHunv3jplNPadcSChyjYZ39JxtfNW5ybfHlFM5KMDQNynS
         zhfQW+5LOCbr8fIq1flNKWljybibCNgNdxgmLMZo3rT0TsVPiqGgcSgJy8ELP4CeMd+k
         qBp6fNtXLEPQWlqJa5T+ghUqLrfpyg2vdX0H0UIp9HkVGVqrMuT6RfR/BvsPfHGG3nnA
         mRXtb+eKAzbTJjVYoRhulj8U4vgst1qnXB8R3P5ZDUUrb0b+FBCJb2lrjkN1oMnkzNC0
         xoBQgcrXmwcsSTcLwij0B4lehbrKHftfHmMHountvx3JOA7w9bBZsgnqDXn8HCuit7FY
         xmNQ==
X-Gm-Message-State: AOJu0YyPFThdrPiW5pkle4+NuwHFNuHhetRq4rGzc+vGTJx40puX1zuG
	Pub+8uG89gBmgd9t+5X8ptUOrww9N+Y3dV6bTRLzux3+n2DUnJIRqLcysxNcgiY71fA=
X-Gm-Gg: AR+sD125IBV9Q1avkdx37zt+VmVhnk8o38HeU9NzocNED9RMwBQx6rmsqbgTYYb0Kk5
	VJb9i7TaASl2tdXRkSKHtSxtc/OMmk3d86Ok5QGAypLicDbPK0xrCgiXdE86t7ssydjoWpQSiPA
	58v9ccPx/ApEoQVhVCKUaInreDbmkEUpQNRpECJiXreWWOyvXDHXd3ItxNsp1A85XxYVRV23plP
	tcc8DqlMJ5i9IoMJlw2SpV7AQ3qK08pPORElHzCVIzA+u3OPo7QX4WzQ7JegxkZodhdKuNdkvVF
	ltGp7apoAJyP3cmu8A22UhJNpn7+mehfAPWPIPp7F9cK1OBUCXd777kZYb72uMqd2+QF6Mi/MQg
	ds/F+YlbqWeao8fE2GwtsKQaisoQ+H5mLoMXI7hIn53Z9l1cq3e79wONTLNOq4QsE83FH4KaB1Y
	3fb+dZ+m9Tn015Gwt9PPc=
X-Received: by 2002:a17:907:972a:b0:c15:f4e0:72a7 with SMTP id a640c23a62f3a-c1c50934a52mr104803366b.39.1784795665148;
        Thu, 23 Jul 2026 01:34:25 -0700 (PDT)
Received: from u94a (27-53-97-40.adsl.fetnet.net. [27.53.97.40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0d6a52sm2432265a12.4.2026.07.23.01.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:34:23 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:34:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 0000/1029] 6.1.178-rc2 review
Message-ID: <amHRf2CoKvS9qwJZ@u94a>
References: <20260722143218.909123637@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722143218.909123637@linuxfoundation.org>

On Wed, Jul 22, 2026 at 04:32:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.178 release.
> There are 1029 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:30:58 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps, test_verifier
in BPF selftests all passes[1] on x86_64 and aarch64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/kernel-patches/linux-stable/actions/runs/29956182704

[...]
