Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443350;
	b=ssk0USOjjs70ZjPBDwD+yJSXXn3iS/ILFXeN5bi/4vebQUxYz/55L/DY0FNpt6gWG3q1
	 wv9MoxuABHAwZ53Eo9vEmHxCcu0x48RS3prHnH3+lGh1JBPsz30lS51+tKgPZRn5s70m5
	 yoREWfzD8P3B6frk6DMTsBTJLRPk3Hxasu7xv4M3EB68HAdBGRw385Y3ogo7q4OH9Tnqq
	 moZkXyQEZ0T9hWqkecPCC3RcqRavaWdYQdBDaxBSO038CEjPPbL1Q5mbXN2xUzW2eUPPy
	 N2/6dP3Iw4mHL8BC6TnkdvZ01Mo/UVphJqpUoV2LkC64+waJXJZkEyGX2odHBb+KSBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rMxdImEr4JU1Ce1Xp+TIMLaP/oLFwxQ3dFnni3rGpH8=;
	b=AwOl+w9Ymn6ebzeis0+Qs5EmQi68/k3O5umY7ka8/UKD9pQWJsitahTmLkzCCBeM9oYU
	 BmaiZFDNdn7xj8NQ0D0fsRXxLuVBM1CU9LkkU17k1HPz5P94Uu0lXXTVCuTH3DHQhgG5E
	 dN1BNBfGd4uHQIAFfs/Z6Qo4y6I2HyoiQLW9TNvRIF30U6maCSZ9SPxtHnyXhvycGaD4/
	 tPiI549WvxlJVB1NohPIWCONawNQi1nObgpjazxSGNcMqBPY0uwzgMQ4NNli2wLjQQKsG
	 M2x+/kUXoWfo9/u7LUPQt0ZxllpGEs/hM1vGERK0PbNgFuhZZxVuSY0KuyXIpE3aYcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mio3yAAR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE47606A31A;
	Mon, 19 Oct 2026 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mio3yAAR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4044B1F000C4;
	Mon, 19 Oct 2026 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443350;
	bh=rMxdImEr4JU1Ce1Xp+TIMLaP/oLFwxQ3dFnni3rGpH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mio3yAARvbSfF93P0br7LSxP4LLYrad5K8r+4AcJzJGrBO94A3JZnsrdYOEtEArmE
	 YIXuqjcceLLTePYZBrSHLVM8+h/7nZ7LzPnQHO59ymE6uDwNEukqCaCKsuMmORRA/w
	 lizgSfjHeKu8lZP43cNfrWwhOR6pox331GXnjrH1R+3hQIKXGTR7IHgNYyxn0enmMp
	 AJmPp3l6PsVyRHmAfXIfBYzyw8GdWSJsFiHRi1IZhjhCo8GeCdP3wjQPeyt4+2eRfa
	 c5cvzryslNN/8RrYpOBs3z4tCcwMHxDEGjRRKsgSxzHJaXdTVfrLpNQnHO3B3iPXsO
	 otMISZ1vln0rA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	axboe@kernel.dk,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y 0/2] CVE-2026-64017: backport fix series
Date: Mon, 19 Oct 2026 16:55:27 -0400
Message-ID: <2026-10-19-1-daily-reply-0001-blk-mq-cached-rq-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016184753.27189-1-artem@trailofbits.com>
References: <20261016184753.27189-1-artem@trailofbits.com>
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

> Please consider this backport series for CVE-2026-64017 to 6.6.y.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
