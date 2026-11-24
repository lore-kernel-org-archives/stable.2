Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547232;
	b=J5AOij4DJm1wOb9GCUUXWDeG6uK+VqhqOwBwgvwCyzdrqoXOLeiKCljwLwxxfN9mP6nm
	 hTZ1dwkp2l5d94kQPV0PVIW+tAPXEE66jHX8INs37AFiIx5T2ON5VDKD6z5uEEi3FdHqK
	 eCZxCC7Fz34IMlK7NBh+24/+NVobNcwW/oAelHv6/cXq9fsS4gXA8Hra6w1VjP8AnaMGX
	 sUnTRIrSBr4Nqq6NqJbmTAz80TNgF980upMhzpn1p6bBEGe2vLjNZWPjAfH8Ewg+407mJ
	 a99F+s578O7l0PayM0idfsOB+xc2n2EvvK9Eo40wCabjWcYEIqDv8C7PDewofvhnWzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QWeS2DaaaqUG6TaX2cJ3ldFcn1Yi6+PWQCuv5r1XuOE=;
	b=4qBlsulKQOY1jEc6J/bjio6CrWQYs5iFBhxYzGkpntf80fIvHnEpr+/3KKFX262bN7yr
	 JC9n5XpIpFdgYy9LA29DhMRlLtWC13qq4SNS5svL+EiM1XD51t0TQtpeVPavh+wH3JUxS
	 n+PfgrZBn2/4fE+lo3xGTE6uFCJqeEYNSnz9kr1ZuX81mP+Eu3NidAsS3ZuVThvg2wNTE
	 cbuYARYVop/ZJhs6t64baq2g3Fpj/wx+O5Ug9XN/A77pBiTmggbY81zECmzuwwM8hhwBI
	 0wilV1ayjYhALkNAcu8MmPfGQ1ouqlb4Oj/BE4vpIzPINc9oATJV/OoJpJbZeC/Pr+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxXobVQ8;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48886606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48886606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hxXobVQ8
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so45388365e9.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547231; x=1796152031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QWeS2DaaaqUG6TaX2cJ3ldFcn1Yi6+PWQCuv5r1XuOE=;
        b=hxXobVQ8OGOjWGTeKo07K8PS/wPgtyJtQN0GjNBZY7UeDZNuYwHGVrbu5F4UfFgx35
         0qz5K/BbB8nStJQ6frMK9ztXJDnsj/sgZNqkoX/wnJxEwlZiSE9JLPlIjA2lQdpFU80k
         hIJ9uKKUvRCcOUYBd/z3YjDaQ5in3M3+Xw1omkij00TcevggtlzyaVAnYPzQSSnPsNm1
         cIML7cqLSWEuz9WLi4WwYu24oTQvYrHiwGjUHKJrss9RJBvJcGW+iOizYoLTo6W1Bi0v
         xxWQzSR3m9So0L86dXQtmnuGI6iQgiv6QzEh3Q31UybZverEQrrGoSXKRMP9GkK3gjSf
         ub/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547231; x=1796152031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QWeS2DaaaqUG6TaX2cJ3ldFcn1Yi6+PWQCuv5r1XuOE=;
        b=vSemP56X0ZCFk1iG16WBKjswnFoMQgakS7w3egM94YWG7KryuqsZSf75g91kBxAI77
         f+hXUQoo6Aq+znMdxY1HdxyrFTvB16puB4VKUMNLFTazItHN+C31sM6LTupqGmdTlI5g
         35PGZdrrX3TUKI31elk4bHZW2LkjP+Cn/bey7mfe1PFuOzWW1PD7EIpeYvZgT+M87bE1
         3sX/Su4WEEglseBnNAZeWNCHfkxVdapUjviOXC7dZ93veU+eiXlKAxNyWfjjKoULl8GK
         QygNQcBt0apgzANBrKc5nbMtWnYQhCIX812AX5BpEKKcTOMxlfDi33UsyyAKp6FE+56e
         a0Lw==
X-Gm-Message-State: APuU4Z8llO75L4XpbkC3NyqQOUv34Z0NJLKnGL93m9tzyT56A4WalI9z
	z+TB6JqmYnZ7V6MVnRArj92GXpdw5n8XxGhKNdfsh6nt8TaHV0rEVffGrdmuAw==
X-Gm-Gg: AZFdTZdtyjHWr5H/tm++BFGZYss0/irBKcYgsXEo+JVaFvM5nw0Kh50UIQZTNj1y6FL
	hsqSyAQsy5FGQpOJxXG59LFPC+lVq534W5K6VsrDjBucY+Awq4Rpc9RtigOQIuvp3c+zq1o0Ey5
	qsXTYP4MJrn/9RHPAvzWYhoulS37CeyPq1MBnu1KyQm/FznrLrameQ4b02SKhGxEWyAqM/cidB6
	awmnos2cLYS6EXKpyJBevjHMDH3/edljkrrHfpMNyiJSTJF7164dDDd9IEOyalKqTR+65o/ClPZ
	7LxJSYUSBaeNbdt2Gs0R1DdvjfKus6AkDjh2TdQAQrz602Bsk1szTLEwKxK85wo0p6BiTxe61mL
	Btx6PHQkg9FSf6a58PYDdfceb6f7wCKOoR1LDUyDFkxWdlccVwSmgupgB+2S0iRH3nlrVEhkFnk
	M8/K3eD1LptjYxCrEBTF53+MyaUpq9IIT7ll6CUjtuna4/jSyq9vnnlcuXO5ghO5zjiXbviSRgK
	dR3EhMKfeSPcJwxdc+xuiB9lcZzQqK/1H4ndWgKunk6QPIQexVn8wLO5Pb3f5i0lq6SVHC4Xc64
	g3TxPGqaCRdyaqyD7nJX9Rt+UJywQTAJCHIJS2arboR72KH4MMGVcppA39Ol1pg4H4fQ35uViJ4
	41e5lZv00qXXR1Ys19ZBmugjJzKjVq6HYlRnMByI+RA0JzU7RrtEeXEmgxHQyijhfSVtUc5p1lN
	v/CDYd9KkuOrNfTw1lk2gJ+1A3XTmIN1Hac+NGaVrspXAvHCk3CovnFJsCvrnTSdlUioTzhsbpz
	kbE6UYRDR9jPEAehHcF14PdM0rUZUC6NWEzqMw=
X-Received: by 2002:a05:600c:a08e:b0:4a1:fae5:f2e2 with SMTP id 5b1f17b1804b1-4bb887e0682mr321398055e9.4.1795547230600;
        Tue, 24 Nov 2026 11:07:10 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm472294835e9.2.2026.11.24.11.07.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:07:10 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] bootconfig: Trim unquoted values at end of file
Date: Tue, 24 Nov 2026 20:07:05 +0100
Message-ID: <305b357184cbee7304972c7b293ad3da11a9c29e.1795547225.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112402-unscrew-camisole-d511@gregkh>
References: <2026112402-unscrew-camisole-d511@gregkh>
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

Thanks for the notice. The parser hunk applies to 5.15.y as-is.
I moved the EOF regression tests to the corresponding spot in the
existing test script. The two unquoted cases fail on the original
build and pass with the fix. The bootconfig suite also passes.

Thanks,
Eduardo

 lib/bootconfig.c                    |  5 +++--
 tools/bootconfig/test-bootconfig.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index ac878b861c..6df7778291 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -586,16 +586,17 @@ static int __init __xbc_parse_value(char **__v, char **__n)
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

base-commit: 4f2df9a01754521fbba3493e8ad91ef65515e68c
-- 
2.53.0

