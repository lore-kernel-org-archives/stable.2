Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443368;
	b=EfdKdxK2iUyAziWGrhwiMehxwzwG5iULPP+eiBgQXiM6ubWgku0k01x7OSZA6GQ0QQqj
	 MiXF4L60+KJVW+1gT4fEtqPv/TCqsTx0V884elFXySwhDhDbH/J5/Q8YA8nWSBfsS2F2K
	 V9BKpwjlf9HBnh6jReRU8vnYCAoaUJuXwvXfainqSX7CepxcWfcvZEJL2VvKYl6EaiXi8
	 i58Gzlu/vEiXPMYwepmJiOQl0/S9d5Ev2AfZovJlAmjyStkYFhUSd7GWr999EyKzVCXAh
	 6j2SbmUEZfX+mTvFc/vLFJ81uzOJhBzTfzflq0GznGjYME7M/7j1wyCD3Xt4Bt+1jyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443368;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EaaX7mjmYrKU11qjZPTJ/yT8+vturI49mzmjSa/B2Fc=;
	b=Lc9oL6s30fDRApjMwxq0BxnBxP1H1peazzESt349z/k5I/RDc6J+2HE3wsz5zDMbKtQP
	 Qjikhf4USkt9lgW9FkSOPZLVIB1/oy0492EdPGCVSfORJM0XXpfvOY9EUfHVwhCsBTTdn
	 iqfMxKu2t7evBXti/4rxMN54IIG+TihiFEzNLLPRq3DiujtntXBDbiO2T2PdDNuZiNuz/
	 mTz7AitlqLNn+OBe3k/rLL1EcD47tmnCrfSndNU+IN96YrMQPaOrZn0LATmKEYtIkTyAW
	 THQsA9C5z2aErS4Xf+jbPp1eaHCkVFx6skU8bdf7gq07Ol23AQRJD0CVXhMtkLjorNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IengG66I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851C606A31D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IengG66I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BC71F000C4;
	Mon, 19 Oct 2026 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443368;
	bh=EaaX7mjmYrKU11qjZPTJ/yT8+vturI49mzmjSa/B2Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IengG66IrO/Wg2bnJFjR+tqqd+VBkPEDYi32ukYBDKqZ36v6Io2sx0Wsh3EQFEQF0
	 GfiE3PxvkpkGMw93/Vop4GPzqTPtexgxK8hLX7k7vEaqEE86COL947cZHRHfciipXQ
	 1syqnlv0e9rb8rlMth6Fh4/qTkthIYk3/C0EPtVCuJc9JYP9//DgAJFTKUIvev5OVK
	 jePYX5UDj5d8s5iekQxRPWyNFOtJrEHlcTQt3ABTyeo9V1uAl9elQeK5pCO83Hnzee
	 zeRHgkeQeoWaYSApd4oUtJDViDqj6ZymWsCZrZ0v9POoNcvgb/SUyEhWDf6ITBKApt
	 GJtSC+B6LMd6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Matteo Croce <technoboy85@gmail.com>,
	Timothy Redaelli <tredaelli@redhat.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Matteo Croce <teknoraver@meta.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: Re: [PATCH 6.12.y] fat: stop reading directory entries past the end-of-directory marker
Date: Mon, 19 Oct 2026 16:55:42 -0400
Message-ID: <2026-10-19-1-daily-reply-0017-fat-eod-patch-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016203333.2963536-1-nb@tipi-net.de>
References: <20261016203333.2963536-1-nb@tipi-net.de>
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

> commit 6a2875517c778ac1111b6920e94cbab91cda8724 upstream.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
