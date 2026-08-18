Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27F3115AF
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055468; cv=none; b=NgB9T/YDPTbJ7eocU/kXSWdOBz8s4SUGncKKQJBllcHj3rt3YoXk4QM3Suk4Uxy1vmHNUGolIAARL3HjLsXtEvduXSop7Zs3iMmSBMjlCRPSHH0FQIN+zR3HMyv2/eRdCO45PQzKWtWj3LIkgrn3n6m4bnmErD2/GMGJ7RMVXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055468; c=relaxed/simple;
	bh=BblLxSrlJI2AE94z5uL63XH8T0b/HFtRARlUfCZgu9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKPox8z2DgUE/D1B6BwP0QAKD/fvgn07YZ8hswTMrhr3z+LmPoMd0pqsOzy4rrUFNJFh6Sv39nMw8A2nVLU8j+3n0HluMPd7MwPiLQFFOwBHbzQ1Q5ZBDZuaiX+47alT/rA5pnW4ASArD4dkB5gE1kTS0BwWvM76YnOrFPvN/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc5EGTXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc5EGTXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB711F000E9;
	Tue, 18 Aug 2026 12:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787055466;
	bh=FF7Rn43fyNeaqGLr/TaLxcdPEtouKA6mvpPHmZ9xP40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cc5EGTXUGomJz/kkJB+J7cXjV8CQNt5a+jJmTeMv2asW/S0UsQrnVMboYcYPHi0Em
	 9AUqsFemNV8q147ZEukOXtgwj3O0HILcy2Jyq+P6uYXBG8FwlUob/rLkbb8hL9aq2P
	 MTc5RCzO79Vg+TC89wCqmMGz1QPdWjxKnwiYGXB5peSvF2tv1eQZ/x7oDNzndczg/n
	 bkS6f3VPUQGNhz+F+51UfHv7WZe5Yfu6rSTUnxdPAPWUsjkXIX5kv3TCWN5IBefxeR
	 Ln7ozHjD/88n+doxPMaA4q9xmfMupobctw+bIEW/k7BVhPnvK8W9e2dEUVs8kPpPuo
	 KNGLaa1iHwyPg==
Date: Tue, 18 Aug 2026 14:17:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	security@kernel.org, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix NULL pointer dereference in
 nvmet_execute_identify_nslist()
Message-ID: <aoRNZblm4SZ56ayQ@gmail.com>
References: <2026081423-enlarged-dribble-10bb@gregkh>
 <20260814190022.1531236-1-kumar.shivam43666@gmail.com>
 <20260817065823.GD16255@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817065823.GD16255@lst.de>


* Christoph Hellwig <hch@lst.de> wrote:

> This was already fixed by Guixin Liu.

For the record, it's this commit currently pending in linux-next:

  79aba4c94034 ("nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()")

Also attached below.

Thanks,

	Ingo

==================>
# AuthorDate: Tue Aug 4 10:18:57 2026 +0800
# CommitDate: Mon Aug 10 12:25:54 2026 -0700

From: Guixin Liu <kanie@linux.alibaba.com>
Date: Tue, 4 Aug 2026 10:18:57 +0800
Subject: [PATCH] nvmet: fix NULL pointer dereference in nvmet_execute_identify_nslist()

When a host issues an Identify command with CNS 07h (Active Namespace ID
List for a specific I/O Command Set), nvmet_execute_identify_nslist() is
called with match_css set. The command-set filter dereferences req->ns,
but this handler never calls nvmet_req_find_ns(), so req->ns is always
NULL (nvmet_req_init() resets it to NULL). As soon as an enabled
namespace with an NSID greater than the requested value exists,
req->ns->csi dereferences a NULL pointer and oopses.

Besides the crash, the comparison is logically wrong: to filter the list
by command set it must test the command set of the namespace being
iterated, not a single fixed value. Use the loop variable ns->csi.

Fixes: 61c9967cd634 ("nvmet: implement active command set ns list")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0b24d31f966d..3fde09b4d78a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -960,7 +960,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
 			continue;
-		if (match_css && req->ns->csi != req->cmd->identify.csi)
+		if (match_css && ns->csi != req->cmd->identify.csi)
 			continue;
 		list[i++] = cpu_to_le32(ns->nsid);
 		if (i == buf_size / sizeof(__le32))
