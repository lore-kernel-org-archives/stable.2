Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906988;
	b=LVG2A3V0QuL2bDRHAT7Y5A64C+CKLQX0GbhHBcalnIGHR6895u5nOMfqSt2Jc5uijnoo
	 AxEJaHmfBExH5UBkA/vmYmgH7GOt3qeWB+lLqIkNdzp2o2M1/N6zQaG4Xh950bYk0irtl
	 E+aQ9QYOyAUJAhOf/9eJVbD8q4VDHvbV5zl/ly0KZGJKDBnXC/h5/n6/+hJa0E39PmZLb
	 wUfUQBXsgzaUnmEIQsZHoyUw5zXxrYLdcfZUSYHpl7Th0xSlVWrHIIWlDwjTQmHqlR6cC
	 UtNnLYA9ZxNB0WqpIbOBRiOrY+bRT2F9qxy7hk+0DLr4coB5Uy3hPuA36HYdHNYstHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=DtHEe0lrgHKpeTNenFZAJ2JyMD75E5FYbOoxTznvRwQ=;
	b=MCGIWKDZy/qzPdwiFDzPdHEKojCfknW5mmo4AObGD5tIOqKBe03QjgFllwX3iSfm1ZbD
	 j5Q3wc/a1DsmbXePqAT3SbpIzuT5eTnIWKma4aKVDv/NVHD6fjs2HeZT3p0l3/peL1ufs
	 RSKe+WwvwBu0A4IVa7aTtOrILdySAsHVH5CGGPPXinWcKV1jNx+5/Oz1j5N55IEiTvhw/
	 vxMiYYZsHFXKsqAXm7KHBubefEYvqaUSsveNUBZoLEjAsfq6HCBIVX2psWk2h9QHaZCbu
	 1hPxD0Tjv3WWToetPANy7sGJ8UquEAVhwXsXzD6r+wmVT9aHJkvPiGQ+yRHLic7EMUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MdlukDOn;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8580606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8580606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MdlukDOn
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6f5a0893610so1644773eaf.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906987; x=1794511787; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DtHEe0lrgHKpeTNenFZAJ2JyMD75E5FYbOoxTznvRwQ=;
        b=MdlukDOntbIKlM4YGZspDKjoX4NaFL03zXlJgKRkyGVeUXb91kAedaDTuG8nouCzSM
         +71KaiZ8MSmlPYQmlGwXXcLCIz6rzp5ks4n83WHANvBV0Gm7GyAVD8Z4Vj3EhUnnHyKw
         KI+M06xh1vUXrWOlzxbYhGGuiqhpcruUSh231AKU849/zlIzVKsRclbumASNkMO/D35M
         nI9f+yeaxCsslMaJMUf73KFKa2EWYH7/hQ5Gi0bzcdkTxiOJJtS6yjioQB1jF8nLhhcD
         AOrqqdGO4hkvdfjlBxVjrchBweDUYTrikic/QYbPb2n7bVDb6vXUeAWopZ6J9qYJC4UP
         3AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906987; x=1794511787;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DtHEe0lrgHKpeTNenFZAJ2JyMD75E5FYbOoxTznvRwQ=;
        b=VIuwPSnCGeKlyelOkm43RrOeP8GM0tN7dj445r8JAiAesAW9j5+zM42dMJ+/qvD0Py
         D+SLaC8MweuG5/XObl/BMD7kxJxZI+bUZvGdwblD1L2zOFiCoEKeh5sObYjkCfMEVddT
         eH2qyhAlPechnX9rAARanplHzrIpwjFu1uclXsGp2z78VuxNmGIjH7bHvOt+fwr3HWW1
         1ZQIl8VuOZlLhvL9wCUxWLhUHye7nvYmDV58GLuM6PjY+5VLqDIxQ6LYtHOEM2VPH82k
         TD8nenNQReg/LxYr/Qwo3GTReh+a6/JdjmrAzlmS9R6Nj0EL2UvrWZ4gMidqfXKmreAs
         Ouuw==
X-Forwarded-Encrypted: i=1; AKwUvBzX73rIYEvbN3JXAjfaYHO7OVV/NzMtWykfxZIFvcCW+EiQwIk3EJ/HnDgqUnB0ZC6kvMVMlxU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ot9M/tkqNAd9jwojhKDtpm4rkRYlCHCrKE2SiSyGzLjfsj9Dk
	47bo7GUcRuOKxUQfHe7Pa6gAManbTYdK7Injc8ymWAU6JgdRn7uf2p8K
