Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AC49E124
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086859; cv=none; b=hXPk6+AYYKo0fNyzKjbWi91forkWJOU4BniCUO2oZEmpke7DnPnRUqHwQA233mvS5v18NSc1wfpgKU4TFnrlLWf97Qc6JCRhh7H1E4rWFMvbW7Tp7FShRoHT7YCrsye4aTt5mR/XO6Qh34KuxfKJziAjaudC1KQlwMyOmaOsP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086859; c=relaxed/simple;
	bh=8wRKz0z+EM227WC2zSpMMs/LTcB4Q2V7blCrgApj3KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qO31RZck4QqtrrzrFw7ZHk+AoaNOlgKvor6QxPaiqhyAOi/UrTB9otS7D/mnv6OTPiSFLbeAa9MqPRJxyLVkVwvRCmr2x3A696/1E/OoY3kdIbscoVxmaS2X/GgqCReq3Mqmo/o7vnPlRCxhSoCbY2GDIJFd0Jh08TsIqxZLQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0ZXvDS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0ZXvDS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE141F00899;
	Fri, 11 Sep 2026 00:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086854;
	bh=0728i9zKE8aKHmYulsDmVW1YeTe1/V+RjLFB5YTjqEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0ZXvDS8Q6qe69g7/yCCVDAWSbuhPCERNw63A5yq1ImRgU+SoD47/9lKUGwT2iP8y
	 vwt5FP2t/wfQIIYRUlszDiNQ/nz2K3ELLis7jHtXKMN3JmLT2kYcLm7R+cx9Tng2ZU
	 kxoZVTnrW9alr/kFAa1jJIpCJ8hUAvanmcRxVcOAB2W/wYgp83tHO2tBR4G5aw7VMl
	 b349RUVn2F6IkJW/PsASGMWT1ORQCoZdjOhLM4Y5bpfLM8Y7gx0sUnFzgf8jz37jeB
	 2abVqxsOgB+T3OIa5vGixcZTzLFWBVUqRYpmCjF/qWHP95u/c7WSeDl/cGoLkoMSOX
	 eIWcL3AfbwY+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nvme: add missing SRCU grace period in error path
Date: Thu, 10 Sep 2026 20:34:12 -0400
Message-ID: <20260911003412.3483920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090941-cherisher-submitter-a8cf@gregkh>
References: <2026090941-cherisher-submitter-a8cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

[ Upstream commit ef248d5de4469fb6bbaf8dbe0c4c47800080d648 ]

nvme_alloc_ns() error path at out_unlink_ns removes ns from the
namespace head siblings list with list_del_rcu(&ns->siblings) but
does not wait for SRCU readers before freeing the namespace struct.
Multipath code iterates the head->list under srcu_read_lock() in
nvme_find_path() and nvme_mpath_revalidate_paths(), so a concurrent
reader can still hold a reference to ns when kfree(ns) runs.

The normal removal path in nvme_ns_remove() correctly calls
synchronize_srcu(&ns->head->srcu) after list_del_rcu() to wait for
in-progress readers. Add the same grace period in the error path.

Fixes: ed754e5deeb1 ("nvme: track shared namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Adjusted patch context to account for missing last_path reference-counting code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 56913db1f4458..1012dfc8f9f03 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4019,6 +4019,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (list_empty(&ns->head->list))
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
+
+	/* guarantee not available in head->list */
+	synchronize_srcu(&ns->head->srcu);
 	nvme_put_ns_head(ns->head);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
-- 
2.53.0

