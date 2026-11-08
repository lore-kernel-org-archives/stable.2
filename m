Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148564;
	b=oJikIhwRpYDxQOJN6/TFcQxS3gTYTMaUem+Q3uW6bztdMhpPZbritND4Tlmk7JMQiwJd
	 jtxmS1mfcHTYUDxgk2FWI1C2S02s6N3vyOjJ1MVr0Zvss64q+XTQL2iyqq669WbdZtzYS
	 B8j9lNsYAhv84NhJQIlabnTwAjn9jXxvFSHU4E3RUDmQf33ltAv6RQswpLeZrVBsPbIZv
	 rBcQX1yCEbzfSUobhpVeNRDf9lcJqWDk08unbVkv0454bg+ehiA61BR0rQ0oxO5Vb5fax
	 eHzHhfZH1bcISbBhNEnaYe7cVQr6FdE7n9VDz+f68t5A5I5MRDcj9MImOyH9d74ERrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148564;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=u7inqwKFfb3gTPBstYWmnGcwWeA6cNNlSHfLt3zFDL8=;
	b=V4rxdnDlOQePotohbVkvLx8P7jrO+9B3j+rKXTzpRrgeM/3flW2aiaLY08tkOw9ZLPh2
	 Iryfcau7+ZXZIm9DHWuiGHhsdoLtphO/IfVDW0P5SEkv7hBom+etSwa//PsPI+MsCEb/L
	 g0BSXZCcXxNV1yrUCM4j2Ub2f/UMkFaZhNwFOCLetDnbgQcyfSqHqvHF79bGFC8hEy2td
	 GwTCSfgumckXBtSt4lcDhMQXqQT2+oD2ebhn8pWa5mxVogIi4Zc54x3v1oTeA/fg/cE5C
	 2105MSWMBAS4bGP++3LroGvV9wuODCLE/QhfnVaJrIILpNwHF8rHNuZ07sSDDjakWbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="ia/80WnC";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0D606A31C;
	Sun,  8 Nov 2026 14:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7D0D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=ia/80WnC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=u7inqwKFfb3gTPBstYWmnGcwWeA6cNNlSHfLt3zFDL8=; b=ia/80WnC/SbAVB42dNROaP987r
	rsCVmQyd9J8dZGJdcLwpFxefAqIT7WQojUi1HFfZGe0RH4b6P5ofemhxFujPOqeNxsRQ65NwzG/lh
	xYB3mczUO9VlJjeuoAOMolDWO5Y4m5Q60+X1kHGDC6DVr9NKX2hoix7eaRYXcZbpC/2LXysrSS8yR
	F4FPx4RvYRe2ergNnvcnhRiVodG/me0LljaBez35vbilc3KVxA5MgXdmLnA1PNGdaiboRJAlPCLY6
	59/wNSsM6LU4yuPUgtbg5hkKVJ0bRanXKJYkuGd9b/b+flcs16AM8iO7/mwBezXVBG33If6tetnyV
	UNHUpJVA==;
Received: from [::1] (port=49964 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xQ402-00000008amI-0wSB;
	Sun, 08 Nov 2026 15:36:02 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 08 Nov 2026 15:36:01 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, Subash Abhinov Kasiviswanathan
 <subash.a.kasiviswanathan@oss.qualcomm.com>, Sean Tranchetti
 <sean.tranchetti@oss.qualcomm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on
 byte-limit update
In-Reply-To: <20261108141812.GA18859@horms.kernel.org>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179348482309.3286.17799482231932078029@kernel.org>
 <20261108141812.GA18859@horms.kernel.org>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <5a28b58c53e167ea8b6e0218fb63f54f@oss.cyber.gouv.fr>
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

On 2026-11-08 15:18, Simon Horman wrote:
> On Sat, Oct 31, 2026 at 10:13:43PM +0000, netdev-bot+sinfo@kernel.org 
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
> I would appreciate it if you could take a moment to respond to
> the questions posed by the bot above.

Hello Simon,

Sure, here are some answers:
* The bug was found by LLM-assisted code review.
* The bug was triggered by a software reproducer with a KASAN enabled
   kernel under QEMU VM.
* It has not been tested on real hardware.

Regards,
Jérémy
