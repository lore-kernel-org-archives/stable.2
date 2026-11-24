Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534975;
	b=X3HMtzA9UojYvdpV9gJONGzRQW6jeMrntDB0DbH6HiQj9h1H8rQpoYeNsS/lULwKX8gR
	 MpvXIL2K3p8rPgGLJ5Itb0V17swVIcXzHRzaUyFGiqg7UJ8+o6AjFi8sm+lhe2SxICJTr
	 LO7MgBBz7NZTg8w3bAEF8Zep4LevmcUnlgY+1tFIucr5x2Oa0D70Qx07K/j5JREEx9FD0
	 m6JYJebt3oGB7RFwrkJoYIBK6EH+EPdKXTGqOmDL59ntqg5otII1wvn2I0u8ji0Clgfyg
	 UA72fYiJ/vYHe8LYKONZDKsaQfIJpizXDPBcmiQRpKEuDmios0MVGX6c9AxrXIgdQfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534975;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FvPZk1p5ZDYXLPdYElmcKDnv/cDSI+ad6xZA2wiNjSY=;
	b=Uw1zQwk4/jsjzn02pWONDEm80aINNnC/nAO1OcwhyxJeCylc6SyZe6MVyoIJ8Z1waTiQ
	 I2xppi7feb8mhd9saIZaCFE3ZPXYbe2tOfbKX7Swolnqw0XLeOsl/Hqi6nmlLZEMKlrys
	 Kz9dcXNnwto1t3MiyVk9XvrnCi9AGGZrRoL4HSnO2hNI4UO8yzQ9vFwb9kXJtoZ5s39JK
	 vkYpztzNreZklESCa41GhTzfZVsSUjkuBmWLqlqVIiw4O5UY935wdCFv5XbXSledW4UzM
	 07DeEpznvH8vAbtxNxlzkrimoQZuMwYKGnFi2g3isWvkT1DGsMdJmWrgmmL4EaHuOZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=syKdxrY0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985D606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=syKdxrY0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207801F000C4;
	Tue, 24 Nov 2026 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534975;
	bh=FvPZk1p5ZDYXLPdYElmcKDnv/cDSI+ad6xZA2wiNjSY=;
	h=Subject:To:Cc:From:Date;
	b=syKdxrY0v/+uLsiqX8BwtCvTRCC7yhlpB9MZYGPUGTfNqcd/WUsDylIEM3aCOTJeJ
	 UIxVSj9GL1zSUNgstqkwLLV6VfsiLa8oPTpoq9FpGkYcggO/MAaOOFverWhLlKqDvs
	 /hNxLZ27o3C/t94F4Q7DLyzlV6EBGNEtoNM8GOiE=
Subject: FAILED: patch "[PATCH] bootconfig: Trim unquoted values at end of file" failed to apply to 6.1-stable tree
To: edumucelli@gmail.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:43:01 +0100
Message-ID: <2026112401-next-exponent-636e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 381b391bfaa3f10d52da4740529804b0b6b8160d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112401-next-exponent-636e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 381b391bfaa3f10d52da4740529804b0b6b8160d Mon Sep 17 00:00:00 2001
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Date: Tue, 10 Nov 2026 20:08:46 +0100
Subject: [PATCH] bootconfig: Trim unquoted values at end of file

__xbc_parse_value() trims an unquoted value when it encounters a
delimiter, but leaves trailing whitespace intact when it reaches the end
of the input. Thus "key = value   " has a different value depending on
whether the file ends with a newline. The extra whitespace also reaches
the rendered kernel command line.

Trim unquoted values after the scan finishes, including at end of input.
Skip trimming after a closing quote so intentional whitespace in quoted
values remains unchanged. Add checks for scalars, arrays and quoted
values without a final newline.

Link: https://lore.kernel.org/all/31f248f330e716b925add3a0ba76f62826527312.1794337724.git.edumucelli@gmail.com/

Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
Cc: stable@vger.kernel.org
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a4aae9a9abca..948c8c10e4b9 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -793,16 +793,17 @@ static int __init __xbc_parse_value(char **__v, char **__n)
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
index d19747e47890..f584f7637e12 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -181,6 +181,24 @@ $BOOTCONF $INITRD > $OUTFILE
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
 echo "Showing correct line:column of no closing brace"
 cat > $TEMPCONF << EOF
 foo {

