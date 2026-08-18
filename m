Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04634FF41
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081437; cv=none; b=kUrHBrDVnxHX6uJgPLyPoHj2wTuQknXMUUnasjay+XDj08PU580z8qUZbNj5q8BBKWlf1cMIrGbVd5cv6agaz9bd2P5MRP0zv0JdRsDKV8Tj1zi7f0zfFmMW50cwJHS4z7urzJ3pPu1mftuRisg0unGaah0sPex917h9i44wxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081437; c=relaxed/simple;
	bh=GZD5JBehQi94S+Ytl2n/LjS+/QD8VRQ0pxZU85F7Ht4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqOwgH2ij82i7y1d+UBJ+TR5fN+8/BePpeIsuibVABV+a+PRdcYyFXJd9QtkzQnga0OS0WUQfuVwDnb/3AtUxnQoPhDjcXjh8hMV6nEbG49fVnchCYsyFeA/SYZJ1NHaRLGhYXfyAQgPvoYCIltoe6pyfI73ocxW187VD7jJ/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9bVLQiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9bVLQiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B261F00A3A;
	Tue, 18 Aug 2026 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787081436;
	bh=hL/+Y11pwEN6fb0eVGWPfAmJ9TWkeT9z6fByKdJjp2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A9bVLQiZPJIl5BY8HkirtRXVdc/vlKvCuCQowtzA4gc4mDdw1NilPF9axgVZf0Rhy
	 OnwEQC6JdaFoZubGKkrCh2PeZxP/DHO/9vkWfGbmFduYJpKjmXeqEKYQmoxutVJWQm
	 Oh+rYwa+mTOEOT+OoSpdqLOdVQhB4MzjX5b/6J+bediG2HQbVDpYZssgDpHvU/wpGX
	 /4l+9PVsHQUNR02TI/ttZfvJ3e4kSUtqyIfNha6HJC8FlZea59HBoLaLF+AwquAfNy
	 lZ1RnaTz2c6kTQcmDhECGAEmjmJ19Kdx4s56yP9Z+PCRcCanH5VUALMGUl6lEVtpJR
	 YIh2sLxX5FiKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ring-buffer: Initialise reader page order in rb_allocate_cpu_buffer()
Date: Tue, 18 Aug 2026 15:30:32 -0400
Message-ID: <20260818193032.3302299-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818193032.3302299-1-sashal@kernel.org>
References: <2026081707-pajamas-stoplight-328c@gregkh>
 <20260818193032.3302299-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit 6d014e44b68ddd43f71288d2a4dbb1a259869149 ]

In rb_allocate_cpu_buffer(), bpage->order was omitted, leaving it as 0.
This is an issue for a ring-buffer with subbufs bigger than PAGE_SIZE if
when freed: free_buffer_page() relies on this value. Align the value
with the actual allocation size (buffer::subbuf_order).

Cc: stable@vger.kernel.org
Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Link: https://patch.msgid.link/20260806211306.3704194-4-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7c9c7f2b4db9..7da4ae0f4385 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2220,6 +2220,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 			    GFP_KERNEL, cpu_to_node(cpu));
 	if (!bpage)
 		return NULL;
+	bpage->order = cpu_buffer->buffer->subbuf_order;
 
 	rb_check_bpage(cpu_buffer, bpage);
 
-- 
2.53.0

