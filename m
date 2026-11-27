Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761624;
	b=fovLHTippC7Vy9e1Z8XjMfyk+TZcfcxejsV2f0EzE05DWu3kXeYm13ZKknrE8p5wiHdn
	 LhXuCnOZnapj43sY4Z6M+P5jRXSccdQhSBJI+wRCqf8k3vopmn2RpaZL4M4LqmxsgcW5E
	 MHSIAYVrlhUMgHUmwRKbidOcwjLh/7llywmyQqJ42SDpbV1PZQ1QyOkJt7t7b1rrGDlw4
	 TMoi5RhiLQx0LTyk1vhm+mAZayPddKQCXyaZFH0IJJkErIAj+6be0OvqcQdyjnvyqTQBK
	 CmFthmrxYud2+uxMsc79GiMxpVtNMwG9nBNo5dYZgY5ZR4I/DLwFJFjY0ALmcu3zHoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761624;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YSTvwPI8uJayXDJex6KW3iyWn5M4RVNCOcwWBDWJ9y0=;
	b=SUqzeWfDWvG+7nUSzV+GFClQTFUB8LS7TH2of8Y5HklY+fLeP7flxbLtjoVtfYnx5zoG
	 al7njJK6gbpBQ73g/8NA29Mv7pgal+rqZtvwrzZmH3CX2zN3k1kVr16KcAfyr149JGLvH
	 xG7lC6qpV6GrqL47zNn0sl+R6jyitNnaL7UwuFxyg8ktd5I0ImCGkOuLAPIxybCw1cnoQ
	 EVUVnn0NF0ctzof9lk+bs7BI8YkqbyxzTCyQHYlA1T/NdY09g+bUdJQESTxJWdMl1gwsU
	 V3r9e77nAGJWFxAAUYbrDMitXJefwmUMi4wIOI2QHLPvNzhQ/z79gXGfhAxENqnbNKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=n98iRn4T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w5Vzkwen;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58C606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A58C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=n98iRn4T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w5Vzkwen
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A3892EC0B24
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:40:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 27 Nov 2026 01:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795761622;
	 x=1795848022; bh=YSTvwPI8uJayXDJex6KW3iyWn5M4RVNCOcwWBDWJ9y0=; b=
	n98iRn4TVZgilWz0YrmbLZpAztSGdQOZPRYuS4Rev8/xIydYRU0P/t/iSYWP8dg+
	oaY2hnqdFouBixlIL9NJh7BkXfxe3ksxd5LZi37wEGdEwL2bR32ihATdAHeLRo7i
	tEKy7jcL1kP6M2LJLjJCx/jZ8szhtwlGlRtAsfJxlZWjJ8R1xo4Dr7wdIqdNKImm
	/v4lLZ/ysf8ajyme/uGCRWIKHEeawSqXnRA2Xib0PONc9itlP3OLks7nUqsMbyfN
	FQf7qlkqJ1WHZyTH8aFbAUSBl9JSqNztU3p/7d/6zc4uYfSVCWMl90fyXMtO9x2Y
	cRsJn68ba83J2zue8V8yDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795761622; x=
	1795848022; bh=YSTvwPI8uJayXDJex6KW3iyWn5M4RVNCOcwWBDWJ9y0=; b=w
	5Vzkwen1m9+TuVD+skmXOj4DcOrF1OR8FH+dYjiyBwKU7w+oYoGFTaCfIeVEDX2O
	qJ6YF5v9TaE6LtNPQdWFiXNuAb5aDH5hmoLNNL7h8XpjEa/6tyu3xTXDEG5ffcSG
	eVWiFEortCtzyNkW2nr0cZbLspTqcXIzazQf9M1eUZB2MGWh19/iVsHanoUqWlGD
	qvyo8cktREqiZFsjTJj8r7COlg+bJYshB02ppDaV2PcJXgNS7TRgPiL5J+WQNxe9
	0UcOjMnFKAk0rlBS9Kc2m6XpXakS/GxxKpxOOAsDsMJgxBo13IZ+nX7Auzc6oOrd
	HvOVviv8orJIU6fYYYWFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795761622; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ZnFDZcRtz14OBl9SjO7cxmtTXikFJ5k5v8tOSgPL/U0LWNS
	ggfpPH7472NoeunPzEFw41kWv/QvpPyXKeF7fVggRRFuHMjnKYrv7ADOZLtlrTtF
	4S0RJ0NpcyLZceFbwcd3EGIYaBBPsj9Yk2ZbO7SMeuN6a74M9fdlK5fXTxKpR0Gn
	yxoit5Del+HdqNDImfB/hkwuxL9+HiJtDYE9AFnOA/8uyL6W9opHx+ziEOx9osVz
	hHHA7nkUOAfKEIG8jrGKciG1P5Y6raLLxeoQGYsRNuN/89jjEDm+5ob8Ei1txRYR
	MePLtEBkrSJodzlGFqrlYx7SN5NSYs8SB+DFPoQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:W2snzuKcscKbgP75bzxbIrqywLLxG0vnng6g5T/Juqo=:8mlGRY+HP0m41SDgzy8rHCGzA3Ad7xjs/rZ7OB0AGfE=;
