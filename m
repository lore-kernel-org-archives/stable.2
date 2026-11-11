Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434120;
	b=jxeY9U4yYc+UBzfwdp3ZWt2Xg7xOxLfQff0Br1n1Vf1eX32dUKl3COaYof37i2Lklg9i
	 k1V+U2nU30/K+8V5nufZp7LZrAaQ4H9vp92dJhroJi/uaTBIGMORdVDgMrZv7yfQJ9qjE
	 jjajvEHTQbuStzm224Jpter5ndwDkxZhWd4dHLwgdJVQrM5oD5NoROoDKyKkMGJfW3RBc
	 iNp0mnfJ+RPWOyPj3dCBhzs1UfABNEynzT7aVybRESmbd3a1EZfbH155yBrG8yORuaD06
	 iaO9fjmKrlx56a3AL+7IlDiu2VLGLtKZbL9CC0n8tSPwTPqWh2RG2R2NYUitgiiwyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/+a926rOlxLyy81ja0vs5xzocS0BpjSHCEsvJ6HLrbM=;
	b=wo9RO6phMcU0eNT8/rx+9kmYU8gNYgiB+d0Y3C/oyfjxXH8gutv3DXiqBcZhUOtI3mf7
	 +zQlc71ncBb5Ts0i9NdR2wig6CI55NBq9otsuO1mreK1mx7cdySh2iSZEbyzJj8seDHTE
	 X1C2yv56DMP5i4SF7Ev6hTRfLHgAHy2yv2EBRqDkvM0s/hvPzqQP282PIJbY4lObgNmjp
	 JGs7C4HNR6r7hVRcyDcr0qcGaxjW6m8X1IBdU2J2yRLuDrLjV+fUmz0yZOABgbgoNo/lE
	 YeHEGO0GD7AqaIirqbzaNu/HfUmB1DgNrFLOQAFTC3sTXhgJHgc16cSb9MDAQpn4Uuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kShEapJg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DB606A8BC
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kShEapJg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9132A1F00A09;
	Wed, 11 Nov 2026 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434120;
	bh=/+a926rOlxLyy81ja0vs5xzocS0BpjSHCEsvJ6HLrbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kShEapJgTkx3u/ftBf4w/Nc5VNwnn8qtY60gySVT8TpX73B9VgQwSAO/JGdJ2Wczo
	 nHxovQT7GJsr6nd7prppseRVhyWKXKcfBDBjueZ0LTC2yx4Y3FAwXdHgnww76WOpJN
	 /GF+rdbcJkyHo0JIiSteZVHgp9vcsMabna6ugiNhc2dQmz/BIlFbAfha4eV0R9Kff4
	 asB0+9vr/rz3tivfmvOqi/k8Ll/qYiH3sPYcysAihViyKgzcY0pMtD22fanhYb2gBd
	 UbOVsVDsiycKZ3wt5Ah7gv7Qz+4EUEf1yXwufEuVciAm7GVLw+R3H8Gvb9bWW0nhoS
	 Eg1lupqqufX9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Siwei Zhang <oss@fourdim.xyz>
Subject: Re: [PATCH 5.15.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Wed, 11 Nov 2026 16:54:56 -0500
Message-ID: <2026-11-11-1-daily-reply-0023-a0d5fd86605d193ae993@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110191058.1747963-3-oss@fourdim.xyz>
References: <20261110191058.1747963-3-oss@fourdim.xyz>
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

> [PATCH 5.15.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
This breaks outgoing AMP channel setup on 5.15. AMP is still present here and
l2cap_send_create_chan_req() never sets CONF_CONNECT_PEND, so the new
l2cap_chan_connect_pending() check drops the Create Channel Response and the
channel hangs in BT_CONNECT. The check comes from a518b9a9ef6e ("Bluetooth:
L2CAP: Only accept connection responses to outstanding requests").

Could you add set_bit(CONF_CONNECT_PEND, &chan->conf_state) in
l2cap_send_create_chan_req() and send a v4? Patches 1/3 and 3/3 look fine.

-- 
Thanks,
Sasha
