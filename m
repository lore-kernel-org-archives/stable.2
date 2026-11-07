Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045771;
	b=yMDBukz0uGMhIjGrQO2sCLtopjW2LAGMsHBVY04j6iXVkIqOHktZAbsOuFae0DTLeH/7
	 R+z+4xkYdIQC6krKtXoX/qwhUe6DySye+2L+aU47AHr48X6xqtRLWxeuSUgOsGPwbSwog
	 18f5mPJSmSHZ8xEfuzinb7UmNR21s7ZY+O7g6CWjUxzHxOXo0egvi45Vu7+3VS6XxqPGh
	 kYxuGFwana/Jt9FeUKcm4VajLEEu8Tp5GP6xs5kSlCFb4I/52Sj0IlG7kRK6DzncEFldX
	 9a7ztE+NSpHg7qk8p/LVR3QHUtxrJl6s4xlh7QEAXBev+wyXzdino6g+IDmbtD64ROw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T2xS6M1dbPlo57MPBypPBNkqsFvVkt72OOsL90v0aZ8=;
	b=THMksygvsTBZcGom/M6k4VyGIDO0/3tKEeimSX2C6j9lQs/vZlgkbyDjX1H/6HLZ04wE
	 LsQ/xkjkJj1CAobRjfl+XoDZs5WXtPhrLbEJ8h/iXvAW4OAxACKuU4dpuB1swu5zAKp/n
	 KxuQUuC+VhHM8OVe09Ir6EsjJTFfu5kkqGf0ztACYPhsNzulELdp6QWc44qJxmEQiQZ/N
	 w2vlizFtqyJAE+iCVQzO2sjdGXCPvjFm7iO7CIN/HnC/gbeMiZwo3RgVTDuCz0YRx1OKz
	 oGObIS4o5iOBwFJaDiUc7E6LfCCUPKCX1a/q59v89e/JNQxOEfSDuHUfOQ3JT7rg3+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bMzf65H/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A5606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bMzf65H/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3777D1F0089F;
	Sat,  7 Nov 2026 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045770;
	bh=T2xS6M1dbPlo57MPBypPBNkqsFvVkt72OOsL90v0aZ8=;
	h=From:To:Cc:Subject:Date;
	b=bMzf65H/Ep5zhhT0KptQYjioRAdlSRW5oW1gWGSy4rv3eRmw4fkdQEuH+NbI2oi4n
	 x3j8n5EBGK2IibHiWWvgZmHtcd1vKB2sPxy9ZM2DO1uv6a9cX60AdJb6pRIyrCsHHl
	 ron/J8gMQ8Ka/GLteUwW4HIXxspDzmZPH2Qb+f1AQfpOvaO/WrzOPeY6Y7FqRYAq3o
	 NjU36DLwdJD+aI4I4gHt1tQ07tqTAxt+Sghm0l21KZQmUFZHYDr7YxMS0nrkn2WK8P
	 32zuKKnPQrg6iGzHrBzvgfL2/u7/NTDpQP7aCpBF7Xjg8lOhY8eNB35TyK0+G7MPfv
	 tA2Xa8UORoVJw==
From: Sasha Levin <sashal@kernel.org>
To: kartikey406@gmail.com,
	jani.nikula@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915: Guard against NULL driver_data in i915_pci_probe()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:49 -0500
Message-ID: <20261107050249-failed-7.3-272792208467@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 2727922084672cc274ecea726ea00363c2893731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050249-failed-7.3-272792208467@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




