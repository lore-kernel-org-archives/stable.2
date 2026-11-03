Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717549;
	b=axiKfS54sN/qrLLXbkYrJtVIMeRpomLJGDML8y+rUyBMiqHQUrfoOmo8wPvMv2MFY3mf
	 dcvPYDiqwQ9nHvY43JEx0Vvd+TRLM5/IKbRkm4sQUePR6JVLQCtVOKPcGitWAKp9Sn36O
	 cOiSfA6NicAqCWa6LJcDZ2ETx5GaGKS6gVCU8FvAdrrp0/ti8zqeppIibebQRo7a2Y+yf
	 MMEjE1+AH7eMR5tc264wTjpGHscW15cpz8IWrPCKIxJMDd/IPYQ/gtOHa4W9XggHEgHS+
	 CVfF7bZwKDwTPu2kkyQ23nMEavxsfhKnhMYQMaLrEcVqAr4Fewii4JwGqEF6yKEKu3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A+tKrZaRWVm75PTRzfEdV7eNXoe4/w0grid+41M9KbQ=;
	b=aBhduu2PXY7InC4ZxP2hirvpIYtYRUVQdlpKoZ2G109OdzfrVNdobJKU8tSOBMzf8V0j
	 LETPblpDZdyBvF9ZuDYhQrzUXQHcheTFHUVzcmX8PLPCBqjPzbHiucYToaRLbSK8WmvWp
	 da4EXoXrwJZnyJAVAanFQKNykJ4pNOvRWm95qSty33w0G0gmQrNALzL1p+ts6a1nnx/JD
	 o1bJTfFv2i2sbtChGIi9+k4wRkYEoqO1DGq7a6CVenZGoJdqCYxXUcdb5J3m+WxixZxug
	 qOuF4pq3J7SanhLzAun2D2hfq1hT//F434xPFblw4QrDmVtpX3XmoAaEokSBgPkS8Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRc3mOoD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086660A263B;
	Tue,  3 Nov 2026 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRc3mOoD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E06C1F000C1;
	Tue,  3 Nov 2026 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717548;
	bh=A+tKrZaRWVm75PTRzfEdV7eNXoe4/w0grid+41M9KbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eRc3mOoDdkBOCF0c8E/7Al2WeUUQHZwfCTZzH4z9srXUfoQFFrxdTPXBTzP3y/8ue
	 uGJ33I3jaiSXOW7AZim45b199vK9dUFMVNGMu26lIzppvPYIYOCvKP2zd6AjC6mriz
	 VxVuqmdsnn6oETkTVmv6xaBb2PzmscOXwVgUhmjHnWmnKBzqBt3RzgnE5ssO049Qyq
	 ISE7ZbDUORr2e0CDKzKmFzsM2G63jcoAHBlL5gvSE0WlUScH+3bP0/caDfsMxW1Vko
	 Q+Isn6QNEHcPnVw5A7WEZ0y5DGl303Duvcx5TSywbUGoT2B1kRvwgUKLfSDkSPbgEx
	 PanebEwa3IU/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alan Tull <atull@altera.com>,
	Jamie Iles <jamie@jamieiles.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	xiongxin <xiongxin@kylinos.cn>,
	stable@kernel.org,
	Riwen Lu <luriwen@kylinos.cn>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y v2] gpio: dwapb: mask/unmask IRQ when disable/enale it
Date: Tue,  3 Nov 2026 09:52:00 -0500
Message-ID: <2026-11-03-1-daily-reply-0012-re-gpio-dwapb-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103-dwapb-fix-v2-1-9bd3785d1365@bootlin.com>
References: <20261103-dwapb-fix-v2-1-9bd3785d1365@bootlin.com>
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

> From: xiongxin <xiongxin@kylinos.cn>
>
> commit 1cc3542c76acb5f59001e3e562eba672f1983355 upstream.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
