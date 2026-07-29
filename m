Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03A4A2E38
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342969; cv=none; b=Rfc78uxo1kBB83L2pS172e8YrarlFD3d8fvr17WoIljmIwKMUhd7SeiGzviyszxnOdCH2vXd/tXUeVnSdg3VaOq2IzTvxhpPtxRsKCdjtTBx4aEXoy9IMjng0AtP6EnO41W79rTvgINMs++I+dsRsknYnFCC2eIsapWH3G+BBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342969; c=relaxed/simple;
	bh=DJ13anud4U1r31eGIBMYFnO7hrRhdWW2twOZk5YXm3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2Mvkwk8+ODyxRtSRUlUq1bvTP6Vau8BzkfbyovLysC1rz4vfTFPYvVdf1Gu7fgkOWI0g5P3XQahCCJUl0HQRwjORTQmaNXq6m6ucKaI2edQcg+RxHq1HPvVNTZGWyniHyC5cIuflTnMSIpYkMpEHszJnQIc6lmVgPBTFGQ0bMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=jyETZ8ZV; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="jyETZ8ZV"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451e1066971so226654fac.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785342966; x=1785947766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HEvGreoWCE0C5OP7NaUiGhun+8f/YxKdbcUZ0hfLOcU=;
        b=jyETZ8ZVf/TZMLpnKopNy70YLnwnSNAkpHSALdQUucLx0a/ob2jglr+VVSZ3zFOj6Z
         YTazr8lUAi+o0e8Djm0KRZgGFyHuq6pTlYPq0pz4yH717yLhoXgz106hWXy7y1oBQLlA
         j80IV4yOmJJYZPCD2USslbHNnoUu3ZXdmFNN0USnDQFZYTgInqPiwTciU9Sk25zw2lcg
         i6DMWK2obeKrjE3FhMP3LmPyn3Z9Ap5/2XKYamTX7ZzWN7yKI5ft8ly8SkLETqwXUDat
         8KOw9WSx3NzkNJEKaEb/beDxEKG660PKIrhvvx9EENof/8anpCnYKbBI0mdnH0oztmYy
         xO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342966; x=1785947766;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HEvGreoWCE0C5OP7NaUiGhun+8f/YxKdbcUZ0hfLOcU=;
        b=cRd+Affv/RDlYzF7i5HUQZ9cKxexlETOFq8ocPGAaeSMj6NKNo22l84J7HGvBNcCq/
         aue4ATHF0ynuY7X9p4kacMequnBWXcV4fwjPMupvxwqQwSpNk1tieiRZnXPfXGmojHC2
         B3qbwdGDo8iAUdpcWnJu0cu8W9tC6UY+TrzemCrRK0Fel9ph4KVpNN75NYPs7DJ+Njbl
         WHFy3wg4SPH1bjC04uv4bKsbf7iRr8cz9VocGEAgGOkj4b4o6pLr3sTiAfO+pvIxrh+4
         DLOzpoAXk1oueozyOqcNd7DlK+x+yWGJH4JjL20hAWwKeqv/Qe+MDwsg3i0sKNc3usLa
         2AVA==
X-Gm-Message-State: AOJu0YzkCZMc9a7eSh0NsIoAzU5+KhPa7qPwHjOf9WO3wEyd+ZJYehky
	qZ/WFVZalymXiYSxELefhOuiBPiA6UDjWJLDHmejANtmNVaf6HJ2xgarWeqtkFIVIr8=
X-Gm-Gg: AR+sD10Es/1w1W5CmbevPfpQ69nkmFM8syh3I7OQhwREyv0XBXFPbfdkL+YHzhGxXtM
	Viw28bfw8QSlCJDIaEaymLFFhB8A0bAaNLcEpFzn2xGBo/SxbH1G90KylNDvj+9TcTrGzf3rLlv
	SGew0LVNzx71YFzRssYACepd95RXu0KvIaRlKIiPoKANTnY7fe1SBnxbVESrNrbY5E6LkJy3CzB
	MiDCc7kvonueDRXEhhHPXPOfENAe84XLdmYkVnfk1ylodC4qodFGd/DdcbakocOc2TrwHJj4djK
	bAxu9Kh12tTrfkVzbZaGphwz4l4iSOjbEw2gpFu3/g3PBtqmVKRsC6OAut+w/Jy5R1in56nyLLv
	hDyfTJ9T+z/RtH2WbUXTtHiMckL2Lp8D+Rcw8rHmMZm4xm1rAJEezfTOWzL+sqWuBGRSefVF/5H
	Ih0Vf8gZ9eDwD1jrgJOFKNJ6enTKKSjp01yZn17ItJQmUClPmPQRqUA/MTlCkaAZdqt+UK4Gy/Z
	kCLiyOZduMlUDU=
X-Received: by 2002:a05:6808:6807:b0:48a:3f80:ee55 with SMTP id 5614622812f47-4ad5bb46b57mr4642264b6e.26.1785342965957;
        Wed, 29 Jul 2026 09:36:05 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc8631sm2129093b6e.14.2026.07.29.09.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 09:36:05 -0700 (PDT)
Message-ID: <34c09190-027c-4b00-92f4-17b5da059af5@kernel.dk>
Date: Wed, 29 Jul 2026 10:35:51 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <2026072912-manpower-thrift-f2fd@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026072912-manpower-thrift-f2fd@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:50 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x ab05caca123c6d0b41850b7c05b246e4dca4a770
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-manpower-thrift-f2fd@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Seems that's already in 6.12-stable?

-- 
Jens Axboe

