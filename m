Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE0470EA9;
	Fri, 16 Oct 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161099; cv=none; b=ahM9fuwCl5h/yAs0DkHk0s7IV5cE7Pi6bnFovr1rmGDbXvnYWAYTsomH7pKJeuAt4glYyPR8gTjL2S94WpjkaplejvMaKW/mfCmVoxc0XmF3ubI0/w5SbIi4sO5p03n6lO6Nwp1VMmnvpHa3J84w2oHjXHJKEDbEE0BSypxk8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161099; c=relaxed/simple;
	bh=OiXxv1qZ/xcEU5mRqLHS7JbWWOLbEHsCm6Z01k2Zn68=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=saXRA+3GplJIcNYsFlWyeFx+CkBEy6/tQR/E5rSRKiUHa+M7/ltMWGmMOKNiHoNJ8zN3ABF01Isu8wDp9S9541oCdN0uX2YM7JxFh85BNLGdFlp0KBQmV3IENxwpFUTew27sml/Cda/7CJdLqQhpAdDrxA/BqFqsomJn+npY9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXyefEp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXyefEp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA2C1F000CC;
	Fri, 16 Oct 2026 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161097;
	bh=jAIll/eRG7L3dQo+tAL1ksieQ7ragvOZqbiPDuFU5YU=;
	h=Date:From:To:Cc:Subject:References;
	b=fXyefEp8M4P0jNOJUAlXG+46gIfncgd7fOGUo+SMkvGyW+Jj804QNykMoGNRYrBjJ
	 SUO+Iv0VxeHelMC38hucg+5k6hTi/Bv98hsri71OgGK6drcR9fkMCZefx9TRzfB34u
	 Sr0zXQ70UOMBM6vv3WWEXVA2lgNvmywMfzbtiHyASQitxjFpxOZoAriUqAuu8dFJwh
	 TRoIvFyZTWjjrlFpBzymwV+bnqL5e/RqIY5lseDUJcejufG92TKQmSkGoMa5mjqGem
	 oEJHyqEAfzwzKtMjiKqi/eERSPa6t7KfYSOH/Ak0Tvex0nNrtxsAyOxfg/EhpjohQ+
	 HhGge4LoxCjqg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHiy8-00000000Xnf-42S6;
	Fri, 16 Oct 2026 10:31:36 -0400
Message-ID: <20261016143136.783442663@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 16 Oct 2026 10:31:28 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-next][PATCH 13/18] tracing: Add the bucket size to expr_field_str()
References: <20261016143115.392980228@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

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
---
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

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
 
-- 
2.53.0
