Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC75474F
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138080; cv=none; b=jO86mKC6zHcQKPeXOXfCi00AZRfXpt3tsxhqJjJGdCKMAzDXbjaf97B5PIYLgm9rX7SQBD/QCcWuLELmOzzZoZTJBKclltZZ/Ge4fbK28dAF+Omqu+lQCcvgIgy+gc0jh+6TRGNP2lVUT07+F1ToQB+gpI9RECljBTOlpQ70ujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138080; c=relaxed/simple;
	bh=aj936XFRabFbXRUDNZH0UgyKLaMaIMbt76jGwM4ZeKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/BZ9ZadaZkRsMwzfVht88kdyevLqnAo7NVTXNYG0ShV6ujvjCiNAXVALHw8ZRdbrJkIS2uOHJWXGl+pCwk45e4Nxku2nmy2ak3wTgKnD4SURna7PtNeDrRlcjpbNS8CmXyG4qNJxS9P2Ft8haqDkHudUCbgaXkSlDgHmiZOIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6Zsk7Ew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6Zsk7Ew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F331F00A3A;
	Wed, 19 Aug 2026 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138078;
	bh=yGCYQWHo7c3BOo+wMXnU5Rg9d3xTS0TkJn3i1VxCPxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R6Zsk7Ew+CYcMmcjVCm830XgFGAmaodLvLRmXTtximULsKK++UqqIGGzM6gnZJalU
	 DsdCwcEKyl1qp7I3Py4eNPK+an6KRWwE5rpaxsMzz0TqOzicUvS3U48aIVWv5J8Q3J
	 UydUxcLBIaNLfLrSJbGVKtd2hfG3Boe9yuTarVkJFiGqGVq+notP7rpqEh2LgsXmiE
	 ErHY6+gL9rB6eD2wSNDxePaGTxP9r4ud+DoyvYo85b/zIhfuYJ365Nf04ayAHESv5a
	 yTKnS0ebphwggoq/zdCEmbwI3KSDPqqCY005Mrd6pgUhwlWSXAk4If7jP6HCBomeRQ
	 +/C+hBFUwBjag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] ring-buffer: Store bpage pointers into subbuf_ids
Date: Wed, 19 Aug 2026 07:14:35 -0400
Message-ID: <20260819111436.3550258-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819111436.3550258-1-sashal@kernel.org>
References: <2026081708-platonic-evade-02c3@gregkh>
 <20260819111436.3550258-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit e682207bf7ae3f81885f612ada1ac44d027158d4 ]

The subbuf_ids field allows to point to a specific page from the
ring-buffer based on its ID. As a preparation or the upcoming
ring-buffer remote support, point this array to the buffer_page instead
of the buffer_data_page.

Link: https://patch.msgid.link/20260309162516.2623589-3-vdonnefort@google.com
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 7c727dfce6be ("ring-buffer: Prevent resizing of persistent ring buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7b14b6911f9a..df4eb35203b6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -557,7 +557,7 @@ struct ring_buffer_per_cpu {
 	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
-	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_cpu_meta	*ring_meta;
 
@@ -7038,7 +7038,7 @@ static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
-				   unsigned long *subbuf_ids)
+				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
@@ -7047,7 +7047,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	int id = 0;
 
 	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
-	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_ids[id++] = cpu_buffer->reader_page;
 	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
@@ -7057,7 +7057,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 		if (WARN_ON(id >= nr_subbufs))
 			break;
 
-		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf_ids[id] = subbuf;
 
 		rb_inc_page(&subbuf);
 		id++;
@@ -7066,7 +7066,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(cnt != nr_subbufs);
 
-	/* install subbuf ID to kern VA translation */
+	/* install subbuf ID to bpage translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
 	meta->meta_struct_len = sizeof(*meta);
@@ -7222,13 +7222,15 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
+		struct buffer_page *subbuf;
 		struct page *page;
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs))
 			return -EINVAL;
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		subbuf = cpu_buffer->subbuf_ids[s];
+		page = virt_to_page((void *)subbuf->page);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7255,7 +7257,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags, *subbuf_ids;
+	struct buffer_page **subbuf_ids;
+	unsigned long flags;
 	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -7279,7 +7282,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (err)
 		return err;
 
-	/* subbuf_ids include the reader while nr_pages does not */
+	/* subbuf_ids includes the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-- 
2.53.0

