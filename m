Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794934031;
	b=tMRo2INCvQ2aQwHJiwTqTQun9fBtKjWub/PRdFok6Ya1YvLHdKmviLJ+hvosZ6nDfoqK
	 2OqPkwK0dRwh0Zy50jwIyZr6UH5Tmac2PNZUi4t/iuqJ9c1BLehQBio3v/6zjygtd1WTy
	 3gegbB8juLZZkxeOaPHHKeZfYxoll3+NtOkChBSEwSK/ux0xIFa3Aap0h8OCJ7DhBes+k
	 qOy6QJhEymE37YXhIJGUNwf0FaXEARLF72YJ0FoPzmRCeAQpNLKgFRbZYAS/UOZssDHkg
	 0JHf0e1V4hrAcUa0vnnvDH99vb3BANV7i0giSQV+R0Um39r7QzvU4uc8eGvrMyE9DkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jd6+ZfKNXNj4bzpM1N39t1xeNHZL6yxdxFvAuL1XklQ=;
	b=D50uJmqnfqjYnRxMzR/mM0z25tkSmiKeylrfNiT0pwqsnkB5r93m3H1WhQ64nuYzAvbK
	 yxPWdrEeAJTm98UGpf+ip+qegyKcshmZHuSCpPU2pkjarp4Q0edy0OOkM8PN8Clbfmhvc
	 GVZL5VLSlNLgsgtXzodP4jifSfOpXMjx9hH9R4ZJ+0DFsUWKg0FHYIDpqBEcH0w+TD8Bk
	 c9WAzqiL4hvVh4Z4e4GkkDffFf0croUpb6HrgqGcp+hoVrrVBVj27e5mU/NdKUBvqQAK5
	 utsVoQjRGHvxU5G1CWg9u4NtrgBbgQJ7sT0j0KQLYsRPOMN2b+vECvJ9aNkph3XcmiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=ivkn2Tcm;
	arc=fail smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3C606A893
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF3C606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=ivkn2Tcm
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55c48582654so93801cf.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794934030; cv=none;
        d=google.com; s=arc-20260327;
        b=NyoVkGj3mS26EP+Dtri8F/UUyZPAZIeLv01lCInXaZOMNlMMlFuCLvzXW1US5AeJzd
         VeAbu+AgIi1vXpMRVMZv2/vQec8jn1oJpeNs/JKTKvV0qnctinsLjZoDh49lyFRLbjQb
         mNnBepOgvHEGhq42Tzo67wUla6aYAe6z1WDhROEemoHmJAaBTbJyizV6raoISHUvnN8F
         rawMsi+00wR1JlvqiZXJbc+lkmZ6UQ5wRd4ImJ2EVe4pCoHGbZcmw29J4Zq6RFM6uFSz
         Z/YuTVa4ZIsQmGsolBbNubK5OfVzbsSkpK9dupC7cPpqTy9orpwQ9snGON/+Q7Vi9QEz
         +zbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jd6+ZfKNXNj4bzpM1N39t1xeNHZL6yxdxFvAuL1XklQ=;
        fh=+xLXQqRhL958B5PszXtM6lJ0uSEp+PkwItr9vgITOGA=;
        b=T5ykAxlUup908DQNHPDx/58+7//tj/t4L9NWd0Os7QmiXo5xVse3xGRpuYqSjJs/Q6
         n72XQAdgayIIN7o/ubWDcZmOPFbt8Am0Ej2SJ1C4Cb+3u+2/BIW05taM1NwH7ksojaDO
         HO2RpX/4ONqrOvxoD9JJtomzwsFVUMfOKGPPUvGGp0g4nXdrfGOtcfxfGc1bQa/pKaFg
         EOFtYUSQ03TmwafHgiROhy9kTCKrZC0DN3g4oE5FP8Y44UGQHIOXopxfM6wrb42h4cte
         zHTeyKBEbQ93N/imvKZWlgcrjDaPtanfQzziB/1HOq87lLfLYThaIYXn/itF0Nwaeetj
         umww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1794934030; x=1795538830; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jd6+ZfKNXNj4bzpM1N39t1xeNHZL6yxdxFvAuL1XklQ=;
        b=ivkn2Tcm0phLkCKz0qlD1qdYjHEfiiI7DmcQf1gfgzzqFU8tgtZ0s/1PPpbxxRFqnl
         5JfkZ8gM0KTbYDR1UDcx3Xs6JZcu+F47AO5PQoYtjfXiMBtl6fbWPHOc4rsLezSH6JMD
         yCbL+pT0ioAZgnStS2CJ0cqj3YZVmsfSewXMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794934030; x=1795538830;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jd6+ZfKNXNj4bzpM1N39t1xeNHZL6yxdxFvAuL1XklQ=;
        b=h2/fHtCIZLtzVPGnxmXyFLzNuc6KcD/nqeHQhAAdxhos2soKEQhz+dehiQ2EW8pf3J
         Kqi996tiXkbuy0xgFlm9NHdYelw9CyvPH3akhTUdUZ3mYCFdM6CZ91ZNUCA0jqLCm+kz
         vrBhzIJxX+Y2LPan8EAygltPoz340jqz/gCinFiiKi7GErq+sIX7TndGbI8YhIq9wjz/
         h2m3J+oaBaG4/FQYTzOvVSsdPPtK2GK5Zlt1ag7GJKrzFd/tTIoMEW1/ZkW4QTGE1R6D
         aDowLnf4fMGwSaidVpfTZhM3xRAty4SYdYz2TiIS7D0OIFyHf+RKV62SYb5mr5K0ms7C
         nCBg==
