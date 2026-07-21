Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B752439328
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634422; cv=none; b=oHLU2SLlKYZiZnVAkdtqvFHLFkf5l5iEFW/wflkOKAER0QoKFpSqIlQ0q4PPG70J9s+fwa7lrJS/S0AnHgAdIk1ctvdtek2jWPNCCww06V09Y3+8amOxbneudpyN7zd+HYSieG9RlHlH2Sq9Twnu2Z9LhJEOD6nwWa4rh7VpwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634422; c=relaxed/simple;
	bh=EJ1nKak4ncCmbZz82qHYSZIeSs0NE3FOsTQ+YbbNj9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENttcmUcN8Vr+wtZtByQcGpM5+zh41mzjVSdD/WVaAiqZktql1ADjtKILXSRCg/yg1UygOt/8M92YU5cU4HEaVed0RfT3Ahq9q7/Fwp5m0gxu0PlPJuKUfoZt/WEk7RpcNx/kZKGDOnuBCz8Y0gRaGqyxC4erKqBStY6VtpSEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJU4JVsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJU4JVsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C291F00ACA;
	Tue, 21 Jul 2026 11:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634420;
	bh=q8zH1KQ1E/F+8AnGnlI1vVwONhHQt0guIRk6pIh/hZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJU4JVsSCnmhVpG9iJJk1xJ2koBDeVPmMrNDDZzJOBFI4nSPc/m+JJrfSze8QHi8E
	 1XaII6m3r6vu0FjFcVMwoXCycOZTMToaS2RJa4qthn4e8i3q2XwrJuMGNKRqfZWvpv
	 VK+ZCaXfRrL5RvT3GN+8HjfaCaoQ8b3A3pe9/eGSN0X1htlbCjxqN6rqgyuehj9ooO
	 MwQYEd+UFfN+xAxp+Pvg2z+z7MTWZFKn9TW9otiT8Soy76EQ3cXCELT6rdwIGLEZqm
	 DXMEQOCm3ZOcTB/FP2Z3Xe7/JYU+ihtvjPNmwCIldWkovqtrvo0sHP4wXkEqALEUxZ
	 fB4Z+lCg/OU9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 4/5] exfat: fix implicit declaration of brelse()
Date: Tue, 21 Jul 2026 07:46:55 -0400
Message-ID: <20260721114656.3687966-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721114656.3687966-1-sashal@kernel.org>
References: <2026071548-sinister-joystick-e062@gregkh>
 <20260721114656.3687966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit f0d1b2e1e02c11e29c953f22a485449e3da2a575 ]

exfat_cluster_walk() calls brelse(bh) without including the header that
declares the function, causing the following build error:

    fs/exfat/exfat_fs.h:542:9: error: implicit declaration of function ‘brelse’ [-Werror=implicit-function-declaration]

Fix this by adding the missing buffer_head.h in exfat_fs.h.

Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 044472d5ee7d ("iomap: consolidate bio submission")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/exfat_fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index d2eec3a0bbc070..c634540e0de62e 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <uapi/linux/exfat.h>
+#include <linux/buffer_head.h>
 
 #define EXFAT_ROOT_INO		1
 
-- 
2.53.0

