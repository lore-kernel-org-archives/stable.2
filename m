Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273899;
	b=HwNdSGDTwEziHPEUGWcqriW+MCgpdnF/xQnbqKo4+0GLUTUGG71wr13j4XGEANVZLD1R
	 SLz/+DKzM2ogw3l07ck7APu+4fvJGdu3P6XzFVwAwqiYhtrfwx1/4SykQFXiGNXnP97o/
	 p2e3DgWyPZhY14cY7tYcktkLxVo6BOdEkvsDQInCEzKuLXUPYVSuxAMeFTwMQUzB0YNwe
	 /a69iqlUYWieJfoUwIy7Sx5Sojvh+Uk/aOpcFSbbLTFLFQRHuh+DqY1URNwULHKnWSa00
	 IN2DwrWs36grwGUfTL81FP4+W2UnRLxj2yRpVDIdbyeSJCAcYfzNEHebjaFgaTcRw2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6WQiVrdr2WVkVbweONo2KJELfLYoXSmMXMrP79G6sn8=;
	b=gZ5sQ01ObxH5GIRbjbmWzdP3zE5Kt6FPtqf4dl3YMVrbl0UbcciDe4kHHQRdmuIbR1yI
	 Kp2AAK/NUdm32f8EJnQvFIRGs5/eIIxR9nfeCRQfCKMGjvzpD629fu2c3np2CB5hBld5U
	 WLnBJoGeN2OSVL/LmIb0cbNH858QegcEziBUeY3oelwdNB/UCe9WHiaViXm4zHAjeM+hl
	 1ylPKHZrg7uaKoaAZwi595Ll5PbJI14LTPJxK5L1JjIHfw4M7WxEgKnJ9SFxNGPl42x06
	 jfDtNaEUita7ok4W5u6K23gHMI7ThzqDskjTjSJmqsYssi3Pl8vtJ4LKMCKlLbRZHsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRIhteFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F76071840
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRIhteFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5871C1F0089F;
	Tue, 10 Nov 2026 01:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273898;
	bh=6WQiVrdr2WVkVbweONo2KJELfLYoXSmMXMrP79G6sn8=;
	h=From:To:Cc:Subject:Date;
	b=WRIhteFuAc9qsOAyg7vsihT6aBqSjDkK6zF+o4tpgCMGpqDiklDzbHcXIke31UHyP
	 3IZaRz+j8NqTFsq50gjq/OmQbh+rfo/3KelmC8RJ8HJmE8Vcr2TA0MYwgwdv7eWBzN
	 lZqXWKIKYf4Vy1b3XRKPdouf/emlTWNdHYxVtPVHPoLYdyWp52sQO6YTkw0ErWaL9P
	 P+0XS/HZnTgrKOOeA4Gsp354S0A7JTcAPRqWLFnvgYJbe0Oo8GAJSRX32kzxMKVVYa
	 pbRceK0qFW22Y8F/mTYhu+2OVdspc9dY6xhf7bSp8CuEK7BfqSlFWhSehq3LhDR2TO
	 2/IaqEJzQfMag==
From: Sasha Levin <sashal@kernel.org>
To: akshay.jindal@amd.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:57 -0500
Message-ID: <20261109202457-failed-5.15-e62df37e0eff@kernel.org>
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
git cherry-pick -x e62df37e0eff4d670e78bbd415be2c1675883c15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202457-failed-5.15-e62df37e0eff@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e62df37e0eff4d670e78bbd415be2c1675883c15 Mon Sep 17 00:00:00 2001
From: Akshay Jindal <Akshay.Jindal@amd.com>
Date: Thu, 5 Nov 2026 16:32:17 +0000
Subject: [PATCH] iommu/amd: Skip non-IVMD entries when parsing IVRS memory
 definitions

init_memory_definitions() walks every top-level subtable including the
IVHD blocks (type 0x10/0x11/0x40) in the IVRS ACPI table. It interprets
each one as a 'struct ivmd_header', solely on m->flags, without first
checking that the subtable's type actually is one of the IVMD types
(ACPI_IVMD_TYPE, ACPI_IVMD_TYPE_ALL, ACPI_IVMD_TYPE_RANGE).

    if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
            init_unity_map_range(m, table);

IVMD_FLAG_UNITY_MAP (0x01) occupies the same bit position as the IVHD
flags field's HtTunEn bit. Unlike real hardware, QEMU's AMD IOMMU
emulation sets HtTunEn unconditionally (flags=0xD1 for type 0x10,
0x11 for type 0x11), so every QEMU-emitted IVHD block is misidentified
as a unity-map/exclusion-range IVMD entry, which subsequently results
in the creation of a bogus pci segment. Eg:

    AMD-Vi: PCI segment : 0x4000, last bdf : 0x0000

Fix by checking the subtable's type before treating it as IVMD.

Fixes: be2a022c0dd0 ("x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices")
Cc: stable@vger.kernel.org
Signed-off-by: Akshay Jindal <Akshay.Jindal@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 drivers/iommu/amd/init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 78c7079dec9d6..3dd4ff145e552 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2776,6 +2776,15 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	return 0;
 }
 
+static bool ivrs_block_type_ivmd(u8 type)
+{
+	if (type == ACPI_IVMD_TYPE ||
+	    type == ACPI_IVMD_TYPE_ALL ||
+	    type == ACPI_IVMD_TYPE_RANGE)
+		return true;
+	return false;
+}
+
 /* iterates over all memory definitions we find in the ACPI table */
 static int __init init_memory_definitions(struct acpi_table_header *table)
 {
@@ -2787,10 +2796,11 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
+		p += m->length;
+		if (!ivrs_block_type_ivmd(m->type))
+			continue;
 		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
 			init_unity_map_range(m, table);
-
-		p += m->length;
 	}
 
 	return 0;
-- 
2.53.0




