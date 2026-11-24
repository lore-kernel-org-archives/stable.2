Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547190;
	b=QHFO7MfWkUje2O1QP0McwOaIaMN1FkbGhYoL4RHVR5QlOwrD8uF/iNbGUOl0KSiOmPKM
	 7qNiUmD3beHEugNaDKhGZwwtosBJdFNuK4FVxvyv9fjkBKRtvbtFgSwa2ob2L3Mq6qEsS
	 KZmT9pEC93S5PtUZK7l+5PMCD4JVQra9zV00a6PUGl8VP0D04YGnsjsK+nJQpvph+s7S+
	 QT5waNX4vIiGFnbXi/0cy3he/5sDpcEUhVR9hPBXaXo0ZEdoSewvMzP3iOZdBdyAVKxzc
	 Ldx3ZqYEnUlcUvm3G0iYwQVlAJf8MGXX/PnT6RFij2MPGyXsqZxlfTULdpZy1K4zmgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tkqslTGIZ6IGvhyXUq030V6SxNJmGkMMXCaoDIgHS+A=;
	b=pMNdi+An/4MTXzpno6+qKtgph73K/zSiDYzgkHIVUMXI8mh8nyuBQMur4BLAxaeOQpmZ
	 DrviKJq/LgESXoyJH+XsIKTSEShx0ltD5bA1btcienGkjhmUFMI8oHWUeONoPugFCJtXQ
	 gPqtyPrulhFmy2VtOm5txdlaCTJslXpl2K8ZfP86QEy+5ZacOtm5sDoPq7QZujbZhiakQ
	 qr7uFFlhwnONBbrSXw56LD9kOELtHtA9gZfmv5znnNGYPQTbV58SkZK++v+92dBKYU/a7
	 4g/xJk/GXwxt2NGOLC74MaxgnlPeHHrgoxhuyetX+vGoX9gZXVHwnmAV0kNW7AC/xyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiCpG38h;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3798606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3798606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiCpG38h
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so28649885e9.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547188; x=1796151988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tkqslTGIZ6IGvhyXUq030V6SxNJmGkMMXCaoDIgHS+A=;
        b=tiCpG38hntcCN+dk2EF+TzXVtsurh8kq1LKphLF/ig2rSGYrFPTHZgg/7iSfUF+PfM
         6G+sBPIUMPSakBz7uZ1RlkkbE1hGJYGmPDH5WPM2bK2+GXGmsC4GJ2B8k7qF17taoxsw
         Wd/J8Isaa6MBG8F3H5TCm+R1tSSgWxUz97jHxSG4NcrGSfbLr3hjhZ5KrYJorJVa5eJM
         LfZmaAYu8Rv7xHZMrLttsOkm7iE11A/7BjvUA1ChOGDur9IUhOF3Tq0PmhJIAgFkCFLJ
         MFnfny8aOMd6ZXc1FLHXSj7GkjGFOVk1FTPt+rnm8ryIxuLX1U68csbaURmGgaz8V5+f
         X2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547188; x=1796151988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tkqslTGIZ6IGvhyXUq030V6SxNJmGkMMXCaoDIgHS+A=;
        b=rrnaJDQOXxV5D0MQuNBglYF5+zRqZrLTUCZbl62TqK8Jou+P8TZGlKqnxbaq0SlMUt
         TEcLgq8yc8fMIFvFaYH1niLMK3OZL2T06NYvD9Z3obqi9IXqA4V4Nt0LVoO187oawozu
         +QhvNoznLgLNCFAula9UvVus3eDH28KFDJqN6x0/gfCVjNL+17wZSZEZZanG4XhpvrmT
         AQmuCIa48DzhTkJoSXOX7MQgYgPnq1NSb5+uq1vw5L1pw+0Id+b8LNOyLixw4iADwiuP
         TBehEz73A0moR5+jV12aTtxd+Ki5y+D44ZG6rtmAKrTYUjfyktezOPFGzz7BRnHtLZYq
         Y71w==
