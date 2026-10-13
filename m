Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BA51AEFB;
	Tue, 13 Oct 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901795; cv=none; b=RhSy94CIKKfvf6uEnufjDmH88/USc3TCerHms+yaz2OPu758J09bdp6kwnVVO7qTIN1RXUEXFIYS/2OgHWHoqlk4JP+SPbkHN19yW9WJKgCSK1hEROgyKdaIx0re3dFXnFJUoXlLMzMJm2PdheDFkAvQlylk2JFuv1QYBvv2KPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901795; c=relaxed/simple;
	bh=IvmPeIWKbIdDQhu3k7rq2ae/m0FpaQCHsciuMxFy7xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YfLO/sInvjMEgCxB4patfwIxSy9ms5Xlt1G0ep3Ni5rqP+CgOdkULuowlUMRvbGZzucDYIwnnVOzfDhfgi0/ElUYb0mtKG1Sm/Ze4OSY4vAqtU8Woy0JG5YL6Udmi2MmB12PaAAazSlqXlI6H7Ucs2g5SmHNkmPXn9DJIfZ4pxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOVxeA7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOVxeA7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9121F000FF;
	Tue, 13 Oct 2026 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901794;
	bh=qEbGMwUHO3ICleo5qtNmsGP+sowO90rtVbwha07uOxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SOVxeA7OgFka90fnxE6A5R4B6v7YnDpnxtwaRmJNWXwQ97plNQJf/r9buZNG7R41h
	 W1v+NnzeN7B64s5IMFsP6iT/TgmblsSRjn1uMcR4CNPXcYDSNA+mp0OFBd1Kr/bJ3J
	 +GJhp57wRf9OzHB9QPIvajny9pkyRgldfHc/E1mvSTFpwBbnDWYDe7OSD6wozew72l
	 /6W6koQFwgp/wF+b8w5Dgtu1b6htPUzeUGvGWja7pzxMYdNVm1orV9zexUWr1pClbd
	 gVC2M9gaURnY/dxdcP8obZPBlYYKXSehphoGAo6xvabqmpOnteT0840uj8veMd2Yo0
	 oY4PBnm4lJQcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Oct 2026 16:29:20 +0200
Subject: [PATCH net 2/4] mptcp: fix subflow bitfield misuse
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-2-932c9b182fc7@kernel.org>
References: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
In-Reply-To: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OedQJ+3W2bT/NjckhNpmoU9snv245QD8tSRsUaxFN2M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOOYSvuXX6STFrn40Fc0y44TQxRwaVso3PZ5iyTCler
 uWkF97aUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJFFcowMh1oP+AuoB5ZfePrt
 zWoNPzZxnSDdlbOvnNU+r8ZXeLovn5Ghba5P9o4mfvHnW9xPszUGX0pubsw4uPOFdtLWrfkZO56
 yAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

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
---
 net/mptcp/protocol.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0384d6a023f9..c006110b1c56 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -583,14 +583,16 @@ struct mptcp_subflow_context {
 		closing : 1,	    /* must not pass rx data to msk anymore */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
-		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
 		resetting : 1,	    /* subflow is resetting */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */
 	bool	fully_established;  /* path validated */
+	bool	close_event_done;   /* has done the post-closed part,
+				     * protected by msk socket lock
+				     */
 	u32	lent_mem_frag;
 	u32	remote_nonce;
 	u64	thmac;

-- 
2.55.0

