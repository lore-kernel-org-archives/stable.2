Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5641F16B;
	Sun, 30 Aug 2026 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788059162; cv=none; b=hWVku59zNX4d/wuYHaiQdgJtavjALgqIEYNLMIY0myGYt5oaHOJS7DqQjLg7bPLndp7SWW9Cx1O6xSpmmRfFR1wyfYXkZonGIU0rLsiVb3Tsy/94t8E60WOmOFLSwpHTtJ3/FdT2rMfBbdHWj76ZcXwOPsSt2Gay0hqH+sHUT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788059162; c=relaxed/simple;
	bh=btUdien4X03r/bYtFjEtwNeg6d/sq7hCybcPbCk655w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JtGt1jdVQczAwgIPNzrhCr06DoWsdF6tF5j/mSAaPPs8Pg3R57ZN155jGWKe0kxKjJfvgZPYfY77foW7TINcj3jl/P0v7uu9WfE5ZEJr3H5HI6HliqTLagZ+sdCRBksOxouN+KlvtQrENijzJHXjISDeomNQciW6pzpEQwsx1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=cQlounGN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IgbUBrDI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="cQlounGN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IgbUBrDI"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E3D3EC009F;
	Sat, 29 Aug 2026 23:05:57 -0400 (EDT)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-02.internal (MEProxy); Sat, 29 Aug 2026 23:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788059156;
	 x=1788145556; bh=2mPrcxUIlb6P1C71QqRY84XP3tOg7Wpod+DsO+QOdsM=; b=
	cQlounGNWbshLukBHa4LvJ6LVv775fz/ta5lnmSSjJS4IWivO0OirZ9b9pj/t30u
	P2MwydYT/CNaZKMT8w5AFR1fLxILnACCvRSYcVuhhy6VmVx+ClQQ5MjUCUraotBf
	qEAqqsf+6lbKFauocrWg1P5Gkil+Y+7OUVU63tuwPwO6/BAoHsVBmZnp395V8V3J
	1xNR24J3j9TjOelCMZN4VaKA+RoZAesk6pYJlaYxGfjXBjBgDr7H6ixaqn5p/d9H
	o405KhwwJcBpUZ5LdXcMmIVkgdCvPja9KcYBUsXjNr1dA194pnpckUXt2uMFDWrI
	vqTe5cLdURd0BPJvBQ4beQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788059156; x=
	1788145556; bh=2mPrcxUIlb6P1C71QqRY84XP3tOg7Wpod+DsO+QOdsM=; b=I
	gbUBrDIJtYWJDw4G5jC/h32gpbK4o1S4K+Zs12F1C6CllwNNwvpQfDYhkWcPJDzf
	daHOgmVmjbzCG9HbydJVvvToJnDRFEdSuI5xXf4pY1dYovVxnwqGXc98QrWKS1Sa
	SUqfgh/WEgW5Ey07MXVhb403tExaizAIn9RugTB5w9ocPma/rHm9tljwqqz8gPMz
	kPv3zrK3NE2wz0alz5nLHa/AZTpg14H+ZsGobSQ3mvmOD8DIID2GxofVD2cynMjq
	4mo5JkHxhQs9QV3BZCYdts+0TwFJI1caCLWL2zaz5bFwocLfIR5drbfrFrHntQcf
	W6rfjlvsMWkk3A1mhAaUw==
X-ME-Sender: <xms:DZ6TalUhQJzwBexGKjzcXsw_Y28rUS-cOAHwspb2ILsGKHbtc2dDQA>
    <xme:DZ6TagZjK3Ff4IbXTKrfvrDqztALmCGAhgDfLAGv1UQfEJvRnNLfEvg2-Mcu8HXFh
    hKEysf4ggg5iJnGJ9ls6AczIcMfZDQZiZ3F4LeFmasE3jpIGViyTTNt>
