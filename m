Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B503D410A
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384130; cv=none; b=VxieFGWLkO7nMnazDEcgxBooFyZeGzSC6/O5BPW9yJXPcw1zFmtTVGK3L26rpIw8I3lfSq+rYNiR6UQFFyF9RQU04qbglcUtKkuHrHWIJnMolL4pEhG5MGO2kBRXp9sYXlGk/ePnNawLDvKnweQT/tYuDFtuRSeW0fFcbBopNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384130; c=relaxed/simple;
	bh=oEas5vwhM7nTqg62I39OYDKKPhuAYO4RRmO1pIV3ySc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF3u+cWooUNbQJ5opGh+Md7Qf3XOSMbrgfcHcpxWC7sSlAa9WufjfUO2gwG1bh2Mbkwd2FsV8/0Ea5WOzwPZOy3yTGKdgFQUAT+lLhKopVUXEE6P7bxLiK646e+f24ISesHU8BZ4UbAUzrAutFsCSDiCJtNa9Gebsl0TMDcmyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAax/uja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAax/uja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C621F00AC4;
	Thu, 25 Jun 2026 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384129;
	bh=oEas5vwhM7nTqg62I39OYDKKPhuAYO4RRmO1pIV3ySc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WAax/ujaoAOU8fSeoeDCGSHurVOGZVoQISk/LA5vWj5vMlG4aBfAtBVX+n3CpoKMM
	 qd4sL5J60GZRfOIFBCWe5hIiOsYd3bMsnOwEyoRoJFCMAISDjA9dGQc7gHHIwIT9Sq
	 3ZOl7equws5+GXSFjqzpxnuo71FhTF8f8nTK0nTyWco9zCgpbZLn/7pMbtkQwC0+/6
	 hcDaZ4PlHiYEZwmfBYtDoNMlO/Wd+3GKBuSKDcmxhIK4/tBKEyC/nAZYO+/Jda34kH
	 cnGYy0b9A0K4Fmi6KjaFhM+O9MbW4yMq9Jay7oX4faZIg5/N7YC3j/5eFe7pt45ZMJ
	 aoT5w030B/Aew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.6 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Thu, 25 Jun 2026 06:41:52 -0400
Message-ID: <20260625054005.0005.bpf-kprobe-66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624072901.28197-1-shung-hsi.yu@suse.com>
References: <20260624072901.28197-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH stable 6.6 1/2] bpf: Reject sleepable kprobe_multi programs at
> attach time
> [PATCH stable 6.6 2/2] selftests/bpf: Add test to ensure kprobe_multi
> is not sleepable

Queued the 2-patch series for 6.6, thanks! The prog->aux->sleepable
adaptation is right for 6.6 - nice catch.

--
Thanks,
Sasha
