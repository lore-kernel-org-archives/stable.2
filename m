Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602779;
	b=pT+CBzB0MutSy7tZExrroWYW/8thVoko97iipuVlHFanIZr+NmSSAmxpWRPvu0y7A0mz
	 ta17qcDR3BJNw6aXaFkDS6zQPUrvBhIzGmoqx7IiICNHAPQAQMPmyBbFG7fdegsQBYVSD
	 z9i82KNtP99wTATXGQnElg+sptMcGSJ1Lpsv0LmHH7zMt2uoWr/hOwpKIFgu49xJJouEl
	 xEHCpaAgxdOhs1VgQ1Tow5PAcHmEXOJ6KWOKvWJhMZNrKT/LrMMDcS8uPkIt5WPNNdY/m
	 ym/yOi5tej/j4i5v06rPFUGHKHJS1Dr/ScF5nvjIVc8oK6/9PzonXmvko0zEcv4pN/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MUIWBtu/5wsR7Tq9sCHiPqBvEjwax1AI4efUUkJYq2c=;
	b=5dEVZSzSUYrdq2yQDz+WB0eIa9HMXiaPCHgalOVYLNNSVdldksFLvai3RUtzS5VvNGUa
	 1pPrYj9CTauAuMBeyBT5+VNU386xAMI8oZL8PYqjugG+4zhzx0chIXI29IfDQIDQ1om0j
	 T7PoCKbPU2C8RdSmGVvggX+aVWhnX5U+V8tePx2/kfvmSB6pYI+toZW+3yP0nu6ci5spb
	 QslDIm9Zt1Xho8nv6lg7IPJKHW4BNVRN3U74526OTA0VnYZwSVRcjM3nUyBdJky8NXiSQ
	 UQzpFEhjtgtn3Hg65jhCdbdJRaMITRL102gfG8pW0aNwggc+rxt8UBpa7jMsVKYJmxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VyxKxKlU;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5AA606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C5AA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VyxKxKlU
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso3184292f8f.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795602778; x=1796207578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MUIWBtu/5wsR7Tq9sCHiPqBvEjwax1AI4efUUkJYq2c=;
        b=VyxKxKlULeZaziZxdTIT4aYPAzVu5vKeH7bN2XB7B5finU9YxLOL9EYpVqyT9L1GYp
         hxVmvAOE3iMU9J3o8SgnRczUWxq31Bo0R5+EfNoInSYmh1SpQbCKxNKy70RX3D0UnSaz
         0bUFUNwWKYSGyq8Yrmj2BLGdXDRR0ER/+CF/mh7mG/fN10TLTrDMf4M9LZjd962r6fKu
         UQeaAGIpeBUfbcHeGujscf3NfyI+0uMOJfJzhEgYBTnH8Nx6zIFX/qtSWPIel03nSU4H
         o5eSnx6+5eEc/Qvzcvs4kuDftSplJNPQiKhjBu4FDHEsongsKB3agaH1L/WKniNbKmzH
         3meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602778; x=1796207578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MUIWBtu/5wsR7Tq9sCHiPqBvEjwax1AI4efUUkJYq2c=;
        b=ILUV2lAw+YkOB4GzLFg5FjcweBLMAB5vTJse3mYVJdxB0ucpdSklss5FmtDioyaJ+T
         TP8B2HhzhVVZfp5BjSqhH5Rkyq8MV4M6a6USWRe0IRYPe4HxvvODd0OCChs7kGkLUSrd
         7hun5TDObKZLHYTfSEZRt8SYOq/IBMaIP0kF34FYuzFQxadgTWoWxITNWUmIRPVHGxRK
         LZBSEoT/4fe4Ng58T7WQIry3ubrVgu3FvXOtDJSmhkcLxPWQmqD7rzO2r+ZgxnrxTeGb
         8jeaTNotwNykbCyMMcW+QFzMeJ1v3E3rYPjO6TdbfhcNhafU3gimGsN2Vhu8T8ADvTsb
         7+BQ==
