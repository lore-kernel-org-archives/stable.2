Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547210;
	b=bXptAwgpzu5x4MJw8vP11A8lVBUwKHUKVH2VWudABkta7J3/3WPtzVaore2x1o6RW3mH
	 T7D6JPRnCo6vPjD5by0Qj2+lB0tliq5BthdTPDteyCkQXxhuEh6YuDNNmrNKgYb8QX9QA
	 DY+EIdDuHRTy4Xht9Fw+P5OmYx7h45+P/i6C1YeSaKC38XKc1zeLy+ygWozWI7XjI+0es
	 J2D3GuziTd2X07LKrJFDpZWRTF0610azpYpneO3TBhRSPN6NGW4QQhFyazgHWWQw8/Axk
	 F9hLQ3ekVoni/s1LDt2dkbeyEd+ywzhSr4fSt4d7HZkOo8q+xRJRY6AB7flGCgVzofQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u0+N5l0TcNfGWABiayH73nQ+z1+esdoUj35Jfefsml4=;
	b=4Mmnj8MY4ZlHRoZUo+ryU63xzXS0dp8jrqdueMjFOQT6Mxk5hpiLzIE1R3LihyZLaJsY
	 VMnJF9loIPThKRm0NrG7idj0shn+Y8nS9sT8ncz30BxFSO020MOULaujgO8UqZx7YT1Bw
	 cky4axv1fs4K9wiMHWwU4Q1QA16J3rtOXoAioFQNItuFq47AbNFFurAOQ3VHG1wGOHQq3
	 lRTu9ljAMS42uNNqK4Kv0BiKECdbAW6Ztai5vC85V6sDq+sbpTacNvoC4ZjlFfV2O51Ir
	 3OyswZRVuUwSnpPt4FuTORkzempnENcQ3VGzcggdI9h7GLH0Zju8Q3BruTLOBbRDBbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDqQe20d;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308F606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7308F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDqQe20d
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so31625185e9.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547209; x=1796152009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u0+N5l0TcNfGWABiayH73nQ+z1+esdoUj35Jfefsml4=;
        b=PDqQe20doXc7NCe1gdn37Ufan5D6NQu8AR4sLb+lmRRiTXbdZt6LNNU+elzjCsxb1U
         gE9iVHmukdxhxxStvss3VYh/yWcSdZHLBzWOUP0Le/tgu3Dnr+TXqJtnCjr63eb692kg
         diruh+WgvQIPdSLK8rTpfnLNwGcnPpRXiOOJQMHZf44LQbDe5jSrTRg18Bd76czu64Ks
         9m7+gY7q83j6pxFtZZjdoGtN5KuqzG+/eihODcPX1FstOlZScCiW+F345jvXSMZFrXkW
         FrCGolbWdZtqeEmE20beofXMf2b5YhpS2HSUbDs4DJGH5wqbmZSSsfeE/1Gd/tAsbCW2
         oXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547209; x=1796152009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u0+N5l0TcNfGWABiayH73nQ+z1+esdoUj35Jfefsml4=;
        b=SSxS3/8viDehEoygRa9wtIFILFzCxDsIAR17kywAUrmP8Cgp2llzHfeJ1CrikLcAiR
         HfaQbbfcK2hrAX3G7Xw+3kkE1i8RYeOFMveBRAuNYk53x0v1oRRlMo5Vwo/mMop1CP44
         ebH8Pvx8AVg/FpgIkefHvxZ0Aw2AKg5FW2obt8xNY+6tuGfb+oIVCRSVDmhoCLw1f6xV
         WMc81b9QdQ5u7AAcif9XgtcyGwgKDMLQZb47OPr1EEmqQRJXMWqTy8/7taO8eR6SIVMo
         uypXLLC2RfK9EUtGod9G/SMqy8W4FRSW4qjW9QleCg2sVdm+E8sqzpslxwdxAHz8z8v6
         nNnQ==
X-Gm-Message-State: APuU4Z+qqvql5GpllCd/mVjSY1GVOrEgW/pnlcI+lEVG0UXg59UXdRiq
	CDMzvsZ/ahYQT6la+WTtP1F5ozvisuQFB7qK4aXuf61SSG/OL9cLMf9wKH+qFw==
X-Gm-Gg: AZFdTZctN4FuYX9L0Af1PFwdWmYLAYODQDr0o3lMM65lhkfPa8pBXu9/tE+8Qt8Wf5O
	dLmJ9OcFUBDjFFMIldwVRZBJWsinrhKQ9fbYuPYY9SmXfJyAX1sH/JHKZPiSJ6aOBBYKz/Lq6zL
	ZFnPJNuXHPMB8aQSdrJ8SXpc7S0Q0Q2OKtoYVbb/W4xXL0IlJIxbIEMEjM6KfF4S8pvA+QkbBwM
	7kBb70c+OJ8aM0Iof5lN5xA3KreZ4BdhhBm8y+1crPvDapIQqtMEcMAIE6mb2CgL/U8Dy4SqkTL
	ELDZkVzJfm6pU00y8mUEtkUeWX5TNoWvwejoMirM0Ko/LJIyypCURZ+8XJCag3Isz+lb7uJZpIi
	8202fO7guvKShJSIkN6UZh9rW2KON11IQeerK7sjTfrIqjptQ9l54SGZ9nIgQTPAmkr64BWgRUY
	3J52VWs2EzNpEvVyImCkUR22mzdGb2AxbdvZ+NAAU3OGE7mm5Hd8ja480ZdMyrNsL7jAB8IPrav
	HDwvyUbYHrUJjmrsbmfjtjnezjGsD2EONW1FQ537DmnTaQGk4Xp1MAFhrrBorILVYPw8YyiiXW1
	rR14FeDNV2hNv9cX5np7g9PvRvZj0WIdVM8vG0pSB0+RgoTENnqADZYJf8crNc/7Fn8Ps8InrX+
	uT6uds3ZjI2ZgEvPz2S2dge1gpDMRso+2SaoeOruYzIQRY6P4JlMkWrXrzTKQKvlr1P1R+D8QEs
	fitR1JohIJeneTCgZQjC09nlxZIyXXbTDI9CDGYTKF7jmSv6uimRm2wJbhcEIPJxRiNmejGl/Ri
	UbqG51Qv/7LNANCNg==
X-Received: by 2002:a05:600c:4313:b0:4bb:643e:3b8a with SMTP id 5b1f17b1804b1-4bb86162fc5mr242301515e9.17.1795547208751;
        Tue, 24 Nov 2026 11:06:48 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm29556342f8f.32.2026.11.24.11.06.48
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:06:48 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] bootconfig: Trim unquoted values at end of file
Date: Tue, 24 Nov 2026 20:06:44 +0100
Message-ID: <b116bf85e8c1af9b20636bb521f33e46a7c6de84.1795547203.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112401-lantern-impotence-35e2@gregkh>
References: <2026112401-lantern-impotence-35e2@gregkh>
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

Thanks for the notice. The parser hunk applies to 6.6.y as-is.
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

base-commit: e2bb30811e063ce0db964484357973b855b06572
-- 
2.53.0

