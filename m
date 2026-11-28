Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=99.33.87.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795831260;
	b=dw8a0U4Y/S2DlYflVhFVuxpXWtCY1SlSfKbU+0fn8K88edjqvA+LMSyd42sPEJ7IoU6H
	 oXKGeSLwKF4Old5r/oxoVU1bT5c93CIsvtRagGbjNTtK4SGw1oWezHx2tv12kER3P1727
	 lnFLFSs/3hY9yoIq2rwVqf1/dZpnW2ZiFNTk4A4wrDXgFypTq3EfaOrCQxRYng2uOWO4x
	 PFPBaWr0vtJtW68T8I7aiwifHGnFdC9ZeAy1KoLv/pYHkxCIuE11C9HpaDrKynvuHZv7g
	 GCEJ/TXwqovd30C3tD9241cD+2GCjpB/mAjfDWUOkY7pEnSFh7ZdK4ZIxCJq3EtnAdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795831260;
	h=DMARC-Filter:Received:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=G5AolTU3EO1Jw2uiLYKbYCg2POKdiEU/uUhXQOPn7Hk=;
	b=anE8bgTGBLvqLojFhKJnjXompILiDsxfNQOhDj5sk6/ZyPmVN6aRid3OWDjYsiwyOUQU
	 Hj56XtwXqJFcrTt9E4PfMfXH2Z15rasaWySJGFm1tOK6p+neJkoAoYiv2FYa94Ik1QJRq
	 cRU75jwwfi1TMAsQ19Sl3w0MkFCzCezGkykver2KsRtq1mCdRJ3i68GOmwMJp1WfjpX52
	 L5Ggcmhi6v+K5BVlqeUXaGvQGrz4tWQb02cz1ci60iizjBRnmzfzGDUd5y1d7wk0j889w
	 u9nMUEMg0xNZnbaYbqwrl/9BtmkXDnJsizh05KOQ23hfb7f44ucq788O7IoKLokSaQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=aaazen.com;
	spf=pass smtp.mailfrom=aaazen.com;
	arc=none smtp.remote-ip=99.33.87.210
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D3606A31C;
	Sat, 28 Nov 2026 02:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D8D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 49d91dc5;
	Fri, 27 Nov 2026 18:00:53 -0800 (PST)
Date: Fri, 27 Nov 2026 18:00:53 -0800 (PST)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: stable@vger.kernel.org, patches@lists.linux.dev, 
    linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
    akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
    patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
    jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
    rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
    achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 5.15 000/318] 5.15.227-rc2 review
In-Reply-To: <20261127052515.841545444@linuxfoundation.org>
Message-ID: <a06c6134-6d79-959d-4146-881fe5ecd1d@aaazen.com>
References: <20261127052515.841545444@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 27 Nov 2026, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 5.15.227 release.
> There are 318 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Nov 2026 05:24:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.227-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y

Tested on   AMD  amd64 12-core and 4-core and x86 1-core systems
and    on Intel x86-64             4-core and x86 1-core systems

Tested-by: Richard Narron <richard@aaazen.com>

