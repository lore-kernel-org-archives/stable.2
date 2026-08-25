Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DB3F788A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653391; cv=none; b=p58CftyImbylcj3twauVVZEg2eWROuwtpade8BfER3r71q2mjV53pe+fyAZ0wbfrVkd0LXR9ohinZ7YO/CbTbX8gWT535uC5t68is+mpSy0552YRe3FRrLY3tXhcH2QxVAywq1/a3bykW6lwhugCkPaTveun9BX+6iJqCF13wqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653391; c=relaxed/simple;
	bh=lqMXD3suOr+sitndCEj6l9BWxP7uFteuQLonBXuJZuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPzzexoq+KnjFR6E5pw6ONEXjmi+qFP+5sz/eVtMj6DRzcrCgh/6v3S7syftNROhofpuN78Ibjuknf1arEzvOn/OZcN1merQ640sssAmZJEfPbnL0PXYzgL29wPSwJYPVSE3v65sTru8OCAx4PPKnYyoN9SCecIpRTX/f47sdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Df/oG2tj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Df/oG2tj"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so6393693a12.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787653388; x=1788258188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4FFQMfXNiGpn+c0Ds6FNCWxiddPqnNk/uHSviV3ZIQ=;
        b=Df/oG2tjxtynxlxuivyAAtjvRVH31qMGGeAuXoTG47ewNzfIzWt14mc3N/Z4MpTVqP
         9E2lwuLe9H9xw+fQomqc6GzjvtORRHl55oitVz6UAL4ixQvmVgt+u3JdHglM0WpJ65DJ
         dhZSy7vwvRwihQH5o42oN5PYQo7DGYrp/XuzXSz5uyb6EBd/q+uzQwvUKxgbPreH7Q1S
         SADj7UtJ+rXFcS9IiWAM9JRr1X1ZdTLyk5XE3bOB75TrW6+7g20dZRdhJ6cVmh0bYfHE
         tBvOFnvNAd6Cu5+zrR5QbgzfSaUI83v0Np41maB/z6m1pN9bdjOWjBchPAc6nF6RynF9
         tzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653388; x=1788258188;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4FFQMfXNiGpn+c0Ds6FNCWxiddPqnNk/uHSviV3ZIQ=;
        b=i5eIYNCk4EWyqwztUORSB1mVwWE7qd0oPf2a6hd2W3CYc+/38gWfiK2qg/JEC3wihr
         9RJ0TM8v9xeZA9ULAUcjOktkQUz9XM/nUDsTWj5mUg6gA0IzP2d7WDDR8gj9CgAuXOE3
         DnaIFf1l8hwfyTCd3A+wdGOJZHRJVu0/dIeBkE8vbUm1qCPGQCywPuOs3uddVYnyYCFt
         E4fDak76U+GyNZ+SVYGzxfW11bjbZTYN17jkquqJNu9XO6jQUuEue4EC6VzWE99KeCZF
         FhKK4Rf+CtslqRzaWl1YtsgWfIYLR+qqJhAF4hy4GgfT3dWwPDSIYQCFYaaqmZrzg7rE
         dCww==
X-Forwarded-Encrypted: i=1; AHgh+Ro2QuM7DYH5oX9gHoSq8+kTds4biD0I7wTkyUhQPH1KBR5HZefCHGAb7k3Zi1KpWChvN74gl40=@vger.kernel.org
X-Gm-Message-State: AFuF++mtGiPeTmNwS2kIuymuwrxbwEkz0m/kK4EkeMxra9q/Mq6KGxMW
	XUrqN9zLd600B/WpRo+KaZOIewarL1gt64jGjcQEVKabdvfq8bUqG5F/iFuZooDnsFo=
X-Gm-Gg: AR+sD10uKqhyVR6iz10D8bwFBY7jYPCknvCqF++i3UPIFYaLz0NP+FPdAiEMf61OMQu
	wcp6myuaz1NpQ0swDOFDAvDYcfyTSL3fJOUgS1lT/I63/hclJjj7pdLkLL2FHTYMqjaSckAgOKr
	3/FxHAZW6ghLzwg19AAjdFblJGedlditMsCKXxeDqw68vpv63vRx9Elz7uEtBhvgYSbUH8wh2iz
	764G1QnNu9kv3AptOQCH6GtXJRwTaCoT7XMfqPP3jNBrarY9CuaexzOk7rcXKP8DcRQW4nDPWjW
	3m/g8VI7YnFdIEXKPpvd3BhnzapYPlMoYC1tObnXJm2h7/Mi3VhzlFtzRgOx+9St8OVNzq/GtOT
	oKkwrKRHoRT4jB0KXuWizxzdXGM6RelCqaXk6A5itIhFILa3V8hjQFdPTCqmr4mfsxA6jIyrpYN
	ypGCSqvrQELhiQhI5O5/R5oVlDtTKWIhzM2r0rK4CYgkWnn6fgjkv1lzcWUs1prjqz35UAPDgmv
	NGG5Zb/LI+J8Z9oDEE=
X-Received: by 2002:a17:906:fd81:b0:c21:35d0:f43d with SMTP id a640c23a62f3a-c246a6c52c2mr3630062566b.16.1787653388035;
        Tue, 25 Aug 2026 03:23:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1880346766b.8.2026.08.25.03.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 03:23:07 -0700 (PDT)
Message-ID: <f2d97d29-e380-4d1b-ae21-f5ea406119c9@blackwall.org>
Date: Tue, 25 Aug 2026 13:23:06 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: mcast: don't truncate the port group walk on
 teardown
Content-Language: en-US, bg
To: Jun Yang <littleddfu@gmail.com>
Cc: Jun Yang <junvyyang@tencent.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260812113435.1854275-1-junvyyang@tencent.com>
 <5fddb18f-8ead-4680-ad7d-82123966cfa4@blackwall.org>
 <19b05984-d67c-4c30-aec6-ee8e8be554d9@blackwall.org>
 <20260825101954.3799675-1-junvyyang@tencent.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260825101954.3799675-1-junvyyang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/08/2026 13:19, Jun Yang wrote:
> On 12/08/2026 15:21, Nikolay Aleksandrov wrote:
>>> +	/* use _rcu to preserve the next pointer because it might be in use */
>>> +	hlist_del_init_rcu(&pg->mglist);
>> Just to be clear - I'd expand the comment to include why it is safe to do
>> so and under what conditions (multicast_lock held)
> 
> Thanks Nik, that is much nicer than the restart/checks dance.
> hlist_del_init_rcu() works - the UAF splat is gone (7.2 + KASAN).
> 
> Before I spin anything: would you like me to send a v2 with your suggestion,
> or will you fold it into the open-coded-list cleanup you mentioned? It is a
> UAF with a Fixes/stable tag, so a minimal v2 now may be the easier backport,
> but I am happy to leave it to your series.
> 
> If you do want the v2, here is the expanded comment I would use:
> 
> 	/* Keep ->next (held under multicast_lock, freed later by the GC work):
> 	 * a port->mglist teardown walk may have latched this node as its next,
> 	 * and deleting other groups of the same port must not truncate it.
> 	 */
> 
> Thanks,
> Jun

Please send v2, I don't know when I'll have time to prepare my changes.
The comment sounds good to me.

Thanks!
