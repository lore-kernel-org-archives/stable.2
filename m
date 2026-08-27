Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6041B8EE;
	Thu, 27 Aug 2026 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826236; cv=none; b=LTNLMcWEI51COysd5NUWh+AQYpyXDCfESvBnfVySz8fV3v3MX1aXefv3s9OW2tn3ucKBAZDZzFYX8rVEORI/fJrxJpL4uLDdX0PkLGwAY8dBC4zWjKtOZ5FZkzQWmGy4EBV2CbSoPy4ku+7+9AsuKgp++JezkdHRgvwrOn4+0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826236; c=relaxed/simple;
	bh=mLMTthc6Iu+ZCZERj9Mp1tLNwbDNCCPfnO3WRCGJbjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlCGrRIFB4ayLm9pW9TMyqMBadd3vk62NBbuyUSXJjC72UZdV4rfOG+2GBxS+k7g+cSP0BSPoMI/Z89rU6WRtwPo4mxtxC6I1PN4uGf8gKJ0fVyxPSW4ZWGCQkAf9cyhAm/Y7V8cTxysBnHDYSNBKY6fVIsfIEfE9SMJGrS81Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gSkWexIN; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gSkWexIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mL
	MTthc6Iu+ZCZERj9Mp1tLNwbDNCCPfnO3WRCGJbjY=; b=gSkWexINwqu4XdkF+F
	IoYNCvuPbxA83EXN6/c6QjwMdr1RvHXGVV2D+X2HjsNTODFJ6Z5NVHwRiZrRuVOD
	FhdJ0YLdR80r5igsUnVhg5xAix9UFXU2hTxUp6HdXtBz+HE0LG1D1KYVpjsf6aG/
	zJIhpqT4Ne1BZrEUl7TRniAIA=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHKALuD5BqtbuTPw--.929S2;
	Thu, 27 Aug 2026 18:22:38 +0800 (CST)
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
	longman@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix DL server initialization for initially offline CPUs
Date: Thu, 27 Aug 2026 18:22:38 +0800
Message-ID: <20260827102238.2671839-1-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <anw7IML1xzHys6re@jlelli-thinkpadt14gen4.remote.csb>
References: <20260811100612.1408592-2-sh_def@163.com> <anw7IML1xzHys6re@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHKALuD5BqtbuTPw--.929S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOku4DUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQ69HWqQD+4OFwAA3t

Hi Peter, Ingo,

Gentle ping on this fix. Juri has Acked it.

> Thanks for the fix, makes sense to me.
>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

Please let me know if any additional testing or changes are needed.

Thanks,
Hui

