Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762F5293FF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950571; cv=none; b=RDC466iV30rBsEEl7Jr00bOmxWVRQQENdQih3NyK+Os2G1M9NAdZCp0tBOFNdTBT7inR3PedJ4Dtfy0vRqR31neXa5nT19taZtPbgPeCSUY+JPeNBNxI7ZyTu5CNqeVZw1eajzuM7M3XvL8+8p9pr5YfWqMsuEbgUsCGJJDfkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950571; c=relaxed/simple;
	bh=QGKhyk8DFt2taIqJMqqn9mKsMvDO2JhVQbdoi15XUA8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WqyMpfJ+kjbieHGn5jEhtYg17DntgFDblQYN/aExWPBtJkDVO6kZK1NccoRRjEqf3uXEeFFhnVygfEsqguO0K4oZ6MB1alVmit/9MGCqkgry09bXfrG/DLCjrGPUFODoloGET1VH8oKMRca08BZ93aNUKjgoq1KGVk5/UU1bEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tz3uGM1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tz3uGM1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EB21F00A3A;
	Wed,  9 Sep 2026 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788950569;
	bh=e/i1QI+JbYgr7pwBgrBxj1FUMBGEZfhs/FVlXY+Rq5E=;
	h=Subject:To:Cc:From:Date;
	b=Tz3uGM1Nx0Co4cO+1/b8Ddj6o5u7OCXYRSxU+YHcpoO6beZUz4cFrKstipuy2iqL1
	 OpKwJRPJujLDU8RpGDXOH16gUn+0zms7APO+n0QeRg9QilgFmlykyTGiFV8cBgTObf
	 AwhcHH16hThvs6Eor3sKC1ueDXCgR01vRP3qbB7o=
Subject: FAILED: patch "[PATCH] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not" failed to apply to 6.12-stable tree
To: yosry@kernel.org,seanjc@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:32:15 +0200
Message-ID: <2026090915-drainer-judicial-082f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e62392bf39ebfdf60d1d082799397fe1cbf8dfc5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090915-drainer-judicial-082f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e62392bf39ebfdf60d1d082799397fe1cbf8dfc5 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 18:10:17 +0000
Subject: [PATCH] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not
 supported

Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
is actually supported. KVM does check long-mode support before allowing
the bits for guest writes and userspace writes through KVM_SET_SREGS*
(in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
check reserved bits.

In practice, this doesn't really matter. The true motiviation is getting
rid of the #ifdeffery when initializing efer_reserved_bits.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713181020.2735367-3-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c230b18d87e3..67481429ad6b 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -19,16 +19,8 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
-/* EFER defaults:
- * - enable syscall per default because its emulated by KVM
- * - enable LME and LMA per default on 64 bit KVM
- */
-#ifdef CONFIG_X86_64
-static
-u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
-#else
+/* Enable syscall by default because its emulated by KVM */
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
-#endif
 
 #define MAX_IO_MSRS 256
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a4216b858194..0845551c6cab 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6910,6 +6910,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
+	if (kvm_cpu_cap_has(X86_FEATURE_LM))
+		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
+
 	if (kvm_cpu_cap_has(X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 

