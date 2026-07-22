Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A73353A8B;
	Wed, 22 Jul 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741409; cv=none; b=UQGEC6WFlJFdJZpkhX8CnitC2T8/JsGWnXT6iq3XSS+39knA7ch74fPoggZI9KAmABXNNY+ZDZDx7ryI91U1mxl/OHX59POiZrULtWaOZwXNqDL0BGqpbrwLnjY/N8XdEMlM26Xb9cePSyL94YwvK1GMnWRCfoLWZhRktk8BFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741409; c=relaxed/simple;
	bh=nlLmeH7xH/folA9mfTTMuflG4FL70EHpAO2MqZXRYpo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=n3skH8RHoCB+vRooVuga49dyvuRlopiuOvjlkbCuKOMAuIYK3rPDvsMAzY/c4vaqsLtxNSWAICWEiiZzb8Yrx5+XIHd/yd3UQ3+Mzjo8NgHw7rJmxNcuByg5IKdfVQXp4fV8pqJh48fF/fp+JFjPgVjJWwunT4DhhGhy/Q0Gj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=Qcj9JU6r; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="Qcj9JU6r"
Message-ID: <07b303cd-03f1-4d0c-ae58-7439503247a5@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1784740968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xXKpS1A6HMxkAGGR1xzLcWjj0SgZpCW98YlKonaaVzw=;
	b=Qcj9JU6r5KXtnAEM/5/ezkHRPDc+pgsomz4QAFUHtAehJkCtzAHu0fLTUVpBoqT86LBlVt
	KsFSlid1hirGe9/4uXY2Q9eTDolLvTAzKJAlbukryzTN+51AuZp2jpaF+zIxeI+lh+eVLQ
	+ZGSCd3nAny7pX/T9Qcu9avcu9A1M0s=
Date: Wed, 22 Jul 2026 20:22:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org, Brian Witte <brianwitte@mailfence.com>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>
From: Konstantin Andreev <andreev@swemel.ru>
Subject: =?UTF-8?Q?=5Bbackport_request=5D_=E2=80=9Cnetfilter=3A_nf=5Ftables?=
 =?UTF-8?Q?=3A_fix_reset_request_deadlock=E2=80=9D_to_LTS_6=2E18=2C_6=2E12?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2026 17:22:48.0063 (UTC) FILETIME=[B76B40F0:01DD19FE]

Please consider backporting the following series to LTS 6.18, 6.12
(listed in the order of appearance in mainline)

779c60a5190c ("netfilter: nft_counter: serialize reset with spinlock")
30c4d7fb59ac ("netfilter: nft_quota: use atomic64_xchg for reset")
7f261bb906bf ("netfilter: nf_tables: revert commit_mutex usage in reset path")

The last and the first commits are registered as CVE:

     CVE-2026-45897 for 779c60a5190c
     CVE-2026-45901 for 7f261bb906bf

The series came into mainline in v7.0-rc1 and
was backported into concurrent 6.19 stable,
but was not backported into LTS kernels.

The series applies cleanly on top of v6.18.39 and v6.12.96.

The series came into mainline as parts 2-4 of the wider patch set:

[PATCH net 00/10] netfilter: updates for net
Link: https://lore.kernel.org/netdev/20260217163233.31455-1-fw@strlen.de/

and comprises a distinct, self-contained functional unit
originating from Brian Witte's series in netfilter-devel:

[PATCH v5 nf-next 0/3] netfilter: nf_tables: fix reset request deadlock
Link: https://lore.kernel.org/netfilter-devel/20260204202639.497235-1-brianwitte@mailfence.com/

Here is a relevant excerpt from Brian Witte's cover letter:

| syzbot reported a possible circular locking dependency between
| commit_mutex, nfnl_subsys_ipset and nlk_cb_mutex-NETFILTER:
|   ...
| Link: https://syzkaller.appspot.com/bug?extid=ff16b505ec9152e5f448
|
| The bug was introduced by commits that added commit_mutex locking to
| serialize reset requests.
