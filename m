Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270811;
	b=EsZOgbqh2UGdHyDGC/dZ4n4U63+dc5PUTRGulxQ4zZc6LWIaozJSWIoET14JfYq4wLOV
	 94AD0YBCWXjK57ZNRCU2LLcAqNYH4sUiIyjwqWJmTn1UoLMUPW54U6or3uPBwNHcL3Qjd
	 s9aiq6C0ZrWh6bjdtU4wNJPhWmTAi4ZxDZw2I/BMITb8IrvIUt1ks3Le+8Vsq0+52kVOW
	 o8hNIcH70wdr8Sjy0IUAlTUoQ7K8L/HlV41X8eGWSCw0xevR3EZt+rmV3qpFuSY/dw0uH
	 /qbuMepXyWrQhzjdQWkcxUkX8yvSQL0LYv7KFJQecD/ckTFhqBahnY7+kZruMgjO6mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=LgGR9HSU/ueCG/BAvwZmTRGTMQyK1xDBde2VmPf4KZp10MulDv+c6IsckYA7ET4+Qlz1
	 Zo3EV4aE3mILtjksLw3Q9PhqlfCjx6g8eeELEyr0FGyFN5H0Ut9AdoQQkuKRFmA0567he
	 LI8BFr1Mr8CLbtNbwVf9T70rNcUBJYypnE2SHHIDIvmkKRQav9gWMHW7SoSX8bwOia7K4
	 iet5RRMi6xJ6Upe6tgiHzqSdRnoKphKLC4/SQR6cTTlsqbjhk147dSTJunZw1PYpo83MN
	 jjVlKct6zTjqOUniz/BCLE1RJfBZIeZopSzQn3NVAcOMJM/XOBOq6TPK7BPGiNkrC/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPP4i9Ry;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A2606A31C;
	Thu, 29 Oct 2026 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPP4i9Ry
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8531F01825;
	Thu, 29 Oct 2026 10:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270810;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DPP4i9RyrK72w1VUYgYCwJbjIgLPc1OTKBfZJBnDQ5VQeC9ejrb9fRnvAAZo74G/R
	 +aSb4YJlhYtEcKLc+3eBMywOXRPnNMQiOrPurTFRZuPYhJqB42MBDhK8NksJ6wV8uB
	 IYNdb//9Qoajdia0wkv8n+WG6Xiye50SDT8nykbXTByON1g5zIviN5p2a5TWp3TKmp
	 NPk11UnfQNCxuts6R/0vc1YbeaDeAUmFbJk4r5NyanegNlENCX5uGDoP0vo2sJ4L9x
	 7DkRm2BrzGOAllOv3HXzuB5euxNuYFWJjCvCcxjFTPpybVeqzAKnCZWLgcC8G0c6pL
	 5LOX46tIcmb8Q==
From: netdev-bot+sinfo@kernel.org
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com,
 jacob.e.keller@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH net v7] net: libwx: fix VF PM suspend/resume flow
Date: Thu, 29 Oct 2026 10:46:49 +0000
Message-ID: <179327080921.3327.2225424222104698292@kernel.org>
In-Reply-To: <20261029104220.77344-1-mengyuanlou@net-swift.com>
References: <20261029104220.77344-1-mengyuanlou@net-swift.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
