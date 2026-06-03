Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD053D410D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499678; cv=none; b=L6FJ1g8AD8TTXXZx/+RBAV5XfyBScetNUHWhpbnVPLqCEduYfFUcITZPWqYR0hcrLv1VoqFvwihHV9q58BuunGdlu8ZMpRSHwgVW8UHfdcXbk8anniN3F4B9zggLMwqWLKJVGf51MI1hfrkbpl0ygcuy2PsjRa2avBOTuUK/UmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499678; c=relaxed/simple;
	bh=sSg1Bp2Q7gxa9Rm/Bu/ydi2z7TgHKY4GL1qs4g3TuNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqnP0LotTCwlIERu598YXyLMXPsgPEJj+SAKAkAVKeyCbX1xg+jC2qYaMn+5zoixGlCTafR7HaPJm77LDpTVCukIPIiubuVs7Ex8RpiDXBBxTCyoyBkBXieNlWlDBGJ/pB0QaC/Xs/6/IQZV3XxXsegq77jqPAM2Atgos4h2v6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Snen5FJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Snen5FJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0781F00898;
	Wed,  3 Jun 2026 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499677;
	bh=pX7WEF6IeTgp1VCOrtgpExlDWue20UoEpxE6XPci39M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Snen5FJ5TNL8aH8mqDXjJAMZbqeygtD2pIWtHoPymy8fbNYpZFZG8hSqC7aI2efUd
	 JwjLJ7Cj9LJjN/nPQqjyvTVmxvvPb/Jc0L0CKcm9hverCCHG+cIaANHDZNwS9A3c6x
	 6Iv2QMBuhRIAW+Ok+m8FtWy66sY/g6A7wKDwEOP8Ch0C+3PdiIKwE+Lf0JMwn8QP6p
	 RzDFRPaXCWoCHsP1lh+TaUvd1WIeJrKJgHPVwtXv7XZGdpYbXtIMc6BOtAdk+rXJP6
	 CohRnmYFGiqRruuqL5LQE39Yp977NL2fJXSqMPKE7ohxY3s01uOP4o55WLcmqY33Zt
	 LN6Q4bMEH05kQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Aleksei Oladko <aleksey.oladko@virtuozzo.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH 5.10] selftests: forwarding: lib: Add helpers for checksum handling
Date: Wed,  3 Jun 2026 11:14:02 -0400
Message-ID: <20260603111500.item006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ahgnK2FarjRafL_J@decadent.org.uk>
References: <ahgnK2FarjRafL_J@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha
