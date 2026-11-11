Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434114;
	b=sV1/2QsTkA2pDN0blQtEhIMYwEwt1IA3hND77hBAymyHsFbu6dMOo5ZcuGnZ0nYRnD0l
	 0kfIztRGmz2wqu97sM3OgRgj07Nsn5o9HMBC5BtRdS5eQJQaYaib4JxiCmybOhGJKcHS+
	 KbaWX7JPNhfJ/PoL3QN0wwpRGBukyaIMoTxcI8M/yjTKP89o22LJlOTk2R/e+mqxgsBI8
	 6WITbc07IoNizeZ61s7mlkGWNu4GYYQDOfti65R9+zF8TrnIpGeYt/cmlUrMzkPi83eV5
	 U2sHcgNJ04SBWeRMbwNPcfuCttkVIa/QE4e8Rmg1MG5nDOudW/rkejqTwSqT6CXizqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qwoMi+Re99vLEUXh1HnNVycDJwVDmwKmF03AWM/nlh4=;
	b=vD/USfAXRR1LKY87vEAp/pQugWUYxnSaTQ+Mca0yLMo79T5Ko/RqSuODfmb1UA3V27Md
	 cFViVQCdzmwlZvmOLTGskhNBn1gDb6JXkyKAz4rbdzaF1R13TLcq2Aoco98eEltx1vbrx
	 V2btNvo5eg62ZqkZOvW2rl0OfomzVwPmwHnACDHr1Od3NDmiYvzyyzDzivDQLc4uQ5QNx
	 g/4Njmn3VXpaXSTIF1ciYJ5mUN5VyMvdGNG/1ggvjUac9Bq1FzdHJfRfqlLRA3+l7DF1I
	 fzshKZoSH5uYBwBj4H30v1moYEKH9hPOWn/yzEQDO10ZH+ICtp7tTFy+CcG62LM+cuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k49jmLoe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B8D60A6F5B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k49jmLoe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DC91F00A08;
	Wed, 11 Nov 2026 21:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434114;
	bh=qwoMi+Re99vLEUXh1HnNVycDJwVDmwKmF03AWM/nlh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k49jmLoelBy52w0xQE4/60qrptjPpvB/PMSqBt6D/qQPiA4ijWMDY6DOi1PT8hMeW
	 187HgnOECYi7rA2voRgismJRb9jHYqDlK41TojBc8siqLaMFvG/gYhwatEUp8wTqs0
	 vdvJZB1S87RRhO/BO0qhQBsNG+D4Wm5+g5f1iv0DmzwILQFPCavhd+z0x/dTEKUcO6
	 tjqFEvXe6I8yv84A0gBFgh+Yh4kiuoZKvZGug28DE7Qge90ELbM3T/O5YO+ySid/jz
	 m0DESF1Jv7k9qU5noOkFaWKxGgkGi3BEeRMBBh9OnuUFWYtarWq1q/KXfonqfHKrob
	 6mzqr0UD4rvKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: Re: [PATCH 5.10.y] ALSA: usx2y: Refuse a retried DSP load after a failure
Date: Wed, 11 Nov 2026 16:54:49 -0500
Message-ID: <2026-11-11-1-daily-reply-0016-38eb9c9b89fde91081a4@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111032336.8545-1-25031212351@stu.xidian.edu.cn>
References: <20261111032336.8545-1-25031212351@stu.xidian.edu.cn>
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

> [PATCH 5.10.y] ALSA: usx2y: Refuse a retried DSP load after a failure
Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
