Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971009;
	b=YP98syzEssTNyKAOThZWFEtKcslQ9cTBftCDE2ghq2pVMzAzDdS63XTFTbQb5OavzejB
	 oviRn6M+R7iI9p3b196egGr1QcJ7I6tjRf0bxI494Vmy8Mw/gcU66TQpN2w5+TqWjxR/Q
	 m70zFIaa9ZkVsa5CY27LTnPBShuDNzd1rUsPA47U4CURp5/CxGDq5qhGgLnKUIUNX2mBO
	 ZjJQcE9KAEMW6m/EKy//PCem1L0fCLG4ZWnOA+Yq6r4sTvSKFCXEoNTobB4xl7aoVYZ/P
	 nqxrakoPFUNhoT/rXZGLMCodKUF1NBmW3KhTLVs2fpA4ZcoG1h7aQUhcN2BpwzVB89g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MlkHn+7oV+3VYLRMpytUTNKZCJLQLbbjowoYmzC9jBw=;
	b=MXYN8UayNyNZ/3mAa6BlcuC4JzGkMBaFkwqxQIEbQd0pZQzhYDgRzRTlICoXowAYaN7I
	 VBGBG8Psnh/rZ4S+RTOCs/kb9E8H6SImbB1kKaHefi4iUqfpggUvLxK+JZz2zX3+V75ZH
	 rdpwZX4CypTlLqwKx4EeHPowNFv5wUUzP2YO/G7gampNNDc86CAtUIPJhv1TB4XFb2gtA
	 T5cv4TshgVoUwnJ6vtwB6tprBxPw15OcpuT7WstQ3vnOe55nm1+DkyuU+I/SdG1umPvWE
	 WwK4RRf4C6TOwajMoRR4l/OLHTGzmwzxO6NqOVEQM5RtGXpPLRG/rYRZfl/6wkPWIjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7wNU7QN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACC606A325;
	Sun, 25 Oct 2026 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7wNU7QN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9216A1F031E1;
	Sun, 25 Oct 2026 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971009;
	bh=MlkHn+7oV+3VYLRMpytUTNKZCJLQLbbjowoYmzC9jBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7wNU7QN5rT9qQhVrZP5A5Klx5WSjTw4cxFU8rzC38BwuiKx4MXTpfra4fliebFVh
	 XJ/SsDeSsy1n54igV1ZnKggsW3hE8x0ghIivI3SmZnr/VVUyNTaxaFyDvChxjis07H
	 t5Oy2JS+WRfCfNTo7OH2HFWHstT00EObaJj1RITtynEaQxfuWI71ym5wovBUeOViLM
	 S4k9rKoBHOLwQl2LFCwtoGg6cefmZG5fa9bggHXNBXPhCTXowBmsAogpuPyxgKMr5n
	 1CTfNcLkdrf2XhpSPhrWkYNC8JHVzLGSEpPhMwdJ/CzN3Ixg1h6SiDXLGLZ1FK/KL0
	 pVq9V+sElm+qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Stanley Jhu <stanleyjhu@google.com>
Subject: Re: [PATCH 6.18.y] block: avoid potential deadlock on zone revalidation failure
Date: Sun, 25 Oct 2026 19:29:55 -0400
Message-ID: <2026-10-25-1-daily-reply-0009-block-zone-revalidate-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025060914.1652636-1-stanleyjhu@google.com>
References: <20261025060914.1652636-1-stanleyjhu@google.com>
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

> commit 3dd63dba8f9cb6990a40af7ed66ee0159f475819 upstream.
>
> If revalidating the zones of a zoned block device with
> blk_revalidate_disk_zones() fails during a SCSI disk rescan, the following
> lockdep splat is thrown:

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
