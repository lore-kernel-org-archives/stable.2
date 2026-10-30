Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362575;
	b=g2RoZdOargoJTw2f7mWocLkufev9vGzwAEDMYAnW47cESiMP0/zg/HY5L0VEgOFHErW/
	 yldK18iGIyek350RmhIWWjq0lLGSEAP3E8lPjZ9U+o0Y90DloSj3NDWua53bBJZ70bVnv
	 J9FFkbWfSCLGMkHvY0ZMTVB+8RkYBx/NDlYYkQ0YcUlj1heui+6VD847J4a+eT28LSFhg
	 WvMTwcuRXGX/OLLJO5aXxNESQ0JkmyInfiZLokgPS6HhgcVbzecvJLdECZbM0na4bE4YB
	 rjkhHaGtNC2aq8/2eWP3Cf31zdrfDhTNwWT/NbroPsn8Ob9tduFzi/8/PDJoQolueIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=zfGTr8GP82BAHjVGcRWUJj13EK5BmCatBJlN0vTN3F8=;
	b=iw+8+FnqL5cRq6TbEypjP/YyGIUi+hNVlb6Y1WoVkw2pHA8t/HOUDV/QaiCz9TmA3rSn
	 GFRRJ6SEi5IvedpEp0aRRiT86xMLSN3PzlVe7+6imEuxzWKZNzw/9YYlfm/jB4P9BN2vY
	 MqYdb4zC4C6WuLZE5L1wGrKYwPPvgYSSuv2Hf0dSN8Fhw7xJoFP4lXShSRr9c5LmJXIx+
	 EWmoKIUukb37C6DiDGyHljv+uEpoC32adBEIJ8U/JltwPeZVNcr6ZkuzKWpgTvfu0JYvI
	 vThy3Gnuio5kBa21MHfcbaM+tRxCLbhDJd5BteY/CYmaGCMA9LwrW08xf4vxb0mT5Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RrANfIKA;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7C1606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C7C1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RrANfIKA
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso57856566b.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793362573; x=1793967373; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zfGTr8GP82BAHjVGcRWUJj13EK5BmCatBJlN0vTN3F8=;
        b=RrANfIKAnQwplsmZf36+g8+qb3TJPI+P1KTq3sqddtfDdH+c//CF5suiAvJdCgHaPG
         qb+fo4e1Wwqk3uokpKcZliooux8JXq1kiQnTeCH4Fn9C96BP8RWlLJs61pZqqDMFL7ZY
         cT9mork83Z4eIk3vT9UcY97Fi+tQSgAO3GSsWBMyW6KPO5kBQ+9jQc/7cRyP08tS44IT
         UJjhAcCL33stKASvnoauVxdJVVHIJ1lJQ9TvmvjGdyLHE1R598R4G8ZZ9qqf4/Blv8pO
         Gmmdt1iwM4zUhSHyJqYMqmTI8OURU06VfhtmDaWPvxeWg5Bo0+9gVkZT2rfWVOiY8cON
         2+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362573; x=1793967373;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zfGTr8GP82BAHjVGcRWUJj13EK5BmCatBJlN0vTN3F8=;
        b=Nt2//btj8o9teqOXcnppb2rxSmlXK/tpn0esLU5gqFBZf6joy5UjV8yw/I9uTF2cdR
         xVQvBGwMlcxN1AefVgWkPcHlJUnDKtiX8164oySHVj0hrgqybGSLr4tCKOq/4LbuaKFk
         OOoIiA6SybF0YiO2fuLvxKlkR4Gk7/eY3YEZKZBdR5Up6wAD6P1YW86LErncjRGjBJQJ
         u+4Ml8yXQhLCQDNlbjKLIfDiqu5v56nYw2fguLoPDW05GfMQn3fN/ZN+GZZcPaXqrdSV
         3ry/5f6meAM1sZyeKr4Os6b9l0hcjWmuSXYN74EKYFqngyf171YJfHhrlFG5F5sQtQJJ
         kqvQ==
X-Gm-Message-State: AFq9FYJwy8ddEHrPWwOIiXoykX6Y+/HLhUKdyUE/yugSffxlR+Fa0kQk
	DdSHOZTGPoOMZnBuYgU/qfyUS9TGUlp/GUKuK1Chn3FRVe5kHYdJZqUe9YXiSEiZVek=
X-Gm-Gg: AYBFou0+j6K//mVLD9QIPIYMnP/usvxWPQrp+n54aFgEK55xKdG/LeNg7ODZ7NMciid
	mOsUDT0+KUZ4SEfBRybheKtJqeazQSlnZEqDCNdP9X1szb+9CZnIPNMy1DQGzPpMafDBd0KsfE1
	wAb8n8GsCxttO4XfDrVuW7VtbftKd+brBRUguIhAdvNxsxAWbUG0+tnL/OF5hrFu9ImETYSy/se
	h19fjP+3Tl8pE09pr2UbfjD6s/jbXcFhNvM4pO+umT+cgUBiHCGa6I1x1FRxiwlmv3oBRzKZvoQ
	Xvso+yeMcrsu0ERCSwqJAxmSejD8nY2xx9o83cgKBopDvQG2lerXbLV8yTsjroBw2TEozKCgNP2
	4LQWYgPSkG9b7L84AQfB9uVxUnUiOGGU+0N3+R30QHk3GmkTn7gHsEhwmwnhpiip1GBwjDVaT/Y
	VUz9i24JVLR7tU3BWcMmZ13I8zB4rll1LSwx1LwKuM+xsXRWnLmkKelVePvgsUg1OZ2OE3z39bG
	p1H7wZv2C4z753hPDokvNV5KnSLfC8wJu+Upgp8eInst7rOXu8iUqAqnua8/Dd0v4KZta5XblRb
	DPaeaKMPmyK3LhxNtgYD1fCYZWOZfw+UsROp+Wf0GBhgCeOe5gL1ccfKHa5x9Dj4tLevC85HkZJ
	ferN/XBAHYm++UYUaAZzI
X-Received: by 2002:a17:907:86a7:b0:c40:80eb:c54e with SMTP id a640c23a62f3a-c4ca792ea6fmr195573666b.4.1793362572692;
        Fri, 30 Oct 2026 05:16:12 -0700 (PDT)
Received: from puffmais2.c.googlers.com (180.192.141.34.bc.googleusercontent.com. [34.141.192.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe4aa12sm59377166b.52.2026.10.30.05.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:16:12 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 30 Oct 2026 12:15:53 +0000
Subject: [PATCH 6.12.y v2] kbuild: link-vmlinux.sh: improve detection of
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
Message-Id: <20261030-linux-kallsyms-fix-6-12-v2-1-689a11cb5b7b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHiK5GoC/4VNSw6CMBC9Cpm1QzoDqeDKexgWDQzQiNS0SiCEu
 zvhAr7d+++QJHpJcMt2iLL45MOshC8ZtKObB0HfKQc2bMkUBic/f1d8umlK2yth71e0SIzs7LV
 3UpECtP2Oot65/ACbE+cbNKqPPn1C3M7DhU737/ZCSFi3ZdFWNXdiyrsmXQx5iAM0x3H8AD53d
 UvHAAAA
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

Cheers,
Andre'
---
Changes in v2:
- drop a left-over sentence from the v6.18 version of this patch that
  doesn't apply here anymore
- Link to v1: https://lore.kernel.org/r/20261030-linux-kallsyms-fix-6-12-v1-1-9c43c892de04@linaro.org
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

