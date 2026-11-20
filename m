Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158799;
	b=N3sHgQ05XeReDdldKzxP5cWMJoJeyCsFL3YMBlS9qUBzHfTLSZHuPB/nkrwu1Khmwzau
	 9CQMltDjvKAesxtBzZba2sLD8ipjKx/FizCFQZGHdyIy+ZUfex4khDO8KymxxxPLVquEf
	 Ooy8XY5iL6DCZBOKHlD24XYivRbWYK0eusBt4ekP+b7mkado5KHiS9OFUY9+8xmdHpZon
	 iJ7ebm0hfVuCCUZdr+IkRfrrFssLqisiS9ljkGoI4/lAJYsggKqL83hd2IHwL0ai6Gqzl
	 ukl5GanpQaUpjV/+h7+HZjhfCps3hW2yNHk28E1jr2FfE6oYljOVL5fSMXE+Oo0O4ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158799;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8VV2fV4QspWOtIgfNZ89pr7CT+8Uxrr6UYvFlPopWp4=;
	b=pSC+b955BoGWr2NsTHrZngf+H2Cxx3rk7bPBWCHxmZFdkcb1GujIjgWfLmr+neMlNrB+
	 ZPRnm+VUaDE0n6+jQpi1Ade+rQ051W2ePD0XsM5bRmGvFSJwCzN7zM6xgT0puXG3s16Mo
	 Gijp8dERQBb3/9uHOlZqu8t7ACU4ZHjX3BjpeL6yO9Ky58vAl3y6g64/KLFLyZV5YnChs
	 9YZ0cX5bBPsrJIgLwchnqU+InvzICyFI+OELHE6Zisu984zU3Hy7lVEHhtFLshJbF31hx
	 2/6ZiZCeqFSNQBm/LdSIDDnuIb4xys2r1fdj0OVD8KzVil20mEC0eIEmYKOksBsKPiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GaU3lld7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jK8QcBNE;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0C606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B0C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GaU3lld7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jK8QcBNE
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBB8E14001A8
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:13:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Nov 2026 02:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795158797;
	 x=1795245197; bh=8VV2fV4QspWOtIgfNZ89pr7CT+8Uxrr6UYvFlPopWp4=; b=
	GaU3lld7zcq7b9uOytWiEmsVS+Dd5VWsbWP9qWbv0cEfrI0Jgb1LW+tduuQfJM84
	Z56ifebk1SrA/UXOx16bAohUzcI3yW+x+sgD+jX1csjlxeobvf9iVJ+lGXAqjEMm
	jeBwGUOQ49IubXQB0hENRNbjh1Pqv6qctNTr19d9FxTLKFQ5Iy2jN4F1tzVC/R0S
	zP6jElrFw46IvArk0Rur8lC4yAyFvFVo/+napebNqPlHtIx0jVjtnqmcMQMG/4MV
	Z4ZK5lxwL28kOfTYNxm0XVcUAN4pV7dQQP4BLt4BUeExxV+CLHtv4UDHtcN6qlvV
	fxWgjAGMrPIBCgGJzco6Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795158797; x=
	1795245197; bh=8VV2fV4QspWOtIgfNZ89pr7CT+8Uxrr6UYvFlPopWp4=; b=j
	K8QcBNEnLoyJSIC5xH3GTb3kvOWT8w4EX3k+Ua+ERurY+6icDVXVyeR6JZzoVKyj
	BNwMlLw6P090/LGg8UZQesS2q84UDWcZtHVYGBcQ3vcPp3KIKAkpfYHLh6KVkQDQ
	ZzUurwxXLgDjhtr8UtbMdjiY+Nic0s65q3MFUjRQ+EGmJubIYhPiybytRrZtLGFH
	bYRrL5uGkJpgBxTCrtIuQYTRNxxwiN+WHXOKoz8ZNnEGyzs29vC3m2/UE9EwxCw+
	US9NnWcGSRW/QEn8hoGm459/0kv5moiAGysd+8MebgoyG/6pQsFQbuWv5UPdgnmL
	Yp5Iqr91p2tX7MhTCHGog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795158797; d=pobox.com;
	mf=PGJhcnJ5bkBwb2JveC5jb20+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KDJ3wkoiLpBy4GylffDuNc8PIs1uGZlyMeU8pMWyQCA/efo
	ySiHbuHmBoPoPzkN0ZPt6DmK3bOzOWOCaW9EUxpdvEVPvXuXt8kiUnISXmxFCk9R
	T1f5oSihcsv+CCG39clQh+t/virV0y22qhBgx+m+W1O9kLjdxFXqbd0ZDE8yOEcp
	7ggCyAduF1u+k41qLVmHVl53ih/P3zQgRtjH1wkaer+LgOIRnS1VEVmcblA6Q1Jx
	QOGeRzjWEMPb3Abttv3GwcUCt9JBcyBWHYThf/A+cNZ3K5ldNtbNwbo3cOs1FWI+
	IccAOn/c42GXxRsSpu4GIgImU0BfTOIvYQBbybg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UK4nk/KL2lpAWw8PZqqIiMvwFg/ddmIA5W3iJtjEueg=:iTLGmj0zPHz3USB2pL+zEMdDzdPOkcVuEZ9EyUdRig4=;
