Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00485335B3;
	Wed,  9 Sep 2026 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985621; cv=none; b=WxE4NPs5Tf4LBe9igLtAE64pQ1BRdkLmlsOzJUAUz8f/PEnpsZcLxTBGPVDvbRIX5oh9SWqSQZB0SfpEuqwFi7wc+AV+OrG8zVdKl44jAJjR6KcSlFf5bU+LeNSeyJCPgMfF62Vci977eI6WM8/Ebb3vVqAceqbo5XOpkeXZE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985621; c=relaxed/simple;
	bh=U2Zb8rfIDnsUY0SPtCGW7KHsUiNHNP8xh1KMypt0K0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6WIXODaEGFyJYSS3NaEUhlCif7WQh5CVtHIV3JVQLycP90nlzkXz5WnCtfmlgKC8NGU7dbeolZ1pJiBfYtzHXvK5qTfiOXvC5fongkU2DwaOwvbs8N4hZlMDy56alqTcpxsDkNQLkrSCdtoO5A+N9R3ibel4jN9q3QYmtJ95Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrCSYcbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrCSYcbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0DF1F0089A;
	Wed,  9 Sep 2026 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985619;
	bh=BVA9FdTupmEccpyVWrtS51+n6C9s1ARMcml10vV/MH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RrCSYcbTtg2dzak7AzzcHixLXT6x/XGRfQVQWVuuZ3x88DBTec8qeSVBYVUBKMtk6
	 IfVMtChW5HTgNmFug9qVWW324CvUD9mUD5/mpxq2IURpCI02Zi9Q43lPIdjqo2JfEq
	 wf2KpUuQbEUfcPStrqchJ0A7tAwJor2PnIU4G8iDsE55XASUeXD2AudcIslZhp84E/
	 QyQdNnu3SXIM/Sjqc8frUZ2aHLlJ0haT3A387TnCaDHYLH5Zq0SCPY2nam9JV0opew
	 p0sFLlz01ns7UJ6Z/o+zElP2WoGwher4X4YBJPS7X8wHWTmbmo+du7UaJIAB5XJG2I
	 tKhheCMOL5liA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Wed,  9 Sep 2026 16:26:24 -0400
Message-ID: <2026-09-09-daily-reply-0026-damon-merge-regions-test-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909033449.123677-1-sj@kernel.org>
References: <20260909033449.123677-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KUNIT_EXPECT_EQ() does not abort the execution of test code when the
> expectation is not met.  But damon_test_merge_regions_of() code after its
> initial KUNIT_EXPECT_EQ() call assumes the expectation is met.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
