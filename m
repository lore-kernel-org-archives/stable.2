Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795279494;
	b=kmY+sYEIfuoSXId7z4eY+B+Ib/d0olDiSdAGJCoqteYlFdD0O1CcGlBMVQdBoB43op6d
	 oFg4EsIFe5q5nEFC/CrX3uRC2kccppiMi9dSx4sKQif5jLBu90mToJj/sl53aw91yZonx
	 SFVPSGqnq/alM7D8jlVEVzKZoXc8F3fUNj8WSu0eLVMYnu0EWNN1mF/ramJOfVZte7Bgf
	 cZtVTVOxu92IaUPjIkVkCKLlPJtDSEvSa0PAEzmq0xHcCnR9UJCtyaFkgXXf7mjmZQXX/
	 PDaKeb74LzabCn4PKBoFrt67FwkQCdJNSEejASV5RrDfNmEB+hH1FMI9Sw2T93UUtRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279494;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-ID:X-MBO-RS-META;
	bh=gXdiQTGe7ntn4WDHykrLhcHPhiWr4wJSEg0jkdiWb/0=;
	b=KI2cQM7+QiCHRMS8Vvkn/1s0n05UHzVBLgFE4tiW1GQitHezIjPJOHmNIUz9NbnDkdu4
	 N9JO0GX264ueGkyeTPcEm87KJhVj3Ii0rGCPvF/Srcv4qz+7z1o7btC4IZQt8G3eN0SvP
	 2MwvsVj7bs9P7mOQ99++5TN+xy2pS6u8ti2o01aRUJiTVnlOy+k3MnHqgh1Ci/MhYJ9A+
	 F9ajTP2/UWRA8xZrtBMfUTsR/uFQs0++HmgbsuoFFWx/a45Z3xOr8G4kmRE3kTh5kMfKT
	 JJH2HSiXMXV6tSuap5peDiB4pxD/K3Jxg/hDqjT6rs4+Wu73IqoojdkfD9KIQc3/EFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=aAppkJCg;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E4606A320;
	Sat, 21 Nov 2026 16:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 825E4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=aAppkJCg
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jWyjY57YTzMlvY;
	Sat, 21 Nov 2026 17:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795279489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXdiQTGe7ntn4WDHykrLhcHPhiWr4wJSEg0jkdiWb/0=;
	b=aAppkJCgcENAr7PYI4JfGigWesGGVopxya53uWu0JL0VwYX7Y/fY9lQXgKKKPCR+UpHTa/
	JqsThSkbfJQBXVi4LskErLYaBTL0oHzaftInvXpLklZcYWslZhlciQof2Cn8ieLd8fEo+M
	C6g+Wij22eFKqZFLhnAKDN6jfRMlkxsH7KqnhfCf0eia1Z9a6n4xVu+Icb7Q9EhV4L7GOV
	ltujv2ZXIQTaOL/6cD2RE6oMXI5u3hhdRSoz7cAuOjOuuQJI/bnRNddW02EAX4k6WtLEDc
	J9Ha9JiXsqWIU54xne7TD5sMVwp2+bs7/hMbjKOgydb6WSK2bVYApRCKHvYi3A==
Date: Sat, 21 Nov 2026 17:44:47 +0100
From: Benjamin Boortz <bennib@mailbox.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/2642] 7.3.6-rc2 review
Message-ID: <awHKZxVgql08UqXC@bb-82jq>
References: <20261120055248.913352689@linuxfoundation.org>
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
In-Reply-To: <20261120055248.913352689@linuxfoundation.org>
X-MBO-RS-ID: 85e19a1006fad7ae188
X-MBO-RS-META: 7i9pjc1tff9p8aesbftkn7yzxojh5pu6

On Fri, Nov 20, 2026 at 06:58:20AM +0100, Greg Kroah-Hartman wrote:

>This is the start of the stable review cycle for the 7.3.6 release.
>There are 2642 patches in this series, all will be posted as a response
>to this one.  If anyone has any issues with these being applied, please
>let me know.
>

Build and boot tested with QEMU for x86_64, i386, arm64, and riscv
across multiple configurations, and boots on AMD Ryzen 7 5800H.
No regressions observed.

Tested-by: Benjamin Boortz <bennib@mailbox.org>
