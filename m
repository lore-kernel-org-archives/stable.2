Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679964;
	b=LwmtVh/1FAbnwCdOx+6k5VLnAvcGv+EuC6St1K0jMop5xxF3vS4TTfahHE3jx6kbGxox
	 RXJRg2mGn+OG8TvC4DC+n0wdlcYXqP+rLUUKzCYlQr6y5w7FIQdeY0x05UVFF2sYddSsn
	 hfBHcJQSNBK0AqNIr8w6bOw6kCaGMRX2Q/PfDyy+lea1qjHUgZPsEO9X7ff5UzRzJF/Ys
	 a13sQeV0DS+wyjF5bjGMD96XEO136mQgiERB8qbAsKfIhm1E/LOtC2KOA4VYIarFYtDbI
	 G+qeojptMNhcIUIUBG3TVAIuaOxpkTR+n/XsCIcb3KfsJtsF5+PAXRMDDnaWn0YnPHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1HSKcZ386dxsdeEKyF2O6CNbJmYTmTebSN/jET/L4ME=;
	b=Bes4BJsCjZ5AQR6MZcdvPjrsSS7owNEpVEwItkWXpZ0NbxLOqi87FsrXr+HfWw4Up3vq
	 pdqnX0ZJSeBXTdVHoEQLHEZlglF9rdfJ+FDEL79Y//S54Y1GEnTaMDXw8ThqFPxTVGbJT
	 cQWijg1pGiokK7sQabS3ACCGcragXDbBuU6nRQ42Hq+4k3C56Y+sQP1k9UJ6AsQpWkzJp
	 nEMqFh1T5LFOhOsx4IEVCSEhIRK5Kvhp7ohW74G0f+2s4IWiNgsH4VW0nwad67Wj9mb/P
	 zJg0MFLvhK9PTpm8y9BG2aHDFskGyptknIaMCglzHmAAUGe5u8gWGotQuZfnY0uHumg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G36KZgS2;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB802606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB802606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G36KZgS2
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-37628596783so3634251eec.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 10:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794679962; x=1795284762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1HSKcZ386dxsdeEKyF2O6CNbJmYTmTebSN/jET/L4ME=;
        b=G36KZgS2YkgFo4UVn91i8GWeVFgU6FJTUeyRnNUic2C9jHhLreydD9U0nFLc1KZUd9
         DDodhaJhDk0exZwqzMNB8gbvEaS9f5lacEOlx8ZWbXKcXxNKivjfJvuI9itb9n3r+PyL
         3orAY7qOpRgYrhmOuRyInjYpyUdP1SItWby+udlfr3C6Hr6TC/rm/wlfcVkzmYycft0r
         QYN4dHu8aVdPU10kBe7XvWexZHyC73A28pZR2SdWq/WeVKOBefenWOT7qeDZGH1qH0ET
         3Kyp0tSJHVKCvK6JARG4BRLoz5O5Zj/7y2jeQ/SrAgBsIg11Y9jTOZf7Zhz5g4UzhHIz
         Ivlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794679962; x=1795284762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HSKcZ386dxsdeEKyF2O6CNbJmYTmTebSN/jET/L4ME=;
        b=Rd04r+zLixsZJPgHB5YMtY1A42lpLEl4O74i4q4PS0TrBELY9JP1i4tJYAgH7g9ZoI
         ivBYC63sRpx1wKeUo01p4VRWj+JXUfWYHbr9sedr73cfSeBL0TFOiVvtRy5C691xnmIO
         RBJ0L+WIW87bDWv+4bPKCGcZ8Tk10Edv9nZAii6QJr2Y4i1bd2cM9b93bj6m/lBd7OmA
         OnSzgXqgDlxgdoBUfFoqrJmO2LaRNgDjQkNo7PQZElFu+3osftXYSjw0nBSImNWNuR9o
         IwnoLm6q+NRq1GjYolmDF3b/qznQ0CcfuK8K6C9AJSngnlxmVw2eJGYe0gjz1EZJUMO9
         9HXg==
