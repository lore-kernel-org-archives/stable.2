Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=137.74.80.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733481;
	b=YCHWN12duRDRu+ZIS47HjhHzEa2r/GfXlc/37/4jBS1R7pJOoLQVEqzJvhXvqqdmFmmS
	 tqabH4nqu5xkrkU92C0tFX9nvv3UqUmPaSKRaiG19X4GsyTHEZzfOT4F+F++3PqFIwTKr
	 3kRcpHhQ8cm5YqAch8ea90nebK0yJLeaInq+I4BuVDxoogUCOfCGa3hACNGgWUpKzkM/v
	 n5XF24VHLNPn5u2RmuZgnlyK6k+5wNNQZy360+d6xpt7eGWEwIX6VpkLZ3xNAStpjaBL5
	 Ndzn4LVPE1WXXnjt7UY2Fksh0MHpFGUpEVLwZ/KIHGMakDp7MXvt7gBpmXQZqd+Nsnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733481;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spamd-Result:
	 X-Rspamd-Action:X-Rspamd-Server;
	bh=aOqxkrW83kpunAumN7rod+MaRbRg0gs5eEr4a92heYg=;
	b=0OaDf33lhnQod19/VzlvXrgvsVc6aQhzGStDH/kCYrBP2+QAeVyJKVh7h2nUpMTl/a/c
	 7U3uWf7tkOKqOrXbMnM+nU+nJPQ2SeJze2eZTRXHjtjfWGQiR43vSf9DolQts/WnMgoSg
	 keowq268Nd+DOt+7/s7Fk5iW2EQkUxleavi7r4E7gYCeTU+973HOtpA5XcIyv448yPeMd
	 6IiEWuhKLJx43+Gbu83Xys46D8P15yddWxS61uNg8cFYxNocsekcTJF2MzGT2JtuFJshr
	 jD47973F5jZZFdBdBo3KdwPG8Har0nLW14rKB3k34P5TApXI+0loCc9g+atiezROhFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aosc.io;
	spf=pass smtp.mailfrom=aosc.io;
	dkim=pass header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=iC+cU0M9;
	arc=none smtp.remote-ip=137.74.80.154
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9BA606A31D;
	Sun, 15 Nov 2026 09:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B9BA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=iC+cU0M9
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 9C6D6201CE;
	Sun, 15 Nov 2026 09:04:32 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.38.223.107])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 76D824007B;
	Sun, 15 Nov 2026 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=default;
	t=1794733466; bh=aOqxkrW83kpunAumN7rod+MaRbRg0gs5eEr4a92heYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iC+cU0M9VMvtQXr1DSggNdA8arI5Jso1ixqGVvyAdMQXYVekTFPD+EmiVKTqPLf6r
	 PG6CA0c1i7L1MZ6lXGzA/IsbknEY8e9u0mClSgIue5Tq985pJ2KLkEt9Q/fEmpZXjg
	 b1T6RKy4Fcpow4b1xd5UGQu+LqOuT+9rPPRtN3zA=
Received: from [198.18.0.1] (li1563-205.members.linode.com [139.162.83.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 401BFE1E63;
	Sun, 15 Nov 2026 09:04:20 +0000 (UTC)
Message-ID: <91614ad9-3110-48b5-ac12-67b40a0599b4@aosc.io>
Date: Sun, 15 Nov 2026 17:04:14 +0800
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
Subject: Re: [7.3.y] Please backport e517a172b776 ("alpha: select
 SYSCTL_EXCEPTION_TRACE")
To: Sasha Levin <sashal@kernel.org>, Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <4ab8d1e3-4e8d-4172-b36e-570eb1ef9e11@aosc.io>
 <draft-agent5-0002-re-alpha-show-signal-msg@kernel.org>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <draft-agent5-0002-re-alpha-show-signal-msg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76D824007B
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
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALIGNED(0.00)[strict];
	RCVD_TLS_ALL(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+]
X-Rspamd-Action: no action
X-Rspamd-Server: nf2.mymailcheap.com

Hi Sasha,

在 2026/11/15 01:42, Sasha Levin 写道:
> On 2026-11-14, Mingcong Bai <jeffbai@aosc.io> wrote:
>> Please consider (partially) backporting this patch to fix build on Alpha.
> 
> Queued the whole commit for 7.3, 6.18, 6.12 and 6.6, thanks. We have no alpha
> compiler here, so a build check on your side would be welcome.

Thank you, will test when 7.3.5-rc1 comes out.

Best Regards,
Mingcong Bai

