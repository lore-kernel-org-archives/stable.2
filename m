Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C25226B8
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789760756; cv=none; b=O1jLx6OITYcEosmTvESCNczjDM7T+sfrHoAWaSdmIbmUvHwaGKdNywackdTTod8Htk0fKg6PA/lfaEB7C7MUmuZa8gqrr+ysXLWZuEz0gooPRakfsIzRd1NtbVyYL0DRi9/4AX9wkijcLXIBZ7TBsWOmv21O/qzhx7Mx5AaUOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789760756; c=relaxed/simple;
	bh=+j9/3qwiuLU6MX5gZwD0+2LLhSgHIRVjmnLqWLEGilw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoCPZ74TYuDm3flGFE5MXm4KiKm5LBkJEejV0zV2Evdm2pHeEV5o//pbxqUdjWktVJj5UKgA3YLqSgH4Lf4QniozHNAkz3OLSouXA7YEg0JCymt26CwEbyMr7gzLfA3VgwwaGxXBSNiEIKR9kktNYTDokF0Cf5+GZ6wSqtQPtl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjhLlFXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjhLlFXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2902B1F0089A;
	Fri, 18 Sep 2026 19:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789760752;
	bh=MW39y4sM1OYB3gKFGl1oxaIx41KdkTvER+VR4gCnmrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjhLlFXT+v0L9ub9UffRfGMrKDBFA6K2q5r6/UKJL3Cs3nDbIyIk/Xd9/ezyAY9Fw
	 vTpI5fRMEEHAz0yO8GSVccjc/SjFjKUVuDpf0l4cy8QKp574yKKzwcPRMbmSKxOHuj
	 JsW+cr6+NSkuhfjEn7jaif+qZSSIvg+VWWXMO6lWxIMGYK3msNkRLfDl0ZbrhALaSL
	 bcWQ1DfLL3Y+/NHQ05jc3JefIKlu+MBBHOI+QDH1/SVsvmF56SclP2B985hjRj89po
	 PleQ9MZwJ/fx3/pFYRRCpQAaVCCKOj3YrIeP0vnYcjGx1Imrtc1IhDGGLHklMB6ZtO
	 ktGuSCWWnV3nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: Re: [PATCH 6.12.y] selftests/landlock: Add tests for whiteout object creation
Date: Fri, 18 Sep 2026 15:45:32 -0400
Message-ID: <2026-09-18-daily-reply-0005-re-landlock-whiteout-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9d9d688e5b0a3d488827052eec9afea25206cfec.1789655724.git.mic@digikod.net>
References: <9d9d688e5b0a3d488827052eec9afea25206cfec.1789655724.git.mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [mic: Backport: adapt the tests to the older filesystem fixture and
> ruleset helper]

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
