Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FC5592F2;
	Tue,  8 Sep 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876899; cv=none; b=d1AdCDwadygazcQ+wF4DGgDp8N8JLUqsJwJp88c4TmXeDepZugKmS4jC4fuvC9SJ/izcBvs37bA5Ii35LI6+gdf9lhEpCHTxApV96I/o+P/vN48kLB6EJPexOpdifCTId6zvP5604nVT/gSkYI/5AgHiRZNgTnPLe1jru3HLdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876899; c=relaxed/simple;
	bh=OmxkKtnPfRqO9xltx7TfPbE3UpbCFtxyGe+KZ4x0R0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zl0N5cqpTtLu1oa6Glh0cjcHOthibuBbcK/l2BZ3PoD72CqRI6QlR+d4fEhANuOvJJsIXPP8Oo4bFlBBNAK7G0yADRKa3GePeJhIHCGM/NWP7pHWOZ5XqmHuymQ1cgsqPcM7kZQCjNc3c4gIzHyh0wfHW7QHhBRgBl7PJSAAJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBVvjnQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBVvjnQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9497F1F00ACA;
	Tue,  8 Sep 2026 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788876888;
	bh=J5n7TEwTvtd6j21kll5N09DmPU5cpF80L1q4Ks6P+2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bBVvjnQCpYpxu+anQue11xodoKMgxZUYRkCq3tQF8AzoKI8sEUcwlwuALwdUCzNHB
	 /KqlGBUcgscFq0cVGPTz3XpD/MUQQi3ZLJcuz5jC6UIO6dhvLsydTD5nee4dIf3ZtN
	 MeykLkUQ8hlLJJR+szlzd+R6WB5ghyhA39Z+b7UtARmYsJd+mLJ06vdbZwE1VJ3dOV
	 Pypvl69xYoh7b4Sq49nALBRxaMdiQ9LwRm3izxLC/6kKWSPEaHyCzbByAfPaHqOWx6
	 EoambclvHlMh2A+9x+PWXZpgO1FVddnE+fUI1/M70TzsfnLnC7pY4ldlONETH8q/S7
	 ktpR//sF3o8Ng==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Sep 2026 16:07:18 +0200
Subject: [PATCH net v2 13/15] mptcp: options: fix uninit-value in
 mptcp_write_data_fin
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-13-df1de70348b6@kernel.org>
References: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
 Keita Morisaki <kmta1236@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OmxkKtnPfRqO9xltx7TfPbE3UpbCFtxyGe+KZ4x0R0o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIWSBhuEKuasmeT3z4dh/f66YK3P9wJXdMmuNGgJVfur
 Qq3dqBCRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETK7zP8z11+s+HHhi0dPPOf
 TZjkK8o/Y66e55uoPxG7ix4Zqt5a28DIcPtib8jejWqsQdqHD/+9kuLN+Zz3xcc6u2lVYXMM8pX
 eswIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending a DATA_FIN without data, and because the DATA_FIN occupies
1 octet of the connection-level sequence space [1], it is then required
to add a DSS mapping with specific values.

If the checksum has been negotiated, it also needs to be computed, and
included in the outgoing packet, and thus the initial csum data needs to
be reset to 0 as well. This is no longer the case since commit
cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()"),
because the whole ext_copy structure is no longer zeroed by default.

This seems to be the only case where use_map is changed and set
afterwards, so initialising the csum field only in this case, along with
other fields for this specific case.

Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
Cc: stable@vger.kernel.org
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.3.3 [1]
Link: https://sashiko.dev/#/patchset/20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb%40kernel.org?part=2
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Keita Morisaki <kmta1236@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 196a46e7467d..ce0de02f5a3a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -612,6 +612,7 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 		ext->data_seq = data_fin_tx_seq;
 		ext->subflow_seq = 0;
 		ext->data_len = 1;
+		ext->csum = 0;
 	} else if (ext->data_seq + ext->data_len == data_fin_tx_seq) {
 		/* If there's an existing DSS mapping and it is the
 		 * final mapping, DATA_FIN consumes 1 additional byte of

-- 
2.55.0

