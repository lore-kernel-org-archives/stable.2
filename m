Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0B438033
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790032; cv=none; b=uyk8USECUgmpdNbvyItJG0SarfQTHlxKLS6pzr70OFsGNxQwbFYDjFn8vCNApzgTlAeaNOdUx+RK02M1Mq/76JP28dWzDscNL3rnB2ZRHOS4y22p31FUQTQN7cS3QC+AotZQRWt5GN9btBdVJAPda36UjVUGDiJ5dC4ECisblS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790032; c=relaxed/simple;
	bh=YAwG/uHJqGSVpFL6qGH3+z4PyuiglyME5nmxIRePbI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcYN+0o3l2ALOtRiHSPTupLCzlkiqkpA65EYQu4kCn9aGrAIv4Fz4QUpHu+yfMQmUiX7tY4Fmjdu9Dl+9ZdsaAXbkZneUJUvQM1sCtAHd8LFSE3K+MYi9tDi/tsRAKUb1qkbLIsrM8i4ciVgNVw0PYqj1N+not8NgGvbR53BDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdHR1l5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdHR1l5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425C91F00A3F;
	Mon,  3 Aug 2026 20:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790030;
	bh=UhKmumJRKPyxAGiDFKTZuGGKEElwdy3UdH9fvK389Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdHR1l5xErRDmDmHz756bXe500DJEJqwQNYpVHOaLb/Iqoy9bMD30Fi0wKlb4Ab0/
	 9imOvh81Wex//kkSMc5W5eYjIACF9Tr8621bzIT8vK5nDUvijHTuj1v3Fyp++EFoG6
	 ytjho3H8vMO+8uBLvWMWfSXl1TK5Sovt21b//UwPAyE9vZqd9niaDEj6zkVrtjDyQj
	 5nXK6Gm7ru4e7GaPtbNnQTvblQXWpposu4b75BG4AZr8i+wzzDhX7DbAOlI55CsyVL
	 ojCyBFGL0x4iASAVJpDjBPZakzCC0h+BO/Ywi2uxZNZKPzKgVvZArL2AQcz/4m+VfF
	 SongLJJK9iraQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	yi1tang.yang@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS conversion in read paths" failed to apply to 6.12-stable tree
Date: Mon,  3 Aug 2026 16:46:59 -0400
Message-ID: <20260803203507.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8ebae381-f1cc-4cd2-8afd-8508cf9cb217@kernel.dk>
References: <8ebae381-f1cc-4cd2-8afd-8508cf9cb217@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Aug 01, 2026 at 10:18:11PM -0600, Jens Axboe wrote:
> Right, this original email was superseded by the later ones. As long
> as the sent out patches got queued up, we should be fine.

They did - "io_uring/rw: fix missing ERESTARTSYS conversion in read
paths" is queued for 6.12 (and for 6.1 as well).

-- 
Thanks,
Sasha
