Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778604;
	b=t1p1ReOUSD20yHHhgtCKneqR7VELwKpGt9l41ZcGKACFWrhprWZucOwqMPTxvrOU9Xk3
	 9soBskTAHgDMyI6ug59/f/wL34fGaDuCdDAdMIKfh/WEK+3/Kc5U4K6IMaamCxqVzIMDD
	 NIy/k37bOXNHnoK2s7yU/qQ7+77yvuqY1C9VMinvRXt9BJKT/HLv0j7w1CWNU1xGhpyPL
	 ldQk+9X3Jafddmf4+1KxzqNcFfA7psV0ah3kZPFEBrMgjk5bC60KlOPnCRWMYSW+M+5sb
	 4zxEGUHsHcL/rsiu2CtgFhDabZGPB0UCbEihLe2yM35nxEQKOJgKn6mpLgTDjxJDxfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778604;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NyAwWvZGRqt2fSINn3TXW/MK3vDKgb//W9niGurTNZw=;
	b=S6rG+lonRKfi256ixvndtA8r7gcx0Z3e7ac6cCreKQRb2TgpJpV0w2rMCBsUc88Y+XLR
	 BzohSydlEYaC8r5EROAnOSRj2+IgT2M+KHADwXgNyruvEWCrK3/XeClTD0OtuUOjWez4A
	 6ys4fAFjEgKNsafH/gs2L9e2AG15Y1XZ0KFbFLRZGzQ3G/W2qanW5lJq9JBMGqhBEuDVX
	 JIJ5Xp6AERTJSqO1pvYuO3Yb7c+lqPpgm0IpXBf4ObjTBhdzMn2No8KltdG+5Hu+Nun4s
	 Z1NWnlbfQ2jOK82myBEBpiQsNTfVqomfMW38s5IXB1oCroWA/BF62fD7RYqP2rvc8sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMcbjK82;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iGp04ng9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C7606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE3C7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMcbjK82;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iGp04ng9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793778602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyAwWvZGRqt2fSINn3TXW/MK3vDKgb//W9niGurTNZw=;
	b=jMcbjK82dytXHw8Na0yTN2pag1huTSamw2ntsgo1yNBeCMMW5ZkNlyh0AZKSxZoxfDcQFZ
	SJd7sk4XZPm+s/efEyFQUPBk2Ahw8kBt5ZkfF71xoCUR29CSm3Sf5urn4npoFzJrPtIDUB
	piwylWjH7Jth5PZ4u1WC7s09RZ7Ae+A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-ejDYdoxAOWqDW6Wj10jphQ-1; Wed, 04 Nov 2026 02:50:01 -0500
X-MC-Unique: ejDYdoxAOWqDW6Wj10jphQ-1
X-Mimecast-MFC-AGG-ID: ejDYdoxAOWqDW6Wj10jphQ_1793778600
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso912608f8f.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 23:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793778600; x=1794383400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NyAwWvZGRqt2fSINn3TXW/MK3vDKgb//W9niGurTNZw=;
        b=iGp04ng9jOg+JXfSK9/ROWoPdb4aGCxKYduJh+qQrF/+pAGlq3STfAeqnB7Yl7WS8S
         5RFuZypuFySAx5IJjX4BBXCQtu/o/eMfnSpEkyBdxR2HzcZlAcYRYOtPyaHrJk9deivk
         CpMZ7iAf4rnxui3GHRwQ/rfDz2o742Y3p2Mi5ecDXF0AZzCgE023dXQ6oqe2m2l1UQVf
         gmGd7KehuVBjzJ9R8PjVfM55Ik2Kgop73ll6QfdoRpmUOlzNWdvlSCe/2jo/rChFx/1O
         h6XDxWHq7lilrafWtaNiJbuVlZVm0dPXwyorQw/Bn9b3L8l4fyZezHy3N5WLl65bQ/+L
         SIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793778600; x=1794383400;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NyAwWvZGRqt2fSINn3TXW/MK3vDKgb//W9niGurTNZw=;
        b=wG6jNraTv0XQ7kV9Ld/4ohggg1vVOZfuT9RmQVnKEJkoVf/OsyKEFYsrxA+gzBxZbO
         2VWHc9ieEYMSZwLsdvuwBbke7DoyK08NYidB5vFp4gXQHL1igh9Mb+lWajzqLNo9AXzT
         UaxhvgIw9d8YV1QbZmEcmDdD+q9kKIm70/ElkPABzE/I/T7E1co+vayyixMkhd50Xkx3
         5+OvheQS+xMBdWyDBfOnaMnQIrldveoUGg+7MAVrJkNXLbywak83+Z//0GLuEEJpY7zY
         FimbX4wYS+TFag7USCnaqr+AyofBmqLyojy3MePvr6+yR74vvLmtI5fqBbhnii5Xgzip
         VGgA==