X-ME-Proxy-Cause: dmFkZTGFi6RNXqP0OtdG1Q4b8vZYGqR7g6Cwmi1B54xX0XlPUk90jU1P3LNGqMVy+DX+dW
    0BzFT4XKc8m5lc6u8BhQjvHUT0QS/59zhlMKo/9iIv/lvZKUHIBB8wkKB/GQ+4xHUe5rx3
    D3gyIxc5Ug8iqrkLI6vBWLgcAwHoahIdWiSqEHGRd5ozkVqGBwrPMBd12YnZXyvYv8l/PW
    zdAI71UjHwP/StVtn5jzpBqeYa47CUHy7S+Cbfzi34QaMF6mds17eNIH7uraTXGSVqpGmL
    N3inJWMoLiMnrwecKGemQdC9noI79XbT2879bBuE9dfs9+P4w24m9RBYF/t/KEaVsRA9Oc
    6orbRkBXpvnVXhNyQWrp5jdOMV8Z2jLAoNg9DnNexwGw3k3REtzZgVYNwednYwJCJ3o0n8
    +6/lAcDWxH2N39gI9MZv4L0IF6vdrk7PYNYu92hmP1tD8KMPVsnBkJC94SGKrdmP75eSbf
    sMYYDZBTSuQrcaQV4qJDP5IkUJRrQM4nWnmY2zFR3fAP6InZWBv1xmOqy853yAQKFQAMDq
    jJYn+hVnjQARb01C76UVyUk/0U6bIzzd8gSZalnNgczS8sYHh2dfCuNo+2vuRE3KZaNNZ3
    PPbYKq+Di/IC3S5RgztTfWwhg4bshZ8wXFn3jjqhRjjanzxW6aszznEcaPuA
X-ME-Proxy: <xmx:EJ6TanYDf8r-oI_LYKvBUe95306_rSZTg5N7nItBfNhD2cpNLJo8Jg>
    <xmx:EJ6TavzIXqsXegTv5iB9nILTRHTgW97VY7ge2xWs2TtsSMSdzpz4dg>
    <xmx:EJ6Taic5PcAZQyKFrtXtoeelx3-ryvK60-86SMAGDx7CL96huFcF0w>
    <xmx:EJ6TatLdlpmWi6ygSUI7nmvoNHVSf4JFPyfPi5zDE6m2SjhbJho2IQ>
    <xmx:FJ6TakBU35DxOk7x1TWTE3frZeWRQ8WtfBNkl_8nxqoadCsQGJeLQP_a>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 97C9B2F81644; Sat, 29 Aug 2026 23:05:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 30 Aug 2026 11:05:29 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S . Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-Id: <cea78eaa-aea0-4d1a-9695-8a6d73750216@app.fastmail.com>
In-Reply-To: <DL0P7NCKVU0I.ARBMN6GAMMBS@bootlin.com>
References: <20260828-eyeq-reordering-llsc-v1-1-0c5a69fc5124@bootlin.com>
 <DL0P7NCKVU0I.ARBMN6GAMMBS@bootlin.com>
Subject: Re: [PATCH] mips: select CONFIG_WEAK_REORDERING_BEYOND_LLSC from CONFIG_EYEQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, 28 Aug 2026, at 11:56 PM, Th=C3=A9o Lebrun wrote:
> First off, sorry to net maintainers for being in Cc of this patch.
> get_maintainer.pl added you and the MLs because the commit message
> containing "xdp". I deleted the MLs in Cc but forgot the individuals.

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Can confirm weak ordering beyond LLSC is necessary for all MTI cores wit=
h CM.

Thanks

