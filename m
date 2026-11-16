Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819649;
	b=IyNmqKUW547dGgmndd+HtrVkZMHfTaqX+jWoiJQHDDH4VFPIimoeY/wwqXUobCqB9WG+
	 +MOWROm70KgkuSS80BXxoP+fZNy3glYJrl5LsZrAbTTvtuVdYKjPJgtMWQOABd4hMu/lj
	 WMmBQuGbfLYmWI7Xx8XzgpoKD/8gtDe/9W0E93RiMpOFUsIbgublDUqJ3/t13AuLOpq/R
	 iN7zljPzbf7YQ0XIT1+VuEHJqSMuEVwONmr8hX6KtsdktWAyj10MicbDjVZdJyQODtvK3
	 NV1qhVbSULDqla15aPvnc//0R+tG4aJxhvdYMywz0RRc5ozrQPPXnN7EbpnVjowoiUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819649;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GFRAJqmxoqqfZ2LnvH9nq2xqgAiXmyl21Bgo26KGPns=;
	b=NrL79aAepXhg88qHiSWhuOJbgvl+nfNnxtqJE5ttRVVc1V86ltZ6M1X6kZM62V3hSPmq
	 Zk4RYP7QU7JPu4Yqc0BJttQRu+zMXoSDXIdtsF8o4q0iBgz3jwVU1o+JIEghS9PGT7I4Q
	 Xa3S8JrCndYluM3QQQhKzEBC6oPKYmNtseB9LFBcHiE1X3l2TkFD+qPdUP2BS05UNvM3t
	 mO5eFXt5//nfBXUG6433w9EsGK2EwtfflwcsmecYzMA4z1W7R1TzKHoJGxxQGYZ+eKucg
	 LbJqPZ50gJDijpPWM6bVfl07kH50QVyZopoJwMmJVtZbuAo4OpocbAtXu+AhY3xXkXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L2pdkZXL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oi6w+ERf;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24200606A32F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 09:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24200606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L2pdkZXL;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oi6w+ERf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794819648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFRAJqmxoqqfZ2LnvH9nq2xqgAiXmyl21Bgo26KGPns=;
	b=L2pdkZXLvP7fRk8bA4tcyqZgQ361q9/mKAwwKy7B5Z7pZeOZtNaNrs1y0JCPpzFhWdbYHS
	l0yWT9ymFdejb2iEtT8AmunjvfK1bajuZlTPLXkCA/UkOVEc6rODfaFV6RGKV6AORYA/rO
	Vhx7QEZjcXZwqRi0ihmsRhVoFMDY7dM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-G9Iuk2pmPbCYbKqXJBOoNg-1; Mon, 16 Nov 2026 04:00:46 -0500
X-MC-Unique: G9Iuk2pmPbCYbKqXJBOoNg-1
X-Mimecast-MFC-AGG-ID: G9Iuk2pmPbCYbKqXJBOoNg_1794819646
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b57668479aso3260970a12.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794819646; x=1795424446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFRAJqmxoqqfZ2LnvH9nq2xqgAiXmyl21Bgo26KGPns=;
        b=Oi6w+ERfB+laJGe2RNLsb6yjlE2ZnbYDwGz5pRQ0NUKZ9Og9k3wLDVHK1PgBkepWrK
         LcOvzDRfQxyBrNPHqcd3GYt8EAcBjnRbXK89ZRALaAELCbNt3FX5lEx3ZpPfPTKtzt1j
         GS8n7piT08lS3Fcy4mw/jQ9tkOM/kNtaIaGVsP3r57n/yeFhqWX99nONHoAzsNHg+658
         k6sOyiUwUvFy7u77U8wu2zfUvMmxNdiVBMJq7aIdJsSWBHfpvvx1KEjZrpctGFQfqv6o
         1gqEZH5Ag0lIahsdHsWtsnGBmbhzt8KfdawHA7mGNwRFaROLe//Z3vzfrlsd8DLHlAlK
         F79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794819646; x=1795424446;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFRAJqmxoqqfZ2LnvH9nq2xqgAiXmyl21Bgo26KGPns=;
        b=l9zQYHrATQ7QHxVgywS9tCRh87VEfkv6tRUeX+SVyejw+NO+Ov+TTqpDm83qiXyk26
         mendSf1c5V09sB+JT3P4kzk05XhMFL3r0eGLVY4Omz6aZzn5ZoIginvpoLsncDbk4kkI
         YaqP0yT8QGIs1N4QoH43x9jP/T1TX+8uyFZNAig+Rx29tXvd+jFkGLnBxiyzB5GcCGbp
         Y5S3u8zjnCJtKNuc7jt42AwOE1ZW9/IsNNlQtEICWcXjc6xQJL/MtzwmN8Zi/xZtpBfU
         NufW3PVs1yTed/SbJqwRiuO1iyzhMPB0Tm5u7SWObSJI+3cABnvSNQd8JYFETUfcJr9d
         7tzg==
