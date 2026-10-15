Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344D5172F0;
	Thu, 15 Oct 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058110; cv=none; b=gyQbfcA8opUTlnckkLxhPSrOBbSqXf7+73EsAj6msNqvSzR76veH+JUxOBp8uOQwz/bW3Cc2Td1+hR0+ue/KxAwLWQVP/z9DxRImMboxe+hH0sOXKSLP+pWrk10OFpeCNJOpmgC7PKVAxmXNiMh4mN3pQS+P9uuYCq5KK5NQnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058110; c=relaxed/simple;
	bh=+Ix0vC4g42IH+LjX9BN0HDkblNx4CUXpKkBZWUUuJhQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WX/QMYRU1j2Wq1jJhFhoEZ9EIzxkIwXqFHo1j/HPhkVr95SZxrm9+mL+MfI6PJm7EiOvDXFp0/iD8fThv87Q4q26ol9Gc5pAKFqL3GuFIHgRc07hqSJWcCJoBJ1zc62Il0+jKaqxTf334Vw6y6S4hmElbh3W2GxnbYbNsEbeNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAQON8KR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n2mDvFnC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAQON8KR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n2mDvFnC"
Date: Thu, 15 Oct 2026 09:54:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792058101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEZjnlz86B5KOJ3Lj7+AUsK4FGHygPEoL3WsxAnp+TE=;
	b=zAQON8KRC3hNrulhr5ppDmj26WojHUXBtFfGQ6/5q1EdeJm50EsYZl0SJbTkVCKmv+MteX
	28dr1yi4Tru+NqNQIgKc/pV0NTU5hhNBpdaLH5uxFQYzVt/2RqFB+EY+UR8Sj5CFjPZr8/
	7r94iLdjD3EIhzSDJaEtuWUsDLc+gLuIn4cb76ctn3cDoXy9AC/39iWN/qMcXT/RjGJ5Eb
	cI8Z97BVcxLWDB0n1k2W6cbKMKHUXFUDOcn18oyyyL5P5rRAfUd0uQUVgGXGTuw5G3etah
	Dhliju4Y8k8KUkBp7C5d6Q1+HJ8glqGcGlrTkEeoBc3ONROMaxzfvmW+KILtaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792058101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEZjnlz86B5KOJ3Lj7+AUsK4FGHygPEoL3WsxAnp+TE=;
	b=n2mDvFnCosws749FdaagyPedPdVCr0Fx4azfutKFM7ZdJmJIfGJHqvLuZip2qz/3IILCrN
	RgHvfDZD8hAMiiAA==
From: "tip-bot2 for Fuad Tabba" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/gic-v3-its: Don't clamp nvecs to zero when
 id_bits is 32
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Thomas Gleixner <tglx@kernel.org>,
 Marc Zyngier <maz@kernel.org>, "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
 Radu Rendec <radu@rendec.net>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260908142632.2795308-3-fuad.tabba@linux.dev>
References: <20260908142632.2795308-3-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205809986.2666988.8606143942256600452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     5a9d62555e7164ec79a5fe70153d79cf1fdfd614
Gitweb:        https://git.kernel.org/tip/5a9d62555e7164ec79a5fe70153d79cf1fd=
fd614
Author:        Fuad Tabba <fuad.tabba@linux.dev>
AuthorDate:    Tue, 08 Sep 2026 15:26:31 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 15 Oct 2026 11:50:47 +02:00

irqchip/gic-v3-its: Don't clamp nvecs to zero when id_bits is 32

GITS_TYPER_IDBITS is five bits, so id_bits reaches 32 and
min_t(unsigned int, ...) truncates BIT(32) to 0. nvecs becomes 0,
its_lpi_alloc() rejects that, and its_msi_prepare() returns -ENOMEM.
On 32-bit ARM the shift is undefined instead.

The clamp is correct for every value below the maximum, so only that
one value is affected.

Fixes: ce9e40a9a5e5c ("irqchip/gic-v3-its: Limit number of per-device MSIs to=
 the range the ITS supports")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Reviewed-by: Radu Rendec <radu@rendec.net>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260908142632.2795308-3-fuad.tabba@linux.dev
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index b6509b4..4f6d4aa 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3485,7 +3485,7 @@ static struct its_device *its_create_device(struct its_=
node *its, u32 dev_id,
 	 * Also honor the ITS's own EID limit.
 	 */
 	id_bits =3D FIELD_GET(GITS_TYPER_IDBITS, its->typer) + 1;
-	nvecs =3D min_t(unsigned int, nvecs, BIT(id_bits));
+	nvecs =3D min_t(u64, nvecs, BIT_ULL(id_bits));
 	nr_ites =3D max(2, nvecs);
 	sz =3D nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
 	sz =3D max(sz, ITS_ITT_ALIGN);
