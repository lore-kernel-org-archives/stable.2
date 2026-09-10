Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A74CCDE3
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067669; cv=none; b=KqHUx8nY8014Ebop7Q6p3MTs7PM9i/ABOZaO5KVR8BTNgCNB8TXa34PNS2C/WSOZccLjfaO/zS/j7Mu74td6uH2hrjl03cB2ME0TFGEI2Mp7NNco8UC9jVMRh5w/Eyi8UWUWxB1DNpvbjT9hUsleshO7PUTdTNSwVxJjc0e1hQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067669; c=relaxed/simple;
	bh=o7sz3cRs3zB+5cRdf/oZvyRbDfkBKlCxIAwPAiNmf9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kh9/dqpVKJVZhZ3JeMZh4RPrLaJf9OQV1FoUqqS/3G9qgdZDBHNGL+JVaUAvMy6Qmr+XeVEiPQvogJ2mIp9UaBC5b692TYG2VFI06/fJ8Wc3vDmRuWW+EHTraVpsKB0AAus4cmMYmmT4VMXVKHBbULw6SB+IrTg+HZHdYfBp0rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkeGFLcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkeGFLcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B921F000FF;
	Thu, 10 Sep 2026 19:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067667;
	bh=LleZVz/HRyF9TlKZIA0DMTlJVxXrqLiyTdkymlKqQS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MkeGFLcrhx8a+23Pz7kLJcNMZaNq6ga4mTHpxDpjyFSmu36CYX03qoK7cfsNytnP7
	 igblg6rMT7vdtLXmgcl30vhp8J0Pwna4RtzbOnrV6mRskLudRArBUTjcqxbjNcytVi
	 2LwxV7A5o3tncjIh+9DWu3qcf9xoDBUWSEVzdYkAg4qSdxQ6AChvtTYdDRJdD33WJW
	 txkDjYxsONpwA/0RkPINqrkVC9vSsrY46cfTdSpJtzSwiW6pi93vonkkXtMfe35L3M
	 lkWoJReqtfwJ6rOJyum+kChXFnPPDRvxvfrIIoHTSsjBeEqW4ldPlbh54zhpjym6WW
	 tq9AI+HsYfeNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nvme-fabrics: fix DHCHAP secret leak on parse failure
Date: Thu, 10 Sep 2026 15:14:25 -0400
Message-ID: <20260910191425.1482187-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090915-fasting-saddled-14f5@gregkh>
References: <2026090915-fasting-saddled-14f5@gregkh>
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
index fd01b86f10a4b..908961bbbe8fd 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -952,6 +952,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -966,6 +967,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
-- 
2.53.0

