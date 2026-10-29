Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271811;
	b=E/PPCtOkN7M7NmuGGft2Ja05uGRMdTY5huGyZOmOmZN9X3SLkyADEYHraVzVKuNQyLfz
	 Re6LtJYdpp4wSyvw08KjlYOuMv6ploQcL8B+dyI2MCsyAKuTJKhu6glHO/9c1Xk3I5TP2
	 5UmlcSInuiLZmdySTnzE+KNSDxbW+keoXGc/AdkZnc/EEuiOTZ/al/rER+1xefQshUPCe
	 3Bq7IwXwgJbW4gHakKKStPCbVuO/UPGg+cl8yvHq8tHyCIG88GHRPI2UOyU3codlP3MI2
	 qnuNl6e5xHrrN7DOdI05RCI3zTzCOjznyPqGZ/9uArOV6x1cN+TSWpAroiK0o0FzW6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=J5RKqB0wgxY8YriR4eRdaupljBM7MivKlhMpyC78ArI=;
	b=IjX9utZ9saGdS77JUjs9VRLsPX4FhrAz0nuhY0SvW+1/WczwEJtzV/nEn4NjD5dGMNzc
	 Qihl3IYZiIKJGnrzn6sHr/JoIv3fWY0Y7HJueUV3y6u+vCZFb/4LeETclWyAnz9q4YwW4
	 A3w6gG+NviWJPFMld9iqVd6W97WGmqvG7rpUjXL845ihZVMQsGh3CiKkSoUZyPAsYmd3Q
	 enlyqKGxBUY3PoJDD/BKCCditpY1pDM55fCWlDpD+cHGcNL7f/6EnY2aOe4XWUT0UcWWX
	 iKElYcmsVRkJxNEpBnBZMEFVorNjsujt4QVIH/6H3a88PLYnGSX0MUuzJSwAejxLOxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hrXahkik;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75B606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B75B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hrXahkik
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c418e215671so255272966b.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793271810; x=1793876610; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J5RKqB0wgxY8YriR4eRdaupljBM7MivKlhMpyC78ArI=;
        b=hrXahkikk7oPVzSRUtQfM/bx8Q+IZRX4rdX79RaEPz/v4VBbl43d+ck3Cd2vrB5Sj3
         gFx2QuyMC20hfHiS4FxPcfN7zUBaoQIw76IuDe0qf0LHTkF8WXHvDQXilycCuPpU0LkV
         DAabHYnBM7Xdc0VUjq3xEcBW9iSSM8i/tvja/z2LrzMrkBjgIjK2JouGDkjcxYj9hazm
         TOMOmuW3bYbLsvzMYJoZu8PwfbazZIMUpFiSRSPCB9ZrPngsojD/2eC27bO1CyUFr4St
         HtK1obuv/HRs3nWAvxWXyFzLUcWW1LjtuYEoNZ9DY0IDpg/nVmmN9k8CVS9qQyTfaY5Q
         wvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271810; x=1793876610;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J5RKqB0wgxY8YriR4eRdaupljBM7MivKlhMpyC78ArI=;
        b=mbN/Mn2J7tnUke+3u6fowU59+KH/LeDJK/bm6WHxd7TsfRDW2IfWdnVwjHDZrmE7OC
         TqA1TfiEwD3rWYTlfftgHYOM/eu/KOugIvnSgp0lvlI8xqBFfoQ2S4NaP/HJsMUp/LYP
         k/6TO11Ge4szADI/GGjYsCbnIYZ4TGosEWfaMnOAAjSpYfdFjAPRTAtFWLQ45LbZvTJ1
         s7DSj7PFtgAhrKGkYeEqiC9Oc+J4DXdsridMj9GzQFJhcrSZ9/TQ+5pgA+XwH+HqDYz7
         hLboBm20TkvApafzVP0uuasFNu6YYQy8GGC/J6HzwF2G3LAV3/TPT+fH0dnfsOtL9iPz
         6Caw==
X-Gm-Message-State: AFq9FYKoqscGoPz5uper8DguPwutYWz48ISt68EOKfxTo1FYQpBfnEVY
	D4UpPYUpaMgn9v1l5OuZDGPtezgnYN2YYLfXwCf9jSgMeInfKAH7CwH9rfPZqwlIyXA=
