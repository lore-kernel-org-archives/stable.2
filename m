Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90284D09F3;
	Fri, 16 Oct 2026 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157566; cv=none; b=mnu5CjaF4uNeQuZHe+cXkyZ+i0fNu5Kd+zJkyRGOmoAIRU4eH14BpjC6qnOxYLwAXAFZq5Qwdh5qISaw1AEJoZJLqPnv4W1gc1vqa1NF5HdBo0JWKYOr1ZUbRRnwVVrx50KrlAE3J6raSqEWckYsT7k6CNgapdA8FMMCNl8RFbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157566; c=relaxed/simple;
	bh=QKHd2xRjjFAOzLy7ke4Z/dj35NJ4a5Rb7JDcr24KGuI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RtXZUP0VuONOOapMcpmst5tppnWU7ro6PpEw5Ud2itG9oKUGU1hLG8V63pQs7iMw3Cx+blYryYtYXnhjl9RjeTn8vvXnIyNgjKkFU68qTMqopWL9//4qvhaNvVuVk3voM979JLWEO+Pmmlzhss9uYH/xYkZtd9imuoFfyl9RCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrM+YTd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrM+YTd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9C41F000C8;
	Fri, 16 Oct 2026 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792157565;
	bh=Sdv4jEo2GAMTX8hgC+kyloM7VR0ZThCwD4MNi5yQbxU=;
	h=Date:From:To:Cc:Subject:References;
	b=CrM+YTd+x+32FkgISyNzZ9t/0RAharXE/zhmOmAAKo6xMtiDZfxvnRom/OSW7XOU6
	 XG3jyE1BwXhXIqMWIMrefTUyWOihM/hCbcttS8FsDsgMnq4RdTtodzCqnagioOlwU5
	 DhmzDhE+2uO+iISYUCp4bJOKyj5OFApjJCiv+PaaYO5XT13vNbVqZ+aZ1H0FY5Los7
	 TLrkydeAdqNxgdlPibd7XyJsDFZ3qOpuVInEZuPRZyYTZDFeVLiU5mIR67hvRBbSSo
	 aMPQHUkIrzRqH3sO1Lccor67+pXuFffbr1xxu+PoQaxeu5JAOyBQA4Zjx4ByjqPKT/
	 1wLNOr1FaYzpA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHi3B-00000000WV0-077Z;
	Fri, 16 Oct 2026 09:32:45 -0400
Message-ID: <20261016133244.831560323@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 16 Oct 2026 09:32:20 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Taeyang Lee <0wn@theori.io>
Subject: [for-linus][PATCH 2/3] tracing: Keep the predicate limit separate from program capacity
References: <20261016133218.800011513@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Taeyang Lee <0wn@theori.io>

predicate_parse() adds two to nr_preds to reserve the terminal TRUE
and FALSE entries. It also uses that increased value as the limit for
parsed predicates. If the initial count is smaller than the number
actually parsed, the program can fill the allocation and subsequent
accesses can go past its end.

Keep nr_preds as the predicate limit and use a separate value for the
allocation size. This leaves space for both terminal entries and a
zeroed entry when parsing stops at the limit.

Cc: stable@vger.kernel.org
Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")
Link: https://patch.msgid.link/atELCd1XjKVhrkFL@Taeyangs-MacBook-Pro.local
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..781416ba6bdf 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -482,18 +482,17 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	int len;
 	int N = 0;
 	int i;
-
-	nr_preds += 2; /* For TRUE and FALSE */
+	int nr_preds_alloc = nr_preds + 2; /* For TRUE and FALSE */
 
 	op_stack = kmalloc_objs(*op_stack, nr_parens);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kzalloc_objs(*prog_stack, nr_preds);
+	prog_stack = kzalloc_objs(*prog_stack, nr_preds_alloc);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
 	}
-	inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
+	inverts = kmalloc_array(nr_preds_alloc, sizeof(*inverts), GFP_KERNEL);
 	if (!inverts) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
-- 
2.53.0
