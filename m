Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7D5A79B
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787444659; cv=none; b=WLCwMgh6fMT/29WSvVPxDx5SARPkOy4/uO17pnVp0vJ0XSdncaLMrQZJD4cy1rOOsnS/SlNp3VWFohzhLPMWkLSxeTPJdNb65s9eVCaMEw1/aE+qWHqIYy9DzGd8ZUUkpbNIzMLoShdHtPQPOZI6BEOYs0c+EFFuov5ZS5mbF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787444659; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEC44lFpOn6zGwlgFYvERnw0qNUDgZuEKdK/P3f53/kinTj/pRHF2H6C5VoCQQD6xapGq8pdU8s8sf7dPUcdlDi4HRzd7R4yoYzZZ6Pie85GJ6vOfr8SAkk5RgT8+n43URTqHVdreg+7BfJ966bcpUn3aVTdlcE57F5+APAgbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so353137566b.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 17:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444656; x=1788049456;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aMfUSaFrW8oUgVpcUu/+C3c8f9Sn9SjzeXR+hFxZnsWGURu7dUF74U2yScL06x0DS/
         3eaYp5XHl301Ta1YsbcNmRh5aqOfimCw/nMwz0TsnrvyqnVNlx6Lth1NDPBHhDOvv8Zf
         Iz4RqP6Vlx3zhOvaGfuhkX2V2bKuzbhEHZtIgsF6UjkgXnqWhM8c4iEMtcjf5es4VYws
         Ex1W68FediQuTafp0GhsHJMPTS+ZL75BG6FA8wY5iGvw5PyFDQxOPC4Y38IKluRAfPje
         25R0fOPKA0milJMmVVA9kIUQYdPfgzXkWtTJneraJnxAUmBV19WNMsknv6ppe/ZGfsVZ
         z1gw==
X-Forwarded-Encrypted: i=1; AHgh+Rpsm9wxWunacvfOupQv12iIFoxl4LyuBOeSou45U8ltfdU4WBa4FO9LET2dN8aTlXwqe30EoKs=@vger.kernel.org
X-Gm-Message-State: AFuF++nqpr2xgUG3at+DVuEW+0XlwMATPMB/2wRUi3YPitBLggfNE/tz
	8MP/RCxXuovzkx55LyrtjZOFlT3eU+/TQ4cvzUB5H4Ws2MhMpiAL4WWL3dE/RA==
X-Gm-Gg: AR+sD10S67tLVkac20W82NjPCjcrWWT9/bkgO5n1M7UytALThFBpBMPPa6HNSvlFt6N
	MAAVeADwkPPXcHXLt6qOGZQRixKwo3FVRJ9k5vJBZub1ZnCP3XXzWKdjeip2kcDe1ybWOOzKnda
	ncoqMfj7Taa99N92/SeqsYMrl1U0i91DzdneHa+Y5axPnCg0TMpNSui2WgW6jGcA56ma8JEEGZ2
	/ebJvNVBCUQg0SHfFcOUt6nD+BcrGfblcP7ETlzrXpYJ/lvekon8YSewkKkxm9/xqeEaNW2nkaZ
	CmUOsRf+pNgNNGdWA+/WX6PzNT9iwgk/IQv3HnsVFzuZR/kUqk4ndtD/oqpvgTppmgV5WQEQZoJ
	dvyKFjVX9ZoeuhPMjjMc229UP5klhqq5dFAIJqi7dQ2JZG3Zs8XyvT/JUuuwQMx1HYIB+32Cko9
	0ydigmn6jTIh461TnhTXXb84uFdMbCQ3/uG3U9C8PZwYai0e/z8wq3ITQAqWRMRX0H30v94YZln
	IgDd3Ima7CZUXYYbuWrQmQ=
X-Received: by 2002:a17:907:60ca:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c24924b79ebmr990876366b.7.1787444656275;
        Sat, 22 Aug 2026 17:24:16 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24968a2e42sm438723466b.59.2026.08.22.17.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:24:15 -0700 (PDT)
Message-ID: <3d1c6882-9ac0-444e-80e6-9d2bbade8d64@grimberg.me>
Date: Sun, 23 Aug 2026 03:24:14 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] fs: configfs: add helper to identify configfs
 paths
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260819155228.84938-2-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

