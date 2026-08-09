Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2455337E2ED
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786245925; cv=none; b=CKkpXpQy3CV3ScHrepO8FgV2qm4SXASCGMoqsv3fuP9jWIIDRFXFHoRldA5YgjmTddoBg/pME/UxcfwA7+Km8ZkTpUp9JXCXmWkhw3wGH4jQOJAK4ECNQ1I9kQ0hzNV+M6/AroOjCfEoWFMSDWR4CpY43mYC6TE1KDhC0Vqz18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786245925; c=relaxed/simple;
	bh=2xrnGlGGQiB/BpILu3NzHYL2aD88g6NlhIuCkrOPNoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC9s8BMOXeay//Kobg0mmgVqm3fV5lEPFDGl/IjCrGxXjTzMKWWFxoPtFDtGFs3/5i6G19n6Z+9dQ2cJ5b9tYrJx1xzyQO3ZFvy5BPw1rF3NYcOGSnhOt6QxstO43HaWz83/RbyGUBd1w1Q9nX5UK/shAex1OWUK6yRCJ6T9+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8NcG38Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8NcG38Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801EA1F00A3D;
	Sun,  9 Aug 2026 03:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786245924;
	bh=eMkEGRFOndY6gSWwQ2wR61SLrhAOTfjh+WjsLZa69a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8NcG38Q366g2TZkXvyy8BmQj7/vmk5+sX7r6NtUq0uzLd14P6yYAa1u5WxoOLgO8
	 FAlaJGCz+jAU2wWCTKaAmIt0CJF1aX5sntbRZcNroHUs9BFvcB4UzBSkQFM5+lEM70
	 iZRsqwQB/uqanb4TWPaJzZ283SP9uglXNDfY99KDCxoNkopE+q9zCjEyShgovD/fUz
	 6ms3w6mf4HrZ871fzGbMI2WmzcC6GK0eo72WAve7fgHDqYAJiZgoGh7QuOrMI8U8na
	 14z3kRhBMjtQsgq18C7yWrV7rG1kOi7FybrTJwInbjYlmX5n53lZhR7X5fpmP0i5Hy
	 /vmXRYeNZbvag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	alifm@linux.ibm.com
Subject: Re: [PATCH stable 6.12 0/3] s390 KVM PCI backports for 6.12
Date: Sat,  8 Aug 2026 23:25:17 -0400
Message-ID: <20260808221923.stable-0003-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807174551.2359-1-alifm@linux.ibm.com>
References: <20260807174551.2359-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 07, 2026 at 10:45:47AM -0700, Farhan Ali wrote:
>This patchset backports the failed commits to stable-6.12. I have resolved
>the merge conflicts and tested them on s390.

Thanks for the quick respin, but this doesn't seem to apply to the current 6.12
tree?

-- 
Thanks,
Sasha
