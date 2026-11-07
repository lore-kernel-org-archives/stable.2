Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048473;
	b=TyL3PsoLAsLeBU9AUGt8oVMP4lFH4NA3lTcpqlNF8SrnHeUtc3+Pvq4VbSYfx5ZlKbN1
	 dToV2kjS8aCLaccsrBbNiof1hGI/qBKqY/HdbPcJwkOuw3jiH8cSvguJmUM8uJM2QGoYK
	 0QnAE5qJqWxTn7rKNYgFgyoqKgZe0FkXLn2stk9lDN69v1LWgNfp1+WYCYJEDgvMkLoYE
	 tLNBGyxWZ192UJNbRjVDVe/K8hdaivVExrKfW67dKTsQa6z6SaIVlwHjv+F55r4o8UPv6
	 lt+5ic6pB38IOtBAbJkD9p1H0QUqdBatqZT/MnBjEpVk/O/SXYDao/vmE8f89qVn30w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RwC8OzqTI4vdUsTJwe8CzdUT4eZeDS8fOjfPLhjU8n4=;
	b=YlXEW4kB4dYqG3KiNbuM9XYwshmb/e0SHQ7nJgSEJCDtjm0b4w34CnHb6kipcZsUYP/p
	 HiZIkXSDkbm5MIQPT2sZ2/jmYnHIr3kHBmI71Okrii6orARd/EDH/HSuw/xDY026cPmD9
	 2kq9fAejOTY/ROw1z3LspfLQC83PKno9ei0q+zriojOk8wKbxBoEl0h9MRn6Pv0bgkRUo
	 /G8xc4lUBTq2jka5n5YT41TQaXUJHF+sVUkeCaLSKdPe0dvuvSqXyiB/xjPe6I0GPjwQj
	 3CBa9RNna7vs4aov88m7W/WpfwuICOBWPD1ki9e/G3xDeLEysEdIUaKPGdglM2U0xSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fjottyem;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9385606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fjottyem
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F06B1F008A1;
	Sat,  7 Nov 2026 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048472;
	bh=RwC8OzqTI4vdUsTJwe8CzdUT4eZeDS8fOjfPLhjU8n4=;
	h=From:To:Cc:Subject:Date;
	b=FjottyemfqQU+KWJJoCVbymQvVFMF5A4JgNaya8D1eeIuCsIguiTj21xTCLbI4I5a
	 gNZypmeajRmMYq6uyYkjixi/RDZWS9dOWV/60biqXoB5Y7F/VoIPInv1ZAbIYhP0vJ
	 EKIJrj1qpVFPcZy3IC/JZPYhJadys4XFVmpYTBoeWYU8jXAVz/h0Z01xEbF4ZmgyI5
	 qp9Fj778eUBD8czElgp4coLAmpbrQnLXsp+5rq2uNRXHTiugJF2ndz+PhRRuOijgul
	 mgLniaNPOk7h+MexqGu0afmvisTpWCKtBMmgy5AJFelcaLugublLZTM9VoF3ZqW2MH
	 WGQughR+qsjvA==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: nvidia: Release write-combining handle on probe failure" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:50 -0500
Message-ID: <20261107054750-failed-6.1-8710af6a3520@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8710af6a35201a6d01b5af8f7e4bad29cc40467f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054750-failed-6.1-8710af6a3520@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




