Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107E2C08D0;
	Sun, 11 Oct 2026 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737321; cv=none; b=UblnttRsOQdEQOkjTWF2RAenMR9Kp5xQuGfZbpYXpYj6rZQWVfrDZfJBRIK8UiIeBlQr5rm9oBOCqqKk+Aj2Ig9bvbLUHjOJb545W4vASTnW0mnBuECfLT7MskpDAfxKl+pkbblm70BriU6cs8ZA/JDDjxg0qMr8ciAAz/zGJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737321; c=relaxed/simple;
	bh=aL7u223fnM/92IEMNmSK9wny5F7t6HQYyreBUkwGcKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7NUeGgWxecoMyeW5zv4gcqKwMAyz9wi+T2ctIO5Rqu9I3UrlAWISoCreIKWOXL/jWaoDy4eOap2dMOYIQCTMRAS70AltuVO2xA3j1a4V4jxTo3QG+OLj92H7NlpgOPlrkMIzwjZoSLQp9DwjLkelXSR8XFLR+mR7NJdikKgsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7oKMIxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7oKMIxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4DA1F0089C;
	Sun, 11 Oct 2026 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737319;
	bh=jW7ekHnfYentRy+iWHdDXOHQ3Lfex2DwvTOdYJea5T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7oKMIxqxgO1NvQDJIrgT1zfe9UA8DbPt+rRSPKi/kjXaC0yQgkRYbINZyH8E5YGu
	 xColnv/Sj2iYh/bMK/bhPy/ZBGyrIxLBXQJUyctXt7orq6MMrkc31fvvLGZ54URrt6
	 G0x6s1fZMJLJ4gSxjtE+jyEanGuDGpCKyGmGtMj4q1nThdi8Xct2tAG207SRA7YdaB
	 TPUqxolI8c6mVfOS/mS5edu61+emhri6udpTA1LqlW8oq1OAnmX1NzZjCv8C1NspTI
	 1dhE8lK2XD/9k4jB412KLynOOO8lgR8I5Q36nyG8sQ/ILSgmwvyV9tYWUhfkZWQANT
	 xN20NuSo9PoxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.6.y v3 0/2] mm/damon/core: fix last region handling of damos_skip_charged_regions()
Date: Sun, 11 Oct 2026 12:48:16 -0400
Message-ID: <2026-10-11-1-daily-reply-0009-damon-skip-charged-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134949.11507-1-sj@kernel.org>
References: <20261009134949.11507-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Patch 1 is a dependency of patch 2.  Without it, patch 2 introduces
> out-of-bounds memory access bug that was found by Sashiko.  Patch 2
> fixes a bug that categorized to be backported to stable@.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
