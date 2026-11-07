Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049038;
	b=jiao8kPqum1N1qy0Vgx3M1meFU9551fMJvHASb64JhIoMmolQLFLJ4v2JVHxgKk6B9GM
	 6Ptm3dxikFnsNOJ2xjCZc9CjR6aIvT5xyNjb1N9m3vk9pzvPU+2bu77OgPX6xpMR9FqhF
	 qt0ne01kqUkttN4/s2Cmuizs/HbliEKfkWB8r9kGOmwRmQDDv2RUoJeYVN8Exkz0k7sdo
	 g95fyng2J1d/72SWpf0jt7N9syqeEagdtF/XgMD2XIweq98+7bhOM9C44krn3C56wQhwP
	 N/mZ4GDOuVkzN29GUCQTZNTnS0b7o7ihDvMvirapCYQrYh0Q7E32OQ8uP0XdkoZX0EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9nxfzYJuZp87DK3o759Vvf1alnw870NRcs9bSX5mp4E=;
	b=5KlDA5rcuarIpkdt8VpDe280Sae7oVMg5wnSGPJ1sOcuKej0PfMo8Zft6y9sS14HpfIP
	 Em5O1FL+wPBMUeA2zDb/OI7TRvVsjvXVrRFJhNS9few2qYdL5NYl/YuiY5IrT5FU0elIC
	 s0HxdPA4Q8LE+Z8urw94jj8MBbw3CH1IBTDgJgeXs1M5BnUILW+GW44BldkTAh7mJtaOq
	 IPIWthgJQ9HLBQscUZXAff/hV1/H9kY18MeMKXTztK7WKoJ6DwbUYpSmAzThmYDfy6X94
	 r/TFByAE1OuRpuNhzOI6+RuOR6RYMYtj828V0XC5mLDHUzwx3OkQl9aV84a8fd8aEPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjpKudWT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjpKudWT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B411F0089F;
	Sat,  7 Nov 2026 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049037;
	bh=9nxfzYJuZp87DK3o759Vvf1alnw870NRcs9bSX5mp4E=;
	h=From:To:Cc:Subject:Date;
	b=WjpKudWTdau8d9z98Iq/DF6cBtWWqKEOrU/WgI1MVXuppb8vFBEdNdN2BN4uLZJUE
	 GhO13sv1aDX4UnK0ZKxdP2nGvzq5kB4dLkGzQdeBnrrqqUloJsWDSiWIcrYzLypolm
	 CSAN8rxlxa7olZ3tfbaMR3WoI/HxEGAD0ud0Vny/wsYIjt9NmSdFwhZwdhsYG7IW5s
	 8sU4N+kREo5+O5J/sO06NiuL+aOIxhgj7gDLfS7/WSvVL93XTEoh6GwUArIlaayMBb
	 IQtyCsjDi+oTb7rtGvnz+vCwalv6Gta4JZQN8fWIkY3UlUZLq0XEFa4uQxRsDiRk90
	 cgY19i+QJJvgw==
From: Sasha Levin <sashal@kernel.org>
To: kartikey406@gmail.com,
	jani.nikula@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915: Guard against NULL driver_data in i915_pci_probe()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:16 -0500
Message-ID: <20261107055715-failed-5.15-272792208467@kernel.org>
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
git cherry-pick -x 2727922084672cc274ecea726ea00363c2893731
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055715-failed-5.15-272792208467@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




