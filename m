Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050060;
	b=LyfeVhVgDRExUiMxMYSdP8VovPzAWliaDjrWC+6ArO2XdKm8iAeud4X3zyZUrXk9HXu8
	 fhPr0Aj3GXxPMLt1r5R0nb+sLXzC49P512oQg5CbSYiRAyDoJuOtQr54Ct8swatrP1hQD
	 XvQnFkkfH6v+UkkUuaVYERH5mw+yTU+dpx+v5sYcKenZuHJ27I61NqBh1SEa4uQRLDPpT
	 QHYbsHkEqA22BnHlXcOsY4S+cYN9IhZaZ2m4J3i1TCwMbkVHr5dx1ikgzYcO2QBd+RKIZ
	 zIFMeCjX5m7SQD3TMpeaxB5zsGgavZTSF/oY+ypsUx0JvV2ubdjfyLSD81PqhyFdDDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050060;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C4M9r4YuyX5BTTrZN+uqJS33qp+1QY5/MaMo1DlXgUc=;
	b=YkAcw9zqi8wz4tIWqnECEIhbjtCooBkYRkhLYd22v1swq4cH/2M2w+bQAE5GtJiJRAT4
	 9gIFIxd1ZjESe+RVCt0ghzZWNfYybpHTFipCzyPjFbtkC7K+n+DphMAknbp7e1GW80/9h
	 /2IC6YLEtOsHfwQIctu8ho4LU+sS6spCnLUV9IU+8kiugcZbvMCuHC3l4uu3HOANJFbrr
	 m9MAds06EVJ/bE7/HijDfoS1Y9YkVl2yZ8FEo0N3NpN++Ub097KaJt0zYYk4esh90t5Ie
	 1hkMJziPpk7r7LaJRXIOE3du4UXP7QqbEDr8ZlvaPfnEH78OfJ5/CfOZdcVja+ceAOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAGucn6I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60E606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nAGucn6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B071F0089F;
	Sat,  7 Nov 2026 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050060;
	bh=C4M9r4YuyX5BTTrZN+uqJS33qp+1QY5/MaMo1DlXgUc=;
	h=From:To:Cc:Subject:Date;
	b=nAGucn6IaC92vt8TJ3khOCYUYTcat5qWH8pMIbED/Sp134dxAhSy8TjqEordm80W6
	 3OnjieVSkKQeClK9q01I+umUue/kP30IN+6sYAYoU3i19s2vrrNW6TpblRTnfQAZwB
	 q6acaR5Bt9nQbGKOhwb2OTpFbC+9t81cda9VWedvU5pzWflg2EiG0Gae2jJ88HlEf+
	 ujbRnlJbE++Hr8woUr4Xajh5yBIcsRz6PjWMcQphIfk5pUm7RaqALEB8bOKiusJilW
	 fmtgBPEMoLdRpGMaUTVRPMdx49ZmoaBbmpQCBLpULy5JrDzbB4qTmAuEMsoqtEcHHf
	 z45/Q491JF/OA==
From: Sasha Levin <sashal@kernel.org>
To: kartikey406@gmail.com,
	jani.nikula@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915: Guard against NULL driver_data in i915_pci_probe()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:18 -0500
Message-ID: <20261107061418-failed-5.10-272792208467@kernel.org>
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
git cherry-pick -x 2727922084672cc274ecea726ea00363c2893731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061418-failed-5.10-272792208467@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2727922084672cc274ecea726ea00363c2893731 Mon Sep 17 00:00:00 2001
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 13 Aug 2026 12:19:02 +0530
Subject: [PATCH] drm/i915: Guard against NULL driver_data in i915_pci_probe()

pci_match_device() can return the dummy pci_device_id_any entry
when a device is force-bound via sysfs driver_override, in which
case ->driver_data is unset (NULL). i915_pci_probe() casts it to
struct intel_device_info * unconditionally and dereferences
intel_info->require_force_probe, causing a NULL-ptr-deref.

Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=db96c5ff032f4292a8dc
Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Link: https://patch.msgid.link/20260813064902.367504-1-kartikey406@gmail.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/i915_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 82415af47d540..2f03f95945f1b 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		(struct intel_device_info *) ent->driver_data;
 	int err;
 
+	if (!intel_info)
+		return -ENODEV;
+
 	if (intel_info->require_force_probe && !id_forced(pdev->device)) {
 		dev_info(&pdev->dev,
 			 "Your graphics device %04x is not properly supported by i915 in this\n"
-- 
2.53.0




