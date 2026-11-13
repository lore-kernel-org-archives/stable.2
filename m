Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537228;
	b=S2gRKiju/VCIqIs1fzSuOrRV5j2hvT3bPjIx0qNenyh7szbd7zDbk1hjO1dU+54gYGfQ
	 RggEUgZfRFYnnY2ePVryHMG8kC1DZ+Bg5q91gAFnowLbPcw5r/5IIeru7v4iPYTzG0OJy
	 MtBrsjobDI1CWkBOECx8jM7VLxNLzUBdKkBuwDZsIkCznkD7n3SI2LyOaMaHY5O3v1404
	 NjPBXIy5nmP1HVr/Z4+EZ8VNIIMDBVoNVmLjfqudmlrNDdNoGyNTdihYcZ2D+qoO4PkRX
	 uHGM2fFm46J4efEK3q18iGPp8GVEd3ojovkQdXLHnSL22R+8/QcakhfdO5aa9DjMwww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537228;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/zmuBhAt310aaxOB4lDjwkOq9pvXWGN5LQqOodXADsU=;
	b=1yV87OYhqaJceMC51zEiP0uytavko2n4quvOHn0uMw9lyXqb/iMbtHHXE24Y1GQ2WNtc
	 0cseNvnQY2SFnGCPlJXh8n3KvAN1uwOgm8Y12w0CVy3RCeDgcQJIZ3O43ta5UzPIncUJW
	 7tNwvpyIEYxGx6tlTE8/QTL+Y3pCTbKoQTPa58kX/Z06WEdVI2W7l/SwNEcmHq02m9H5V
	 mzE69vZTvM2FdI98pBNzB41nrL8QLBAt2kukXIA6VpmFdGPnJMuaiKS+pqErR1/GRF+5E
	 t9KYUBK4jhiVUC77gmHbSL/UPqZemMFljykf8jEf9syiftSwXPu4rJ3YK0v2rMZZ9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdfonqN0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE4606A8B6
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdfonqN0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6F31F000C5;
	Fri, 13 Nov 2026 02:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537228;
	bh=/zmuBhAt310aaxOB4lDjwkOq9pvXWGN5LQqOodXADsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZdfonqN0RmHcYM80uCvTtq6k2KKyWw7lHX8iulC490POJuV45U2dCkzvV7KB+z7rG
	 xeafOITTdIOeJVTBiMjV0xcYnB6heMH2zmKkvxkVbVxOkSN7E433E96Lpdt92nsurK
	 72cj5viXw4JVxV/J0qv4CdiXSmFSQ18OZ6XZRGtiHcA88c6cZvyn80ugimVLqk56U7
	 PZeDKdhr7Q/iwW14AAeQm2X0FVXxgo8y0io70B9d21lL05yuLALclOvFE+Xpo39QEn
	 DiP1yQro5bYWhq2ksFtxo9Ez2UBOuFTKZsmQblomZOAaUjC74I+ESBXOQMp0SQS35E
	 wqLG7tf7cyUNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Gregory Price <gourry@gourry.net>,
	Matthew Wilcox <willy@infradead.org>,
	Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH 6.12.y] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
Date: Thu, 12 Nov 2026 21:33:27 -0500
Message-ID: <daily-reply-2026-11-12-8298852871@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112083705.6165-1-dennylin0707@gmail.com>
References: <20261112083705.6165-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-12, Hungyu Lin wrote:
> [PATCH 6.12.y] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
> The ratios used by __wb_calc_thresh() are scaled to parts per million, but
> the threshold and ratio operands are unsigned long.  On 32-bit kernels,
> their multiplication can wrap before the result is assigned to u64.

Queued for 6.12 and 6.6, thanks.


-- 
Thanks,
Sasha
