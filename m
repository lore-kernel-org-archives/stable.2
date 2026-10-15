Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2D3525A62;
	Thu, 15 Oct 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071246; cv=none; b=b6s4XyZ9JXEKrsaME/su6wYK6NaEoHCxDtIWg2QcvHtmAhgjplR9GWMW4B7dFQ6HevmizhXQzpL2Cpn8s/AA36ovOF1EltWaNguDeZB4dz5vPjE5AjmCRIm1cOpD34640+QrtLQFKsuvfaJGJiwt+aLw+N3A12r7x1S6LyhoJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071246; c=relaxed/simple;
	bh=4KaXui/No84bu8n3kwTTNWJ7pLnVQ5J55bC8Iu5juvI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jZfJeUusLLaWzbDbqH/Wfk6e3yDHXqe9TCz1wV7ZdQY1eCV8MyUJBFKi7KbVTtQ17ofn382mOXXdgOHir6GHYksTS5/i8i6XXciGawOmg0Qs292UxQCVAWvPrMDkhfSFGMLqV5av4ETYfHVn0CQKnyS5Xf9qmV0W0le59KwUTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKEPATSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKEPATSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29E71F000C6;
	Thu, 15 Oct 2026 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071244;
	bh=7XA04YtwYueNkG2JHf7YpgvFxwo7uCAtD6OaTeZNXII=;
	h=Date:From:To:Cc:Subject:References;
	b=MKEPATSt7iTXX1H4/isYwVQIXalX6fX7UKmHTypzLsEVhUrVqgHUGFYZHYJ+y9g2K
	 7ubalcF+KmajlNC3lT74XE0xKn+02/L5m1nOsHQSKquKK4Uv36mT/WVd87c2DRjqGS
	 sGDzEqPBcwmmwUStump+aLANMP0yO0XK84WHHgVtwHeMzSJLDcPEmWxi6Zc04J3vS8
	 zlr0/aVh9BCefBJ6gsIkr5dX13JkezTVWSYiMjXEEAxxAlDKcMrKt3dJ+rfA8Z+4hd
	 f865iPa54L7YA9bDA7MMEFLLUouMVyV9u3LszXsN+ETC3ekCPi5lnvjkrhFUuHO00f
	 njCNfGOb2S18A==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLau-00000000Mez-0d0v;
	Thu, 15 Oct 2026 09:34:04 -0400
Message-ID: <20261015133403.976802464@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:20 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Dmitry Kandybka <d.kandybka@gmail.com>
Subject: [for-linus][PATCH 10/16] tracing: Fix ignored return value of resize_buffer_duplicate_size()
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Dmitry Kandybka <d.kandybka@gmail.com>

When tr->allocated_snapshot is true, resize_buffer_duplicate_size() is
called to update the snapshot buffer size. However, its return value was
not checked. In case of a failed resize this could lead next snapshot
being incomplete.

Add resize_buffer_duplicate_size() result check and return error if
resize fails.

Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260928152634.4354-1-d.kandybka@gmail.com
Fixes: 180e4e390978 ("tracing: Add snapshot refcount")
Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_snapshot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
index 07b43c9863a2..4731ef7325a5 100644
--- a/kernel/trace/trace_snapshot.c
+++ b/kernel/trace/trace_snapshot.c
@@ -675,9 +675,12 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
 			return -EINVAL;
 #endif
-		if (tr->allocated_snapshot)
+		if (tr->allocated_snapshot) {
 			ret = resize_buffer_duplicate_size(&tr->snapshot_buffer,
 					&tr->array_buffer, iter->cpu_file);
+			if (ret < 0)
+				return ret;
+		}
 
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
-- 
2.53.0
