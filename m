Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE509486E43
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394923; cv=none; b=aHjRZYUNXI3l2YjXreBzeDPp0hU3zbr1AAQqiCiQgzo8n45jb2xTcabcXADg8+JK8iXRJGkYLOtJ0Z8IDTfc92W5432GePng8OPOa9EM5hVLRPZ/dk5ZnNv6BFPM0Vc46bhcqlpb1+ZzLdjCWk/23T4ttUpN/LFFoGRUfb6VwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394923; c=relaxed/simple;
	bh=+EWke+kegKWW2B563dpfhTyACjX4Bih9IB1dZgkly3I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IN2uY2+8gl63lN/wIlsDBm3RzWaUFmUXsflDymtmC+lfAn9dq3vBQj/1dlIgo/ACh75+L00stfy70NOYT9tRoHqntDYmdGpC0WPH0/JvPVFWy5RgSHbTpO6t3h53ScKWq8LH8rIE8e452nO+QxR9fuWmMvnVDQqrHmUvqZ4qg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dAZcgL1X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VrQOALa1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dAZcgL1X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VrQOALa1"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 016117A00E9
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 03:28:41 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 19 Oct 2026 03:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792394916;
	 x=1792481316; bh=PLHYJfXPw5eZbHRCcZ0a6KnmTa621kQU2YjXteB/tC0=; b=
	dAZcgL1Xda48bGQNimvV+30TMDWB34dW9GlC5BFaeug0K5leO6Iipw9N7StnEGIS
	cNAIRj+KjBBi1Y2XcWg66eQfdT1Ifu/Q/JhNWHudkDtwO98sGq/DVAoD0AFppOVO
	TgBLbF0VeNMEWgfJthmS0MY8uEpLj/me+9TA/n5nGF9XDzJEWVfWv1xCwUlQXnzM
	/1IkmutlUP3oaoAGMiUAYZq2XWQWO9SFKTSwighnSjjQoXLXJZNG5oEatSWrTQ6V
	jHOAhMSFYC53fq3ah7ewK13fPzf6/0Tx3gbWr2HiBOIgurSaaAHq6gwVjj+3L8ZZ
	gba1EwKudsVvN9OD8TaSFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792394916; x=
	1792481316; bh=PLHYJfXPw5eZbHRCcZ0a6KnmTa621kQU2YjXteB/tC0=; b=V
	rQOALa1QDxzsdLrV+6cFGUFFFIhTiUQQr5UwqTAkG8kJf3tOcPXalv6cKmDbcVzx
	rAqGa0o9t2HivL+B8t9oDRt43k4QoXvzMsVDjxqzKXSP7KjSxlNmljaF2/uk/ukE
	Q9wdV0kylvNP5hwwpCf8Au+uxqRB7/H4YElPhiQ4JH8o2FEkVjQnN7vuBSDG4Crf
	SKKHaakVwV/CmQHWmM1DWF/DYQ7eyth7SXlsRLOwOqSr07yRctuhsKpwdvIsiDTy
	gYUTi+wV/ZnzI6MR+1wbXKb6fGmNVfLwQakupcWSNM07PFqcJ9/r6zCXuOY6B184
	cjxbKef++G2StWTbzq1Bg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792394916; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LKXTo9Xsncg9WAQPoWqWH4tg1iNko6Ye2T5UJvSd+Ifr8EG
	+8bQ3exWazJVMntUHQ0COf60Wt9m44fwSyQX5Vfx6p1Ie4gFOSdBYnVxUeG7KVTj
	sgY1QQyZWhlQz60ABPUYQ506Y5S1iyI8Dxrnh3LtlKXxhti1XWMh8RENaEtERhZC
	+4kLE9tm7aA5slLkmKLOkIGcwmpiQF5AMaWP6Gbqrib5Oncc7bpSiiMESN4GLc9Z
	wvCPNsgvaoejsUjpVdX9qvz8AInMjgIuwANOxzIrAIBxpGIL7CHy7qZ25quRC0Na
	U9XMVTVAqsU2kQX64dYcoah+skp+g/4S2LT+9Pg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mjPdJaOz8JVVi9EZGnwjC/k/+t6i0OU5KJZVz1cg+XA=:+EWke+kegKWW2B563dpfhTyACjX4Bih9IB1dZgkly3I=;
