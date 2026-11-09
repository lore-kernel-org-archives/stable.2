Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227969;
	b=kW+LKYBdHBY2rxU18yu1hQyEPToPrBL0prjVQq527Mr5X96lOhMI3+z0xFCVPm9EVgWg
	 sg42BvJT2X5LMEponbWWp+LaXHQpKXZ4nmNLNWwTjUMHZXkhXyhlzAPTSL1sTeJjPMiv/
	 O5ZMtSeMayLZlLBER+lgFhhb95oBTuJPweDMuBhbnGKcZtIGAQYxypl3ksvFcD9WvARmw
	 a9zOak4D3jg6vv7dfywkw39EApUbwXWDbGpyODYHN0Rs1CJ0+UVHRFrBUJAdf5t/91M6i
	 83fSbzNdZyI3kHrXU7Ncp0BnninvO+WnC8SGNc1ZteSJ/KNBjglhbXpdA+VVdQ7nwaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227969;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=n9bGePk9lrw7xV7HE6vQIA1MU1oWUPB9VGc2zWRd4WM=;
	b=kjMuvlXZ+f0kAPO4okluqPe20Kc8JFSP4CuKiDyK3n9V0KwvNYRpkRjskQrGIJAqV0x8
	 wUwSRKnNHeK4uLQX9aytnGZfil8SydmQn24AvVXijr2/tBV49F7UHIF291SrFawF/IflE
	 RjJQSzkap8q0vZNSlgVfrPrD/AnNVmBccrFCSXzzxzStr/petrC9yCjGjkOnFF1QKxqJb
	 MCxJ+ptgcHQR1Twr/aRI1HB8pJL4u8vGMmaQUZ1Hwe0k8++1pw6egjrtw6TnL4LaKP01j
	 sjHH2fnJHYg7eFEyi7cUQGWm0cL3cOyGHgTBLa4qWXsZEZ3mVpAEomx6W4wsoi0/31A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=XgS8SARQ;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAA606A31C;
	Mon,  9 Nov 2026 12:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=XgS8SARQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=n9bGePk9lrw7xV7HE6vQIA1MU1oWUPB9VGc2zWRd4WM=; t=1794227967; x=2109587967; 
	b=XgS8SARQeDd52UUID8Zf5MsYQeqj2kxNFlXwBf6MzFX3B2WSCfTJy3Cg9mFtpo0JhyMziaFc3q7
	OHgBudiYc5qeUXtidUL9kRcTwDuWs/8unXuuCRazog249+9c8Ktn1ZhDxHYq0/wqYO9H8O0Ih06bV
	lXhaz5mfmCkYMoVfJbR9/5P/htyWu56xa1FF5n+ipJI06n+UftuthxA9G3cll/dzgGjRHPDCfnNvk
	iAudp6IyNWcdDR89VuNdWLcXPnxVk/V39EUq6Skroj4p6FZVIexl3e4WJlNmIhnEWBFUVLe+KE9jr
	Artm620STVvIAEZUkYpfKaM2BfnZIdw81BfA==;
Received: from [179.105.94.163] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xQOea-007Gqw-OE; Mon, 09 Nov 2026 13:39:17 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: airlied@gmail.com,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	dave.stevenson@raspberrypi.com,
	dri-devel@lists.freedesktop.org,
	kernel-list@raspberrypi.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
Date: Mon,  9 Nov 2026 09:38:46 -0300
Message-ID: <179422792408.2740537.1643509391861817980.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106092016.2282805-1-vulab@iscas.ac.cn>
References: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com> <20261106092016.2282805-1-vulab@iscas.ac.cn>
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


On Fri, 06 Nov 2026 09:20:16 +0000, Wentao Liang wrote:
> The firmware reference taken via rpi_firmware_get() is leaked when
> either of the devm_clk_get() calls for the core or display clocks
> fails, as both error paths return without releasing it.
> 
> Fix it by moving the firmware lookup below the clock lookups, so that
> the reference is taken right before the firmware property is read and
> released immediately afterwards.  The rpi_firmware_find_node() call
> moves with it: the device node reference it returns would otherwise be
> leaked by those same error paths.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
      commit: af200e91c7b996177aa90981b2f0e794b085d43a

Best regards,
- Maíra
