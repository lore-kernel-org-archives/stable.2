Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208888;
	b=EvjECuEfv78LLPGiU8aJZW/dZcQFVdLp1bGaLM/UXDRMejmdI1qZi8BnJBhWw3SB02QO
	 64ojIvG/uvsrYI9tbUXG/yzYgPPbK4R9jtygTv3Jmv9Obj0UTnyjoIX/vIsNXdLY5ACCz
	 rBDtE2HbHRqrR6qcJUMq8AyvFVwD3fQMWAPFViZBKJqZVRJT49bj85PhG1VV1wdcivmGJ
	 PBCmyD45H003ZtIKsPzKFJpz4Zy9bZn/QGbRlh0dZ//JHXCVAbw9E2LdmGdSHlwpZJyOt
	 vhP9wgLjNLx1OQuH7G3uF1pm9r+90gBmuj9f+Qaer5sLiVTHzTnWaHA66aJ6TKhZ2AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208888;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=z4KQ9ur7T2zxxI5IMiepuDiZw3HO1s+NcjMePnOn0Ro=;
	b=ydRXMMjvNiRonLcLPumATnTQvYsz10jz7bc1ZbaZQ5q/wp/2h2hjnlkCBC43XwwEygwV
	 qneeTZygX8K5O+UQvQtVpiX59HUmIAH+K7GW+NDdYWZoUUV5tJzGsAvlPFmB90ZBDJ5Fu
	 BAAEK1J0VdlLWWfbXgLGiRt8eKzaSCPOaRnpuMARhOctGRopu8ZAHzYqwAT4oWrpuTJul
	 4iKwb+h/bRxJVd8cL20NihaEC7xmstLtqcOe4UMol5/ZmTeA66dXl0+ZMdW8hEXURhYlA
	 YVbdJDP8MBUEgQ9fRoDpNBqwLmUAwn8Vdd4wIArFSQYQFb0tPoPDQ6MbwSzq6l3AQkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zrPZcwmi;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D9606A31C;
	Mon,  9 Nov 2026 07:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B8D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zrPZcwmi
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id B1E6C1605D3;
	Mon,  9 Nov 2026 07:21:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 72DB86000D;
	Mon,  9 Nov 2026 07:21:20 +0000 (UTC)
Date: Mon, 9 Nov 2026 02:21:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <srostedt@redhat.com>, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <20261109022104.214fc175@fedora>
In-Reply-To: <20261105155729.0f9c7e4d@gandalf.local.home>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
	<20261105155729.0f9c7e4d@gandalf.local.home>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ca6fqgaq4119qkm9zan7zj11nwtuioh5
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 72DB86000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Wus/X+66WuujD0oWCiUcgXWmfMH+Kh9c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=z4KQ9ur7T2zxxI5IMiepuDiZw3HO1s+NcjMePnOn0Ro=; b=zrPZcwmipijpDKowW7aYBNEZtTC8jO3Q3SD5qtuXkWv+0IOHkSMJFUPiSlpRbkvlozR0E4ErZkzRLSy3GtIW1BPsCH57qN+ZdFRul1vV/DpTLZ+4Hp+coEbNfzIZp+zkI6lZxhQ4hyZhw8TsAy4po+UjQWbnmvEqNA2elUOU81U=
X-HE-Tag: 1794208880-263880
X-HE-Meta: U2FsdGVkX1/h7Z9+jzxdQwjhXJav2RBG88LhYugWFjpJW6DLPXAOWsPt6fkfd2Qq/rNEMEUIwFaFP0BL74Ies+BvgN6JLmfstsXLJ6HVdwuXigldN/FXo3Cfc7S6hd5kRLhI0R4eJB/fFCI8cazEX8n4A8Mv2w2HBCquco+Hz6ywwNO24lI/j2LOirZS3n/QkfLgIk/UkVR/o5fmr51GGSqYYSxAL4vano5eLIePbV+5HuMQt029pTCmMLtQtoPtxDWVLnlGa/5+cgJd7wkAgzmvVsh+xZoArn4TOjvidCSnrH/u0EgU7cIl3lh+CW+RdN8gfXANumFLGIPGOgJRxGW8xf/QvxMxJqykrWeUUjWgAyKMNQ0R5VAKhZcD+T4d

On Thu, 5 Nov 2026 15:57:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> We may need to add memory barriers here, but for now, I think this could
> fix it. As it should prevent the search from ever starting in between the
> two heads.

Yeah, I think this will do it. Please test, I'll go write up a formal patch:

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c64e001c3fc0..0d37f8b529d5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1494,7 +1494,13 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev->next) != list))
 		return NULL;
 
-	page = head = cpu_buffer->head_page;
+	/*
+	 * Make sure that the start of the search of the head_page does not
+	 * start between the writer adding the UPDATE and the new HEAD that it
+	 * moves forward.
+	 */
+	/* Sync with the writer moving the HEAD in rb_handle_head_page() */
+	page = head = smp_load_acquire(&cpu_buffer->head_page);
 	/*
 	 * It is possible that the writer moves the header behind
 	 * where we started, and we miss in one loop.
@@ -3721,6 +3727,15 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
+		/*
+		 * To prevent a stale head_page from being between
+		 * the UPDATE and new HEAD pages, set it here to have
+		 * the reader check always find the update before
+		 * finding the HEAD page.
+		 */
+		/* Sync with the reader setting the head page */
+		smp_store_release(&cpu_buffer->head_page, next_page);
+
 		if (cpu_buffer->ring_meta)
 			rb_update_meta_head(cpu_buffer, next_page);
 		/*
-- 
2.53.0