X-Forwarded-Encrypted: i=1; AL+hErGOyGvIoTSDdlU4VueaMjcNEQGMyg+Kt6LY/YwJJvC/aTqr89Z49q1b5htKCUYUYJWOpm1vBU4=@vger.kernel.org
X-Gm-Message-State: APuU4Z956wFleIH3boP5txOHfjYtnBmfETMAjSroTuvnqrKyf2gBJoSf
	U3bbMpxPfJ6PftvT2+WdUv4llRWD+CZyVYOE/CMK/XA/cuWpK3jcLCIwb3TQG4fAPq94INWAatM
	lzvw2/BavuCrJudX2U0+bpyKqlE7/AAOLpe/H93X/oRJboVgOtWYIcW7O5g==
X-Gm-Gg: AYBFou3uiQ4GkEjezWMLFg/h1AtsHF+v1p2yXywe2wRgr0V0LVMdhCv4yNFwh03VQ3R
	jC3YRh+xnhGYQ2kkDrAapmMYpyOLgT8C2GW2L32yM5+3doY/UK3bwYYMxNdLkLXpPGRVv0OnjfO
	jF6duISe5G5Y90wF755OYgFOXvh8fIPdmOZxLp3kSj5cIACpVmMjFcIym0bnuuPC3LXUNyp6YPT
	Z6W+jub2IDW2+0IXj62SosZzge4lINC0oNnVuUO6JLB1WPieAUy7fc4ALIR1ATEZADfrV6dTToP
	fmdfiahY+eFwkYB3D+JpqcN3Idhum6G9nwv4iSNakOsYa/DXq1VF0OclUvwgTi4LgmiNbxTgGAb
	43N0vy+mMXSLVGkJzB1IujkdoFT1dUairGfEXSWkKCRoHP3MQTBqG4k0vNdkgD0Go51zstg4YFK
	0Ekqxq4s35LbA5F4l25LlmdRXPhAiZ7kU/o/CjWqUtKtQr
X-Received: by 2002:a05:6402:11cd:b0:6b6:fa19:41c1 with SMTP id 4fb4d7f45d1cf-6b7c09580e6mr6633111a12.8.1794819644311;
        Mon, 16 Nov 2026 01:00:44 -0800 (PST)
X-Received: by 2002:a05:6402:11cd:b0:6b6:fa19:41c1 with SMTP id 4fb4d7f45d1cf-6b7c09580e6mr6633087a12.8.1794819643759;
        Mon, 16 Nov 2026 01:00:43 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c262338csm4287688a12.33.2026.11.16.01.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 01:00:39 -0800 (PST)
Message-ID: <4418e4b8-0f86-477d-b9ab-7fe84ceba52e@redhat.com>
Date: Mon, 16 Nov 2026 10:00:37 +0100
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
Subject: Re: [PATCH net v6 0/3] net: wwan: qcom_bam_dmux: fix DMA channel and
 power-control lifetimes
To: Hongyan Xu <getshell@seu.edu.cn>, Stephan Gerhold <stephan@gerhold.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <179474327647.103840.9539614513141118915@seu.edu.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179474327647.103840.9539614513141118915@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 12:47, Hongyan Xu wrote:
> The original report described a TX DMA channel use-after-free during
> runtime power transitions.  This revision splits the work as requested:
> the DMA provider now offers device_synchronize(), the client serializes
> power-control and DMA lifetimes, and removal stops the state publishers
> before tearing the interfaces down.
A few serious process issues here:

You must cc netdev for networking patches, otherwise patches will be lost.

Races in devices tear down do not qualify for stable according to Linus guidance.
They don't qualify even for 'net' material and should go via the 'net-next' tree.

Too much stuff at once: I have ~10 emails from you in 4 different threads landed in
in my inbox at the same moment: keep one or a most 2 threads in-flight at once.

Thanks,

Paolo

