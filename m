Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866944;
	b=4zOvreMmBvfFUuH/YWIlJkDbkixZH4LoMjB3IMTr2Wv4FzVh9JEr0T3OtwX0Ae+649/A
	 M6HCBo7hmDAGEb5dVgPk/N8U6z4zSW50SgBh5Er97XwaUNaO39KtILIJZA7A+k2jIeF98
	 63dF1KbYR8BW1pRzMGO5M819SXW5/qDT6r9pVTryDCALqD7ltp3xFYHAWRU8UtHZJM8Y/
	 7JURQS6rG+68Rq4bmiMyC6acBL+pLE4d38AjqLz+IxnA13+OuB6PlT9eUdMys9XXPRkkF
	 3KpaiglcDO9lj9ZIqqw4H79cB3hWT+V1ir61e8C1KASjEUOpCQDuL8ywYW0F9MF2uYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866944;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7mgC9jL8NBJ5pYS7EFVo2spVfEdDqKdaGi7rc+pAARY=;
	b=VZzdT1ToLGI25HhxhNQ5pkR7na1oPdT6iC/30dfWJFHDS5uMtuQslU40qpuSlQRLW6vd
	 7TyqEgQWxKNfFWoY01aCqQFTTk64WxI5Y9ZtNgH9AZczf+RKuhJ4rC47QTEFc8tfit97n
	 GpBYhcppM3yrBvSfLaeCX55u9DmGLd2RrBliNGt1LqJU0gJe0uahCLZjKgJiedId3gxch
	 02VeU7ZfSHpuh20NTZrDyzclQOEHDmPEpEDaUGkCnXr+fJsGL5alhQJz0jQOhLFJBJ5wJ
	 BLcUpc1wbPMt7b1o+6uKefzz8NJbxVmjOHGfhA/YIPx986/l0kCl+vbIZ+Xpgac60Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hetkCGdD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6A606A8B9;
	Mon, 16 Nov 2026 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hetkCGdD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74BB1F000C4;
	Mon, 16 Nov 2026 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794866944;
	bh=7mgC9jL8NBJ5pYS7EFVo2spVfEdDqKdaGi7rc+pAARY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hetkCGdDXEkm2883ua7V0ixFQK5QSPIpIaWy78Hd4Iwo4hmZDI2Yoloe5w/YmIqVf
	 XudrZ0hzES6OovQtMHnR9psf+FQ4VmEcUuTT4kIC50ZOw9xyzhGD3OP8xFxYsKClGC
	 Qz9blZXLb3/YEk0lCBL6Hgln6WNh2Ht/j0zU9QsqXHaJ0Pi2t+muHZXwidOqJhEwUP
	 +Y5WANWD9vvclNWiNdgabAGpmYozJYPT+AXeryQ7528KsP2um0jSFpKuf9oXG4mY6D
	 VCAzzm7+c9qlVcHN0AVBuqCGPYRB8/HYWqLbF3eAevaV9j1EkiaHLl5/hf7CEsaPnp
	 Ns37YVyfZ7XYA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Nov 2026 23:06:13 +0100
Subject: [PATCH net 6/7] mptcp: don't send a FIN before the pending data on
 fallback
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
Message-Id: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-6-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yQZm9eVkTr9yeWS98qWO8sSUzC9QPTMsOrDIzUhNZrk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ+171corI61OYN99UWA846j3qGcw+zHISrOBZO+BTaw
 PDA/7hnRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERmVjEy3FuZdWlJ6b6dOWfO
 zFxw9N+CE0X2Kq90ojoqpu7Mio92MmH4n81eNunyehVJy7fCVYcfxLoyicbxb5YvDvPfkpoU8iO
 VCQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an MPTCP connection falls back to TCP after having been shut down,
the data that is still in the write queue of the MPTCP socket is lost:
a FIN is sent at fallback time, and this data cannot be sent after it.
This can happen with TCP Fast Open (TFO), when a server writes data and
shuts the connection down before the third ACK, and this ACK has no
MPTCP options.

When the MPTCP socket has been shut down, mptcp_try_fallback() also
shuts the subflow down: if the DATA_FIN had already been sent, nothing
would send a FIN on this subflow otherwise. The commit introducing this
only considered the case where all the data had already been pushed to
the subflow.

The fix used here is to only shut the subflow down at fallback time if
no new data is pending, i.e. if all the data before the DATA_FIN has
already been sent. Otherwise, mptcp_check_send_data_fin() will do it
once this data has been pushed, e.g. by the previous commit. Pending
data that has been reinjected, e.g. after the failure of another
subflow, is not new: it is already in this subflow.

This issue has been found by an AI code review agent, while reviewing
the code of the previous commit, and confirmed with a new Packetdrill
test, where the server writes data and shuts the connection down before
the third ACK, from which the MPTCP options are removed. Without this
patch, a FIN was sent right after this ACK, and the data was never
sent:

  inbound injected packet:  0.240127 . 501:501(0) ack 4103187975 win 450
  outbound sniffed packet:  0.240207 F. 4103187975:4103187975(0) ack 501 win 1050
  outbound sniffed packet:  1.347800 F. 4103187975:4103187975(0) ack 501 win 1050
  outbound sniffed packet:  2.499829 F. 4103187975:4103187975(0) ack 501 win 1050
  outbound sniffed packet:  4.739843 F. 4103187975:4103187975(0) ack 501 win 1050
  server-tfo-fallback-shutdown-before-3rd-ack.pkt:27: error handling packet: Timed out waiting for packet

Fixes: d51991e2e314 ("mptcp: fix shutdown vs fallback race")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 011e73d04ee6..7d226ee38315 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1333,7 +1333,11 @@ static inline bool mptcp_try_fallback(struct sock *ssk, int fb_mib)
 	msk = mptcp_sk(sk);
 	if (!__mptcp_try_fallback(msk, fb_mib))
 		return false;
-	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
+
+	/* no FIN before new data: see mptcp_check_send_data_fin() */
+	if (READ_ONCE(msk->snd_data_fin_enable) &&
+	    !before64(READ_ONCE(msk->snd_nxt) + 1, READ_ONCE(msk->write_seq)) &&
+	    !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
 
 		/* we are in a atomic (BH) scope, override ssk default for data

-- 
2.55.0

