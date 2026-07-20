Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD42BE7B6
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560966; cv=none; b=gEs0TCp6jWdZDTuwFGlC6+gHx3zP7e/i6vOX9YFPhgMUapm94Fd0bMx2DQ+7QB8UXS9E6bxPLzCx2DyuiPEXCfA0mOB8bCZ10Z/BPx+SM0E8ulBiIJqgZrjTwqkJ9OP2vjrT/M7X2jbV33pFu71j6feRVlx2KIwSAxaSTaKUjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560966; c=relaxed/simple;
	bh=w45foug3SI/MQbS3lkj0FEFadUWGFMwOrqZY0WH686c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JrXwBb3HLW+oY/SL2K8+/ORYYPVsktevcK194uAnxHrQTtSD9gnJJOh3CbLq+xkIMB1/ki67IdDvYTj3mZOGsvVAjCNpcnMmmpeBxFVG5MpswHWmM4hbhJ1rMv/N4GrY7qTAqPMaU5uLjWBG4aynSgRFq/UaAEXE/AnTgP4ftew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZ/mXf9A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZ/mXf9A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2601F000E9;
	Mon, 20 Jul 2026 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560965;
	bh=5tc7sOzd8iMxyXNE5ojE59Oc2nv8qTP8ZQ7Wroq+OpQ=;
	h=Subject:To:Cc:From:Date;
	b=sZ/mXf9AzUsLKDM1dx3XdXeRgd2Lcg6KrzOKYKBO+5ZOb1sNhxTLsrfMeh1tqJMZu
	 F0HCDKjhEA0fGySwsEshl8YXHH8I9CinR1RZuCYQh6kC/gPR7BjTUlQmc9oBIGfxUI
	 6K/ZOHH5SbtIUUv+5BU7VdxrhGbHni2lKWERxVL4=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: tracing: Do not dereference pointers in" failed to apply to 6.18-stable tree
To: rostedt@goodmis.org,bvanassche@acm.org,martin.petersen@oracle.com,peter.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:22:28 +0200
Message-ID: <2026072028-animal-expiring-a6a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 46aea2c64e110ed1878fa5363f86ddc8fd79c9c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072028-animal-expiring-a6a1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46aea2c64e110ed1878fa5363f86ddc8fd79c9c4 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 30 Jun 2026 18:54:12 -0400
Subject: [PATCH] scsi: ufs: core: tracing: Do not dereference pointers in
 TP_printk()

The trace events in drivers/ufs/core/ufs_trace.h were converted to take
a pointer to the hba structure as an argument for the tracepoint and
then in TP_printk() the printing of the dev_name from the ring buffer
was converted to using the dev dereferenced pointer from the hba saved
pointer.

This is not allowed as the TP_printk() is executed at the time the trace
event is read from /sys/kernel/tracing/trace file. That can happen
literally, seconds, minutes, hours, weeks, days, or even months later!
There is no guarantee that the hba pointer will still exist by the time
it is dereferenced when the "trace" file is read.

Instead, save the device name from the hba pointer at the time the
tracepoint is called and place it into the ring buffer event. Then the
TP_printk() can read the name directly from the ring buffer and remove
the possibility that it will read a freed pointer and crash the kernel.

This was detected when testing the trace event code that looks for
TP_printk() parameters doing illegal derferences[1]

[1] https://lore.kernel.org/all/20260630184836.74d477b6@gandalf.local.home/

Cc: stable@vger.kernel.org
Fixes: 583e518e7100 ("scsi: ufs: core: Add hba parameter to trace events")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260630185412.283c26c5@gandalf.local.home
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/core/ufs_trace.h b/drivers/ufs/core/ufs_trace.h
index 309ae51b4906..377a3c54b9f5 100644
--- a/drivers/ufs/core/ufs_trace.h
+++ b/drivers/ufs/core/ufs_trace.h
@@ -89,16 +89,18 @@ TRACE_EVENT(ufshcd_clk_gating,
 
 	TP_STRUCT__entry(
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(int, state)
 	),
 
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__entry->hba = hba;
 		__entry->state = state;
 	),
 
 	TP_printk("%s: gating state changed to %s",
-		dev_name(__entry->hba->dev),
+		__get_str(dev_name),
 		__print_symbolic(__entry->state, UFSCHD_CLK_GATING_STATES))
 );
 
