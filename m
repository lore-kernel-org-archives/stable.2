Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515070808
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123225; cv=none; b=eFj+i6ht5qPeRKgShB42qGabZ+LByGwCsKW58D+hUsyD1xyBGj3hroWpks+iIHLz1lDv4d4+AIKeIOKi8bgTBif8a1ouaCZji4xMuA5CUk21rrB57g4hEYEccUKyMETxziLiLBZ5iGKqHyLjdGoUf93jiejiStPao2h8eDt+NNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123225; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5mTTDFtrcYyLq/FvCHlOuGvjc0+DANVvNxo9+UNv6CHsvkKMMhP6V7DsE4GIOOADkpZpmnEFI9yzwK/eK62pJ7zNsb8I/+aj0FWyWNIMhqWLJUVqWm/gyIIWFzKr+x7abQUvNrdLhmcKOK2YsX16nQijLNoOcNhaQauCK7mQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso27002695e9.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 13:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123222; x=1788728022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oJ/FuZF3Q3mIbyfPCG5oph+PhMFMWBPUPISG/AYEazItb6ikKm+l9XSzQFsQlDO36f
         Ib70M01yFqSIGNMlIXZ2THh1jUR9eD/VeNxipLJFPImhPFJgqM/cKpHadNJD+9u1osnJ
         6yMeRQR1lzjwjous45MI4w/fBFC2ATTvpf9qJ+Uq+X2zIMreB0zyNIchC6vCYartuu1u
         0eFmlsRinrtyUDwD9QMtRoCDJCCPIQFr/AvXTWb4LXeM+2vvn4N4rRKCLPMwcV/x5jZw
         Ly2UUSIJDxb9DzD1NY59kWxbHxEhRXG7g/oo/Ca13a5gNKtv0FwlGGIFbic+5aHEtme6
         FSvg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+cggjc0FGjc/sDcDz1JWYb0asW6N2ZurLEu9PyB2aPCt0SaMDNJT1aRm9UqpvnoiZcOCdH8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lQFe7BmHx04EbyrzbxEbANGYnllykCESu5VcVgft1WUfqN3Tvo
	ihA7+bETVQQw+9yaNb+wuiNlv2h1sGNYbTyARJtQ2N/tZqDQp4sMYvZ9
X-Gm-Gg: AR+sD13Im25pd33+NHyBL2I2AstfRDRrg34OXZ5tNX06Hc4gUraiMIQLJJQ5V8CYhpE
	rhBOtYrMzGB3+2smb/qPSJ+ma7Jm25fBwuUpwzdYqvJEVY4vPczEoa0hu/0/GZvHCeRCYDAO4Il
	P8OS32y67vVzDcf0GDq5Ljrr7wCgJNg99Y7BvEZ1ehrsiEdJmY82Fc+TE8avyaLTY2n/LpDW0ww
	vq8pqU8QPLgIvvtAyyWy9JoloYApBmqaUvzsVBK3wv7QiZG8gCLevZWxdwZAl/rjC2SxaCn76rp
	x2l1TGYm5uzfYXfhnUWo7/QSINWcxJwG0bHe8EYpRM3P7A7yVsmkQrYcTKmvZ5MKjwGb4BY/0a9
	N1WcjsHHdjWSObFOuxRWooOg+/s8CS/5bHys6EAphjesf2jGMQqvhZidUkr3qser2TH5tKteh78
	XXE1bicm+cWZ3M9n/Xn8uASotRfIUc/s71B9kQ0/vhA87JlYRHR4/CHM2/JA+DhTAuaT/adV5PB
	C2Bz8vjrxkrR3jvZYgY0A==
X-Received: by 2002:a05:600c:1f8f:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-49b91c44ec6mr295353325e9.11.1788123222310;
        Sun, 30 Aug 2026 13:53:42 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c9cf95sm179357275e9.1.2026.08.30.13.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 13:53:41 -0700 (PDT)
Message-ID: <e502dc95-d309-42d8-a154-6f9d1ef9a8ac@grimberg.me>
Date: Sun, 30 Aug 2026 23:53:40 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown
To: Kazuki Hanai <hnkz.64@gmail.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kch@nvidia.com, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260830131105.680566-1-hnkz.64@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260830131105.680566-1-hnkz.64@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
