Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137244;
	b=rKXSEfNcw1hyDpIjMIShAOkhXxOOYiraRNxS3vVEvrJoI6vkeAEBuEEC4uQ9Y8YUihgf
	 yxGIoveWDIVlyJzrdDjk6rxKau/VRjyioDNpNA4UvSwzwv4fvQswYmEhJq0TgMctzTEsE
	 ypYQNyFfQ+5aywuroDjHsh5SwTA557X7hNsG/YYndwFST265O4O6suR10/kPV1+WNMY2J
	 3t/4DnA4ngz6IXxxqnmXeshbcVkLncdD5H4KDDBEin5D3hmsY7jbn5STwNMU4ZUvmkSvE
	 HYryaRus8LR4lwBRA8IRsqBMWXzM/YlAKcByMvgplRrkhSbfFlW9sBBgVJD/Atp2Lxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137244;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=39bDoFX1gA+lloMmt3PCEuUNG+Qd1IFfvFhHaZ2GOI4=;
	b=qPLFCE2ro2aO1F7vC8YsRgRun9cs3TVPi9LEhh/U8T1M8PXBJZj1W8Y6YEbZVvuEjYuW
	 6OgVIG6q2Vp75TzvLu2O4D6xeWPXYM3aqgM6aLRcbp/nMbqWqoOVcJT/ZygfZ7J9v9o9W
	 JkOB16eyRfva6N3eyhpk/zE9gQ806q9RdBtuNlWqaj8fR0wOVvUWGwnVd0I8DKUEJdlSg
	 /+U3kDzHJRtQeg6kSAInTa57WmIFy65HI6BKUVyOcDxlOjZGeVA0KaoyxuqC8QGDuvKGh
	 vpVRzQ29bA0+X4bXUZUJNPJuwL56xq3UCHWBE7QjoShcWDgTu5IBFmmGGBIlmCLCxcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YQHef3Pr;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A0606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 11:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E85A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YQHef3Pr
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86BFA15A1;
	Sun,  8 Nov 2026 03:27:20 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83EC23F632;
	Sun,  8 Nov 2026 03:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794137243; bh=8qcQaLeHy3J2qDQ9LX1JMEuxjxs/y4QwWo9t8CrUkn0=;
	h=From:To:Cc:Subject:Date:From;
	b=YQHef3PrJ5+gsKpQkYkr7pg3QqmG/BYD/bu586Yp2W6YUpsBXxK8vrnqKCSBs4jBP
	 49opxfq7MbrLR4THerRjS6b3Up9X0MVHlnvik7s6f9AmY17hFObitRsloY5jwVP0r7
	 z5/HhkWyFlonsDAaihtcZ9gQ1ezGbfNMFf2IJTBQ=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	rafael.j.wysocki@intel.com,
	sumitg@nvidia.com
Subject: [PATCH 6.12 0/3] CPPC stable backports
Date: Sun,  8 Nov 2026 11:27:14 +0000
Message-Id: <20261108112717.2565915-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
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

Hi Sasha, Greg,

Please apply these CPPC backports to 6.12.y.

Base: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e (linux-6.12.y)

The final series passed plain git am onto this base, affected-code builds,
full native builds and boot/runtime tests on AMD Ryzen 5 7430U and Orion
arm64. Runtime coverage included FFH validation, feedback counters,
governor and limit writes, and CPU hotplug. Extracted-function tests
covered malformed fields and error paths.

Christian

Christian Loehle (3):
  ACPI: CPPC: Validate FFH register fields before hardware access
  ACPI: CPPC: Propagate errors from cross-CPU FFH calls
  ACPI: CPPC: Accept requests to retain immutable autonomous selection
