Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072303;
	b=zak19cFuXTNWuTqkt+Ft+7+98YFNpOXiQjH5s8eXriPsJ3BUwSRafrbieK6OmGDDcYgb
	 DsY22ICehU9GP4uQNeuH3wRzPPfNgB38oVaRikJfgxHCi6QYQWkq0jeNjHKi/ahYVwZH9
	 lTFohRh15merV3nl9A+5xvYmSnmOsiP+Rdamar3pDVNjzhl0+cLKhLW02lA9AmfPnr7Sb
	 0nwNwsLHBzEraPjG3i6XYbGt9qDr8eYYOo52khdl8ywUxMnBjJZsiBaQDNYjB9/8R0USp
	 W1Drm4Jfy/3A9LZYpMedA6mqrIsIjbR1b79BKTtWMKeGogQfcce7rHju6Vv5qEBxNhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=56K4FbTqN9iuqeBa4x5ePXVEpS5MDyK7GetIQvheO7c=;
	b=CwuEwsF0MX4Af+NZkaMyJg1vE47Mu24XhORjc30NhHweNEX4G8oG6nUsiC4Ti4ZPnTKd
	 pS1unE+wsb94UVT4f9juVy61x4ei2nrJDZy2iRxV/Imc2VsZQF4Ri03TlrrHK7I6MvUx7
	 BoY7DIX3Vzj4JBO23ZN9R6sdie6P8tHGAw/kjyWFndxFQsDtFh8+Mz5RUrCX/s+5vzilF
	 MORkEorhtc+QrfEV9p1Mr1AHDPyJZMUwPQKCCsKxN+B3R9R/SgWjbIBvPykroNVGwPxXC
	 FaIxm2j0MvLA+j1GE0Ynu1bFBRI2ko80LgtroiMF8ZjMFuNbP3bEHO8E7pIpK3HWylA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dp2jz6sl;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDEC606A330
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACDEC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dp2jz6sl
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso969894a12.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072302; x=1795677102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56K4FbTqN9iuqeBa4x5ePXVEpS5MDyK7GetIQvheO7c=;
        b=Dp2jz6slsa2nPA1ODcfYoYVFZ8fVvJy6eA9FuBu2d4k5NVYVdmhp5yOXVYQEwJtNH2
         zbXbU1hyNloT8Cn9/XX1Fu5Hjpyz8o5Hhvh8f939/QQTZ3WrNtO+FYSZOkySzqzRLZDP
         EzUXcmsebAvM79a8wqhaBXa74UwdrTTC9bL4nZIWYDPMXPjVUH3lpoSTvz9BbxKeg1zZ
         NXQE3tpd+Hsfhk/OMvAosDVsVoiSWNncBZn8RXrGnwID1uep42kebuVPJJ+3H3NH9P5h
         2bq/OYKpauyHaMHbCQLrD+paPL4qR7CM0NY+UtNJyhLjKSjueVOy4adFafLb4XwoCAQU
         w7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072302; x=1795677102;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56K4FbTqN9iuqeBa4x5ePXVEpS5MDyK7GetIQvheO7c=;
        b=si+sTavSArXiy/YLawD53mYXVQ7nEt6grgLpiGk3HnFfBibEGVmAVdx/1Z0Q7iDZrA
         wRy1Z/MFF9SczX/2lW+WSG5L3J7aaSzfY0A7nA7aDcKD9CE5XhMlhBXJp9fc23m8x4pX
         xttzoU/GHBkq8xP90T4CFv6obTNjDLcrS57e2nlDCOZ4b2kaTIjh9IYdhLSjSXUqrto6
         1BPWqnN90gYBy79nOYyef3tqwMaqIgS7Rtt4Qlg+Iwo+zcodVwICsFE6Y4alzN2O5ACE
         wfsQDgCovLijo8qnK57KB6mgcEKuqRaxYZbJLiL1nIgxlOXyERvtZ/lZR0PwOpl/2jGX
         GQ5w==
X-Forwarded-Encrypted: i=1; AL+hErF1VX/NaP2o50J7GJrQRpBnfZt2DTfQesf5+X84oHo7TvpOahBocLNkC/8nj+uM/eJ1tanEHYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ihRZw8cQaib6qQZMCdKFPGZzVoklRg8WkxsGC4DR5YifI+oJH
	wS7W/6hze3QxIKXyL2KPyCk7aHy6kg3JVcHtfZ1kGqNzb4ZCHK2gqFCH
X-Gm-Gg: AZFdTZe/9Pc6kPzWGIf93yVgUeNWXWQoLQncv6TjuphK2O7tKWt5rxjLRGl4JCNFcJY
	sWITROaGHZhNkf0ZTx35Ji/mCIx/ZgT1STF/HPoNqG6jaBTTSiWsG3bJgSmYeE0DlkDG8o/c/P2
	GedO7monjBLa5ByqzWDRnb1A1LRuGL0KKgwsWnlurbt0oR7IejBldnXb3RS0qLQtHPZA1Qirfye
	Zmi02tqgzjNtspaSZK5D8Ka4LE8D1mefu3K4rb5g4SExXAbXHh/7s3JYSmg72OhYGiSxB80TJnl
	Kt/IahHIS8neXfOX0FSxGS6pXxaF6hzcYBUJOS+e6kypLw4iFjardd5W5NOQMfxplfslC9YjGXe
	QBD6gV2VRs8WnzEGpX8PiiuGOEWHCZaU8oAnSEB6VG/MY/oETfI2K7bgCxhp+o2woiMOqinza36
	4OeYBdrrvjcAbMKA3KXkvfsA7NsNTwJjewnSsd419m6pVmaEOwgCOTpM+0bU/RQBiy0oZ1HZGaj
	SqaVlhIDymCeyum6njlwuU8oUqbcljf/DoIet7SL+kKKYmoydaWnY3j5wMvDiF1c+v5vFu1hBP/
	EBstty3a5POZP9b6PppeS3sPbk1wCQ==
X-Received: by 2002:a17:90a:d886:b0:3b3:b36e:8c40 with SMTP id 98e67ed59e1d1-3b3d07cd39dmr4957649a91.62.1795072302037;
        Wed, 18 Nov 2026 23:11:42 -0800 (PST)
Received: from [10.222.0.188] ([59.20.222.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm1183692a91.16.2026.11.18.23.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 23:11:41 -0800 (PST)
Message-ID: <69c61b39-1b78-4c9c-8289-8ab40cd13c96@gmail.com>
Date: Thu, 19 Nov 2026 16:11:37 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.3 0000/2651] 7.3.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261118150247.972732815@linuxfoundation.org>
Content-Language: en-US
From: Joungmin Lee <leejm516@gmail.com>
In-Reply-To: <20261118150247.972732815@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/26 11:20 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.6 release.
> There are 2651 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Nov 2026 14:55:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Hi, Greg:

I see the same rust build error as that reported by Thorsten.
That error was not observed with 6.18.65-rc1.

Distribution: Gentoo Linux
Architecture: x86_64 (ASUS Zenbook UM3504DA)
CPU: AMD Ryzen 7 7735U
iGPU: AMD Radeon 680M

Tested-by: Joungmin Lee <leejm516@gmail.com>

Best,
Joungmin
