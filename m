Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602779;
	b=nq0Jb2zhqb2YnfGaE+lSOfzxpYTgkJ0TndmPZPLX/KCEup3wSEKHzvIWksvvPEqwev/N
	 q05pLt+6Sdq5JslB27T2J/k8u9vl4yw5NgRX4tIH3LKDZhWk2BjVf/uKyH2XB0ExZJNRM
	 ATm6mrnmx+YGTl1N3TyodRIuIQbcZiVP/HIxY7fao3cpMR1uRNyaWkuJ+LNvl4Wax+p58
	 rLb7uOvBDM4YVxfNLpNogqQyWhfRvCYjudANihGpIS4M/yZk/wKkHNkZHo8KDNB0jTDNN
	 Ons7skVDd1SalVRAIxkfat5cXpBdyrSjcTTdL7GmUUqwmkzFWrFf5NFb613JbOl5+1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v9g3Spbz9SEtCo7yUgTL6YRQAf/hoxvLHrjUObnvhas=;
	b=UuZgyJZdpSrFQ7pFd2AZhaEZ8gNalglGi9dqmS24Aog+Tcow6ZpYulGPT6mMs68I6i5I
	 fnqxwGJtIuA30PbtSZjKqXuCcVdX7dwmytBuo5EFT5nB9kNVwL19zRav4vFNJUS2VTuaj
	 p2JlSE0/txdLKmcJVqASujK1xtPeKw22ReThjSKKOh2XCIUe3L4tt8EKPPWB/6Lq+W7dU
	 p587eFjmdYXXvI6lYUH+2aCKFeJKFdekUJTm0EWML1AL0Cdn4D62kyUEwxQcEsC2CNSU0
	 2KJoClrAiBs+CjQ5hT8NH58vpaU7e9WMVB6DJVxx0IdTDAWCE+uQM0dmPv9M/+2EU6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sAQ5W7A6;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBB606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0DBB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sAQ5W7A6
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a357b1c649so3231534f8f.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795602777; x=1796207577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v9g3Spbz9SEtCo7yUgTL6YRQAf/hoxvLHrjUObnvhas=;
        b=sAQ5W7A6TR3G1yVOG+eIXQXJoQh4uwISIH18TPln9VcIT2N178QAk+zIXv7hgWvjSi
         kbTMbL+a89cWFnYEvS4wyTPaGBVIu8Tp6KqzhgurywDFZo2jbG/oZuXSRzlfswNXHAKO
         fExr/qu7gfNwFCVpSjmU82w/dW1rP1qLTt8LDBgxNiPfMFlfAy9491/Bwu+XiCLUm8Hp
         83p2edIKT9kLmR86z0gym61gXnIdqVESHeeiHO5it9/+vl+3vpRdBTNX4Kl1btm1tqU2
         iv2yU+PNr5CvTjfVenuRG8heH0vPDLF/+a/XM1Jb2WLDXPDKbFn5MejPhnccrdwV9ZJS
         X4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602777; x=1796207577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v9g3Spbz9SEtCo7yUgTL6YRQAf/hoxvLHrjUObnvhas=;
        b=1/u5BjkRsZnH/qA33fzHziT7+N7++IhhR0o95lS/twfmiZbDIXfZj1kCgy7A21zm5B
         k0g+LlzP/BhkbVbcXnakBI/2s2pPgGbSSGxK8R0pq8lOMN2flUvb2aq0W1AlvcSeDtG0
         MESShi3k1jsopsFp/aF0o4upkPLGsn2CWwcNHIRch/yO45rud7H/nfcAWTdYEXNS87g4
         j3MNuIKzEYXcmybFMU+kS/BUqJg2nH70SV49qh8cuFDuWz0+vj8aNBz5V6ZfAoaxtgMS
         P0s0x1ed68LvL2lTwKz6tGkNao+Rhao/7WeUSVSA5biCCzNDmZkdX5TWo3arzlE6WF0e
         7uBQ==
X-Gm-Message-State: APuU4Z9tAU53CjMjnMwV+nUamZlGe5bX9AkF5vIukJ5No45Jwx1WteQD
	Ie57dTqpgBjxC7TZM8O5u+aLmbCWQ44eudmMLd0pwH008TtFh2kPZ5JPzVFmMg==
X-Gm-Gg: AZFdTZdJLiZekJ4/00LMrqzgWg6NGdCQRw6xZ2pFEvfHPkQWOwDpMXXrAc/inzXHBDK
	B8Jhk/VCBtavWCGqOGSZu+IALCgi7sZxEN2NTad662/PZsLMYEVK8bmid0gSy9pK0IiLbqnH/FW
	60h1x1wytp5mPjfZvLvTFtfE8TpKNOTwOEOnwES2qmAF21BJ2gVIZqA83q202rAjRlXzEoC/j41
	SU8vxH0kNW3ShyH7KTpeus6gJdzLVd0jH1Zp+E8o89vKWySGwc91uFqj4OnH0V5DVuvTtyV7mqm
	dOkBVlH3lA5rnuP+W6H8MlxwQMK0K9b3/uQfWMZpTm8wxaDHRvYY0W49LpdEPbSWJ8HC79AHRQ6
	hWcs9P3QWcyMAU2NSYM6nszk1xzyDk0wUACi7wR6tS8/0grroCyYjyl7DA+zvvaTYcJDJ+Y0Kz+
	Zz4Kv3MsBSb9kSvuyB7Kk1Uhoxrq8spA9ierHoPffjE+XVyYVwjp2jT6OXyNjz+UAUGTALVn1/Z
	mGIxJqw+oL7Jv37fZMbyvWEb9c0CzAj+8pzWvlYLBcGE8lBRKs/gdGKB2BSARZo/E9S2Ke7Ah8W
	djpWLRGvQmvAsD+uXft9Fi497DaWh02KiBk1DJ3IARipIkPKj7dHGrFi9OeiEVW8WaA6T2NEe3C
	/BC+pCoQia5gs6jj3pkS2i5E7+AwDQgevDphypg33dkkQN2ANHc5bhYmFBj7+17bSrf2xYMrflY
	eXo67cgEOS1l1cj0M2Q2MpJ8mOzpNDKzTa/Jm38QzsssROu9CD0Q0l1JAgBXTessrVbvsc630ku
	qbve9gp488rBGiCSw==
X-Received: by 2002:a05:6000:2512:b0:4b7:75cf:37fc with SMTP id ffacd0b85a97d-4b775cf386amr8119712f8f.52.1795602776688;
        Wed, 25 Nov 2026 02:32:56 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab9cf005f2sm27424238f8f.45.2026.11.25.02.32.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:32:56 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] tools/bootconfig: Close only opened braces in compact output
Date: Wed, 25 Nov 2026 11:32:29 +0100
Message-ID: <89e26475cf9f34274a05eb3d79b91efdaf088b83.1795602749.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112513-impure-slighted-13c6@gregkh>
References: <2026112513-impure-slighted-13c6@gregkh>
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
6.18.y. I added the expected output and a comparison to the stable
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
index 6f5d60045f..43f0a7fa87 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -39,6 +39,23 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
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
@@ -99,14 +116,12 @@ static void xbc_show_compact_tree(void)
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
index 7594659af1..9e308129a7 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -182,6 +182,12 @@ for i in samples/good-* ; do
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

base-commit: 4700e3adf3b24b39dd4929e9c6d62811ba3ccea8
-- 
2.53.0