X-Gm-Gg: AYBFou3i7CYMdwkdnsNJ6lXNhfU3dCN2Ywgcb6YXFULxpJmDp+ZgXpT3K2y+JRUGD04
	Fs0cruaB5O4O6TYZQfWkGa3SefIa4nBww45i/K10NmeDvOim0wuDu6BjOdYY38b3SWCSXmTc4iS
	4hwBO0wECH50odLMzn/bo0OS7bl2zP8S8BXi0S7cXDNomaQezGPKVLAzAINJEYQAyufJo4S6ahH
	tyV3qZAHmtrCRmDSW7pwrNTp2Yd9pbXKWJr1+BoZ4d48oZ4IUxrNlOJjHr6vTA8rpelZB/WPr3K
	iCaAT2XPgIstpg9SQllRJxvctBonrY8YMXlTHawB7s7xdU0AZhR3EJIUTuyRWs3UkKhdkSUxVWY
	gGjEwNquqCNRP6Q9jXpRHnhPKcOrv7Z9U/TAZR1be8p6K7baE9LxV0tcwt5ie1fGkhl69gHbhgh
	I6ialnbktqtotzFgA8cBuZ+KohgqioFVuf1HeNiT6x0mRzfcvc3EEyJU1ui5SeSQuf8g8p7njuh
	aC53EmDN8P0kj5u3M8/0XsaMIMTO3nhYgXjrIEZ3tBHONNQF+C7m7qieubi89Z8jVGguuD5Euy9
	GRjUlkZguspNvBIE5McUbXmdyXJRvCwwD6Ro6X2K2A3KiLWqxibsVT855e55H4AYO4UoE4aO+A+
	oVBEJCrhDl9eiIpKUYUUry7MWmZUBOp1pdenLcwk1SkSvnnK4C8kMstGEblYckM5nAV7bUHN5pf
	Zk7xqCSuMkllEUVpHP4+2JjtoHsR9DHh+KYXoQaLJBa8iWjQiv10Vx
X-Received: by 2002:a05:6820:16a8:b0:716:e855:4ff4 with SMTP id 006d021491bc7-716e8555060mr340379eaf.55.1793906986644;
        Thu, 05 Nov 2026 11:29:46 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716e99465dbsm177463eaf.0.2026.11.05.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:29:46 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 12:29:40 -0700
Subject: [PATCH v2] mtd: core: reject OOB transfers with no complete page
 remaining
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
Message-Id: <20261105-submit-mtd-oob-end-v1-v2-1-734bffdc2914@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7RjaIFFX3sOwaKctjLGUtJVoC
 He34AFM/uYl//2/QLKRbYJrtUC0MycOYwF5qIAGNfYW2RQGWctWiLrB9NKeM/psMASNdjQ4C3S
 NodZpR44UFHeK1vF73713Py7iw1LexrbGwCmH+NmPZ7H1/n2UCDyRPitzkYJ0feu94ueRgoduX
 dcv0rCWA8wAAAA=
X-Change-ID: 20261104-submit-mtd-oob-end-v1-f4dc6fbfcfca
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

mtd_check_oob_ops() permits offs == mtd->size when the data length is
zero. For an OOB-only request with a nonzero ooboffs, maxooblen then
underflows because there are no pages remaining. The wrapped value lets
the request pass the OOB length check.

The OOB ioctls can reach this case by encoding the OOB offset in the low
bits of start. On a partition ending before its master device, the
subsequent address translation allows the request to read or write OOB
in the page immediately following the partition.

The same underflow is possible before the device end on a read-only
partition whose size is not a multiple of writesize. An offset in its
trailing partial page has the same page index as mtd->size, so the
remaining-page count is zero even though offs < mtd->size.

Reject nonempty OOB requests whose starting page is at or beyond the
number of complete pages in the MTD device, before subtracting ooboffs
from the remaining OOB capacity. This covers both exact EOF and trailing
partial pages while preserving data-only and empty-request validation.

Fixes: d82c36821684 ("mtd: Fix mtd_check_oob_ops()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-197995@kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Compare page indices to reject OOB requests in a trailing partial page
  as well as at EOF, addressing Sashiko's review.
- Link to v1: https://patch.msgid.link/20261104-submit-mtd-oob-end-v1-v1-1-5cb8ad921cb0@gmail.com
---
 drivers/mtd/mtdcore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 491a27d0315f..34ab30df03a0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1676,6 +1676,10 @@ static int mtd_check_oob_ops(struct mtd_info *mtd, loff_t offs,
 	if (ops->ooblen) {
 		size_t maxooblen;
 
+		if (mtd_div_by_ws(offs, mtd) >=
+		    mtd_div_by_ws(mtd->size, mtd))
+			return -EINVAL;
+
 		if (ops->ooboffs >= mtd_oobavail(mtd, ops))
 			return -EINVAL;
 

---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261104-submit-mtd-oob-end-v1-f4dc6fbfcfca

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

