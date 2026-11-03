Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717541;
	b=Ou+1bNJ6uur+pOOZ2DBw9tedTi02WnUcmEvGcFrfe65CxJf9npsIvEoxxE6I8IE8iV/e
	 oqwGQWKTCAJk1zCc/I/6IKbq5J6dPfEjATb8PPqf+exOZf/j4FbhR/fF9lJ9Mn/yjkmOi
	 jwo4PKxg2GdvpqGh4frmTIpiIwKTmIsgXBgr39Zkn5H6fhIacBqNz8UIHxOQuCKoRWQZ9
	 sS6bUmgjUUQA8juGUCgEL9eJmmFksHH7g9B4AkKSAhDrlmp/NT5zWx5gM5KpMnfkjRTAU
	 IhFqzxW4ptWmUygiyzMWAeN0cc+G2X6i+TyRjW71rzZ1WexVMPvZqokGiqjok5h2cNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q1RwUUB2SGzRM/xlK6bFv1Cor0DulNlU980YLEG+TAE=;
	b=5XmbzpIG57UzRtQqO9SVyHT9RFc4e/qp8rCWMh+o0AIvBQUSP+W396NoHUpwXBMTXijf
	 wOYH1lCoPoQ6nbkNGBbkwwpbk6qOa/SXpvLdyNqIGlAT5T2c9UmUv2EyY2bdNqU3bKkQK
	 PC3tTr9LXRbLH/dkmlkPpxw6P8lfVINLLkmmTngEv5iZLdMjDiTsaNfvbUF/iPLuh/fgR
	 FxLkZn0f8CxRvI5GlEPDjwbuXz29VrlrvSGEza+gXqtCfqLW6gZmeBoCu3DeHxCD0gP1L
	 +3bztvsbsryD+LDAGQXzej+65YaVcmQ7Y/AD9wyyQ7BgqzHsc9XGq1H6zvWpLHdbh1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrHKGYCN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BC60A2619;
	Tue,  3 Nov 2026 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrHKGYCN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109DD1F00A15;
	Tue,  3 Nov 2026 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717541;
	bh=q1RwUUB2SGzRM/xlK6bFv1Cor0DulNlU980YLEG+TAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QrHKGYCNgqCSncLN4i2WXs3uJxSVn+qIiCKZHCT2QCisFV5DIoHEkkvmbFQPyYitL
	 UsELGDV96+izMumxGBdhMH0aYqOfaet7hs9Wnikknwye6cKY8buyzfo6fySQN7PNIS
	 cmH3M1/Iu09CsR5K84dNuT9TyPskp+xCd/Qj5sJw4vSPODnOaF6QL7UgYUKH7Vsj4M
	 R7mGJo8FA/RreBRw7UptLSMzLt+15XNfoVLNwDQyKFCY08QumfP5fRXUd/Qu+XMqDY
	 L497hLplKdiTwBsrj0ZsQhWxVTgVpq41FXssa8xDKXlLdJPu2rhu/iD8QzP3VoCJCv
	 eXE5uLYIsPLrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Erik Brangs <erik.brangs@gmx.de>,
	benh@debian.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	1149377@bugs.debian.org,
	Christoph Zwerschke <cito@online.de>
Subject: Re: [PATCH 6.18 1/2] Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
Date: Tue,  3 Nov 2026 09:51:56 -0500
Message-ID: <2026-11-03-1-daily-reply-0008-re-revert-asus-bt-rtl8761cu-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102153241.373878-1-cito@online.de>
References: <20261102153241.373878-1-cito@online.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This reverts the ASUS USB-BT540/BT600 Realtek 8761CU ID backport.
>
> Mainline keeps the ID entry, so this revert is for 6.18.y only, as agreed
> in the regression thread.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
