Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794036530;
	b=CtbGqn4nQJaLpCJlZ9fEjuV3r8s/z0Qf9ziLmdNjyqF4jiFmfv1JkEJMcYHaK2OKlmBF
	 WhGGawhL76tFlsW1Fx4bboCimlxweeCuTRbSjO7xWv+TkDB4MXvVeDbjBk3DvX/OBM91J
	 c2rDr5yIpvSC5R8a8L7r6Abug21o2f3xYSXoyA2L6Vpq2TALAXUGykmEwlumHIP5R6oTi
	 LsgcmKprHLaNWMwHCzSq2Yfz64DaEpUN4t/IApbjeaheE9AWrCvJWdHceV2mQsTgOZHyP
	 By0dpTqVJt3yGIBqMN4mVMQviADW2312b8GufWR/NhtYy3+4pal7iT6L5L5BtDCYi/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794036530;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=3HWUg5FNjyVay3O5xAbrgZ/pPYrYvOt4d7ooGVwU3ac=;
	b=a92SQEwQl23YkFPHejQ5QarKv6ugN85a7+dhXkUowQoCQ2rahhKF7C+kMOWT3Tvu7/qi
	 IzIzmoZhuIvLiaYBwbwaUlTh9nHoLbl7EWn5xFmYO8yYbQ5RIeC90FlsKAoReaeDzIM5Y
	 UxgQSWMJTg+5oCsLmYPPjJRQdtLiudwtbIqJLmEhsuVlnzgOrPYFOLEPBlbYsMuYbplwR
	 GgRM9B3B78XKcvIJP2Yjc5at/U1JlusZy/tao17kKeYcAgMuwDK9uHtVRWInj+3//5ARj
	 FFsNELm5J9wMkA/YUCVOFdaE/YnfdOuPzCVaG7+yNEQnuhDHw9NLN1JaGeAOrgPrVnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCPwVL3G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E8606A326;
	Sat,  7 Nov 2026 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCPwVL3G
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794036530;
	b=l3TyIj+jAMZpwOrVg7wIyUd4XU0xzGuybh5HImfWpwF/mjCvfkFz3yLYxYsPlrVnr1zv
	 YGR+CO39s4eWpvraxkoz9fSRnRaq6/2/78kNX0pZVuZo7oFGc7YK66T8VD1cq21LGVDVo
	 8W70U31gJ1OSDWAFMF5BR5SH6zww3acPcdgXu2xlnFt01YWbskstIihpzNgQFWFnD9zoq
	 /yH8TeD0Taw7CR2UePknBSU7oWMeqlKVOikofRljkDfyipc96NscBfr/zg4jZLWzh9QoB
	 /GfvapYIKTCpvgEj+ZItJHJpEh4DtBPluJuauwoJYUhOnnGapfy7C2ucyzFpp87eWxA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794036530;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=3HWUg5FNjyVay3O5xAbrgZ/pPYrYvOt4d7ooGVwU3ac=;
	b=TJyjeWPooVdgcZfZqMYvwZPAssFdVo+bH9jUchZxT5VCLf8hpyOl/K4hj9En7Bad+a4d
	 ZUIm0j1bzY3DEs/LNDFtYhidaknkNFfDvbIq+KGNOXWl3Pqc8oFIlvpSWvR+PhiHbuntE
	 4mp4WlgDt/Uu3yJCYJeK67xIt7W4YIyDqZWrqXpoYcDKN2SLBDQZASe6TsKGa/dcY/Hv7
	 QlonUVI9hDjhir5UObYsXjJeV04rYnZvXO94FSH1LJoZu+iysDZZtgW3oGrPQvPLRxFCa
	 fYsHDTGiC84jAl2jzrGF4ixAXEiKVCiJbgZ1f+uS6E/pm95ym7qrCKKFWayPCgESvwQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7746A1F0089F;
	Sat,  7 Nov 2026 07:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794036530;
	bh=3HWUg5FNjyVay3O5xAbrgZ/pPYrYvOt4d7ooGVwU3ac=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=VCPwVL3GRJN0QEm7IfPsFymYB76ChJ8KYnYtDAGmX+3GezcauUq5p3h9/Otvhamwe
	 sBtKapahdQhPhxrq3B9+if7HijkSGbcOtQVMybOPlR4aEo4NUcVemtYhqjB8frLROo
	 7J38vN6J3fo41V/8x/3UmtjYQZMu6hNZVv1b7sBs5YahFL+AfSgP2Dns3aznXrQI1+
	 1NOX3GCjYHuFx3A1GYXGW64MiX5TWG6o2lbXpKuQF+bg77hWLH92qtIJYRzfXuXemd
	 js8Owf3YSnktW/ExdSRYLL2D29xcebdmIo/+50LAzrw4WRQlt+ZXive6rli+Ze/Ti6
	 7iaJKi+rgpnUA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 07E8E47AF9;
	Sat,  7 Nov 2026 07:28:49 +0000 (UTC)
