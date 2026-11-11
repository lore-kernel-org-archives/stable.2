Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434108;
	b=sy8FVQ9Syu6IiRhpTfyq/sM2UqZsXTg7CkOFSIYNyauMhzKkTkQL+x5iX3ZA4fD2gxmR
	 4rulnYK0H6hOj80lvEMOVyDW9lP0FNvLyVMWV7e75iGkLIaiRvcnxQ/Iifu/uP1GSytIR
	 0ZJca6xkSZjf635YRoTYMqYzYGlIMF79HKXaf3rl4Am/Lw96Afdg5pH2ff3L9X7+NrIoR
	 VmEOfWt+1VGLKiSqo0xXgWKJggpxs0LbkO2xxVNuFksnaDOxoMywD0EtybE/YuT82lz1s
	 pvaZsotoFoiiUvLnTh/zO8RAZeY5zxfUGmNO0ShbfVK8O+N+NSoJV3zxVy8JQ6pXHtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434108;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iNNTkeUPlZofGTcR4AVLM6WXSL0ltbTteyIwZ+bm5Cg=;
	b=cMV/8cgo2qIQ4GI6SboiAiwKPaZaXZhv5RIYh/F1ei0zkhqYTT0jc/XdrVXx5spdaRnC
	 QJjjShRp7pvhQCNzQjxHWrVdBg4CWHCgeeIvEHo4rlXAzviSJYaXtwY7JH/5M1Rh6ww3/
	 BN7jygcDGZt9h9YEsjsxsIWJ3kn6v+6UGhxTA0v2XCkUBFOeCoVxgv4aHOOdEqOIJOtPN
	 2RJbndqUf49wcCDg17DNV0h77UL6LmMmOxGhg1W63JwRqodRGuT2a7jt2T4H42FDIHoQl
	 wXlldRBaWKV42g6QxLtHxTYSiUvwNiTBTnila5VCAD4SxA3Qwwcdac6HYUpppZNNbMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+rRBwNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11864606A8B1
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+rRBwNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AD91F00A05;
	Wed, 11 Nov 2026 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434107;
	bh=iNNTkeUPlZofGTcR4AVLM6WXSL0ltbTteyIwZ+bm5Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+rRBwNTZPCP3GkczldNb1gp7x8p+J2N1ZhdeYUkY/2kdTtyshwQyH2xgahMTf5qV
	 mjRUvfgQlOH4qSs+Sh00RH4QXGgrdcRIPwc1LplBlCtp1P4qiqEyAmcmu7kNzmELXe
	 YvV1yIHzX7YwcP1h95N/kLWcmIQOXMmk5R4tPw0vcn2O5wrlGqMoZBCJScIogBBTWr
	 NL9Whbj+XEYx90iI3i+FZV9QbusqxhQa+eyTB/Sixw8NA82xmT3QhYv2PjD+6O1Ua1
	 VMvar3NKucj85ieoCNFydKTjeuAVVIN8/bjwVoFARkZ76FGBzBOREr5k/snfZt5Wac
	 biTc1NAnlHuWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.12.y] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Wed, 11 Nov 2026 16:54:41 -0500
Message-ID: <2026-11-11-1-daily-reply-0008-b7bf3299f24cb4de7601@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110190100.108068-1-sven@narfation.org>
References: <20261110190100.108068-1-sven@narfation.org>
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

> [PATCH 6.12.y] batman-adv: tpmeter: fix u32 truncation of reported bytes
Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
