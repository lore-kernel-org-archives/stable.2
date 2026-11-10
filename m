Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344406;
	b=rBbZxhoqfzywSxFCPao3oSwfEsFrfqA5jBjMLrOdhQyWZ2rkuA2Ku4L2hK0TNNbT/YoN
	 jxaDfHwEs97rg1GjdZQcK3XSvUZB181gU5e2RvnT6kzdmIQhH5ScstSP37AIXiMXblQ2W
	 zWF1GJtPP+q0HQ76Cj3ctJ1/8K+BLOk6QNQaJ5RTSihOxwrfNZIT4eJgVOJ324fSvbWdu
	 kdKLCOsFLqlDSJan6iksQuFsGUzxf5pAIEgI82Db4LsmYOL4ApctG11csX2S8tqALiA+5
	 P8tr1AbbdTOtR9g4h5bJG2hWNsm5BQpbCW71mfJQe2xNbFdKv5Tjkjbu9CzDwAk8QwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344406;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B7riTDJpu+xAusGR6ZhbtUA4hXaJQVQ5XK/yRyRnAdU=;
	b=u4KF1IG8F3aJ6brDDKOFRYhtojtXt/MYlIv0vhkoWwpgZHUWwhDtYRSBQgwlS3PgcQPB
	 U8x5lAjmNLrgwb683+6VlgiwLywPtDSbTlOl842eEj1XyZHcY/n2NaaSOlH5vYunfSs/d
	 DpULNlIlLB4UM8aN1jEPPS1bs6pVd8WywgKJEzUOriPsBWFzwseoL0ABCLwojO+pXwgbo
	 Qo4ciFolszLDfvgnDmnX8PVDzGw+p/i/SHheSqiRwAlf3yFdimO4QySAZf5mrP9KOkEul
	 ekdR83pS7x5pJYmcp1Th+sK5EggXtVMa/fXaJO2EXRjnQS14eiVwLuxezVBGINj1riA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2VNkFSs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42C606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y2VNkFSs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588E31F008A1;
	Tue, 10 Nov 2026 21:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344405;
	bh=B7riTDJpu+xAusGR6ZhbtUA4hXaJQVQ5XK/yRyRnAdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2VNkFSsPltfndXAAFlhCLAJGX/oXCxJtFtGmIAGmXvUEd978WmzohpEnehfEBHKV
	 zIiZbZ9o4GYQ0kqpIXFMT+qjI/zUxPt+XasU7fp7I9XglsJUwxaKzBFs2rVJ7enSqU
	 IjRgf5p9un5TIB7wXXtg176Dxub7I2SFVikS68xYVcx0h3LRHzpyegS5K6IsA+lp0/
	 ZyNFPHvpBenrSFh9T7ajCw9dR9/77iA+QWuu7xBx18JZijq+ST5XhWW0fpDls5gBdU
	 xPiV/7YeeoK6fEMiDhUy0itNO3dYMm98l9RvPhdwQHhfR4YriFCdm0ngq4fJuB4Ezx
	 gclviTIgYlPYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 6.12.y v2] apparmor: check accept index + 1 is in bounds
Date: Tue, 10 Nov 2026 15:59:30 -0500
Message-ID: <2026-11-10-1-daily-reply-0036-apparmor-accept-v3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110015643.469506-1-zhugl3@xiaopeng.com>
References: <20261110015643.469506-1-zhugl3@xiaopeng.com>
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

> apparmor: check accept index + 1 is in bounds

In v2 the index + 1 bound check sits in verify_dfa_accept_index(), which runs
for both rules->file->dfa and rules->policy->dfa. The file dfa has two perms
slots per state, so the check is right there, but the policy dfa has one slot
per state (accept[state] == state, table size == state_count), so its last
state always fails the new check and profiles with a policy dfa are rejected on
load.

Please limit the bound check to the file dfa and resend both trees (6.12 and
6.6).

-- 
Thanks,
Sasha
