Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602780;
	b=ITCq689DxasmgnuYHVgco2xIh2MgM8TQ1TCXhJ7/3z71FOiMkQCDB8QGM0idOF4MtdVC
	 /JTqmrFqyri81iBw30qkT7YFeWwi6F65tM3ZS3go4N+r9eGJHfuHTnyHVNdGtYEryaGwg
	 7vytXCX2aOHoa3as9lC6vCb79OVWry2aDHSbIVTTXFY35KRmocNt2Frm290oupn+VX8VT
	 Eo/sE3AEjqRFAKxQm8+/CjOXtpkCinyp3OIOOxzCvBZPmtdF5RsXKbpkhA7/yvwkb+tTt
	 JEFCmte4SXOPC57NmUSfMaaFVqRdt9l8tYQsVQtfEW374HYWjbCx930CVOL/JpfEHFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0q2oNb6Pyw1Pmj5XVo3vJviaQP90F2K5cY51QtIA42c=;
	b=XL61JvZCxI+FE2E1f3ngsxHG+3ygy6gzKLm9PqMIzM01Z3+kye8vEapvqzMdVVnl5J+l
	 e8Ch/xbNuARr7a/4LAkXGL2DfAAnC68SND4t7vVuFjXDTWWkb3nbSzPcHXXhumaW2ToE0
	 Mu6mOH73J5T20P7F6gOn1QDPZSnM0F5COFgjhMGVgVHuFZdj9YcZ00pu96p0c0zHSeEIY
	 cqlxtE9QCJXH3bBn1ec49sWTY/0fiAzWjFkuh4A1x+dEo2cO2Lx0QvwnV/wGsXmfQMWET
	 nsP9gyrjeQ3IVzox3qFb/BfP9aGlaAF1tBqXiG6PCSdzXh9GHW+sOqEULO/wc7vUzSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfi4Xq5y;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085A606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F085A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xfi4Xq5y
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so4891631f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795602778; x=1796207578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0q2oNb6Pyw1Pmj5XVo3vJviaQP90F2K5cY51QtIA42c=;
        b=xfi4Xq5yvzSLmOz9vUZA+Fw0LJqszGRiZpHlgo2b2U2xRx46GrCL2g5AFCaJFObhGM
         bCQ5meXda1NMJ1KW1H6EeqZh/7GAjsX2HjO/r3/Ll+6GGgluxKQhIiRD2M77IFOAwfLk
         LFQQeiDnlYOxVNliVi6ySKajFUJrHWCGML+6YmZWyZyqQKw4LrnCKIIINkWb+lNDO1av
         2GnNl1BBax/WajzJHsS8VXSJtwE58WodLXsqpb6t9thavIoXTaOIs8y7Ae2rATBB9P9z
         j6yeR1580V1nYRhxzucVbl5HA26DSnVt9BlON0cKOp79MxHSySg8xb7ekT6NcuLUzjyX
         Pabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602778; x=1796207578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0q2oNb6Pyw1Pmj5XVo3vJviaQP90F2K5cY51QtIA42c=;
        b=ydDDIlDaJ0h/ov1s6WPYVU8KxH/ev2ZKHxKZmjhGzVO5R/qReUSq9ybL/Qc/HXeCBP
         Qb757ADgMHgYYep1kbDPy5qD4mWpyTGVnUXFa2K10252u1ieuxhKV8m30N0PCsPP9p6A
         nCTVwGG6V9sAxNPFirbqar++WJBv6s04WpP4ZDVJP59yzuzAzMS8Whw2BiiiJ4fhSgkB
         b0Cw6hr7ZfxmFzgbgwdmux8nMs7pEDHXKdRGcXKdwQ5vw/wr7iTQikKin9fWuVoLYJaV
         iw75qVJ1DXh7jVh9279Y+XnNP8i8DsBYDW39w5XcbmWmA2FI4e8Fyl5kUlEofVnojGW8
         p/cA==
X-Gm-Message-State: APuU4Z/MdycDY/xRsbsN8q9NCfARtTNyQgvLIcHuL9Iibly9lr3rxAbK
	kzmKSNf21EWs716lgCtrLjNnZuzYdbAplPbtd3NAJsdcSG4UyELw8lAKYW1Jow==
X-Gm-Gg: AZFdTZfaCylrat1y+EGDvhzVusURM3+eCZQmubl+7kox2e3DzFTxuYaKHsihYxmlknv
	Mupir2UmgrPol3NLjKikKgiGySTfUHhO90ia9rtW8ymqCmlk7CmEsjnMmGJvyVz1aHcGB05DEcy
	9xCGx9l5aYE+fwU8uFeiSf2v50OhRRlPqZkyE68RZHFucIXZ8oxx06W/HXeclJ8bScw1bJikrIJ
	Q9mqfQ6aAH3uoLhCEvQaFc6E9KjWtp4j7q7cipO2X1LSu/BLfd1R2AMD6BXF/huYomuQ+snao9q
	nOkKkXm0kzZhlHS4HDDoqMxoaEwPPUa/HmM47ycn4V8uDrvf0p+a5uR7Z532/mN17MRh4PoQQqk
	yCc4Fs54Ht1YdmpUHrwfx1dpulN9JoFu7vTtCSIVTaBrTy+Jws/Z1UmbOjRnaH83sncB5SRmOVm
	DIZJfB+S7uZaA0Hb2ZOT1PcV0k75OlkIMvtDg382t/Jf3qWsdL/1kOYR5Um+OaozobCYfUD7/35
	9OK4/1K5/1onY6EFsNQSfuu7DxxPXf8wT/UbELdwK7jD1pulcmo+r6PhH17CJi2oP8XuUJQtlEw
	jMaEBdZe1R2yiasYhEpkq9jksNVIAEKW3QFL1ck63iIjkMr/6N2E3jRsqcqvQz1mmvoUa999Py9
	zyKa+aAgUav4XezWXDcpiUBzV4uKWmxt1IZEL2yDUktmgFiy094KT9T/FiRvK5lGkod3bGKZN9h
	zZaglz4VHA72xKeZlZtdyIvoNoDom3lTk6eMQe3cMn/RCKRjYhUpHA/WVdJChJM6JbrCpVn/p9j
	HrL0UaIR+7/e+lUGA==
X-Received: by 2002:a5d:5c05:0:b0:4b7:6ea2:472d with SMTP id ffacd0b85a97d-4b76ea247b3mr9157079f8f.7.1795602778348;
        Wed, 25 Nov 2026 02:32:58 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab9cf005f2sm27424238f8f.45.2026.11.25.02.32.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:32:58 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] tools/bootconfig: Close only opened braces in compact output
Date: Wed, 25 Nov 2026 11:32:31 +0100
Message-ID: <b892a7a4c2c9307c98015e6f9f74270b7bc88337.1795602751.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112514-brewing-massager-d7b9@gregkh>
References: <2026112514-brewing-massager-d7b9@gregkh>
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
6.6.y. I added the expected output and a comparison to the stable
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

base-commit: e2bb30811e063ce0db964484357973b855b06572
-- 
2.53.0

