Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046760;
	b=KjQ5bjfFeZZV76+iu9T91gQmNBCHlW6W46NKmD6ZCSfczXNrU2qA6UEJD3Sa6MHcURrZ
	 1zsYed1y0tVb6Lz91WWyOXxj7MXVSaDqwpX+8JUy026nygsKL8lo6NBKWvlHlWxLXeT1N
	 JViKeg6xwzbksxxaLFPDesHC6ECOWMeb0IBfZNZ55sL+c+nTHXMM0meH/WpxXyRpx4psw
	 C+lOcBazsivU9DDXfM09tfY+9Rf5lRvvLMpGl+PKSCQjx80DOcTDMxDfFE6XDR4nZw8OK
	 JNcaBXmtgqu0FbYfNye1OeX0J+piJhBMMbXFbUKAg7UZmUCGmPyEIIc9xwHKR1Odrvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046760;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o3YOLUGo2L+Li9lUNmRfAwgyJfTMxwKGKqV8mRl3kKs=;
	b=NOh9H7oIUfLSqM+ma8LZQ1jtC6lVyN8BSTzDnQcKPHAi4YcTYGATLzHJeJIsVqJv92EE
	 s84oofuiqaYLfQCXEUu0ZlZ3vZdZr1Lc+V5mYhiSRTEa2J1g1arHFJrJekb5+b2/F/sUl
	 qeG+5p88Q/h0TqvyN/k31Jh3V0Ho4yrcVLfLIhMecS5X72xWiq4Jy3reSQf/q83ojJ2Mv
	 SFyUGhAYX4kpCFphRwbHfiYmjiWe5n7tMgGUZl6SamyR7kgbPdbfsD6sMjasKMrboIPTH
	 59Cye8TUbEF4pyv9dlHNpApRpXO5JO6L5xBLbqJbRVv2ToNz3iL/yCy+ET6vCOYrClw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IKzG/cwo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C97606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKzG/cwo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC4F1F008A1;
	Sat,  7 Nov 2026 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046759;
	bh=o3YOLUGo2L+Li9lUNmRfAwgyJfTMxwKGKqV8mRl3kKs=;
	h=From:To:Cc:Subject:Date;
	b=IKzG/cwojIv7cUnu1NVB9mF9lRtHUy7pWoaSE8Ue0qn40/jFQS4OM5NV5I8ZDzekF
	 OU6CDwIh2GuSe+lBGCdVAyyWsHYLT3st9lfxskbBMGWTFlC7ewiqEDNy9K+Vdyqb6m
	 /6r5WG2Yi73h4XuROuFnl0EDjmPq1jDlps/5RIjiAmqTHTUMozfG3ONBFw8LKeLs8q
	 /1cFOtNcg8jhhE+Jk80oMeClg4pUnN2nYEG4RWmXdxIs6OAhdMmrWIEw2pck8A92n/
	 CI0o1aM9mrf7ihy/gX+X1pjRFfKY/EvKQRD7jrxacDfQragx6Z6JYt97vwWNIjiEt4
	 mKzVnDTs981Ig==
From: Sasha Levin <sashal@kernel.org>
To: rathodpriyank@google.com,
	bhelgaas@google.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:17 -0500
Message-ID: <20261107051917-failed-6.12-d4c842c3af5b@kernel.org>
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
git cherry-pick -x d4c842c3af5bc52b3ca0b8a7f116114e43b6ba44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051917-failed-6.12-d4c842c3af5b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d4c842c3af5bc52b3ca0b8a7f116114e43b6ba44 Mon Sep 17 00:00:00 2001
From: Priyank Rathod <rathodpriyank@google.com>
Date: Mon, 28 Sep 2026 17:40:13 +0000
Subject: [PATCH] PCI/AER: Fix memory leak in aer_recover_work_func() when
 pci_dev is missing

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues the
entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

This is reachable whenever the device reported by firmware is not (or is no
longer) present in the PCI device tree, e.g. after hot-removal or when
firmware reports an error for a device the kernel never enumerated.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260928-b4-fix-aer-memleaks-v5-2-ba6b94c9c9a6@google.com
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b013b853b5555..a6600801af6e4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1366,14 +1366,13 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
 					   entry.domain, entry.bus,
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
-			continue;
-		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		else
+			pci_print_aer(pdev, entry.severity, entry.regs);
 
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
@@ -1385,13 +1384,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
-		pci_dev_put(pdev);
+		if (pdev) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+			pci_dev_put(pdev);
+		}
 	}
 }
 
-- 
2.53.0




