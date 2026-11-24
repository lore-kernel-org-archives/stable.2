Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547202;
	b=qqgoc6HD+phtMQ5gN/VaTrHOBjc6vQyRT6d0SNtxZP3zAwQZe4hiaEEzVyYP6cG6jmZS
	 yjfNxC/mfwQ376S5+Y6A1RhcseUdWiFn4uBeyuf5c5zFqYQSZO6RvsgBj0KRkaqOrqYvT
	 Gl7W2iuvdNNxlKJL3l6q22hrWjEBGQXuGkedALHcEVpatlzQ8VaTjJ7Bxopj9bXVNCf6y
	 u0ZQku5awkYZYCOGFTdp5I0CPs6j6+74CfnfOnOt9xjCixe4ircbYFgIEQeomxN+jm1IR
	 vDnz7XDt8F0aEBN4r9gP1Ya23f/XopKfF4IFS3qBbbWORkDzOPDZWQ9Skvbkri50bHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6BIMU6o2sLqqhi12F5lHIdOnfygamAJ2pU00Cj+aLvo=;
	b=SJJ2LvZl8ebEMgdineJGd+EO/YVQXD5C1ySZ+JPua2g6iPCuDN9QFDVqwIHe/uDPJcPN
	 jc1fI6m2lu1OPMb6Y56MJa7icjRu+p6eHjezvbJeAtyfkslLBaxNSd+Ddzo2liQ5AaQ8g
	 76+IRjS3Lywghu1eUoN/jXsiuzMKAvXoCtxYJ3R4rkk3WFvsOf4Z+7HKGyigS6D11pNMG
	 yzqXACrkLUr/H9NYFQ1Z274egqxfZfQ71PthGVNcvezJcnb1BckIpRlCxeFxuoQPQd+YS
	 X/KShXJTU6zCB6ShlHyI/HtAAc3Xt3Gvt/eXX2XyY4ENKr2Yhfxw8dIRrrJ6FqE2xpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtXB6tni;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B575606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 19:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B575606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtXB6tni
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so3206214f8f.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547201; x=1796152001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6BIMU6o2sLqqhi12F5lHIdOnfygamAJ2pU00Cj+aLvo=;
        b=rtXB6tniQcRBK+LYw/8bW38O6J5DQYmZh0ovt091iR+7uCx9JN6f4QK4Xk2CLImrrN
         EdU5PyK9fQpXvpzNAJPosc/o3mxw9lW+MBIJ5UaetNMwmFgzSyOHnPiBWqxIf4kcro4U
         cZYn/vVxZWvO7Ewv1CKJAUhuH+hlXgCzm364AwAZNPvMtTTJQ7YbSKwCcNON+iXbb9I3
         jEo5lJMsReF5HjgR55XHuumtWmdTnSbAoDTIMt+uw+B/7SIf+wxHTOUg1BbXy9YtTd/e
         b6n+n9wCE9EpLC4lvmYuLDaSU9VETqQ8LAJyNnH8ipSGUsbkIqYOwK8vaIwSfZ9PaLqa
         XTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547201; x=1796152001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6BIMU6o2sLqqhi12F5lHIdOnfygamAJ2pU00Cj+aLvo=;
        b=eTyeAj4oEJNmTHjGaqurXHYZI08oe+gPpxKMDo/rHuF9fg5EMf8b3zpPAMqnEvTk1/
         iGZBKgYIO8JxP3SOoBHnhwUuRP5AfpjJOqZ5OG8k2rHEK4M3RnDw4VgQnnlYYt+0I1Du
         ghjhKhql8Sdq0D6tD24TB+Dj/9zT4F+L8Bsz6pV7HWefaMNZX1gXL6hU2aFUT/hERS4m
         Ai5CPWUdPcw2goBLZ359RzFHBuXdorQrelgpyShEX7yVDIG4mrqRpvJHGzh6vd5aE1Iy
         5sj0jO0yDtStl/hm7mZ56jQfOox6SrbcdngFw2hFSZyIQvEA2aawVqa6YtcbXziyhVZl
         beMg==
X-Gm-Message-State: APuU4Z/ToFra1c5WAlBvejajb4PKUi4RrPm0IHgawY2rMG2Git6QZLcd
	sxpsX43NBoOjC8BELNvmH6yDa3bNgC29N6gB0Xgr8dqBViwSZvTvpCTES6AeXA==
X-Gm-Gg: AZFdTZc8wdpxVpd43XGJ//DAEfcWDH020BDLnZkISm0STWDOn6YCvR1ZVoHfr6owqGn
	4YzP7jeWZTaZkTZE9rteTRTG/dgt+waHlLBi4qbkSGDNB52x5Obtzj3iUOg5tsstfLXQhZ1e9+w
	RWzLWferSMZdlE2t+TPKDkYWOcQTvNm1CN10jTpHC2ZMGiv4s95TRMttaylL209m3TIZ4oF3pxt
	q6+TNMfz0dtWWq1hiDpG3Wv4nNTn8EiYAnOBTJP9AzrQDEj2TQdHSfroAhTCmZQOq74UfhgUtp8
	sjVT6fQqB3Fq2hmzVrlaGLh/JtCyRUxnoM8c/xZ9u9ncFcHjGzV4NOX7gd82JO8QTApfH6hi5BQ
	jw4edIvk7IrmdhXapPvVTdwRH4p5fhmOBnmNAJ868/eaiQM6chRFDsc8VXTnNURReG/ssIyZTsQ
	WZYcSizEBFJJIixiKOrImJzHYXCN1xJ0zCwv/J0gogRSD7+r5MvVqwi+XuZyM7CyZ8HnlDtXAha
	7qMV0FCbY/WaQw4/j2jCXPiOg75aisi55gFrZttQHx1QL/9kPPJjSGK8lK0R74afdTQ/4S8GGUu
	QdYqWvptmhKK+dOK2WoTmTJOqypxFQv530PYHpIEtWosD8wr5Vp76kp3xBKsjNI0OrnsY0YwdcO
	i5P0xp1NymHckrubeDNXtzaVPdm62+VNr0GHuHZyA5iB4/1ddYM9gcWxIq+SUCjBhSOGD7Hn88g
	dPDnVxi9BdUNHo2fmPocUJJKd9c+/qjQipAozPDqwAsqREoP+5vZNvFRS0Wr1k4Aj18W0gYGsPV
	qJEshqHy1n4OoqvZw==
X-Received: by 2002:a05:600c:4e0c:b0:4bb:875b:f23f with SMTP id 5b1f17b1804b1-4bb88827f0bmr300587085e9.33.1795547200826;
        Tue, 24 Nov 2026 11:06:40 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm455663325e9.5.2026.11.24.11.06.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:06:40 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] bootconfig: Trim unquoted values at end of file
Date: Tue, 24 Nov 2026 20:06:32 +0100
Message-ID: <7379c51c52a9b4221e243638b7c3e2965d6e819b.1795547192.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112401-settling-magenta-7f54@gregkh>
References: <2026112401-settling-magenta-7f54@gregkh>
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

Thanks for the notice. The parser hunk applies to 6.12.y as-is.
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

base-commit: e2e4b92c2b2a3ae78423cb343951cb5d2241b405
-- 
2.53.0

