Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046414;
	b=NVLJDVq70+FURov1eNK3/qszVjFW8BzpEjHe8EM7J/Us2d/kVMcrwuE6AVA4qw+3bpwg
	 z5yYcT4fRu8nOqEMxy9l0FaSYLygqzi1JoOigdattBacAtQlW++3gy4CYm3X8rIo3GNRY
	 C48FgZTG//LMa4PngguyIzWuDq9xx/LNNGLrDP3FH57nn9xsyfxykqhnkEo5KwN02k+Kq
	 GwSdmtyhE/ghTJeEmaofyzpSfg1Qa2s8HVw1bv+iWhCxUpUTiTyCQ2HYcekOImuFjLEJ4
	 Epxi7z3P9BGExVOz4PEv7LkzQrs/vSSikQcfUsCd9BlFNDY57HnZByIPRo6MonrEHIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046414;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cERq41rHSIkHv1Y+Dht9v4sJG8YYtkYttL4pyTsmLvM=;
	b=jV7RPWUQl9XJp5yAmeCeC9YHtTxdFf9ApK3aOrIXlKb2SvXWbx7V0rQGtN/W/Krk7aKF
	 TDweA8R8SGQfR/rrPrtD51eO1ceSsl5H/no+1qED+c+2PIDmsGrjh7Kd5grwz3v0L6fBW
	 t2fE40AleeX18jQasSYmbbkWwitSocMMrwxPgu3dExVbUo2C292rYJbO5MdM6dKZ1C4I6
	 IG1T6/LomsgZwdlDcZ4yCArKlUASaPbbvEpRszY4sUegTgCtP+9hK+J4z6+dHenUBoT8F
	 vdfiYD3s19KQChL5jNuEVZZOJXGNoNphxWj23tAeKz3DzHKj7VPjY9ypWqUpLteXMdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaRjAKrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28011606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaRjAKrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC6F1F0089F;
	Sat,  7 Nov 2026 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046414;
	bh=cERq41rHSIkHv1Y+Dht9v4sJG8YYtkYttL4pyTsmLvM=;
	h=From:To:Cc:Subject:Date;
	b=kaRjAKrjQa64Qt1SZHLAk0IxZg+3sfS/OupkVHBZv0CzGZhY2KIek0nR5ctqFlAFp
	 VJWPdSrbgZOAXTO2J34kIMjYveYYidK00ohPFTCyOx3yJjvVuK/TjEUu9qCqIL/Hps
	 wLOG7sk6ClX1VlJNV/y4RH1WQAUBXg2wR85WINgLluIfZRcMqxd4L13EHe6KKcdk1U
	 oGIMNX3Rn1B+vbYk2XxaXufevnQoTFJmwFoYXmmdqNRl/eZ6s2Ac++0AIzoBxlkaL+
	 V2JNU0n2+xeONtaf/nDCw6xHW2zSdIeSsgKiy5/QIekUXry90wRWy+nk/9QsiwasiN
	 D67qe+Pd+6dxA==
From: Sasha Levin <sashal@kernel.org>
To: alchark@flipper.net,
	bhelgaas@google.com,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI/pwrctrl: generic: Fix leaking array from of_regulator_bulk_get_all()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:32 -0500
Message-ID: <20261107051332-failed-6.18-ee450e3a2d33@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ee450e3a2d334c7e6383d8a55ad2d53b3822bacc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051332-failed-6.18-ee450e3a2d33@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ee450e3a2d334c7e6383d8a55ad2d53b3822bacc Mon Sep 17 00:00:00 2001
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 20:07:45 +0400
Subject: [PATCH] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()

of_regulator_bulk_get_all() allocates the consumers array and returns it to
the caller, who is expected to free it at an appropriate time.  PCI pwrctrl
never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net
---
 drivers/pci/pwrctrl/generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index d56171e0ee244..4b6cbbb522480 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -63,6 +63,7 @@ static void devm_slot_pwrctrl_release(void *data)
 	struct slot_pwrctrl *slot = data;
 
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
+	kfree(slot->supplies);
 }
 
 static int slot_pwrctrl_probe(struct platform_device *pdev)
-- 
2.53.0




