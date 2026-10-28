Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166163;
	b=YezjlJ1PDaShQTsT6oGfb2EaM74pROuuFWdlw/YCYlwim58IW8g/uK4nTOOXss8j2bdc
	 k1r2F1r0KNGKrpHiZD2chJ0JyOYKrlJI4Ww74+Tm0d/Eu5m8QPuJ2UiR4in6kTdWoO0yr
	 9ktwNXyXJf29trLGSkxIj+NM7/vg+uEBKCo3r1WzOS565sHGFazDRAlE5EdNOGEO3IICd
	 VgfI14RaKxKjm/ZWr9Y9gAaRSUKyhojFyy9HInwGr6SrtBMAMaWeFp2r++1aedg8ZxoXj
	 5HKxq40FiD/BRhwk2hQ2CXIZ9a+a0inpegiio++1Mv2Yve3H0g23WH+SuIUicuScNhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166163;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xFl0go1Rt/XZg/UL3vYvI0sBGlrUpRft942jlbk9A7M=;
	b=lvPg8WRaThHgH3GQUJSqkAeYsznb9uxET5EEHv3/oLzHHZIGJkkRP8SmeusNxlkhVHY3
	 02bKF6zg2wAUhdfe7RPE8c6PAwTFSD8dioIfkGIvBd8p1s3sR2lrGO86L97/AVUrtS1J8
	 ft//ZsKCBvGotMnQU8+zJM38LS4HEBFkz1oSL0JWt5k8CjmlmbdZKUZdWIGEwvoC1rJM0
	 fKZEwCzunfr4KNqs6huIBqCr96v6KxH08r3wnbzK/x8v594ix6aD/zd7BYacC0EQABhVc
	 S5jw0AWTXzuayE+aB0FKxo9XRbvBjCNroixCDcv39AsgQRoJGsYBYD+d8Hep1QiRBUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u+7QSPbJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94061606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u+7QSPbJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F5A1F01828;
	Wed, 28 Oct 2026 05:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793166163;
	bh=xFl0go1Rt/XZg/UL3vYvI0sBGlrUpRft942jlbk9A7M=;
	h=Subject:To:Cc:From:Date;
	b=u+7QSPbJH2+dmmdv2GkrDDwo8xEbWdg09ex3WfzgW2MUkzyzE3V2QxjCQiEE7BkGD
	 ghajrEdj2qv6lwhuOxy2nQLB9cYyeHLBQ5cEKtOIIKqjKAlrhsQ+2rms97jBDC4puD
	 EZXID0cSmth63nIyVGNYAuXM+1iwrK0zWYZZS+Ik=
Subject: FAILED: patch "[PATCH] tracing: Add the bucket size to expr_field_str()" failed to apply to 6.18-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 06:42:33 +0100
Message-ID: <2026102833-repeated-divinely-f6fc@gregkh>
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
git cherry-pick -x c027ed03bc03a0e82fc368eaad657584a4480c7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102833-repeated-divinely-f6fc@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

