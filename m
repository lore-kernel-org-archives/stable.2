Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511546;
	b=x1OqfpIhDjTLoHen8lKZ3bNAa8ZKtGImXP7e4B/rJ7ly+3Vkaj4/uI2USWq9zNpxywGr
	 mnzg8CNsKQAlbInpBkZzQ76rEeTzt+IJqPw7BNHHuBYo8hT2nJebglJbWNIdPEU3z6CfR
	 Piz5QLBn6dNzXaf+zXHpSNmDgF2VakzNqwPKT2Lmssg9KFn6X86YOCTfsqTvIlvxFRapy
	 93wVTTbo2wNgWulhowRnnxEZRPSq3YT+XuGlwSd/X8qkaWkNRNHotKFNXOznSXSz9iYKI
	 +SxeRsfpMYLzfFUI9pe5niMukgRfwQxRUWoj38s9wdlMsq2xYhZsZv/cb4gAZPwGw2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	bh=n2NrdT5zDS0kkhFDqsqeiTGBX18CerPgmLJitntpUHc=;
	b=SDUh4kHz9wekkGFBaCDEkUFbfnmo6YvNdNNY4d/feLgjDI49ytyzlXddRuVbnxcA8ghh
	 ejbs4PIroXamjI0U+L2MHOUCbWNuHvwE+6Q3HHmrW/6G+qHjdy6G8def7K9okq7D2ya5o
	 QIfdDfE2Z3xDnCA5sR4HB0eCOXFF/SDu2lgWEsOBsEAiBCEjgIj/5BbxUzlMrbf2dQOHG
	 QaTbM6KeWWcFCKjaEVvCNn1QZ7rZIYxitGpwg/eDAFL6UY+p/hCGpRtLrbnxW7TVlCy6y
	 9Xbmu/4vDQYA1hnIUXfGbwl3Mk5D6ov6629u/lx0fBQt1HjnemWIcNd8sAtAI1YQIgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=StASTQzJ;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDBE606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FDBE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=StASTQzJ
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a07b5f2795so145921b3a.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511541; x=1793116341; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2NrdT5zDS0kkhFDqsqeiTGBX18CerPgmLJitntpUHc=;
        b=StASTQzJyZyqKvna+MguyiqN5KFN/a0/4ciSaYm06uXS6Hhmbirt3OdDP9tTlKGo2P
         IrgWPKe5sPL4i7ns2XEYQGPVS7DWRcuDKEEq5DJXvEsazdcvssEJy1mT2xzDeh+H5ygw
         zwV78dfUU2s/1Fahz0p7w/CJr8InHVnxf3S2zYVtlvpI2wt0lpMvqUk25ETNAhWTCDmf
         q05ukX7sldIno4UvYQ0ftxfGjzwZz7TY04S4t/t11gwq60LwhQaDIlcLCPakDnpw5bG2
         92rVNWcoeUV0gUMkQpy9OLlVynMxd7Co0hJBal/cyxorxAFbyGEdBJZ0KVWqlWVJEOG8
         2/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511541; x=1793116341;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n2NrdT5zDS0kkhFDqsqeiTGBX18CerPgmLJitntpUHc=;
        b=g2pYci6ryTMetvvMXXEDxI71fLCvIezrxAQyuvWAMTdJC/6qmM6jnWg+JF6T9NXnd8
         vC3X1qR+/zujSRXY4VGDaiBMhfJXL9Xvs6MqlKD/WIO+pImWTEUikG6WyPB5plRssn6B
         u+G927tz9l6od5FTONDgDsUz9gB8SoPpK1iHQZrbmTKyifh4n/1y4E4moLlTnm7msZ2P
         l5/f4UIZ6OzAh3d6wWU8dvkClUiMHQzNhWSaNPnYo8HiY4hFJRD5js4aIWuBazHR/mMb
         0oUNTshwj3ZEtWJWXZHibxop4o/9EcnHN+xyP92F2OfH8M68Yw2NU6HmgRplh2/zZvBz
         bKzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxASoG6N0e6UVmTKfGSRWKN41bnCgUjpWh0DqD4TAqKqOKcftCC10YYb9uApgyP9E9bJwpJgwU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrwuQA5XfOvFU/3C2KR80pd8hd7Ko887sWb0WmJ8ORfMcwOhBe
	RwtGBkjlHbfvPE7EpoZbOQNNwH2f/ukDvVwgGIrRikRHYYhgHOvE3RB8
X-Gm-Gg: AYBFou09LKUY3pYGD+/nWb7IfGXk6TDJt2PhKoRoMz5TwaIrk/Tdg/3LrAHgmvKn1ND
	ShLNAQ9gP1LTt8uhAturbwGp9BmBMQ4lUu7fEc4VbfsmxNjV0xIjNlIsYFWWZNLm5g8tneb3UEl
	nbmEvXo2ttaFZmpvPJtzVdROfvnj+rOZWXO7+qfj9FOgGFtL+kFl0BHg1Mzx9QM+Ap8kYnuSjPY
	ethUSe5D17ZIf3n5LcdQUlznqZy304RVNFZUPMrW7MxrdFsmcSi5IqAQDzhETo+SgEno6jMp97s
	pBNsxqYyMjBHH5nXE68Ei3KOqkTA/JaoUXWj7aNlcd7xdAxXbwE8qEOS13z9ElsJ4eYPkoiK4bD
	XPbY1x0CVKlRzXjf4V0hK8juBVu2LjvNDEn8YlMsfoLhjTu7O9YCBKDfGKgeMCP+gGvL8+wwWVA
	p1nJtY4pC0cuYpJcje7FI0GmxzQKpItm6ohuY8lO+QGicB3xWRSHKZvlYbtBMYeqUh4aswKHeGU
	e1nmsGUQfbyTNLGCuO7S3YdDA==
X-Received: by 2002:a05:6a00:468a:b0:8a0:8832:7b51 with SMTP id d2e1a72fcca58-8a08832cfb8mr93447b3a.0.1792511540588;
        Tue, 20 Oct 2026 08:52:20 -0700 (PDT)
Received: from [192.168.31.234] ([183.193.19.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a06b4d1a7csm2106541b3a.45.2026.10.20.08.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:52:19 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: "Neronin, Niklas" <niklas.neronin@linux.intel.com>, Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: fix EP0 context leak on virt device allocation failure
Date: Tue, 20 Oct 2026 23:52:13 +0800
Message-ID: <179251153301.11928.2472677014573396901@gmail.com>
In-Reply-To: <e952e037-5be8-49c0-b0fe-bcf1bda77bdc@linux.intel.com>
References: <20261017111114.1135-1-anferneemelokc5@gmail.com> <e952e037-5be8-49c0-b0fe-bcf1bda77bdc@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hi Niklas,

Thanks for the pointer - yes, this is the same issue, so I'll drop my
patch. Thanks for catching it.

Best regards,
Anfernee
