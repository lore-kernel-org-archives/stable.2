Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F54D2ED4
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349576; cv=none; b=CKxugXM0hnuXTTviC2ULwK92O7j5C3Qjg1bJPOTPXjwlhTw3vQgs411fOZgn1GPAXWGJCv+vdq28Vo5pKt46UrXtikD+q602n/up38k/8VrD/PqUiTH1oeT7BvmVBN30UCeqd+RU0Dl/mnoBbYCVRjmZgkccAlNoJ3RR5jNdEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349576; c=relaxed/simple;
	bh=ChiE4nttoZDFdv5u9pt4YHJDW+8IBco14i82JPdmYzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJEtejvT6xZGLi2MLBAU4aW4DqWC2UsMSwU6TiumIFu2mDH/Iw1du0yaotvbB5JaNMhXpX/uZLbZh/mNsoQFCAHa4kIiX2iUdLLMBcwdSn97tXoWvQQLyUAt89jLYXruvsSrsJGS/FftwGQ8EOLv3vz7LSk0moepbjijvDc6uV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=IZu8a82n; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="IZu8a82n"
Received: by mail-oo2-f5.google.com with SMTP id 46e09a7af769-7eb5203bccbso119994a34.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785349571; x=1785954371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JowxVlp25Q46P74or42Yi6cCW45eQe+I1G/RDtY6pDY=;
        b=IZu8a82naka6mY+FAyjK9X/F/Tig2ToT7Dq9nfzigmQ863PPNObkDvCBCEEvLacZYk
         zU7UqrULWB0C2WWsFvmDCf68WWq7l5wi8XK/XKRGgEtS7jX2YgA4Wg6G6pN0hD+TpqI8
         aLR4pjUAe3/En/tQktNC8NNUVzlDMqpJ/ELlL312XrkqEYvI4HGWUZ6iOCvgH8GAtNm/
         x/H+qXxtzEAsuSs28bb+2opyp2acAgEhqtcblg6z4T43tT0oljdWf9UgjKtr/a7CCZgS
         PhHfaqlfcSRyMeqW1BOy4PfCGYVqJv0xLog8pXq20xdgTFTm2eU4+qFBHOasv3y+2+Xr
         G0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349571; x=1785954371;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JowxVlp25Q46P74or42Yi6cCW45eQe+I1G/RDtY6pDY=;
        b=m85g2iZH/CmnF4ODLe/NvDpyM8ASlrtJ05xWmnvo7vEtEsFSJz3oiFll1Hy0Ee7JaW
         yytCbkuF4vToeo9caRXSJwCl8pDWh0jrVjvWsDYjBDW9rG9buwVU0HCYXRzDOdaZeHV8
         tx3fgq5UMZc95sluoAdj1AC84FZggJG/ho9YFHC72RhbJjuQQCHzGnxEbucrDuDJSrBN
         AGG8driDrSOoP1fkuufVQO0tRcGaA8JFMGyS8vgEVtG5gnxqRgf4amz9BWToD1a0myF2
         iVR4VWRpdu6hMxd6qzyHHBLRf2OrilA/BCZC0WLfNjVZJylEPhMCHlQ4+EBbOVMuff0B
         YfGQ==
X-Gm-Message-State: AOJu0Yzi8ZVCXFxyC9yv1jRPysjKA3xk3ajmFHix/IobHdqhIoPKZUXT
	IFxKACqaKzDWL10NwqnTSA/mcPFaauxMmAeftMHoZgXCAuTjN+FAIVzr++ak3eFSLOIL3hnv2wR
	M5VAxnjPlDnY7
X-Gm-Gg: AR+sD12DxuughiQ9/BXQTUjSOoQPYojdWvVeJp29XTF2RELYlTKPBRqDuccJ7KW08wu
	wyOaKRyt6HD8mNTnHdFyqYSKxyFpZi1kZEo4n99edA35f8Zwm4PR9BJ61CKhK0cIam5SzCw+Eay
	XCxw1ZGIiEiVAkchsHP3J+18ghFRmKKCXr0YywkdPnNlefrGH1Ckx5pQeYTSxvR2V+GSEfjDf9w
	tibwQOg2KqxO7MyqKJaWDs4dlySlocvJO1nH1VHMPqvv7eVZQCMFZTNruX1p1F+LIHVdO7lTQ9a
	Cpw6dQ5hIx48NwbEpVmLJmejA6+GIqu3N8UdKGrtIwTWRAffNwB8Oszxj+8UtY5yKb2hMaLF0tB
	+LnNThTtqmDGHBPNYVlnz+sWH9jfM/jI98Qmi7bxHwX2m8VyUf2QltqbnxB0A343y1Emz7uWCfQ
	O6eQpcUcCyX/s9c9mL616m+JrKS3Ug/3fnsWRV5hl7aQPfPTnF1e/jb7C8szIXmtZ1Wu2JqU8+k
	2MGaaW1QR8ysC8=
X-Received: by 2002:a05:6830:81f8:b0:7e9:dc11:5920 with SMTP id 46e09a7af769-7f014227371mr1879657a34.8.1785349570797;
        Wed, 29 Jul 2026 11:26:10 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.129.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d5f3ae0sm2926807a34.8.2026.07.29.11.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 11:26:10 -0700 (PDT)
Message-ID: <e180d1be-854e-476d-8768-2518d503ac0c@kernel.dk>
Date: Wed, 29 Jul 2026 12:23:08 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS
 conversion in read paths" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, yi1tang.yang@gmail.com
Cc: stable@vger.kernel.org
References: <2026072912-barn-caddy-3cea@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026072912-barn-caddy-3cea@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 7:50 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x ab05caca123c6d0b41850b7c05b246e4dca4a770
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-barn-caddy-3cea@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

And here's the actual 6.1-stable one, that should be all 3.

-- 
Jens Axboe

