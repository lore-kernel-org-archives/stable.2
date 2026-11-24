Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547222;
	b=fil5p/E9oZp9RiplYO5wsO2Jb/GKTT/58FKXToa3YLMB2hyzKPWSPb/781YybMHbFAw5
	 HGPFFT+yAEdbL6pDZpF3TeiKHR13NyjfoVIP66DHWCMrLqIrGVxfcOp1hCQhkC5Bnsm75
	 EK/uW05DGvB9P0u9uCECCiBlHFSiS2zNPaFU79/pL/djiKf57aUm+kvj8NLV2ESAgAseK
	 Aeog9qrqCuj2GysPk921tRYNAwZqYKV77OnLfkAVz2ufKNhpqkKQOGj4haAWJns4zISnF
	 jRX+FUrmEjk++y6KNlUsYoP3+xWQBkaHiNKJfrtaj9OqgtY23mVcyE5aTyKbap6OUGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OpX0FLoxct1PLaPALz6HFwdz/064VEsupj8Ei+cvWfA=;
	b=EayRheRLzJ+jPbJgaXjEKjTQ4UWXguXC1UL4wCkqk2aGg6coNOVjbwNE7rYC2LuFtqKA
	 1jzoxetDLc6qrP4HsdBlCrojGPuoTKepi8D+JKKhRDakEpMNM+5MWA66MkC8Sa5IVs5X2
	 GW2+2fFyeMWqs3AiWavijYN3KWJ86Hv2IrE4JxOqJAeUcmonFyVMkMn0/qe2EfdgffMss
	 ag0EFkCb3btzAonYT8tIUqsc5Ia5pskInFILD1dxoabpJH2LEz/O7w18ZUqm7RLXM0jQC
	 twTvmUFszrUfmeJdl+n9nm69wxKdMBpZbGsD6BOaboeZyYGcr00T+35kMBvYx/q4b+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHoLtywy;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF0606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BCF0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHoLtywy
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so39652945e9.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547220; x=1796152020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OpX0FLoxct1PLaPALz6HFwdz/064VEsupj8Ei+cvWfA=;
        b=tHoLtywyypVfg3JMPV9R15tELc7sHkPsGD+QBstOYfKWXmJJEXyfCHSAadf2EUkucI
         /ZmlhL7d/HgRBYY2l9uY8rBYJLr1C6frC+CpNp/z5KNl7fVNgBc4F1sDaOcPyxw8gj0i
         wbOMpTix1MQaAReNtkMnhgq3Kr/NX2kSdcYJGq1f7wcL3cu6elOAFTs8DZFB6Sg1egC+
         YjzbLY0bg4wNv664BmTzaxeKcLsni1BeGpD2iGQqfXTP26Q2HrLaxvbJHGGZvxBnd+6X
         2z6pffiCP48AmZXdxgwElSsj2qruwYkQSfh3z2JFJGdhSAybUnMh7/71E2tuMMbzbsDk
         IAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547220; x=1796152020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OpX0FLoxct1PLaPALz6HFwdz/064VEsupj8Ei+cvWfA=;
        b=vPSwIRp7TwLVnyPuvZpBwXsmg0OaT4x2QiYN5xWX6Fat2ZWcn4JZkXFnJD2NES35lw
         9ZaCJTPm6zY3Bef4YRdTAA7ylUlpuzTbaz4Jevl45b0bFfS+4vlQx0qASzcZ0DLNj8ci
         4TebtervL0XD9a1tsRdulWTwoLPfnRX+cXpxJ/LLriH4r0eO5AOWEOpIXosH2KVLbiyQ
         28y/EEm/Gknu3b/yluC+5U/VkKQuNQ46tANdTnq/qEmvb+jDqA1SlUccW+9IT8xFLRdj
         6p2yroFpZZNK+qjOZWT4Kkgcx3tySbxZGKiETEjJSjVQP3wrHREUd1JQrr645h1iAlHM
         0zOA==
X-Gm-Message-State: APuU4Z+zN4zRb5NxLKNLWot9y6LPdhmqsM/w3mN/g3zUeg13oLERxUWU
	O4MkVFuqJ3tdK8KpLK/GYrvciJcn6BmItyr+cKKAaiITQ/bUNxcyjisZs+bw9Q==
