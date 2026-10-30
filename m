Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360627;
	b=3XR6Ubcn/1qN80GPYdT4h6EZfrYgwNjWOnghC4582g1B+BXlj+xnjPOv6d8frgTVzsb/
	 Gvb4LB3npVRvhWyGSfEZmf+LnXbx3GBK7Vi7soXskVRtAH16SELLbTnbAmEk4zzS8p3LW
	 hB9Vfrx5qP/0+P4E2xYLVFjQ6paCxb4tVmMhoI3d7pKA55qe3yZgLryTvcsHHJCkx9Bju
	 B0xMLy0HEouodGud/325NxsuKn++dzTqIdj6fBYejBVkuYnTDEaZ9GhTKde604MWXIbdE
	 0jbaQngN7GZRFEh0/WkSVVCBS17BWIf4LwvN2ZKcp9KnmCTnXpQcc5oMz/XgabhCTrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=28PCckgDhGD/ZLp9OHCQjH3mpXja8gxz92m6X/6oBYs=;
	b=wtKNtrlRXvwtDZXc3TRjR264Kkqf4EgGDfZuk0R+Hg/1tmS2x9qs+0J5ssNnm/U04J1s
	 KyDQCCqHoxFSTbFkKZraB/Z5Nl7rCwoy/HYrXVcc3lrrcB+I8BnwhkS+ygSW5s3lHGLNk
	 7oXoa8GFx+5OS2fAaaH4YRPI3Dks1XnKCL61xmB7fCZuJH33Ds3QzvxmK5a99p+D5AnP9
	 6oydv1fAZQt4fjeizFRaweeRTQYJRqXMmwhmwJzDKZCTq6QhXfzd+U2kubpH355U0OUsE
	 KrIvszOxZe8r5qL4TFtSw5pbLcM/HybF+OdkdxjyWReZ3pPCqc0WKTCjfx0Y7FP1QBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BrRcfepc;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3A1606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E3A1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BrRcfepc
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4550d8ab15so67830266b.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793360626; x=1793965426; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=28PCckgDhGD/ZLp9OHCQjH3mpXja8gxz92m6X/6oBYs=;
        b=BrRcfepciz2w83GNcZbxHrJ2h/DD4uYz5bujei/G8If+M64RnJr1m0opOigiTXRwux
         uIOzF8dGYeRVyprDCL2z9h0k2rneEVLWdfSOt3Ll4OAYv+WT8MYxtaotoBh0WJN5UHiq
         EarDp7MVeY16oksd9RM+KmcY+xOzl8Q5EyWt+J3kDdKsgm68J6op3DfoTw8XZCaaOeSk
         f50avOJeBH2NkLcAwZwDkuoDe79qQ0ObNb18JeaBm0hFzP8ZdnXOVmYyDsyABusdi3IZ
         qwet0ZXiocIjYi1KjQajjr874HEA1mT3ijQakyjUPHzlOtSRKNN/3yuyuRTwfpOY5Ilw
         Vmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793360626; x=1793965426;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=28PCckgDhGD/ZLp9OHCQjH3mpXja8gxz92m6X/6oBYs=;
        b=tmxd1OzeMRZzXxqVRoyhiAXSFVp2/o25CRleYNaSzkFehh6+K75e0cEZkZeIJZjs6n
         MtprH4g+ErJzSA0vzOITfSNPhVtbHDkVR8R/3vs3wUUxkAsDa6gVgIZ7B7fNFajqSo8h
         Lf6o2/5jJwGqeslny6R4J2WO40Xyj9L/hWr0pDzbbMDEMYFy0tqglKcIiNXzJaJbWPIx
         EZ9sQ/03iVtp2Zc8DJKkhDhPQjTtbbsI9VbXPDsSTTtDCJNs0ttGFnk82Rdygp6m5ekM
         i+Brv9j83k1B4IqqzStbykRBwb8EdHWKNl5pOxYyj9ecxziWE6cl8aPxlykXU7L5Qol2
         nPIg==
X-Gm-Message-State: AFq9FYJvTNeJbxQSMhe/uUQxm0cwh23Y50rjIeX78VX2tA+qLVyerLiC
	EE7r68tCwuXn4gleFInZ66uEdEc+OkqN15pWOdlt+WDZDcgcJQGQZoUjDAqJJu9kkP8=
