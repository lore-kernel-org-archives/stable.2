Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB405226B4
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760758; cv=none; b=mu8yFeARAr9pQO8TOyFGpdkr5e/BZXcRCBmSxhWrMD2xuYGCYS3iOWdqhQFXkV233CxBGlIsLrtjH8Jf53+RkD1pQ0IBjG6I2iZEeiEG9IbW+1CKyGp8M3wNTOdaF/FScU8GbD2FfQGXIw8pHdIdznmkpdYoFW09UGSXVYhNjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760758; c=relaxed/simple;
	bh=BKjGaPFkJq7Cq8gUlWKcniWnClzbREp2jjBs0wfyC1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u53ss2r8FOlEbSycuAHdDJFYA40GzWYwX8ltBzBBF/5dig+z5g9uErDinLO4GDoxf0DCcQqywvk0J7tXCjHRMGP2WJkOix34VYfhbaQV3eYcn5Q9WEtMl5jxbu1cmClkFvgWskVySJmmeOI0bObBSQ+77//dXz8+MtV/iSZYPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkKO1frX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkKO1frX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDE81F0089C;
	Fri, 18 Sep 2026 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760753;
	bh=kCmu6CAP8P6omJoN8fFtROxTwtwo9KcLnCymZAHrA2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DkKO1frXTiDADsnDT6WND4vk6fayZNogcDCv7UqOB6bqd/9cKcAXRwih9bZjwittA
	 Xv5jCxn2et70eiFoEVxwAY0Y0sJVlDytueAw9je7djdAAqi+/YJC+SpLFp9hXOLuiY
	 5HOOJWuvLrWnRmaoDtFw92mgp2BypWRc9kfXKXwLABjFtTOQ+bnBsV9+b7eyDCdZFN
	 HfH99pLzSjW2+bzBnD1ZDHnpC3j/PFdFc3vAF/rWxz6lew41mCmnCfAJCPMQdfw7uL
	 6mPORFb2cZa7U41z4Y13+21UqB3QxHHjvQx7D74JXaNKrIY8P9RLRA2gH2oy/vPfPh
	 9p4ujko/GyxvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: Re: [PATCH 6.6.y] selftests/landlock: Add tests for whiteout object creation
Date: Fri, 18 Sep 2026 15:45:33 -0400
Message-ID: <2026-09-18-daily-reply-0006-re-landlock-whiteout-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <520a1a9a0c6f14c19f1b962ea33adcf672bf6fdb.1789655724.git.mic@digikod.net>
References: <520a1a9a0c6f14c19f1b962ea33adcf672bf6fdb.1789655724.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [mic: Backport: adapt the tests to the older filesystem fixture and
> ruleset helper]

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
