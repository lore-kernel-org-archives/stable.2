Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EB236453
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788058906; cv=none; b=oRohPbsECmDUOq8iu4zmXlHcdvKn5Nde7yaHpvclu0qMI95dbTIe6RDgOVeVKH6/OK8tGZTK0KUbfK8tKB19ADLp0adQqxgYVdsw9ghuPY3RBAL7MYN6Da6oCubGnz3jxs7rxMWqxT4Erg8QDDmPlexSt3ongGs1RMARM5/qY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788058906; c=relaxed/simple;
	bh=m2BVB4MJ88Vy0gkjyvczREqkuQiFu2EkOHsv9CxRG+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXAzR5RRSPKqPdv1T+ptOeDXiJoWUOw1pSXw+VcgGzkEmN4/MSKNSLe/fjoOv/FYrqPcCJ3VXWUp1iC/YauktwyUEzrAQmFqunQ9ucwKeh96PaaESs6I9xtTWR1om27c0EQuPZXiCXCZfFJun8PSEhccX6oF6uF0jkaylmX1R2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfE14dDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfE14dDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89441F00A3D;
	Sun, 30 Aug 2026 03:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788058905;
	bh=3qQ2nz2S/ZtXLXjjc96B1x29Nvj889xRv2LJdtUlT30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hfE14dDJ2FSSynYeYG7CzJF2Vu17tDpXaqjXcpo1nkuG2/398WaqUHFwjAEhmbGTW
	 xrGk4myVnyn1ccCsZ6JcP8M8+5guMBY+JkOslQpnLPVD+DOZllhVBTzVSaUS1zPm5D
	 ++UyD8hNlC+D9KSUTOtZE9M8mpLoQgUiEzF67JpsiAfIyKDnJhSbq78q+Vuzh2CvUI
	 TrfaUvEZ9OFJZCTJ3mrw8cKukwr/8nRpW4Ee49HxSCAP+BzoAeY9ZPiXB4alECAkj+
	 1uxqGV40KcfJh7r3qXbD2UnYKIb3qlVTtauB4GweNWnU1s8HM4sYLkuj6NhoC4ay8L
	 FIU+zZXrft2GQ==
From: Sasha Levin <sashal@kernel.org>
To: Kyle Zeng <kylebot@openai.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Backporting fa091f46c383 ("perf: Reject exited events as group leaders") to 6.12.y and 6.6.y?
Date: Sat, 29 Aug 2026 22:56:42 -0400
Message-ID: <20260829-stable-daily-0002-perf-exited-group-leader@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apHjKRQq5V_c7ubA@eldamar.lan>
References: <apHjKRQq5V_c7ubA@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 28, 2026 at 09:36:09PM +0200, Salvatore Bonaccorso wrote:
> Do you have a chance to backport the changes as well to 6.12.y and
> 6.6.y versions? The commit won't be possible to cherry-pick as it is
> to those versions.

Queued for 6.12 and 6.6, thanks.

I made two changes on both trees: PERF_EVENT_STATE_REVOKED does not exist
there, so the group leader check is added rather than folded into an existing
test (the remaining states make it equivalent I think), and the new error path
goes to err_group_fd rather than err_fd.

-- 
Thanks,
Sasha
