Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479120;
	b=Z6GZnobgumDHZgGcuHyrpDnimuH8sikfXUwLzMKSqOq98vgczXw7aFFAAkbIqZMPk93R
	 6awkhhAfFj0kg6vjAlDI4/hORLi6yqjfJqgdnPYmUd8ffhQWx7av9ulnaNVvORuT4XCTm
	 0Znb0xwR3yjcln9fnZw7m4ZQIXtvmt1I9YZQQckF2XkTzFfPzzbRahGBGMRE+wSi67WTF
	 19ta97V6cpLP2x5QhECUmxTPcxLCAKf/7iRqpleGHmsWpCoqja2ExPuG3g14E81aaI8eV
	 PE7mZjoerThUo2NiSC3QNtdR/UUf9sQd8bqrSXXSZcL/gqbNZaiKwJkRS4qid7rProA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZhuMKltTCvdTkz+Wx1942wGr26xIife2tEs7G2ZEbwg=;
	b=Nw6y+HICaaTDN0+LwuhO88uMa/IP4tnNwdsm09rePBIki1szMYzKHnSxvE3UsVc3jPGj
	 BaPV3d8d719fJbmAm0XsNKP73ACgzjehSEJ547ULXRBOhqs8Mcr5Nx4UEk9VrwGoPQD6s
	 Kjhrf8xzX/nyToN5E0yHKdX9rh98qkUxVjs961aAm+52Hdqb/p6VTZKwLbKK4vw8J7H8R
	 srLWa9dolMD6/2wJvmriPDFEKnlKf1Ub5K+YZlvpeAcD8Yszpy7MZ4ciE8Pu86gCZvCnJ
	 AKv8cigPdf8ecI/PcLOoBmIpjaLjzBBwOR+VbB6RvrSDmizeTIQXI/tq+nFs4H8K28w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nu7A3hX/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF0606A322;
	Tue, 24 Nov 2026 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nu7A3hX/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECAA1F000C4;
	Tue, 24 Nov 2026 00:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479120;
	bh=ZhuMKltTCvdTkz+Wx1942wGr26xIife2tEs7G2ZEbwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nu7A3hX/6E7Wk6prhTKBhcFs3I9ARz8wOvvXoSVve2l4Ufzfx/PAm/n4wN32ksjOL
	 L+zCMeISI2QwBve8N6eh/vf1rDV2keDNknFDbE+87M7b9nIm1Otg4My8NPKytSh9tX
	 hyo2HsDZXFjmnTSJRR/LrsY85Vc4ccU5G/BHNd/L57TuwylJeerDzHU5I9SbEunrsZ
	 RcrKjmM6VI3OEzRBlmXN/5OtOVeeiC4I+AW+ldvXHM34h7foffRm6XzIrhzhbI+UMY
	 eEqNYanxOcmAFiphJPdNIsD3RslE0+H+wpRIGAr/vhyg5HAnpj6IZP+UdmyY1iJ/Dy
	 TsFYuqKN24IZQ==
From: Sasha Levin <sashal@kernel.org>
To: Wei Jie Law <98lawweijie@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	andrew.smirnov@gmail.com,
	bentiss@kernel.org,
	e.velds@gmail.com,
	gideonheinz02@gmail.com,
	hadess@hadess.net,
	hansg@kernel.org,
	jikos@kernel.org,
	lains@riseup.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stuart.a.hayhurst@gmail.com,
	stable@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 22/33] HID: logitech-hidpp: shut down G920 force feedback on input unregister
Date: Mon, 23 Nov 2026 19:11:48 -0500
Message-ID: <2026-11-23-1-daily-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <78d3f2f7715e3b66c06dcc7268966964@gmail.com>
References: <78d3f2f7715e3b66c06dcc7268966964@gmail.com>
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

> 2ae35f090d02 will apply cleanly to 7.3.y, and for 6.18.y and older LTS
> trees (which do not have ef166ce08801 and ff->stop) it will just need a
> trivial backport dropping the ff->stop removal hunks.

Queued for 7.3, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

On 6.18, 6.12 and 6.6 ml_ff_destroy() also switches to timer_shutdown_sync(),
which makes it match mainline.

-- 
Thanks,
Sasha
