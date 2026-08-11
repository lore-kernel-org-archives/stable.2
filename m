Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A173E4C98
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474574; cv=none; b=jomqFXzYw2FxxNuG1RGx87F388aMnuI1X4FJ8PIsnvVFpm7XB1dGDe6zn7HoFXSp1G79jcKX8ne0NMDrVh5Y4Oe4+oFk3D+HUoljzBzFP0WOFIJxHN6RHj7RmnP+6Q9lG/Nbnom68acpaHMkbDTsKfyPXfD+Fw471zK2OemfiW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474574; c=relaxed/simple;
	bh=0Uz58xEkLCsLuFXwfzRFZRjLWIoJ+cLPCSIagl1sHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZimdTJaK65QTklxokCzclMYj5CmMGdHQTksCMuj82vpacL08qtI45Sc4nF6Qa7GGnV9LHSEA+6KsMLJ45GAejSvfDa5SCwGrKZaMHO6KCyxlzT0HiSkqzA4zovksD/5V2dW6Y/vcgJXnHPrdTnj3WwRW0inQ0SdC3XMJxWvuPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG3s5zBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG3s5zBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FE21F000E9;
	Tue, 11 Aug 2026 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474571;
	bh=i8ur0gay9qudU80AAjLr15zby7q3xb5ff/SOR79KV2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nG3s5zBTKBzOa35sqeX44hQKTvit8yhYF8T4EDVXuckFN1OrkWtkq9q4O1ZR9V+81
	 4mjyXT5z2AHWhE5ZIB3pcABTGi2UdrpIDx6V6m/6GN8K5M4FOf+jfD2P74pAFeiCLD
	 b2MVYDqgRTV4JN0GgZZbNQS2mQ8tRwBXPW9uEKkH6mcNUqdzhGR3PoDyRbw6IGgtW+
	 IUUBCp6Vxl45r5Q4BtQzEvn1xNk4oi7XK/Ammii2WVtvwVuVA1qz4Qsg3dq6D6dh0m
	 oC7cR7AVwka//14si82GZAksAd7nrmjgY8i1I+pUFoLW2mGLPYJvRMJ8EEMjZ36n+d
	 53MpFWLLfxcuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marco Elver <elver@google.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 1/2 5.10.y, 5.15.y] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
Date: Tue, 11 Aug 2026 14:55:55 -0400
Message-ID: <20260811184500.stable-0012-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810195147.4121080-1-tkjos@google.com>
References: <20260810195147.4121080-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey Todd,

I think you tackled only one of the conditionals. The "reinstated NULL check on
conn" in the changelog landed in l2cap_chan_timeout(); l2cap_chan_del() is
identical to v1 and still starts the block with an unguarded deref:

> +	if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
> +		struct amp_mgr *mgr = chan->conn->hcon->amp_mgr;

5.15 and 5.10 both still ship net/bluetooth/a2mp.c, and a2mp_chan_open() calls
l2cap_chan_del(chan, 0) on the l2cap_ertm_init() failure path before the
channel is added, so chan->conn is NULL there. Pre-patch the if (conn) guard
made that a no-op; as written the backport turns it into a NULL deref. It
needs:

	if (chan->conn && !test_and_set_bit(FLAG_DEL, &chan->flags)) {

-- 
Thanks,
Sasha
