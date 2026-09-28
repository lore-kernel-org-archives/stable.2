Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F211A6823;
	Mon, 28 Sep 2026 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790564314; cv=none; b=ZkKsyn21CWBvJLRm3XBpuiw3DB9Mt5Z/bjlR7RO/s6FRMdeteF9i6UtuXOpglQU8Wb/mPgCoR4aqv/V9OFkhaRW9Gwx5NpqlRxlsZ09CVhaoNzQ8UPO+Lm9K3n6PadT9Dzi5jCDcbCsLB31AXGgjfW9JcwhxziWCFAOHmFEfrlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790564314; c=relaxed/simple;
	bh=ZfuTHPSgs+x+yKaDC7+EzEzTpW4huBKA+0FFKd+Wryk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DoKO6AXuGEl6y7S7qwE+9lhrL4haSKBAgBbiTZsRkmD2DCLF5IYLM4xDjl9nDDVtjOcVEuEoEPTfTAud543HtkXmf2MeUPxzsHbkJNxBpcByrS7hTYgPpEsoVFZj37X6CWFhqynr7596ko3wxDR4iUyZl0XDntc6Krr58AeFD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJr1KFnO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SBz7kaG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJr1KFnO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SBz7kaG"
Date: Mon, 28 Sep 2026 02:58:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790564311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaofDDwJWL1eA1Icv3zbym98sot6iJ51WB4uzkDCYlo=;
	b=xJr1KFnOYVZzsM24J7ob4fOMCMk73Am3JFo1idGGOEqjYXfAE/PP1zDYgceA7ymXjheK3u
	kl1OFR3LtnQayQ0wPnEVCHJ9/zMyqiuC9hD4Vhejng7AoF8c3pCriJ5NSrmYtRshIpEhht
	tLoXVp9CHCS3b3yOkAJ//IiXtFxlcPuxYtmRDuLvmB4uZprzS48iGmbF8FubxnAF5075No
	bobW28JnRVKH2IN7JHsJV9gDiLg1b5K1wkKVoz4oceyGvlhudypnjIxTpeIo+Icjn1pZ4f
	l1jsaXa3gHo/Kyux8HcOYIaQG0BQKNQ9rB+bshrgg2OxwJ9zAs/JF4fIIxx4QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790564311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaofDDwJWL1eA1Icv3zbym98sot6iJ51WB4uzkDCYlo=;
	b=1SBz7kaGtEBkGYTheH06QO6muhLX2X5evRH9ul9ut6qmt85xDnqfSLgxYpjnLu0JnDofRu
	6iYHAV4aYqQJUCCg==
From: "tip-bot2 for Laurent Wandrebeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Don't apply va_align to hugetlb mappings on
 AMD F15h
Cc: Dave Hansen <dave.hansen@intel.com>,
	Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.13+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260922085032.46144-1-l.wandrebeck@quelquesmots.fr>
References: <20260922085032.46144-1-l.wandrebeck@quelquesmots.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179056430898.3910103.4551601592538855256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d2457a7e2727dc747a61a50d65c2f259afce8c45
Gitweb:        https://git.kernel.org/tip/d2457a7e2727dc747a61a50d65c2f259afc=
e8c45
Author:        Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
AuthorDate:    Tue, 22 Sep 2026 10:50:32 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 27 Sep 2026 19:46:45 -07:00

x86/mm: Don't apply va_align to hugetlb mappings on AMD F15h

get_align_mask() returns huge_page_mask_align() for hugetlbfs, but get_align_=
bits()
adds va_align.bits regardless, so vm_unmapped_area() returns an address off t=
he huge
page boundary and __unmap_hugepage_range() hits BUG_ON(start & ~huge_page_mas=
k(h)) at
teardown.

This can be triggered on Carrizo and FX-8370E, both hstates.

Pass the file to get_align_bits() and skip the randomisation for hugetlbfs.

  [ bp: Massage commit message. ]

Fixes: 1317a5e7f7b1 ("arch/x86: teach arch_get_unmapped_area_vmflags to handl=
e hugetlb mappings")
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org # 6.13+
Link: https://patch.msgid.link/20260922085032.46144-1-l.wandrebeck@quelquesmo=
ts.fr
---
 arch/x86/kernel/sys_x86_64.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 776ae6f..4c07882 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -50,9 +50,16 @@ static unsigned long get_align_mask(struct file *filp)
  * value before calling vm_unmapped_area() or ORed directly to the
  * address.
  */
-static unsigned long get_align_bits(void)
+static unsigned long get_align_bits(struct file *filp)
 {
-	return va_align.bits & get_align_mask(NULL);
+	/*
+	 * va_align.bits is smaller than the huge page size and will
+	 * lead to misaligned huge pages. Ignore it for huge mappings.
+	 */
+	if (is_file_hugepages(filp))
+		return 0;
+
+	return va_align.bits & get_align_mask(filp);
 }
=20
 static int __init control_va_addr_alignment(char *str)
@@ -157,7 +164,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long a=
ddr, unsigned long len,
 	}
 	if (filp) {
 		info.align_mask =3D get_align_mask(filp);
-		info.align_offset +=3D get_align_bits();
+		info.align_offset +=3D get_align_bits(filp);
 	}
=20
 	return vm_unmapped_area(&info);
@@ -222,7 +229,7 @@ get_unmapped_area:
=20
 	if (filp) {
 		info.align_mask =3D get_align_mask(filp);
-		info.align_offset +=3D get_align_bits();
+		info.align_offset +=3D get_align_bits(filp);
 	}
 	addr =3D vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
