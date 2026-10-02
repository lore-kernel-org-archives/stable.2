Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431B4B0495
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949039; cv=none; b=HUzlU6SW4auQQxRbtxxTvvtWF3sAXEdDcg3hPGNaxcUHE6iHlpwP3Yaz5vVvPHlyp/lj1ENGFCGse4LNmgwQnPcvJB3ALsu3Wvb330IXtTheJS2WGe/jfSUNxkB+NvCoofXj7l5rn22AxzW5YTV39trkA2hMiUhD/6IPCZOrL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949039; c=relaxed/simple;
	bh=YAbhCEsj1Xow+kprODecviF0SnZgAch7eBzBEf5i7yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSOGhHAEQdkle8aMZTr8ZoIPoAmRRE9QBA82AduLHNqo8U4GSUz7Qj1yxUCRRFmAHQruwnXrnEHkTVeQslpK7ytBB4YoaJUq0W25nqlxzAc6329o5HQ2DA8BJJLi/IUxw0lv9Px+DAJFHXM8aaOKiUa7os+pj1k1yaK9DtpUc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Uc7VvP9h; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Uc7VvP9h"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91782711448so654396d6.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1790949036; x=1791553836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lS1VVahwxyy3uHWOK8ukiwzRDiQgwlDYS5Uok3wV7Vc=;
        b=Uc7VvP9hw+/KML86BNYTdH75zqNW0AAN7XHghFdwAfe0ffkY/4tC/3u4uFXbxXIiaB
         vYKO3I3PuS5P4944i5X8zgjUgMryhmVPp1SStJ+b2aHK3rr2ucUk2mD0tZqDnQ/fiv+R
         lgGfSN6vVBGYD6RQRdKSXefDk/beouC5XXWoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790949036; x=1791553836;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lS1VVahwxyy3uHWOK8ukiwzRDiQgwlDYS5Uok3wV7Vc=;
        b=dvp3EfasA4I/HFYVnncnvlUqhHbLZ4bwN33w6BmcdH1/baxngRbi+/fqSELE2Wilc7
         TogLTI4ZEfaNgq1R4n7UgqYhkR5j7z22UFMDWfIWtzlCEYQbMud2pvMoG0sdlMmxPyjZ
         2Bny3Ppl6r1pXk4wXpvWWvLSONZG4HHeQVIt3ZKgcmhIZDRRIsn6qCmq8DqFN4XgaiHj
         Mj+XuUYPYfkVjFxX9+L0Ark7glNmIWqVJzk8eAL5OzjXvHJBMCDWdLDVNk0+BqkQYHpz
         8lINnBY2OzALodakSkOlv2cUtWrtczkDFlBrXNJJjepw5er/4q4oEW1mGa50zRkLeH+n
         Du/w==
X-Gm-Message-State: AFuF++nU5aS3n7ffoHwRvRuCxsi+gPy+w66e1n1v3dh6J208u8MGjD3g
	SHjp73A4v00RPTVe9IuQFO55jfyF2/43bUtH/r/2Xt5gxcF/uKb0JWqBKsK7ZYVEzQ==
X-Gm-Gg: AYBFou3wNm6PZ4ZdMpJIjJ8KxPA8MR6HHOnjpQeMEDYKlNPsk2wUF+gPpPz2axN1Gry
	26Scg0HArcRrIXayRU3yk7SuiVEV+Sj6qxjZ7/YVzcT7O5fSb/aT63O3obkBSFGdR4GGiK93itt
	V6nfiMT3Fq8xByHogp9QCrDPTVEQSuq7/3q+NqpIwefixIlV6DdxOOzH1QnSQmAY8Gwvv4VTTHf
	s8zT7NYUjWd8P9ROLUrL1J10t/HLNBqTPwgFBXMd1XoTgE+LlSSR7pdXesHLvOKkqiY9Y7URosQ
	dKBFqj2LRu42LrXJLgoV3DhE8EZMz+mgrJN1NMcR7r1yPPUwjcbMpjwhuHjqsBwsPL37iIjOJDh
	Yg0B559vfDyMA6kbWNCLdj49d8XSENZcUfq90UNzRx/X4JzlKOMIujtjjPXk+lf6xh17kWXBWL5
	Ci433FUaD/whRBG1jEn7GSHAEjCtEKVkPRpDAvPwqbS0q8ucyi9m9yenZ0M+7rAkokvbDVAm8Ql
	a/BF32tedMMWFsOlA==
X-Received: by 2002:ad4:5dc8:0:b0:917:8ea8:cf48 with SMTP id 6a1803df08f44-917c0023954mr55938026d6.11.1790949035586;
        Fri, 02 Oct 2026 06:50:35 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.107.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c17b8esm19945606d6.43.2026.10.02.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:50:35 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 2 Oct 2026 07:50:32 -0600
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
Subject: Re: [PATCH 7.2 000/457] 7.2.9-rc1 review
Message-ID: <ar-2qLGYAeke2TUl@fedora64.linuxtx.org>
References: <20260930152346.024115587@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930152346.024115587@linuxfoundation.org>

On Wed, Sep 30, 2026 at 05:21:45PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.9 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.9-rc1.gz
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
