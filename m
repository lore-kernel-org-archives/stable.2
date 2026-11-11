Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434121;
	b=t/MsTMsZh3SgcvdslOenBIkPVAjov1owo4PZjTvqjA7M2nrM/dzMvMisn8QkuCr14/k6
	 CL7Ug4Ihxt7oj/xC0L8xKu9pMYr8JF0Tx+LymXcHqMPwkXPEWRFArgzSIbMqqOcNX6i74
	 1GbFQ0rWzX3cg1j7IapNOHUD/LjOu77RZA1gSN1C06QGEUF6deXq78aatme6n7SPXsmjD
	 creIRY96PVa0ytAjSmQhmFKsKfap30LMfEEc2h9MLKmwheTjSUXL6IaKCiGoLct+YIWdj
	 18FwlcF/ASGzcsBkza+miUEwzaPrenRTIpBQ89MVHTH3PACKrkoorvVfEg85ZeNgFVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cU9gAyLB+QYQ8kTxCcvTeen8RJ65VvMiekEmsuQV8zg=;
	b=YsLq0hNglnZoiQu8Y+b8NZpJ/tm4LgJm3R5EQ2JS9LACnDhe4nH2M2TeVgmogi8XnctU
	 TacZdGGZ/o+5qCnaMwGrfpJtFsfv5Oqn4djGRxuvyTfjo/D0sDs1lxrK+oZao5lwfz8CC
	 cwIu24TmZtDmO+Vls1IgEMqyYIehvTFP76LyMacbDhTtuONxLY9aKEUyBJZYkEMsxUTD7
	 uNzyXoQ+N5Hr52vjlQnfxlIGyYCeZwmPPtUSGC7NFMBnrJ0bafugsv/34uZLMi6QiHHW2
	 vvQe1VmOZgj7fxGjFnIiA3NYivhMEyfU5gXT0bC7DC1po1YwmMXhGCwKwYQRWhYrIsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRRQRKkb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207660A3814
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRRQRKkb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AAE1F00A06;
	Wed, 11 Nov 2026 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434120;
	bh=cU9gAyLB+QYQ8kTxCcvTeen8RJ65VvMiekEmsuQV8zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRRQRKkb4BOmhEP2KqaX/7a4zCA3WsOc/0gIU6eNp4o4Bxj/4/1SxGR2IKdLqtoCR
	 Kj6bkjH5NeScaZ81N9YAaEsZNareqkh4xZqKkMjEVbO4HKg2AAC2JyQC93/ZrSf2pv
	 1mYB47H3fps/QEmfp/6TBgBE6u7Bmz8y0zHpKZ77H2Axcpq8nquBZDh5gt1E1bMhbz
	 IMBTI2q27COYMs8nGIPhfvffk2CEiUGNhmCVCy9Ck6Q9nS7jcQQgKjKheKtCJ+An5W
	 4GwQmDpmQNwyqmXDy1EY1zeIL1jjVncTo0ELhf/T+Jf7fNJo5mThoTHYYYo/GcLkzw
	 cLR9SOqVvSKgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Siwei Zhang <oss@fourdim.xyz>
Subject: Re: [PATCH 5.10.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
Date: Wed, 11 Nov 2026 16:54:57 -0500
Message-ID: <2026-11-11-1-daily-reply-0024-b3f3824e55d7379b942d@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110191136.1748573-3-oss@fourdim.xyz>
References: <20261110191136.1748573-3-oss@fourdim.xyz>
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

> [PATCH 5.10.y v3 2/3] Bluetooth: L2CAP: Only accept connection responses to outstanding requests
This breaks outgoing AMP channel setup on 5.10. AMP is still present here and
l2cap_send_create_chan_req() never sets CONF_CONNECT_PEND, so the new
l2cap_chan_connect_pending() check drops the Create Channel Response and the
channel hangs in BT_CONNECT. The check comes from a518b9a9ef6e ("Bluetooth:
L2CAP: Only accept connection responses to outstanding requests").

Could you add set_bit(CONF_CONNECT_PEND, &chan->conf_state) in
l2cap_send_create_chan_req() and send a v4? Patches 1/3 and 3/3 look fine.

-- 
Thanks,
Sasha
