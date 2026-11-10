Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343391;
	b=5BTwawrGv07cizpqOdUiccERNFudGpyr7m7wQ7pvFuCwYFNyfYyoQf3IAWwbAplqS5v0
	 tnECeDUmvqHG3RA2fHoSTsltMFdWKf782NL8tM3R829DqTHErITbUbFaONeBfRx+tFe4Z
	 1uG4MrzYyz4zN7Or4DTjZNs9Un3iEh4UUvxtqaF9Jtw0WjZ6E5qDqjAzyBu/ovrXdS+lS
	 xGqCxHn00JyO4IiGDvtaaxww/E1Qg6xHL45fwECjneZ2FBpFBxL3PLpddsSPQvHWIfRKc
	 rA5JEh5y6K/8UQxU6/OszICNXpNBZKEyY3hO+5zwZkbHcTbDwCOEaGNVADNiSGq/Bcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TBXP3CUX0OT9nsyShcEgbbH1Z6IzpLV3S1MPROc/x4o=;
	b=vkHZiq/0UiiQupIqNSEQtpJCn/e61ZjSSdi9FwGnJvgnp1PpvygNCQPiTUMF0TRAn3QI
	 FLdXcNmxehyfnRmDXRgoQqTaHEoCBdDNLFpmYm3PFWsVIidcyXdQT5XRsTCFzpqqSKPFV
	 hGlX+K0dTIOAy0zWT1h4377vir8UB5TC8Va1ziPDIRjroM9yKTA9X7bFR8zL7iSnXe4vy
	 eUZCnxU+PlDVIrSdp5CyqGSLvQkZpUTPLT6pbmLSOgvoIZ8SEXLfXlnnbESvIejqBsWF9
	 jyRTi4KKzBjKiTXxU8qHY+yrEqFYKfAq3ZoxpJCfUEp7zW4RrCqsFD7GLQOIKi+Hh3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X00/zfFb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22B606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X00/zfFb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F3B1F0089F;
	Tue, 10 Nov 2026 20:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343390;
	bh=TBXP3CUX0OT9nsyShcEgbbH1Z6IzpLV3S1MPROc/x4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X00/zfFbkMbq5YmVNnOEPhK4hfwNVmFeQve6Xzcg4zhdHmR4k/CI2ZZvMiA0GijA0
	 FnuhL7ZrIZNG4Al2QQ0sLBFgi2MJSySUZlbU94JuSvf9oe5BIc54bM3uNwCcobxg0+
	 hLUvNPHIrxo1kWTmQDvCUPXvn6CeL3fRsxKx3bJePvnYvD1L3QrYbI08DIeDI/3//F
	 XAJEL/PWV3ZENFeK4BwVlTIFcvcOs9ifbSzbi1jICWLARsOnxYLmRHFX/kRYhEuVcF
	 Z0F5d8K9rVlDkYAkFKPbr2tyCxJDUpoNm94PxQRdZQVR3srH0r0XUhzGyDqhA5Fr7a
	 uQsr3hEox0xdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: fix subflow bitfield misuse
Date: Tue, 10 Nov 2026 15:43:08 -0500
Message-ID: <20261110204253.3819167-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055050-failed-6.1-7538fa33bb2f@kernel.org>
References: <20261107055050-failed-6.1-7538fa33bb2f@kernel.org>
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
[ sashal: adjusted context to place close_event_done after pm_listener instead of fully_established ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 31ea91b45363c..9d53b4ae9fa44 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -492,11 +492,13 @@ struct mptcp_subflow_context {
 		disposable : 1,	    /* ctx can be free at ulp release time */
 		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
 		valid_csum_seen : 1,        /* at least one csum validated */
-		close_event_done : 1,       /* has done the post-closed part */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 8;
+		__unused : 9;
 	enum mptcp_data_avail data_avail;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
+	bool	close_event_done;   /* has done the post-closed part,
+				     * protected by msk socket lock
+				     */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
-- 
2.53.0

