Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8142DA43;
	Wed,  8 Jul 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527497; cv=none; b=cBE3Y6U2QE8YyOwrpuu5q/HAgwKOQOuL8xZ29NuxT2S3r4EsClczXoBAax0VGnuAqZFaPfpmLq8QsywtDMp97DQ1TXCgwtDpouAkajtO2ch0PcWyNM9S+B3GJilTYhVfGQV7cRSOBpTWa5er3UTau/ZWe3NrjoW9kGsd1cKsCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527497; c=relaxed/simple;
	bh=emeqFPYJhsU54P4D5pKnIVo2bLb1/yDskAr0lHzp7o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBYTyhTf+3PkcXWmnKKkDTzOl0+NuwuYwnkaChHcBc9SzJBeRSlWjv4vwtmq6L7ZKcfL17k5HNduf3wujaqVmRts6hbDCmjw+iGdOyciG6LV71dyAd616mtmOcwSzXR2MQ4Cy0SAK7SHfPh3jphdCjA0U7OEVkGCMZRgQFrINHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+LU6yiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+LU6yiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF1C1F00A3D;
	Wed,  8 Jul 2026 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527496;
	bh=JiC5/914qoX/pLC23xYMfmaM5nvG9RDJDy++UnOezLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P+LU6yiJCrkAx1zLq9qFp3mjvSNsmF1Ik1xPmJNmb/SD+Ox4RCmHRhlZJmaIOfFGl
	 e5L5WbJok5h5KvYloSY8cauaFg6D40uLnX8Ahgv4X6xPZT0akCmMJ8okiBkMzNwxlc
	 9TC12QsYiUJ4QXcAAJfq+qRBvRiyUNKUVTFxe3QZSbkKv0+ONzqsPPyyX4jBuDrZho
	 g95UOTIJ8HEokiLssLxr2/qUitCFNtSxJl0IhmM89z8VbmezPfVwtPkYkg4q3fPKpj
	 hGUZ1oPJM5FW8QYhPefAQeUokFh8tXGjyQoXewPMtEeUOSfW3zszr8MmIhxmBTaJx7
	 BWV7GvOv8ooew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	John Garry <john.g.garry@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konstantin Andreev <andreev@swemel.ru>
Subject: Re: [PATCH 6.12.y 1/2] block: add a store_limit operations for sysfs entries
Date: Wed,  8 Jul 2026 12:18:03 -0400
Message-ID: <20260708120505.agent5-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707153729.1834723-1-andreev@swemel.ru>
References: <20260707153729.1834723-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 07, 2026 at 06:37:27PM +0300, Konstantin Andreev wrote:
> The prerequisite patch to backport of the CVE-2025-21807 fix to 6.12.y LTS
> (see Stable-dep-of)

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
