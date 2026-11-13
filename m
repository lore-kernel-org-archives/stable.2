Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537214;
	b=KSDNgKqxOpMpUHA7aNInScNwIoxqkSoEx11H2Cjth+S51ECB/d/8Io8/+clYP2wsULGx
	 ONf8clzef4pERh0hxlBlGq05PVLXMnA0YT/sANFWn2GwORWiwq9vFFmuhJfgxAG/v/Xn4
	 eK1Zv8UO1J6gVP+IwXTmPflh3Xh90FUyfInpmGaVkXx8aIQd8SQ+Rg3KOlkM+07TRIHfn
	 Lh9EPF69uFTba99BG/hNq0fiYO4pXEUMtKMP5DaZf0ebrJ1SZQguD9pi4uZ/ljf/z0/Qt
	 yQDoTWgQdIEKke3DtyhxI+7dmmlJdtuzG2vVDLWRU3hjWDfbd9OD1GMNhHEY7PA9Aqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537214;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SxIW+plsCgY2R5l2VH9YPxDkVEMEyU9n92O+K6dC4g0=;
	b=THsakNdFj44hsWl96Ps/kht9cbPkqwt2LnfwKKQRMQ3lnopy53RfQ1M9PvrQ8ITXumhY
	 iVb/q6dwCYFZ3v2Pi44rcXnPyDXUnTYY4wwURk2GBEEhRDmu+Cp+7ecVf+QmBQ4PauSY7
	 rsZP9wia/VEHofuyLzJUfhONrlPjjUbNcowCcaW1wE6IaMdHAGNLNsPmL8eZN9Gem7fO3
	 Py2r1UYOV0IVfx3YbvZf17ID3qbtaW8q1IHcB89CFWDQJ8d1K+HWFCQbRf+MjHRisSBKR
	 aIkF//jZt/ttCejXPx0+STCFoyC5xtiybbfG1fcQ3F9BiTHELWPDsrkC75khl5NeArw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9wlFzEx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437D606A33E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9wlFzEx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5491F000C7;
	Fri, 13 Nov 2026 02:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537213;
	bh=SxIW+plsCgY2R5l2VH9YPxDkVEMEyU9n92O+K6dC4g0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g9wlFzExC+9dRXDn1K8QcDufe6YdxsAK1UhifICdzqjhG5nO8IKtnvUAWT9iy3Yfg
	 skaLinQA3ca7p6A65jnbOGHWeBcz68liJLh39fDnxDYieenfOQ4VomEBzNL3avMyQc
	 YTcZw2VbrhncFMOfDx6onzTpX+f9DwyO0nk+pdphFfXsoRktC6mP+Qknwvo0PKUQa6
	 QYhZF3TUhaYeVRlXTDSZWJc/Jo6KtQCeBybYq/Ud/csIl2lc/4u3rRwz1rcJR8AWpw
	 1t5MBMDjbHTjHdzW8a9BFCikO34O75ALol36We7mwyUo/9YjwwuSXM8Z0DGUhqb4li
	 MqAu5BSDJEWlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Siwei Zhang <oss@fourdim.xyz>
Subject: Re: [PATCH 5.15.y v4 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Thu, 12 Nov 2026 21:33:13 -0500
Message-ID: <daily-reply-2026-11-12-6477997587@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111220745.3075256-1-oss@fourdim.xyz>
References: <20261111220745.3075256-1-oss@fourdim.xyz>
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

On 2026-11-11, Siwei Zhang wrote:
> [PATCH 5.15.y v4 0/3] Bluetooth: L2CAP: signalling response fixes
> Backports of
>   6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid states")
>   a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to outstanding requests")

Queued the series for 5.15 and 5.10, thanks.


-- 
Thanks,
Sasha