X-Gm-Gg: AYBFou1pwFifNiQn9yFSmGMcgHUzqxAU6oe6od40SYth7m1cnjra7OBvUzZU/6/o2+Q
	T3n80BnbX55reIGleBj4soqD3JjlotLcJbmgeJVS653xRaye+CQd0RORXYDxvvYskFaq4LDoOeJ
	ob7l2VlIuB/Q0oQG870oo6fNbwKz/4Ilt/u10M5zUDUI1ffoieccmCyXeb409TjxD9Zc7lk4leC
	q9XkKap77rRALYLF/OhP025/tA4nZfUNE0X5VFy+b8LU7IT0iWX5cCjtspYwEdIftxLRjlWSvw+
	Y9q2v3j7UCuDOg1VAYBS5EWAII7SszXNlUH4KOfyAzJkR0DvoLJR/GFIhcx2uxORN+N5pn7Pzv3
	gUXg86t2ZWQZgOsSCETJdqwfZHBn07Gg7OBDOY/P0b1X/vWrH3rJI+otmBk2/PNbE65pdRoWzNN
	HsNxO6wSA3xp3jj4xeUyiYwxtcgMAidaZIlS+LyyE/8NanWzwLdTBGV23q2Rkq83vz3ztDifS4H
	mQz8/vB1yVSEayopAYYOGA6yHkcoP3kL7SikK2c12kkXbg5k4LY2kqVLg3aPvkAXXpbbT18+K8V
	G1YbnbVKjUDkIxJkCtcsZe1w/o/Mrak2gB9G98IjNyZ0Qcmdrp8mvzhjMo+XJWEHr3XxG8Hwo6n
	8XtD0FYfP6kRJLr8k8MIK
X-Received: by 2002:a17:906:9f84:b0:c41:b94c:4538 with SMTP id a640c23a62f3a-c4ca7af1b6cmr189766166b.47.1793360625856;
        Fri, 30 Oct 2026 04:43:45 -0700 (PDT)
Received: from puffmais2.c.googlers.com (180.192.141.34.bc.googleusercontent.com. [34.141.192.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe1003fsm57506466b.44.2026.10.30.04.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:43:45 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 30 Oct 2026 11:43:33 +0000
Subject: [PATCH 6.6.y 6.1.y] kbuild: link-vmlinux.sh: improve detection of
 third pass requirement
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
Message-Id: <20261030-linux-kallsyms-fix-6-6-v1-1-91a57d3197cd@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOSC5GoC/x2MwQ7CMAxDf2XKmVTtpuXAryAOa5tBRCmoEWjTt
 H9fQL742bI3UG7CCudug8ZfUXlVg3DqIN2nemOUbAy97yn4wWOR+lnwMZWi61NxlgXJlOI4x5x
 HohTBxu/GVv2PL0CO3PpLyQUz130/AEyI3AB4AAAA
X-Change-ID: 20261030-linux-kallsyms-fix-6-6-cb5fbdd566cb
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

[AD: kallsymso_prev is already tracked by kallsyms_step() here, so only
 add kallsymso_changed() and use it]

Signed-off-by: André Draszik <andre.draszik@linaro.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
This patch fixes an actual problem people are seeing in various
different kernel versions.

No versions from more recent kernels apply cleanly on 6.6 and a minor
context update was necessary.

The bug was introduced by 7e2b37c971a2 ("kbuild: kallsyms allow
3-pass generation if symbols size has changed") in v4.10.

This version of the patch applies cleanly against 6.6 and 6.1, can you
please apply it to both branches.

Cheers,
Andre'
---
 scripts/link-vmlinux.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index ad16e25a62ce..2b8746f7bcc8 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -144,6 +144,18 @@ gen_btf()
 	printf "${et_rel}" | dd of=${2} conv=notrunc bs=1 seek=16 status=none
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
 # Create ${2} .S file with all symbols from the ${1} object file
 kallsyms()
 {
@@ -271,7 +283,12 @@ if is_enabled CONFIG_KALLSYMS; then
 	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso_prev})
 	size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
 
-	if [ $size1 -ne $size2 ] || [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
+	# Due to alignment, file size of the kallsymso object file might remain
+	# unchanged even if individual symbols within change size. Changed
+	# symbol sizes can still shift other symbols, though. Therefore, don't
+	# rely on file size alone.
+	if [ $size1 -ne $size2 ] || kallsymso_changed || \
+			[ -n "${KALLSYMS_EXTRA_PASS}" ]; then
 		kallsyms_step 3
 	fi
 fi

---
base-commit: 0aebf2870d53a8d97e02a99e2103ea0b38950c1b
change-id: 20261030-linux-kallsyms-fix-6-6-cb5fbdd566cb

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

