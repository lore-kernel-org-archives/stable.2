Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFA83E3C55
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922481; cv=none; b=aFYxJ/C+Tp0eEM8uLzij6cJYB1cOtF47sNJGoRQNau01lQK/rercUymtNMK8HXePJC++DWKcYMUo74JsfUDLeWFEqvpmazeU63xyeHST/+GxY/xMxgWAOfBzlPsflqS5prC55RTdsw80GoHY6YpRVFBtc8QjATd6rV008gDF/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922481; c=relaxed/simple;
	bh=TztYmewJcZ5wlkj2HJISuCmtDmg9S+5X1sS0IypKIE8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SKL/zWlOrX0Q5HkZgTKNE/QjsSHiHDdTMq+SsVBbIYNTGw4KETlrfOyg0trWM8xCl5JY1gIrgQzvMKZTOKMKu4J18rMqKjcObbSaX6nnsXKEFu/f1krW2Cf2RYgHX6pqjlSDTqhw5ogl6AZNkRGaq7DXV33ywEYxsM8Wmz8fUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J420ee+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J420ee+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FE51F000E9;
	Wed,  5 Aug 2026 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922480;
	bh=JJpCtQnu6GiDhS3ouJFFuRD32CHNqnpxWbqNPHSngY0=;
	h=Subject:To:Cc:From:Date;
	b=J420ee+6APSJ/umfCtp+oKYDmC0DQXK95ZctCHfdzV2tudaKWwPyp5LuaCXKSIIpS
	 Ma/aTsoIaxESUwSPCs7ZHV+fdFlvYlAZ3eAfWotN8CRojVcvcPaTRylUMMFS9r33nm
	 jHDpbESi8ngy2s8ZHgbQs8LLXzINSxQSKzxGm1tA=
Subject: FAILED: patch "[PATCH] tracing/fprobe: Roll back on enable_trace_fprobe() failure" failed to apply to 6.12-stable tree
To: raushan.jhon@gmail.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:34:23 +0200
Message-ID: <2026080523-footbath-chirpy-debe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aca0cd1bf16574327ef64f3178e5f5e37a61ef0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080523-footbath-chirpy-debe@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aca0cd1bf16574327ef64f3178e5f5e37a61ef0b Mon Sep 17 00:00:00 2001
From: Raushan Patel <raushan.jhon@gmail.com>
Date: Fri, 24 Jul 2026 12:12:08 +0530
Subject: [PATCH] tracing/fprobe: Roll back on enable_trace_fprobe() failure

enable_trace_fprobe() sets the file link or the TP_FLAG_PROFILE flag and
then registers each trace_fprobe in the probe list. If
__register_trace_fprobe() fails partway through, the function returns
immediately without unregistering the trace_fprobes it already registered
or undoing the file link / flag it set, leaving the event half-enabled and
leaking the registered fprobe(s).

enable_trace_kprobe() already handles this with a rollback path. Do the
same for fprobe: on failure, unregister all probes and clear the file link
or profile flag.

Link: https://lore.kernel.org/all/20260724064208.480030-1-raushan.jhon@gmail.com/

Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
Cc: stable@vger.kernel.org
Signed-off-by: Raushan Patel <raushan.jhon@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 9f5f08c0e7c2..3120403a5b60 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1481,11 +1481,21 @@ static int enable_trace_fprobe(struct trace_event_call *call,
 		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
 			ret = __register_trace_fprobe(tf);
 			if (ret < 0)
-				return ret;
+				goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	/* Failed to enable one of them. Roll back all */
+	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list)
+		__unregister_trace_fprobe(tf);
+	if (file)
+		trace_probe_remove_file(tp, file);
+	else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	return ret;
 }
 
 /*

