Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184485;
	b=375RvWnYArJRBmd6Nzlq/nz8a5CgwW/y81qznVHS+N+0t2bHuzzlZT25bhDmKppgnUsg
	 +izgbsXhdMboAHix4a0ITCiAMfMO7W3UZoueM3uXQPRLDHQmozlK9gKR8KUt2EvcWNp6H
	 SdC/cUXgQXim+5zfHjV/sphWRx5mtXun4pg/BarP16xDhYM0l9pwetbGggk3XIREKxAJx
	 +bL0uFx22vAk4MMBLcJYEEaojWWQF7MngDq49iZCgzRqXYAAbSY+u6bOFHaXJEWg7MSjZ
	 RsEoQz2/TnZk5w/kWgEr3ltV8ziOQAiROUsF9JxgyQtc6ag3w98C8VfGHcdMVyUWB2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184485;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7Zgvxy9nCRbIGP3Vs98dFUWI/fdNtaBQwo1qW2JnK6g=;
	b=WjxFfX4/gGUvLbgONP4CXn4w27V19NKT6hPC+mZ/RwiKwuwV2+itKK3df3lHg17Q2qPR
	 raPYByJS6VPtpWaMzFt+12s1Y/xHCRJsHZdr4QDi2vkGNqzYA1ljgEP8TevkyVcKe3BHQ
	 Zws4LAVEWouYZmZdao0+2m7BMkQ+1B0akeX4PEcOSky/+fijF4pcrlN0ugj4AjEExutWh
	 BBapO0PiDWAKmCd1AZI7Z21+szU38IThmUqPEWknXM7V3q420eORyoR7lIPm5F7gTcrST
	 HwWONTMgWBb6vJFcCfhHLI2pjNKR9vXOP/dtXGfKIy/hO0wBOKriavec7xpoj6fUf5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWyQavHw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEDD606EE83;
	Mon,  9 Nov 2026 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWyQavHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8211F00930;
	Mon,  9 Nov 2026 00:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184484;
	bh=7Zgvxy9nCRbIGP3Vs98dFUWI/fdNtaBQwo1qW2JnK6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MWyQavHw6+0HGA5IK5iNGDbeAIgx9OTwLgnM2i86ZZBozd9Yo6DjksIui3PdnksfY
	 1HnbyzkNO527dCvWK7ibuQ2Ln2y7w3/IC01j/POBilnhd9Ae0XLn9t5yNq/u5XAClO
	 bp5WjmL5WDI55JC61I3+kp9+R5bnsDN9CEOQAd0zvK/ihODhLS3Ct/L2zAduJv5BNR
	 IiGjuWk8cL5S/fZ+NcYtPus1zmg1aUKb/GxPseylKIWTqMN9fNZDKvuS5zkCALe1rV
	 xbzTXJH/M5Jj3EY3iApp6acE0/nfnzZH2gBa7QLOWW3W7C7W540wBJM9anXNUE10T7
	 apPhaR3Hv2zog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	Florian Wagner <florian@wagner-flo.de>
Subject: Re: [REGRESSION 6.18.y] ACPI: button: lid events lost since 6.18.57, please backport a004b8f0d3bc
Date: Sun,  8 Nov 2026 19:34:30 -0500
Message-ID: <2026-11-08-1-daily-reply-0002-acpi-button-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108143640.6252e6a8@teclador>
References: <20261108143640.6252e6a8@teclador>
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

> Backport note: a004b8f0d3bc applies to 6.18.60 and 6.18.62 with
> offsets, but does not build as is, because struct acpi_button has no
> "dev" member in 6.18.y. Using &button->pdev->dev in the two dev_dbg()
> calls is sufficient.

A backport that works would be much appreciated :)

-- 
Thanks,
Sasha