X-Forwarded-Encrypted: i=1; AL+hErFM/LKZUEV9Wc/QoLo/h2/ePb+A9jrDnPMMZoC0UpkaM5WA9Bc6zWOTAXda+Wodv3uX+d9EBos=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BARQIAfRRQeRaSDQNHsQ6xZsSr9YAvkp2NT2oKuoX44rCCoho
	WSk09oX8pbbqgEsap6oiB06G2bpUuLutOOvp+6TghPxOBielxvxMhdvjoqeXeV49v9K7Eeh5aSa
	HNI86jFdk8qMe5oZKuO+TBvDmUqlqphhZfxU2xlsMwA==
X-Gm-Gg: AYBFou3YNgXlIz8rD17Ih3n4zHpfEuIEFG4lxQY9aygluvuU0EyYlDMl1dNbwKe27vY
	Ebdh16x3ZGENPrk8ss/5/NpnNHfIWGhWJ8dtHDqztNKQUjN114TJRyEBSD9iOwLvvlhCxju7Sj5
	FMBXHaRFR9TT94+lH2q8x20hXoybeg+JjMo8AFtaM66kcSxy2ultQU7ZmNrIa7SQmQSt0i044ZV
	sP2puEBfvslt+2WzmYWeOr5mL9GucD5i8c/Mx1QqlEeZsQsRO6KDeTErg8kPH6xkxC3MEZhymkA
	c8OL0qBKqksDwuZaUxGfnHHgu+diYDXrQVxAz0vpfNOTgkLonITJnprGE7inHaRCqObJiLERAoa
	GSVZd3+pmrVkEfIFiZTSmTyS6soS+LZ3vOw126NBZTfziZxiN2maBkck5lzxNDIObWPzts9Ba4p
	DL/EoRH8HgTm4=
X-Received: by 2002:a05:622b:c9:20b0:55d:36cb:d2f6 with SMTP id
 d75a77b69052e-55d36cbd522mr82984791cf.8.1794934029641; Tue, 17 Nov 2026
 08:47:09 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017094601.3434882-1-hengyul@cs.unc.edu>
In-Reply-To: <20261017094601.3434882-1-hengyul@cs.unc.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Nov 2026 17:46:57 +0100
X-Gm-Features: AclHuK8wmcKKsdp4Cx0Jb35BfV53xmf2JhwPHldvoPOcuRVA7GxYXeCz_kxkfRg
Message-ID: <CAJfpegtmi=SFYeX5YSq-Lch+FbkP4NszUTnnuwj9Mr9A11=eDg@mail.gmail.com>
Subject: Re: [PATCH] fuse: preserve ENOTCONN after failed initialization and disconnect
To: hengyul@cs.unc.edu
Cc: fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Oct 2026 at 11:46, <hengyul@cs.unc.edu> wrote:

> Record INIT failure in the channel before publishing initialized, and
> check it in fuse_get_req() after waiting for initialization and checking
> for disconnection. This preserves ECONNREFUSED for failed INIT while
> the device remains open, and restores ENOTCONN after disconnection.

Applied with minor tweaks.

Thanks,
Miklos
