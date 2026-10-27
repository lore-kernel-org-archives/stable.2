Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095368;
	b=v8PG2CrPRiwYdLJB24V+VawTshoD2p1OojGGIc3zoAwdUv6eBHsDT8aQYPRkMlNgXlwk
	 HJZ6sBwkopXQZOSeKAPn6kvg95TQWF/e5/vzzGwHMuayeEskgFt1cznIT+EadYabeTf58
	 hQULNAROVg36UwxuaYGhmN+5+eEtGx9twlbRKNd5fl7nmgfWkiKBVlCG+ZR/Icy7S65rC
	 OLLwvUNXV10DW/wqdQgBPlyMnzcAOAc39qLyO/Gavs5jZjCuZ4vmPS6J8eNd98nPbbZSS
	 bCs9yXIbE57n1zpvLFj2owB64h4rJs9BUA210pnLhEdF7FJuBLjVu0LVk0orsvQO5+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095368;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Z3PM0awfNAnG6AsGb8/mcp/mnb12cMk3hPSehrp3igU=;
	b=oEgRQbhqETNJ3D17nSGlGlg3pYxou7ofUU2Qwc266Z0LyiUabhGncfEOrndIpjzJxbv0
	 eGrqx+DmY6WQWKmObsAScVLovuZYv9lhzUneOxOuSTackzLeyKaO6jYBqQyy+xzF3UquA
	 JF0lRNNwaIZl3KDM6WjEylLUx56RSiqdUUakO5QnL7goUsSDMWIeCmxhSydynOVFGw87O
	 ZcKCdjutHxsr25Q+A7Tj/zXYkQHEkP4baBdMGkSav95QFANU16bCg5lNtUEi5agUF78/4
	 QBoxJtIH2jwtP7zAmRHD6aLldY6srwMxx5JJGab9fHylMi001BcDB4W0g7/ZraJRKdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WnzEF/Qk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C6606A31B;
	Tue, 27 Oct 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnzEF/Qk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C0F1F031E1;
	Tue, 27 Oct 2026 10:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793095368;
	bh=Z3PM0awfNAnG6AsGb8/mcp/mnb12cMk3hPSehrp3igU=;
	h=From:To:Cc:Subject:Date;
	b=WnzEF/QkE8ycIL8pYSotdfPsXWvOlN5fgD23aYj7wouhUPzt+o5xHtMjV9VOYmFCc
	 fj5wDEBigyz/whiGgp8N7N3cwm1D2QwuylT+VN4aJ7gB1MunQrhjaqD0S/k5Oo8Ax+
	 /unWaBFZhL6u0/fqS5OA3II+1aeGwAQQHuuB+vnbbs2qyYYy+hu+/vyhAJZc84SQpF
	 CTJr9Xh2U8FiP/gc59P1uHK+XykxOdsU62xcEuNhZdssb/ZDt3ceNLJTPiTlsqIaPk
	 QzIenVWwp+UmYM8imffWi7obj0K2x9pWEC7TwySBy5XMb/ztlXLTXM0axKGv1+Iltj
	 JWZHpuy0/yMUg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Marco Elver <elver@google.com>,
	Maxim Krasnyansky <maxk@qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pauli Virtanen <pav@iki.fi>,
	Sasha Levin <sashal@kernel.org>
Subject: [STABLE v6.1-v5.10 0/2] Bluetooth: L2CAP: Follow-up fixes for b66774b48dd9 (v6.1-v5.10)
Date: Tue, 27 Oct 2026 10:02:38 +0000
Message-ID: <20261027100242.2886699-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
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

Backport the two follow-up Fixes: commits for b66774b48dd9 ("Bluetooth:
L2CAP: Fix UAF in channel timeout by holding conn ref") that did not
apply cleanly to v6.1.y, v5.15.y, and v5.10.y.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Marco Elver <elver@google.com>
Cc: Maxim Krasnyansky <maxk@qualcomm.com>
Cc: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Pauli Virtanen <pav@iki.fi>
Cc: Sasha Levin <sashal@kernel.org>

Pauli Virtanen (2):
  Bluetooth: L2CAP: access chan->conn safely in get/setsockopt
  Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

 net/bluetooth/l2cap_core.c |  7 ++++-
 net/bluetooth/l2cap_sock.c | 59 +++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

