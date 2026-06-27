Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA602701DC
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578143; cv=none; b=WIq/J7xbBYjxUDiHlVtBT79aJXXB1ln2tPP9DTJfBGiQv6KbBa8w++zo+ISnhGuK+C+2mEBQkQGVMjwIogYEdWIk3XxG2m49DWZNfcjAfTPfceCwCifLB0RPeQbXk8FfxwEdAK1tkTSVCMw2Bm3w9UUVMY+nEEQZercaY2P/C8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578143; c=relaxed/simple;
	bh=bbKbto2FN5zWOqJSME3TlCQUiFdgjkZqwvhKQvsGaVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoJGr57JRaVLUEPmY+AnrFXonNHbRvtzZ6/lApJJ5EUtBtiBpXUwEdKWyfzs1vQ9drTYHBlBCytZtEAXYWY5bFCFNTAG/OsdRGQmxtqlvVOrxlKISRsJcIlHLT3UPgfZXBVzA3mW/XoRxKvx/hI/ow7oB6h/An820xQNEZTaEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHh1+Rvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHh1+Rvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2411F00A3D;
	Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578142;
	bh=Cw6YTKayCbd64Xa7/kMVbP9gM4FadKDyRhgYQXHyLkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHh1+RvgDnFTFcHWzqoASo/2fcSubg9g3wC670BvqxcJ4IyEbFNueIOEwv1J6V5dF
	 8ujk1fvTWI0SPA+2QUmrJuFP0axERsIFmSwOo+ic07KeGPj0G4v1x8dK8HVVv4vRb2
	 KY5lgvm3cgE0Ar5yyVFrfb44wbVqw9nt5so74Ih+GJYp7ov3ttTD7yxDBIVBaaH+rC
	 TGygH/FzFXlFoEymIPXgCsAXbRZ4N9f6i57i/elavAuWM/8fPsJoUZFM81q9J9ywQL
	 8Hkk9CtFQxSTZJrY1yXXNQmPxF1k4kWvSKRJDzsphFDV1dY/NswJ/PAVtPVYRM0oAh
	 h2A9Sj+XT7AEQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jack Wang <jinpu.wang@ionos.com>
Subject: Re: [stable-6.12 v2 0/3] 3 SEV fixes backport
Date: Sat, 27 Jun 2026 12:35:30 -0400
Message-ID: <stable-reply-item015-sev-612-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626193343.256956-1-jinpu.wang@ionos.com>
References: <20260626193343.256956-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 21:28 +0200, Jack Wang <jinpu.wang@ionos.com> wrote:
> [stable-6.12 v2 0/3] 3 SEV fixes backport

Queued the v2 series for 6.12.

-- 
Thanks,
Sasha
