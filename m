Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9C3CA481
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067920; cv=none; b=nIt7onsYMpdRgeLt+OfilszcBRkRN1K6NKwLWa+rtOqik77VhVC8Ntqya7nPHFfXvMEFRAi+feDCwaaCaNv2ERNtUKnw0PHafNm3EszQlu99liAlbMkMpL/ihlG88PAgi9C8kb0dHei85Gez4jH+V6NZlGyY8UhYxYxBevTqPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067920; c=relaxed/simple;
	bh=Hxtk+DkuEEKhhN/A3V/gn+ZeaqS2zEjY89CddlyMc0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2FtiXi6q0HxviZ8LWebsSHmieTlEBa+oMfuGlNvNssmbckMZ8713bAbcHirkdOz65gJ4rJU1u0WOOKOBdAQLCrKiq/9GMmd+/AajIU2I/7oVyY4Bzsip8u0VbrlGR+NQFh3NdbQs8+uRMwu6/B783d/ZP6x2UEvA/Vbga+sv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCtMvCP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCtMvCP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA68A1F000FF;
	Thu, 10 Sep 2026 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067918;
	bh=dBLDAAfxIP7flLDrm6ARuZPI34vBDfCnBCcSb9XVOkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eCtMvCP3hTrNTud4dci36oG+vii3Iwiwza/jaj8ARyA785xSZeZ1wQLikq+pD8c8g
	 qnTHjTRSGlatmFMUGSIFKc+uh9w/294Y2h7r3YJyw8iLSGXO71VSCKBVXF88ii8/sq
	 T8Pk/dblKEv3+1iJhEbD11YpsJYGa7qo3i7COMLtRqVDqm4IeuwDPEqFSjqlLsdWMq
	 8FVq0HxK/LLzcmGXOboDfpzNL7a+Cg8kUuLdch/Vrp5hPDPqfMpbac5oS0hQ0uMidE
	 BWhTioCyA2KpxhgpAR38WSS5+C6PV/8OhiF1MSG4ij3udU4l2jP5mc92V40A8phpAk
	 s1x9G8QlD5ttQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nvme-fabrics: fix DHCHAP secret leak on parse failure
Date: Thu, 10 Sep 2026 15:18:36 -0400
Message-ID: <20260910191836.1505281-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090916-resurface-ultra-bfce@gregkh>
References: <2026090916-resurface-ultra-bfce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

[ Upstream commit afdee49a1b88ed9bb44e2b30e855297c169bcc53 ]

nvmf_parse_options() duplicates dhchap_secret and dhchap_ctrl_secret
with match_strdup() before validating the DHHC-1: representation.

If validation fails, the parser returns -EINVAL before the temporary
string in p is assigned to opts->dhchap_secret or
opts->dhchap_ctrl_secret. nvmf_create_ctrl() subsequently frees opts,
but nvmf_free_options() cannot release the unassigned temporary string.
Each rejected option therefore leaks one allocation.

This is easy to miss because valid secrets transfer ownership to opts
and are freed normally, while the malformed-secret path still returns
the expected -EINVAL to userspace.

With CONFIG_NVME_HOST_AUTH enabled, the leak is reachable before the
required-option checks and transport lookup. No NVMe-oF target or
working transport connection is required; for example, repeatedly
writing

	dhchap_secret=BAD

or

	dhchap_ctrl_secret=BAD

to /dev/nvme-fabrics deterministically takes the leaking parse path.

Free the temporary string before leaving both validation error paths.
Use kfree_sensitive() because the copied option may contain secret
material even when its representation is rejected, matching the
sensitive cleanup used for stored DHCHAP secrets.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ffe433c470894..eed78e6f2cdf6 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -898,6 +898,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -912,6 +913,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
-- 
2.53.0

