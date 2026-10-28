Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166166;
	b=rCRCjjCA+F9P3kzj6Xl2nj2nOvbUCXLSKxkDt1mknH+CrDL+opzV2rpgCN5Uq4a/Coqu
	 +PQZjec3OsZZOLoJ/YTmXmVfoA+g8pUYz9vNX686t5GLzUYBnHByjN5TnPVWlogyf0PNI
	 0KeygUVzAgHm76pxqeMNspB3xUBl5TTp9905/LyboqylKAV0sgrQ3ZpfIQNHOVyLHxnRJ
	 P9f7TBtah5xR/DNoBhmy+0YOCcBNOf8JQRn85l0ZvK/QvGBwiO5SfV7g8MQ3eLIZe7cqg
	 nYYCcNXSHt5F/2hKIQNd3GezwzTQKzqvB9L1MvAN/RCnHgnGARPT9qgSHj9iYjl2frg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166166;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mWxv+AM5u93WA62jFENB3xHKk4tt6GmJ8nyFXf9SFto=;
	b=BeTIFW2ZOcxOl5n0/IPmg4y2QoA05TRoYme/1rnLti5Mbz6NSfPmHL4DA2xjemIUO6wT
	 kxMRgiZ1hotZikiW4D863yA9YRcyWqn0DMR3PXR/PUWSDtZApdXzDQZr4K24lTfl/7hOZ
	 yOz0iljU+40bkbHmBJ3FGnMZ3DRVlhqKFuPl/+uAzUcpLy8Vu9CuMLYy23t9NVi5PvITQ
	 ZQhLBD87Dabo/fVcvvqCGVgwwlEnUrD5WVpmXS+HJ3qCpd0vSzo2g2p57rtAy4s0mQ6G0
	 Oc+dibmETBMFW9f5hjOgjbw3JYhvugeLg51xWlan1b2HOmEFspsCLsTfl5ExPNxHb0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GXpelgGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B5606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=GXpelgGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA931F01828;
	Wed, 28 Oct 2026 05:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793166166;
	bh=mWxv+AM5u93WA62jFENB3xHKk4tt6GmJ8nyFXf9SFto=;
	h=Subject:To:Cc:From:Date;
	b=GXpelgGAkb/tErjcbiG3logI32tc8l7jNSqy0gD8bswe6g/vJ14QEc8H63R24oEfG
	 DXIas7M67YMJi1/U1ajUIH7l7P6A73lwHVBO/jryH8oZ0uXK/JgcXYsehSNSySOK2p
	 rDAtXk3edRWinirEVt1D91e1i98ixEl1uC6gUgJw=
Subject: FAILED: patch "[PATCH] tracing: Add the bucket size to expr_field_str()" failed to apply to 6.6-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 06:42:34 +0100
Message-ID: <2026102834-proximity-conjoined-4fdf@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c027ed03bc03a0e82fc368eaad657584a4480c7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102834-proximity-conjoined-4fdf@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c027ed03bc03a0e82fc368eaad657584a4480c7a Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Mon, 14 Sep 2026 14:34:41 +0900
Subject: [PATCH] tracing: Add the bucket size to expr_field_str()

expr_field_str() renders a HIST_FIELD_FL_BUCKET field as "pid.buckets",
dropping the count, and parse_field() rejects that spelling.

get_hist_field_flags() returns the bare string "buckets" and keeps the
count in hist_field->buckets. hist_field_print() appends it,
expr_field_str() never did. Nothing reaches it today, since .buckets is
refused on a value and no expression can carry one, but the next patch
renders histogram keys with expr_field_str(), where a .buckets key is
legal.

Append the count, as hist_field_print() does.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914053443.981201-3-donggeunyoo.kernel@gmail.com
Fixes: de9a48a360b7 ("tracing: Add linear buckets to histogram logic")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a3eae5c1344a..91a550411e8a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1754,6 +1754,9 @@ static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
 			seq_buf_printf(s, ".%s", flags_str);
 	}
 
+	if (field->buckets)
+		seq_buf_printf(s, "=%lu", field->buckets);
+
 	return !seq_buf_has_overflowed(s);
 }
 

