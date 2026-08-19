Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD63CAA2E
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138080; cv=none; b=gywaI4gIRB3yKfk8FroCfsqseQ7M2D45saV4C+ZyTlbO5TPBk8/DswThy4xQxtAGTC6RmUhwi2y69A1gr9asJnLd1ZbAlTreTai1kPQ3mis0pv5NjSUZTIL6CG+odIkfg0kIWb1xepP1HlWOaTWDATGEWmXlg1BMDz0YZm2Gqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138080; c=relaxed/simple;
	bh=Cpi2Wo+ujnqPriurR8NEwtT1qtHQmXgylxv7YPc6Spk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky9bnvxFYwG/70scdsKb4HLedgXnKLW5Uv97AzPun/qfPPi6KTHAlCmNxo70yGavxfim/P/QEt+crK3zB1YMCTD+zK6lHumwxdHJcrTBCMCWvoc8a8j7UifomGzfat21xIspIKvwAeg9wOnNMivy8UYi5cYwLsdxRhDJXHQ3e28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbpmdKay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbpmdKay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D24D1F00A3E;
	Wed, 19 Aug 2026 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138079;
	bh=N7gcssczlWro9ADjnq9obeJBCMwQrmv+JqkdVF/EGHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KbpmdKayzpKee9WjihlzYRV6hwQohAMVgeWGFh8LBSqJlg6UZjThOwdpH5ZNZd/5J
	 qWLnoGIn7qKKS4GOlF3N572eqwCqEnUMfIS2RqxVfR4/fKYzSP0Ut0FBDoW7eQTzbF
	 B6cJZH5agDT5k2QwiEDofU/+1IPEJBkvhFC7z60WuX5Kk2O6XtrzqLYgX8ynh/AIH2
	 tkONpNLWOxHIozFX9aRNNcumEyALU1Boi6AMI+DP5w7qRE99jLCbNlFNgIMevkDH08
	 lkwDi2GcooLMoO8NbupKAlhgIK74CnOl8LWVf0MKYqRFsO+lCjA8G0jAWuhB7/rf6I
	 OteSBhlmY33eA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] ring-buffer: Prevent resizing of persistent ring buffer
Date: Wed, 19 Aug 2026 07:14:36 -0400
Message-ID: <20260819111436.3550258-3-sashal@kernel.org>
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

[ Upstream commit 7c727dfce6be04dd009b29091a4a17d952dbfe03 ]

Dynamically resizing a persistent ring buffer is not possible. Disable
the feature.

Cc: stable@vger.kernel.org
Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
Link: https://patch.msgid.link/20260806211306.3704194-2-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ dropped the incoming `else if (buffer->remote)` block since 6.18 has a plain `else` arm ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index df4eb35203b6..4ea02f5ee3f0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2398,6 +2398,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		if (cpu_buffer->ring_meta->head_buffer)
 			rb_meta_buffer_update(cpu_buffer, bpage);
 		bpage->range = 1;
+
+		atomic_inc(&cpu_buffer->resize_disabled);
 	} else {
 		int order = cpu_buffer->buffer->subbuf_order;
 		bpage->page = alloc_cpu_data(cpu, order);
-- 
2.53.0

