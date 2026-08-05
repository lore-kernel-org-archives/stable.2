Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2E2931F1;
	Wed,  5 Aug 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892423; cv=none; b=gpeRwSj04BHa52Px7uq4t4MAmhZJqc2jJXt6HgL7lOGlT5jmE7xuFk46PHUA9kyt7vDrUw5+TU5TdMvF5gfmZC9WnWgQvz5pUKJPCJTAVZuYAHPOPVZRqRfKdhEhqRXTD6kIE5HB+dh448q5hnOtFqj0jh/zb6bywg+zaenxmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892423; c=relaxed/simple;
	bh=w+CRlIlmrAPMumYyXiXoWIgMbJJ8ZuofClrSDhS4h/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffmIhCzF//8jUx7ZkvMaIeLwaAjHoyuw30T2xmf2PesrGLc+PL5ZEAd8gQAjfqR5sAHY+EdrHGwZrZco7Jmh+XLepy4t3Ir2voPspRQ4VGisSLJxfqQMcfd7UK7UH7yEACmv5DzX6nHpS8I/RqnWMKCZCkTJA4hyMXy4h033gRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTt7hYuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTt7hYuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF451F000E9;
	Wed,  5 Aug 2026 01:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892422;
	bh=o2Q1r7x0ih9Fqkq1mWeYbjC9mRstGVVs1Y3aP7h87bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XTt7hYuTh7ul2d7evYIdu9qdojNy9qqbQeYi28oSe3uB0M1soLZoejgM6ZQ8y+qAa
	 B17GssDT2OOj/i4VJ5Vk8FrnHrB75VgCbMXJPIyWdlsBKgkUZfi5K6/6gNZPymlFYM
	 J4fpifVp6w0XPeHBSFhv10VcTph/RAK7wXxiKaljpBLwJSWFNGR10RROsazGxjIum8
	 g7XB8cW7v2YP7O+qp3O5XVHXzBIeFZBaN7PXuQ92ktk4lRDpgfYfeZcqPxY5x7qkFN
	 ZFICmLA3aHJsa+iGhrRhX87Lz23Ozw+yOvvjgVbiA2oEucwodwmTONvFV9fIRo5ujH
	 dcf5w5CwNSc0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 1/2 5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
Date: Tue,  4 Aug 2026 21:13:29 -0400
Message-ID: <20260805011006.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804214406.750710-1-tkjos@google.com>
References: <20260804214406.750710-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 09:44:05PM +0000, Todd Kjos wrote:
> @@ -192,7 +200,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
>
>  	/* Kill socket */
>  	sco_conn_lock(conn);
> -	sk = conn->sk;
> +	sk = sco_sock_hold(conn);
>  	sco_conn_unlock(conn);
>
>  	if (sk) {

I think that this hunk leaks a struct sock reference on 5.10.

Unlike upstream and the 5.15/6.1 backports, where the sock_hold(sk) sits
just before sco_conn_unlock() and the upstream hunk deletes it, 5.10 keeps
its sock_hold(sk) inside the condition:

	sco_conn_lock(conn);
	sk = conn->sk;
	sco_conn_unlock(conn);

	if (sk) {
		sock_hold(sk);
		bh_lock_sock(sk);
		sco_sock_clear_timer(sk);
		sco_chan_del(sk, err);
		bh_unlock_sock(sk);
		sock_put(sk);
	}

So after this patch the function takes two references (one in
sco_sock_hold(), one from the surviving sock_hold(sk)) and drops only one.
That is a permanent struct sock leak on every SCO teardown, reachable by
any user with repeated connect/disconnect.

While respinning, please also drop the Change-Id: trailers from both
patches.

-- 
Thanks,
Sasha
