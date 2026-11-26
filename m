Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704033;
	b=ozhdG96qohoNuBFMbCW0GbKCnWqecGV1vVEi3bAuHmS8rnEzpUoRupGklN13Jsc059JH
	 CzegbQX3x6jZfGGuQzSI7aooPYUES2iwdqDso3ON1bqO6QgzyPTWjM3Jwp3vMonrrIn3X
	 KNK+AZqDOYU1xabwIEGq+T/EJYImErrYA2AUemo3pB9pasZ/XkwTafnSLUh4rXwNl2pZ5
	 YKCRy4gjP8dIidSI3JzLX5vgNf0DPKJA/8PTB6KflkD7XQuDEvbh1M6W2s1bncKJ12hnZ
	 KPc3Du05JWmKLeCsk7Kmb/w+uavfmEgk+HcxVTaQ8zqpLIH9GlPBIQKDNKMqe083TSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704033;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lscJSZYibXtaHkly1WX2zI5TxDx/Ues6iHpcftAsrZI=;
	b=MycavgVm+Xfn7Oapze3v2OkjCUtxDL04aF09e9VJZJ7UVRyHHqs+dn3ILgI0EOLO5Hko
	 UO7QC3H2jkCeJPMYn4THDBdaCRWp+x9cnh6p5afXmXKyrVppClHqu4iLYxmrZFB84V0D1
	 UxoXrs+Kmjb+z+AdftX0dEmiH8x0JjexV23H34UGrmOqH3wWUcziIkyTv6zr16D2SD1sV
	 58OUxrqnxw5zRdMP4SuOQ/lJ16SFHkLZrtkV+3rbEMABIMpdIjQPpk97MIPlKJ5O4360e
	 FhueRuCYvHEU/ALX0TDxGHVYGTx2JfmNW+2qn3GzNp3GOCuJyvE87i3PSh5ez1no1VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCCg1PWJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4074606A31E;
	Thu, 26 Nov 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCCg1PWJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BD41F000C6;
	Thu, 26 Nov 2026 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704033;
	bh=lscJSZYibXtaHkly1WX2zI5TxDx/Ues6iHpcftAsrZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LCCg1PWJPOCOTlOo6LcSvdZMHotdUnnJwLuAdNDK3dg7TJOz/1yqZcsJ8xY45zG0B
	 KlU8MyyjGJhVR+nN2x4RnhECwsNrBboonSPhXCmiJzQK7v27TKiyYjyP7ue5bbebM3
	 F2UZt3zQVfq+h/gdYpWoMJFGhcdrc+dGhDp3doLJiQghaTmO2ZkRp0QKnFYvhYODfr
	 tdHgKb6zL1BVUtkqfi+xjWs+XHsNwBpXzAdyLgvZX/4QktjLts2nNKBVeEWPNs4acZ
	 UfF4K0YDG0HnQUpjo2ABzpvraDw1W5QLmtvbleoPT44whBPy+nByJJ6SJ0CDL2il+k
	 RIxpd482ny6iw==
Message-ID: <c6ad3ad2-fd56-4164-bf50-0ac0bd9b84af@kernel.org>
Date: Thu, 26 Nov 2026 15:40:28 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2] iio: chemical: pms7003: Reject frames with invalid
 length
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 stable@vger.kernel.org
References: <20261126052717.69095-1-zhiqizhangg@gmail.com>
 <20261126053526.623714-1-kapoorarnav43@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261126053526.623714-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 6:35, Arnav Kapoor wrote:
> On Thu, Nov 26, 2026 at 01:27:17PM +0800, Zhiqi Zhang wrote:
>> Reject data lengths shorter than the checksum before storing the expected
>> frame length. Keep other lengths up to the frame buffer size accepted so
>> short command replies and compatible Plantower measurement frames can
>> still complete.
> 
> Thanks for the quick respin.
No, please wait at least 24 hours between revisions in order to get more
feedback. You may waste reviewers' time by them reviewing an older patch
only for them to find out a newer one has been sent, making the feedback
irrelevant. For larger series (i.e. new drivers etc.), you should wait at
least 1 week between revisions.

-- 
Kind regards,
Joshua Crofts

