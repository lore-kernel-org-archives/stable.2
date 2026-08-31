Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD14457C2
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198641; cv=none; b=SzP7Cz23XPUEqWB1hg8+q6bM6NW17k9qGnvcmBRayBVwBcp/OP979q2WviqXLHXPZYmNDduA+LfxLgDSfQ+dPH3afUE23awbCvk3a3MEo+u77J7ZPKajdtSZw0bTCoJh4jI9j+nfqsPvgYuDUHcEuGGUG8MtYOKIiHGvoo7muF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198641; c=relaxed/simple;
	bh=nQ2OzwrZKHaYxYFAxN/IhfHiA9sv4Jp6iArmTITeQhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gq6VO4W9fBTgYTZaPZU9IWzEhB8p9X9tjtNiGFZksX2XqMJ96zlpF3RGSyX/vDDOkm8PJFxbXkIPtWDl8PH693izGx3eGZIVDQAYDhTMPC6Qbj7zx2KILpwpvqywHhrp6jkI3WFo45OFuaBiC3N8ATrDFeIw//eQniMnEXtNkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/oltlbC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/oltlbC"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so4093900a12.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788198639; x=1788803439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbLc580QKHQB87a0tif0AwXX4z/fpS9vCcyNo+ew9kM=;
        b=S/oltlbCt6lBZCxNqdstpDKnhvZAoLgxtKCxeUoeHULMTVU53Onck1foXJwSuDXATk
         xnf41dM6syuuPiuvL3M8evj5pUcxcBUdhLgHZN7xvKeK1uUw33YdQm87JlcwVt8TTdAA
         w0Uwerriqlzza0dhSVaW1VvcFE7SF8Bsy4OGrKE2ZGdygWApjS7vusbRphTFEZYHkzi3
         DGZ3bbUyDiFGe0kqs2CXYk9AHCaRhxUFkW9yiadZBBGAtLACMO1T2UUst1eADiPdvHRC
         8AaNa0giJszb6pom59Q17OYYmEKghwMuxaPAFcardAfvF4vWPbsn1KP/M4RTLXL8D36F
         +TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788198639; x=1788803439;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbLc580QKHQB87a0tif0AwXX4z/fpS9vCcyNo+ew9kM=;
        b=I388QBos7ggzfMRnSobHBlwF/d3NpNrlWG4TXc99itjhA8aXMnPelnjj6Ky7E4Rcx1
         2nYzjBs2FgsM0YEQUIgkmfD4usil/tcBdC0jtTj3ssRjhMGHl/umQfPnc7/YTHj6SoyQ
         sR0fx2W2z5K1/ZXhDN8BwdG/a5WdmtGR9601Xj65xcoF9CMB6z/sSAKtaetvHk851EAY
         oHnIXCBXYxdURRdwkKCWeA5cvBgylzh5jiCn/YU+YZ/jSZotmqXjtZFaqu8SoFOt+FNQ
         gHKGCagSosFeE72BwGbx4CWL+Bg0vmVgjUkOknQ6XQKJBPMhdZrcGKgkyO9HpiGE+J5P
         jhdg==
X-Forwarded-Encrypted: i=1; AHgh+RqEnrAgMJAs7hLvlvFwJo/Bz78A/JijOp3NS6Hg3ZLaaQjG/YV6uGex1O2jxYyEYa3W3aBrk3M=@vger.kernel.org
X-Gm-Message-State: AFuF++lK77DWwq4lmYQdCkfShO4tJe/3aWmUoXoXdZ6lZZ7RYnSoGp2E
	S2toPATkx9qKVLNPj3T0TpL2QCM4Q5JqCSOFXX7XQgm/B/HPJawsy3p4
X-Gm-Gg: AR+sD111YZF5f65ck7ahl0w84L6LtuQvpjNgSao976p4eZCcKVyDEQTOPeB47HkOO3d
	i0FKZ11LZ7a49f4rvKtuxUfdctPyADuNBoz2Dfth355JCFTAxn3DTuoAgbPMaVN2fX1w3PIVytN
	3QW0YRTHCvTYZQTPeguW3h6NJVGiDN8CSP3UMbUoWAImUSVJ6juMnGDqXGgaO50vdsXTzeaeyhz
	VY92fdSeyt2LFmmQefvDFb6/8sbO5KmOIZLHalmFgiThwigitXsqcZqZeCucHIPM3qtLL47foK1
	W+4OPRChluHQeWHeJViIKAYK2WxeHMJ+pdF8UId6ae8yH5ra3jNXGEFJIhbYIsj5+mLTyA7T/uD
	TNFzGFF2YtAwRZUpzYfEc8LQYJg48MQ6gS1e/OCF1FsH62IOkgTuHpAgddjZhv+N3kRe84vykDX
	5LMbe/f8xfJEgrhyCaMRW4QJqHfJWZXYMF4KsBh4lngD+c5j7cG1j8ATBEQ3YoqwPgnAoRrPWWR
	WihsmYc+I+69SXpVS23YLQUO1aRWA==
X-Received: by 2002:a05:6a20:9f92:b0:3d2:3e73:29eb with SMTP id adf61e73a8af0-3d7adec0469mr4503090637.1.1788198638790;
        Mon, 31 Aug 2026 10:50:38 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f95a160sm31383185eec.18.2026.08.31.10.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 10:50:38 -0700 (PDT)
Message-ID: <674bb3e7-e61a-4535-bdde-beff6bd1c2ea@gmail.com>
Date: Mon, 31 Aug 2026 10:50:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.187-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260831133359.482388899@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260831133359.482388899@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/31/2026 6:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.187 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.187-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

