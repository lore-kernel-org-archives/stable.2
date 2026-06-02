Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C63DB33F;
	Tue,  2 Jun 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402493; cv=none; b=HHRXVfhMG7xXciph7WsqlP9O1Baj35zmqAJk7cFo4LCwwuIhUstUyDiBfmvrxbNSjXuR9+qeeQagTnbl03/O3wqioavMBn7UKD/4iFhJYQEPsMZIbvWiW1SD8yRdTdgw8WOUyCb2dV3P5yJiCcWKlfPWGdV4d4dDp4hc2CG4Nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402493; c=relaxed/simple;
	bh=89uQ3n/0Qw3xj0GP3YUOWBjrjD9h2PL6dSpP8OMpD5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEzMqs242vMCkBw2zfMArRiuHWiscFuJS/Dw57q0yvFDDp8FeIZuELK1+wdbXHOKkFrS/K67zR1QfsIsJHG5UkSUuSXgTg3MKjACk8N15WmSy9CVI3uugWpeRhwQxSdkgIcYzdxSumYL8eDvV5I9op9YXNyisRyrwh2PRVr/l94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJeELQpp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJeELQpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D9B1F00893;
	Tue,  2 Jun 2026 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402492;
	bh=aaWaJPX46vtcjlCbR7WSB0JgKZ/Rcr2pe1adTWLv85w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oJeELQppnutOMNTdRqYVqhfrW8sfW1oXbzCE2/13wksfckDVIdoZRlBcI4Uq1YN7W
	 mhbwtjCujEOnFTPLEhwDtVdPuwPCX5Gth1K59nY0Uy9wa2o+ji6+Sp3fyvmxDroF5J
	 pOfGzPYE55kUJLbt/j9FSxc746/1VDDmrsxqgMrRKIUfz8QOkgKaFY3cH+3UEOli8X
	 UUhJd/ejFWBJrNf8OSFqoGOO/QdY++PrHa8vWwwjIUv5QCh+yzHowH3LHUc2hsZhjF
	 h1wsax266yyrwhUcokAG8ewgmsHgyVIlOk5vGabONVmrE0Gs98q0CvlfjZOThoKUpo
	 ibhbS9ZcwT3Wg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Jun 2026 22:14:09 +1000
Subject: [PATCH net v2 02/11] mptcp: fix retransmission loop when csum is
 enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-2-856831229976@kernel.org>
References: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
In-Reply-To: <20260602-net-mptcp-misc-fixes-7-1-rc7-v2-0-856831229976@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vBnH00lmV7eZlsPI2IZN0MrG2/KQqq2hWo2tFLKydHs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHsksW1ZYzRxnUnLX88enh/v3Kd94bl7FioKSV
 WZm4ElBPgeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah7JLAAKCRD2t4JPQmmg
 c9KAD/4mCT+QjdBm9zxk+dsvJGn5JpJAuIzpXTxOsO0UfgQYvdNcedKMF0/zZLFKUraxv0esOTE
 fx5yvdhxP87xIbNcbEf6wLvDXVRLJ5uYId28V+wRa5qi9wjZ58zowFdCDew892ky1jYubVRiBrw
 xN0EUhgLvPDL5a9A8+E3w+QVIzd3dvocz6o4equkvM+0mompUda9S/wKzhqeHraGbMg7p+tVNuH
 QOWMpXP9RsLlhLAzbHmAqeGUK1tT4fP0uvidWSzqSTmzdmlVy2+8zJSOOTehmKnD2v9qi6L/Mjo
 tIh/KULGJT3zq+7gWDnp89U5ufVObWQeP5ccjHJzfVBFpZMvs50Af8UIXYuqQFjH3fxSGpkWXe+
 wfTs00tsOb8Cv5RzowPGbZYK6mYNoJ1K8htVfnDqZ0LDD2XfCptz6CLjB9gRZI5J8E6Wu3Wqkkg
 303eKzTMQCjKP2i9+IXPHrJUfxAr7Gn5xRDamdNK8PiV5dIZs+RMnfWbUjCgusKXp9breSPJ+bx
 V4unNstRUsII6SOF6xUEteoMI/cJTIS91QymXZeh3Qa2C636O8NrnFO61QykqPGAeHoCfzzGBOi
 ++Od/liQ3JyEu8gXh9kFRD319XPU0gBiOXj+U520fvp03gvyq8iMrVmW3uI6co1TmVqGMwl/juC
 KiIxB3LzFBFI7ug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Sashiko noted that retransmission with csum enabled can actually
transmit new data, but currently the relevant code does not update
accordingly snd_nxt.

The may cause incoming ack drop and an endless retransmission loop.

Address the issue incrementing snd_nxt as needed.

Fixes: 4e14867d5e91 ("mptcp: tune re-injections for csum enabled mode")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5a20ab2789ae..7fac5fac2097 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2869,6 +2869,10 @@ static void __mptcp_retrans(struct sock *sk)
 	msk->bytes_retrans += len;
 	dfrag->already_sent = max(dfrag->already_sent, len);
 
+	/* With csum enabled retransmission can send new data. */
+	if (after64(dfrag->already_sent + dfrag->data_seq, msk->snd_nxt))
+		WRITE_ONCE(msk->snd_nxt, dfrag->already_sent + dfrag->data_seq);
+
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 

-- 
2.53.0

