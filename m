Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC6328B71;
	Fri,  2 Oct 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950806; cv=none; b=QPFU9dTte3zD+067bQGu2EEQ531iHsmd/OcSAOMSwyrbtltZxbs1Devs6TP2d6RZ8W5w9T4dI413ZUBOxmaWybMc2kgfyjN1a5mkSgb5ylVipw7vkj15nAdCiF28z6jBdlsz0idZPz1XQvnj0gjj5kCUm0lcDGomkpdwgy6RftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950806; c=relaxed/simple;
	bh=vFkaFbszM0SqxHUdGU7QWXFCxe1WlDMQ3kbQONzkGXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5Gy/KdQrBDPlovScUtKHzloSum35P0MKGElBBeqnHBFftq/vY/BA3sFUhopZEnMswEM4gEVNRyIbhwW3aghrWe47jitOJYq8h4BZdScMM5T6oqmOLEKghYc/ty/4jZT/uqVd8GFJ5PH28EnUCMfr9nP8/S4UCTilOovhAZnj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/PVuFH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/PVuFH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F5A1F00893;
	Fri,  2 Oct 2026 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950804;
	bh=PU19rFJLWWVDwOEvluSj5TNvz1m4UHOLOuxxcuen/H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k/PVuFH9HqzWVEgb16nZV0JZfgtgkYpM3rloa/vYJYUSvGiL2Em2fVPlh92lVpFeF
	 NUUCgHpF3JlrllGrBDDed8MxXoZADHRWU9IxOAJQOE0PNGbhrfebznzqu9RVe10/v3
	 ZpwCty8rHGl9BqQiEG5t3I2pqdlM2vPWDFm6ig2AG49TCGEP9nW3o3FiZ4LjMqyngy
	 Ozofhb6G4dr8sXmIgMssuv6vryfhIATuhurB/vJoX/4uMVV5fvxav5x7ITeUtGBIlZ
	 QrjPHM2cl7OARI8SJY6vdzIjSYpK/wk8JMN1h/fbg2rQoz+sVLt+vSyCPH0R7jSden
	 QpTNOPt+j7mgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	lei lu <llfamsec@gmail.com>,
	Nikita Nagornyi <nagornyi@amazon.de>
Subject: Re: [PATCH 6.1.y 1/4] fs/ntfs3: Add more checks in mi_enum_attr (part 2)
Date: Fri,  2 Oct 2026 10:19:48 -0400
Message-ID: <2026-10-01-1-daily-reply-0004-re-ntfs3-mi-enum-attr-6-1-p1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001114549.162469-2-nagornyi@amazon.de>
References: <20261001114549.162469-1-nagornyi@amazon.de> <20261001114549.162469-2-nagornyi@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Signed-off-by: Nikita Nagornyi <nagornyi@amazon.de>
> (cherry picked from commit a8f659ce14f8f734894227ba2c5ca78c8451501e)

This one is missing the upstream tag. In v2, please start the commit
message with:

  [ Upstream commit a8f659ce14f8f734894227ba2c5ca78c8451501e ]

-- 
Thanks,
Sasha
