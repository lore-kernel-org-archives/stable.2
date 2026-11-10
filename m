Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285315;
	b=t63ffoLba4lc88zzc4XFOEZlyLvA4S9jH5t4nJ2zWzrLRTqvoELbri5XlOCbxPygTisF
	 PtJ7IYL3HjjVSITEztYQYYB5NKnfKVoXaY4hPLpqT5fDEuc+/5dQcctscpjitjPrdbi8s
	 GPZt7MvD/W6/KfizUHMcnxa/cK/H9CMcyvJBA+B9FYRQI2NR1NzGsrYUglSyWiNK58m6q
	 xDEyTa9DPGeGw8FIHoJUatyu6KKAGxayxFLOVSVuMEiKhJOB5wG7O1aWZBlvWuFZ3uWMB
	 NMbb3ol0dZh1p9DxZe3T/aO1dyudALs7MZJ1z6xfXD0Wuh65wiSzHD15htQh+0ZWEiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285315;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SGZZGFlmvKGj+2t9SWhAh9SxU2TjgpS7fELs9nTPyv0=;
	b=0MtfG4dG7ikINbtx049plqqtjfYREZXYUYkxzJhEmE/aYjP0JC1bqlbPWKCKDmS4/j8C
	 BRVRZH07CPkmzExj5OtFMMG93R+oagEmFsx8jUHWSpU4jkgyOSYzrU1XMutvGNtW8hJ/k
	 qo+LkqbYjPDgfLrW6X7X181ebAO5EmyjKP5d0nWcDWbukDZULBlfK3wV0JFy13Gj11FNm
	 K+Ms9gC0BpX7YQgrF1uko1c92GLtIRQQnKLj2bqvjZl2VlMcMNW0r6K0EAUoFAg0mV3Al
	 xtGPKhzY+m0fNL5bNBNha/51LmJi4MhjvvrNXELzBnEgLN90SvuEUYZ83mvrD+Z1S3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7FjtYCM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A560A2604;
	Tue, 10 Nov 2026 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7FjtYCM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBB31F008BC;
	Tue, 10 Nov 2026 04:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285314;
	bh=SGZZGFlmvKGj+2t9SWhAh9SxU2TjgpS7fELs9nTPyv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P7FjtYCMqaZvNpWJJUYZEAnvfhhg0VsitvxgAovDmfyCFVn1KiJkPJ8aQJOZ4sPHT
	 Tp4TYg3KvSD2UTrj90Px4UPCR/cgvVvWJsDdWCheyZxeLORG7Oo1OafR2J1C2JEO+M
	 n+gDL3MHShs9v3Q6oW1Jpo8XBU7u37xzUEP472R+DCVHWCU515bTQyqmIHOTOVpBwo
	 wmZ+1+K2IQoe3anShYGx3tA9D1tZHn71CxhpHY581IfjeURQZoMv6NzDpGBz/GSMR8
	 ZRbTkr0Ui5WZal0Yh13V47YZiBqB1vw2j8TXH3RezVphZyxxVDtRybzh+ELIM8w+lL
	 vngS3swKfKF8w==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Amir Dahan <system64fumo@tuta.io>,
	Paul Sajna <sajattack@postmarketos.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	stable@vger.kernel.org,
	David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-lg: Fix dark corner in backlight
Date: Mon,  9 Nov 2026 22:34:55 -0600
Message-ID: <179428529326.1061455.2796035043921377487.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261108-fix-judyln-backlight-v1-1-af4b946f559f@postmarketos.org>
References: <20261108-fix-judyln-backlight-v1-1-af4b946f559f@postmarketos.org>
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
Content-Transfer-Encoding: 8bit


On Sun, 08 Nov 2026 14:03:44 -0700, Paul Sajna wrote:
> Restore qcom,num-strings to the default of 4.
> 
> Downstream had qcom,led-strings-list = [00 01 02] set, so for upstream
> we assumed qcom,num-strings was 3. [1]
> 
> However downstream also overrides qcom,num-strings to 4 in the driver [2].
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-lg: Fix dark corner in backlight
      commit: 9a6ea15d1629b124f481f892eab41e3ba0bd1c41

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
