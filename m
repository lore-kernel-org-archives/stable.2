Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461F2EC0A2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941247; cv=none; b=pacd3KsuS/W8Nm6IVEdcw3kq5IzzWNqXYta3V6vVpy3oBMDC3LrOQf4dq4+qmUlb6sC8o2T5aJHwnF10d+mpy7//+PqC//nZwfunRGUwK9wcLsh5C6VaakGUwVlLN4JkyylT9A8N2AF6EcWNrEtv126SEoKDSLDK+CxsvhCuQu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941247; c=relaxed/simple;
	bh=yes3wTJWurFHdhqD4OoPf1og8i9pt9ZVwKgmA40y/3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUeCe1/a9fHC/MAvDN5LVTM8SRktFLBleiGI04bkAAlvK+Rz24v1ek532yOWozVNldhs0Q2u1ss6YMTl+1DY/p+QxrPW6FLc4kQXE/37kr6IPNRBCdlzpceztSVA70A2+DSXaslbxDqoTqAtu/SPkQHoTWP8H8DAclSJn7Qimdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2QQkvve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2QQkvve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269101F0089D;
	Wed, 14 Oct 2026 01:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941245;
	bh=iavnYH8xS2Rd07WfRJM57FU2/6+RalVoh2519JR26IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A2QQkvvewJuXjShuD2tRp08H8c6zSY7WZtbG7atLFuWbl8bTs+C0Tw4kZu7fKgyzh
	 usWxcuOQZBp/pFTj3X3/odv+cc37DgIYElwRSCXf978NiQn0itYt5FQfqZMbloFO9w
	 RXnIH5Obe9zyHV74TYcg17GNVzZbRO7Lrl9QsJX2J7iwpUAL3sM+MyxU4LoFZVvAOw
	 eEqTV3XBT9ZQuevcu3L/Hfw8boIhSq/4lEWJeo+jOAyZhF8ZLmZc4cszlXU3u6Su4I
	 pfrBv9MVOMrWa+F0Wr/NVDsmbb3Y1phIR3aTPKMWG+KEVt1FDclQu8ChndGV/pbubP
	 AXmvynqHU8w5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ezrak1e <ezrakiez@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Srikanth C S <srikanth.c.s@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 6.6.y,6.1.y] dlm: validate length in dlm_search_rsb_tree
Date: Tue, 13 Oct 2026 21:26:55 -0400
Message-ID: <2026-10-13-1-daily-reply-0004-dlm-validate-length-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012155942.703925-1-harshit.m.mogalapalli@oracle.com>
References: <20261012155942.703925-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Add length validation to prevent potential buffer overflow.

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
