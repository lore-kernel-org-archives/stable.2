Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716271;
	b=zEv5Ve2QYZn08rHMACxlbYlm+VMiiF29nrDlr+wprWy9xM59ibEJXSh5OzWmUfBffEBb
	 ysMs6pmUSWHGRJmAcaGykuJ/SgSJTL2F6ZPS9E/Ih7j/YAuWA4lYyGz6YSSjuoeKeSxvY
	 WGscwK6TnkreVEQDMwwBwfY8rzIbvlBXAnmvNWPt2ZZxGrdQ6joPfUJsrqV1i7oUsxiTi
	 YhlFLk5Gi1+n9v6+CIi0z504CD+4iawJZdERL8u00f0qBH56+shmfPZBSZds7rWKab1Mc
	 375b1AMkp2ddW05buU29dWF3UMGbK3iHpUQ6RiLG/bRDv/21aVOv1cHZKom0gCPgEFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716271;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=1c5PCbIwwV6vQj5//fN+ktrM/G6dDkpUjrvlgV4uuqc=;
	b=anhOCa8DFAiTUOAUMXkmm9YQEGOtddRP5XTyEr2WXG+fmGVrst1yEJoZRQncB8CRXjBH
	 nCVEPYGZ17Ljg5hUaxRVFoOJuawbnLqexufzqbP9rM7QBGAY6589JvmIbAklpzmse7JaC
	 c5p6CK54UFh0/pU3mUqCsbReH9fDvgNhS+E/8eTqXz+iq3I+yaVnxlXBP2DrVnP4ZCoV6
	 k6tbi8FvrY25C/mc5qGPq77NfNxq3egG5yt8OEqBTF4U8+QphDojDWtQsn8SQRMwt8rIb
	 DTOtxb7bHYjd0c0qqGmw9zCgFI9M+9XUxYmWz1R6k+nuO05TAQEgkaWjqAapYaQrdLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="1yEXqF/A";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244F606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 18:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B244F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1yEXqF/A
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5E0281A0645;
	Thu, 26 Nov 2026 18:04:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2981860558;
	Thu, 26 Nov 2026 18:04:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED06F11E69016;
	Thu, 26 Nov 2026 19:04:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795716268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=1c5PCbIwwV6vQj5//fN+ktrM/G6dDkpUjrvlgV4uuqc=;
	b=1yEXqF/AvWVGxDC80ZsqgZJgPjMtRtg+ger1/TeF3eFPH/8UyuB8f8Iwv0O3KAOVg4S8Kz
	XdsUwf2RUkOy4OOTVrgJyCxjwPJQ/qBawTLHUupzmsi5YdlpTS5Qn6/MdCF4Aj4kgg1g5y
	6HIUJTHqIYXGSCIM/S19bBjs5p9ac/OKPvqUag0+HImxb6JkcncYWfhPWwNIQKo9jskPdv
	XTKnJDTESorub4cQtkPQcSOa58ZHZF0FgmpVcGkh2noaKSX9s6vgedl4W6EntEK2y0XjD5
	VHjqRzbkzJ9gWKm65mXutWoAcihLNbDi1ds3BJfCibZ7LZzWP0ksotHJi1e0NA==
Message-ID: <ef2953ba-1510-4bd8-85c1-81d4e45d2693@bootlin.com>
Date: Thu, 26 Nov 2026 19:04:26 +0100
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
Subject: Re: [PATCH] i2c: cgbc: Fetch the status of a write transfer
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Markus Haberlander <markus.haberlander@rosenberger.com>
References: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
 <179568834099.302193.16315749597111506309.b4-review@b4>
 <awgwO98qx3zX4MaY@zenone.zhora.eu> <awhxAlhwF4QF3V6a@zenone.zhora.eu>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <awhxAlhwF4QF3V6a@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/26/26 6:49 PM, Andi Shyti wrote:
> Hi Thomas,
> 
> ...
> 
>>> Yes it conflicts (compile issue) with the series [1]. The possibilies are:
>>> - I pick this patch in my series and send a v7.
>>> - [1] is applied, an immutable branch is created, you rebase your patch on
>>>   top of it, and patch is applied in I2C tree.
>>> - [1] is applied, you rebase on top of mfd-next, and your patch is applied
>>>   in MFD tree.
>>>
>>> Andi, Lee, what do you prefer?
>>
>> Let's wait your patches to get in first and then Markus can
>> rebase on top of them.
> 
> as you are going to resend your series, would you be so kind to
> include this, as well?
Yes no problem. Thanks for the review!

Best Regards,
Thomas
