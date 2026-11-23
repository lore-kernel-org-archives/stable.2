Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458265;
	b=FcqwSCbXhgG+2XI/tgQ2ExZtu/6/zaXMS1H9wpKY4Le8ael3oSn8Yq8wdyNVe6F2R+iP
	 ZfFwPSKxAMtz9TEUs0UW0301mGxO1cSaln1pyQHYcUY/JXkZaoTdkdV35Gf5vO2k2FEiR
	 JDp5/yQ/WLFCW2k9TynkINaUV+OsL3CeRxorHQOmsv7HqaL3PqSF0t8+qkOgJWj8INmbi
	 CDx33AFqHmTU1FdDj6O4zYfWyJjAx28WwwHwlmT0f5RojR7rzHnfJgK4fJq+z3PCBC1vC
	 YIE+wO92MBjPFn5I5Sds3KWoIo4yWWlZ1tgktOzOTS3LYnqRYhXF7NEh78LJXT59/HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8HZUrjcwEG43R7qH7gGFQ84AJRxO8wi2o1a1d3AUQaA=;
	b=RW5j41bitBhhLeoG3fXbkFJN6I2CF1LLwg72WuFuhZo0ihY6OjpoCFu9WHfFitCEYy0p
	 NmNTXJmR9GUIDdAYox5PUfupmNmkZblCAORm4bJOFIfudjAJmILboEj8fbkhK3qkW+res
	 ijvqIjaUqnDCPsXb5tLGAsPaGpqgyh4KW5DsFRjAcqiGK5l2cRMRIgwR38M6ThyFGFOEF
	 2Vid0QeILawOlI6+DXyI2AeDgQXfT5HY9seP1nSt7YtCWrjQW6mIEHhIrcqGsGPsiekj7
	 U+YHGs11d5TEIuT+uCeBRldGSTVmkPxsZaljmvj5vlQ3qxHwPqSFIQ9nafi/r2TVyhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=YsBp1vGK;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D5606A321;
	Mon, 23 Nov 2026 18:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 563D5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=YsBp1vGK
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jYDqX52k4z1XLwXN;
	Mon, 23 Nov 2026 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1795458261; x=1798050262; bh=8HZUrjcwEG43R7qH7gGFQ84AJRxO8wi2o1a
	1d3AUQaA=; b=YsBp1vGKdZcOJ3PUSOOAQatFTUlIL5SR8hz1xYeiUEAtV1M72AZ
	lQHyHkknotHj4ddLPjtKktjfbRmwoagqV/zug6F15mTCjazLVtvcWbyy4TNXf/sU
	fItEMBVmH8R45C8RO2b4v14KqVhCAflNkrO7i+8dI4zsUl5Yrz6Wa/qFyaWstjC1
	W4EOSx1KKY0+sjCC2TqjwF4iEfkc6jW6nZk6F3ojO9+OWvmlYRjun3aRzw6Rb5Kp
	+71FPziSVxC7tnF/RGV084uWqhwM5QvLjtHYsKOJKRSNVGIru4NAc9bAXsjI03oF
	6w84hMsBS6dhKDhJ8AWW1S76HbJW/WuL/yw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JrYvIIlafrFO; Mon, 23 Nov 2026 18:24:21 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jYDqT352Xz1XM6J4;
	Mon, 23 Nov 2026 18:24:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	stable@vger.kernel.org,
	Patrick Bernier <patbernier@google.com>
Subject: [PATCH] md/raid5: Fix out-of-bounds access on non-contiguous NUMA nodes
Date: Mon, 23 Nov 2026 10:24:13 -0800
Message-ID: <c6d8950738e77f0b5a44c4e00aa7364395dccdff.1795458253.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prevent out-of-bounds array accesses in raid5_wakeup_stripe_thread() and
__get_priority_stripe() on systems with non-contiguous NUMA node IDs.
alloc_thread_groups() sized the worker_groups array using
num_possible_nodes(), which returns the count of possible NUMA nodes.
However, the array is indexed by cpu_to_group(), which maps to
cpu_to_node() and returns the raw NUMA node ID.

On systems with non-contiguous NUMA node IDs (e.g. POWER9 with nodes 0
and 8), num_possible_nodes() returns 2 while cpu_to_node() can return 8,
causing an out-of-bounds access into conf->worker_groups.

Avoid the following crash when group_thread_cnt is set to any non-zero
value via sysfs:

  BUG: Unable to handle kernel data access at 0x6f776b6f6f625f73
  NIP: __list_add_valid+0x2c/0x100
  LR:  raid5_wakeup_stripe_thread+0x258/0x340 [raid456]
  Call Trace:
    raid5_wakeup_stripe_thread+0x258/0x340 [raid456]
    raid5d+0x2a4/0x9c0 [raid456]
    md_thread+0x108/0x280 [md_mod]

Use nr_node_ids (the highest possible node ID + 1) so that the array is
correctly sized for indexing by raw NUMA node ID.

Fixes: 851c30c9badf ("raid5: offload stripe handle to workqueue")
Cc: stable@vger.kernel.org
Reported-by: Patrick Bernier <patbernier@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index d52adf81065a..c7b4576b8f91 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7465,7 +7465,7 @@ static int alloc_thread_groups(struct r5conf *conf,=
 int cnt, int *group_cnt,
 		*worker_groups =3D NULL;
 		return 0;
 	}
-	*group_cnt =3D num_possible_nodes();
+	*group_cnt =3D nr_node_ids;
 	size =3D sizeof(struct r5worker) * cnt;
 	workers =3D kcalloc(size, *group_cnt, GFP_NOIO);
 	*worker_groups =3D kzalloc_objs(struct r5worker_group, *group_cnt,
