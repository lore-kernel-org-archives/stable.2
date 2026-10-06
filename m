Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696523D4138
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322586; cv=none; b=DdKdFzYTf4J4TCQfAo/vIhdzf/Bli4jUqXnE7rxk4LR3ruD3LsZ8V9GLx/SmhJOdelcLeasXBKb7ymq38BN5vTfWKNEzYwz0gxGvuBZwjGtQsOpY4Wpq1zZazxj4MKCHAAG25YrHMb0kWJmKvlddNZwKLfuHdztCiUfu0IKiucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322586; c=relaxed/simple;
	bh=Xohk6/0lM9xHwNdrWD6sqmB9kQ3V1dtrkZ7tu5H7TqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd9r6sIrhuybipyJVd65B/3VIZgoIcsAJR5TUQ8zcIDdRdW69CrnMtxhb+N9cEhRvetJBMGrR/lju3auTt7+V8nlRdOuMFQow7fZXtrJzM/tqIX94/20clZkAEDuFteJapQOeevKhBF7Rm0oPwBjJFOfS6mPea4Lh40dEsGUHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhfzQGYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhfzQGYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2DC1F0089C;
	Tue,  6 Oct 2026 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322585;
	bh=52mtRDWtjj8A1og3L1590qS45vXHxOJZz4TwdVaDlmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OhfzQGYUL4/+kUkmwW80Uob3+Vxywq6DUlrF9LE6+0fPP2fVdIl1auIsPNbgRVcym
	 V/fOwI9OpsVMdfaK2eTFD7KqclsnfkZ5RvSlYw2+34cml9zbF1E8BTgmpfdGVH3wa6
	 DuVMMx2X1s7Kh2tEpx5FU4Zz4KtvpuLN2kBMAdBEw5u4h3NQdHjwqMf3iI2UuAS1Jy
	 Iw7rJc9hhxgzO2Vzcp7Sx/oeu5V0q8TY1m7B+PaLZXv+IG+nmUcgFc8Pw1FSUVRy/p
	 QwtgDLp3fpabZj8Ma2Hr0dfz3y1v/lom5B6sZfQ+HwAr0Upwf+v5b5ycHxjSX60WRP
	 Rtaujd+7stG3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Please consider these upstream CVE fixes for 5.10.y through 6.18.y
Date: Tue,  6 Oct 2026 17:35:42 -0400
Message-ID: <2026-10-06-1-daily-reply-0010-cve-fixes-5.10-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006042448.93194-1-artem@trailofbits.com>
References: <20261006042448.93194-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please queue each commit for the stable series shown?

Queued all of them. The SUNRPC fix went into 6.6, 6.1, 5.15 and 5.10
together with its prerequisite 5e9a94539b1e ("SUNRPC: fix
gssx_dec_option_array error path bugs"), which was missing from the list.

-- 
Thanks,
Sasha