X-Gm-Gg: AZFdTZf2NhhuCRGDkGPD4PV3h7KM+5fPOe+2HTaamYIocbG+AqjWC/9k1m4EUA72p0O
	stC4PsyPZVxMgMBsBlh9S1v0alZe8Cbo+g1myNImOHabXR3Cmb+KwHrAtepkZVzPa2L8rC0g0YI
	RNyhWOaCQY+vLGThFwWfRQwSxeZJoLJvO1+ozTqINA5ASkRlr/M7Bpp4aeqFyVZ8J0c8gyr0rPy
	fAgHFKRZ30aXLvatkfzQsYfDOrJV0fDmvtt1TjGWqKC74xb+s/o9+HX6nY5/BCkuWAkc9mEH37w
	DhA1Wbnnui2MCFWhwuU0ZxmwqTYWw0zCWDej/pyDZK0oy0eKreqTY8mY9g61/9CGS37k/QtJ88E
	PyC+uh1J4/NZ73VoYwuDdkzjlT9EzrnJx8vbLIlCvV6WBK1i7Fby2jAHWPH2fQlIEnIN1kSNQNH
	+AJyy+d9DCCFXJZ488QXjSXwbzIdqkyslzqq0d5bR0tIwMz9BxuZP9CQ7SuEpMa0VCO9Sgfsx/K
	WOo4zIY2/DfOuP/s4hnyI2vzwcIFq/i31Uy0vpNRGwR+qjKNfg4v1y9XTHt1t1/3Q7rnTklKBcp
	fsd7jd9ZTj8PUZQZAvE2CN4UHQIA2ILUHNwa8kszoSCytSDwvOWhjdh4S4Cx+t9EwR+MvcP+9pn
	E8hTP79T736AhsTCImwHv1wRL4iKslbSLJAA63x3uNqNS1bzkQxpjxVmv8taOUQs9YcMGceRtdE
	wVIUCoSTWK/k8xLNB2HHowWwCO31JgHOlAt2bSYBdG5aC31x9VxlnVi/ZENZdVzb4XZJ2QmkFvV
	2rZ1/nSl8eqRDCK7w==
X-Received: by 2002:a05:600c:530f:b0:4ba:6d8:dfad with SMTP id 5b1f17b1804b1-4bb88811eecmr305292115e9.14.1795547220396;
        Tue, 24 Nov 2026 11:07:00 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8960068fsm171505155e9.4.2026.11.24.11.06.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:06:59 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] bootconfig: Trim unquoted values at end of file
Date: Tue, 24 Nov 2026 20:06:51 +0100
Message-ID: <17eebb0e1a90a05e84feac2144b05e1d708bae9c.1795547211.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112401-next-exponent-636e@gregkh>
References: <2026112401-next-exponent-636e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 381b391bfaa3f10d52da4740529804b0b6b8160d upstream.

__xbc_parse_value() trims an unquoted value when it encounters a
delimiter, but leaves trailing whitespace intact when it reaches the end
of the input. Thus "key = value   " has a different value depending on
whether the file ends with a newline. The extra whitespace also reaches
the rendered kernel command line.

Trim unquoted values after the scan finishes, including at end of input.
Skip trimming after a closing quote so intentional whitespace in quoted
values remains unchanged. Add checks for scalars, arrays and quoted
values without a final newline.

The stable test script has a different layout. Place the same three
checks before the sample-file tests. The parser change is unchanged.

Link: https://lore.kernel.org/all/31f248f330e716b925add3a0ba76f62826527312.1794337724.git.edumucelli@gmail.com/

Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Greg,

Thanks for the notice. The parser hunk applies to 6.1.y as-is.
I moved the EOF regression tests to the corresponding spot in the
existing test script. The two unquoted cases fail on the original
build and pass with the fix. The bootconfig suite also passes.

Thanks,
Eduardo

 lib/bootconfig.c                    |  5 +++--
 tools/bootconfig/test-bootconfig.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 95ce04eb6b..a3e774618f 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -654,16 +654,17 @@ static int __init __xbc_parse_value(char **__v, char **__n)
 				return xbc_parse_error("No value delimiter", p);
 			if (*p)
 				p++;
-			break;
+			goto skip_trim;
 		}
 		if (strchr(",;\n#}", c)) {
 			*p++ = '\0';
-			v = strim(v);
 			break;
 		}
 	}
 	if (quotes)
 		return xbc_parse_error("No closing quotes", p);
+	v = strim(v);
+skip_trim:
 	if (c == '#') {
 		p = skip_comment(p);
 		c = '\n';	/* A comment must be treated as a newline */
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a2c484c243..be8d058337 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -170,6 +170,24 @@ $BOOTCONF $INITRD > $OUTFILE
 xfail grep -q val[[:space:]] $OUTFILE
 xpass grep -q val2[[:space:]] $OUTFILE
 
+echo "Remove unquoted trailing whitespace at end of file"
+printf 'foo = val \t' > $TEMPCONF
+$BOOTCONF -l $TEMPCONF > $OUTFILE
+printf 'foo = "val"\n' > $TEMPCONF
+xpass cmp $TEMPCONF $OUTFILE
+
+echo "Remove trailing whitespace from the last array value at end of file"
+printf 'foo = first, last \t' > $TEMPCONF
+$BOOTCONF -l $TEMPCONF > $OUTFILE
+printf 'foo = "first", "last"\n' > $TEMPCONF
+xpass cmp $TEMPCONF $OUTFILE
+
+echo "Keep quoted trailing whitespace at end of file"
+printf 'foo = "val "' > $TEMPCONF
+$BOOTCONF -l $TEMPCONF > $OUTFILE
+printf 'foo = "val "\n' > $TEMPCONF
+xpass cmp $TEMPCONF $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD

base-commit: 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
-- 
2.53.0

