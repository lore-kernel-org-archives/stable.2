Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5C4E9C32
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800320; cv=none; b=Ni2OVvIkVuwwxTrw8FqsJvCiGe6KLj3N+61co9jBu5PMsR7fG53XilU5NPjrpaibKAq5gd2hd/OSCml2cBO9HmMy2QGDS2nC+JLuwyAHflxNMAHFHB5otgX9lW1k05LqgSyqKOnFOHhFFbCycB+qHdulQVrpVXJcqDQW9OyZoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800320; c=relaxed/simple;
	bh=EKlcz5CBEcnRCHzlR10r/eowVg5c846H0vKVV3ugVE4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HclTlNF7agcjMvoGJBGkwWyNc9NKM0SgsOCihEYp0u95IkX54W/ZkuW3M2g7VTFqIsVr3/HcKy5zykFoVV+9sw5xK96jan1nW0AKquUliB4CylsMlkQeWgUzQE2Cyt1j2vtQBeDZ0uvqI8uw3iS+zaRptzoUpZHAIPl4TwMtOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq5NM1Wk; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq5NM1Wk"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5f63c54eso381791985a.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790800317; x=1791405117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bzhRivw0MBLgjbe/iyV7ysat9gpf94TLhhGWQJh7iRM=;
        b=hq5NM1Wk2w/bG7zm6byUGaOVpF9QApJcIbY7eGKjIy/YAn2jdYlyZj0S40d2S/xZyV
         pCKlIc2ZV5qByiE8SY0Vr62oVgeFUZBEszd4vv5ikh4X6XoK0h4xq++PRsm0W9wLcxQB
         mycS7NRty+K6mibYlSxM2EJBAj492uLwVWWBA9XhDm6VVsFHWdmdz5g6Df5pgcPP7YsW
         5bnnou2YndcfPhT+TlWHa4sa5RaV5zrVV5+mJY30ANyDRFKx5ilemFzCBWVPBB0cjbMs
         fYhnQ5cd3jTGmN55rD+PF6lexGfN6cBz/JqLRp5wJuHEzK4o0dJKRNOCPmgMuSKFTevv
         Tv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800317; x=1791405117;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bzhRivw0MBLgjbe/iyV7ysat9gpf94TLhhGWQJh7iRM=;
        b=CzBHxCxZ3cbk0zAq25RgeysJ/NnT9RXnwp94+0D/1TIPB9ZmkshxwyTNAxzPMv6qZ+
         GdQBNEOD2MbwVPtnV2tjMENhHn9FMDCc1FjZs8wPZ0IRAiSpPEF6afcOsFpIfX+Ws1Dl
         nANcBB9vlX9Tp8Hy295JY9idzqKi02ipW8QoE4gtKO+xD1CMMxoiJVBDGUjZ9JjtF7/v
         rXFaSRWEukVLn68iqPMntHZgbCBJSGj7HAGltV3PKHsdMqb1wx6vQas7UQaz/5CfFwT6
         KvD01ru12b0w/WtBOnmNIkljDDm0h3sVlLUnzKW+KV7Rng8Fs6SL1zP8WhCLP/PGX8+P
         5w+g==
X-Forwarded-Encrypted: i=1; AKwUvBxDmXMqF9OMBSmGJYGScn7JMpW/myq27AbZUwmtsLdVsbqbJJEY64pcPrKOIIGhIIoNZlKf/ns=@vger.kernel.org
X-Gm-Message-State: AFuF++lKkmL4JGsek16XQojVNDsUt3oqhOeu1HdkpNsiBjw7Dnekhb+6
	1thfMxx3i+Z/hSIUdVoIqv64SFYSAoFATdZRhJcDQiq3q2Q2DTIEOHY=
X-Gm-Gg: AYBFou3x36I8DROEDbaWYXjrTLCXBUiL7sx816HsBnby5GypmjyNuhdLGJ0qAm6MaAU
	OeTcGjGqjzDFdcsrZDsuEUgTcenfGiSeuOdILhqyOJiS89cvxcX+Tn/YOIF/Sjl4P5sB19y4q/Z
	9ZGpmfXVaAxRHxx1IhEUsXABL7rjVOJspQu17bO9OXmsNk9IoRyovUmXhZ2ma/vRg2q/UEyFQ4+
	k4weYSHAgxihINHPj3rMgrYMz1DwCL9XMPM8ztflBdl2IqGTXugghRSiKASVhiy1H3PJd/AQWA8
	SReb7eGANI+LAYfNvhPMA46MT0M0qbu19pM8enwr62PojcxMoEx5RtF0oEH/Qvn+b+4cJnz18P2
	o5VFktyswREeliAfHaR/Pfn+cZRYaOd+gF5Ejvn28zCGjErGbGaBAVkS34qmLuxrZPqDj+QvE4y
	iW/9z8msU1P+EVl2oGnCQ7UxhThGCifaWk4OheAJ74ZEY04xgVnfGUhxjQFomr4YPuRHuWBJCpM
	bBz9DM++Q4oJrmcf81lfMWrfCM=
X-Received: by 2002:a05:620a:43a9:b0:93c:771e:b672 with SMTP id af79cd13be357-93ca9899d69mr494177385a.54.1790800317375;
        Wed, 30 Sep 2026 13:31:57 -0700 (PDT)
Received: from [120.7.1.23] (135-23-94-154.cpe.pppoe.ca. [135.23.94.154])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cb8826b52sm16187185a.1.2026.09.30.13.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 13:31:57 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/595] 5.10.271-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260930152347.700140858@linuxfoundation.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <6eaeba9d-7778-88ec-d5ad-5433bd18d507@gmail.com>
Date: Wed, 30 Sep 2026 16:31:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:140.0) Gecko/20100101
 Firefox/140.0 SeaMonkey/2.53.24
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260930152347.700140858@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.271 release.
> There are 595 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
>
Built a i386 kernel and installed on a 32-bit EeePC.
No new problems noticed.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