>
> On Fri Aug 28, 2026 at 4:07 PM CEST, Th=C3=A9o Lebrun wrote:
>> On I6500 CPU cores, lld and scd give no ordering guarantees (same as =
all
>> other instructions). To respect the assumption that arch_cmpxchg() is
>> fully ordered, we must inject sync instructions above and below our
>> lld/scd loops using the already in place WEAK_REORDERING_BEYOND_LLSC
>> infrastructure.
>>
>> Otherwise, bad things can happen:
>>
>> [   34.054496] CPU 3 Unable to handle kernel paging request at virtua=
l address 0000000000000000, epc =3D=3D a80000080838e01c, ra =3D=3D a8000=
0080838dfc4
>> [   34.054559] Oops[#1]:
>> [   34.069561] CPU: 3 UID: 0 PID: 170 Comm: pipe_race Not tainted 7.2=
.0-rc6-01553-gb73c35220968-dirty #103 VOLUNTARY
>> [   34.079932] Hardware name: Mobile EyeQ5 MP5 Evaluation board
>> [   34.085592] $ 0   : 0000000000000000 0000000000000001 000000000000=
0000 0000000000000000
>> [   34.093616] $ 4   : a800000808ee2618 000000000b7a879d 000000000000=
1000 0000000000000000
>> [   34.101638] $ 8   : 0000000000e3f2c9 0000000000000000 a800000808a2=
a9f8 0000000000000000
>> [   34.109660] $12   : a8000008139ffcd8 ffffffff84080018 a80000080837=
fae0 7878787878787878
>> [   34.117682] $16   : a800000807e82940 0000000000001000 000000000000=
0000 0000000000000000
>> [   34.125704] $20   : a800000802920e00 a8000008139ffdf8 a80000080264=
9400 0000000000e3f2c9
>> [   34.133726] $24   : 0000000000000006 00000001200406e0
>> [   34.141783] $28   : a8000008139fc000 a8000008139ffd10 0000000000e3=
f2c8 a80000080838dfc4
>> [   34.149837] epc   : a80000080838e01c anon_pipe_read+0xd4/0x428
>> [   34.155697] ra    : a80000080838dfc4 anon_pipe_read+0x7c/0x428
>> [   34.161549] Status: 140000e3  KX SX UX KERNEL EXL IE
>> [   34.166551] Cause : 40800408 (ExcCode 02)
>> [   34.170574] BadVA : 0000000000000000
>> [   34.174161] PrId  : 0001b028 (MIPS I6500)
>> [   34.178183] Process pipe_race (pid: 170, threadinfo=3D000000005ca3=
5720, task=3D00000000e1013890, tls=3D000000014ebbb780)
>> [   34.188568] Stack : a800000802649400 0000000000000000 000000000000=
0000 a8000008139ffdd0
>> [   34.196623]	 0000000000000fba a800000808ee0000 0000000000000001 a8=
000008130c3e80
>> [   34.204676]	 a8000008080d1280 a8000008139ffd58 a8000008139ffd58 1d=
bd2b22ea1dd500
>> [   34.212729]	 a800000802649400 a800000808ee0000 ffffffffffffffea 00=
00000000000001
>> [   34.220783]	 0000000000001000 0000000000000000 00000001200ae518 ff=
ffffffffffffff
>> [   34.228836]	 000000fffbe0e530 a80000080837edf4 000000fffbe0e530 00=
00000000000000
>> [   34.236890]	 0000000000000000 0000000000000000 000000014ebb55a0 00=
00000000001000
>> [   34.244943]	 0000000000000001 a800000802649400 0000000000000000 00=
00000000000000
>> [   34.252996]	 0000000000000000 0000400400000000 0000000000000000 1d=
bd2b22ea1dd500
>> [   34.261049]	 00000000140000e3 a800000802649400 a800000802649400 a8=
00000808ee0000
>> [   34.269103]	 ...
>> [   34.271568] Call Trace:
>> [   34.274026] [<a80000080838e01c>] anon_pipe_read+0xd4/0x428
>> [   34.279533] [<a80000080837edf4>] vfs_read+0x25c/0x318
>> [   34.284607] [<a80000080837faac>] ksys_read+0x104/0x138
>> [   34.289763] [<a80000080802b9cc>] syscall_common+0x44/0x68
>> [   34.295187]
>> [   34.296689] Code: f84000cf  02209825  de020010 <dc420000> d8400004=
  02002825  0040f809  02802025  f84000c3
>> [   34.306504]
>> [   34.308099] ---[ end trace 0000000000000000 ]---
>>
>> My initial reproducer was the xdp-tools test suite. A standalone
>> reproducer would be an lld/scd loop that, when the read is reordered =
by
>> the CPU, triggers a fault. We can achieve this from userspace by
>> stressing an anonymous pipe, which uses a mutex. Program used:
>
> Simpler reproducer than the C program given initially. It takes a few
> seconds to trigger.
>
>    dd if=3D/dev/zero ibs=3D20M obs=3D70 | dd bs=3D4096 > /dev/null
>
> Goal is to spam write(2) on one side and read(2) on the other.
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

--=20
- Jiaxun
