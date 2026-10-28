Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166156;
	b=P13F6TbAtwAL+h7PfdN99E0ZInghWBiFxg0PJfDFM+uuCKnBis2CIhyT/c7DGQMoeUoh
	 FleYPWSRly/CNGPQ7Eitwdwe+XKjQ8EkS5QBiqQSeSEqyn1jWXAuxB7/WpZSO9OVerp9U
	 HvKpsjTYGLif2RK5D9mRZU/LNurpcC1TbN9zaLGm5uGhpPSdsQlydmRUKcnd8EtUFUvJY
	 nrWee0GOcl+sX85JsA7+8CqE5SxEMLLUa8tD7y8lzmQCN8iroTWXt48tgNbzS4b3jo7mE
	 PehTa5/XCXGziuw/lumcOw5UfreMGp/EBso+BdqkYRZzUs5X6jn1z8WXGT1Jn1K/Qmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166156;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WU795Ip6yXYIqHZIpoF505o1m0MQqFzjjAKbrjns9ck=;
	b=cEoo2sM0EfmkV5wMW1D8Qi7mF4g1l+n9zkP/BbvdM0OAJHs7BW0BjNC87RSkNAWFBu8R
	 9DnAYjBmXkuD+r/M+9G6DhtOc1OiTrG229EICbJOWO7DxWU4nj4FaX1mhedCAzyN0VGTF
	 5P7Ql0k6OE+ytiVnzu2/LIf7+P2bNiehkt84GEPs3LlbNHLRzan3l+3ZSturGR2RMgjjj
	 rG9wUyseuueIz1uq6EkgiJzmD7K55ewZxn0SR8QmJOvx9oSy8Aemb3lKx0hc+e9+veNLQ
	 mPBoSsttru8noAbMPwcW3gJ6p64e+73hTuxh4Q6jVwKFZWN8cSLLK5WJA9VlJAwV2Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MviaE+6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C1606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=MviaE+6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3781F01825;
	Wed, 28 Oct 2026 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793166155;
	bh=WU795Ip6yXYIqHZIpoF505o1m0MQqFzjjAKbrjns9ck=;
	h=Subject:To:Cc:From:Date;
	b=MviaE+6aPBRvU6AGQH+XeL2jJ+WWc8ja/Gw/Ap1Qi0tBMRHpZABoZBqqJ9T3p+yaC
	 U1JikhU0PwABuWN5wdrp2H10MZnH818vL3MMEY84dbllX1vFUOtFKsH2/435TMZHVz
	 CJ6dh0pDbFp8dhK4vY7bvwMk6qZHHXYY23YiXjvw=
Subject: FAILED: patch "[PATCH] tracing: Add the bucket size to expr_field_str()" failed to apply to 7.2-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 06:42:33 +0100
Message-ID: <2026102833-sniff-unspoiled-cf9e@gregkh>
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


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x c027ed03bc03a0e82fc368eaad657584a4480c7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102833-sniff-unspoiled-cf9e@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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
 

