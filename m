Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633626;
	b=NEUAP2jptQPYZ9bnmc9RzAT9e3P+zh3lsLEU/n1OVFG7Qg05B2SeFyVeCJNva2w64WsQ
	 zfxg5NbaPfTa9oYQ8IZy3VR5oMcr7pTsB61+EFDwgC6zb6MwAAkcHuwV53Y+A+o4AA/o4
	 UBA17e253AVxHWNA6JRymD0pQyixFXhHSI1dzo6hSgFZxIGov8+TOj3ljrb88/QHf3vqh
	 aXqsmYBMADkTFdYNcinO8clY70UP/5lZN/a84kKgyBtwR2kH7Z1MDahKaz4YNoJeoeX2s
	 I+f/6LPLtrZYSTqfI/yXvs2K8a1Wux+XLAK5Lu2F0xqX4YcmqvHLj2qKuU1gwBghNtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3ULwGZVRHjn4Pbmcaih4knIMdgQv5I+filuEnZQMups=;
	b=XycqyfJe/XAZMdbrmzGam3HDuANlcGVE8S6162o5kTvFZjhxpWOGmCd4FCj8+rmf7tJ5
	 b1wG60MTHciA9SrlxP6g0L1h/qnyofiKSl4dodkNjFpaaWTYCZbiC/+Kx8tlcausK2sov
	 GgvC7lpIp+jbSjSK0/jDjW51nGpOrl7ENnUJSupoLJZlRzBiY7eA7qW6LebBuwH+IYV3u
	 eKkWx7C/Y6n1pUqelHbEvuRerJplm6Ybv4JuMiaqmsdP1Fm4ho6nFkrssR3EimQAyPEa7
	 XjFD8QtUXud89iJTB9RTzcv6EITL+q8eIiAH6jYFkMI4L3Q3Vg7Y7aEa9a43AfiASnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nq7CQgVb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F401D609FD9B
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nq7CQgVb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD5B1F00A1A;
	Mon,  2 Nov 2026 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633625;
	bh=3ULwGZVRHjn4Pbmcaih4knIMdgQv5I+filuEnZQMups=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nq7CQgVbJlS/uaF7appaAEEETC/EOhedU9JYnTn9p/yiOC/tJsfsDwL8DEIuGqSp/
	 Nb3pSkjvvggHMcAUcIpnlj2uqjhkp44ngyr7IR8LLjmzELu+qcETB4y3xpdTapvFxq
	 QIshDK2rCFQwpi6z4bJ7N3bpoD1bOjrPohiNanKort0lSBoyzmPY3zecTHt0R9kXlB
	 uvyYtaRF7dL3+wx81H/gvuhsoqPplbrlLbqlBPpshAXTYoxhAPvd1plZ2RGObSqLeG
	 5Zp7L9Jvz4snHmJoFKFmkayW6KnUcKqF4EphT99DelJ0IZBp1fj5/v7Ykkt4h+QvIB
	 XQNqHx79W62wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Qing Luo <luoqing@kylinos.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 6.18.y] sctp: auth: discard auth_chunk when skb_clone fails
Date: Mon,  2 Nov 2026 10:33:30 -0500
Message-ID: <2026-11-02-1-daily-reply-0004-sctp-auth-chunk-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102095202.1516572-1-harshit.m.mogalapalli@oracle.com>
References: <20261102095202.1516572-1-harshit.m.mogalapalli@oracle.com>
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

> Discard the AUTH chunk early via pdiscard when skb_clone() fails,
> so that the receive loop can continue processing remaining chunks
> in the inqueue instead of stalling the entire packet.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
