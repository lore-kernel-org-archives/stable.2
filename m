Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CC5A0AB1;
	Tue,  8 Sep 2026 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907178; cv=none; b=YEbVTXgusiPvvvXcuvpGNbx32PqpfK+BH0bBah+HGNNvWzswyVM1CQz4/T4D/APIf2UsZ4wyltgHdFPrpGk5zh6ViD/CB0q778k9i3oduqux+L49LVrc4emjm0A/lDt7b6D97nyqQrU8ZYY2ucEcScE8CNsVTqtf6fl8OQ+cX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907178; c=relaxed/simple;
	bh=sKEeS3oHNOVnSKKf84RwnAWtQQFfajldcBg0rEeeOeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5e1+upvM1AunUChar3s/goFfnDEMj1YTJx8bYPqipEHlKCqGnikh/71sSwPZhi575v1uvqMjiSRWRypM62zKOg5z0u5uWzy0X8gO2Zsc8aGZQ1BReiNZ0xmsiDS2ULZxORhlqjzgSkHa4hEMSM9Q36Q/OWQ2VciyRvfN6PJiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgF89O9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgF89O9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894C21F00ADF;
	Tue,  8 Sep 2026 22:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907171;
	bh=K/hPnK5Yh5N07FENO7vbo+FC49Twupug/9nVyV1/kH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dgF89O9zN14hUgPefmxDu4EyDAP3zSsOjBnrdIDiwB8ygYXP6ehqQcN18w1eTHDDb
	 AehjLHLZT5oK88UXA3izbRyN72+teLHLijFhk5nOqNyo7tajwLdW0qdu8IZqJWT65J
	 INMF9EW6pkUY3FkGg03Y+ExjjBwkA6OUN8v8ASsVq8GqF/D8RjmfYZhNZP43NZm64U
	 GhEeCWMvPCO7T8p5X21Fp/GNcKcfRh/7EVIkn39B1DwnDb2yF29ia6jm3r06ZPEtYW
	 GltaexnQTECiN3oGhfDP5DTcTD1LmbSCsQJRgyi2JwkLvrlnYvcLPWhuDKszxNQXgu
	 2zpzfGkX1NW8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Garcia <miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH 5.15.y] Input: aiptek - switch to using dev_groups for driver-specific attributes
Date: Tue,  8 Sep 2026 18:39:16 -0400
Message-ID: <2026-09-08-daily-reply-0009-aiptek-dev-groups-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907214213.1817320-1-miguelgarciaroman8@gmail.com>
References: <20260907214213.1817320-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 5.15.y, the attributes are removed manually from disconnect after
> intfdata has been cleared and the input device unregistered. A concurrent
> sysfs callback can therefore observe cleared driver data or use the input
> device after unregistration. Letting the driver core manage the group
> removes and drains it before the disconnect callback.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