X-Gm-Message-State: APuU4Z8xfrenJKJfTP6WHMvSFZR3ydjGxmFDRHQO+K4WGuYt+PZBnWWX
	B6F75vLU8gRg2ZKx04sIMzkfF9+nWRMTYjnq715OMZCJBb5GPFA8sfByNMKIXg==
X-Gm-Gg: AZFdTZdWJ+q02UIlUFOuTZAy+JFf5C7X+8LS81lyIz+WM+yM+xmzjDsqL/bH1JzA0wR
	VfMZSmgb771SrG2kbRerQ5lEaOenD27tjFJfsg/KlBYKCO11Xeubu2BAl0UJNLXc4bwP/L9cA5E
	S2M/Rh186OQoa49rybxONcQXbqN4qUHGlxHuq36kBkupz8DdL/o7ZYs9eVRg8kesb1dxJPvhfkP
	sAYqshrIUx8tYrjEEmFiVYBYx4qV/+SPV+wLnGKZ+StzcTU6fMmUa+/0/32QyfQ8mhQ973hKvvb
	fFO8yVHwzkjRUNO/W6Au6S6HBKjwn4fPUyGNdcMfbJKuS0DS8y0hgHBDYkrXIvnVZnzpY9OC8T8
	QDesSQ8MsRWhBMiynI/WqS23sAH0ZiNkhscHrqBkkVOjnjtM9/jZWQTPchm0VeB3+ZHWN+y2r4t
	Gxt/fCORZAg+8flZTzubpXWDnPxOFcPlSV5WS/+/0Sq6gDlz91VD1+JoLwBc0f1VEImWhEbLpgg
	94turbv1oPy+dItEamkmaFfVBKNoYhiusgc2XWXi40oU96H5lt9AOzFG2IaN4RLBJ13bIfo3A/f
	hmiYQR8Ju3ePm+i5Ll9fxZ6EqUNzWPM8cgm3qicSwmq/InQKEpv3fM241nAxCdFib1ZDC/UD/pX
	2bccLCk9SBghZxaQPmKHrczsOURmODHiIJ5gJIpDgLUhf5SmW7QkavWDVQTkGP+Cf8c1gM2PAzP
	wfh1aRff3xuBJu8hATvTTxma3PMCzJP73qX2rM99kHKcLw6x6ucMFV1w0CtVxgjwBRQvW1TQ40f
	vTnxcd9vmptpbQ0Ww==
X-Received: by 2002:a5d:5d88:0:b0:4b4:510c:51da with SMTP id ffacd0b85a97d-4b4510c553amr16912452f8f.11.1795602777830;
        Wed, 25 Nov 2026 02:32:57 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab9cf005f2sm27424238f8f.45.2026.11.25.02.32.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:32:57 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] tools/bootconfig: Close only opened braces in compact output
Date: Wed, 25 Nov 2026 11:32:30 +0100
Message-ID: <49bd900ec2bc05f28ea6914bdae9c96dacc06cd8.1795602749.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112513-patronize-spinster-cf95@gregkh>
References: <2026112513-patronize-spinster-cf95@gregkh>
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

commit 26fa92f351d4993428268afebf6c60c987477af5 upstream.

A key may have both a value and subkeys. When it has only one subkey,
xbc_show_compact_tree() can print that subkey using dotted notation
without opening a brace. During backtracking, however, it treats the
value node followed by a subkey as evidence that a brace was opened.

For example, a.b=v, a.b.c=w and a.z=q are printed with the brace for a
closed before z. Reading that output back changes a.z into the root key
z, silently changing the configuration.

Check the key children when deciding whether to close a brace. Skip the
value child, and account for a sole subkey that itself has both a value
and subkeys, since that combination is not compacted. This follows the
conditions used to open braces without keeping a depth-indexed array.
Extend the mixed-value/subkey sample to cover the lost sibling.