X-ME-Sender: <xms:DfP_aj7nORI5gnzosujopMSJ0qhuXLa3dgNMxjdZhALNYBUia9mNBw>
    <xme:DfP_akx4lJVOfndW1xY9QIeT4YRHdoW9zFN5SnVPhhAbMYwo4CIMM7gWEx4F1inyB
    waWJIAuVLqvYr8LnGIORKd1lHnMJ7kRPfRYVPSWnFr2-Mr2SEKO0tvE>
X-ME-Received: <xmr:DfP_al9nb-s4qrIvwebg017CW9bIZqo3EbNnpRq1qM3XQDNqjs9evwUaiqOUXp6FUSof0mp3VOlok8vPdQNrb4V36xcif6ep>
X-ME-Proxy-Cause: dmFkZTE0IqbdrswRFyOK94QTyk3ATZE6LnKbHBv4ERebW/hCB1O1egXqrIudLZ4YLT0Lc1
    10oqWeMArI0KkbFTinbT6//1R2OcinDwT+qP71yXi4B3Cc/A0AiIJNMjXuRzgr5pBEfINv
    YuSTZayQK4mrZaTq+cMNMdTHt9pVOza3nwKOGOEebI4xasKpAzxxim1s+oE1PdEZ3pmTIk
    vyWaE/HSNveyQfDs5Dw9O0oJaCyFjHz9kI8GFE0u0oOog1XrioA20VJBXAgf1pnK0g4b6l
    aFaz/WBdes5UCfpnPA8yjCq6u2lHoogBDBK8qw+w7xyuRopShI/1AjnR71W+mGIvDKdnEk
    BaxadHQ+veWwt0cgzcqtC8FCIfy9zuApwSE/zMLptSIfyCS8pUWAt5KGkCrH8gqyS99kzl
    CqcTDBlNYSZwDcb1BrrutQTgJ2786obLNsLdkWFUXMQL0Ab6dOsuafui3BVfbhJmuY9n4d
    SECXgkcEH6OOyCEkzT8f1MdfX9WdRVtk/YCVMTXgC0Ek94wcVIY3ygDUMvbVE6M8PkbBXZ
    yMqZCJ3eg9/72iFQSDgW+f2ieTuO3FCvSceoNLZEPtNZhTaQxi0tWkIz74+MXb4w0jzvd3
    wWyzRbC+SQSAbE0kQzZkpeRKsAP+tUJtDoGL1CFhvJ3e7MD/unJZGNRMNH1A
X-ME-Proxy: <xmx:DfP_aoFHVVb2xApIv7-0BF4pWv8yVINxzA90V2ivmifkwFGTRQuBEA>
    <xmx:DfP_avAQ5aRvgT4WkYQlbzEZ92D7jw3fl_7I2hdkyECUuuyem3QGXA>
    <xmx:DfP_aslsW4ABwrBe78LYcsLBOXsefJ7ylBE3buKUJ8ut0mf5O2Z63w>
    <xmx:DfP_aiQJwGv5txgz6WngH9v16AzMtYX1dOlK6hUODbnM8R028GlCLw>
    <xmx:DfP_apN6AJuspnGmTm5pCySeJgZPKpA75VRcKPpfCZu_6QdA3XJsohoU>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 02:13:14 -0500 (EST)
Message-ID: <2f0ad321-ebe1-4735-b854-e8862588be2a@pobox.com>
Date: Thu, 19 Nov 2026 23:13:13 -0800
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
Subject: Re: [PATCH 5.10 0000/1811] 5.10.275-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261120054906.397973290@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20261120054906.397973290@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 9:56 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.275 release.
> There are 1811 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 22 Nov 2026 05:44:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.275-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>
