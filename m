Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434110;
	b=hgWZssoi/y2K3LFrgsYQdA6gAS4YuvjVBXANCUyt7H3Cj0U41HzM74dlciBCyV7HkNqO
	 dNXk8u7NHGODciNsK8kLmOUGc+PEZOnwIbTXy/7Vki/EDH/A7xdoNs5sub77AsYwwYQNy
	 gwWRJx2aVKz8NdoMRK37ZTpFUvnEAOxzw3fmwTfE6Zqll5pqoDvnpgtmOJJt4AhyDClvN
	 R3YfNY9xP8lwF44uXOBvL3zFAGPhPoHuhP7oaRmvCN4I7wj1QmJG/rI2cdBhu+E7iZGV1
	 4NYrOesF01tTsctU05T9TOVxC2iIHgywaFwdWCuTZfvuN57HiQiUdreYuh7vZZJzkzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434110;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d8ZA9i7RSnp0HZCEqHbvEviy1ECjVENYnAY39GRUS4s=;
	b=KBpl4fU/w/2DFMP/VUneAO8IxkcLdfss+W9RbiLJUEyCyUbeMBpX3eTEBJ7NbduY7teC
	 IH0DLdoSkGSOcBWNybiCVna10Wp/FobIOM5PbxJ0BZRkbZSVZKm7kplJu34v8+qXI8ulC
	 62hS7rYPWA6mrc6FnpOKNUXtxBflBiJ2/lRmMoxLI7p5pUeBqECUeP3TnEME0n8WJ5QKi
	 ybG3ig2KCKjtm+sqff9qFSjt6B4nE9CAn20wZevnxq5Yxefh1DgYiKssJUBOKA/vF23cD
	 yqoYXfB/IE9rd7sctM8N+YlXvR03idmTX3mCr3h1MPAYb2hYVX0BKpbWtWzDGkv+jrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1TqTX08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58760A6F43
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1TqTX08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFA51F00A08;
	Wed, 11 Nov 2026 21:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434110;
	bh=d8ZA9i7RSnp0HZCEqHbvEviy1ECjVENYnAY39GRUS4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1TqTX0840YqQYeBAcd4Vi3XLhZocvMmAIZKBKILoftytW90d99qime1f6EddqpXr
	 jpvnvW3rv5x+LLsFwXqjSx1Ii8+mrjb5H8E7X+qknQLf5WY1TiKgbXv3G/QkJE6q5a
	 5Cu0qEU6yhYKGUpF9rjNgT02U71KB72QTmaeisXdPz3unpT3o5w0HMUs/FB58LJR7U
	 CEfu8MJ23EYMUt7oSkoeSCxkUQe0SJX9JHtAb5D6mpWwu9zX43N6QrH6eu+MZGjZJf
	 DdHZcyYl9MjeVEHMSutvQKHYrfmYZRq2JBEvnD5VdyBGm+uoMb1uo0nsbzUw9HecQm
	 x13TqnRRjQxwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH 6.12.y v2 1/2] batman-adv: Limit number of aggregated packets directly
Date: Wed, 11 Nov 2026 16:54:44 -0500
Message-ID: <2026-11-11-1-daily-reply-0011-fff8ce5e3b252085290d@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110200026.451472-1-sven@narfation.org>
References: <20261110200026.451472-1-sven@narfation.org>
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

> [PATCH 6.12.y v2 1/2] batman-adv: Limit number of aggregated packets directly
Queued the series for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
