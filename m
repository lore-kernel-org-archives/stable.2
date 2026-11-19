Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795113203;
	b=QadhOrOPG6PcmSTGgzxvzT3CHTuxTHDUNtoOYTdYFAuftXwHGpuoRqnkIbRGAiEABeCg
	 Uhe7QsLGdF0z8trTYoNnxPCw2dTtsg7/51abl3cNmini8qUyOCUnd9PI8uqE7kDJ7KLpk
	 GJTRnzBEqgJDkoYpB9j6QJ1AmA6zo7ZfxOMgOWoFtD57BdG70CiZZC2BicDX4jgOIr5JL
	 Wa/DsdjVhhY7MolozhbukQDslOTOzaN+lcaLDmDdMKOliIfX0dQolb6VECGycOEamaqOC
	 m+HBscW4CmPM96qtdCRKggDuC+SnXl48EZ5GCtqdfQr7gkxfs2e0ndovxpTbfxNU8Bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113203;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pHywAss4SUFaOVdqoHSlrUORbDZHaQKBA7uBl+sRzDc=;
	b=bsR52krEiYPE1M/o/WBCTkp6pAtuJDp6oVge5PYUFdbnCy65VilqyQ3y+dK965oIlLaI
	 97CLeNRqdJBWAfUtSqsFom4x2mARWa5HbRnOpcSoaOzny3QthRrL/z/ypTUQMc3Cxsu8P
	 pYZEIkVahmpas2U1PTX45+fZTNC4/xstkK4JVl4m//AtYRDlwqQBseaz+KZ5+xleL8ZUb
	 6VFnnklFeG0gr2KkhGdyB/8+jocTRqYnY07zFjDzUkIEPrqoQh50vY+wqyS8NE9BuUWBE
	 YH11z5LVyYHeUduIokUPl29/k2lil46u8EH5LHeBwtYQIC70RqgZ9sgN1+3MLVvy7+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYSiMv7o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED8606A325;
	Thu, 19 Nov 2026 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYSiMv7o
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795113203;
	b=tKdD3fRkguifYwfAfOKiHsZrY+A1Qo3exQBm9WDpcsLVPIGe6HP3ZJ55Ec/rBOqLEBHr
	 SacMQaP7UFER2NVZmT65WVxya0oF+tGZ+W/PfOeWC4ZZ0JArItB5qepY9uR3lTI1kwHVK
	 hRQQYJhEYbjqS45snkD7/R/3Mp6QdRFMUB5o+09BIB34BggCHTjr+ytYxzIv3/0f08HPD
	 FjSAm6CaG/aybebZMpE/LKedNPacAjE6yew8d5zGt7MxAHEfz3dHAAspazyyiyeIwsWv/
	 khAxYN9wxA63S7R6BznTNwpOmFQEyf41gc4yyto0D3NuL5qXFUPnLeVVocrjre1Xbpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113203;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=pHywAss4SUFaOVdqoHSlrUORbDZHaQKBA7uBl+sRzDc=;
	b=OmRlC/6FgVFGAu9m0trK1kh66LrUNNkWIJ4FejEj1cqJGV6YDIv3IxuQCsFnTaNeieUG
	 xeoyewCgu+5vCBamuBX7GU+8LNK6Zmm+VY6rs+t+lSK4BzILNZMbBEceF0LkxdgzsPYlv
	 hEX2CG7Ox9cA9j8ZGzFDpLIF0RxyE6fXGJH3qHZPRFFn44Hr8fnl6RxIl72BG1gOMla0e
	 gf1rifzuF+VoDfm5tsKtmeDaA1143bZo+psi27ey6qcRIHC+5lXsOySVlDJ69QReJAXTB
	 HnVs4prki02hVfYV/eADKOMs/Li+WDdgzoqPMPUfU8yEAm1McoHvOzkmRMSFmh2CG6Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B1E0F1F000C5;
	Thu, 19 Nov 2026 18:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113203;
	bh=pHywAss4SUFaOVdqoHSlrUORbDZHaQKBA7uBl+sRzDc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=BYSiMv7oAi0YFfXivgSpiwe4mCX5uLf8wWOkKBd5qlQM4X3u0qtoD5Vrd944WsPoH
	 DA2tVQ914ZaVh0U3fUDfN2ZoT4Ojf7lYIFzTbVBY9lkFLFKzfEXI+8eCEWmwwFGZ/g
	 tgtp9vJ0JmL/nCHq3y+SMe591ATq76RhqZI7mjGj1zxLEXUnbsUdsrFe5uKWbx38N/
	 IgpPDKzrOfJKDz1WV2VROZ4O03FmI9sw+3fVeyVuY9U719mObt7oU542b8N2L5Wwru
	 vX/WxyVrqaolhpwyaEVQ/b0hjT8fZ4hCM7laa+z/Y1Alo6AqUpe/xI4uIrVixQbucp
	 dpvmZqzWc7big==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 43D8C4B3A2;
	Thu, 19 Nov 2026 18:33:22 +0000 (UTC)
