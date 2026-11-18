Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016450;
	b=XGSqOv6NNvKaBcoVFVs5RvdMhHicluRvV4Qn8WOZCQJ9Q25RCI0XpcX0xLo0UXg6fgXr
	 E48twnN0nYy3NkOzQlTKlMDSAjY3EF61V+TGKxeKav+bvFYq2tmKEtyjuDUFqLQrKguFS
	 A3xjlPFmNZ/UcwYDjH+/7PJ/+2vFic1KMD0ifjv5F7Hsy8VhuyOZY4FPw1IvbWrlldLB3
	 Rbwd/l6fpKfYgjWP+Z1Z6j3Som+gwRU+dgHBynWbLr/boabT9TNrHAuKpo60S3T6xEmxG
	 k56BlQuR7pGA2LI3TFIvbTZJaWrmRv19AHjaPSkcOEvYdkwy82zoHgodFs7aEQFkZLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tm6dB1EUYOThFG6qE8KMMgbho+/lR/6Gk/9spMdJzlU=;
	b=V4E/0Y3jYF0ks29CCD2zdN8LKvY/W/fUo+fsgeU3ACj7FcvJ5OPZIjRsGdUIkJ3OxhvL
	 GiWxqCi6EBdmuM9PtykDKaI59qoAlMLZqQKwnjyz7n4751iRXrPrJgWi7WuzCYRgopBOa
	 Y/cTeglSvaCpOD2wef/7hbDBkUsA5ru6eAKjkH/R8EwageM8fsvoLbXE7vjZ885xqhphu
	 EtRpMENaKM/NqulSbd9Ah2swMmPGpwcECCd2/0QueejeGn6BfI1OP25/7kAKNh/PxBmlt
	 4tHNXS0tTzq1L9v/tGkX93Vze7+UdvYy9Vo5bvhukfW7wEiyzNKQvF3tR7ULPf4dGig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="F/T+wXSc";
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2B606A334
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0C2B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F/T+wXSc
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b4c8b51b58so778453b3a.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795016449; x=1795621249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tm6dB1EUYOThFG6qE8KMMgbho+/lR/6Gk/9spMdJzlU=;
        b=F/T+wXScP9Zgh1uofVaMqzOlFgqfmKgwCctq1qXcplNMa+wjBVSQAc7SSMeRLdzPB0
         aZ1GrJrH5iye0o4/LLMI2fA25rH7UfxV1ehkUE7OC99in1a0QZS4q4fUT1mZWt1NMlya
         gIwScpx9+n0G70Q0jOcfxLy+AeOQGv591C0uGFyEAHz9ZnLD0ZPavJuDzCS5ZaYKLAvn
         6pxQ0tEw9NUG7Dmh4UdLTFYgD1RdG/Yy3r4oDl+vYou7NUVAtvVOSdOwQBIm1lDnzDne
         iwJ1y8JgjfqQy1FPn6+euDTe3FiV8I9E4eClxfNeRAuzzroJEQOGh0/mIeVlCC2JDxXj
         qTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016449; x=1795621249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tm6dB1EUYOThFG6qE8KMMgbho+/lR/6Gk/9spMdJzlU=;
        b=ElZqh8Ie1c61VN7VEgkN/tohSNMLLy54IlETty6Mzfl9tuoAYIEaE7dOnCVvBm7DBJ
         P1RmWBcZZry2I+SIfFCx/Gd8eE9+l4j2mbh0SZRQ2T6QAGmV3DDy1V8l8h2Te4vx/Lyx
         7lBTXwJh7s2AdxPNryrzXVUHi/QIS6ZqbQD46rxKYHk9Eq4rtpESzcQRMU70IFiBIqTd
         9UIjoKlTKfUg4U2/M337RaXDfz/7fIYP0w9YVNQI5t+yTYztm4I1yVsvltvUkq7f6mm0
         8Srw+gpwCeAUpYlnwEtWgj33XAWxWzRqVkvLwrpsGP1115/sr+Y4e0vNvJcYwYh1u6ck
         oEvA==
