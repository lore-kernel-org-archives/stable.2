Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC6308F0A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018245; cv=none; b=qEeV7Rp2rlFwOZLlm5xjWqsR9WOfOBaXR+KWkBo3HveQS+vT8w2KN3VbusqdJl/wfXFV/6nxBz1p0edXyXMOn8KPi4qe1KZ7x8D0n3daOKHqqwbLTPY4bKwmIxaXZgjzEI8R6wf1C2GSMXqxblstFzyCjFBdLSXx2w5g6aef2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018245; c=relaxed/simple;
	bh=jyNi2uQN+yA/KxZs/JeOh8FJ+fAidxRw+r2ty9saz0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dD/EEModKT044nBSFowThZpu9P9SKF5a7FIhOtGACS/rzVgEtzuKwGN7zLzqmONAAvAM+h4s8b5bEs8Ves4JBsu3cod21zDi6tjqhcxTyJptU+1ab9WnOJkvTTabrBkJURkvV2gomddJqoOC9Qqw/hkmTqljrXU+SosF/YBzGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoHG1Zjl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoHG1Zjl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4758bd3731bso535192f8f.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784018236; x=1784623036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C2Wd2Xk4XZ8QtjBdQAzkHYSxRYvpP0OLkJpmP7Ac0SQ=;
        b=RoHG1ZjlN9LgqdgchRqf/YaTilkFn0aSTzPr5wN/U5HfBN2utje0GaqlVq54eCOhJv
         QtrOgbOUE1xWkc6eNiGptCUfaj84r7C6ABNGYomMT63j7pb8AIX68WhY9+U5wSyDFIGb
         WAEPAYpgpXfmFNtua87OM5m8A3J5hgMkCVb3E/KrDGyZFwF+Ab/QLq1iH9kaW9DvOuxu
         cJhUwP56x44S78K/9JCE/XH+FMTrX3+Pe1s87HQxc3gnDzHNEZxNmrPQuZ+P3bwCOkaU
         XRDXhANlAj4kUjSaIcGRS1i+87/kms91l/YpENjhU5faNS4MKtjjfE1l3TQseMVco7BR
         gi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018236; x=1784623036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C2Wd2Xk4XZ8QtjBdQAzkHYSxRYvpP0OLkJpmP7Ac0SQ=;
        b=qtyRBIYzZVztrLmdDGx3jDyBLwUfAAHpqzIgeEZkOiheGwStL3umClVyh4KWFVwxqa
         VHg9598zLrE6laEWgPxceTfI/yofqDfMtyDuAhg0eL/r/lC9zJ4TNy1ZrUluCQeEDuRg
         8btg3KZM5M3ieRmQsxo8Cc4GYmVDOiqGj8o277q17jswsCkY234nIH6evSc9kBpDij9M
         ZVV1gR/bXBAaDM6gjqrROzcOCEyYCuR9Q0e/n1NDs0EsE76e+KjSD3uFNFYnYUtQPoLe
         7h1jhoIdW6uxBDYGucGADRoWbkucawQA2VFsCKOYoSsez1AcRa+iZVzl70qZ3wRTAm73
         Q+nQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1GE97j9EqoY8Fzkhgv5avouGbEAi9jl6eySl+I56mfRULAFZ0KwaWN9FbdmTO/fAFwu0v+10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WXew3wZnk/LGJ1IHE1Q6/w3Z2FQhTB2hfatI7f59ruUdsTZX
	B+0YxcDl5kM6SHgZe7iNQ1/5WEF0bbsi0+Drw7sGBN/tkw3I6rPf+0wc
X-Gm-Gg: AfdE7cm/ZBRHTbWZirV20ri37SFJP/Eeu+uE0ZjmBtH4125Z75ND3KZPzLhZRiit9a4
	ktMknrAqpVlLwMbEyHuywlZtcRon5Iz6Kb6a+cM1kUTdM4ObBaxmimykfP8Q1+N43zUuSnZY8cK
	/WCWxTMbra/Jt3+4oYCpAcSP3BL/1Vr5N4y1UXYwn2SGjHqmfvRLg8n19Xkn2vPrf3SlIPrWp1N
	IPSkqhSnDf8rEnsG4P5VhuzHqWnMrM2kGn1oPeWLne912FKjTlejYR8QnUSr52X/51GmO1edUu5
	QH9DZ3BzAhEJIY7MVS6tQEbd4TfCLzROV0gwn4AWn7FUh0V/0zpJvjfQdWSKdKAWGIJz+DfGL/X
	GncmOE6AVrm10FqZmTbp72JIDMlvMPBYVm0FV57QhvEW1pFseQEGszg9BrbHJ1AymCkoksubK7X
	SwVNC09u/34Yb8hojTSs612tQDMn8ZF16BAkQvrsf3wlyo
X-Received: by 2002:adf:e19a:0:b0:47e:96f2:52ab with SMTP id ffacd0b85a97d-47f2dc85da3mr15640517f8f.7.1784018235606;
        Tue, 14 Jul 2026 01:37:15 -0700 (PDT)
