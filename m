Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274876;
	b=Ibxr5U68gSeswP68yBUT9ijyj/p4LfHYzZs2jeGYe9yA5pJz0MLue4xZ5Jw9iks5q6lk
	 sKyRx9KW3u8yhOx3VmTn1IB6DcNqWFQ/LVWawSCw2tMCSPGGW4IEiWTLgXpgMstPWWIRu
	 pEgVSxAB0wOayDoxeOmWrYwrQlrlaKlTsyic9us9g/F1WxBFB/tzggDBdk7PXwkbeqebG
	 DTdzbeJmBLIvTKyeDqMR3N75XWCqZtpu9j8WDbJC7e3+7PNwsC8jPEegO52jpQJWiSxU5
	 rrf6IpIcKlmFlovQ+OJxFoAHazVPpV4huBJFFcBX2FCWpBNZsgh55xbMWYqYBb4CB/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FRrGU7jI02/74YNAonFZt75GvbnqAEAOxEjE7e5zkuA=;
	b=x1hZxP3pc+z/2Bd4vbcPSiZDDyEF8ReM1opLtCLOqvPyRfriZY82lhnf4h5bso2lbZVK
	 qSQ7ulLa1vkF+mTFLNFRVDJTVgdRyQ4ZRrtjrO1CFNfNfdNYRUTSjse+evLfbdl+bQT1a
	 xTHj7GF2phh+P9El1YK2IFK7m1wbBzTMpH+1cZz5LclFGFv+bNGGQtHHZGlN4LVXdIJzj
	 C6z2kDGHs5NCUBCA24onkjRNIYQOtxOisy2S44GOA67dPpMRClIHUatVxJAuWgd7o8cYu
	 RrGFX7CdcZedncKzOFrOIuv//Rd2L5388lg9eeFfWAdIQHYw8V1WRqrrqpsV4k86ekA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hmOvM/H+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FD606A680;
	Sat, 21 Nov 2026 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmOvM/H+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F0D1F000C0;
	Sat, 21 Nov 2026 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274876;
	bh=FRrGU7jI02/74YNAonFZt75GvbnqAEAOxEjE7e5zkuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hmOvM/H+H6iH1IRoUqFS+1jWKB6XByMU/tyY/x5wHVEk26Jw7PldIRmPIRxMNM/4d
	 YGmX4U5EvHTdzQWvc9HA2/RIdz3/CfO5xM/0QI0qbb2R/P70UN1GmVMJoyJdmx7bN/
	 2WZRyA0wLD0QVNcywRAkf8v7WdqMAelZSP/maFkUkjBsL+oA/p1Cl8zw1E1Os4Zxiq
	 D//196KWkADFqq/WKo7mtzffeOdBz996ElTz5u5UbQJKXZntj17/p+rzV2/zcbYxw0
	 mddhMOcaop31QhzQ98cDXp01OsXUa5JrV2Z5tbN07W/HtaX/cW47CGEPoGZEa1YJE0
	 QKts25sKZ3utw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tiwai@suse.de,
	linux-sound@vger.kernel.org,
	linux-kernel.supreme403@8alias.com
Subject: Re: [stable request] Backport TAS2781 calibration address fix to 6.18.y
Date: Sat, 21 Nov 2026 10:27:36 -0500
Message-ID: <2026-11-21-1-daily-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179525879604.6.759418222472508172.1791565667@8alias.com>
References: <179525879604.6.759418222472508172.1791565667@8alias.com>
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

> Please backport ba39a31448857da3b848174c9130b466b3ccddba
> ("ALSA: hda/tas2781: Prevent throwing away custom calibration addresses"),
> which landed in v7.4-rc2, to 6.18.y.

Queued for 7.3 and 6.18, thanks.

-- 
Thanks,
Sasha
