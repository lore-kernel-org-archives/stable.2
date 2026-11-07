Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048470;
	b=3esZgTt13VOvA9rXZe0J1EkZmVXRpQF4eRJelFNjA1Whz4+AZq6B0u8UJBTm4u+yN4Rh
	 B+zKPVNiIwmEYeLODvYODBRK8HyRJZM585i4se9AxWOKXiCweaQxnk5FwnEPKw7DLw3BX
	 yQFFh4LmcadUkkVU7KjCPDNaLzYrtffyKHxuaJYOvpLAHOQwnnPGjZlWe6eTGtiQJ+xWs
	 LI6R6EYkdZ/5hflYbAlV0lrbDcPDh4/YTPxp6aCDKo6wvQMDEzUUTKkMzatC7eTXbnv29
	 BfCRXEE3sr6BvaGlWZinWtI5qHlt+pEve5PtlU9evthWzgoN3p+6roVPtvzbZdUEnRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=InZoqaZiyZx1DakzXo9A0qc9I8ek6Biepx1KehhirKQ=;
	b=xj+UG07K7wrlhQgR4sdMFXvYEkS/q2Q7gsUUzzQzccPpgBu5p6sGWiCM62c+wkHOv0lq
	 VUlC8wohjSRLCwWbGWGzI8hZ6x71Ql+bNYovPB4GSnDzy1eTZ8RMWvi2FGJg63CN4KkXS
	 82DXWcFXAbTmDmAjJ0k/uYU0z4IxyThoZBS9DtE45HM1jT+yyyOx4SAi4fpeiht8lAjjO
	 F4300DeQrlhXKnrOykrFP0Jz0j5iVPiQCrG+u9K0ppCCm9leZNaV1KnLOrP1+EMHYjUiZ
	 GagYFIBLnotsJ1mP3eFN44NWtAx8CPitefeHBsc/UQvS02I5XhAoadzMEISGiYsF3fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwB0QrSA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C98606A339
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwB0QrSA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97FC1F0089F;
	Sat,  7 Nov 2026 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048469;
	bh=InZoqaZiyZx1DakzXo9A0qc9I8ek6Biepx1KehhirKQ=;
	h=From:To:Cc:Subject:Date;
	b=JwB0QrSAKd1FK9Rp8XU9o0sd2WAa7G5fjqplyvlQc0Zg3NF3YjV4ZjRIHyxFYSqUI
	 xS0Wiow7VuhcV3HFTKsqJQI3BziZ9iHeiHNrfpJTB/u8BYZoFrcyhxoCciH/Abz5k8
	 Upab86MJQg2yBHwc0PJ2F7dNLRa4utj2JKWRKtiUkW4peTQ+veDDCkyx82Q0b6g+HA
	 MWdqA3JQlQ9mJRZfLAPH/j36KT45EkjBbqrpipEzyjF9RUA9Mzstm1jYRJMWzlfxS4
	 so7fHNTDlGynvtSHhbJEbs+BzL9rNu0Oo/tfLkrUG7DfANcIZisNMzjc2GPSX0ZywU
	 osNkGh19G/z2Q==
From: Sasha Levin <sashal@kernel.org>
To: mhun512@gmail.com,
	ae878000@gmail.com,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: kyro: Release WC setup on registration failure" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:47 -0500
Message-ID: <20261107054747-failed-6.1-d3bc005a6294@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d3bc005a62945aec57059201092b12b7c955e5a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054747-failed-6.1-d3bc005a6294@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d3bc005a62945aec57059201092b12b7c955e5a7 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 14 Sep 2026 20:52:43 -0400
Subject: [PATCH] fbdev: kyro: Release WC setup on registration failure

If register_framebuffer() fails, kyrofb_probe() frees the framebuffer
without releasing its write-combining range. Release the range before
freeing the framebuffer. Earlier failures still skip this cleanup.

The missing cleanup already exists in the initial Git import, before
the conversion from mtrr_add() to arch_phys_wc_add().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/kyro/fbdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index c237389888229..94d6af54e6c46 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -765,7 +765,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
-		goto out_free_fb;
+		goto out_free_wc;
 
 	fb_info(info, "%s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM\n",
 		info->fix.id,
@@ -776,6 +776,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 
+out_free_wc:
+	arch_phys_wc_del(currentpar->wc_cookie);
 out_free_fb:
 	framebuffer_release(info);
 
-- 
2.53.0




