Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837433;
	b=svR61QokqzcFTjW6/n8rcDNu23jGfOdKT0VK729RPeMdi2RLW4B0KbnACQ+F6o8VKaXo
	 cDaihPhGfLooWcoZyLYfzGEp+1b0L81Obm6NHSatTb4MPdxoxFgMURKVGI4mds6J30UG7
	 wT6WentmaR6qa70CzfjTK1G0eK6gTd9PZAIL6PJx+Hv8q0KuIefs77cbxUC1LLD5LbDzF
	 YRjvLafI2YUxvoLZbrANS4/O59gZNmD7vaK6Q3CVhjn4moN8qDtKAS39nu+gvF4FlrvK8
	 7X/9KkUtpEW6tkey4MYM0YpG3+X3KiOUmW0mgm+d+PUqD3IXUUANSb9bPaWo/pSI1bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837433;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=QENVAfGaOo7cG1bvZbxpHS9yVMi7DsE5+E5r95kzd9U=;
	b=jt+DmHdEQpbs6zA9IAa3vcJIo/IKLWYrHQpNNP4SbudDU+KVrzN7dvZQzOTYekl3IROR
	 FEUqdsONmZJdSxdolamBckbH4+OTZNQVCV7Jcn4VKAhF5kXVKVCey/UdsmkuLji4fhWJH
	 k7jyUU6mgB8jBlMgl5iDQ+fxk8JkR6WgdPyOo7V9NhXqq162sTuUMb2grpmE/8HWUv11F
	 /9GExcmVeslo0l0RCPDi1hGPMoEGBMupReQ17MQwph9Xi1wf7qY999+RuUS5Ro6erg7Gg
	 2Gq4ltxUCgMc6vSfn91yGIi97t1GhEePohiD39zgKfaBWqCMJOdt4SiYbHmZkjobqaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ml95Tpkh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED33606A323;
	Mon, 16 Nov 2026 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ml95Tpkh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59961F000C4;
	Mon, 16 Nov 2026 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837433;
	bh=QENVAfGaOo7cG1bvZbxpHS9yVMi7DsE5+E5r95kzd9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ml95TpkhccdOdCRgqDBw8B/20phX6V6A1Xts98+iUqCBqyfrGl9bqmmewT7LZDLgB
	 cNg/PJOeL3JnR2R55byH5qrj3ZptnSPxy4JQdqDzVVZg+m6fkBOUAMH9lRK1nALKJV
	 AxJNo2XgUr6Z0vvRUMX8JAQ47s7okiQhWRpQfkynY+ckEa8lCu7C2h20mFBxjsYFKk
	 jH2kXTbqCv0PDJWTovf2UJ2hN+TLAZXxZ641uUdD5lbprL4pDuYASJ3V2dlA5KonvJ
	 eRS5afGshQcH8COdh7BY+pqoHZKyENZ7EraGDoT4FTd0ruLcJYH7pO6KX/rW8Yd8Q2
	 Xgj0IYb/C3U2A==
From: Srinivas Kandagatla <srini@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thierry Escande <thierry.escande@linaro.org>, 
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>, 
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
Message-Id: <179483743046.37272.7082029810163966845.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 13:57:10 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 22 Oct 2026 14:38:46 +0530, Vinayak Katoch wrote:
> This series fixes two races in fastrpc_rpmsg_probe() that can be
> triggered when userspace opens a fastrpc device node concurrently with
> the rpmsg probe sequence.
> 
> fastrpc_device_register() calls misc_register() before the channel
> context is fully initialised. A concurrent open() in that window hits
> kref_get() on a zero refcount, and because fastrpc_cb_devices_create()
> has not yet run sesscount is 0, the error path calls kref_put() on the
> saturated refcount, triggering kfree() of the channel context. A
> subsequent IRQ-path fastrpc_rpmsg_callback() then dereferences the
> freed spinlock, causing a kernel panic. A NULL dereference in the
> fastrpc_device_open() error path when cctx->rpdev is concurrently
> cleared by fastrpc_rpmsg_remove() is also addressed.
> 
> [...]

Applied, thanks!

[1/2] misc: fastrpc: fix NULL rpdev dereference when session alloc fails
      commit: 2b22e3266386190d2027d9f12f317e0662a40711
[2/2] misc: fastrpc: fix init ordering race in rpmsg probe
      commit: 1bf78aac760fd25b684153f8c477aede9b9dd634

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

