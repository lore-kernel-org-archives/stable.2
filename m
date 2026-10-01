Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165053B3C01;
	Thu,  1 Oct 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862773; cv=none; b=T3UlSnA7T3SBU8rdDL7QQMDM7sx3d1WOvn6Mhks5klsxSc9c9q9vo933jlDWZexESW3pjaaEjef0MBjRX8qyrmzVj07N86vhRMjZTpYMzF5l9eQe9//wsc5v0xaSoVhVsVfNAgin6xhoyRZ7M+lUJMKG0vn1B0pFR3LzX3Cd8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862773; c=relaxed/simple;
	bh=c09gCXZZkFnebcOu1m94GIoqqZ40oMcxu7gcsI5x0jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQBweHWPCQAvR237QXIg2FmeYllwvRf8cplM/oXGrjT/voo/XNlg6p8nAeCtP8xYcyqoZ/GxRnqRD7s3TxIShp1wEwQxYDpCyA/Nxc1DfK6T/nPh8uODSJmWmR3DUiAD39DVPhS9MEIbYSgSWAnkICdccbuezXt6S+LF+bimCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M88lOybB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M88lOybB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162861F0089B;
	Thu,  1 Oct 2026 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790862769;
	bh=Q/dRH3J5ey76kvRdwTVhhOoQZVelrf6ajc/JT2v5uHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M88lOybB06xf6SoaMF1Ba5D8/68u9I54qfijfvr8ckFOjZLjRbMAic/Jow188uaaw
	 RJDaIZtAA0fPbQKnHDuglsYY4R/RG0/frYveBJdceecZ2C5ju/dolgQzXHnB3TYUeG
	 8ELBuRmkeXCNHGsXxqzX3Bmm/bseUFK7HYkgPXvDotLAyqmDlTehns/ENExDYck2hN
	 Gi5Frz5akCeEsPeq9nbElpEsB9Ywdj7o5ILuwp2rpeH9skX5xGMfoog+WapA3hfESR
	 l2dic5RGb+fbM2Z5iqJ2yFqLU/5t2+LfDLITCfFBCiVMZgjKvyqRR/MqKW+qED+P9m
	 KQq4NSijV9gxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rppt@kernel.org,
	sayalip@linux.ibm.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v6.18.y v2] selftests/mm: hugepage-mremap: fix mapping alignment
Date: Thu,  1 Oct 2026 09:52:21 -0400
Message-ID: <2026-09-30-1-daily-reply-0017-hugepage-mremap-draft-v3-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cd4c16d1-d23e-4321-8f2a-6754294b74b1@redhat.com>
References: <20260928130916.231112-1-luizcap@redhat.com> <2026-09-28-2-daily-reply-0006-re-hugepage-mremap-alignment-6-18-v3@kernel.org> <cd4c16d1-d23e-4321-8f2a-6754294b74b1@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> My intent was to explain what was being fixed and why and, as it's a
> partial backport, I decided to author the change. But I'm keeping Mike's
> original changelog & authorship now, can you review it before I post?
> Note that the subject will change as a result.

The draft looks good to me. Please post v3 for both 6.18.y and 6.12.y.

-- 
Thanks,
Sasha
