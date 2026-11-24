Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795493590;
	b=kYjVtTjE2YcrAqmNjkcPZvDO/QoehZO/7bdfpxKN7e12WdXaYv2crQgt9F7KBt064rQw
	 fC0UdYnMgBCXVWCsRiw8h2zB4nGmCoXlVPMB4j0qdCRwj1M8CcpI6ZuUOgdj2FpdMY7a1
	 ee4RZ7euQku7yGKD+RTuntaUxDE3cDZspwDEH0OLX8z7CXzUgFHhzuXat1Haa/8hyP8/q
	 8+kcOAgQdAvDJs8+Z6NPjEOrJTVj3EImbS9zsW0DBkfptwq6xpp9gUbl+wx798wT0jKL4
	 ksi4ljhwPyjWKB8H+HL7rm0+8m78b/kmprh49reCKkucovbcpACToXElRuI1JzQzpDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795493590;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wgVbbg8AN2+MC7E46KUqvSner2LscJzA+99+j0fw+b0=;
	b=tze1PwG6h4oc34Nbb2cD3d1iMW1tTl8nK/xz4e2DJQELzw7iY6nEPPYUObVdNDd/CK5A
	 4JGyi/wmUZK1eHybA5fuCOS10BR5yNx0qPPRjAp4dPSLt5oYwTPlsD+Mi3FZ8/E2GFPto
	 BWeZlvt1vVpuzJtbHUHlfDw29Gkx85Kv5SMHVJyZH64DuYtUurhnG4s6fRbNZQ1pM9d63
	 9WoII3rN1ZLYx0voEGWp0rbqmbrB7Gsk+RH1ugATv4cMniiHRyh1ngYwt9wgBYZHMImoF
	 GCthvNz80OBUK0ja191hcOHVQ13OL8JdS63Gc5EXy1Ka7Il8UEGbxAcbQqEyT3uLtuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="f9/Yjb0N";
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98B606A31E;
	Tue, 24 Nov 2026 04:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF98B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=f9/Yjb0N
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795493585; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=wgVbbg8AN2+MC7E46KUqvSner2LscJzA+99+j0fw+b0=;
	b=f9/Yjb0NXEHBedXWjgqEvPuTBmkS669673zujoI6o+wM66P5KOO5vn4cw7APgt5XegCg2vj3pGjZLFlY01oSoMAu7hb6Vn6dFo1kZC9CXl1FpSuQchaWBHrlv2fwAekXtCHk4Xg+YwJE8MFHhjhau2V6RsuLDYBaxv8C+/Q1XSI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XFNJZxt_1795493584;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0XFNJZxt_1795493584 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 12:13:05 +0800
Date: Tue, 24 Nov 2026 12:13:04 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: free_netdev: exit earlier if dummy
Message-ID: <awUO0BqIzkLTLvFb@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20261107161415.1917665-1-dust.li@linux.alibaba.com>
 <2026112329-moonshine-vanity-29ae@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026112329-moonshine-vanity-29ae@gregkh>

On 2026-11-23 08:26:37, Greg Kroah-Hartman wrote:
>On Sun, Nov 08, 2026 at 12:14:15AM +0800, Dust Li wrote:
>> From: Breno Leitao <leitao@debian.org>
>> 
>> For dummy devices, exit earlier at free_netdev() instead of executing
>> the whole function. This is necessary, because dummy devices are
>> special, and shouldn't have the second part of the function executed.
>> 
>> Otherwise reg_state, which is NETREG_DUMMY, will be overwritten and
>> there will be no way to identify that this is a dummy device. Also, this
>> device do not need the final put_device(), since dummy devices are not
>> registered (through register_netdevice()), where the device reference is
>> increased (at netdev_register_kobject()/device_add()).
>> 
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>> ---
>>  net/core/dev.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
>
><formletter>
>
>This is not the correct way to submit patches for inclusion in the
>stable kernel tree.  Please read:
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>for how to do this properly.
>
></formletter>

Hi Greg,

Sorry, I missed the upstream commit id in the commit message.
I'll pay more attention on that next time.
BTW I notice Sasha had already picked it and added the corrent id, thanks Sasha !

Best regards,
Dust
