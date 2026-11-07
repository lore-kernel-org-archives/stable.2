Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047372;
	b=vT0CglirXK31PYQ3dA7Om5qbDM4oxCTeidzpRr393oTPz47Ns8madNhv6mBlEm70fv/7
	 jKCWxCdHAPB6pmPmR3raLqW+lmaeoWMMPSqgAShkEvlghGhdaSLr1Mzcl/LC1XRn2KR19
	 5KOfqJnHSMsREIEzmAn8tME2sPCXPp8PWtUJzz67eSLopbZxHYZuI4zpDQkIYtClhvqKx
	 nDkDqHmjjE5HM+dF6V59EVC7DcQMSGBGrM+BYClElmye98FWtEVsvMw5KBLQ1HMfZPeGH
	 FIU/frpidwyAGim4KuRvxWkjr/hJ033TUTveuk8mifFx8pbd3m3wklHbjw4YAsAfuLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047372;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I4WdEpqINMePfnqhP7uukQfAIEuFnZcmh523oov9EJo=;
	b=drsLJaOK+ZQrf+C/Sf57MGhs8qHC9yrkbV+fWQ1hf5vviVwrothdM5WKzGdNyabjZkvR
	 h0xDJ7JuxUyloHX0FITVelkAMSdnFI3zGdV5dxloLc75Ou/wuJTCfPzsPDFbNufbdWOxD
	 m82twF9sLWbL5M7yHguozpwTx7Q6ZhQEERwoWMEq7eLznjiNzWDBLNd0tXLsKGl5vqt6Q
	 hs1FXuCAdabZTcSWgfYTUVetWTCMAZxKLHGFLs4maKnh0jm6z9wKXj5o0szBrXzcfaGI+
	 Myx4oW5uj3725HEeWXtKHqqQApOco1F7HwWyQYaZh6Y/mK+/KVXMOajn/sW7iU5+Z5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lBn/vicQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B1606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBn/vicQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7778A1F0089F;
	Sat,  7 Nov 2026 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047372;
	bh=I4WdEpqINMePfnqhP7uukQfAIEuFnZcmh523oov9EJo=;
	h=From:To:Cc:Subject:Date;
	b=lBn/vicQ/t3950uLSu1aS1QzK5nYmnl6ac/vog/YvaZ7X0pAYLYCBcF7U/v89pcLq
	 zQn6lOFGMDnaoaMS4Nux1CzNBD4K3rD7lu9+3u7LircZkyJHzlwAGho8R/H3PmSeAp
	 1PDS3Fv02f5f2Ql4jeUyScOLdnEn9YPkAYAPmsC+vCH1sDCphzCqEilAFD55gxjpCy
	 CCo2QlxGE0TB9lTsya4+r0Cy221mQVX7oj7OLK7FpcL+UXGaJKfPQp52DIqVHFScGY
	 2np4bX6u2XMrqrcYCzh9v+T+l0Ln5bhiw1AzauF4btjALJ0yvZxeyOrLouhLRNfm0f
	 jtQVV+ZhSElVQ==
From: Sasha Levin <sashal@kernel.org>
To: macro@orcam.me.uk,
	andiwild@gmail.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: Skip Target Speed quirk on clamped ports with no link" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:30 -0500
Message-ID: <20261107052930-failed-6.6-ff8a969f7dc8@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ff8a969f7dc8e79ea6113abcfa983e070b2b585a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052930-failed-6.6-ff8a969f7dc8@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




