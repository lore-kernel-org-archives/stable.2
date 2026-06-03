Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFB3D75AD
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499690; cv=none; b=uzlFhzBMcgb5mXh/Z27KhYdjgQqc8M7wjy1eRWmHmYYh4EYIq/xZpCXU6DvN+RVtL3rO07mDwYEzOI3VoV1Fy9bVT8RkAEtS8LcPXc9EH8WZTTkrHB0ELj6vF7YAiMDheEmFWEDLSP9W9bN04QCvw4dX8L+ykzKdPoIxLp/oxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499690; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6p4tigViemewhCS88jJsN40gtW/hd0l3+LH41l6HX05SRuJXUhjpBY+fjCenoEqBddHsOJXRhCNDxMEZARGBHzFrldeL0ulTj3VVQFNZdy/9Fq8iTO3Nw4Lhx8+gtn17D7K7MSGEmYdrkAwHAKg0jAYBbsR0FDupYPR39oLGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOyfH2t3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOyfH2t3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421551F00898;
	Wed,  3 Jun 2026 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499689;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OOyfH2t3GtFlD8tGtYXrg5u/isMe8YGwmMQSQrDc78s1ZXc9bl/KBeA8cWyosk6wK
	 CUu/KZs1WrNqFjVSWf9uCYjQjGMYCXmO6Sbw616g3RKzdO+Rllq3yKgaR9WhL6xQe8
	 s2vCM1B1kXY4iHSzfiCNAffpAuxOicp2gs8W3XP8YS0mayshjefn41lKhaxne99F46
	 uHKf6N+SjEepDbT6UpsHogbkp1ArQNUqv8XRN9HeGS3ezE7IfP/hjSplamHIDwxFAV
	 zUEZrNLLomaKeZGhESOlUcuD7lPR6NlxbsxXqG1vvAWYFdAdnFfI4yvBxgQ9MqZZkF
	 cGPcI0nfikwZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tt: fix TOCTOU race for reported vlans
Date: Wed,  3 Jun 2026 11:14:14 -0400
Message-ID: <20260603111500.item040@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528205744.636746-1-sven@narfation.org>
References: <20260528205744.636746-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha
