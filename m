Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049514;
	b=Jh+FQVh+XuLUci9YGhQ61WGWP4Ggs9xjaxAkBc+GAqK3nw8XfdbiB4fftRQ/AcDhoUrm
	 Jjii4svq0IphPzMk20N64Sb5qi9kIb33naQ9RrXJbByYpNgfUJ0/+3uWyrYtErGT8Zj2k
	 IwsFQz4Iv5jPbz2kKiqFtDS+f6hNvMRdU1SC33+s9L4Tn4K6iTeJJXmPWyk6H9CRMglu9
	 kR08T21A1NR73cHxxVOSr0C7ALfp0B8tCM855fyzlKRCfBYQkaVQfg0WLeP300sAOQLwY
	 AbxuXHjWTKObAGrPD8cx9QHAbzoG4gfEsY7OVbAvLZWcux32SMUJF7YcTpQT64P3TFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049514;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w7TqUyoX/VjVpQ6aiBEEdZNPt7jtBc9WT2b/xOwysM4=;
	b=X958knDN/Eufht90uKpDQvrAvxiqXBiVh95Swl/BrEsCdRpf9OsKKeZVl/5rU1gre+gR
	 Y/F2xMPzxF/wxk4q5MaUPBHDzzKXmevUpgrx5lVlBBMtL04ctIC54KyixFuRCCNMgO3nO
	 V+N+2obwSsbEBWEqvb9eb2ktxdxG8xJem6kzjjoEt1csu/Q+uzBxD37pVKf/o50o2n6ac
	 iH+WBe7yMasLnJ+IlNcCIA5P7UfEvcsM/2ltXyGjQbXx5CbwULbiunINEE8A4lBKKwPhl
	 IfJMMmUfzmZMDkVgwi2zlNjBNbVGvpoDrx2yxf15GT21fdKzqF/nUVMBCXS3NpG1FoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpo90v8c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED4E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpo90v8c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3FF1F0089F;
	Sat,  7 Nov 2026 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049514;
	bh=w7TqUyoX/VjVpQ6aiBEEdZNPt7jtBc9WT2b/xOwysM4=;
	h=From:To:Cc:Subject:Date;
	b=dpo90v8c3RjLMsQPBZXYn96LMks1g7Pug69k2DwEbAZY45tqC9mAwLgx344f8ZlPy
	 zDptPTG0GtmY6n/LowJfqfSbbPaZtdKaoNEKutfWLGVMdt08yIGnCyLqILGHWBDQ/b
	 QfLZGePl1zum0x8asVlCpsdZjjW4P9+nsZSV32NsBjd2kiKvZYsRtQovvhphROQwew
	 3z3newO4lj6vQSoIpXfwRn/yk04uCfrcSc/nRzTGwKJd+Dh5h//2egbVfZyYTbzScu
	 3+ZIFWhJUdSi7ljnQ7TutKq7hjINcbPMdUKnA9gCqdjijdgJeSa/JHn149qKPyLuvR
	 v5WPS683pZ7RQ==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: nvidia: Release write-combining handle on probe failure" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:12 -0500
Message-ID: <20261107060512-failed-5.15-8710af6a3520@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8710af6a35201a6d01b5af8f7e4bad29cc40467f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060512-failed-5.15-8710af6a3520@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