X-Forwarded-Encrypted: i=1; AKwUvBwlxBy3XjNYEManJ4jMmQyygYheiKDT4T1v7oUzK/WKuweJb6Mz/CbZl5ozTqvdGo4F55YZu/g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iT/WtMVLosI438qUnXj04Pu5/D8yYEpEH3GGug7/7Cb0JDfWe
	CP6JNyTRGSDlogWnEEXdqxBMrEQoDYyE6aKebg/va96FsDodxQPc3CM6Xt+RBANPlmKSDcVK/VE
	PLKuy3A8IGxogxfvDvmkmRdmu84PydeDI//4wlFnFenqs/8GEqqdBknadjA==
X-Gm-Gg: AYBFou2vWcqEwcIzbPAP6ze5uazvAseb+eDdYk9gy7sUQCrh2D7mecp3Fjn7MSYwXLt
	GnvDfdvl/7xzOwXYMw44WC1JfXdCRduO9IqtK2N1eNy/cWw4G73zwCu79OBNOI6L3MiChxkGefg
	G35X7PzA2IXwTUZPB/qsWNHL8i4M2YEPSpXEhWdcB48W1H+rXo2iFvtaWJYFqK86LPqCeWk9u1H
	YXvDxsmX5lIlw+QSn5UpMdAPGmAqEyNZ75q/Y7fVQ9IJ6cZVD4c41nyETHv+5bivbe0RcCt4xm3
	Zo24YoC17HhHrfIuZYnxd+BS9+UATbvz0TsOh9UuLHDD3ADqPpY+BGH+ZlIQG/hlUkgbl+8BWBu
	mkWSw44XL5PZiOOs28dnDEwIRCkeusMOAfmuMUoElb+uHRQjBGV06Jgv7BSRqLdw9zBQWjV2h+s
	hziaoe04W+XJGlsrEgM10p52qt9rzPHDnL0/yrCTIfm6s=
X-Received: by 2002:a5d:584e:0:b0:48e:6669:fefb with SMTP id ffacd0b85a97d-48e6e2e2369mr36435239f8f.22.1793778600093;
        Tue, 03 Nov 2026 23:50:00 -0800 (PST)
X-Received: by 2002:a5d:584e:0:b0:48e:6669:fefb with SMTP id ffacd0b85a97d-48e6e2e2369mr36435196f8f.22.1793778599451;
        Tue, 03 Nov 2026 23:49:59 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda2007esm2308479f8f.47.2026.11.03.23.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 23:49:58 -0800 (PST)
Message-ID: <9490ec30-10db-42cc-8071-2e8cd5dc5a3b@redhat.com>
Date: Wed, 4 Nov 2026 08:49:57 +0100
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
Subject: Re: [PATCH] net: ethernet: ti: cpts: drop the refclk mux node
 reference
From: Paolo Abeni <pabeni@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <20261103102858.1340800-1-vulab@iscas.ac.cn>
 <dd92fa56-7c57-4a6e-9598-20d4363d0a66@redhat.com>
Content-Language: en-US
In-Reply-To: <dd92fa56-7c57-4a6e-9598-20d4363d0a66@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/3/26 12:23, Paolo Abeni wrote:
> On 11/3/26 11:28, Wentao Liang wrote:
>> cpts_of_mux_clk_setup() obtains refclk_np with of_get_child_by_name()
>> and only drops that reference on the error path.  of_clk_add_hw_provider()
>> takes its own reference through of_node_get(), which
>> of_clk_del_provider() releases later, so the reference taken by
>> of_get_child_by_name() is leaked when the mux clock is registered
>> successfully.
>>
>> Drop the caller's reference once the provider has been registered and
>> its devm cleanup action is in place.
>>
>> Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
>> Cc: stable@vger.kernel.org
>> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> Please have a look at:
> 
> https://elixir.bootlin.com/linux/v7.3/source/Documentation/process/maintainer-netdev.rst#L386
> 
> also please note that such limit refers to related patches within the same
> series. It's highly discouraged to have more than an handful of unrelated
> patches in-flight.
> 
> TL;DT: please stops sending new patches. Likely a very limited number of the
> one you already submitted will be processed; you will have to wait a significant
> amount of time for any new contribution.
> 
> It's not the first time you have been asked to comply with sanity limits.
> Please respect them, I really would not like to be forced to blacklist @iscas.ac.cn.
I see you ignored even the above message. I'll proceed removing
from PW all the patches you posted after my previous message.

I don't assure that the left-over will be processed.

Please do not post any other patch for 2m.

/P