The stable test script only checks whether the good samples can
be attached. Add the compact-output comparison for the extended
mixed-value/subkey sample and add its expected output file.

Link: https://lore.kernel.org/all/6ad67e4cda05238cd173c99e820a85de2c13f5fc.1794337724.git.edumucelli@gmail.com/

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Greg,

Thanks for the notice. The formatter hunk applies unchanged to
6.12.y. I added the expected output and a comparison to the stable
test script. The comparison fails before the fix and passes after
it. The full bootconfig suite passes with the backport.

Thanks,
Eduardo

 tools/bootconfig/main.c                       | 29 ++++++++++++++-----
 .../samples/exp-good-mixed-kv1.bconf          |  7 +++++
 tools/bootconfig/samples/good-mixed-kv1.bconf |  5 ++++
 tools/bootconfig/test-bootconfig.sh           |  6 ++++
 4 files changed, 40 insertions(+), 7 deletions(-)
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-kv1.bconf

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 5ccdb9881b..0c73eacd8c 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -38,6 +38,23 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
 	return i;
 }
 
+/* Match the conditions under which the compact formatter opens braces. */
+static bool xbc_node_needs_braces(struct xbc_node *node)
+{
+	struct xbc_node *child = xbc_node_get_child(node);
+
+	if (child && xbc_node_is_value(child))
+		child = xbc_node_get_next(child);
+	if (!child)
+		return false;
+	if (child->next)
+		return true;
+
+	/* A single subkey with both a value and subkeys is not compacted. */
+	child = xbc_node_get_child(child);
+	return child && xbc_node_is_value(child) && child->next;
+}
+
 static void xbc_show_compact_tree(void)
 {
 	struct xbc_node *node, *cnode = NULL, *vnode;
@@ -98,14 +115,12 @@ static void xbc_show_compact_tree(void)
 			node = xbc_node_get_parent(node);
 			if (!node)
 				return;
-			if (!xbc_node_get_child(node)->next)
+			if (!depth || !xbc_node_needs_braces(node))
 				continue;
-			if (depth) {
-				depth--;
-				for (i = 0; i < depth; i++)
-					printf("\t");
-				printf("}\n");
-			}
+			depth--;
+			for (i = 0; i < depth; i++)
+				printf("\t");
+			printf("}\n");
 		}
 		node = xbc_node_get_next(node);
 	}
diff --git a/tools/bootconfig/samples/exp-good-mixed-kv1.bconf b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
new file mode 100644
index 0000000000..0b8b2f59da
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
@@ -0,0 +1,7 @@
+key = "value";
+key.subkey = "another-value";
+a {
+	b = "v";
+	b.c = "w";
+	z = "q";
+}
diff --git a/tools/bootconfig/samples/good-mixed-kv1.bconf b/tools/bootconfig/samples/good-mixed-kv1.bconf
index 1761547dd0..35442ee62b 100644
--- a/tools/bootconfig/samples/good-mixed-kv1.bconf
+++ b/tools/bootconfig/samples/good-mixed-kv1.bconf
@@ -1,3 +1,8 @@
 # value -> subkey pattern
 key = value
 key.subkey = another-value
+
+# A valued parent with one subkey must not close its enclosing brace.
+a.b = v
+a.b.c = w
+a.z = q
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a2c484c243..3fb38b8f31 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -181,6 +181,12 @@ for i in samples/good-* ; do
 done
 
 
+echo "Compact output keeps siblings under their parent"
+xpass $BOOTCONF -a samples/good-mixed-kv1.bconf $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xpass cmp samples/exp-good-mixed-kv1.bconf $OUTFILE
+
+
 echo
 echo "=== Summary ==="
 echo "# of Passed: $(expr $NO - $NG - 1)"

base-commit: e2e4b92c2b2a3ae78423cb343951cb5d2241b405
-- 
2.53.0

