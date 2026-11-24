Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534969;
	b=ZV260bH9cYPkJ7x/3WZp/kByFEwtWgeYzr46O/M5sG2/07wj4qGKMGgTxtv2mPWIh48s
	 O3UJXrR4hZSJzLK34p2dINVeRx4JFR8RLwbcXBSAMNugKd44NbVHsyB8cdbQmPAa90tPm
	 LdfLZ/fxbvSU7wBxd3w4JXHV/dgbu8b71prK4FIcm58ZdxNWpigLjA74ZSLTWsDIn3RGC
	 4SpyY5TDrIPRxdkxIQCn8lUXJXqK6v2UJ63Ge83jrY3vXVFEqjgGOgsFSSlKk4prQzij0
	 AeSNnKPqOMxEoHMTnctyfqkLTv2HmiIuSsafyaosQlpSMqnE5POH2Bsqdo0XHsQHpIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534969;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YoQo8x8RM9Zoa++3He8lkWo7hpo+FLZqzKP49nl3NG0=;
	b=bU94S6gGSiiEP5Souu8ezZWwn11eIUz92c74l5b6be/a/R/yB1WsWIJzs9GjRFZGTVuo
	 s+5JN69Z9N5OA7cwIOol4jBdmawGGUhMBdiOJ5dBzYCB0D1rBYBcLPTpOqY6+D3KpLdK6
	 Z08GK9CpUaG2ED8O9RRrHVsNR/7rNrkgMarSud8W4QHD2ACIyH38z50ypJ5GOP+2XoQVg
	 ZCSmeoGyhDX06W5m4p6Y/Y53NTY7KCrbJQdhfrXj8c8eRaMaT2v0Pw6AjUUTk0HDjZASx
	 B3KdmvvN3e5Nr+qCQrUpyL0BhgI6z76nvXlfo4xNUn9f5fJaJ+d22IYCKRMVsGo0anw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WOv1geDm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA2606A334
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=WOv1geDm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734881F000E0;
	Tue, 24 Nov 2026 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534969;
	bh=YoQo8x8RM9Zoa++3He8lkWo7hpo+FLZqzKP49nl3NG0=;
	h=Subject:To:Cc:From:Date;
	b=WOv1geDmD7Rf9RpofnR1xUVuKgxEDt1Er8jzPd67vjbU5AvZcBHqzDGyF7dzyO3Qt
	 Dw+3+6Z8gq0pEksGH+mHw0R3PnZ3S/ULdGIriwlvH9NuvcFq71xG+s/56iget7iGDK
	 /ejbKuMmUdfp5bdbOCqP4D0thKuMsnFLB1iMd4QQ=
Subject: FAILED: patch "[PATCH] bootconfig: Trim unquoted values at end of file" failed to apply to 6.18-stable tree
To: edumucelli@gmail.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:43:00 +0100
Message-ID: <2026112400-underage-preheated-44a9@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 381b391bfaa3f10d52da4740529804b0b6b8160d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112400-underage-preheated-44a9@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

