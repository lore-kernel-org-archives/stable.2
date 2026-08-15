Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A6286415
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761217; cv=none; b=LdqkbjcWR1JohJOtgALDEJaOMosVUF+7OXiICtIHXOAe7eUUOXzUbFj5PIVeWPMcXTZ3Mol/vL8pAr13lA1s37lsRB9GSyL8Jc6W7FSR775ABBiAU5KysZXza9LnmJMJPGWei0aezwTWRgolrZHIUEhnXi7Rju3O6REUM45xzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761217; c=relaxed/simple;
	bh=FT6NaXpbG/1BGPB0h9NLoCgd1n0Dh4h9zCH7ooapbj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlm1N5TuAs/7VSVAOTSf56fe1qf7sN15rxtJNB9P8oEZuEYy/zrfyyXpvRkQh1KCJvjrfdeb7KZuX7Fk6ihM76D3D9ZwR45TMexO+Cukd9L5Bcv/4RAOKQZOR0/KJ9DDgRkFzczUbjAeKUYmWGk/rr1TV/91Q0NDaahL9+rpXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMwglQKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMwglQKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C7F1F000E9;
	Sat, 15 Aug 2026 02:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761216;
	bh=sNsPyXX1zNJCHuvVndMYNq7SWeXexE2y6AeRkSPirzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BMwglQKZxrX6U7UZ4agTedW5mwGpESsl1zEvAODgqnaKGh/5k3W2PzFkzxYLEP7Ov
	 04aRB0uMeCd+eAuOniUBxPvCG8Z1U853XvYT0fvU5VjFo5z+1GlIR6u3gs2B03Ml+f
	 EMXeE1/TAM13J2q/vOnIk2egQPaBvAxDk+FqWpyIn7bkKAICmG2M+gylrnTpgNn/IH
	 r1QiotU2yQbUHRGeXOMJwYbYPifS/58CDWINiqbjBQCZ7Yy3BWZOTKNCbWijP8H3jT
	 uWiRCVtcTgxrufSD/b5yEhDg6ka+vhhks8qPYCh8vV96Hm/sf48/xaqmOJrIyrfe9X
	 6RSrw3r+36+SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marco Elver <elver@google.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 1/2 5.10.y, 5.15.y] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
Date: Fri, 14 Aug 2026 22:33:10 -0400
Message-ID: <20260814193000.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812234659.3439057-1-tkjos@google.com>
References: <20260812234659.3439057-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
> the connection is torn down while the timer is running or pending,
> chan->conn can be freed, leading to a use-after-free when the timer
> worker attempts to lock conn->lock:

Queued the series for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
