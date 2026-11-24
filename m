Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547239;
	b=hflWpSKxD7RoN3tmoXmHBgaA11L16+S9Xy5OXouAMdcuoyhwycqwUfrkT6cWufSAfPa9
	 LKDPoH/Jn1oVIJYynE7Yp9RGwlL5Pil0O0mPR9W+IkJB9RKwWzkxI0w+ysE725ZW1/y3h
	 835Wwpl1cbW+DjOPqiQSLDYc0OSmQdEq7gZ9K4pVgM+Uq2PWKLMgyBOwFe4GinzFs9Iuz
	 Cp72x+a1++yaDWCrBui+jKt9hs4M3M+JyoWiFG+/ybLfovfsyYip5CmgcXet8E+EduzfA
	 gcYC8PQrTbNwV+9ggskPTvHZ1XiVs/oJwXiQrW0wTG5fPIWErFxXnp49VrzG9/djQyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FgZi+nsyPVs7u3bXb6h/s8IEK/RFyuKclCr8Y77aBt8=;
	b=0EREzClkz66F5qhzHvmA8xQzHjAJnwurFmCto+nM3e1hwfjGcupI8ZobvdBiV+HT0r3T
	 F5sxsGwKbkx4MnHgChhtxZSztCrVxaW45IE38+2oZ3D2pSonRBYHvIBFBFQ0mV8X/6PgT
	 i57wDsqJExj86loCg/m2ajbSJ2/WQ0hGqSz7QGgY2RS0o4uwoYnrCSP5eT45XLjifNQhq
	 bPI6qEANTpZwh9rNDOSv+VtJudYWJoJzg8X1tFGNzSPHJaIeMGDuTOEW21C8L/Z3phCCQ
	 DyIEmYwDvFy0yX/gVGSbROx5n8TqNGo+RNBiluVvGd5FMcC70VaUXC7cCIbR5mUjouQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=STJlAoLv;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3C606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D3C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=STJlAoLv
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49a92144733so2417687f8f.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547237; x=1796152037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FgZi+nsyPVs7u3bXb6h/s8IEK/RFyuKclCr8Y77aBt8=;
        b=STJlAoLva/MdLxcgf0jtLAiUHzF1PHRhuLkilaUPq9copnvf/bswY9eLOJ8HjgeloV
         Eg8j8YUZZq4HIt7QOVezpjovNMNteXfBFei7sERtVlUtuVnUhN6qzwiyOQmBQPGj3Rjq
         Pjur8k7dIUaDd+4/hsJbd1nOdnymJxwn7bQk73TYcimVkf3Id2Bb6jVV+BKtxkbNuxgX
         PuPQaBndU2ujxZ7W7dCEMxyN6+1ipssFWmb38kLIvWGUv2gECNhn8tzE+Z9VAXoBs3Qw
         Y+1GPCAfQswSy1bEAWQeCtGUvwY80HEXoQDNOwGJMj9679gsoIPo4ziRTle2ZQ1YP6PI
         mdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547237; x=1796152037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FgZi+nsyPVs7u3bXb6h/s8IEK/RFyuKclCr8Y77aBt8=;
        b=tY00okoEtY1JmSw2bFNdwMrKqFOr5aZUdNQ7bwKQHJMZ1twFRTP6NsDc/H7nfFukR/
         lNet87Pfv6y2cDbZirQcOwBChkCxREEzK6JD3Ei+NI4EsAVuXO/tneSYvdOKbE8mreJm
         jtwLtscKpj2e24TnOBiyTlvE6fSOLV8dg6TnTEGypaocftg3PY8JWfuA4xwYaAQZ/sq9
         1W01UVknBI2OKM/5YIlNqtHeA/c+CMOcRbA18J6xWjbeRgG0G0sqXR2zAYbHejsXEaTQ
         8H0czV8E22zQwmXdcwHafeCAWo+x34af/SPvy/4J0xbSJIAFMTKH4/RK9rrANFt/i2WR
         xOyQ==
X-Gm-Message-State: APuU4Z9QagxlgKX3mg+b3I1pghIVg0Kln3GR0Weq8djhue/MtxyKFdSC
	2erZGGSDZB3zzMhpm3waq95Iifof1UnXkVJ0gJUcwUK98rEOyspHDIsL8cmaMA==
X-Gm-Gg: AZFdTZc8gtzWXe/yUhJqFoq2pprfM1as3jNaH8J8l1dJBFKyqQtTyUXNJ9HA62/995T
	mcLcwr/rx6Xp8MzQc0/P/nJf7rwxU+eMVTgvl6jQTQrnux0TxVdkOVGSfES+8KqbIpMr7C7Qmap
	pI7nX0S9iIPf69C5gSmqfSDipzA/T3lWJxve0MkOdvAAHoLBwS/d3s6qx6sngvd8kdeSAVhab0m
	lD3pm0WgFSeFBTxYBUASPc0Cf1sWPuZ9pXhadrtFoFT1NFMZP7LsY1u0GqfkIicV01tT//wio42
	SsDtSGiWere0KWIgpMyWtwYtQ6zHL+sjhO+t38PXuxdRyxoiujhm1bHQTlWdGq7xFXq32QQiQ+t
	VSCMFLN9q1yWDYHBuAxy+oNJ7HMEbdIFSU+46esNjsNf6TEkTkN5KTOM9yUhz//qJUVKUR5/C89
	81YZ3SSAGZY67vbbV3iwWaZJm/vCdRSeOtqhZQ8rQ4vx9grT7SppBRyaKX2IYbOtuP5V2viaXDM
	O1cICZoXGpRmdp85HL3MgH+oA7ZcU2eaE/EzgtsRHT70peH1F6WIM15CLOSw0wPtYlTaQtXGi3c
	qOPySupeG6tmHvcmJ/ch1KFQBsTHVIoPo+LMwAUsJEq5dfhKOKFJkcQntZrpWSk7UpsnxNbAzGN
	rIBxLigjKc1/E90asHbIiVxEXzL87TGrUHbbJmJWU9u38IjhJ5gAv8moTYwg7GUAqDgPFjDZ45y
	Ee6pY2oQVZX2MJybBwxK5/q01tk6qMxNmh7sXQIZn+orl4KnlbdJEX0YJmeAfnbdwP2hZBV+ZUj
	lqX4CI2nQIuC1BAoQ==
X-Received: by 2002:a05:6000:29c6:b0:4a9:b2f1:aac4 with SMTP id ffacd0b85a97d-4abb42ea141mr20426548f8f.22.1795547237279;
        Tue, 24 Nov 2026 11:07:17 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm29821513f8f.41.2026.11.24.11.07.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:07:16 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] bootconfig: Trim unquoted values at end of file
Date: Tue, 24 Nov 2026 20:07:13 +0100
Message-ID: <17a42c040edf4cac0df91ac43a3c4a30f416613c.1795547233.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112402-grit-gauntlet-c172@gregkh>
References: <2026112402-grit-gauntlet-c172@gregkh>
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

Thanks for the notice. The parser hunk applies to 5.10.y as-is.
I moved the EOF regression tests to the corresponding spot in the
existing test script. The two unquoted cases fail on the original
build and pass with the fix. The bootconfig suite also passes.

Thanks,
Eduardo

 lib/bootconfig.c                    |  5 +++--
 tools/bootconfig/test-bootconfig.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f6bede03c6..58ad45a93b 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -556,16 +556,17 @@ static int __init __xbc_parse_value(char **__v, char **__n)
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
index e36f178f7d..4dffe2bf8c 100755
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

base-commit: 99112ea818e35b606397c84fbc05e6fadb6ea162
-- 
2.53.0

