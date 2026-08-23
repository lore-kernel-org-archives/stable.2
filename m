Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8FE1D9A5F
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787444734; cv=none; b=WlPTwERDObQAw7lV/dZiOIdghzTN+p/nwJRsN42m816IXm302Zh7gY+tr/8P8GynShORT/VPuRmHeuip3Ilx7oxgzyd9X4L9NYsCdNIbVyu+sjUqe1BFyH6KDNbm0bkkKFRipkzO5IYOOlvb+btzvOjYUHPZIAH1XZ1ivIt5lIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787444734; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amIOffRlXPT3sktHyWfOKgSSmiQ6US3UmPNC+bqeC1rLoi+XxrjBeILP0jEkZDNksnINuKSvaBx3bSZHdMVGYOGYNqVorGwmGMOJIi9CQgsvS1r/ey5TglOl4cYhTZo6mOSL07qWvMjCZX8ezlpPpnnl7tf2buva6TltgbZpiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a378f90555so3816591a12.3
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 17:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444732; x=1788049532;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BQVSD91bA8bd6SO15hpwV8bd68C2n6Yr02IuGpxSN0f9wbVzPNN/tD0zKOJKNwjFV0
         ATXo6OivOOe2nntOXBfba8MC3y9f/+uKbx51Ky5uIcK/AIVkF4nFGyj+snBBBe/goGPS
         mpOzv4FIGChYfMlmbymscwVAIdmk/JilfPnLQB9alQ04l7JQB4G5cjDIBspR5d42d4L7
         YumYZvc8FkcnmY4uWYGRRbcKW7ejTa+hYXYKSeLWJ25hOCR99MOVj3ODfP18WngcD5+N
         QeUEW+/kypjbyBpiXgmld4/6CzkIc69dvGZNFRIVbPDyN6lWs2+nXPsqj8BAyTu5ezs0
         PFFg==
X-Forwarded-Encrypted: i=1; AHgh+RprjhheGs/hXJk6MXHco+pJwYUI8OAmSivcESqedNa6w9bG8J+ERXEwGVszbcERFz7KEOJEuP8=@vger.kernel.org
X-Gm-Message-State: AFuF++kv/iCpjcwjFLd0RggYVo9SSIxTIKvX3yXaWX55IMW0LgZRl26l
	a5PBMFqDKJTIbE7YMuNIVg4YCnS5XHqEDjgKCz0JLRcQsZ/gzLDZzZ55X+Weuw==
X-Gm-Gg: AR+sD11QN73GbLri0xQaCLZ4+tK76yser8l16BWZpbMhY3R3ZAKbuqUwhBXUTSZCW0D
	O2wcJw7R0pfjoq4Od65GvyN4rtsmPUaCpHDSzLNgr5WmOyI1/QcbQ7BlKgsT5YrfQviZM8BjYCF
	rOx5iGNb4gLUtxR7fcOuxyaIrT5uIRMMEz6/jTGLSYrdQXCLA3GxQ+1rOOQDd1orBw0yHN/Ifan
	GoaRZIi9w5TQ1+MqXBx/LgcJX4umEzv6wjbyadoYaDGA7ici5bKpfUV4s+9Kw0WLahynXcKLloX
	DxoY7+L22O3Mvh07ZBBmKJWHZTjmjU0Dsr96lqyFuyatilfF0piHMbNLVuKN8TAHrfTPXHzJ2qu
	Z2KfK11nycPYvv7f4rD7sQ2yJQNCUvE2NH9NWPZYkVtbc58FKqse+hMWy1EhTiwE7zIAQpSG14f
	eCF4PaOn8ARPPudbQBoUMNsXjnXZpjH5GJK0Z7eQVSKoe68H0nXTEZc3IikpL8R7eortKTKmN1m
	5zf8HGCkOHAjkokBmb6t00=
X-Received: by 2002:a05:6402:321a:b0:69a:a4cb:2882 with SMTP id 4fb4d7f45d1cf-6a42f216beamr20077425a12.9.1787444731671;
        Sat, 22 Aug 2026 17:25:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199c4asm386394a12.14.2026.08.22.17.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:25:31 -0700 (PDT)
Message-ID: <bd8b4763-c9e2-439a-a6e4-558f963ab311@grimberg.me>
Date: Sun, 23 Aug 2026 03:25:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add missing SRCU grace period in error path
To: Tristan Madani <tristmd@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander <csander@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
References: <20260815001427.3148050-1-tristmd@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260815001427.3148050-1-tristmd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
