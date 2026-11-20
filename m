Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207178;
	b=UHMGW5hMW5P6hhJWBZKYtS4f5OENuhl2ugdWfKH7URymmsnWKD58709zSPQXyCYPqyVT
	 pcDGi4udFMxdIp0+YxziIhPozgxsjYcz3X2jA9FqAdtvvZa2UfCEwN/0zeNiT0WjHTB4S
	 kLSmYypmy0KkBdEYI/rsHbRnGjWPTw8X7iGL6ohQUdwxAAGO41KSUaP2OJ32hZtqvfilv
	 j81voMfA87ASLnMdEiBnymiYJ/FtkOWGD2EX/4JcWtUkaYWSCWANrAHn72MXQeud5N0CF
	 rt0iQnqEbSTMFGSfTtdBaPnqJlcRI8CP748fogaUFSMF0Fjb2HNCBOknGYUO+wz3WsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207178;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZqyrD8ay9pSjtUAlI3QqZfpWvL/B+dN0TiERfhGQl0s=;
	b=gCYiIEsaD8/ktwmCjKMLSLLDLPn0a5qSG7Yu4LdpUw3X2VTRv5y0jW3YlpZZVwvezE7l
	 nG/KgAojL5S+hT8AE1cKDmu9QpFGFBurjtGL02NdKoz0nh52tR5gyW5lwUQ2L5EU/O/ol
	 zDfqlyaXvCYQRJQEzhLLY84a99EuqMvZzQWuY7KI6VU4ZNkQoPZAdXfe8MMrZvBS40NgJ
	 WRMKMEfRIVwfZud5Zvmss85YWewIKFL3JedBw2FWpYCjH2W8nrL/5iAsvAGhYhK0gbdpL
	 i8YeWIwdU1W8B01HWNay/A7xtJSBd6XEf0v0cMusDDd89KNQkMfseUvLlb82OxGWORw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOOfts3q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C579606A6F1
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOOfts3q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040F51F000C0;
	Fri, 20 Nov 2026 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207178;
	bh=ZqyrD8ay9pSjtUAlI3QqZfpWvL/B+dN0TiERfhGQl0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TOOfts3qgJ4kxmabPChUnJ+YpFbJH0lrRF0auUbPmFexPe54SFjUsE+f1u/bSIa8s
	 vsSR7SlB3X1JmPH+6fb0GmTa8oTROSUNDcc64eIbR2kIIEd2krjCj79md95aFBGDuf
	 Br1ANoFcvXu8e6npC2a0Xkd0o0oOXiRdxNKZ01Bu4li7oOB1gfDDkiSmShx/WZ0w3E
	 sHxoatzG20PqzcJngLcr5K2j76DT/XrlQThyUml3jj/IYxycEknovYSSW1Ap7NlW2U
	 PQ1Z7q2cOMk4h9roHtzmK6uMVOhwUhZTHmkHIfsK2bTGVuxDqO0G3st7cNTb1jzzIF
	 6itn3IvGAEsBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	david@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hao Li <hao.li@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 7.3.y] mm/slub: refill prefilled sheaves from the barn
Date: Fri, 20 Nov 2026 15:38:58 -0500
Message-ID: <2026-11-20-1-daily-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120030833.3188636-1-surenb@google.com>
References: <20261120030833.3188636-1-surenb@google.com>
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

> Currently, when the prefill API refills a non-full sheaf, it takes the
> objects from partial slabs and never from the full sheaves in the barn,
> so once the barn's full list becomes saturated, it stays saturated.

Queued for 7.3, thanks.

-- 
Thanks,
Sasha