From: Ahmed Abdelfattah via B4 Relay <devnull+me.ahmedabdelfattah.dev@kernel.org>
Date: Sat, 07 Nov 2026 09:28:46 +0200
Subject: [PATCH 6.18.y] cxl/features: Ensure that count is set before
 access to ent[] __counted_by()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-cxl-features-6-18-y-v1-1-2607e151ffc2@ahmedabdelfattah.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CQAwAv0J6tmS7wkL8CvGwlqI1Bs0WDITwd
 1c9ziQzG5gkFYNTsUGSt5o+xwx0KIBvcbwKap8ZvPOByDXIywMHidOcxDAgtbii830d64q5qY6
 Qy1eSQZfftYNQUluucP57my934em7hH3/AKUozVp/AAAA
X-Change-ID: 20261107-cxl-features-6-18-y-02d5a54cc743
To: stable@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-cxl@vger.kernel.org, Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794036528; l=3408;
 i=me@ahmedabdelfattah.dev; s=20261106; h=from:subject:message-id;
 bh=kGxIhmutMPB0t26HBZzy5K5cqXcRM4FNrQBpPeExzXU=;
 b=PwQHc1r8VxRJDZam1vDQ4PStYycWRpoRAjshq4AdXhb/xvZBBP2SCA/cVsyq1jQEoXYGXGQyh
 pJwZJzcOj9TB+Vqkqe6FLNRd+bhEwH6bJQ4F8rFoc5+495VKvl/2WPz
X-Developer-Key: i=me@ahmedabdelfattah.dev; a=ed25519;
 pk=DHEHKU4PddrkJ/iYMZpwyyXsFyIQ6ySjTttKLrt9YqI=
X-Endpoint-Received: by B4 Relay for me@ahmedabdelfattah.dev/20261106 with
 auth_id=1438
X-Original-From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
Reply-To: me@ahmedabdelfattah.dev

From: Ashok Raj <ashok.raj@oss.qualcomm.com>

commit c1031c2474f73261d8d5e4deef2b5dc20fb964f5 upstream.

get_supported_features() assigns entries->num_features only after the
memcpy() loop that fills entries->ent[] has already run. Since ent[]
is __counted_by(num_features), the compiler's bounds instrumentation
sees a 0-length array during that loop and FORTIFY_SOURCE trips on
the memcpy. Set @num_features right after allocation, before any
write into ent[], so the bound is correct for the whole lifetime of
the array.

This was found via a fortify panic:

 memcpy: detected buffer overflow: 384 byte write of buffer size 0
 WARNING: lib/string_helpers.c:1035 at __fortify_report+0x54/0xa0
 kernel BUG at lib/string_helpers.c:1043!
 Call trace:
  __fortify_panic+0x10/0x18
  get_supported_features.isra.0+0x4a0/0x4d0 [cxl_core]
  devm_cxl_setup_features+0x84/0x120 [cxl_core]
  cxl_pci_probe+0x254/0x5e0 [cxl_pci]

Same class of bug, same fix shape as commit 6c9d2e87df40
("cxl/fwctl: Fix __fortify_panic"), which fixed the analogous issue
in cxlctl_get_supported_features() but missed this one.

[ dj: Fixed up title typo per Jonathan. ]

Fixes: f0e6a2329bf9 ("cxl: Add Get Supported Features command for kernel usage")
Signed-off-by: Ashok Raj <ashok.raj@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Link: https://patch.msgid.link/20260911215304.1816467-1-ashok.raj@oss.qualcomm.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
---
On 6.18.y, cxl_pci BUG()s in __fortify_panic() while probing any device
that reports CXL Features, such as QEMU's cxl-type3, when the kernel is
built with CONFIG_FORTIFY_SOURCE and a compiler that supports
__counted_by (GCC 15 or newer, clang 20.1 or newer). I hit it with the
Arch Linux LTS kernel (6.18.44, GCC 16) in a QEMU guest.

Tested on 6.18.62 (GCC 16.2) in a QEMU q35 guest with a cxl-type3
device. Without the patch the probe BUG()s the same way as in the log
above, and with cxl_pci built in the boot then hangs. With it, cxl_pci
binds and mem0 shows up.

Please also queue it for 7.3.y, where it applies cleanly. There
kvmalloc_flex() already sets num_features at allocation, but only when
__builtin_counted_by_ref is usable, so builds with clang 20 or 21 are
still affected.
---
 drivers/cxl/core/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index bb73f205f16c..0ea5a31275d3 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -97,6 +97,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
 		kvmalloc(struct_size(entries, ent, count), GFP_KERNEL);
 	if (!entries)
 		return NULL;
+	entries->num_features = count;
 
 	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
 		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
@@ -174,7 +175,6 @@ get_supported_features(struct cxl_features_state *cxlfs)
 		start += num_entries;
 	} while (remain_feats);
 
-	entries->num_features = count;
 	entries->num_user_features = user_feats;
 
 	return no_free_ptr(entries);

---
base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600
change-id: 20261107-cxl-features-6-18-y-02d5a54cc743

Best regards,
--  
Ahmed Abdelfattah <me@ahmedabdelfattah.dev>


