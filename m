Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F61530BF70
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837391; cv=none; b=uHwlATO8kyW3icbKslcv8Hsdr+We0hSqivJnJj+9gYlW6JFBb7KOkAG0AdhAZORLWYbybOURGvpSuzTX17RsX5jUUdscDUqcLmozacH8MU1brzogXDHddiF/TIyjsSfxJCR66NdL3U7BcSeli01xlvfCuYbRYpnAITSiuHONo1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837391; c=relaxed/simple;
	bh=kI4MqRXoz9tUKHuNpyi6hMIAkrKO5Y85UDsjot8YWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2pYqCNAMufACDGSXo8S/an8CFwiXPc0K0n1STMhCXHDPkeJKnZo3TmwnjsqPp9VDWcK3yIN2cQAEOCxuYAZ3WmjBaqYElArbl4FlNGcQ8Pofm7Ha7vuajv23dpAYl8HNBUSkr2gQetR5MyzicTF4MMvk/wBaOhQPBFotQNZsLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMqrFQY6; arc=none smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMqrFQY6"
Received: by mail-pz2-f36.google.com with SMTP id d2e1a72fcca58-888e95f3e96so26092b3a.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790837389; x=1791442189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sqjFwTItW9Z6VE94NesB4AWUO0LgcGbOQzM8AGhhbUo=;
        b=wMqrFQY6BqHm0aB/zackbflPmVKYc0xkXt1P2r9Li2gIMw8eBH5xrquh9cSNcMe4+9
         vmy6uindptLRybTLpMaemL8bbQpDVpxmb95vceueLFqQ1hZIltLuPg3vlEWU7J7DjG0I
         8Hnj7asSDfkIHC+hrP0V9yf/FXZOtVV8I1FpTPPwSb/3zXidaKhD2V73xJMFZEx6xmUn
         Qtj7lHw8ZuUy2rogm7nuzHfldqsfCsqJECg7PY/jVmxwvg/70rYYkiEs7F5IlggZhGO0
         01/gm2Jmq7Z7tlhR7h0L7naNBLc2TDS/fzsnKdX5/g3/dYkjczZYgfNe/JPn7QKkWchp
         4vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837389; x=1791442189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqjFwTItW9Z6VE94NesB4AWUO0LgcGbOQzM8AGhhbUo=;
        b=cud/hrxj3KTiD2kv3tSewQx+kgvEztQ6BwH52Z5q/TCZ7IarnAgjL/i322SLQGj8io
         Yp/6r40i99hNgeLm/qov7qnJLzKpRaOhP7dlNMG65k1AsAPHJBXY3xKqiv3VOgUb0EQw
         dXRzbcLmR5VhLHtGOeva3J+f6cnBUEiBbgFlnzIGIO/EJQZpLML2nxdMKJ9Qw31Aq5Kd
         N2QIinkmkV+FcVlJawLTq0S9FbhWPulq9zTFzoARpfm/JqPbrHAwYKUhMjD18pVsu5ke
         psGX6VqSBqYKgyHqQ7Zf21BwWIdXzsM0JNv2djaJ07CGlVYc+4+5GQtECh9rElTuXQZt
         i03w==
X-Forwarded-Encrypted: i=1; AKwUvBy73In8x0HTyzNPFE3+w5/uWotxXm1MvQaRt+bZj3lIHO1pvCzSIpOBPiBKOwbgPq/aWVY1B0Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lioxWydGAUU3Q9Hy8U14JGmen1ydBJUliqm5mrxfgKfgw7S7Zr
	RMESa7hjqa5syy4i2AZY0tivOuYjkOs7z73SD2tKNmu0l9rk4Yed0LkJUXOMB6ObDCk=
X-Gm-Gg: AYBFou21r9zlcIMPT979DbvsPpXce2phRiP9EDIyIwwPWyj+/amzJnbBsgNREEDd/XF
	zP/m5gxgm7W7a2GEXMDP26hrtglPUpinTqF/Sk9H1HBuTDfkguPYnNdU/YV85O0yjkq2h+HDpnZ
	Biw8EgXsfWtf/XRk/VmRGU0VMJ3GN/lUqmwqJg1jGUS6F02G4UIGaGOPOfDBcEFc0dRp5E8aw+F
	t0RhZ3x7DrT6zAvdS3+WBbmc9sLCfpgd9CvtoAdVLbLSAgXwg709ya0Yw1x0Pbjnx8P+OO6Zf87
	S31wypfufrhstXo+lUFlEdkLMMuNYAclRZc6Oy19O0vhQfVxRtKZrGVB+yPmhMkkTstX4B4aMqN
	sYvHhNh0eEdMnFR1FtO9OC1E9SS0gWuFkYs4Lp24PB/QqVqr1jvqTi6UZXUcptQCfNuM2iIoFW0
	5e+/GLWhSgY4Ldgu0k2xlE+/NNz6Ue1sm+RC6p+YbI0KTL3iqSt358tId3JvCxH3qKRY64Upyb
X-Received: by 2002:a05:6a00:aa85:b0:880:6b49:2044 with SMTP id d2e1a72fcca58-8874c8d5a3dmr3078678b3a.38.1790837389439;
        Wed, 30 Sep 2026 23:49:49 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8886b1ccef0sm387165b3a.23.2026.09.30.23.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:49:48 -0700 (PDT)
Date: Thu, 1 Oct 2026 12:19:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Gavin Li <gavin.li@samsara.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Yuho Choi <oss.patchbox@gmail.com>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	linux-i2c@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] Revert "i2c: virtio: Avoid hang by using
 interruptible completion wait"
Message-ID: <ar4CiZZK4igx4Any@vireshk-B250M-D3H>
References: <20260922050251.403857-1-oss.patchbox@gmail.com>
 <20260922011619-mutt-send-email-mst@kernel.org>
 <arWHzKEfy6HKMZr1@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arWHzKEfy6HKMZr1@zenone.zhora.eu>

On 24-09-26, 22:28, Andi Shyti wrote:
> Viresh, can I have a comment from you here, please?

This was discussed earlier as well, can you have a look at this thread too ?

https://lore.kernel.org/all/yaeiwzxxh42y3oxiro5uxaxbvralwqxweb6cx4vzwx4y7nards@cysus3gbvple/

-- 
viresh
