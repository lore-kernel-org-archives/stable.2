Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.182.66.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794650672;
	b=FLo5LtoHTGZsI/ncZ1AzvQWUUhrqtHyOB+4Wk5OzWmdBoc5dq+EcQghBq4K4Ij1u6agP
	 WDYP/37V5ia+d5wE26eUQb0bVuIbND0Qci1ULOHZAQKguAB4xeGxcJWoCKVO8JVM7HYsK
	 7tqdgeQ1MSkALRHBvCXfhxf/9/aRfrXQvtOMzw6c5OZbXg5vJgCunhlKLozANghL03TEi
	 HhtwEUd47bPjAwraShIAfWSTMbJa4vr6+y5upftETKeHkCkuyMMohLBIhz4dLYlhIBODw
	 Qqn2cljY0h89wZHwjAeyI40HnMqGictBiUJvJrMRC1W04hDMszUZwn51WPqkwMtiDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794650672;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spamd-Result:X-Rspamd-Action:X-Rspamd-Server;
	bh=cg6fKvnH/uKWYe/esn2QO5i04Su5kqIyBMMBNXXe/EQ=;
	b=fDd+NymSMIQ2NtlxnVQXm0c2nmBuCfWCHO4jxArrm/I6L3zlvikJzUU9L78FdS+xD5I5
	 UStAjjBiN9CJqvHZyh7pIAe+PLO82ArCAUI8rSuLRwAJvr8Rr3PqYgu6jkE+YFAcdtT22
	 JKjSTXt6KAgenBH5HBzRLqF2bZGa9sOVZOJ970q9LepEIUaVba4cBNsiLVsJ/YmjIT6v1
	 +lSyg0vymvlfrYo8tdV0S/pGJr7trVnJ6Zc/7QE6aZDgcsWUPzE3gNiYRE5IFDshZOSQK
	 giTTp3n8FXM7z7VLkxEZ5Bxh3tWyxX93bM7Tfy/bU13328IN1hlrAugWF4ptV81urjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aosc.io;
	spf=pass smtp.mailfrom=aosc.io;
	dkim=pass header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=uCJK5+6A;
	arc=none smtp.remote-ip=217.182.66.162
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315E606A330;
	Sat, 14 Nov 2026 10:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C315E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=uCJK5+6A
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 2DF183E878;
	Sat, 14 Nov 2026 10:04:24 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.38.223.107])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id B4E2240009;
	Sat, 14 Nov 2026 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=default;
	t=1794650659; bh=cg6fKvnH/uKWYe/esn2QO5i04Su5kqIyBMMBNXXe/EQ=;
	h=Date:To:Cc:From:Subject:From;
	b=uCJK5+6Ab0kTMLGbS+64UC/mQzolXRiVdFL33RAKHEc7eo+8g/3vw3GcLTFjf561R
	 Vh0h/dmmwZXlIG/Qm7VTIgE7iaYpCnkDH5GRR7hYcJBHCLBcqRJjUERtClLsgKqrm+
	 9/JqNKG86sY3NAMwXt9w13EIpoEygiMZufWuRsIA=
Received: from [198.18.0.1] (li1563-205.members.linode.com [139.162.83.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 5EE08E1F52;
	Sat, 14 Nov 2026 10:04:13 +0000 (UTC)
Message-ID: <4ab8d1e3-4e8d-4172-b36e-570eb1ef9e11@aosc.io>
Date: Sat, 14 Nov 2026 18:04:08 +0800
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
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Sasha Levin <sashal@kernel.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
From: Mingcong Bai <jeffbai@aosc.io>
Subject: [7.3.y] Please backport e517a172b776 ("alpha: select
 SYSCTL_EXCEPTION_TRACE")
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4E2240009
X-Spamd-Result: default: False [-0.30 / 10.00];
	R_SPF_ALLOW(-0.10)[+mx];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ASN(0.00)[asn:16276, ipnet:51.38.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALIGNED(0.00)[strict];
	RCVD_TLS_ALL(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,kernel.org,vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+]
X-Rspamd-Action: no action
X-Rspamd-Server: nf1.mymailcheap.com

Hi Matt,

On 7.3.y, commit 4bef20bbb9e0 ("alpha: handle VM_FAULT_HWPOISON in 
do_page_fault()") was backported as it was marked Cc stable. However, it 
introduces `show_signal_msg()', which was introduced with commit 
e517a172b776 ("alpha: select SYSCTL_EXCEPTION_TRACE"). This commit was 
not marked Cc stable and therefore never landed on 7.3.y.

This resulted in a build failure on 7.3.4:

arch/alpha/mm/fault.c: In function ‘do_page_fault’:
arch/alpha/mm/fault.c:242:9: error: implicit declaration of function 
‘show_signal_msg’ [-Wimplicit-function-declaration]
   242 |         show_signal_msg(regs, address, SIGBUS, "hardware memory 
error");
       |         ^~~~~~~~~~~~~~~

Please consider (partially) backporting this patch to fix build on Alpha.

Best Regards,
Mingcong Bai