X-Forwarded-Encrypted: i=1; AL+hErFjmP1d73A6tOqHjbVF4+VD8WBHoJHsxCo0MtQ7QEIDMb00YB5S2gh7uSRTce444dPpCwIB0Bk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vZEK0BcGOmCJgBH2QJm2eYoleeojYbyqWIkUp9H+yTZOwrlBa
	ElPWRJxvms5wS5Enxjh6CemtgZaKU0PKP4jv+TTEBErVx+3h0C3bnplymKJCglHcVGA=
X-Gm-Gg: AYBFou19vBj4hr+I8Dcdc5FZUjZAi50bKmxxPjN/+oyZvzLubAywSw3pzXN6DMforTR
	T/XZaoomO7/kQxHtkQSpwvkK5UZQRvL0haTO3Nsz2jNxDOV0V9WiRKfj3ULnj3pPqgw2DF4TAmq
	EIL4ZlKxQPNEJ1MvS1Ay8NcaHjqzSV81xSGJHRmwaFO0rgXmYxnCqMJrgcOUWcNEpuqGlMVx98j
	lZ2azO1GBtNbag5iTSq0fROyzW4PVM8wH/H7UdU6I+5+ivvBNUFmQXclyd52TmF63DvHU5t/s/o
	+9Ju5s6e7kGWMdXaIJTlFNzwjTcq2MifpwwmVEdOetgLA5PBIbA4z7A5mZLsu+nKmaeyq1QFA1j
	uIQAuIMo5x9QhlgR2U05YnmnFwN58nCMPAracjf8oLzvXC0g+l3c5S4NTV8M8ozXtqb6mtDk6ae
	ljQYit1Q32jA3NQ+ueqJkc2hF4ri60mirMZ7esFmn8u9uIlBFVryKjyCe8X1rR4DRFt+T1MTO+T
	rklwwlFDfB9lTzVoBH1onIBTFJbnoz58R/Q+J6zD2JRI2NfgrvttnYJ1Pavm7ASqwGzbcPxpcEF
	n0UpSNe8xW1CdMjUyCbM504rxlGe41g6GdNow8NyvqRwsNBSJkJOcVrNFJkS6pdcktOw6cDyGnt
	GDWU2B8qJ0OU1
X-Received: by 2002:a05:7300:f794:b0:36e:58f3:6f0e with SMTP id 5a478bee46e88-379635648c2mr5638645eec.5.1794679961789;
        Sat, 14 Nov 2026 10:12:41 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d73dsm19082212eec.2.2026.11.14.10.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 10:12:41 -0800 (PST)
Message-ID: <5d92861f-9a4d-4810-8700-b9e457ed9c86@kernel.dk>
Date: Sat, 14 Nov 2026 11:12:40 -0700
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
Subject: Re: io_uring/eventfd: registered eventfd signals only once after the
 cd305ee3633a backport (6.18.y, 6.12.y, Ubuntu 26.04)
To: Sasha Levin <sashal@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 Yufan Chen <yufan.chen@linux.dev>, dev@rebasedinc.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <oMhla8VwCWoihfrmgn8znIy60W1QXI8g_v2OyB9i6sWESIDlVJlwoGGOLylJgIHRARNoieXUVRGqzeB__KvHMdXgnCfPPovs8vLMOzaMPEw=@rebasedinc.com>
 <draft-agent5-0001-re-eventfd-signal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <draft-agent5-0001-re-eventfd-signal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 10:42 AM, Sasha Levin wrote:
> On 2026-11-13, dev@rebasedinc.com wrote:
>> If this is correct, a backport of 04fe9aeb4f3c to 6.18.y and 6.12.y looks like the right fix; it keeps the CVE-2026-80920 fix in place.
> 
> Queued for 6.18 and 6.12, thanks.

Yet another bs CVE - Greg, please invalidate this one too, it's NOT CVE material.
Getting a little tired of chasing these.

-- 
Jens Axboe

