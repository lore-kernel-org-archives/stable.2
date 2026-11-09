Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239611;
	b=Ub/HkyB+1m+tyqwGOtpvbknLGBN5fE64kcm0XuDiQRjPoYMIBxRw1NLw0oJqsGrKbGC5
	 ict6U5tWXF1K2gYNhBkmyRDw0oGgAdP0TAwaH6pO5CE3tNDHaRt8TTaA/nNMVnXNetD5k
	 63WDFYKxM1OqMZ5bK5hzI8KBJGGaET+dW+adIHEq0bRvSkERKKG2jRNNcyJF1LxYH+3Vq
	 0B06rnIB+rbbEDd+zrLeYkYJZ6Gl9Qwzhm67MLQxrZqIvjb4fX2suTWNQ8KuW8Vl7dHb+
	 yAHN0gmC/f7qA6KNl9ikoHCDlcPG7qAKsiruIJ/txhDR2jhlrwP1Pr40tA23qHDgz2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239611;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yJA7BCFhH+RQjLwjIdifscjXMoqOwffmrgW5a0DLcpE=;
	b=btHfAkGttMXk/WNkLOKU6VsasyD5alkRXRBCAUBqZgz4asNA11Rj3vqTGmLeYEAxccRW
	 Cu22fQNjbhOOxx8vWhhCgR69zu1G9lcvrVVh3KVPqMwUiwkyHw5bgozUps0eKRXIYScjz
	 61kvJLhUkW+a85+G5IA9FkTnvPA4PjHAHJ7cJhgECoJxDhnwsMd1UUVG1Q1NNDFU9lDfD
	 AvQGIpqrf3w7/8bz2i73GsEB0oaoG3VbmcQ/O/YWnbSnhHatnCP7qOKHkVnvBHQI5Ckfd
	 Zov7eDhHd2cnR8BaSDKL4KWn86H58wnQegro8Ne4Rl1prW0bVLPS4KyFWCkXKucs5MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NURiGASo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E768F606A334
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NURiGASo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480A41F0089F;
	Mon,  9 Nov 2026 15:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239610;
	bh=yJA7BCFhH+RQjLwjIdifscjXMoqOwffmrgW5a0DLcpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NURiGASoEHuJbGBgiqwJBTGouemRL4Pt3e9KC8XwexUaodeoqfGwsNqHFxG4EMJUy
	 xzyHgzpPm4eLL4fwYbpdYFQnxdklUvY28oZQN8QaEdzIXEhq3MN3TYhfLg/EApD4PX
	 L3DaN3sf26rmBNc9LAkA0nTCvZWQOQP6icscpikBZnBU5bH4wKh2siQaYMskm8yuRa
	 33eqx8mUU6tsbUWBOYbpd9DxbO0dmglXdZyRCU+qFtek0SY4i9PxdJZzqCrdZoDhcw
	 u56d+I1AafzIaTHnAlG2jPuoCgQPPz/kpbqZ18oVGh9xwViwbt6TusKnluIdUSkI+G
	 Ku0cJTmMcQaJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 5.10.y-6.18.y] s390/vmcp: Initialize full session info to zero
Date: Mon,  9 Nov 2026 10:52:46 -0500
Message-ID: <2026-11-09-1-daily-reply-0004-s390-vmcp@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109102946.664117-1-borntraeger@linux.ibm.com>
References: <20261109102946.664117-1-borntraeger@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> s390/vmcp: Initialize full session info to zero

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
