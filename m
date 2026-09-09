Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D332A3D7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973570; cv=none; b=N77Iot1KoJK6hJ3WZiT0sYcJ+uGf//+Ybf9fJWCIPYvNPhp/ksoRn7hRe9dkrNvHFkPOBD+wx1lNlzHxkiq/+lU0ACEahjTv8Ska98VVqy0qocKGVWlZ+5keZ39YPg1NqDylmcLloZvEisZfl3AVrWnuKrM3VOuXMhoYPNW2n2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973570; c=relaxed/simple;
	bh=IT+5BxBDkBlHcy60tDSSWjRoxzsZAlJGXYTR0RF97CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsnadJcMh5ApSiUHjWztPtswdSQMxEwDXkKjcv/ZSNTylbyJd1KnDDE+CafE+jqWCT+r3Fgq8qNz2K8rBUIO5/8n/6QvQj9IKjTTypNl4M/xjS9fxwGwhFKORIQ5ehZbumTXf//dXpr/qb3LwxzpFnegciUAPgRuazpiQCtZths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE0lQHrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE0lQHrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5D01F00899;
	Wed,  9 Sep 2026 17:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973568;
	bh=ce5VijTfa0sCpjEjHcR1ZWF0AqJTQ8Kb3qNbCYgTU6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NE0lQHrwEBy1PbHyeVr0Dcm9H6inhG3EbINuvGyR7sYkxmezk4VndP26i+gc3ePU2
	 v3JCrTnE8tJTe9Aax5Tz5+HDUooPIshsv35gBYDYMCYrKn5HXYdMBMWpKjr3yQZpeJ
	 v13ZFCY+TE595BqZ84PUkdWRbJALNrhWBnJXd9FggzA88ge9HK/+HXmBF54ATms0ly
	 ssqtGPoIZ6idAglldZnTGCSRzHGlkTiP+bpTwtd7LYF2BorKqX41Vw2P/rAlqTQk7e
	 MbmMxw2fO73goI6dffKIPs+GlCi3KcTH7/JceatY5psbOX7pr35kQwd4yN4lvlaN4V
	 JYaoU2EcRZnTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hector Martin <marcan@marcan.st>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] nvme-apple: fix controller shutdown in apple_nvme_disable
Date: Wed,  9 Sep 2026 13:06:01 -0400
Message-ID: <20260909170604.3185721-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170604.3185721-1-sashal@kernel.org>
References: <2026090346-clang-google-039d@gregkh>
 <20260909170604.3185721-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit c76b8308e4c9148e44e0c7e086ab6d8b4bb10162 ]

nvme_shutdown_ctrl already shuts the controller down, there is no
need to also call nvme_disable_ctrl for the shutdown case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Eric Curtin <ecurtin@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hector Martin <marcan@marcan.st>
Stable-dep-of: 08660a5c8d49 ("nvme-pci: disable controller on admin queue IRQ setup failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/apple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c888ef115caf9..c0c23b851e4e7 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -831,7 +831,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 
 		if (shutdown)
 			nvme_shutdown_ctrl(&anv->ctrl);
-		nvme_disable_ctrl(&anv->ctrl);
+		else
+			nvme_disable_ctrl(&anv->ctrl);
 	}
 
 	WRITE_ONCE(anv->ioq.enabled, false);
-- 
2.53.0

