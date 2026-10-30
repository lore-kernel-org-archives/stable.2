Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359776;
	b=FTe8PVJEt+1XnLz61Uqyn/D8BN+fypJFK+nZUuJbpyVeJ+Foy/LZfhTTI9TPs7CKDWLC
	 bsP0TCNF6dCxaPge0QWJh7bxsHol8dhUDYV3QnlAQUvQK0GqGWrzyKBe0+5pgOW3w+NdY
	 6sWB5oDtkON9ZrsEFC9K9GbiM6ri5jeszdoIh+kG4hBLDRWf/6dWuvcFup/Kt163ZX3tU
	 DNLpEuCkCMHWJmLhABFnb8mp5nPj6NXFiRJhGuR+tBACzlob+BtAmrHGbakW7oxi9K0X9
	 h3KKdNgO2GgaS6qrv2HaBMBnf06IxtbPmrQgOXgiXPN34yRIVPSaWCnUlPr5g1adVeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=k+4d3YeUVXdsSSuX0GC4pWzZJQi/FeecQ3AMlBUJ4B4=;
	b=ZMk6glVDxyS8y/q6F340pfLx7Fsmd3EzIoHQ7eJO7z527GUDLtcdoXIBIbQvkS2hJqcT
	 0bR1UGCIAI4dtJ4fufFpfpt4oX4CAXQ/RTRPxFdpZX1JVBkkJsLAqv3U0jm0GTV/MkhVb
	 Y4zZPKmyxxv/kLsNI+x3AxkJF79UFmbn5CC21/AD9MHyS9TaAqo2iV2VVNKVBOPX5DZhx
	 d+VKi8YVrYBL0UG7H6m1v7+1zRbMN7uIyMjbs6+TvpC64zx3l/OsxKEj0SJbcSCI/UOxK
	 +3qP34OY7f01fRorZUsEGQql1xFEUTwtO7jpDJ1WebZgg5+N89Voed+Rb/ivRfG3h0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kKrY1rZZ;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514D606A320
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3514D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kKrY1rZZ
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so817297a12.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793359774; x=1793964574; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k+4d3YeUVXdsSSuX0GC4pWzZJQi/FeecQ3AMlBUJ4B4=;
        b=kKrY1rZZ632i0tdgWUKU60WkHdyu9nIPYABSlnuDF7oi8bFRjYIKhO5XzQlbl75Ctt
         PKmMtRZPK0a7q4qLIMkDH91H294XZN5PTFJPTWW5twUPp7rk6sLiMLTNgNcCE5HdUHNE
         yCOWYZ/97ECB812gXzDxla/kwLzWPAXLpFx+xrIggUru3Y2QupTUl9sjH7Agq6QDLTq4
         3vgpJkLCRBAEldI5hzc57hgiE/mnhdPgVKDtypmHjZQJpMJcikLqd46Mv0VVKj/H1MBG
         9auiZjArNPfy5+uFbFhTzC5P6xaBcYxazq5sGVZkbHE+Dr0F87rvsmDMCVQ0kTbw7pTS
         G/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359774; x=1793964574;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k+4d3YeUVXdsSSuX0GC4pWzZJQi/FeecQ3AMlBUJ4B4=;
        b=K4nfTKpvrwHkA9CboSO4234M+bRG0TEz0ZiupjQh+dt0DfOK4O7QdejT7x4M9j1lWl
         C00SFdtmO34Q5C5K+CaJsrUA4yRSlg3XkqCm0YuOR+OY+qm4j/yM7nwjWNJyG6EYSBnJ
         6lhwgQsB4ERoI2ENTy4LipgXK2SVWkj3aQTCY8tWFZktflZKC7Z11mYTD+BjJuRLnEMm
         cr4lEvtS+WMUesKItwbaHUKemH/teyIc33eQJseLAbwxst1OSIIpZUm2alKpAbTz7rWJ
         sL5Na/JKrvimcv5dcxHHjoqjxFfkS0Kb3r5CVVOafLq1XXZadmPqvC2JQkYkZCSf300t
         uKHQ==
X-Gm-Message-State: AFq9FYIiRZxTS1zoXNlZc508QcQBncxaX555jzbhUPPHSDEEqMAlVjTu
	MCS+BeB6dlEYdWspgtG7c2ITtCpW+W5stbMtYnGtWWf4iov7ByA7y11JHEuRkmI57X8=
X-Gm-Gg: AYBFou2NAnjnygblDKoA5949deGPpt1lK52xx9JlS8mu0qX8jno7mdYkzXyGGHqR4Gd
	hqMg9Jo4DnlpdhQlBDvXN+920G4WWTcKp9FVZ6Ae6mgONTVQleUjvIcyg1oVNmZu7aztbr3WN9x
	RMXEoRvKG8wcReaVpvlOZAnlJcyR85UT2qVpfL+fZq4qR7kPVdRZVBrtzjw8W+b7t/2H8BeKMRV
	+vA3T8ioosPaBxVJo69EWbKOo3oKOA4R3S56HkO9IorhZAnoiCZSVxnOQFOPlPES/uXteKoYCGk
	7BGmHFzyl6Qb5xDnrji2RlNEqaCXsZlSoC2v82p0zX5ecfJWvNT3Uiz1OpoGZxnfnDs4U3QMYcb
	3eHE0Z9loAv2MqtxdQswOHnxOjCYWQyJkgodEeU+iITroKrQ2ZC/I0F8g8pTCgeAOMfWQYnMdzM
	9VW8EgS2CwN1ln40fzwxhB/ZIkK/wZAmq/FYrkW22a7fhG+nMufhw3vCtlHO8T/djsddKwaa/8i
	04yFv17P7mRoDKJiZhlYb5g3BG+xbHs0m22OE067M1XcDyZ3GFcy+ud6hCEVb1rFb4yYLXr1as/
	mMtd3ShnByx7X3LjMEYissxQ6U7eqQGc4he7YIZZxMwFq8k6KNqFD34CxirYA1f9b2v8Rond0Y1
	B0WugIx/rm6Wa4GFCgHBW