X-ME-Sender: <xms:n8bVar0hR9ty6kHHUR1QfQ75S-iQUsyT9fJHkfkfNPeFK0dVkydCiA>
    <xme:n8bVak7_YyElYRzuvT3GNX5FqzEKmky4a_dcj5BRAC99SKMbmzsmZAsqr79qSE5Vw
    yBysE5zCE5Es7pwcGNr9dOqxeTKtoSIux7CT2fqjEut8BEGBIBeoDsQew>
X-ME-Proxy-Cause: dmFkZTEgTR2xr3LjwoQxTz4QE7mX+5PH46bNXCriRkEqgyvLMfGBx4gYCV93emLUYy/l5M
    Uj0lDN5V7zucVcFPXh1K6dNdKEEFwfXHUAHartXABXQj/TBlb8Sd2SoVVoaHQnzMj+JH4u
    rHfVcJFfbgA92Lex/Nk6wLuWq0JDbqWI9Sx+NsXOzqG0RJWZ3apQcBaysEfF8kv9uVnEjX
    3tdLlo1+2Tv3+DpYfHNghLqk99BH+v7W0mmQ9RosYwG6Q2Mx/Np754/4x9TNHahfr53oOi
    qVGBqJ98QI0LAARUdiTHlPZMJwD+rLIpw09e8M0Yykv4qtjMhkSxktzahgs/WxhsSbjAHX
    JVI/h7iHJ6Cvm/7eR+xhyoKmzMJDHXjSbueGBGFrhiOHS01V7UfR8ldnhfigDagAUjH5Pi
    lL2viOH/uQEpCEHZZt7oRLZNpi0mn07ge3xyABkkcIcoRp5HuVUCjRykLaY6Fh7IpCocMT
    Rc1CShHHTCYtzf/kuPU02sKSJfCiRBQJ4TisBDVU8iY3R/Pd8x+ZlSl19LcMqREnO2Fq/O
    kmLfzkbfNTVy1d02F8djTzJ7HtdiR03t0rlKldRLVaeAPSMIf6hYND5uP997F4j+82i28u
    fHtZ8l8i+SeM16P3hjDa4n16/IHIFRWkfb6u9WgEbaXn1M65duq+3wZS0v8w
X-ME-Proxy: <xmx:ocbVasb1HjVuJubc-t3mapr6ddPtKOWHhY5rOIm4Sr0iUEGCqzN51Q>
    <xmx:ocbVavmZ-Hcw3Io5zJ_6bHf3W4o-UF5yf12p5-N6h20zRWvP1V-NRQ>
    <xmx:ocbVaigHNthuBahyYD7Qq7buCImw9V4_idiE0y9HP9P7OBQD7m8d8A>
    <xmx:ocbVahSCx0Q7hjy_DGU--Ab_5Wo6I5cOJl-7cdar0GVA3QfgXzq2yw>
    <xmx:pMbVasjnztBiCuEhrfCJBjyRwPp0KnpeJ--w7f6o7Hf3WNuPTQYJTOas>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1F95632A008E; Mon, 19 Oct 2026 03:28:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzLNdjRv6F_B
Date: Mon, 19 Oct 2026 09:28:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Huacai Chen" <chenhuacai@loongson.cn>,
 "Huacai Chen" <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, "Xuefeng Li" <lixuefeng@loongson.cn>,
 guoren <guoren@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "kernel test robot" <lkp@intel.com>
Message-Id: <7f22dbbf-98e9-42ac-9c12-f6b4377ee430@app.fastmail.com>
In-Reply-To: <20261019031436.3523632-1-chenhuacai@loongson.cn>
References: <20261019031436.3523632-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH] soc: loongson: Make Loongson-2 drivers depend on MACH_LOONGSON64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 19, 2026, at 05:14, Huacai Chen wrote:
> Loongson-2 is 64bit CPU series, their SoC drviers are not supposed to be
> used with 32bit. So make Loongson-2 drivers depend on MACH_LOONGSON64 to
> avoid build warnings:
>
>    drivers/soc/loongson/loongson2_pm.c: In function 'loongson2_pm_probe':
>>> drivers/soc/loongson/loongson2_pm.c:178:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      178 |                 loongson_sysconf.suspend_addr = 
> (u64)phys_to_virt(suspend_addr);
>          |
>
> Cc: stable@vger.kernel.org
> Fixes: 3d9aba6618d1 ("LoongArch: Adjust build infrastructure for 
> 32BIT/64BIT")

I would prefer just fixing the trivial portability issue here and keep
the COMPILE_TEST option around. loongson_sysconf.suspend_addr is
'unsigned long', so just cast to that instead of u64, or
change the suspend_addr type to 'void *'.

      Arnd
