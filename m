Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C244F54E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125693; cv=none; b=Hb0PMAQ19Cd1s0e6DhqPoQUliPULVa1cTe9uOjy/P73DoXNFG1lp5yIkjVzhYd3WVhZrQbLfnCJyuSKv/vQFLy0xbjwQYFAUkvX8KpyDYOqjkvAoC7Nyn3Q7K8D2h8u+EX2iujGSNYJAyTjFxBtzOso1Yz/6yZD1dyQ/D+QmVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125693; c=relaxed/simple;
	bh=/EDma1Q0k7mvlphafIldRCkyRBLZtlLrncaPmf9OI8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryjxRy/xg4VJ2PKqcI2z1vfGxzQCJFJQZsmHX29umnFQwBWvxdmjPIx3scLOXvwL6qFbpR2ERamDo7a9QwJD4S8+sSwYFq0gVZ3Pc6KrdHL4oFg4cYiOJtZi4a4vxf9ZKxXZuSKQEe7STFIyXa7NDtxQGKHVWpDOk7qH6AwPLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5VaUGkl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5VaUGkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7B01F0089C;
	Fri, 11 Sep 2026 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125686;
	bh=EJ8uTiTBpkijfOyalSl+vI45fbb/dmtCwnM1Zc4fByQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A5VaUGklsfm1qX9cd24n2oqHQmC5UVQYa1n/VLcP51B/kwEu37Dci/O/A5iIdVbVh
	 8Tp68oqtQd38bUZ3cnqhl8PXmpMVBnoaXn30fmVvxfHrOU+BD5lQxap31DHqhCOYk8
	 1Gtgv+OX8HbY6GV07gaVb4HARdkGmFmVankukSxWVHTmzdC15KLhQurFY24hkndtIH
	 cid2PYZmN7WMyi6GqwSLXwtajiII5fzpoDZEOob4zG+na3yayfy9OnBKO0m7VEXFXz
	 Ap2JQfNBIXVd8GtGVLTKz5mNtSGKdHB7eXVfw1zqRX/LmVP+hbx2gxd39BdWJtzDm+
	 bkGAilQDI+r7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tze.yee.ng@altera.com
Subject: Re: [PATCH 5.10.y] firmware: stratix10-svc: Add mutex in stratix10 memory management
Date: Fri, 11 Sep 2026 07:20:47 -0400
Message-ID: <daily-reply-0028-re-stratix10-svc-mutex-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <893f8169cc68d614ee36efc9151cc60d0f82872e.1789009964.git.tze.yee.ng@altera.com>
References: <893f8169cc68d614ee36efc9151cc60d0f82872e.1789009964.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 85f96cbbbc67b59652b2c1ec394b8ddc0ddf1b0b ]
>
> Add mutex lock to stratix10_svc_allocate_memory and
> stratix10_svc_free_memory for thread safety.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
