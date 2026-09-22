Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009E39182A;
	Tue, 22 Sep 2026 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046860; cv=none; b=ofsxQRCXKSgydGP+/xH+Qr1UTyiIFlsPeZ/Z09onoXLX5mWyqyTsmkt6mBONk6xvzMBq5/wqImc6dG6APY1i1XMBcZvoiy3uYnIyIHs1wagvO1k3x+x7MtPVEnMUYraJiiFa0l9ps2Q2NJAisENGWVSl1yfdnFSnrVyxH/M6GOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046860; c=relaxed/simple;
	bh=obg0oXGgsBAMkBRdKYDmxHCHeYv8nX7lxnpuF9gPeY8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RuOTjznXgI/cEcunFLVxO6zMU1+jm51Ix2j29NlUDNpnuCjDOOx39rI/+c1ssqffl3YMvKjHODVXN1GA5FUfvbiVm2Z5R+yErxuQ5qSeIse11j765/80uDdNeshk8X/Dc/TpOXk1JHs4hMCD3j7uNfQV7IhNOeWUW/lW+ATuKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qu4AwNB2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ywbb4kPt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qu4AwNB2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ywbb4kPt"
Date: Tue, 22 Sep 2026 03:14:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790046854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6PBSO4w1mJ8PEEYgWsvL6BPY0w4uOQhVpwDDkQcYZk=;
	b=Qu4AwNB2QlnO3p/qYhWF/DIiL7N6EApYjAje4Rf9g0MYTTJq/Pg9b+FPT9t/nMc55RSJpa
	dL8nq7kGkoy/G5FF0YeyP5aNj6CkvSeI3yVtexJD0lJYMLZDYAVLvtuK/0Re65wBM+4Zxj
	kOZFDrkwNNkW/vS7ME0FMtFpmcsvUP3rtAR7dfqo1vfUgC74wfMKI4GaxryPuNF/cocmhr
	NKXcoaAI6Dkvln+Esb0rPXFHSp0VsayNTeNSEVdGe57gDhKnScmECzJrIFaQ0SA6AiyZCv
	Hyo7+1S8VDd/5LPsqEsfUyV1Hzz8PJcDM5Gi8DDNugrk1FVMFGzSCBkoJoz+Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790046854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6PBSO4w1mJ8PEEYgWsvL6BPY0w4uOQhVpwDDkQcYZk=;
	b=Ywbb4kPt0ZApDkBkxUV6BNfTEvot5SynJcjLrAgwIxyIvtZP64OAf/Do37nLmjD2UKNJMO
	X3AIdPtuGCXiOQBQ==
From: "tip-bot2 for Melody Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Make vTPM SVSM calls preemption-safe
Cc: Melody Wang <huibo.wang@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Stefano Garzarella <sgarzare@redhat.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <a5bc0d4a2c462a0089109e145c21626b244b2ff0.1789345277.git.huibo.wang@amd.com>
References:
 <a5bc0d4a2c462a0089109e145c21626b244b2ff0.1789345277.git.huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179004685258.2819794.12514099294540319299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6c43c72748fffd29dec15cd1f31e9a32949bc437
Gitweb:        https://git.kernel.org/tip/6c43c72748fffd29dec15cd1f31e9a32949=
bc437
Author:        Melody Wang <huibo.wang@amd.com>
AuthorDate:    Mon, 14 Sep 2026 00:57:17=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 21 Sep 2026 19:59:25 -07:00

x86/sev: Make vTPM SVSM calls preemption-safe

Two functions in the SVSM vTPM guest implementation do not disable
preemption when fetching the SVSM Calling Area Address (CAA).

The SVSM CAA is a per-CPU structure. When a thread is preempted and migrated
to a different CPU after fetching the per-CPU CAA, the SVSM call will execute
on the new CPU with the original CPU's CAA. Which is wrong.

Move the CAA fetching operation inside svsm_perform_call_protocol() which
disables interrupts around the SVSM call and thus runs preemption-safe.

Fixes: 770de678bc28 ("x86/sev: Add SVSM vTPM probe/send_command functions")
Signed-off-by: Melody Wang <huibo.wang@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/a5bc0d4a2c462a0089109e145c21626b244b2ff0.17893=
45277.git.huibo.wang@amd.com
---
 arch/x86/coco/sev/svsm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/svsm.c b/arch/x86/coco/sev/svsm.c
index 916d62c..2d493d5 100644
--- a/arch/x86/coco/sev/svsm.c
+++ b/arch/x86/coco/sev/svsm.c
@@ -74,6 +74,14 @@ int svsm_perform_call_protocol(struct svsm_call *call)
=20
 	flags =3D native_local_irq_save();
=20
+	/*
+	 * 'caa' is a per-CPU variable. To avoid using a stale or incorrect
+	 * 'caa' if the task is preempted or migrated to another CPU after it
+	 * is fetched, always fetch 'caa' and then issue the SVSM call with
+	 * interrupts disabled. This ensures the correct 'caa' is used.
+	 */
+	call->caa =3D svsm_get_caa();
+
 	ghcb =3D __sev_get_ghcb(&state);
=20
 	do {
@@ -321,7 +329,6 @@ int snp_svsm_vtpm_send_command(u8 *buffer)
 {
 	struct svsm_call call =3D {};
=20
-	call.caa =3D svsm_get_caa();
 	call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_CMD);
 	call.rcx =3D __pa(buffer);
=20
@@ -345,7 +352,6 @@ bool snp_svsm_vtpm_probe(void)
 	if (!snp_vmpl)
 		return false;
=20
-	call.caa =3D svsm_get_caa();
 	call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
=20
 	if (svsm_perform_call_protocol(&call))