X-Forwarded-Encrypted: i=1; AL+hErENV89D2Anr3n7IGNoIz9Oy8IY4Bn1qppBwfToIeb603y2SVOC9jgXHp3L4AgdtsK8X/rRz0rI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qWiT9SHvIdIw4GlcPp3csnuJ1SafoZRtYZ3oIL5JNzUj2UpbW
	23mTq96tpb8S2aBEGGtBoHeQ9DCJHYSZe+yzkQfUT8laodL0YsWt/CVJPok2eA==
X-Gm-Gg: AYBFou0UVVnN84JpWcP0V+sAX3n9uAIZHv9XWhm9g6j5q6lwFrdM4BE+yW6cAbeFUlr
	30i3yHuYvyYZVzQssuRpZVX6RlAK/MzHBXTed0vjrzssvgwBz9hOtfU96vulFUr4PZpLDKa/B8O
	SqKZ8LbvV3yDh6D3861XbzT8EIqOuv9WjsJxEUkaLzEKDJCMn2ooPee2yIEigdPhpda0dlSe6Sx
	B5a7Bec1FimzMdI8NMNMXxxqrc+o13FVBnAKBUAtckCNiVGmpClsq444c1XKJ6hqeJpSAZRlr0j
	7GpRokRjRJqSgf/T3fcWWJtVel4AUXloVl20BPOGhxZ+bVypvl9xzvBZL9AHM4EtuCxyhGy1Ae4
	o6mcxhUo1ZDUL6eXFvYRQQTw6xG3PJ5Ar6tgInbHTCrDuboji1ce7GRlzIBDpxUPBramz/ZA8XQ
	5q0oBRN7wczuVGlfDJKNxRgUhrft0AuwESvndiiRYFSF+X9I4eMUFGM+eib0cmYnKhBJt/wBWPP
	17F1KV3JBWZCVKRimuCy297l3TqzUiR1hO1Z/1hyiW0OIfH9u4OhDmxnvyGc7XSexzSZo2ZOJf4
	qDH2VhIZDsJ+2qRVNZGFhCm+eZGQQQaelPRklBd9lZPU5xge
X-Received: by 2002:a05:6a00:a244:b0:892:e080:4ed8 with SMTP id d2e1a72fcca58-8c5d48d82b8mr2645070b3a.47.1795016449055;
        Wed, 18 Nov 2026 07:40:49 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca5bf959sm1421203b3a.20.2026.11.18.07.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:40:48 -0800 (PST)
Date: Wed, 18 Nov 2026 23:40:41 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 4/8] gpiolib: cdev: don't sleep in the SRCU read
 section in read()
Message-ID: <20261118154041.GB46152@rigel>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
 <20261116-gpiolib-chip-removal-v6-4-aambrozewicz@nvidia.com>
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
Content-Disposition: inline
In-Reply-To: <20261116-gpiolib-chip-removal-v6-4-aambrozewicz@nvidia.com>

On Mon, Nov 16, 2026 at 03:47:07PM +0200, Adrian Ambrozewicz wrote:
> linereq_read(), lineevent_read() and lineinfo_watch_read() stay in the
> gdev->srcu read section while they sleep waiting for an event, so
> gpiochip_remove() blocks in synchronize_srcu() until an event arrives
> or the reader is signalled. The device lock is held meanwhile, which
> also blocks device_shutdown():
> 
>   task:init state:D stack:0 pid:1 tgid:1 ppid:0
>   Call Trace:
>    __synchronize_srcu
>    gpiochip_remove
>    devres_release_all
>    device_release_driver_internal
>    platform_device_unregister
>    gpio_sim_device_deactivate
> 
> Check the chip in a scoped SRCU section only; nothing after the check
> dereferences it. End the wait once the chip is gone, and return -ENODEV
> if there is no event to report.
> 
> Reproduced with gpio-sim: setting "live" to 0 hangs while a reader is
> blocked in read() on a line request; with this change, the write
> returns at once and read() fails with -ENODEV.
> 

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
