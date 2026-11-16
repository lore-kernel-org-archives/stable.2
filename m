Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837436;
	b=LXaJUwwQDKzb3igHBS3FfGWepst+vto3wUg8HXJxI+3q6Irm0cgGULBDtyeE4laTdhnN
	 YCJudgpqu4pp4iDhOulga1pHSdtUSLa7nSAzrjjk9lr8d1MRG/M//OpfL9ukzTrQLBfs2
	 ETM0CKl847WTXcFyGdIRUShvAp/lc+E5AVe6BqB3MlSp/CxR3yTsYpWaakuxCsvx3BDTP
	 54j8qmnZoER1ZnW9XxRXiz8M3WXyRhjmQJ0I9AF92UR/M4n19Gu/MDGQL7u66MkNslxA/
	 dTwocssXN235IhDjghYBClWRqxuw0roe4WaFpRX/PWIRP+FNiHN7CiNXee0+rldA9+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837436;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=VfRZDaWu3mTeK1q7W9hztmEL/1IXE/SN2J1h/Ct3wbM=;
	b=1v+jxevpoNXhycgDlxnvKWAXtL6NRSUTNintlauxSZEnR6gXAUVzI+abct6BK77sRUDZ
	 A4tytFDac3t6cYH8HFa54Gqc8U96ZuWWbKwFlgUXhRbQmqZSEzcrOyZQAXufoULP75VSl
	 D9ys8RsAyVsMAQ6nIJaSzCvk7gH5L0dM5BWmB0dLV2jRL86RoSlsH5OBQ2Jj93t1a9ngF
	 k3HclocBSImtqkoSsJu9YvW272C9nu8F+rWjLfOqxeskG2sIKHB4OQPvzRyjMbrHc1M2B
	 wDcOFvhotXL3fwKlSbBMhpWAp4Aq/ao+j58tSm1sgydTuY7UiHTUang4PUlbfbtWiYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzV4EIZi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E34606A333;
	Mon, 16 Nov 2026 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzV4EIZi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C171E1F000C8;
	Mon, 16 Nov 2026 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837436;
	bh=VfRZDaWu3mTeK1q7W9hztmEL/1IXE/SN2J1h/Ct3wbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VzV4EIZiG19u4MHeJLjqMGDXH5euTIdK/SELkr8O05rPjl/9nusx4QLkVUHaUM5rA
	 kE8jNVOLBIgzLyOKSr3jM8TZevBUvgH/tsq00gO23bxB77ao35zzdZxGI/m1gSKz29
	 utpXu8Smmhvo4yyf0Rfv1g1I5BHpnqVbJAX3yt8F/ODGuXe9Ux6gUON1G+TMy9lYVT
	 wbv+9ThOq9pUwU/N/sdSDw1U9yj77KwUBsBHfAW6IzSiSteQSb4CXIuB12/CnbCgBT
	 fzOLkmeqTnnab91HChXjYToi7Tz/WJMQfbUttRWySpWqGg7PcshDJlSHJPtpH27iTq
	 qTyPXLU/Ken4Q==
From: Srinivas Kandagatla <srini@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thierry Escande <thierry.escande@linaro.org>, 
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>, 
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Tyler Baker <tyler.baker@oss.qualcomm.com>
In-Reply-To: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
References: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
Message-Id: <179483743344.37272.11839722342354246118.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 13:57:13 +0000
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


On Mon, 16 Nov 2026 18:57:29 +0530, Vinayak Katoch wrote:
> This series fixes two races in fastrpc_rpmsg_probe() that can be
> triggered when userspace opens a fastrpc device node concurrently with
> the rpmsg probe sequence.
> 
> fastrpc_device_register() calls misc_register() before the channel
> context is fully initialised. A concurrent open() in that window hits
> kref_get() on a zero refcount, and because of_platform_populate() has
> not yet run, sesscount is 0. The error path then calls kref_put() on the
> saturated refcount, which kfree()s the channel context. A subsequent
> IRQ-path fastrpc_rpmsg_callback() dereferences the freed spinlock,
> causing a kernel panic.
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

