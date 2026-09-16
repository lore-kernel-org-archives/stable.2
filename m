Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FDD50C289
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568360; cv=none; b=Ch6e5ordYG/IzNtqkRJ/v2TNtLvIu+CmZ2pVgwyk0VmAR/62cujR0SFV0jpTK6tWl3eA6TUvYrGKVgB/uVy8a2GNDBB0Ap8zHI2/lo8k1sIsc1qJU6x3Y3G/ES9vbCL0TdSpBY3v7U9CXXKM/OatnYJD7TZCR0FLxJsqnvINqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568360; c=relaxed/simple;
	bh=YqRNY6LldusggF0L4TrWy61PBeePQGCRvtSUcCHMrLQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i8mUxKgWq5Z9mXYEjXk/+eaJIIixRFrnMSw/wp+OP1KDGqmqToQjOkNjE6jXDsSTLJeG4TfdskhD1XkC7dNbA3b9btLUHa9ZP5JAto8HfUCVOyKH0bCyXDyxraYstBxAwbkIXS4gvllsiGXqcmRRYrcgAFg/mGelTYm0e6x0+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SvOmGzzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SvOmGzzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63F61F000FF;
	Wed, 16 Sep 2026 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789568356;
	bh=IgnSj2qco4mxQ6AXgyfGrAVXjLnhe2Gtqz4AJwL85D8=;
	h=Subject:To:Cc:From:Date;
	b=SvOmGzzmtUHMLveu3OjXTxJp0uK1hR70KiZImfZTX0vyouS42r7Lz0vNbGbTvYsk2
	 zzO3n6ufnyaocfrr6cLZh5rq7ys7j/QSkpIHBOxpng04XsnpanfN7HwFmH7vY9VeDR
	 FAQaUpo3Kru+UEYbwdu4uwwy8lKQvTX2KRtm/ya8=
Subject: FAILED: patch "[PATCH] tracing: Free histogram var refs regardless of how often they" failed to apply to 5.15-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 15:17:21 +0100
Message-ID: <2026091621-debtor-hazelnut-dfc6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 4bddcb346a6cf4615ca77f69a589623b877ca267
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091621-debtor-hazelnut-dfc6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4bddcb346a6cf4615ca77f69a589623b877ca267 Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Sun, 6 Sep 2026 21:40:25 +0900
Subject: [PATCH] tracing: Free histogram var refs regardless of how often they
 are referenced

Using the same variable three or more times in one hist trigger leaks the
variable reference and its strings when the trigger is removed.

commit 656fe2ba85e8 ("tracing: Use hist trigger's var_ref array to destroy
var_refs") made a trigger's var_refs[] array the only owner of a var ref:
destroy_hist_field() returns early for HIST_FIELD_FL_VAR_REF, so the field
expressions never destroy one. One entry, freed once, no count needed.

commit 8bcebc77e85f ("tracing: Fix histogram code when expression has same
var as value") then made repeated references share one object and added a
count of them. Only the increment side exists, since those expressions
still return early and never drop a reference, so __destroy_hist_field()
sees how many references were created rather than how many are left. It
frees when the decremented count is 0 or 1, so two references work and
three or more leak.

Sharing kept one array entry per object, and create_var_ref() searches and
appends within a single trigger, so nothing outside it holds the object.
Removing a trigger whose variables are still referenced is already refused
by check_var_refs() with -EBUSY. Drop the count and free unconditionally.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260906124025.3550596-1-donggeunyoo.kernel@gmail.com
Fixes: 8bcebc77e85f ("tracing: Fix histogram code when expression has same var as value")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..f90680b33a37 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -169,7 +169,6 @@ struct hist_field {
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
 	enum hist_field_fn		fn_num;
-	unsigned int			ref;
 	unsigned int			size;
 	unsigned int			offset;
 	unsigned int                    is_signed;
@@ -1913,16 +1912,8 @@ static int contains_operator(char *str, char **sep)
 	return field_op;
 }
 
-static void get_hist_field(struct hist_field *hist_field)
-{
-	hist_field->ref++;
-}
-
 static void __destroy_hist_field(struct hist_field *hist_field)
 {
-	if (--hist_field->ref > 1)
-		return;
-
 	kfree(hist_field->var.name);
 	kfree(hist_field->name);
 
@@ -1969,8 +1960,6 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	if (!hist_field)
 		return NULL;
 
-	hist_field->ref = 1;
-
 	hist_field->hist_data = hist_data;
 
 	if (flags & HIST_FIELD_FL_EXPR || flags & HIST_FIELD_FL_ALIAS)
@@ -2223,10 +2212,8 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 	for (i = 0; i < hist_data->n_var_refs; i++) {
 		ref_field = hist_data->var_refs[i];
 		if (ref_field->var.idx == var_field->var.idx &&
-		    ref_field->var.hist_data == var_field->hist_data) {
-			get_hist_field(ref_field);
+		    ref_field->var.hist_data == var_field->hist_data)
 			return ref_field;
-		}
 	}
 	/* Sanity check to avoid out-of-bound write on 'hist_data->var_refs' */
 	if (hist_data->n_var_refs >= TRACING_MAP_VARS_MAX)
@@ -3276,7 +3263,6 @@ static struct hist_field *create_var(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
-	var->ref = 1;
 	var->flags = HIST_FIELD_FL_VAR;
 	var->var.idx = idx;
 	var->var.hist_data = var->hist_data = hist_data;

