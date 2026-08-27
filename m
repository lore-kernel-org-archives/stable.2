Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039C43A7E9;
	Thu, 27 Aug 2026 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825861; cv=none; b=PaE4y/6fvBLQQQgNgFZGfOdOdbgzdOxnK21nGy7ZLePVTPrY5iDfiEPD7wet8sau1xMzEyPcu7vP+W4trV2DMLFCGpAOLT8n0o1V/jmt8+YeQlIQJuUK9owJt6AljZU1cVgJu5hoo3sKXLwdI/5ts0c/qtuhPaaXIlK/2hOH5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825861; c=relaxed/simple;
	bh=r4HsTiHvzg2AlQkD8+AeG2tkKnoHBQ5COc+qj98xNQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su/ktyn3bjf5cJaWZqGRrLShtMbUoucLUCIT4XoNAE+0ME4IuqEZ3BAF/FaA6E3wXI7LYyi/feglduh2QO/4y2Pk1yUXPtc6khknvjTcX1tLajSuF34TbbjQGHMlpRkRe1CIrtE+8mLk8j7ZfqDcp5QXplquXBY4YwvSKdL3xqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MHYCBGUv; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MHYCBGUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=r4
	HsTiHvzg2AlQkD8+AeG2tkKnoHBQ5COc+qj98xNQU=; b=MHYCBGUvRT02yksjJD
	Du8ID5eA70iOL/FxASbW+cMh2+ikbhM/kz16lBW1M328kl0Jzw4Y2lbFq9KmHttS
	RlMVquDx+x//EzyD2s4fuVeGbNsLgaxfWRkvZE9Bwzt+H7yDPElHPfturOkgHia0
	IVNUYIq0PHobitI9unFdXFU5I=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCXX71tDpBqwQL_OQ--.51270S2;
	Thu, 27 Aug 2026 18:16:14 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com
Cc: vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH] sched/deadline: Fix DL server divide-by-zero for inactive CPUs
Date: Thu, 27 Aug 2026 18:16:13 +0800
Message-ID: <20260827101613.2664218-1-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <an2BH9a8PWlZUGj6@jlelli-thinkpadt14gen4.remote.csb>
References: <20260812123252.2355986-3-sh_def@163.com> <an2BH9a8PWlZUGj6@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCXX71tDpBqwQL_OQ--.51270S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjWlkDUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6g5dvGqQDm49hgAA3k

Hi Peter, Ingo,

Gentle ping on this fix. Juri has provided an Acked-by.

> Looks good to me, thanks!
>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Please let me know if any additional testing or changes are needed.

Thanks,
Hui

