Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345929;
	b=QAYoPLGcuWm04F4rDm/ujCndlo2Zx+uKKsvGgmB6GkvYjZ44YSC4ktaKDMc7MFafwd8w
	 QYnuYA4YXTplpUMxigTXsYMrD9yoh7tAPtlL9j+JIPLFy2BKw97Tlcblee4yilm1FEWEo
	 9fF11LHRVkHxkcvuMil+BqHh0Fx1Lpp38880D7GIkzWi5EUp3UwlU8Ty7Teax2i8iVg91
	 QlQpIFw1pFgchpPQN1s4fMPmBg2GLTUPdTN9nhkNYKjSu4X5kqzqQN98f9dvv9vsXv073
	 i0++neDnlffhruKzZ0UfiLZrPVuRsH8pstkyAZ3roxqxd1kMdx0NiiTzvJWsAJWSzTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GPeUEpbxZgN6b6poMbqb4po1OzKA7uw1ryiUgB0GJGA=;
	b=upJR74127C/pfNcFoc4asPe6+Ep7l7+cLwO8GjpAK+uJR7aiQmWF/qf33vWM/+BOhIfD
	 cJzc8v6gFE+X2QdP+ZvR0vPg+8USScQ/IbDVLZMfzP4WVO0sVd82i+2kJqR3+S1KBzfLG
	 amj75ctxU9N9EOMRKPhX7pFCZ9OzhFeqNomZAk1awlIz7YCxcGeeHxbnYUxB8w+P0qiAN
	 96v4zQ5wFu2MEtmf2y/bDblBsF/IcLjofTPpDh3IDMFM11ijnOR+lI46fHEWdoZM99ngO
	 ReW8CcKguk0VMG44bBSEP0ujzbkHAv28d97jVEmqJdx80O0Xa72C7H0yrweFzvFcc7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jccq4jcX;
	arc=none smtp.remote-ip=74.125.231.195
Received: from mail-oi2-f3.google.com (mail-oi2-f3.google.com [74.125.231.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB7606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46AB7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jccq4jcX
Received: by mail-oi2-f3.google.com with SMTP id 5614622812f47-4af85d1cb34so265899b6e.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794345928; x=1794950728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GPeUEpbxZgN6b6poMbqb4po1OzKA7uw1ryiUgB0GJGA=;
        b=jccq4jcXeMUlb9kNFMg4bmgySVVsmX5UsetGhRhR+64XWvTXdLN95EixkElbZjvhHE
         W2Mx71diUc+jVyHhbA9OE3M/B0EmdPmaNlknxxSr+hbNZZgxDri4FgRCajHMgOI8ZXZQ
         kRT7PO7iWV4cF6tMLtElZkMM1xZ3LTJ//nT1adfehGSs8hwTfJ80puGlSZnsooPNDDbc
         nnT+zrQElAtdpL8WB6+7BldhmhWm/wZcTtrovggk2cW08mkutPMTKaVC0f0s3a5KgF48
         gQBa8pMdrkpRlxkngfl2OJMoJorjC9OtPiglvccnie7kRLanUD4CDTF3JyFUcFjpgphV
         U4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345928; x=1794950728;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GPeUEpbxZgN6b6poMbqb4po1OzKA7uw1ryiUgB0GJGA=;
        b=0kGK/ruhvnWe2i5NrCglLmWuDGRTb92cGzDi9IRQyuUAIGot7R9qMefKUqGTBtEURE
         t4tsIg3L6si+jqjHyaZSdi6b/G9vxYNlqz2h08u7oqoYHT4GmojIBegE+Dyw4HGxDZgT
         beZxdBIQ0YJVGhwM5q8N21+WidTPKB/pQiyYKh5H0bBRo0+LVs61Chx3NKfIEWR5/6Ub
         poAWHU4q+Ub4XxiYTVTT1X4kqUdxhHuqDbYa+HHKyx7a40TY63Mcs9oVGgl76BP+S03B
         PiP80RqYEgtML/MqHPnUYtDWnlxtnZu3mLri4BBl+fUXRiUourTffLRboVR3oh6FsBwt
         DOtg==
X-Forwarded-Encrypted: i=1; AL+hErGZugyn82cWQhLQTZ6FTOx4Q17uxw/xgPJN/0a4DqHzdX1qHNrou+Zz8PScEwdLbzHlLoocQqc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VR3FBOmcQy11xJbFsfMOddkqy3ipT+VBk4QxGdpRl2BCwOR4U
	GgM9sPONo7uU7F+8IXZMmTsisy7+r5gCEXmvoPnzR9LE7UrWyzz8omFi
X-Gm-Gg: AYBFou1F+eosatuyiv94ESpbycGXeBquX/RvlMOHHFl1D9Lb+JjALrQIgDADVR6queB
	ZmvL1Yjtr3lXVg1nRnSdgSXNJEPyYJ27Z0/NZiJ55o8DHQFSC84xDizMV/pVze47HkGs11X2W3S
	pGBv6AlmiUUnlt2HGRxpIeQJz7yTR793tw2XogYc6uDSchvxX5LD1L6tWRhwlOROEx7WnT+EsdQ
	JYDRwm69Tm0w0Dyd4FHFbjxxd36u39qWfCQ6plxwgmSnWE90nIsYdTLpwTAEhBqXXXO+rAqpLVS
	dvX0Yc4YwlyK0B2eeF7jwEFQIhO0wRJZ3wgshTFrpQXktq3x6jccLEldasqaNcuW0CgsmX6Ia0y
	9NVfe9vllAt0Fkhtav0Y0xB0JLg/QY80IHzDNa7bpiR3SfEgmPZJXGX1Q6iuNlNhcpuja2c38dw
	56eJzdUykEWznZRbgsCFTzVhoKzj0e7O0I79IL1+mAB4kTBLgkTnKMspVnZqz0l0F3l2ljusVOy
	rv09FwPeyZfobY9xPhFpKGB6/U+NJvUlQSIph2NJdRyecHNUPvEV7SaJcdxSipb2eY39tVJdhoV
	pbIejvBekBrJ0FWnAynRIX7Yi5NvJKu5iSfmu0Wi8d0igiZs+tTgB/xAQMEazaO4URk=
X-Received: by 2002:a05:6808:15a5:b0:4b3:3e1:499b with SMTP id 5614622812f47-56b96294badmr126559b6e.6.1794345928215;
        Tue, 10 Nov 2026 13:25:28 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504c276sm3233400b6e.4.2026.11.10.13.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 13:25:26 -0800 (PST)
Message-ID: <01f512c1-84ea-4443-99c5-f6c30242d4bb@gmail.com>
Date: Tue, 10 Nov 2026 15:25:25 -0600
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
Subject: Re: [PATCH v4] pci: Add broken-GPE quirk for some Lenovo Legions with
 Nvidia GPUs
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>
References: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

So sorry all, I accidentally double-sent with b4. Please disregard this 
duplicate.
