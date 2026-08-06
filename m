Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9D379979
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038603; cv=none; b=IV2tjx0w4dwCrKspnZLEtk4YttbfMGUkidbqqHu/Z1s4GQrZ5aok3VwzhXmCbfpCnVo3xrowV2kxAUItdOs8Z9MzJpJRtYLJJ8xsR659BRt40FlbwkVnpoS2WrGccwqIslQ4MAB55xN7gOi6/c2JzHPU8FaBrPV+1ho3yRHBs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038603; c=relaxed/simple;
	bh=mfrg87x/GPH8JkfabbPvmPn/b5jbzjScRA1244FKtsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhGUNGQEEOuum+F+1AHY9vIMAvpDiUky+QWC34LVt8xDMEdDa68TBzu6M/Rh6+UhzXXBRcOw3VA8o1qtqslP29EYMuw679xcHdVceLmOtKA6nZ69Ctdb8TTMXimoLJyUUJ/l85kkFqq8CdFGqXBmo/g3z9LZqJHq2Z/SXhxV/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVkKKcvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVkKKcvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9E11F00ACA;
	Thu,  6 Aug 2026 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038597;
	bh=YIPVivvXgCLBT/fMrDDrQQYUWKzkgM2YjC+LVV4cmlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aVkKKcvMDZ33nZHGcuOos+fxB2MPSrzy8nk0elAqcddlNeH+/qmE11LpNtXJvv7Y0
	 c2WqqvABTY8ADpzH6LpT2PmmLOKscqFtaoemOT61zkt25uuZHwk6cZRZahozHdxgJJ
	 lDNL4VsTJ7VgwuSquBGB2FWqws+Qtt8zgVTieNAnbLE4lyx5GkzYSeQbssqjdJkhet
	 /PBbCc3bbak7DzWqKKD7/9POzFgLP9cjVg4r3GhokWSJSA97cYfldL4q51v44eMWId
	 61XpL1+h6FIZ5NLKnupe/MTlKeHrfm9TQQhVUNx/DB+vkQlxry4UQrOLWjfyYJW7lu
	 PB0n2tkTBAu9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	tze.yee.ng@altera.com
Subject: Re: [PATCH 6.1.y] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Thu,  6 Aug 2026 13:49:41 -0400
Message-ID: <20260806131003.stable-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d8815b4e8e836313ab8af55d7f897fce5e83e894.1786011370.git.tze.yee.ng@altera.com>
References: <d8815b4e8e836313ab8af55d7f897fce5e83e894.1786011370.git.tze.yee.ng@altera.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 03:18:07AM -0700, Tze Yee Ng wrote:
> Fix a memory leak when gen_pool_alloc() fails by freeing pmem on the error
> path. Switch pmem allocation from devm_kzalloc() to kzalloc() with
> explicit kfree() in the free path to match its list-managed lifetime.
> Remove the erroneous list_del(&svc_data_mem) which corrupted the list head
> on failed lookups.

Queued for 6.6, 6.1, 5.15 and 5.10, thanks. The 5.15.y and 5.10.y v2
patches I had on hold are queued too now that 6.6 and 6.1 have the fix.

-- 
Thanks,
Sasha
