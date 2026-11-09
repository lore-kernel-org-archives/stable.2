Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239621;
	b=ye4XUHRuZMrkFFz5CrrMR1N9Q45zq8YYNHZ2LJq4DpCSZUK29ROtXlGbw+qXQmqgKwtQ
	 pQbDg2zFZY0yBmuvrJaR5WebTNoL0Auzp8C9DVKphdd2hlsRgRRNmNMm1xLQonsbrvVg2
	 Khem5ZnVNy/toWh3QKukZwWWbPBdzDT+hD6ZZad2H6HzgINyesIFoC/pl0ug9yThJs7Sg
	 QFRRACKxWgbux3R2zxdBiqPh/XFcB3Drdnpapt//qzTu9258muDUoLplgAOkfbUx0cHL/
	 zevQ5+KYMpOJTK44hCvlPffnWk07Ac/2ktC03QmV0wyLeJDTTvO7mjSrDBndRb0gQdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nECuvqZrB1r+QkHCc2O3dG7lA3qTak8Y1i/J55gqqgk=;
	b=bRwGZgJWdPLO/HC1OE4HBDSV9/M6GKnvEptu4Dh0RuQqXa3qtA0G4mIvGI1dwEf7q4vb
	 gip/kPoZLKHJooapcJZ+8uEqBNbfODmc8GWeyrhmrl5vpU+tnGj8IBrGb7dBsGDKwr7Jn
	 gKpgwKfHWVECpFfV6lDwWZij5zkVl3dTv48FRsrxc0UCeGD4gzUIzvgLqZ+lA1bHOflNh
	 QVGHN0jJHG330RzxdUbFn+N8md7jYQysOoakNE2tmESO8/qIZIIXdaIX2C2ujhTfzuQsi
	 TiLh09LVrU1HoARlJ2p+SToQJiRU/BB01gB/sTwE70u540GQfiEIKavbrnfdR5JguyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi0IgwVh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F76606EE86
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi0IgwVh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1476C1F008A3;
	Mon,  9 Nov 2026 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239621;
	bh=nECuvqZrB1r+QkHCc2O3dG7lA3qTak8Y1i/J55gqqgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zi0IgwVhUoqvUAAj4h6JVOxry/AgtXxecA6pwLcjqgvBbUvfrms5dYm95yN39TEqi
	 I0xEqMl5+5zmoRsLcrvGLu/5tTBQ1vpEvCtca3Q0ZxIexDp7Jv+JFVvMjSBPhOZtp0
	 DG/bqrsGkKMcnnjGrZaAffUsnXy7IADxaGDMbN96FyDY4GOUoDJ/TGKgskML+0ozP1
	 nbNEENeHkqsc2qKC/6iNzasXwywGhECW2Uxgji2A3CrIM8XrL0UTBt4Vq0P+vXy2Sj
	 eQn4nc6DgVsxUejA20YSMB70QT22Fx1m8nzdBsrBW3DfsxRiAEuGffVQ9rQfxUETRz
	 I4xuy4pUEv5PA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@kernel.org,
	Yu Junzhe <junzheyu1@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Subject: Re: [PATCH 6.1.y] jbd2: don't advance j_fc_off before the buffer is recorded
Date: Mon,  9 Nov 2026 10:52:56 -0500
Message-ID: <2026-11-09-1-daily-reply-0014-jbd2-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109-jbd2-fcoff-6-1-y-v1-1-e11d3a042ed9@samsung.com>
References: <20261109-jbd2-fcoff-6-1-y-v1-1-e11d3a042ed9@samsung.com>
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

> jbd2: don't advance j_fc_off before the buffer is recorded

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
