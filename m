Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166175;
	b=2r9w15EpO8jBoEkQrnd5noz5hOG69u/Br9bEEa+zrMwh7MQ38zQdTotUKiW2Yj0BbhIy
	 hnEEo0Lz7VqwnZguvR25GTrOsfiyTC40Wahg0ulPN8BZEsSAXCoH1jxifkENVVPvq0Un4
	 d9KjbTi6Ja203bMrsap5ejVSIDMiZnfyaLA6z/ilSnmRLLM1RVkygaNJ6oXOoqMApvqlY
	 B6WAgZJjnQG9E2tmVRaVGUk0I2oeXWBkngt019f9eRYlV9wZykSulV/tMAMYzG0c517fK
	 6XYsjtJgsOAxIioYfT2h5SdgLbZHdCrSALnm59ZFMooQXNXcFD6zcAOEXeXGePGXHJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166175;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lmr5/G2WiVR/lcWtJS/UhAiZPU3IE83O7fxfui1NwEA=;
	b=J2C9di3fGv+bkmFBoYfMuFdPBg1IE3xYP4oUofL8wjMAOAEUfcjd1v9OV9Ceq1e4M9uS
	 7X72pcQm5TyRn2QcWOhAf+RwZgjUvIIyPhivMJmEhIBYkeKooaIhhZXcbLFd9sYbhHPTs
	 x5lPHMOwiC42qWNYGG/2lEV49kJJhRjV9DH/zLj9heYp8w6F/tuPWnSC1SIdGZDC4E5mw
	 +6slXnNgDclcze8FeAgObUZdM7gZEzdfXQSNhwESLGvKONbkHqhRVmghASbQNv1kutc+p
	 Mz0RCxuPy/GTZSotNKubJ0Ni7RU8QS8meyyedY51YmdowntyfTOg0FaYHgCj5ek0aOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xQy1bDdV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593E606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xQy1bDdV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7871F01825;
	Wed, 28 Oct 2026 05:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793166175;
	bh=lmr5/G2WiVR/lcWtJS/UhAiZPU3IE83O7fxfui1NwEA=;
	h=Subject:To:Cc:From:Date;
	b=xQy1bDdVCg69KqUwHTZoZ8mIdo6k0k2KqMsED+Y/cTha6g0Er4/wKfO3PyFRqShWK
	 qQrovLppquVy4atWvNAL1IgOJHW2BeXprrBz9AF66rlpukDVlzFXW16PodTyZaz3VM
	 yyLtP3SFjo5UtQFj4kZVNoE50xzz21Bx0oyOy8Hg=
Subject: FAILED: patch "[PATCH] tracing: Add the bucket size to expr_field_str()" failed to apply to 5.15-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 28 Oct 2026 06:42:35 +0100
Message-ID: <2026102835-probiotic-eaten-cce2@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c027ed03bc03a0e82fc368eaad657584a4480c7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102835-probiotic-eaten-cce2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

