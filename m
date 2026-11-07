Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050518;
	b=1FdxG3lG6pSTLMJQZ9hE4R/EBfRnFZqFFR/sihi0CHzOt9SDnhdxX6swDsgTi14ewhxu
	 ke/akRyQ5SrzbSA9JrlDAHiD780PelsEddOzk4LekyUG2dob75d4EJYHNqg9YO5eMjt9v
	 9ti/0MvqrWcS3bvXI/K1P3WQMYr4Q5AiKxkrSGw4eB9sP8QBw4WAyl81sFyDsSYSuQPse
	 UHVZrFpwXcCn9JaUSiNxvZCCx59jv1gEWm9RVDW0VK8WjGVzT8mwLbkYxOc2zvYv6PTDn
	 +flDk+g5mxKcepsikv8kb7nYpSm3FFCF1X9r4sD0LMGu7oahsKtGOpaXYBAirHCHFnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050518;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xD25SUxBg6sMNJZRU6aaWic5nr8pn6wO6VBpDmTPx1Y=;
	b=dzoilIMOB3UbpoXtxjD9lxwzheaJyiIf0HCVWdoAbqlD0LZ9rtc75BHiop9l6IleoQYb
	 I7m2jZlxqqOCN9u5cAYCfQlX2GGslRIU7l0DFLhuhxTwX12qIMjIAYuU2jZ+GYQFCJ9Ny
	 MFhvLL5+oQ1XHsmu3m0GJy5r2/heZpbRikEdchH6cIYroxxZ9g6MvqtDxXNdIpJEhePi4
	 Onv8XzXoyDb9A/TL5qgEuLkjfXUN39QnXL1J6n+i+i9vccB7s7Kx2hy4oqhT01d/1V0Il
	 9KK6NF3mKTys7FdqVSvEu1eo70jgiEIH6/O9u+YvUs55KmPLeVw1/sB/UIyhUsYTqRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWOcVvUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A108606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWOcVvUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C6B1F0089F;
	Sat,  7 Nov 2026 11:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050518;
	bh=xD25SUxBg6sMNJZRU6aaWic5nr8pn6wO6VBpDmTPx1Y=;
	h=From:To:Cc:Subject:Date;
	b=TWOcVvUAuaorOSTj60H7fJByBiLin8qqs97NYTfhBRDkkulHCDPxivzFmMEloJW6j
	 09xxMe6RA9McsrE1dzI6JW/NuMSBDGH7ngMpL8K2qNS2Oio7yZVRm+MgdS0/4VuDwL
	 o6bKbaBhlbETeKt8NUq5HX/U6cg5u9u5lSadj9HZ5BEEUDzZ32DZ1O6bi41OJt+PSk
	 gCOpOw/UBHr6Gewkjys8oetVpwhhHDoWCIQRLxqtzffTLJVYdYKuCbevbRazB73p0Q
	 hDIhuSNvIYgZ2JBLdBAqxUqUSX0sQR+85KBjjVt64SQYUiNiYvWgHoZKBNq/Y8umIk
	 6OW4tHECajJkQ==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: nvidia: Release write-combining handle on probe failure" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:56 -0500
Message-ID: <20261107062156-failed-5.10-8710af6a3520@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8710af6a35201a6d01b5af8f7e4bad29cc40467f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062156-failed-5.10-8710af6a3520@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8710af6a35201a6d01b5af8f7e4bad29cc40467f Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 20:54:47 -0400
Subject: [PATCH] fbdev: nvidia: Release write-combining handle on probe
 failure

Failures in nvidia_set_fbinfo() or register_framebuffer() leave the handle
from arch_phys_wc_add() allocated. Release it in the shared error path,
as nvidiafb_remove() already does on normal removal.

The missing cleanup was already present in the initial Git import,
when the driver used mtrr_add() directly.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 4ef7a5ba43cc4..395f5d0455fa4 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1423,6 +1423,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
-- 
2.53.0




