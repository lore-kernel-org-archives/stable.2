Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274235E949
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781378830; cv=none; b=erqD0Z74rBRJEED7wD/KG7+ykaqnkRIpPC3YyuPmWlGd30wu41XAS1n6ZCL2zsmgkSGxDYo/cMBLIqtbKy82cQsYD6ecnyNyxTnY03igLQRhESJv+VepMhzLT7OEvB5O4rYKtew2DLVJIahOvSGKdVkGtamv+MLOKZq6abGhFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781378830; c=relaxed/simple;
	bh=xVelLjBz1oChDfGaccyQlEKkrUo4O0HxtFhkEf12Xyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YDsDT3uit9tC3sN4cgskCdgDnOvUJFpGwMKCt9AQrILcqiQv/sWwHAS1ycjrMLO3jUw5AmFZN7yY45vxJrSesEuOYOmQuvRwOvz96T1iCuMfSypP0qzQZGDgTcVYNlK0adiIRsHfoeyk/UlW8pydGim0Fna+WedUAXcJWQc+O50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A521F000E9;
	Sat, 13 Jun 2026 19:27:07 +0000 (UTC)
Date: Sat, 13 Jun 2026 14:27:06 -0500
From: Clark Williams <clark.williams@gmail.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org
Subject: Problems building RT stable for v6.1.175
Message-ID: <ai2vCqAXVEMQJDOJ@demetrius>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Sasha, 

I was having some compilation problems building the v6.1-rt branch after merging v6.1.175.
I'm building on an up-to-date Fedora 44, using gcc 16.1.1.

------------------------
First I saw this:

  CC [M]  arch/x86/kvm/vmx/vmx.o
In file included from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx.h:15,
                 from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/nested.h:7,
                 from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx.c:63:
/lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx_ops.h:15:58: error: ‘regparm’ attribute ignored [-Werror=attributes]
   15 |                                                          bool fault);
      |                                                          ^~~~
cc1: all warnings being treated as errors
make[4]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:250: arch/x86/kvm/vmx/vmx.o] Error 1
make[3]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:503: arch/x86/kvm] Error 2
make[2]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:503: arch/x86] Error 2
make[1]: *** [/lilnas/src/stable-rt/v6.1-rt/Makefile:2025: .] Error 2
make: *** [Makefile:238: __sub-make] Error 2

The fix there is to add const to the definition of next_path:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7bd6aff6e260..33b214a91338 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10748,7 +10748,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
                if (!search_paths[i])
                        continue;
                for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-                       char *next_path;
+                       const char *next_path;
                        int seg_len;
 
                        if (s[0] == ':')

------------------------
next up is a warning-as-failure in libbpf.c:

   CC [M]  arch/x86/kvm/vmx/vmx.o
   In file included from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx.h:15,
   from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/nested.h:7,
   from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx.c:63:
   /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx_ops.h:15:58: error: ‘regparm’ attribute ignored [-Werror=attributes]
   15 |                                                          bool fault);
      |                                                          ^~~~
   cc1: all warnings being treated as errors
   make[4]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:250: arch/x86/kvm/vmx/vmx.o] Error 1
   make[3]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:503: arch/x86/kvm] Error 2
   make[2]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:503: arch/x86] Error 2
   make[1]: *** [/lilnas/src/stable-rt/v6.1-rt/Makefile:2025: .] Error 2
   make: *** [Makefile:238: __sub-make] Error 2


I'll admit I had to ask my buddy Claude about this one. Turns out that the regparm attribute is relevant only on x86-32
and is meaningless on x86-64, so treated as a warning and a failure. The fix is to wrap the definition in an #ifdef
for CONFIG_X86_32:


diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 5edab28dfb2e..50328be40b2b 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -11,8 +11,11 @@
 #include "../x86.h"
 
 void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-                                                        bool fault);
+/* regparm(0) overrides -mregparm=3 so args are stack-passed, matching asm callers */
+#ifdef CONFIG_X86_32
+__attribute__((regparm(0)))
+#endif
+void vmread_error_trampoline(unsigned long field, bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);

------------------------

Pretty sure you'll need these (or something equivalent) on 6.1 stable, when more people start using gcc 16.

Don't know if this email is enough but if you want I'll send you a patch series. 

Regards,
Clark
-- 
The United States Coast Guard
Ruining Natural Selection since 1790
