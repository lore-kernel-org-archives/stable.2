Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA03D9DB6
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664043; cv=none; b=V3FH6D+WjT5C6fYxnxZsJwBUlejDTNBpXAN3AmYjy4KkZZUwdzuw6rK9M1KLb59l5ZPMGol5/shxiZZPfZ3tWo9XKCXw44svoGNu71mi4xwKFAAkP7I1QljQ9ym17+EZwgArIt0fILaRrJ49w7vDaXjYMMkzF6YMQzslr7qXJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664043; c=relaxed/simple;
	bh=6DfkNgjsdq+0eXfBVgDcDcwGQ3HhcMz24X/DgX5kWHg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pq4Baprt+IAJRuQhqY3mg4VX8voUh0E43M48RMWPXpLxc2UXkEqJHIwTTvfUcEhRjfeVw+TVr91nSkeNFSScPL+GDjlYWMGUWicnRLXiHeq9m88bacSTajfNIJqMMhMiRd2zhqCAZiSfvlqei1FO/NNY7QDqm83354kTKmb1TpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vzexG12P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vzexG12P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A381F000FF;
	Tue, 29 Sep 2026 06:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664041;
	bh=nxbuFRFFydp1/YTJE5NcGdz52GlE8OjW2jBufRZNSCU=;
	h=Subject:To:Cc:From:Date;
	b=vzexG12PfB+1E0h8G7MTlXRDuTDOcWCjpGx3QtiXm8V63h9/A1N1MKRCTSI1ZLQNs
	 mi39cOWX8/F6HDqG4wQ0z1ACR4Acr9E1M0ovBYENMkw5gz9ja/gc9U8iHnYu2Z2mbj
	 YYfWHWGsKTnFA6ZedbUfPceEtyi8SncB5bg7pI6Q=
Subject: FAILED: patch "[PATCH] x86/sev: Make vTPM SVSM calls preemption-safe" failed to apply to 6.18-stable tree
To: huibo.wang@amd.com,bp@alien8.de,sgarzare@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:40:39 +0200
Message-ID: <2026092939-ecard-twirl-6094@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6c43c72748fffd29dec15cd1f31e9a32949bc437
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092939-ecard-twirl-6094@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c43c72748fffd29dec15cd1f31e9a32949bc437 Mon Sep 17 00:00:00 2001
From: Melody Wang <huibo.wang@amd.com>
Date: Mon, 14 Sep 2026 00:57:17 +0000
Subject: [PATCH] x86/sev: Make vTPM SVSM calls preemption-safe

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
Link: https://patch.msgid.link/a5bc0d4a2c462a0089109e145c21626b244b2ff0.1789345277.git.huibo.wang@amd.com

diff --git a/arch/x86/coco/sev/svsm.c b/arch/x86/coco/sev/svsm.c
index 916d62cd17dc..2d493d55ff2e 100644
--- a/arch/x86/coco/sev/svsm.c
+++ b/arch/x86/coco/sev/svsm.c
@@ -74,6 +74,14 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 
 	flags = native_local_irq_save();
 
+	/*
+	 * 'caa' is a per-CPU variable. To avoid using a stale or incorrect
+	 * 'caa' if the task is preempted or migrated to another CPU after it
+	 * is fetched, always fetch 'caa' and then issue the SVSM call with
+	 * interrupts disabled. This ensures the correct 'caa' is used.
+	 */
+	call->caa = svsm_get_caa();
+
 	ghcb = __sev_get_ghcb(&state);
 
 	do {
@@ -321,7 +329,6 @@ int snp_svsm_vtpm_send_command(u8 *buffer)
 {
 	struct svsm_call call = {};
 
-	call.caa = svsm_get_caa();
 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
 	call.rcx = __pa(buffer);
 
@@ -345,7 +352,6 @@ bool snp_svsm_vtpm_probe(void)
 	if (!snp_vmpl)
 		return false;
 
-	call.caa = svsm_get_caa();
 	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
 
 	if (svsm_perform_call_protocol(&call))

