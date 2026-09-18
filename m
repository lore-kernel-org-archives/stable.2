Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C255226B0
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760766; cv=none; b=uTXSi5iL6J6pBS1V/Ix22tdAQ2ZJnav1jtfWRjdkyh/Zr3J2y0FtHqJ/80ynFyJcnVn30Fc3a0nsQ8nUMRUe06L8t9LiDDGBANOKqtCZZRSFD6LbSG8hoFFSmURPlcYxobtxqvRx5sv1/uwEq9UZ5NFS1uvy0flO4xecBUjrJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760766; c=relaxed/simple;
	bh=NnNacUfQA8RUUR+7wD19zJh8Suo09mp77vi3n7ow+TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLEXG5ELjQRNMEnMSBy4El1XHbnzZ1YqetNl1GE7yKWhBxIy6CG8qxt4jtkorC7yR5gyomgIdygR2kywi1I1BnxlzwpSrD7csKpCgw0Glg2OMe7IKZQUIntlXHdBwHLP8C160n5s1MhXg1CyK4NcNg6KluxWdW3gFXf33QSPBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6yqVqbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6yqVqbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345771F00898;
	Fri, 18 Sep 2026 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760764;
	bh=Z4153xnVqG+nvSDe340Ncx4z5MIXf47K7U4JDRgK7X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c6yqVqbzB0pPjT5HqplPTbmqcdpbqoEEx5ZEivXABrJrvE0AMh6i4+Fk/yoOEVKS9
	 5knNDH0CHv1+oAiEOvkkP3BPhZ9RXDPNYyM7Vb5eY5liE+22cL6oDhM9i50eIsdauU
	 Jpa8SaUL/JNmH1MA59hrxHoVqs0/LLcFigkZdGyRY5HZO4EGpBtu3YCH8LfnPJRPCc
	 nsCPKt98EUd3Fm93SVcHc855IKYY7PMbg2xMovt5cjlO+kpZZbxRGcykUB9Q31UwSb
	 gMacyMlCrKZzkxqPvZ7jV81qxp5yNGckArdPEQA37LVS+arLvM/3it+qBH8j/SzlaL
	 ohVRUsYgAsdzg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	ojeda@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: FAILED: patch "[PATCH] rust: allow `clippy::as_underscore` in the generated bindings" failed to apply to 6.12-stable tree
Date: Fri, 18 Sep 2026 15:45:43 -0400
Message-ID: <2026-09-18-daily-reply-0016-re-rust-clippy-as-underscore@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a94a954d-3776-4e56-9a51-f6efaeec5036@nvidia.com>
References: <a94a954d-3776-4e56-9a51-f6efaeec5036@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please drop it from 6.12.y instead of backporting it. It would be a
> no-op there, and my Cc: stable line was too broad.

Dropped, nothing is queued for 6.12.y.

-- 
Thanks,
Sasha