Received: from localhost (a89-182-201-216.net-htp.de. [89.182.201.216])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f464c7c96sm6238308f8f.33.2026.07.14.01.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 01:37:15 -0700 (PDT)
From: Sergei Litvin <litvindev@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: ojeda@kernel.org,
	nathan@kernel.org,
	nsc@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Sergei Litvin <litvindev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] scripts/tags.sh: Add support for rust source files
Date: Tue, 14 Jul 2026 10:37:09 +0200
Message-ID: <20260714083709.69517-1-litvindev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com>
References: <CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing the command `make cscope`, the `cscope.files` file generated
by it includes only filenames with the extensions *.h, *.c, *.S and not includes
filenames with *.rs extensions.

To fix this, modify the functions `find_arch_sources()`,
`find_arch_include_sources()`, `find_include_sources()`, and
`find_other_sources()` so that they can accept an unlimited number of filename
patterns as parameters for the search. Add the `setup_name_pattern()` function
to convert these filename pattern parameters into a list of parameters that can
be passed to the `find` utility via the new `pattern` variable.

Cc: ojeda@kernel.org
Cc: nsc@kernel.org
Cc: nathan@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Litvin <litvindev@gmail.com>

---

This is the second part of this patch:
https://lore.kernel.org/lkml/20260602121521.11650-1-litvindev@gmail.com/

which I have split into two parts, as suggested by Nicolas Schier here:
https://lore.kernel.org/lkml/akVkIrcpNxZrrfii@levanger/

Changes since V1:
https://lore.kernel.org/lkml/20260705175957.4672-1-litvindev@gmail.com/

as suggested by Miguel Ojeda here:
https://lore.kernel.org/lkml/CANiq72kHbVQfNrum5D2a5sCd3mFQHNtigrQxP1WW=YcggxA=WQ@mail.gmail.com/

- Add "Cc: stable@vger.kernel.org" tag
- Add missed "Signed-off-by:" tag
---
 scripts/tags.sh | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index c9dc2763a505..41e38df96984 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -46,13 +46,31 @@ elif [ "${ALLSOURCE_ARCHS}" = "all" ]; then
 	ALLSOURCE_ARCHS=$(find ${tree}arch/ -mindepth 1 -maxdepth 1 -type d -printf '%f ')
 fi
 
+setup_name_pattern()
+{
+	pattern=()
+	for ext; do
+		if [ ${#pattern[@]} -gt 0 ]; then
+			pattern+=("-o" "-name" "$ext")
+		else
+			pattern+=("(" "-name" "$ext")
+		fi
+	done
+	if [ ${#pattern[@]} -gt 0 ]; then
+		pattern+=(")")
+	fi
+}
+
 # find sources in arch/$1
 find_arch_sources()
 {
 	for i in $archincludedir; do
 		local prune="$prune ( -path $i ) -prune -o"
 	done
-	find ${tree}arch/$1 $ignore $prune -name "$2" -not -type l -print;
+	local src=${tree}arch/$1
+	shift
+	setup_name_pattern "$@"
+	find $src $ignore $prune "${pattern[@]}" -not -type l -print;
 }
 
 # find sources in arch/$1/include
@@ -61,14 +79,17 @@ find_arch_include_sources()
 	local include=$(find ${tree}arch/$1/ -name include -type d -print);
 	if [ -n "$include" ]; then
 		archincludedir="$archincludedir $include"
-		find $include $ignore -name "$2" -not -type l -print;
+		shift
+		setup_name_pattern "$@"
+		find $include $ignore "${pattern[@]}" -not -type l -print;
 	fi
 }
 
 # find sources in include/
 find_include_sources()
 {
-	find ${tree}include $ignore -name config -prune -o -name "$1" \
+	setup_name_pattern "$@"
+	find ${tree}include $ignore -name config -prune -o "${pattern[@]}" \
 		-not -type l -print;
 }
 
@@ -76,23 +97,24 @@ find_include_sources()
 # we could benefit from a list of dirs to search in here
 find_other_sources()
 {
+	setup_name_pattern "$@"
 	find ${tree}* $ignore \
 	     \( -path ${tree}include -o -path ${tree}arch -o -name '.tmp_*' \) -prune -o \
-	       -name "$1" -not -type l -print;
+	       "${pattern[@]}" -not -type l -print;
 }
 
 all_sources()
 {
-	find_arch_include_sources ${SRCARCH} '*.[chS]'
+	find_arch_include_sources ${SRCARCH} '*.[chS]' '*.rs'
 	if [ -n "$archinclude" ]; then
-		find_arch_include_sources $archinclude '*.[chS]'
+		find_arch_include_sources $archinclude '*.[chS]' '*.rs'
 	fi
-	find_include_sources '*.[chS]'
+	find_include_sources '*.[chS]' '*.rs'
 	for arch in $ALLSOURCE_ARCHS
 	do
-		find_arch_sources $arch '*.[chS]'
+		find_arch_sources $arch '*.[chS]' '*.rs'
 	done
-	find_other_sources '*.[chS]'
+	find_other_sources '*.[chS]' '*.rs'
 }
 
 all_compiled_sources()
-- 
2.55.0