@@ -111,6 +113,7 @@ TRACE_EVENT(ufshcd_clk_scaling,
 
 	TP_STRUCT__entry(
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__string(state, state)
 		__string(clk, clk)
 		__field(u32, prev_state)
@@ -119,6 +122,7 @@ TRACE_EVENT(ufshcd_clk_scaling,
 
 	TP_fast_assign(
 		__entry->hba = hba;
+		__assign_str(dev_name);
 		__assign_str(state);
 		__assign_str(clk);
 		__entry->prev_state = prev_state;
@@ -126,7 +130,7 @@ TRACE_EVENT(ufshcd_clk_scaling,
 	),
 
 	TP_printk("%s: %s %s from %u to %u Hz",
-		dev_name(__entry->hba->dev), __get_str(state), __get_str(clk),
+		__get_str(dev_name), __get_str(state), __get_str(clk),
 		__entry->prev_state, __entry->curr_state)
 );
 
@@ -138,16 +142,18 @@ TRACE_EVENT(ufshcd_auto_bkops_state,
 
 	TP_STRUCT__entry(
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__string(state, state)
 	),
 
 	TP_fast_assign(
 		__entry->hba = hba;
+		__assign_str(dev_name);
 		__assign_str(state);
 	),
 
 	TP_printk("%s: auto bkops - %s",
-		dev_name(__entry->hba->dev), __get_str(state))
+		__get_str(dev_name), __get_str(state))
 );
 
 DECLARE_EVENT_CLASS(ufshcd_profiling_template,
@@ -158,6 +164,7 @@ DECLARE_EVENT_CLASS(ufshcd_profiling_template,
 
 	TP_STRUCT__entry(
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__string(profile_info, profile_info)
 		__field(s64, time_us)
 		__field(int, err)
@@ -165,13 +172,14 @@ DECLARE_EVENT_CLASS(ufshcd_profiling_template,
 
 	TP_fast_assign(
 		__entry->hba = hba;
+		__assign_str(dev_name);
 		__assign_str(profile_info);
 		__entry->time_us = time_us;
 		__entry->err = err;
 	),
 
 	TP_printk("%s: %s: took %lld usecs, err %d",
-		dev_name(__entry->hba->dev), __get_str(profile_info),
+		__get_str(dev_name), __get_str(profile_info),
 		__entry->time_us, __entry->err)
 );
 
@@ -200,6 +208,7 @@ DECLARE_EVENT_CLASS(ufshcd_template,
 		__field(s64, usecs)
 		__field(int, err)
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(int, dev_state)
 		__field(int, link_state)
 	),
@@ -208,13 +217,14 @@ DECLARE_EVENT_CLASS(ufshcd_template,
 		__entry->usecs = usecs;
 		__entry->err = err;
 		__entry->hba = hba;
+		__assign_str(dev_name);
 		__entry->dev_state = dev_state;
 		__entry->link_state = link_state;
 	),
 
 	TP_printk(
 		"%s: took %lld usecs, dev_state: %s, link_state: %s, err %d",
-		dev_name(__entry->hba->dev),
+		__get_str(dev_name),
 		__entry->usecs,
 		__print_symbolic(__entry->dev_state, UFS_PWR_MODES),
 		__print_symbolic(__entry->link_state, UFS_LINK_STATES),
@@ -279,6 +289,7 @@ TRACE_EVENT(ufshcd_command,
 	TP_STRUCT__entry(
 		__field(struct scsi_device *, sdev)
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(&sdev->sdev_dev))
 		__field(enum ufs_trace_str_t, str_t)
 		__field(unsigned int, tag)
 		__field(u32, doorbell)
@@ -291,6 +302,7 @@ TRACE_EVENT(ufshcd_command,
 	),
 
 	TP_fast_assign(
+		__assign_str(dev_name);
 		__entry->sdev = sdev;
 		__entry->hba = hba;
 		__entry->str_t = str_t;
@@ -307,7 +319,7 @@ TRACE_EVENT(ufshcd_command,
 	TP_printk(
 		"%s: %s: tag: %u, DB: 0x%x, size: %d, IS: %u, LBA: %llu, opcode: 0x%x (%s), group_id: 0x%x, hwq_id: %d",
 		show_ufs_cmd_trace_str(__entry->str_t),
-		dev_name(&__entry->sdev->sdev_dev), __entry->tag,
+		__get_str(dev_name), __entry->tag,
 		__entry->doorbell, __entry->transfer_len, __entry->intr,
 		__entry->lba, (u32)__entry->opcode, str_opcode(__entry->opcode),
 		(u32)__entry->group_id, __entry->hwq_id
@@ -322,6 +334,7 @@ TRACE_EVENT(ufshcd_uic_command,
 
 	TP_STRUCT__entry(
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(enum ufs_trace_str_t, str_t)
 		__field(u32, cmd)
 		__field(u32, arg1)
@@ -331,6 +344,7 @@ TRACE_EVENT(ufshcd_uic_command,
 
 	TP_fast_assign(
 		__entry->hba = hba;
+		__assign_str(dev_name);
 		__entry->str_t = str_t;
 		__entry->cmd = cmd;
 		__entry->arg1 = arg1;
@@ -340,7 +354,7 @@ TRACE_EVENT(ufshcd_uic_command,
 
 	TP_printk(
 		"%s: %s: cmd: 0x%x, arg1: 0x%x, arg2: 0x%x, arg3: 0x%x",
-		show_ufs_cmd_trace_str(__entry->str_t), dev_name(__entry->hba->dev),
+		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
 		__entry->cmd, __entry->arg1, __entry->arg2, __entry->arg3
 	)
 );
@@ -353,6 +367,7 @@ TRACE_EVENT(ufshcd_upiu,
 
 	TP_STRUCT__entry(
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(enum ufs_trace_str_t, str_t)
 		__array(unsigned char, hdr, 12)
 		__array(unsigned char, tsf, 16)
@@ -361,6 +376,7 @@ TRACE_EVENT(ufshcd_upiu,
 
 	TP_fast_assign(
 		__entry->hba = hba;
+		__assign_str(dev_name);
 		__entry->str_t = str_t;
 		memcpy(__entry->hdr, hdr, sizeof(__entry->hdr));
 		memcpy(__entry->tsf, tsf, sizeof(__entry->tsf));
@@ -369,7 +385,7 @@ TRACE_EVENT(ufshcd_upiu,
 
 	TP_printk(
 		"%s: %s: HDR:%s, %s:%s",
-		show_ufs_cmd_trace_str(__entry->str_t), dev_name(__entry->hba->dev),
+		show_ufs_cmd_trace_str(__entry->str_t), __get_str(dev_name),
 		__print_hex(__entry->hdr, sizeof(__entry->hdr)),
 		show_ufs_cmd_trace_tsf(__entry->tsf_t),
 		__print_hex(__entry->tsf, sizeof(__entry->tsf))
@@ -384,16 +400,18 @@ TRACE_EVENT(ufshcd_exception_event,
 
 	TP_STRUCT__entry(
 		__field(struct ufs_hba *, hba)
+		__string(dev_name, dev_name(hba->dev))
 		__field(u16, status)
 	),
 
 	TP_fast_assign(
 		__entry->hba = hba;
+		__assign_str(dev_name);
 		__entry->status = status;
 	),
 
 	TP_printk("%s: status 0x%x",
-		dev_name(__entry->hba->dev), __entry->status
+		__get_str(dev_name), __entry->status
 	)
 );
 

