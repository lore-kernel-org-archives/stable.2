Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA904A9D7C;
	Fri, 11 Sep 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150578; cv=none; b=gACfYXwL4ZRP/yoxvXAoGll4b/KCry2O+4P6gba8giPjhNEmLzAqH/qmHEFDTjMKYOGbR0dUftGIlztW611GkVDN/UqamZeW1AZcOZ9TyGsMNFrdmm7rs0q/Ugb6ynWQTfiFPBj6rnP7773jiGkZE4dvhSlfqlM4uXl/ONa+9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150578; c=relaxed/simple;
	bh=vIFLuivCeQ5Xw5/AowTYuazWOvl3GwU4HZGEW5vQMmw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CMb238kXpGeOQdUcZdlQoNPUr4hihr5HTyS1MuFovzt1qzlIUMQE6NQSZ177Pkc4kKmsyWTgjzJiXWkE7gJdkfOT/ng1NOgpji9pZAZ+Z9BbuR22yJe7sBlJ/ZrIHZrFEdqXkXF5VN4hLV4RZUk7hfMbbPbrda0KnZ5Uo+Pfk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlAz6xK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlAz6xK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53C71F0089D;
	Fri, 11 Sep 2026 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150567;
	bh=lTmwD2rLpAi7kXIGGvh7B7Act95huXSlJg38wH9ougM=;
	h=Date:From:To:Cc:Subject:References;
	b=MlAz6xK16bI9tf/mfS2d2yF9XYw4pqeLAQgY+AWxzfudptxWZv0VRNo9pskQ7iylu
	 VPjsmAnHmcA0L+XxEeiV76aCP3lQ8ivJG1vTF51DcpiCkpvxA605WLHqQ/L1dBMzR9
	 6wjEHlT4krDDxe9kAl7loGPKIZRv072gGFo4td1Y8VlkuQjhm1fTUSRX6CvVxO+GvM
	 Rhsp050x4RwoSS8drPkf6bzjilUgTQu6cuFqlPYURLrQ7jFiYoDNGV+72UjCTBTwZU
	 F3Rb8f8MVrHC1MrUialvq8T2KGzbMX9H4tMGGftI+OTu6fvqAInKmz1KkIQ3Ml56Y6
	 f5kLwrkkf4GFA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oX-000000094xo-2XBO;
	Fri, 11 Sep 2026 14:17:29 -0400
Message-ID: <20260911181729.421437849@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 06/20] tracing: Free histogram the var ref when its initialization fails
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

create_var_ref() allocates a VAR_REF hist_field and then calls
init_var_ref() to fill it in. When that fails the field is leaked.

commit 656fe2ba85e8 ("tracing: Use hist trigger's var_ref array to destroy
var_refs") made destroy_hist_field() return early for
HIST_FIELD_FL_VAR_REF, since var refs are freed by walking the trigger's
var_refs[] array instead. create_var_ref() adds the field to that array
only after init_var_ref() has succeeded, so on this path the field is in
neither place and nothing frees it. The call was correct when it was
written, before var refs were taken out of destroy_hist_field().

init_var_ref() cannot free it either. The caller owns the field, so
init_var_ref() undoes only its own string allocations and leaves the
field alone. Freeing it there would leave create_var_ref() passing freed
memory to destroy_hist_field(), which reads its flags.

Call __destroy_hist_field(), which frees the field without consulting
the flag.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260906133352.3815019-1-donggeunyoo.kernel@gmail.com
Fixes: 656fe2ba85e8 ("tracing: Use hist trigger's var_ref array to destroy var_refs")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f90680b33a37..bbdd56208eff 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2221,7 +2221,7 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 	ref_field = create_hist_field(var_field->hist_data, NULL, flags, NULL);
 	if (ref_field) {
 		if (init_var_ref(ref_field, var_field, system, event_name)) {
-			destroy_hist_field(ref_field, 0);
+			__destroy_hist_field(ref_field);
 			return NULL;
 		}
 
-- 
2.53.0
