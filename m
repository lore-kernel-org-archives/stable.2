Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794151108;
	b=3HbJbAWjRln2VCcCukGSnYidWExzfTYewGb7ID/kLmp8CBJgd9XSunXJgJHN7hftTn+3
	 gwIO2KwgmtppnuLRWnAIO5Wr6eZLJwM0iMRQSy6j4CScheZOGvXVp8aZvjoW0pLZgOXk1
	 2sT0Dj8I53IRU4dgvj7StQNw6JL8jQ+EtMOPBUn2jnjWCVc8ATxjcI2QIWHwrGmKYhX4m
	 rLf2YuCi3WzXikPbHm1Dgj/uqmIPQZ7FeMscwrmN2IbA8j9djRw02xayI9+OXvtHkPEux
	 xI2PZ852ITlDgCj/Gb5ahbDZpXrorJ/tHGKxoRuVme+DuV4KdmEb679fqNcE4iFJb0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794151108;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=e7STtpysw9I8m/43IhFTvhpryd3E0G+N/LKjSLSoWOk=;
	b=ZhWStFCxeZsHGZjMe3x2ud47jxMZrnkOPivJi1rH5kq0vswxRJ251sWr9rbOuzkp0sg8
	 MSxjVTGNpRIUgOqkyFUKKCSL7r2StdU6GgwRE6GRoaTSYsfaJu+wXer6YOWde+cA+rBBj
	 z5y9hU/5zG821dblNOHT73b3RSqpmLAKOV59V9o8RAqwI+YqM+4MsqXaMUPeD1nXaOner
	 AZjZZTS1FOhn1Gfk4PsZ0OppLbEtTbmKwi5rgEDYyJpqHOMxawfd9yv5RIrs5MM7/VFRR
	 +N/YL3o2i1qIZEsirwxoIuFo3yz0MljXSS9BZMGYZDq7Pm90edr8pgdQrx/BNjXI4Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=gHjciZYY;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB4606A31C;
	Sun,  8 Nov 2026 15:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3CB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=gHjciZYY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=e7STtpysw9I8m/43IhFTvhpryd3E0G+N/LKjSLSoWOk=; b=gHjciZYY88TzSIVnH7/U8ozKZb
	tNoKg7B4PsX5YJV/qD/c3yGeY8w2+WDXCvn7pxw4qkCi7/YMmLIWmau9hcQT966g/JzocOnUruapb
	k4E74qQsnHmxAlroG6ZrA9VN1+OgsMrySrBgwL31qVPSLTkGNimhbKZvqQWiINFU+DdoPFz09d/9j
	+/DlUH7duNWsyS6dKpRJ2wneT/eQzxLWFJjbx5U4L2YkG3ix1dIqfpPzkwGwQxD/5+iJcCg5CX7iT
	4JiH8HL5TQJoFLWrVrHAc+JJUYZve9fOFyLA4sFTtjAXTnHrJoP/ZQl4zI4uSZMQwfeqFMlP4ZOFn
	tXK11NQw==;
Received: from [::1] (port=45926 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xQ4f3-00000009ldL-3ofz;
	Sun, 08 Nov 2026 16:18:25 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 08 Nov 2026 16:18:25 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, Subash Abhinov Kasiviswanathan
 <subash.a.kasiviswanathan@oss.qualcomm.com>, Sean Tranchetti
 <sean.tranchetti@oss.qualcomm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown
 race
In-Reply-To: <20261108150339.GC18859@horms.kernel.org>
References: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179357635158.3286.10001576876397197758@kernel.org>
 <20261108150339.GC18859@horms.kernel.org>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <05a24913bdea1ce4482cace6d9772564@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-08 16:03, Simon Horman wrote:
> On Sun, Nov 01, 2026 at 11:39:11PM +0000, netdev-bot+sinfo@kernel.org 
> wrote:
>> Hi!
>> 
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>> 
>>  - How the issue was discovered, e.g. hit in production, hit during
>>    development, syzbot report, manual code inspection, LLM or static
>>    analysis tool scan.
>> 
>>  - Whether the issue was actually triggered, or is only theoretical
>>    (e.g. found by code inspection). If it was triggered please include
>>    the symptoms, like the stack trace or error messages.
>> 
>>  - What hardware the change was tested on. For driver fixes please
>>    mention the device (and if relevant firmware version) used for
>>    testing, or say that the change was not tested on real hardware.
>> 
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
>> 
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
> 
> Hi Jérémy,
> 
> As per similar requests for other patches, I would appreciate it if you
> could take a moment to respond to the questions posed by the bot above.

* The bug was found by LLM-assisted code review.
* The bug was triggered by a software reproducer with a KASAN enabled
   kernel under QEMU VM.
* It has not been tested on real hardware.
