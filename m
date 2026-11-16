Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866927;
	b=Hxb9Xrv/vjwWAGfwRAQ3M+e0jXAPo74ftUIXn8XXnCthKSEa1rBUMjn0neCP7AJzZPu3
	 t1icjBoon5rjRZUXGB4T2Jr9uZEt//u47IKZkyyyL0y0dNWjdYmjNMqfDvwBRKT21rDGu
	 SW8mNd9Uj3C+Vpw2I67Q5Rl+fT270UHnqgCn4C7MIWPLSjsHz3jgUYlyDT2JrLfEvDWmS
	 +g5eO9u8Qc7n5czauNSQoaWHTL4hwee6KB4Co0SXEMUIlMhbT02mwrvLXhlF7JO9sUHzT
	 XuLfkvw8FyssleA4PDHHtA0C+oz1ue/AFRnKe3T6A0ROmNVWLzl8DPMQRQKRatej58w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866927;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YgGC5dcF1FjK0AqtrI3Ka3r7FM43DVqvPfh/GmOBMCU=;
	b=cX7c0KQ5aUhoYBC3d2HSalV+n9ptTPERsjNQcjGZtR6mh+tgQus0r2TX5PPd09ncpWiP
	 AjJMHL8ww/OcUHqzyZkzUjy9J9vj6vDuixcJI0fIXnPiBdPGfh7PKt9XbL2u07dZY1OPf
	 onLJVMzM9gXiPI9eaf91Nnb87KziVAB7pNM0dmc5Zh325WIjTs6Ap5zY52FyNOIiN2nT4
	 QxTbrbLguAbJu1C4d2UMpGb3kg1L+ETBHzcaftjOjYY4CeTxvmOVONdFftE9WwXgMMnP7
	 hBdzInB/UcWQSXDKvDwkWTwbq3ACNhoGel8nEsmi3edsYfYcqJY2D2o3Xos+xwSCNbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkDD5C73;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A5606A32C;
	Mon, 16 Nov 2026 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkDD5C73
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ECA1F000CC;
	Mon, 16 Nov 2026 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794866927;
	bh=YgGC5dcF1FjK0AqtrI3Ka3r7FM43DVqvPfh/GmOBMCU=;
	h=From:Subject:Date:To:Cc;
	b=EkDD5C73fky8RbN+l0YO8J5+aiybO3Ajk0rL9ztJ3PXeqhT18PlrmWCAcg1/Sv3d6
	 wus6kmgsrtezN14K5dv2Y8lVCaItUF1h+l5ctXTNsXoNoFlFRP4L/b8jAesQIO4ZmR
	 YCfVt0hI7DpTh6a7b/YKRN5OTXBSMx1qAdKYVFfkK0DizYdVRVhyJBV45VuDvlXR2g
	 Q261gHsZT7Ulf4mTLWNvgWLvIBYkbyJUKSS5sjPpjRkwXXB8o4DVNSWn8pgmM4b+Yo
	 tApPZoFDVHYYn0Rlx/l50AzSzSXS7I2KnKOc8iPLxmYjuHJA4upaa2+nTFCXQSo3r/
	 gkAxseyoD1eQA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/7] mptcp: misc fixes for v7.4-rc4
Date: Mon, 16 Nov 2026 23:06:07 +0100
Message-Id: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2YDtSqX+ivjg0kwjrJamijD27
 0Z9PJd7zgrKTVjhOKzQ+CUqj2LgdgPQ7VKujJKNwe99dM5FLNxxqZ0qLqKEs7xZ8YABGwVMmVK
 I8+hy8mCJ2vh3sMIJzITzf9TndGfq3zBs2wc/dBrnhQAAAA==
X-Change-ID: 20261116-net-mptcp-misc-fixes-7-4-rc4-9dc946f31d92
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Quanye Yang <quanyeyang@proton.me>, 
 Petar Sakic <petar.sakic@ink.fish>, 
 T S Rameshkumar <rameshkumar.t@phytecembedded.in>, 
 Chris Mason <mason@kernel.org>, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/DeWziEbbXwiOuisDmNrM56NFM/zlaQSji3xryXLt4Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ+1z2d/KrwL2vpqT0H/smuOr7hd/OUV2uPL3+7dPtX6
 0rF745XTDpKWRjEuBhkxRRZpNsi82c+r+It8fKzgJnDygQyhIGLUwAmcqebkeF1jF6avY55U4zR
 1H8C2f03NrTlenY2vaysMy+bmcxy3ZCR4W/kEh6T9IdusTedT2hU3jXcNClsf2Ew2/qcp8o28yf
 JcQAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some unrelated fixes:

- Patch 1: do not send data beyond the window announced by the peer. A
  fix for v5.11.

- Patch 2: push pending data after a sendmsg copy fault. A fix for v6.1.

- Patches 3-6: with TFO, send the data written by a server before the
  third ACK as soon as this ACK arrives, also in case of fallback to
  TCP, even if the connection was shut down. Fixes for v6.2 and v5.19.

- Patch 7: after a fallback, fix the dummy mapping of overlapping
  segments. A fix for v6.19.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      mptcp: fix dummy mapping of overlapping segments

Matthieu Baerts (NGI0) (5):
      mptcp: do not use a raised snd_wnd for the send window
      mptcp: use sk instead of casting msk in check_fully_established()
      mptcp: push queued data on passive TFO subflows becoming established
      mptcp: push queued data on subflows falling back at the handshake
      mptcp: don't send a FIN before the pending data on fallback

Quanye Yang (1):
      mptcp: push pending data after a sendmsg copy fault

 net/mptcp/options.c  | 23 +++++++++++++++++++----
 net/mptcp/protocol.c |  4 +++-
 net/mptcp/protocol.h |  6 +++++-
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 28 insertions(+), 7 deletions(-)
---
base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
change-id: 20261116-net-mptcp-misc-fixes-7-4-rc4-9dc946f31d92

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