X-ME-Sender: <xms:1SUJaz8Xx7zho4Ht4w7tSBYOFf6YNNeVcSPdgD8-bcJlQn7sDNYP9g>
    <xme:1SUJa7nOviuKMPRdDvnBQTvyCKFTVrqyzZmVgxSJqtogR64iVyPnilIURnOEcDMDz
    JdfyAwPBBF-lzuW5XspjY3I4TPkzSzNOMYUvt_KYPzF2Qqaw-qMB_a6>
X-ME-Received: <xmr:1SUJa8ghmBeX1a1xrkv_cn1vPuW6lJYzU3RQFGZep-L_dCo5adOUMn6v06DN90G7HKM3UoKQSzt3aPss4MLW9Nvt8PBUmtly>
X-ME-Proxy-Cause: dmFkZTE9K/2WQmeS5DN3A/bfu9z7ombAqQKJIFl1b4Zop3LZ+5VKIpR6WSaXj+3ARfi5/i
    v9bOAnaBcTJC3No7DFIbkQjMCj+amHIcxVRy1Sc7ZW5lQE2oXc9oE8wGfllp/25CkZ+ojA
    1VSH60pQscP5sYO3lRaoV9+xIjE4hKoLU2+NcdUT2EKo7ZlkxpaUQ1QUxfsuLOiDAaZFHx
    ri8EvllyZm0VXehzVTjyXg5WtUV/tn1K5U5Xsy6CeewJiFrjmCwRlvVNO6zuYKh1pwENs/
    NuzlFAq3QdvAtfwJdGrYC2WiRp5s7W5Ddc41K3a7jiTF5YNfd8rX/GFrr9byVlLpntIvOr
    bumARZP+WTsmGzwxA730xkk4hW2q2C4AagOBKcVO0PtToezbOzEIZ9hQQK1F+40RG5xisk
    5NKx6P2C8g1swI71QxlRp1QMamJ94tP7RX4KvNn/cW18m9vTGSx6WxhcLpuwJdUpb8Yux3
    GJmQAnim/D/NfQhZf5Bu4oW1br0/+YI/DfSsBiE7g8kI6V3ts3RS4Qea3iYHFLcmDOjykb
    00RQ9EdnKk8ZwQIlsj2PsuboO/Zj/+XeBDIbrolWInnuXAskJwXs/lrogVc/K46AaNWnjX
    PyLBs0WlqgU71mEcO3O7XpR+t06hWojHP79zcVSmh4aEHVLAZwJ9ggEGenlw
X-ME-Proxy: <xmx:1SUJazb88qGKnMbFCU52Ol0xOwTG9uxWS4CHh0-AqGYIQZtv_jRX9w>
    <xmx:1SUJawGgQRToldsiMR1VX24XZ_EaiQqO2HceC_LbToyP3_ZF9n1jRQ>
    <xmx:1SUJawad-bRWb200xNgkPxuy0G7LUHWEOOGeeL1EXpM3EHii2Kh_Fg>
    <xmx:1SUJax1hrVAclJ-aLft9oVcp-bmE4fnWQx_X-dcMJRE7L03wt2yfig>
    <xmx:1iUJa0Dl3qOJfZMM0c0QaxMz2pvpGCFOUrr9bt3th39jjjjjXrkx2XG2>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 01:40:19 -0500 (EST)
Message-ID: <603e9158-d907-4d7d-9ddd-bf8eb3bd1f99@pobox.com>
Date: Thu, 26 Nov 2026 22:40:18 -0800
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
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261126105725.767748294@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261126105725.767748294@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/26 2:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.66 release.
> There are 990 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 28 Nov 2026 10:55:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.66-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I took 6.18.65 and applied the stable-queue as of commit
936541b23bb407322981540c7964c73f2ae436f0 ("drop 13 patches, add 2 and
fix 1 based on RC review feedback"). That's the current stable-queue
as of this writing and includes the changes that were made after
6.18.66-rc2.

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
