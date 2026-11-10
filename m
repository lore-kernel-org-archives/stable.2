Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341810;
	b=SkkZhrGM2lycfNaBXXc6QZ0wHqKnIJtA2AnatOU3VJc4lXdPcj+rwiSmJXRwOjyTo94N
	 b2GDK7oPmJJ3lGoFKhT/4k6g+RYLoNNEnyQc+zQT1W425pPRiIXmIYhTFdPBA5fcnwvio
	 IwyNjAhCnW/hWUsdDIqHZ3c41JN2FJB1i+5SHROPVl3nKIs4QG4vQ5gzdV+8RH8OBKiDk
	 SEBfO51OwgXtfLdORSnFj6VBuMWMHF+6RJxSNUb++q6FRRJ3b0tQGykl6i3TAC5f1SDaA
	 2Et5zgIBl2I7z1iBo+Dhe3UGAWYQ6W2tFTp/CiPcEIxMqGVMW3S5jAHjmz0qOGJUsDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MYsJ6R1JqOzQ0AKfpYVO6Se6xjEHtYZj0JPQpiWQPB8=;
	b=vEfok5zXrQNZpS0vOCyeH8KIzlpGCmwxKvYlQdHT1eY9rA8k4jxIZg22IBKMnRtem7fm
	 Hrkyhi7/FXivgPnYBMTfB+cu57PlsXlTo/LjhCCKAzkJxYTsf79zlJGzQtn1NOuy0qCnL
	 wClaTdoSupvdehHv00YEfu3V8DfmZjkbKaK+uy+cPEQhFrtaZhT7rlPO4t/Cr56gPJIbS
	 0ZWxdVM6SOTTq7DEyol3QdhTg26Bzfxz9Lk6QFWA/Vrzf0HzEiHEoJl5S44UABxEV9EuZ
	 +WH7iuKorpVMdcbLBGQBgPz8Tmn1wwI37SmcAaGwGC+gbNzTaJr9j9WE2wzfbFAaCLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PojKKhoP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A53606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PojKKhoP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C31C1F008A2;
	Tue, 10 Nov 2026 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341810;
	bh=MYsJ6R1JqOzQ0AKfpYVO6Se6xjEHtYZj0JPQpiWQPB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PojKKhoPp0i37cWLMLWcCNrCRqtmeI1BfQQy+L1ud9+hsjSFHBQzQ79sumNvpBpC+
	 R8WM5Q2oBM4N6elM1ipSMs/8oKsHZDgJWkoj0U9WhthNMUfgMYLP1R9Mhg8ABEgWUT
	 FiQNrouZafanSB7nIiaWa9Jr9cY948ZPXCbuddrVzgZYqNx+S64fvLI9Q6u5bEl2Wb
	 s9wLyitCtAtFy5lq6z8B5TlToyGQ1FIDEOBg337SozWlwz97paQ0LjkPdsZcW58Yzl
	 88oSnbZt8cK/wR1u8Dh3JMgkCYepjuFxiWpSyg1Q8PoZcPNeHLKDkH7pUjVvO/kWbR
	 FP9yMCqwxEG+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: fix subflow bitfield misuse
Date: Tue, 10 Nov 2026 15:16:48 -0500
Message-ID: <20261110201634.3734215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052336-failed-6.12-7538fa33bb2f@kernel.org>
References: <20261107052336-failed-6.12-7538fa33bb2f@kernel.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 7538fa33bb2f66b8b809ff39d58308be48e197a0 ]

The subflow status bitfield is protected by the subflow socket lock,
with one notable exception: the `close_event_done` bit is actually under
the msk socket lock protection.

As reported by Clashiko [1], flipping the latter bit may corrupt other
entries in the same bitfield.

Move the `close_event_done` outside the bitfield, in a 32bit hole.

Link: https://lore.kernel.org/178959153492.22033.1944011998010756543@kernel.org
Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20261013-net-mptcp-misc-fixes-7-3-rc8-v1-2-932c9b182fc7@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: adjusted the unused-bit count from 7 to 8 instead of 8 to 9 because stale remains in the bitfield. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 28dd7dd08c150..d9c20de69dc55 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -544,14 +544,16 @@ struct mptcp_subflow_context {
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 7;
+		__unused : 8;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
+	bool	close_event_done;   /* has done the post-closed part,
+				     * protected by msk socket lock
+				     */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
-- 
2.53.0

