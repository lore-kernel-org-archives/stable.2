Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045798;
	b=UlsjaMKnzYk4ddal0VOkM2MjfMnE/lqy91uBIJM3Zp08wo/L+2+xF7WiTZur457s7T+0
	 LCYOMRFbbrkkdNw8UoRhGnVlTfU7skx24/dclVDckCUjq8ECch2BIgQQeWkldrCSUAfPh
	 w1XJ7yvk2AznazABgZwE4mmEJ55OfEwy9MZ63M984QE13Y8MjAOKMC59eGgIUgCl3sdXM
	 BwLXZDv1JkeJ+v+9oxogMftVvoWH2srvyaYcqRZxnoVmStv0jphCoqntTa7ScxlyygqTT
	 WvfiADG1VIMh0z7LUNiszMUPH0F3IKDXDSVmVZbRcyT2Bin+xPLe+ccYWdL94x3AwVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DcAmRD8cD5nfkuOTtG9Ju67kAIfXKWUV+G74ZkKVqU8=;
	b=GCzXQyT7XgDABNVCQm8w2m0MR/7K4D4QD8TYV1qvWFa9jlIlsSlV/sq6EwyUH+/1FRTE
	 PPtQaC88jOGNVXMX65yoWG/0/JjyTVYqICogXZvbQDCV1BJOqbPGrht1nxM9B1T7IZDn2
	 VgsgIYJmMQaVAA9vCJeqMCaWkNHxU/8O0GmvKviFV8kbSMQy6Vm1AYHp0olnThpvxCPkc
	 AATrc63445lDbpKQ5why0VkPPNn7CFORsS5nxCbhotx0jJfc/EXoAOuCxy24fz1HUB0oe
	 /q61o1qiQu8IP7pMPhLE9DdHHq9GkppJQgO8oaTQgsBygWf5HefLUiieKpefTRnRT5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqT9dAu3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40020606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqT9dAu3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9798C1F0089F;
	Sat,  7 Nov 2026 10:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045798;
	bh=DcAmRD8cD5nfkuOTtG9Ju67kAIfXKWUV+G74ZkKVqU8=;
	h=From:To:Cc:Subject:Date;
	b=hqT9dAu3IHEMPxuhMs4r4VOEMSRYOfaXDqfwV2UUxQ6uddi5cbwjjPlFtWH904smA
	 zcjS72iIifu3mp4RgIvYNIWAe4jxsRWfVp1eMytS9ATPFXWh24HXN/j6sUGtgFT/Go
	 cuCQ6Jo2JmQ/0vl8F2BBabQlsn/G926q9FuMZBbhzBZ9K0UExM1ODTg4LngCTOhals
	 4d98nX138MWY+4BoDN0MObrWpZANBfX0NxnS5AmWeFuUL/SN2eT3+MsUSEseLq3AeT
	 pTPRmE5sZLpjya8POJion/dbw2/Xk5WNWwcrr4u/nNnzdOQ1pUXqqtvGiQLG6H3Ydx
	 ioJYPbp5XBAkg==
From: Sasha Levin <sashal@kernel.org>
To: ankit.k.nautiyal@intel.com,
	annoycc@gmail.com,
	nemesa.garg@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:16 -0500
Message-ID: <20261107050316-failed-7.3-550b703fdbb2@kernel.org>
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
git cherry-pick -x 550b703fdbb2a2022faa75b4b11ab135241afbd9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050316-failed-7.3-550b703fdbb2@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 550b703fdbb2a2022faa75b4b11ab135241afbd9 Mon Sep 17 00:00:00 2001
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Date: Mon, 7 Sep 2026 09:15:55 +0530
Subject: [PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus
 14-ew1

The eDP panel on the HP Pavilion Plus Laptop 14-ew1xxx advertises HBR3
while leaving the TPS4 support bit clear. The output however flickers, once
link is trained with HBR3.

Until commit 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink
doesn't support TPS4"") such sinks were capped at HBR2 by the TPS4 check
which incidentally kept this panel stable. That check was reverted because
other panels legitimately need HBR3 without advertising TPS4, and the
per-machine QUIRK_EDP_LIMIT_RATE_HBR2 was introduced to handle the affected
machines instead.

Add the machine to the list of devices that need the
QUIRK_EDP_LIMIT_RATE_HBR2.

Fixes: 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't support TPS4"")
Reported-by: Annoy Cc <annoycc@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16743
Cc: <stable@vger.kernel.org> # v6.18+
Tested-by: Annoy Cc <annoycc@gmail.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Nemesa Garg <nemesa.garg@intel.com>
Link: https://patch.msgid.link/20260907034555.2753846-1-ankit.k.nautiyal@intel.com
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 33245f44c0d50..7d7db774d8c7b 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -257,6 +257,9 @@ static struct intel_quirk intel_quirks[] = {
 	/* Dell XPS 13 7390 2-in-1 */
 	{ 0x8a52, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
 
+	/* HP Pavilion Plus Laptop 14-ew1xxx */
+	{ 0x7d55, 0x103c, 0x8c31, quirk_edp_limit_rate_hbr2 },
+
 	/* Xiaomi Book Pro 14 2026 */
 	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
 };
-- 
2.53.0




