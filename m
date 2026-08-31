Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133B3367B9C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202843; cv=none; b=NQCfST9OzG4cQmhFKFkyCJmAUpslpKGdxnWFvuNubuMCUigmZbRj0ghioVWtDXkKfK7ndRB7k/E+7sWO30EYkD9ZjfToiWaK7Yl7Fq2VkyWcTGcse2++5yXlGJARbF/yKmlyaBcNG9e9BV18otFw3e4/fL6QpVDw6eMwGggsGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202843; c=relaxed/simple;
	bh=swFnLySAppNxuSAvXdelckAar1KHHAhbi00Pj7v/3qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9VbFgQLRS5o0K53q/z8k7diPrJO/rVoOzrl6XCUIVMXHklD9ZzUQfCz94ht6vm6lzauFpi0G/uW5NsUASdnAY+oDGOo1H5cjgEHNDPGZ+vicFSaGOL21AlKxv1mlTvHJQ9HmXDb206is6rcpM2OTvnQQFTbpNtpPQ+aSNvR1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5c1b7/f; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5c1b7/f"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-854f8068301so31093b3a.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788202841; x=1788807641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLLrMyDTQSEhjgi9BlS/V8xtiJJP4gucQLQ+mXxPqRQ=;
        b=e5c1b7/ftXqgipAo+PUnBkk+EMhS5dQwxS8BPUL1LnrGjvdrvVEFBl55aOwY1ZFnoV
         2PR1mL0mXF7u2DiNP3TJUUIse8SkMT0p/l1kHzzFbAUoO7eVCaRNV6wYMcdVAVuqFDbM
         6fgxragWkIRfdlDI+dzkR7tWXjOibdKJDG/u77gigzju62d/P45okRWH6fpXzPZxdENM
         wGHoDJhBHmPyBJ/knQ6dJv47cx5+HNu3rE0O7/o+k/UFNEENSLnIdRjrUdpuC0aSdSq8
         RQcpOU32BQEIii5543WjMO6MBFjTZSG0PIybI0guorHaAbuzO0xRlbMY0gY97aadIb85
         4zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202841; x=1788807641;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLLrMyDTQSEhjgi9BlS/V8xtiJJP4gucQLQ+mXxPqRQ=;
        b=QDcjf+QQy2WrJe45B0q91M87aFBG75vS3z1lMofH70REqngRZ7MFV4Gd48MIcQgW2J
         fUO7QeWpjVfydkAPCOkYdSU+vcImq8w3a1ECX1eGJUiq2H3rrBp6Zjxdji7qh58XmWaw
         VCP0PYKXlbC1ARNIEkd9ILmLAMU5iOp3FagbZjeKRBv9ziVxwJYJ510e74AV6OmHQplJ
         4wjvy3p/oVULoqqjeWNz1KwW9YsJp2lYnho8m87djXto/iF5DP/+7XZgS6jUVHT3vp99
         C2Ij2QvcjdA1yv4JwrF8Sa81WR/Du1Fq7RqubFAeUJqxYtTGa/1ggFPVfI4SAywsG7/i
         cesA==
X-Forwarded-Encrypted: i=1; AHgh+RpJCK8qHLb1Wc07gFDKb2XiU23z48eXSu17WzjPGCtqxg3oBTKlV9jTRffW9V0Ay/JAM0rs538=@vger.kernel.org
X-Gm-Message-State: AFuF++lK0n1VrPyuTLUD+xZ1jApq9gcoeQftDDG75ClPR4jXwJrcXjiV
	7SYkL9NNQyX0Bwiul/aSlhaGlm2O1RYMV6Wr21rKOsOAKoK94tJDHula
X-Gm-Gg: AR+sD11zEtw/NvpCAAumQx/N/44IELD7hgFeVmE1Za5MrldIQi2VrjdABOXbMEnhjoI
	CbpiekQUi18Ai9dZB/vXGEeNoQH3w0NIRzWQZx3596U2ALnP1I6I7yl3w+D3V/kPqRGhDDl6xA9
	ikS6vq9z8nrJcd61LaOo4jL6h3yuHPDz3t3FHK2FTqz7L4pdBjvX4bqyPvIi0ScBjLVST0N9Lsm
	aVhs5rahim0j0hJfTproZaQNAni6rGXbnKpXpU+QwQuQGAv2Clmm0+u1xTjQnPve80/yfAWk+Ap
	bDq8zBw9LUTRstcKYiAD4EGXnVP0yYtLqcH5OhklTADVMOv4OIdHQtNIGPCyjxP8tnZBEFbb8ly
	tgQLnRpSfPI+rUFMhz9Qd+HLp93IldEUakvIc1a8PnQozCrPbclXQEuvHMUVWcXwOTmIQy+a0J1
	VGOOrTWKsr7Php4+O00/38K3hPfSd1oQOauK9xw5ILGItPg0fDk+TKrj1DuemUnxUKhYGOQjevM
	Q9MrGp1pwgUrdtJIUUTN/2GM5tIUg==
X-Received: by 2002:a05:6a21:9098:b0:3d3:adbf:7778 with SMTP id adf61e73a8af0-3d3adbf8191mr30903334637.20.1788202841370;
        Mon, 31 Aug 2026 12:00:41 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7be440sm36737824eec.7.2026.08.31.12.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 12:00:40 -0700 (PDT)
Message-ID: <ac8605bf-cb09-4ab1-9487-8e4c58dfeb06@gmail.com>
Date: Mon, 31 Aug 2026 12:00:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/99] 6.12.108-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260831133359.740409777@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260831133359.740409777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.108 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.108-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

