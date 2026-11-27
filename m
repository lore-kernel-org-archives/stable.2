Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804963;
	b=iIim7ecFeZorJbrSY9dUldVNfDWyHkaJzGnEtraJGwe9PFu1kj6NpBX2HkicVItwkySe
	 7a5vosGQTNIRm1UYylmLLpYfVuWmDCCqt917nDqlDu9+L2SBpVK0svfXS3MlPplGHmeOD
	 W1V6GrNioJlaJUtaYpoKiNvKO6GfmpBrq/Va3TmlIVMNyVoLV3uuFi+bCs2cW0nqHxja+
	 v6EOTVsY1ozrvz3C229z9F7WgVSuIAapBjs3yxmCoZIkgBMiDsLEHkvVYaAyx5DjtSFpC
	 o82vf/sYjb6ZHtscZffKdqrMyhrH+En0aaIE5XGMm7CdHCokQqLGFSHg23nsUgA3Fbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804963;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=Akbo+DQOb6IFGJ+L86BHc+GMQvC+7if25aj3ycJApwI=;
	b=jMn9mNB2bNHMcHWd14upxqiC0v3VLHOqL4sfOh2OhRxQsl/8N2tBlh7YUb3oPrqWJMGu
	 349NCf7qjjoptBqKooV+ywXVlBKrRl4xUOGHmulwDrbttDa/AUwqKsOIh4fhn8iFdGXo1
	 PPCDV1PsT3KDikgd7iWEv8w++26JHJDXfP/lo+voujxBM7QHLX+c15+L/XbzCHVQYcyOG
	 wKjYQQd6POMo2DJF0GoSbIjoFzRI/SudeLNIJLj0gFSd4OKV+tRMZiIehhaxU0nDEpJsW
	 WYZzr7dl/CL14wtgvsF/e+5UJ0xvb38sRBTjLeOTPncIxDVzT+cEswOm5UIu+P6jTIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMTn0lDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD060A2609;
	Fri, 27 Nov 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMTn0lDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4C31F00939;
	Fri, 27 Nov 2026 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804962;
	bh=Akbo+DQOb6IFGJ+L86BHc+GMQvC+7if25aj3ycJApwI=;
	h=Date:From:To:Cc:Subject:References;
	b=eMTn0lDl4Ra1BSpRkWdfRTrV5QboPHwls8za40JCROFtkkLS8hnj6pZFDdCyhUT4V
	 lHQIMn2withNpL0G1IKxG083jdKOGk7B0EMglPyEEZBQ7a8+IU4T0znP+MmM3c6LqR
	 OGTxDm2QJbtNbpdYndVUy4ylIk0N0iA5adQhZalDNTrSEZuIsGat6fhgw4JZYapBfu
	 UNB2qKaAmXtN7AcU3EKWRg8QFr/KbmdP9HZ0ywwkOH9WNh4bf/HPjbryCETIstcPzP
	 QrPuwO3YWm8q7U3H8a+pBB7aW35gCgHsgrnum9YAWxRzJ3+5cbSaOmhF0tJHQLwmBM
	 qQ9+LsvMEhX3g==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xX0u9-000000085ZM-41qo;
	Fri, 27 Nov 2026 13:42:41 -0500
Message-ID: <20261127184241.768558453@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 27 Nov 2026 13:42:05 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Fuad Tabba <fuad.tabba@linux.dev>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 2/5] tracing/remotes: Align field offset in remote_event_format_show()
References: <20261127184203.439481361@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

remote_event_format_show() doesn't take into account each field's
alignment leading to an incorrect reporting of the actual field offset.
Use the existing field->align.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009132848.709379-1-vdonnefort@google.com
Fixes: 072529158e60 ("tracing: Add events to trace remotes")
Reported-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 2d5bc423efca..7e35f48ae467 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1098,6 +1098,7 @@ static int remote_event_format_show(struct seq_file *s, void *unused)
 
 	field = &evt->fields[0];
 	while (field->name) {
+		offset = ALIGN(offset, field->align);
 		seq_printf(s, "\tfield:%s %s;\toffset:%zu;\tsize:%u;\tsigned:%d;\n",
 			   field->type, field->name, offset, field->size,
 			   field->is_signed);
-- 
2.53.0
