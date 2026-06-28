Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E7261B8D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617630; cv=none; b=uMKNGvLToVpJEou7AFBnyj77bX2HzQUKsy/RJAfmTK7W/PVPyfE1KlWWg6bOdLJt+DimwQI+ya4mfob8mqUAj2iKjYOry9dnCuCsnE2A37vhV25kDmT6fWz4BUtFqKOGQHfrOHbBn4XQxRkhsPd39rGduyEyjsvbxKEcOLC7EME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617630; c=relaxed/simple;
	bh=8AgLgPlt+YJZDQOXBmYPeDlG+5ro9HmV0nzgSQ6ekHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZpVG74c3H/AG3aOmfjOmiV4TwbUcW5qucKuKFN1scosKEECRZZngICo6mUc8/nOIbDCheihdRXA8uhlule+L8RHApdNKP2oZPKREuHmrlqs9Pp594IGvqyKAJXGgvg0q7ye4w2DnMU8I/x4b1F/6wWzVGiJX9Is8akInOwsMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMmdUt5e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMmdUt5e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91201F00A3A;
	Sun, 28 Jun 2026 03:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617629;
	bh=8AgLgPlt+YJZDQOXBmYPeDlG+5ro9HmV0nzgSQ6ekHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oMmdUt5e5SMlwK/ckVIC0K936uVghegIx/+kw10PsT+OZ2T6OXw/ftT6DO74/8t4/
	 GjKrx2ukLZABEqtiZ0G7TmQ24QyV8LQrMEvHQv/y0VRgvDB+t6vEX1Opq5QhxmIOHB
	 DOodBK9SPVvrL0uWDYxsF+XitbnNgvxhNQjOgd6GGLhfnWmcq7VfM7ARwFamlHkZq+
	 Ap8bsRrzQkN7l3kuRWCeW/bnc4TLHJeOvF9gtK9iIlbo2ICNcm2tzQvMLvBVr+R531
	 BWv+0+V8e+wweQIue5DgyAZAXB06dfoWpJzESoMa45w4IbFs9cVFHLc5u7E57ws8kM
	 f9zyNzr5QlKBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 5.10 00/23] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:38 -0400
Message-ID: <20260628032401.0008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626160952.123713-1-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 26, 2026 at 06:09:29PM +0200, Sven Eckelmann wrote:
> [PATCH 5.10 00/23] batman-adv: 7.2 merge window fixes backports

All 23 patches are queued for 5.10, thanks.

--
Thanks,
Sasha