X-Gm-Gg: AYBFou1vkg3jCJbvVujLSL5ycEz0N7hSRpQv3PPXqS6Cts051lIJd8/RmFmsJyVa+SZ
	1anSdKrI+g8YaKfXysp1chI0w3O5/+vkxv4e2+AA4lRjbcfXF6okFQM5Zca+gUo0HOCSnTBdqkx
	kq1Pqyg8IRPcIt+118bGkE+usUbBcoK0UZpv43+enGq/nYvmXpZvNIEPNvS+HRxoYwgcN334tnQ
	XtrltJmaR4VtWdsY5ZLHHCjVuvT45GlCtVCfh+jN+2ZPs41JLfLkZSIk4yzZv16y4pIobEk8COk
	tKOISsQliRi1onsIWstXbi+ODw3P+shxFrZuiPSb7KeukK2ojKK3gV13Jgn+wPKu5GztoNxBcLB
	nVmDqSusTZTLdQrQEYcjN1kycKDl2zLFAlWyhcE18pRKi4NzxVexlZR6GR7RAS7BadSsXiiDz/v
	iSReOS+RiZ7JL2KrYpu1Lr5a03VVFnPGXKDr0q2d0322iSQbWeuwQKX/DD0QpSqiEMUah+fxZVT
	5iunku7ieTrw8F7imOvMgBS0ZOq5GSIRrKfUxGejbnDDGBEnOeFNKn/I3O5NWzwO3F7pifqrnLK
	opKGyw5guhaRaJBkE+SaorjbumPpL6RTQVQ7fw0QtKmu3PeqX+AAs28laR3vUb8I254KvoquTXS
	GfyiFRFxNY8nH9uUyI6zMig==
X-Received: by 2002:a17:907:9606:b0:c41:e75e:5889 with SMTP id a640c23a62f3a-c49bdf2edb1mr432560966b.33.1793271808923;
        Thu, 29 Oct 2026 04:03:28 -0700 (PDT)
Received: from puffmais2.c.googlers.com (180.192.141.34.bc.googleusercontent.com. [34.141.192.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd5206dasm723212766b.33.2026.10.29.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:03:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 29 Oct 2026 11:03:26 +0000
Subject: [PATCH 6.18.y] kbuild: link-vmlinux.sh: improve detection of third
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
Message-Id: <20261029-linux-kallsyms-fix-6-18-v1-1-69c5dbee4c80@linaro.org>
X-B4-Tracking: v=1; b=H4sIAP0n42oC/x2MQQqDMBAAvyJ7diUJEmO/Ih6iWdulaZQsLYr4d
 0OPwzBzglBmEnhUJ2T6sfCaCui6gvnl05OQQ2EwyljVmxYjp++Obx+jHB/BhXe0qB2GEKbOqcV
 T30Gpt0zF/c8D2Ea75oDxum4inuOicQAAAA==
X-Change-ID: 20260924-linux-kallsyms-fix-6-18-dddb780fae97
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

The version from 7.3 doesn't apply cleanly on 6.18 and a minor context
update was necessary.

The bug was introduced by 7e2b37c971a2 ("kbuild: kallsyms allow
3-pass generation if symbols size has changed") in v4.10.

Upstream 14b8b4bf2d7b cherry-picks cleanly onto 7.2; please apply it to
the stable 7.2 tree as well.

Cheers,
Andre'
---
 scripts/link-vmlinux.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 433849ff7529..050791ea1023 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -133,6 +133,18 @@ gen_btf()
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
@@ -149,6 +161,7 @@ kallsyms()
 	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
 	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} -c -o "${2}.o" "${2}.S"
 
+	kallsymso_prev="${kallsymso:-}"
 	kallsymso=${2}.o
 }
 
@@ -267,7 +280,12 @@ if is_enabled CONFIG_KALLSYMS; then
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
base-commit: 1253a6aa5d104312bf0992afacc15220ae35bdf9
change-id: 20260924-linux-kallsyms-fix-6-18-dddb780fae97

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

