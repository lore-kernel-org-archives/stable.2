Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD03C454F
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701623; cv=none; b=hFN9VsjdP0uM89bsZdeQkZyzuV5UFDNP+Jlq8Wf1a34Ydd7yPYfbRQzRhpnrc8ku+Jb4FmqPZd3h47b68suTyQMTIsOflQDwIRsd5D/9saY3751Fp0FFYX3e5cFBSYZ3iumRtJQZUjUndpt1mD8r8E68ZtXJLEtEQfniHMqyDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701623; c=relaxed/simple;
	bh=F0NAPv5F8MSFhUrd00I6xi3dT0bjpu4hgB0LbVoUrLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxerT356qwT/+Bi+i+QFLHVoOqQ0VaXNRj7samrsTLhWxMpVHZAOoFPHKnRl8ea0k7gcOwbONLCEkJ7t5SNX6geA+uK+vA+O0TZq6xLFJc0qZdt7nGc2RTFCNdyBg9r/YZ052Af4Hnf6uBNkiP2klQu+rcDTqbCU2Hj5J4dixG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAhG13O6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAhG13O6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D0E1F00A3A;
	Sun,  6 Sep 2026 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701620;
	bh=RbVOAEJCILL3VKl2JOYpuSe37VgoX9pmshhCgrzruRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TAhG13O6xl1JOFLuvwPGPa3o2VA9irpBwjlZpwdxC9qUDaI7r/494VFvnfoyhj//l
	 Pn0TRXCLt8eCUcmeINHc/jypRMvukoZ5LRH6KAKzxhu1MLE5gbZLmwtmK1HS/QQ++L
	 Uvq4EczgeFuzZvc5JSv7Rvb9FUCZzh5XCGdYR6Dau2S7+RVLYBDgx8E+QDlQu2qf1G
	 YDRehmNbqluDCTB+KuxwZNxXKcOAtNgKRP2rJ6UX1iECpXAx2aRg+Kw0jbV2zgyHXG
	 VDiVQKDhqEOg7LeBCxLW5n7EZgvpd3U6NT84mLcqtnpxE1Ha2BBH7d9cP45T0rSxCg
	 cCJfQji2bb+ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH 5.10.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Sun,  6 Sep 2026 09:32:46 -0400
Message-ID: <2026-09-05-daily-reply-0016-ovs-ct-limit-uaf-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904094826.1817930-1-i.maximets@ovn.org>
References: <20260904094826.1817930-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The patch doesn't apply well without the previous kernel-doc fix.
> It seems cleaner to backport both instead of modifying the main patch.
>
> Ilya Maximets (1):
>   net: openvswitch: fix kernel-doc warnings in internal headers
>
> Yuqi Xu (1):

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
