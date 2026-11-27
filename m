Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811022;
	b=YXobzE20T8S5mFY23ANEalhdklCxtl0ygd5ZNJG4hFl9iS7woaF/55HbdBHfYyqxO4jm
	 AyyI0GCjVOdVsPvJhebVg2VT4quM9RAkUBJkAT1BiRd8yBYY5iYFp141T3JGqZPaa/QTz
	 X294BonsPIo7CLziqY9nXxU/28aRIGIH85d0SwkUNJqYf8n0p+jk7jS7eqsnkZvv0z7P+
	 IaJVltObITh+rwsXDtb90nS18c9c6l4YwqMSzK8VR6BKqyt63+gJDcra+QeZiXIQB1mhZ
	 jmlaC58H3XJDzKBhyvjpjzlEm+ZHFR43M7bcS369ROckkH4ebATSP3dwyUCnJ7FpZzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811022;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-ID:X-MBO-RS-META;
	bh=prGHkgX8EzWGe78aNVP3e+KL4WHhb14qYjHkPoXJfIE=;
	b=kgpQK7+iSNZdt8GWEEcmjdbiLq8/u/yNX8YJtDW3qFnQ4Y7qMKkGjHJIFnlppK6+Frrt
	 uNuSKJC0FpnCJ1WdB61XEVg40HV3QYfqarxPsa8mt3Vy9wAe3khwo9Y50KmKn5B4+Vgrz
	 fAA4w99iw4aldA2HVTArJvZRGattZHAFHc2OhVce9ncc2IEgOZ1fUmLUj586AzVk//bO0
	 FzSO67SiyMp6fMT1WxBZ6LwW5IeAq8bP7dDN5nkRcrqBdf8ShEvq7LT4b0OvW+trgFiCc
	 UwaQBBjardGYco3iNdJ3aQ36b4tq2dG9Ahdc1AEbGRlVL4yH8w2SIblzrM63urh+cLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=nEHyF3u4;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE7606A31F;
	Fri, 27 Nov 2026 20:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9FE7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=nEHyF3u4
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jblHF3Gf5z8vXw;
	Fri, 27 Nov 2026 21:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795811017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prGHkgX8EzWGe78aNVP3e+KL4WHhb14qYjHkPoXJfIE=;
	b=nEHyF3u4U/MDoSkk54nAhbr/rAgMw9nqT5Jna+h5XdAMuQ3/a9lv2rVlFgm4Sz3IxXVlEa
	/YHrEBvs4MecruRaguO6Rk/5LK9VnUGNETF7a8MDdUXuOSHA6MGF1gmtDnvDGNcDFxJw2z
	u8PWrIQxbqwB62K6kJO9j+nXQZBCsnyHNRowPZ5IgQc1+gBmk+XcPs2SPPj1ahAivGX5y9
	iER3T3J28nFSM/QGThIv4s6u/IByJXN5scS/SQ6xwpbpskxJZ8BnOztz0cqwcgAkcMn+ZO
	yIw9KXj7NXSMeP2dca4IiF+FWcuZJ0Bljp82mltjbgwbmpGTIF1lOIh/jmMLLA==
Date: Fri, 27 Nov 2026 21:23:35 +0100
From: Benjamin Boortz <bennib@mailbox.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/1002] 7.3.7-rc2 review
Message-ID: <awnmdqGWYZ7GMbYt@bb-82jq>
References: <20261126105729.110697432@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261126105729.110697432@linuxfoundation.org>
X-MBO-RS-ID: 39d3dc8004c07938cef
X-MBO-RS-META: cyiarbbj1r68xtyex9woodgainbdc37q

On Thu, Nov 26, 2026 at 11:58:20AM +0100, Greg Kroah-Hartman wrote:

>This is the start of the stable review cycle for the 7.3.7 release.
>There are 1002 patches in this series, all will be posted as a response
>to this one.  If anyone has any issues with these being applied, please
>let me know.

Build and boot tested with QEMU for x86_64, i386, arm64, and riscv
across multiple configurations, and boots on AMD Ryzen 7 5800H.
No regressions observed.

Tested-by: Benjamin Boortz <bennib@mailbox.org>
