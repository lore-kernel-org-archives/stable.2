Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716556;
	b=Tt64OnFvdKoX2GiK2TsJCUzjeOdVJQ9e5baut3LoYUflzMwQKoIjoUtX587EJcex6loS
	 KbGObS8S+qY5nGSO8s4MVN0snX/gkfa3RAREHguOOi2LxapvzA7AiIjv1yXDeZXnlPtC7
	 nz3k6vKT9vraTCBKqCd9TlaT+LsG5p9H7q1bX8+QW1QqCpfoJbdFeNwpewzeGE6JnGmnv
	 oYHDCL00sicmuQh4hZCuBt6A+TLfWDky8NpXpB9OONYDUZWuz+LCpaBPypowPaq2F5S5m
	 Y7WC8Dq9uI4h1EW3mgZ+YhOrVwlLWwT+j7nJew5/uW5UPBrx0w6eY7U96sqOM28iizg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YXt+m65s9sfa6GGsjmbISDgFqPDceUiO6WhfTNtsSu0=;
	b=yZmh7cUgeefcCPHqaRg8d09dtsB7EyJm16Oc2XqGuoNdmPvvmWrPqqz+mhC/84Hnu3EJ
	 TDUKsQPTVxtnd666beJn3Ckj1N4fUim0Dm3MY0jzs2lacWbS9C9GdvfwJJREjq+Wtz9rR
	 iz9WrAlQyHzr08pMZ3yOJeoyaKQQt5zI+Cf8bpUc1pa3kOh+PHNFc7LKNsmDGsY/hP0vK
	 2ZCDR5E797NyYp3dOK01iGZC+1TDYWvNXEpPth/ffyNKqYd+SrLOCll9fDqElzPkBenMr
	 XnLH97daKCc8yfSEc7iLiBa6NcZNXLBAFJqx5tk2/g6eb9td/JbwTMLSCajoHyQTpOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=CYD1uaP5;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD5606A32D;
	Sun, 15 Nov 2026 04:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EBD5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=CYD1uaP5
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jRyWv5gVszllN3x;
	Sun, 15 Nov 2026 04:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794716553; x=1797308554; bh=YXt+m65s9sfa6GGsjmbISDgF
	qPDceUiO6WhfTNtsSu0=; b=CYD1uaP5muJc9HvBL7/tluqrK2CCgOX45hYSTcHy
	cpQAmCpFgKNqjOrwbKy7ymHmHTPvyTtedn4+BLqRHnd1SfudmKhxBqxrT6se9HQl
	BMrHlcv7+5ppoqXJJ9OOkcCXviWheA7PL/5RvEfmUhrku6eCrIyWNvltBfK5Rwc6
	n87IKmeMK/1EEn9ps2SU/Qqb3svLThBnCquHeer4NiAw1VrBqD15wAbzp4/ITPpS
	+dRuc9UnmRSj6oxlAv6KB275muRefPIfvPytqOaup7dOfdh22nTtqfd23td9/uUW
	ntpUBqTLAbuJcP3pi56Npbw4CoGgUyDzUIM/TXQbfEBwdA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FiLQlFqH7Juo; Sun, 15 Nov 2026 04:22:33 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jRyWr4kCGzlffvQ;
	Sun, 15 Nov 2026 04:22:32 +0000 (UTC)
Message-ID: <9e58338c-282e-45ed-b78c-b2032e5b5f73@acm.org>
Date: Sat, 14 Nov 2026 20:22:31 -0800
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
Subject: Re: [PATCH] nbd: do not reinitialize a live socket lock when
 reclassifying
To: Aibing Chen <chenaibing@cmss.chinamobile.com>
Cc: axboe@kernel.dk, davem@davemloft.net, edumazet@kernel.org,
 horms@kernel.org, josef@toxicpanda.com, kuba@kernel.org, kuniyu@google.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org, pabeni@redhat.com, stable@vger.kernel.org,
 syzbot+b29ed72382b0e218323a@syzkaller.appspotmail.com, willemb@google.com
References: <426d5936-54aa-4b4a-b70f-73f506c5a902@acm.org>
 <20261115033749.827-1-chenaibing@cmss.chinamobile.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261115033749.827-1-chenaibing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/26 7:37 PM, Aibing Chen wrote:
> Are you (or Eric) planning to prepare the
> revert of d532cddb6c60 and 9280e6edf656 together with the TX/shutdown
> deferral to a workqueue, or would you like me to prepare it?  If you
> would like me to prepare it, I would appreciate your guidance on the
> workqueue design (nbd_queue_rq() currently transmits inline via
> nbd_handle_cmd()).

If nobody else volunteers to work on this I will take a look myself.

Thanks,

Bart.