From: Ahmed Abdelfattah via B4 Relay <devnull+me.ahmedabdelfattah.dev@kernel.org>
Date: Thu, 19 Nov 2026 20:33:21 +0200
Subject: [PATCH] EDAC/ie31200: Give each DIMM two chip selects again
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
Message-Id: <20261119-edac-ie31200-rank-stride-v1-1-3514fcccb130@ahmedabdelfattah.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORtoulnQVxEPXRM1ClWSTYSxd
 1/V43f4/wVcTMXh2C1g8lbXZ22gXQfllutVULkZYoiJiA4onAuq9BRDQMv1gT6ZsmDmsadBEqd
 9gpa/TC76+a1P5799Hu9Spu8P1nUDX+oDgHwAAAA=
X-Change-ID: 20261119-edac-ie31200-rank-stride-adb314e6d656
To: Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, 
 Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795113201; l=3793;
 i=me@ahmedabdelfattah.dev; s=20261106; h=from:subject:message-id;
 bh=VP8SCFbiML+yq2OXuS5I12VRNITneI1RQB16ykCjEfc=;
 b=S+ImWECOBViK7xaKc+IUCgF2y4TrPCmCl9t23ueND5tdDMfApnbzaC+WxUEvF92lL+Jnrhntb
 70pqRNLn8GmBJdDSQM3J1yQ1VaV6Rg1/NciQCDDGMQKx/ctMh+pHEk7
X-Developer-Key: i=me@ahmedabdelfattah.dev; a=ed25519;
 pk=DHEHKU4PddrkJ/iYMZpwyyXsFyIQ6ySjTttKLrt9YqI=
X-Endpoint-Received: by B4 Relay for me@ahmedabdelfattah.dev/20261106 with
 auth_id=1438
X-Original-From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
Reply-To: me@ahmedabdelfattah.dev
Content-Transfer-Encoding: 7bit

From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>

Since commit afdbc3655556 ("EDAC/ie31200: Make struct dimm_data
contain decoded information"), ie31200_get_dimm_config() puts rank k
of DIMM j at chip select j * ranks + k, where ranks is that DIMM's own
rank count. In a channel with a dual-rank DIMM 0 and a single-rank
DIMM 1, both DIMMs then use chip select 1: DIMM 1 overwrites the entry
for DIMM 0's second rank, mc0/size_mb is short by that rank, and errors
in it are reported against DIMM 1.

Before that commit the stride was a fixed 2, so DIMM 0 had chip
selects 0-1 and DIMM 1 had 2-3, and the commit did not mean to change
that. The error path still passes the two-bit rank field of ECCERRLOG
to edac_mc_handle_error() as the chip select. If the controller reports
DIMM 1's first rank as 2, as the old layout assumed, those errors now
land on an empty entry when DIMM 1 is single-rank (or when both DIMMs
are, as DIMM 1 has moved to chip select 1). That trips
WARN_ON_ONCE(!e->grain) in edac_raw_mc_handle_error() and the error is
logged against "unknown memory".

Go back to a fixed stride of 2.

Fixes: afdbc3655556 ("EDAC/ie31200: Make struct dimm_data contain decoded information")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
---
I ran into this with a QEMU model of the Kaby Lake host bridge (0x5918,
skl_cfg) that I wrote to exercise ie31200_edac; it is not part of
upstream QEMU. It fills MAD_DIMM in from the configured DIMMs and
reports errors on DIMM S (the driver's DIMM 1) with ECCERRLOG rank 2 or
3, which is the layout the driver used up to v6.14. I have no machine
with two DIMMs per channel to check what real controllers put in that
field, so the "unknown memory" part rests on the old layout. The size_mb
part only depends on MAD_DIMM.

Tested on v7.4-rc3+ (4405c18c95d2) with both slots of both channels
populated, injecting corrected errors on DIMM L's ranks and on DIMM S in
both channels, and an uncorrected error on DIMM S:

  ranks L + S  without the patch                 with it
  2R + 1R      mc0/size_mb 3072 instead of 4096; mc0/size_mb 4096;
               DIMM S errors on "unknown         DIMM S errors on
               memory", WARN in edac_mc.c        csrow 2
  1R + 1R      mc0/size_mb 4096; DIMM S errors   mc0/size_mb 4096;
               on "unknown memory", WARN         DIMM S errors on
                                                 csrow 2
  2R + 2R      correct                           unchanged

On RPL-S, MAD_DIMM can describe up to four ranks per DIMM, so this also
moves DIMM 1 there: a 1R + 1R channel goes from chip selects 0 and 1 to
0 and 2. ECCERRLOG has the same two-bit rank field on RPL-S, so I think
two chip selects per DIMM is still the right split, but I could not
test it. Qiuxu, do you know how the RPL-S controller numbers the ranks
of the second DIMM in ECCERRLOG?
---
 drivers/edac/ie31200_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 88af77ee07fe..1ef91cbda291 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -461,7 +461,7 @@ static void ie31200_get_dimm_config(struct mem_ctl_info *mci, void __iomem *wind
 
 			nr_pages = nr_pages / dimm_info.ranks;
 			for (k = 0; k < dimm_info.ranks; k++) {
-				dimm = edac_get_dimm(mci, (j * dimm_info.ranks) + k, i, 0);
+				dimm = edac_get_dimm(mci, (j * 2) + k, i, 0);
 				dimm->nr_pages = nr_pages;
 				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 				dimm->grain = 8; /* just a guess */

---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-edac-ie31200-rank-stride-adb314e6d656

Best regards,
--  
Ahmed Abdelfattah <me@ahmedabdelfattah.dev>


