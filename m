Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634435966;
	Thu,  8 Oct 2026 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418076; cv=none; b=JLWBN/rq5P5/wSjODlWK/ben8t66CDbxsRU6BHI3WZ1pEqqSTNubUvTCS7Jfrc72nsWi5gsjn8fvUzYKqUJxasrQK7ksCG+CI9bZX8eQyhLZv/eyHdIQlqHX5Wv3T8le6vSHn2Wzy0/mCtjfZ6YF5p179H995Yvy/mEhZc9MdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418076; c=relaxed/simple;
	bh=lUvFAR7BnKEAXUpY8di4oHKCnay10t8yLNq3LAdx7NA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jN7bgweNAAPmI9y1s1FOq9BlKQ6PC7lmfoCze1RjJHv0oxGgbBeLZoKCWz5BNn/t43pFG0vHfHPq6/rxg2WSUkyH4AiNfbT0UDjGWrTNLpgCRMGxgfu0qorvrIsqb7GNKY1lfp+LPjx6GpD5H186kMincvrGfAsTNBWHFpJnJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENw+E+7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENw+E+7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26AF1F000FF;
	Thu,  8 Oct 2026 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418075;
	bh=lUvFAR7BnKEAXUpY8di4oHKCnay10t8yLNq3LAdx7NA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ENw+E+7+nC2cMJ5jb0iWD0TTjHQzUFia+4sZ9BCBkD+rUTY4rS50nrVKhmzgxY/gB
	 M1ScSdnpecPO0tOX3g2qXZgkgDIuFOVPmzr6YC21dnzmDx0ElR9Q4iXGURkv1UZbLQ
	 p4YJ9JWMmN4qdtHlC6fRfKzDT+EH0aw5+hfOaItWOI/XnOJajYd7CP/DqMkmlilEbH
	 S6t5N+StcZrSt8Syl2WKFm/KzyxyNmSGPo7wHRt7qr+7kT6MyjN0nVZF5HPJclbFM5
	 Mzv7vDsCrxbb2VWD2QzQh9FGmd9kFd0/IvKEW4jDjra3oKW2ow/EScZUsqNAzQDS2K
	 Jm4AZdAKYYSoA==
Date: Wed, 7 Oct 2026 17:07:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: netdev-bot+sashiko@kernel.org, sd@queasysnail.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] macsec: prevent AES-GCM nonce reuse after packet
 number wrap
Message-ID: <20261007170755.43c8fae0@kernel.org>
In-Reply-To: <5a337607032eaf65e513af47177bc755@oss.cyber.gouv.fr>
References: <20260930203333.598733-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<179094094507.434549.10343867236114211128@kernel.org>
	<5a337607032eaf65e513af47177bc755@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 02 Oct 2026 17:22:26 +0200 J=C3=A9r=C3=A9my Jean wrote:
> Please tell me whether I should submit this as a v2.

please do
--=20
pw-bot: cr
