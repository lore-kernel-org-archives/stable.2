Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C1503902;
	Mon, 28 Sep 2026 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635163; cv=none; b=p94FDp5dfxJx/XOFnuUMXRYAwMbGdr9r0Ovf/2wz4v/ZyS3BdQ1I5tKGuUWwskegxxk4xzt01OtARl9RVGVrHmX8EMKi3qxb0rcsaslQ2PkEtXb7SN4WLSq90E949HitrRKeJdG9FidNuCRAZpNGLJeXaLyttWGMtk4dWhAA3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635163; c=relaxed/simple;
	bh=1XJyeLQmth8y2Pue8ALK5isM/2Ana+M/J4FUGmX3VRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyskPnNbW7UFU2AEZJx/QqM8isWuO1Mr2R6JrLiKBCKV9dvj8qIdsoZ51WpC5hMvFhWyCAJwnC+ArkamtuWJbHgaFILIyRU2qXwotziiNroOo9vfcYerho7gTo+9T9AwjyFdx46XkXW9DYMXkQNuhy80lbWLdsVRl1rof72zbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbf3WGwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbf3WGwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9921F000FF;
	Mon, 28 Sep 2026 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635161;
	bh=yZVWLq10QP6ozzOGLEiOzZHrsDG3MWGDn12hp7nFEyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jbf3WGwT4gjsrZyd6WMg6L6kxTClEshwP7xzwtYR9LZYlFUdNMuLvH45mzhqky2Au
	 7Y2vx2gc1483ffxELAGi5uCU4CRoEvlw8gL5S5Kce98HHvndxs+6K4WzWQM1FCfhFh
	 yr8vBSThsDqLlV/MR/LdO+42444ThoFuKQqKX1hS91PcUISZOqPbYF84nm6A1Glxd/
	 CwTzLdSarBIdWenr0FLGm+VMc7OUe3HY2Qg3LheMucGW0uqHiRjsy0hr63zJQd/JXL
	 tW0q+0DI/MqE0CGDK7QKSdS1i2L1Q5i9EBml7Sr5QfjHxeNQhAfp5iTM2aposRkZrd
	 E01N7QfXdR1aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rppt@kernel.org,
	sayalip@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v6.12.y] selftests/mm: hugepage-mremap: fix mapping alignment
Date: Mon, 28 Sep 2026 18:39:11 -0400
Message-ID: <2026-09-28-2-daily-reply-0007-re-hugepage-mremap-alignment-6-12-v3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928131117.231700-1-luizcap@redhat.com>
References: <20260928131117.231700-1-luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit a914785f6349da754e1226420bf4e51961956769 upstream.

a914785f6349 ("selftests/mm: hugetlb-mremap: add setup of HugeTLB pages") is
Mike's commit, but this patch has you as the author with only your
Signed-off-by. Could you send a v2 that keeps Mike as the author with his
Signed-off-by, followed by yours, or otherwise makes the provenance explicit?

The same applies to the 6.18.y v2.

-- 
Thanks,
Sasha