X-Received: by 2002:aa7:c0d7:0:b0:6b3:d0a0:39e5 with SMTP id 4fb4d7f45d1cf-6b4d438bdb7mr1069754a12.9.1793359774419;
        Fri, 30 Oct 2026 04:29:34 -0700 (PDT)
Received: from puffmais2.c.googlers.com (180.192.141.34.bc.googleusercontent.com. [34.141.192.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7aff3d8sm494375a12.17.2026.10.30.04.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:29:34 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 30 Oct 2026 11:29:31 +0000
Subject: [PATCH 6.12.y] kbuild: link-vmlinux.sh: improve detection of third
 pass requirement
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-linux-kallsyms-fix-6-12-v1-1-9c43c892de04@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJp/5GoC/x2MQQqDQAxFryJZNzKJMJZepXQx2NgGp9MyQVHEu
 zf4do/H/zuYVBWDW7NDlUVNv8WFLg0M71Regvp0Bw4cKXQBs5Z5xSnlbNvHcNQVIxIjp9iPSa7
 kgK9/Vbydz3eILXG7weM4/iJjCmVxAAAA
X-Change-ID: 20261030-linux-kallsyms-fix-6-12-2a67fae81111
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@android.com, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3

commit 14b8b4bf2d7bd5d58c17adbeed0edfda1dfc1a7f upstream.

It can happen that symbol sizes within .tmp_vmlinux1.kallsyms.o and
.tmp_vmlinux2.kallsyms.o differ, without affecting file size on disk
because of section alignment and/or padding emitted by the assembler.

link-vmlinux.sh doesn't detect this case currently and keeps using
.tmp_vmlinux2.kallsyms.o to link the final vmlinux. Due to the
different symbol sizes, other symbols are shifted within the final
image compared to .tmp_vmlinux2, and the final comparison of System.map
against "${kallsyms_sysmap}" fails with the message:

    Inconsistent kallsyms data
    Try "make KALLSYMS_EXTRA_PASS=1" as a workaround

This can happen in particular if the linker emits additional symbols
that might have different names between our (re-)linking steps, e.g.
because those names depend on the virtual address of the symbol. Linker
stubs for ARM errata work-arounds are one such case.

These changed symbol names can cause the output of the token
compression of kallsyms.c to change due to the changed symbol substring
count, which in turn can change the size of the kallsyms_names symbol
itself, causing the potential shift of subsequent symbol addresses in
.tmp_vmlinux2.kallsyms.o and therefore the final image.

Update link-vmlinux.sh to not rely on file size of
.tmp_vmlinux?.kallsyms.o alone but to also consider symbol offsets
within to resolve this, and do a third pass if required.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: Nicolas Schier <nsc@kernel.org>
[AD: adjust context]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
This patch fixes an actual problem people are seeing in various
different kernel versions.

The version from 7.3 doesn't apply cleanly on 6.12 and a minor context
update was necessary.

The bug was introduced by 7e2b37c971a2 ("kbuild: kallsyms allow
3-pass generation if symbols size has changed") in v4.10.

xxUpstream 14b8b4bf2d7b cherry-picks cleanly onto 7.2; please apply it to
the stable 7.2 tree as well.

Cheers,
Andre'
---
 scripts/link-vmlinux.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 94f794ca11ca..a5729419a452 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -131,6 +131,18 @@ gen_btf()
 	btf_vmlinux_bin_o=${btf_data}
 }
 
+# Check if kallsymso_prev and kallsymso differ
+# If symbol sizes within ${kallsymso} change, any symbols within vmlinux are
+# likely to shift, invalidating ${kallsymso}.
+# Since file size can remain unchanged even if symbol sizes change, compare the
+# actual symbols instead of relying on file size only.
+kallsymso_changed()
+{
+	${NM} -n "${kallsymso_prev}" > "${kallsymso_prev}.sym"
+	${NM} -n "${kallsymso}" > "${kallsymso}.sym"
+	! cmp -s "${kallsymso_prev}.sym" "${kallsymso}.sym"
+}
+
 # Create ${2}.o file with all symbols from the ${1} object file
 kallsyms()
 {
@@ -151,6 +163,7 @@ kallsyms()
 	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
 	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} -c -o "${2}.o" "${2}.S"
 
+	kallsymso_prev="${kallsymso:-}"
 	kallsymso=${2}.o
 }
 
@@ -263,7 +276,12 @@ if is_enabled CONFIG_KALLSYMS; then
 	sysmap_and_kallsyms .tmp_vmlinux2
 	size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
 
-	if [ $size1 -ne $size2 ] || [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
+	# Due to alignment, file size of the kallsymso object file might remain
+	# unchanged even if individual symbols within change size. Changed
+	# symbol sizes can still shift other symbols, though. Therefore, don't
+	# rely on file size alone.
+	if [ $size1 -ne $size2 ] || kallsymso_changed || \
+			[ -n "${KALLSYMS_EXTRA_PASS}" ]; then
 		vmlinux_link .tmp_vmlinux3
 		sysmap_and_kallsyms .tmp_vmlinux3
 	fi

---
base-commit: 85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e
change-id: 20261030-linux-kallsyms-fix-6-12-2a67fae81111

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

