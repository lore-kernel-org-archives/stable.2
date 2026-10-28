Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.59.206.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179849;
	b=FoPZC0hkm37HcptHt8dHMZPtnYpQG/Ap4bEChLE6tq+Wxcj0UnH60Bd9bCmDurjGZ2WG
	 p5pmMg8IBTDnm4Y8LmoO8dUwqT1D93pu6eZKDPud98WXOjFFeOFVzKSM1UddcmjIJQp8K
	 tb6U8IhUJSBJKxibqfhbVhjMaa/uuJfCV2OdoQOAiNs5UClSxk+2CAVpp/w4whwudrYX5
	 /68wS0z1ox/2rWwATjWpFrzu2PGVoUtdvLha3Sm2P5eeXPO5bbt3R6ktuvY9IFdVLK5Hz
	 h5UaWowaqPJIL7PniiLf8l8wjkddJLk7I8poWPBsZSOfgyQa0yxtsksi7j2qY39Pq8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179849;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=Yz76oOmF8BT8+08e1VGZ0CzES0UkXP8ivIRndu1Jn+I=;
	b=WnX6HI79anIws+LWcyMbekYKSH+yjZlhkz3zhCbroU/0s/3gbm2BAnMLTBK12NMcQj5P
	 n0AkLCk/AbNrwqVXc7ExV2UmNRcEfnqTWj3S3BDnnekHqaMoBPwuDFMqGCX4/tEzM/vMs
	 B1zOv76TIbOhl+qZMbaQRtZsFlMIhwe2KBLIT6EJm9hMQMwa3bfyfHA+uUXK8c0f1Mr8L
	 N7WHYZAqdJSOpawdaljlih3EYQfOmFbfE2aE6jxszOMblYOZfhRWIr8LoNhmMImEAkIfm
	 zSCAwGtLwkNNBdFiI5yA/EnXGdQgA4KOgHt0vSy5RdvKXnlnmwypslBbXBwrQAqaYOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=XXOkfy8f;
	arc=none smtp.remote-ip=194.59.206.189
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E560A2605;
	Wed, 28 Oct 2026 09:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA4E560A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=XXOkfy8f
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4jF2Cg4wlZz4gB3;
	Wed, 28 Oct 2026 10:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793179839;
	bh=b98VBHicFPHHWx0A6xKSF3YDtQW4jPChJfnqgGAgdKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XXOkfy8fZr3BIlV3qgmG8ps5OhHwzPHvJpy0Ier9Bf9UswfxqJDtmuWYNKux+ouA+
	 aIH/1NCvf6WUFtwIxReelu6Yjq9ES7osjoM/Uz/V5OJI4x0Q0tl9dgCMn5vtJyXGnd
	 g9eDe77cwur6eIgHjwaWM4V0U2xHdEVjjCxwiVcRTnKe25vvSw3zXlpUwAt7BrKJyr
	 zHSjbnWZPIqNX+mBoUTjR1p5EuzrD96cMQEnNzoTCTenxXm5wsEB+WWGDPCoK2r4O/
	 IFcSL1rD3uPw+qhk+qSqVz7081OVeyB4ZFK1NLAOWhBN8IZNqOc3vJryBVhaXIS4y+
	 RTfUtpH081gLQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4jF2Cg4FHXz7yvw;
	Wed, 28 Oct 2026 10:30:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jF2Cd4rrqz8thr;
	Wed, 28 Oct 2026 10:30:37 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 533C85F8B3;
	Wed, 28 Oct 2026 10:30:36 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <fe5a4a48-3054-4a53-8487-d968b3983d89@leemhuis.info>
Date: Wed, 28 Oct 2026 10:30:35 +0100
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
Subject: Re: [REGRESSION] 6.18.57: resume from s2idle triggers poweroff and
 hangs when tiny_power_button is built as a module
To: Mikkel Sejdelin <mikkel.sejdelin@proton.me>,
 Sasha Levin <sashal@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>, Ting-Han Hou <ue081723@gmail.com>
References: 
 <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me>
 <20261024-rc-reply-0001-tiny-power-button-s2idle@kernel.org>
 <dyJyEj-TY1YtRVdDYPD4xnYF_aIP78z9wliSc3251tj6aZEZxux0c81AiZAFPpZvbg6rjgqivtHTFfY29YHTS9WZmw569IbyVF0NPVTxqrA=@proton.me>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <dyJyEj-TY1YtRVdDYPD4xnYF_aIP78z9wliSc3251tj6aZEZxux0c81AiZAFPpZvbg6rjgqivtHTFfY29YHTS9WZmw569IbyVF0NPVTxqrA=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179317983672.1123909.5267239163159569902@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 533C85F8B3
X-NC-CID: 8BhwjSnzVcSoDK9NTl/C+VSzlBdyli9V1RllZ+Cn/TkMRJGgSi8=

On 10/28/26 10:15, Mikkel Sejdelin wrote:
> On Sat, Oct 24, 2026 at 10:26:52 -0400, Sasha Levin wrote:
>> I have dropped f4203ec64e11 ("ACPI: tiny-power-button: Convert the
>> driver to a platform one") from the 6.18 queue. It cannot go out without
>> ab06eb920401 ("ACPI: scan: Register platform devices for fixed event
>> buttons")
> 
> Now that ab06eb920401 is queued for 6.18 again [1], could f4203ec64e11
> be queued with it? ab06eb920401 alone does not fix this report: on my
> machine (control-method power button, PNP0C0C) it changes nothing, and
> tiny-power-button keeps binding next to button until it is a platform
> driver too. 6.18.59 is still affected.
> 
> I tested v6.18.58 + ab06eb920401 (with Ting-Han's 2/3 and 3/3) +
> f4203ec64e11 on this laptop: platform devices and bindings unchanged
> from 6.18.57, acpi-button binds PNP0C0C:00, acpi-tiny-power-button
> stays unbound, 3/3 s2idle resumes OK, no SIGRTMIN+4.
> 
> Tested-by: Mikkel Sejdelin <mikkel.sejdelin@proton.me>
> 
> Thorsten: regzbot has ab06eb920401 as the fix for this report, but it
> needs f4203ec64e11 as well:
> 
> #regzbot fix: ACPI: tiny-power-button: Convert the driver to a platform one
> 
> [1] https://lore.kernel.org/all/20261024105710.593-2-ue081723@gmail.com/
Thx for fixing this up -- and sorry, my fault, got that wrong, the cover
letter from Ting-Han Hou (now CCed) sounded to me like f4203ec64e11
would not be needed anymore.

Ciao, Thorsten
