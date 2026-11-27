Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798929;
	b=WhlxDaSv0Mp+14S8LbA8aAPDDkmufLmgnqYmuU6e5/sa7jTbgdR6ujuAp528/l94rkzg
	 cBrCreVk0K+r5jtkyr4RBqhJYpP1XkQOR6OJHfGKmkz9P4+cpyosC0ipkOxkVGXBc/0Ks
	 YHCH1xCyoRTLU7ycih8OsNHN5e8CqL2VjQxrQ192mfhF+6urHuo9KUBcaIxgF+ZN2vaIP
	 gme0UgvO4GxH2z7uzul5yYT+tQaJz2F2gInXzKN3smvsriEQYcs4aGggZ1Jxs+tLL/1x9
	 sJcBMSPobHTu6AmgxfFpwfct+OCJ4dy/B6fdb22UHOHwVfw/gnu4xoDVKf9H4+PYnEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798929;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0NpcS2oW6nvPxFck76SHtDkLZbI4PkMHqiSgzCL0FUU=;
	b=IVfbqIoMbe31f43ZsNgeEzyzMQx8mAxHvuoPIIu5DdyYwJMOIV7F+mMBS1hUOhT+08A1
	 7vLTcIXxXapQ+dQGpBBOZ7Lo/vGZk0BaafZGxRIBujwYPiuhnlaMqqnNfqTIJ/qXGMQm4
	 aSv+agu3pNSyG3LY9Ytdanddvr9pSPu/5REIfQHYT9BCE96VDSZREkLu6hoOjfGg/TiF8
	 EMZjVQIt9uU05rlBrqqwySSxyCLBzQHg2AjXe94IBZWpcbrjjAh6asHf/SlfNVKyK6osh
	 BmTGJGRP1BOyLv8uc9EPuXO4VDvM+1TQOsDOTQg58gbGlelISiNPCdH5iEqUqG7v7Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRybg9qx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5D6606A321;
	Fri, 27 Nov 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRybg9qx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6031F0089B;
	Fri, 27 Nov 2026 17:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798929;
	bh=0NpcS2oW6nvPxFck76SHtDkLZbI4PkMHqiSgzCL0FUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRybg9qxMwxEw7Ij/+K6+orVM1fDkeUocwXtv7yMd2Q2ImlGfAQ3laH1lzSjA93bU
	 XZYqc+BrDsKBHL1MEgS9HlHBDyIfTSrimtRqYhe6GmnXb3aTH4eTgfPk1pJlsXRc0u
	 bMGHEC8v6RWMPGuWDj6ca/IPwpO1+cFBsmPeKj7MimOo1FY0LxeR8oyeIwjVEKuqvm
	 OiwexbODR8TTPD4gwujesAD9VJYtQT83Xqt5NTUaj/y04/BnFuLCXdKG6EEA8xOhTm
	 e0S6TnImZf4DYt0lMO5f7roDyD1yFEh96J+E3KJSxkktviUBy7SL+SjdHZdjgH53oA
	 G5MLcRx/f96lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH stable 6.18.y backport] ASoC: SOF: Intel: lnl: Enable offload for UAOL link
Date: Fri, 27 Nov 2026 12:01:09 -0500
Message-ID: <2026-11-26-1-daily-reply-0021@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125152602.22513-1-peter.ujfalusi@linux.intel.com>
References: <20261125152602.22513-1-peter.ujfalusi@linux.intel.com>
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

> -	return 0;
> +	return hdac_bus_eml_enable_offload(bus, true,
> +					   AZX_REG_ML_LEPTR_ID_INTEL_UAOL, enable);

On 6.18 and 6.12 hdac_bus_eml_enable_offload() returns -ENODEV when no UAOL
link is found, and this passes it up, so lnl_hda_dsp_probe(), resume and
runtime_resume fail on a part that doesn't enumerate one. Upstream doesn't hit
that because 978152b2cab5 ("ASoC: SOF: Intel: hda-mlink/lnl: Convert offload
enable functions to void") goes in first and skips absent links.

Is a UAOL link always enumerated on LNL, PTL and WCL with these trees? If not,
could you send a v2 for both trees that ignores -ENODEV from the UAOL call, or
one that brings 978152b2cab5 along?

-- 
Thanks,
Sasha