X-Gm-Message-State: APuU4Z8tiDEoEd8b+Vrskb0bXO3R8mxZvhyJVBRoDtOWZhFkc6wVCgCn
	o1x1XgoGem82WR2QqMqxf6aNyEo9FwBtzOrksR/6pcST9Ssva38b0GJAm2Zqqw==
X-Gm-Gg: AZFdTZeRKIzg7RodaptS+48om3jbqgFizWarNzaxCz+wgJTu7m08KGfI50iuxQRwJ2D
	hBgjBc6CrygXYU7VO4D4780XsXWvSzmDB3FpEFzveVVWcQYfMWhVgDztAy7tfm3SasOs6SDiTmB
	0XMXVSPVkRP6oDkGvI44lUotLJMCIOOlTnHNr6AGWC0fz1KK69d8s8vldUWtxLtyiMlKWbrTbm7
	pmzNjyUYX01W7+FjuaZZpd1Jjeh/AwAdZmwXZrnDUEDp6h/b+1PvmhuPPYRkGI7+ubgPxSK/Zdx
	EdkfjoZ77Dt/gEVWQFBYhGRoUuQhzmLNs++ofki0iidXJPjxMfQjQl8OcoavrNubUTMrlw1trzU
	qyfaVUQafEKsZuGLDmaujY5HqNAXGaEkIy/IXB9Z4xEz5O800PphVdg13X21TtqFR5hDIbkhRuo
	tegFXsHHyBDn3s0okQpQWNuBrmlFDmmOIwf2Etqn35P8/uHmwieEkQfsSC19pQh+pKK6Cehxg6G
	owQLXo62pwsn59yyRSLuHQZy5luZb3v+KRu7vvzFO3fG9NUcDsD7ttbJaDM6on4xVSQ3vVGqhuc
	GQoUibPrmaRLKi5vnMi62q5A35Rv1VO4VTXE1pxXuQX7xxfbNegArHZC6Qr3FbsdcciYU1X8Zd4
	XGWVVvuwA3IzIAbl87odRKnhCidMqhDc+NKWgJ02Achh+P7bS764+u6Z90CZUTAkCHKw3m3YC/n
	3xeZGHtkBWeXRwXCAZj2tt1Q97vYHddOvbcgTuPADcWeU1jY+z1KzWJdqDS/sRbsRQVSjG8Vfau
	2szTMvb0js7jlEKSw==
X-Received: by 2002:a05:600c:820d:b0:4bb:7b4d:6396 with SMTP id 5b1f17b1804b1-4bb887e21c6mr287562665e9.3.1795547188204;
        Tue, 24 Nov 2026 11:06:28 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm30425962f8f.3.2026.11.24.11.06.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:06:27 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] bootconfig: Trim unquoted values at end of file
Date: Tue, 24 Nov 2026 20:03:22 +0100
Message-ID: <44f125a6a3a3bde09a966d0ce191d0fa0af692bd.1795547001.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112400-underage-preheated-44a9@gregkh>
References: <2026112400-underage-preheated-44a9@gregkh>
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

Thanks for the notice. The parser hunk applies to 6.18.y as-is.
I moved the EOF regression tests to the corresponding spot in the
existing test script. The two unquoted cases fail on the original
build and pass with the fix. The bootconfig suite also passes.

Thanks,
Eduardo

 lib/bootconfig.c                    |  5 +++--
 tools/bootconfig/test-bootconfig.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b4e8e17e29..a2faf01541 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -652,16 +652,17 @@ static int __init __xbc_parse_value(char **__v, char **__n)
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
index 7594659af1..d6211efe6d 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -171,6 +171,24 @@ $BOOTCONF $INITRD > $OUTFILE
 xfail grep -q 'val[[:space:]]' $OUTFILE
 xpass grep -q 'val2[[:space:]]' $OUTFILE
 
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

base-commit: 4700e3adf3b24b39dd4929e9c6d62811ba3ccea8
-- 
2.53.0

