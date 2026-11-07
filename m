Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046635;
	b=i1zdt5U9Ie4n/TPsPWJa9FwPwINr+qF6j5b5Ge570E6ApSnCvoYmWGRxQ2Ss7CSKhBiW
	 +XDO1cv3TfHZgEl6CNGIrPBfaofj0ht8VHDxFGQhRXlJhg5PHYqRLxKHymnJbJtWbIwrI
	 WlFpSP797btcVHl/GLCVv9cj4Lol7B/pzZkrteYzIyyu1d/ILld1/WywAJ0a5KIlf6K+J
	 EqqrJMpZhZVq5RN8jYnEhiOC94nm97DhVk2hZ9PwN+sbYlaDNdsg1DPjFGek3TPshDsGt
	 ldnv0q9JFxTq8WXJnXRna87w+S79DjeYGaUvOWCqeO3xbJ6QsPW5pcDsYP6929NXnkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046635;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TLqv3Z3LFCesoLhBE5fbBYX8jOiSPcrVDu4P3YlMjUI=;
	b=Q0OrQ5GPEEdxATCpuDqCvX422iwITpovIJB6IKxXOxhMnNt5ZRluJMO7PlyILirv3WH1
	 e8tZT4GRQEYnObt/maqDrDVOUu+vKtR9iTX8N8HfBgT0Ei9MSv12Rz86M0gnTcQFwe8G6
	 a5qMMZrFkstxRlJCUlhLn8pvsdIBIFAoKDxPDZun5AD4S6FkPmwkTCPRtpwwAKZmv+SQY
	 5P7AixxiQoOjsjevOuqVyYz4T2b1G9zr1nyTJGR8IeFl7DUtqQTTMDqx4+mNCJ9e/zQW5
	 gL8aDoqvI3ox8rR9c0pdMfgbjEhHgqLBNxLOZcYi7WYUlnIBIWZ/KBD9kY5pVpW8cVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWyt6i3e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7360A5BCE
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWyt6i3e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BE91F0089F;
	Sat,  7 Nov 2026 10:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046633;
	bh=TLqv3Z3LFCesoLhBE5fbBYX8jOiSPcrVDu4P3YlMjUI=;
	h=From:To:Cc:Subject:Date;
	b=kWyt6i3etGQvcjzT6xyBPIft5YNwg0P4q1RFdGY5V8pNT2nn3wy6MbHcoLrZOKfVG
	 zIefBgxvRFu438gavfXEStcQQh5ZsFtZYZe7EWkPsgGoIs6QgsZpzOvG8dxx3dQyGA
	 wnJxAQ1Z86v+I5Vdd75GKUyns6ked/W/Q+sO3qpGtpLJNSgkqe6OG57uRH0z94eboX
	 kOXsgael4vnZe+hj04HK2b9b/zgjVToT54xg/QuEloCFHLGLeX4YGo6uC1MHFuZaas
	 RYjM7ZAEeDKS8EBnDsPcjYPLLR5FU6Lz81ptnkVgIwCMnneUE3/NCffCYgVLDS08My
	 oucD7+BvAQfCw==
From: Sasha Levin <sashal@kernel.org>
To: macro@orcam.me.uk,
	andiwild@gmail.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: Skip Target Speed quirk on clamped ports with no link" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:12 -0500
Message-ID: <20261107051712-failed-6.12-ff8a969f7dc8@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ff8a969f7dc8e79ea6113abcfa983e070b2b585a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051712-failed-6.12-ff8a969f7dc8@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ff8a969f7dc8e79ea6113abcfa983e070b2b585a Mon Sep 17 00:00:00 2001
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Date: Sat, 1 Aug 2026 22:11:48 +0200
Subject: [PATCH] PCI: Skip Target Speed quirk on clamped ports with no link

Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
failed link retraining") the Target Speed quirk lifts a firmware-imposed
2.5GT/s restriction on any downstream port, without checking whether the
link is up.  Where nothing is plugged in, the retraining that follows can
never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
quirk makes two of them -- the initial one and the restore on the error
path -- adding a fixed 2 s to every boot.

On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
slot, running v7.2-rc5:

  0.541 pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restriction
  1.541 pci 0000:00:1c.0: retraining failed
  2.541 pci 0000:00:1c.2: [8086:7aba] type 01 class 0x060400

Where the Link Speed has already been clamped at 2.5GT/s and no link has
been established there is nothing worth doing, which is what the kerneldoc
for the quirk already describes: the restriction is to be lifted where
firmware arranged it "and the port reports its link already being up".
Bail out early in that case, before either the ASM2824 workaround or the
removal of the restriction is considered.

Ports whose link is up are unaffected, and so is the ASM2824 workaround,
which is reached with the Target Link Speed not clamped.

With this applied the quirk returns without touching the port: both
messages are gone, enumeration proceeds from 0000:00:1c.0 to 0000:00:1c.2
in 1 ms rather than 2 s, and the systemd "kernel" boot phase goes from
3.011 s to 1.036 s.

Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining")
Reported-by: Andreas Wild <andiwild@gmail.com>
Closes: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail.com/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221801
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Andreas Wild <andiwild@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Andreas Wild <andiwild@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260801201244.4421-1-andiwild@gmail.com
---
 drivers/pci/quirks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21fd..7cbdbdd5ddc80 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -108,7 +108,11 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &oldlnkctl2);
-	if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) {
+	if (lnksta & PCI_EXP_LNKSTA_DLLLA) {
+		;
+	} else if (PCIE_LNKCTL2_TLS2SPEED(oldlnkctl2) == PCIE_SPEED_2_5GT) {
+		return ret;
+	} else if (pcie_lbms_seen(dev, lnksta)) {
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 		ret = pcie_set_target_speed(dev, PCIE_SPEED_2_5GT, false);
 		if (ret)
-- 
2.53.0




