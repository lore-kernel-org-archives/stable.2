Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299427;
	b=HO2bIjNCOPjyOn81/FLW2hR+uyZddm9D5xrJEwf2XxHOkT3MidBzLk03Sh8sQdnDiO5T
	 HLmYnvQ6+zt+fA4d6+pDtHjVV03cmeYqiEIZD9koCiOMvsDNHSsXaAkEtvJrNzCaCoGak
	 Kqm4KZyNiaTzX6c2lbotGTXe4p1sV0w9PEB95JFrWcLL/VLEUuVApFqcgKEpK19tMYlmr
	 O2h5h4iHjsawIyiL1EueHKHiWmadL4KBlBSVYYrviyHOu+WFJF8n1eH/5OeSIQ7ncSzwU
	 lhmI14fLl2xM0UNVst4AytkdJ4+Aao45x/V21s0Vaq1jxOufo1jOjcCMz0znw3cXhUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1gm75zfLnvhGfFKJnN4ctGyUHQ34iNDpJNKslNN8jhk=;
	b=FrM5MqSagSc01jHfvkS3GNcWpyfIxwJJhKtHuigh+x8Ac7yl13ynI3skOuzRcHDnF11Z
	 KGq5B1TpbhT5Zse4tLsaCuZ6FeD3bHl563HPmO0ZDRqCyZW5UJLCkDzRPyrxciHRGPYyg
	 eV0reP6FrMUAgwlh3K8DZ48ObnoR9MOPh/RTmUOE//TcFg332H7TpkeXW3AAGPnxlgSsE
	 XBGQq3qxmT5Hkh9zDuUUqDVQ7DKcx/1nC1tu8biPuJUGT41gUs7L7wljIhP6q+y1A9M1X
	 EzruUyPG6iweDsObrXYIRqltWJJI/9hUNbOw35Ub9ztnfdPmoPslwE/Zgc2qj4JWiuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feSCgdpn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BC606A32A;
	Thu, 29 Oct 2026 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=feSCgdpn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EB61F031E8;
	Thu, 29 Oct 2026 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299426;
	bh=1gm75zfLnvhGfFKJnN4ctGyUHQ34iNDpJNKslNN8jhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=feSCgdpn2OY7H3OU+KhljJF53i4WvcbHZvYSkB7wDb0Q3CqUXpQMPmGf0KroGVvLV
	 YEyYgJCrI1YQqtOD1aZ42Lh5LISEIyheZYqbt5XEP1RRKpBao/H5IetUks1zpUHAaG
	 WCOvf6z8ZGVJjQdeFf9ns641P13EC5i7FCgp/9FEauti0yryA+wV3hQA8GCjnsqeGn
	 b+TNoys9oQIb57qXvmvHVU2t8TmJPese/MRQ9cep+0D9ox1e7Iy35snedBuWnTCOob
	 vX/4dVvCI66NAqNowz7C8x+L3gcy/Y4aacehIQpnbmNwVPwVkRlmTqosA+T5FB6o/A
	 IBcMYlPlxpSWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Yingying Tang <yingying.tang@oss.qualcomm.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavankumar Nandeshwar <pavankumar.nandeshwar@oss.qualcomm.com>,
	Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: Re: [PATCH 7.3.y] wifi: ath12k: Increase RXDMA buffer ring size for default memory profile
Date: Thu, 29 Oct 2026 14:43:18 -0400
Message-ID: <2026-10-29-1-daily-reply-0011-ath12k-rxdma-ring-7-3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029095541.685879-1-shengchao.guo@oss.qualcomm.com>
References: <20261029095541.685879-1-shengchao.guo@oss.qualcomm.com>
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

> commit 15f7603b69a83a0acc7fcc8992ecbea6110f9424 upstream.
> commit 643f0bf936176c114d5631da7547e991b5d99f10 upstream.

Queued the upstream chain for 7.3 as Greg asked, rather than the folded patch,
thanks.

-- 
Thanks,
Sasha
