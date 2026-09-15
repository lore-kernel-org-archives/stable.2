Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE13D1CB2
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437833; cv=none; b=nH2EC1lXkQt7/0Jv06u8k7TtqWrnQfsrk35c82U3IHwGyEjE2ksuzxZ05/fYEDJ0Etqk1CoK7QqPGdD/wkDJ9s0NAbgFVCsAougIC6iXs4tj+rMa0HDUkOp12jbI74SSFuSlTyBhqr0WGY7dJCSYRIgh+NE25SaOOOXW8RMOcjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437833; c=relaxed/simple;
	bh=6SOSDJARdn7Zxwkvof1SmyRbj0gcSv4s65obQiNGeKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBuJ3kXnMR6VXwK3gUBQ6K6PEizhRTR211LZHTT7wWIVaokEl/i2aQDSYGIABgMrDbAd+w1dnDJgKSnpF9w3ZIFciBAWtNq24QcYuIDFmzATxqqIYmp7OY7jhyPwt3JKF3cn6/JoLy+AHsaRGNMkLW6v98fd8xi7nAPzAV0+S2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV+uJjgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV+uJjgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84B81F00899;
	Tue, 15 Sep 2026 02:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437831;
	bh=pYBHArjipanoJFDU0odTbSkMq/EW+3olvPzTKBwHc6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OV+uJjgm7h6RpaP/YYeSVHokhCyHJmbPVpgsu9S2Q+AEMmbnaj9uKBF/ksSD2Xu1C
	 h+ulm+zLhQwtFslZseqsWVxwcUZCZ72OMloz84Lo6zS8n3NglVtXTNxwx23lr3mzd1
	 p+U6pORhbGyvY0T+FU0VwUfL1Targcp+CDSkK6E41SA6CktlSpMl3JFmwD9xREkWeB
	 avWr7WTNsbticmd3YwqjlJUH/rvbQyZewq9H0p4zo3sCf3n4J0G6bRazIPtJVCrzXf
	 YH7P132LH8HiASTcO4HsT20hZUoWbLIDiR+s+kQ+AJknakvIOhEuClr4tKhA9I0zPJ
	 yE8ppPH0/Vb5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Vlatko Kosturjak <kost@linux.hr>
Subject: Re: [PATCH] ppp_async: drop the errored frame instead of resetting its headroom
Date: Mon, 14 Sep 2026 22:03:28 -0400
Message-ID: <daily-reply-0012-re-ppp-async-errored-frame@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aqeYOh8P7EfhggfP@griffin.linux.hr>
References: <aqeYOh8P7EfhggfP@griffin.linux.hr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please backport commit 8dc5d98a16fa ("ppp_async: drop the errored frame instead of resetting its headroom") to the currently supported stable kernels.

Queued for 7.2, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
