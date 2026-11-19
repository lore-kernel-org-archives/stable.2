Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104516;
	b=RyhlZz1ht7/JjjyilbCf0OTPj5oPhLWqEih3VyqYomqIrSCjGhJjMo/XquaoMHPX8k29
	 En5QGuFafQwGsRckstVvxRpD9gMVz9pXL49pFNqcitN0XX5QiU9aBmWmsJM/9bNELlCyf
	 sN21qkvvkgo6MBzYKS+HOVf4qELaNH6MuOWxdaZaXdsH4TM+ErhgD2e07uYpXT0C0IEFl
	 gnuBjznqu4WHeB1n342M1SIJK1kF7YbKHRVYqwBb+QNlpN1C6EwrfrrsEwiMt6s/uefUc
	 OERJGU0k+SKctnZvbhDC0DwULMlkQWumcoH1A8D0OHwVmgXf+JnbGfguVoQADMuSCzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104516;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UUMbqy+TiISpQgDGl3gDWRmwEP4ubm4k5QKg0vigiAs=;
	b=ziJhlpmxbTueeiKLj+I4IdiGDc9jyYdYIwHHPZXc1VOiQMLWPXh/gEfnzmAiX9dW1siq
	 z7GPfhQSt58M3u8eC1nseKcR5P7Zs3w4/GVOT6TByRgkLOnqi4Qecy4T0OMr8Tsv/sV/R
	 /sw06k6b212oMz8iMz8f6IflKwfqFrl3HCIXHOh+ICCcewu+bDSG3u25clpQOesgy7cAy
	 rFv3wBHlNNhbSHAMuRUJLiIrgFk1xUG1sjXgfg1wamuc5YUnTJiotp2PuqZlexIXCbpGY
	 Pn1f/k3q9mh2HxZbz+JDd0x5G+koqLeVknXMl0lSYof3Jc5v4jogqVlZ5UvXnRNUFHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mnww0mgg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82049606A320;
	Thu, 19 Nov 2026 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mnww0mgg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271731F000C4;
	Thu, 19 Nov 2026 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104516;
	bh=UUMbqy+TiISpQgDGl3gDWRmwEP4ubm4k5QKg0vigiAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mnww0mggEmYPmwCPjcWHPU+nD/5VpbiQ1Lq4SOaAEcdHBvRLX8Vm6ysXTnk7IVZq3
	 kavZ8kfoSZ0i47fJcsiu1okzgwZvOC4eEYTSsHq/oUwQ4bSY9929tXhbyUfQh0x/uw
	 2m+d1+nc6HTnVXtrWhE9YpvO08VSWt0LDHYU9yvtFi98WbXlI9zGZs0YB+Dt1diQuZ
	 lanqX/o3/9LtIWrfOsNqij+QKNayon8zASOnmGy2Hz40hed0tMI5csVuPSZUeZAcRs
	 tD8dBGkDcqi+IXZ1na08KdOkY6RKVpvSmcDIWYgVwHoWvtFpn9DG++HQWN59qjW2wQ
	 aKYd+c2y6pdgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chenchangcheng <chenchangcheng@kylinos.cn>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Naoki Matsumoto <naoki.matt.matsumoto@sony.com>
Subject: Re: [REGRESSION] 5.15.y, 5.10.y: media: uvcvideo: please backport 5b9c75c794ce
Date: Thu, 19 Nov 2026 11:08:04 -0500
Message-ID: <2026-11-19-1-daily-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avxKOmxCBLF+7qdT@jpc00229873>
References: <avxKOmxCBLF+7qdT@jpc00229873>
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

> I use a UVC device of USB3 at v5.15.y. I found the frame rate down with
> the below message after updating stable version.

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
