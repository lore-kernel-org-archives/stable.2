Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1933537FD
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769065; cv=none; b=hIbtPMoOwea+ONuuFKNmYIFgUBR++1zvrvc9gPZd2/8sSitSC77DDoTJXsrJziaScQ+vUPAfrvja3neha/zxa1mwKFN6/oD40NDYQ1UbHN75bZJueQjZ/opzNmPzdUR0KtzHV3DUErbeniG8y1HQ6a+ZeR6WjFINbpRf/Z/iuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769065; c=relaxed/simple;
	bh=jFAWYKmVqe0Mh/SD/Y7hlGGG4XNWYE1a0HpQTiZyN3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5mGVa1fQvsbSJnUiNaHHrvIPPs89ODN5zWmlKLPzD3V5hl7GK3Ersq7FrMqA2kD+p0Pn8cBRpqfS+lJ033NKMviORQ+3L34FTLxllriaNmB3WlCxIyy4dwULy8Qec2BXB7BfNk7eeHbkR4mJ3a8aurwOhvYcLE/7jewkyoSPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DgxSzYmq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DgxSzYmq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so38589675e9.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788769062; x=1789373862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SpoPZ0fcd3JuJClRUUCxQoIFsxpcrKHbj5/qQhfrnoA=;
        b=DgxSzYmq0osm/iHYnNMP1f9/uMVLPaPVWPb20EKfEk/mgFlLBpygD2bf9fTrQOHMkF
         cwXgQWNX0YO47UbEBKy/xvUvPnM3ZUbi3aiD8pAl5xqRaz1wzoKEUminXhP++VTIfiW1
         Ybe+QP0vn/NsvIKYUW1rpw+Y3pFw8OLrh7XWMzKx6+rb2TqR4MWttKTtehZ2P+ftE4cz
         Pd+EAnATvNyd1tTo/GHpwPF1MlodOSYMMxz6X94oZfNwbOvQljXjv/Syfm3lVU/6RgdA
         xXuKD6RgSPnrzypU20PzPQpMh2ZzAh/ETB9ocPeNtiaXvppGgzSzLhdVebhyIiouDcLT
         8VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788769062; x=1789373862;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SpoPZ0fcd3JuJClRUUCxQoIFsxpcrKHbj5/qQhfrnoA=;
        b=IyXaE/T3CIUZooWrcIfUFxVNouDS1plmcClK3VWTaLBa7DuFNKCPkt5E3sV7U2S0FV
         tMBaLqMkSu976xCLDOivDFW68XIaemM4hYG9K7+3KlL2Z6XrP50jr0SGwXz8ix1UkCRU
         0Dt4X4LcOdEB0d7I2SwRNNHgwVEjM1G4wXrwD7hQf5x2xlwu0mQPE1BX/ZBbzrItGVrX
         Klmq7vbMoj3XhwqH/WGl9hsvwuxQuzO8pbu0v9TufQdmr7h7+m9Pq0GN0K31av4so6Jm
         RuYb+0Eh86NvH4qSmNv0GC1Qsr3rDl8qkrzi/uKzZrbXEr2u/LteS0u9KjiuMz/p2e2c
         ps7g==
X-Forwarded-Encrypted: i=1; AKwUvByn9I/lv5qnQayM/k4+MgLKuOWvH6zQh8GglhJtF8XWbA7bcCs5GpQrVG3jK4b81Dr24ePVsmM=@vger.kernel.org
X-Gm-Message-State: AFuF++n8ekudenqPa10Ui8tGuSQU0dercLdEBioPbaaoA4J8i45LklTr
	CJW4w/8UR3PHL26eBzTWOHFmKzMh0M4aMTyQZT+K8FfrRDD2GE0ExcNYKWfKyssYq+g=
X-Gm-Gg: AYBFou1V6PFfgcAvK59YKx9ALJZHFft55VssIQkzc7a2hO3z6I4lRc4wa7gL/7Zl7L2
	89vInxKRCYR3ocfy7PSDPfIhxwXHTZz05fckuJZKCsaz7QEQpP+LldYeFGdsykCb0R6j+g0dDtv
	iGdxs2A3thgdU9P8zHEIMqNwfphiGFk5/I1lEzs/cmSE/LSH+wsmat6DfXDMO7j+CQO6vicWmAy
	lbtoLxW8kwBuPnTgcMfGpuc8x368XNxfRIJhRdeJQ35VR3JjK+TgEdR+BN38kRASqeHMCmwnjG1
	biWehI3voUogG+OhJaLcwqWLQbn3a5zpWdnBswVvyZqz+mRLGAG4F0hkU+2zP6VKHcDW2+pmxMH
	DllWUNWrGca8vWkLdL7xLU1WX8xIxYbp6WsEBgnWAvzWslueGT/UJucMfyXea9iTJwdrDP9eLIR
	bnK8RPVvHF74YJZPAJ2QmtvqKYHLuVAL2MywZ8uT2xd57Kts+pTQiLC46Y+Z7iFEMxF7me7EuPl
	FxtQt689+be0Zmmf2/vzQ8p9+rN/2pF
X-Received: by 2002:a05:600c:34c2:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-49d10d6fdeemr36875255e9.1.1788769062392;
        Mon, 07 Sep 2026 01:17:42 -0700 (PDT)
Received: from ?IPV6:2a02:3033:28e:551d:9975:219f:1622:8b8d? ([2a02:3033:28e:551d:9975:219f:1622:8b8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm802674335e9.0.2026.09.07.01.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 01:17:42 -0700 (PDT)
Message-ID: <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
Date: Mon, 7 Sep 2026 10:17:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
To: Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260907065501.101013-1-johan@kernel.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260907065501.101013-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.09.26 08:55, Johan Hovold wrote:
> The wakeup condition needs to be checked after adding the task to the
> waitqueue and updating the task state to avoid missing a racing modem
> status update or disconnect.

I am sorry, but in this case I have to ask:
Isn't TIOCMIWAIT inherently racy against the hardware?

	Regards
		Oliver

