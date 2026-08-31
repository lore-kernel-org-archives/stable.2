Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE433F1AAD;
	Mon, 31 Aug 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197739; cv=none; b=XVoReEV3AIAoFhnv4nBKO3RT1oGph9TI5NmOCu/9dxxOvYoqrgFWzcx06b9D3V1dTgMFHsO4Lvp2e+fXcVUHWUilxvrsOzUcJ78IcbOVNf0SEYstjpLa7/0oRzHax5Jp4uai2Pp3MT3nRanaQgplRY3goQXo8Baroz1HrU54hwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197739; c=relaxed/simple;
	bh=2qVC5yoQBquWe6LLwPrlx9oakMBqorOlsrR2KF1e3Jc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dvFlnbV3MGsOVum3rEpciZR0EIDxzvFbmxi761nSxRYk8kl8yLEDoXI8AjTh/XlGIym/Q/hvAZ/MTKmaMYsf8P8qnXa7dB+YhWRWhnfKQ0ObAxMbGpv6DwwNcvQfXREe4xKhbyvOdClXheuy0XhOdEfFCqR53RnrcijwDAJMCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJPoO2d9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uAUN7GQ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJPoO2d9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uAUN7GQ2"
Date: Mon, 31 Aug 2026 17:35:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788197736;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8Dx2ZMejgOo8yw+tVY8+elR2md2Nj5Pg4EyNxccHG4=;
	b=qJPoO2d9w32upNZrOE2RiXOgBnPcCm7UNJaAi+9b8Go4sNy4kSwMVZso1Jtu+GHf7ZAxcY
	zSaVC2OUNIfeWomu5keX48ALGxrU26+XW06f56FmPUTxT76EJbKBDh+v4Cs6au7EgwrR+Q
	xQY/qGjH/vg5hSFajzNsc030NLvATsSgN7ywGT0J2PbH9OWjVkxFLYGaBFq/Gr3p5/6EDv
	VdSwdirqj4Qn5kfywWh1wFr5chv/iaKjSi1v9kGDyyHIOo9Q8iji0vuyBBv0uX6zK7AF87
	l32Ct508DonjtTHN4HUhqckVw2uZF83qJkn2fXB6Ptf1XVsWFQ8iCxvIEXYlcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788197736;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8Dx2ZMejgOo8yw+tVY8+elR2md2Nj5Pg4EyNxccHG4=;
	b=uAUN7GQ25ascWtQPuFVfw5GNklnNgydUcbK6hT5r30yvgbXUPW7ZdbCAa5+3V90E9Ckyc8
	zILzpYba4I0NqEBA==
From: "tip-bot2 for Jason Andryuk" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/amd_node: Avoid divide by zero on virtualized systems
Cc: Borislav Petkov <bp@alien8.de>, Jason Andryuk <jason.andryuk@amd.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260825214805.39148-2-jason.andryuk@amd.com>
References: <20260825214805.39148-2-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178819773427.3717435.17649146675219220348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     72bd92bd8190d7869ecb462649ca40f297822a33
Gitweb:        https://git.kernel.org/tip/72bd92bd8190d7869ecb462649ca40f2978=
22a33
Author:        Jason Andryuk <jason.andryuk@amd.com>
AuthorDate:    Tue, 25 Aug 2026 17:48:02 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 30 Aug 2026 18:25:42 -07:00

x86/amd_node: Avoid divide by zero on virtualized systems

On a virtualized system, the number of nodes does not have a relationship to
the number of roots.  A Xen PVH dom0 can calculate roots_per_node as 0, which
crashes with a divide by zero in:

  if (count++ % roots_per_node)

because the underlying topology code on Xen ends up making num_nodes
2 and num_roots 1 and the integer division result is 0.

The issue is seen with Xen, but it could affect other systems.

Set roots_per_node to 1 in this case. Print a firmware bug when this is
performed for non-virtualized systems.

  [ bp: Massage commit message. ]

Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260825214805.39148-2-jason.andryuk@amd.com
---
 arch/x86/kernel/amd_node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0be0172..408b9fd 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
 		return -ENOMEM;
=20
 	roots_per_node =3D num_roots / num_nodes;
+	if (!roots_per_node) {
+		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+			pr_warn(FW_BUG "Error detecting roots per node.\n");
+		roots_per_node =3D 1;
+	}
=20
 	count =3D 0;
 	node =3D 0;
