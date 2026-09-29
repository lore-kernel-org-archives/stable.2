Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C343D649C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704008; cv=none; b=tyII12MyJtOg8UNszeXfltks260tquJ5ZuT0F0U/VziWgwWEWfUwzMBWkfEdQoiTNvVzKdD0kToGN6omLgdBkukzMuFyAQrGnChZXMj3sJI7KnZ+cI6LWUmrOg4nglvVLzUn9qPMjPNnYDx1yZ25XNcVSIYWQRiTzUV9isHrnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704008; c=relaxed/simple;
	bh=GTKdDpjuAhtqeHrtNcU1GNTB4yw4w8g4AUbpcCZmp3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpKwjOHPAXcxxklbB/oVkrhGXYZYtMPcqmo+LK8AIs0UQBIoYYCx6bWQXMJawwcQ9v9m3ZWQ8jU3ofHDBUkFiAVmhZZ1RBRhUbJ7+RymhLX97cOFYSUGVd0OqRZ+4Yyp93oSCO6Rt2xV3HCTehrTfz2dGdsUYCTzAIMQNDCiQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeEG/fp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeEG/fp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517C81F000FF;
	Tue, 29 Sep 2026 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704007;
	bh=Xll6AlSDGHYb+429eVMFp9iT/vRXY532IwdpEBqBdGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MeEG/fp0Xq/HQNUOovpyivuBkhNj9HXfLz6rSqtAedqJ1e5tu+7ZmXOPDrbGEP1aJ
	 w7+03fE8un37GrSPlzGBdtDNtovk4afch9T4poGKc3jBhuq8oCpShmF08+jxyUuM3r
	 +4hF8x4qwoW/jcG+9Lb3wyGelknJRJv3mSjspQuvM1hPTSsiiIztxG80o2BEF1I6Ar
	 2oNaKHyy4qYHUhPvH1BWqnwUxgWRDimzzESRGJ3H9YErSDI/t9fMyqCo8/LsFM/76C
	 U8Njt1QiJq68X5WCIqsfILqDV4fKaKvwRmGNymod4lcCGUKpe1fGNRWEMELlVvV4Ee
	 uhNFejofoavmw==
From: SJ Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SJ Park <sj@kernel.org>,
	aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: allow esz to be set to zero" failed to apply to 6.18-stable tree
Date: Tue, 29 Sep 2026 10:46:43 -0700
Message-ID: <20260929174643.9280-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026092900-avenue-magnetize-e7a6@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 10:28:00 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Thank you for this notice!

> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 90179da203ba8b708c84a12a07cd44be0f346334
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092900-avenue-magnetize-e7a6@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

I resubmitted the patch as a part of another series:
https://lore.kernel.org/20260929174456.9251-1-sj@kernel.org


Thanks,
SJ

[...]
