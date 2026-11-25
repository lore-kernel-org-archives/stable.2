Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602781;
	b=dUNE+e8oLsajfxnn6/irItPvamTGp78vKemLV1t5Fbfe82tIL6GjbRVWqnmESPylYLWk
	 5P6gNKwAt2e/+oYoqrmcOMK6IkIwM5j/7ioPR8LORgGF7LSVlvdfxhz5ojcIyAKojIMIM
	 c436t7GWVzScDrdjFodZn/CwXPkmJCLfEcEm14X0V2/8g/x1MZAUIFpmNkVgdXnkqwGB3
	 A/IMg/Ru0nG/U7ECW2jENNQw0hhdEPhXevoCsb6H1IPiLStkDLrZJ1ULxdl16276ewNMx
	 WKWmf3yc+wQKw+pkMgRC6VVrn6gMwa2HHmBmOCIa08JW2EEcuQHgzOF8Pki+I2JI0HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7xV916A+35SXl48r5rUtwZKMhyqpqrYz+QTIMIESbq8=;
	b=plOy/xcFwdmLjnru6IK5RDE+ogoDNBMR+skcWvnBpsUDH6uCXH+qTIQdTULU1D29A3WN
	 dgD0ZuwY8lNekbDLN3odEH+Q5BItA06DYE5XnKwcPbfl1YkFf0XnVU9CbifhE5/79Dc2Z
	 T1WXdvxuVfK7gK8hwhAxpkA+VSLCeGL+eju5Chr5IdOX/bpAIAHB2E6dDY8hmg689ybC/
	 5Bj3UOxpNuoBsduDBCCZgpGY4yXizwyT6vzgeX80JmJvYWio49IEwuBoRBKPniifwdg8/
	 k48Qcb/kQDbFiNwhwfD+wlEiUKMda93pYJJ+mGafu2cl1wZrwp1sYTFEmmsRsbi9aww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ivGrpQN1;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4D606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A4D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ivGrpQN1
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so4296859f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795602779; x=1796207579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7xV916A+35SXl48r5rUtwZKMhyqpqrYz+QTIMIESbq8=;
        b=ivGrpQN1F9+Ei+uXeqi7ohc0WOmj7bUvp42bZvx1cSe/v5ndwbJw2OsIzUM4WWvr/g
         ELyn//oU8a6kVxl1HfUTD/hjrVJgrj5ZRt3WnaNQMg0FtC6vUnVC+uEG+/VRxwTqps1m
         n3ndmvflYyLA+beo2vy9wOrlbzySM5hinBD9KOYD6rX0fC4NEadsg5DkIjrbeSr/4dzO
         dkOmbl9SQDvfSKRLzHkFe0wCpZU+wG8EQnojsXhf43qBIcm919d1MG2uFh4uCzGatscR
         HlJ7xZtAFc/pXTGbBbsxc3aQUpqY3WrqV5u9JezD+VWYTI2x8yDoGrsAy6r/E+snsava
         thmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602779; x=1796207579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7xV916A+35SXl48r5rUtwZKMhyqpqrYz+QTIMIESbq8=;
        b=kAPWmQoG+nPYSoME74NJrTWIlXhUdlOXX/frIevN/9Ce69Y39aH+WRFFk4pxL+sveK
         iufrJVtrSVCANiOTPJ/OiYYkWYMtbteRmV1SxF7+bhTE0U73o8B9DOBZV4/nAjjWUqDP
         swPB5slbBKSIWnJEAOQpK5yjcpGCeUSxqxeJfcH4tWWl6I3MKtesz4bq/8bLlcUmY8kK
         15+B91ivpUD9ZoL+8FAtgx9US2pKURaV7wGMvQRYrOM6CNDZTDszOsv8ktfZnjOhhtgJ
         WZP7zH8pyP6nR0+ahEevPOM5E0L2I20DsW9d2myeA69pArc4QLagJOQ4wpN8m39OyWuQ
         C2Zw==
X-Gm-Message-State: APuU4Z9R+4eJ36esSrN5eJrruaCi0mKYr/cGePsK/tU/GHqFJHx1gWJi
	8Zcy0xMisbznuv/Qc2TeJKEHeBTPi3Lee6Glh2h2fjxxk50iYEa04v3Inkaf0A==
X-Gm-Gg: AZFdTZcoiXX5mXGwgUqzvvftD0Kveg5ifszNC2OQ/uGotWudDJ2eseG9yd20Kj9D3Tc
	1DukSuHzE4ZjTpQu7/NHDL8DwgfHx+iJoln8FkA7FEv4x+X4Hoit4dBxYP/R3oWcpKhu84U7G84
	HJU9I398WKjkOU2tSSlQ1j8HsrV3pTaLndXSNFxFhggzPrqHh+IjLUnWMiMpc/hGIkgAcUG1g//
	64Amft4ZTcSzZyl1wtN+6yuasejpKQA82iwoy9vNBf6NmkpVipf81s66Rr8HFbtt6c/GNwoMYbz
	BnRU50IMbvYP1HG/o+LHLxq6/Zz8OUIhS0StorQmOFMf4+x2VEzq8pM98mjrrALgSB23ziv4hj3
	P9lGcFKUA5F7Xxl80t4IR+5awhgXh01TuFkCcu4iflCgKeoSr8tVrmkvfu+mggOf4fVU/T2eEwk
	ifmoV894kbNLzWK8qTWYVz9ytjfYqxS3wijsKi1+UJIMf4r34QlLUpwVU7dwLFBbLiE/chyfqfS
	nPaGGqkMjZW7F48YtHZ535fUWNEExAQ5vTLsM1BNJrHKV3elVMQMnmtRUwYUMcNGiXH06GT424W
	8cGI7CgftEh3tmydFOikm6om7m2jDujhunndWp8Al9zPyg4hBoQVzmk9GslHEIIJougz7ww5Ier
	hriHOwtatMvveB3//YUFKYf3d/zxs9GCmT85v3jhiJmcERGTrgiNWBkasUBE81NOfIhdE2UtVN5
	BdlXWFtLFKQBRIjZHhhg+UczSyW6YAokhbVvA7cKpK+QJuFLmkPsrTX4rd+2FhDKl9u3zv83aay
	5TNIUzfpMR8pmuTxX3nJpWdStIEosDU4x6NPhg=
X-Received: by 2002:a05:6000:2b92:b0:4a9:cbb5:803f with SMTP id ffacd0b85a97d-4abb400a6c6mr22607073f8f.37.1795602778879;
        Wed, 25 Nov 2026 02:32:58 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab9cf005f2sm27424238f8f.45.2026.11.25.02.32.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:32:58 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] tools/bootconfig: Close only opened braces in compact output
Date: Wed, 25 Nov 2026 11:32:32 +0100
Message-ID: <9ae7974f3fe787daa9758ac07b37e2150ae546f0.1795602751.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112514-demystify-mayday-8d49@gregkh>
References: <2026112514-demystify-mayday-8d49@gregkh>
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
6.1.y. I added the expected output and a comparison to the stable
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
index 5429a7674b..c464ee6ed3 100644
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

base-commit: 1ca1436ccc68275d0b43b6a730b3940fcc46b7c2
-- 
2.53.0

