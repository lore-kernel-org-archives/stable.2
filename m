Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729550;
	b=TdzCffnzwyy+9kDRM6I6mELT5BNa/PRQdl5nrvbABSs1EFekcKmxhghGfw5ZotuJqqFw
	 Wbn9n51ySqiBwU+lsyxAsWRRk7AIuPI3KWgSepN25JR6xhrB0Xa+lP2cojUvdY9/fq/Pt
	 Kujo5EmBmbuaoxd4KjqaaZF0R24HKWz52wyrxy/8zS3xQiQ89/QW0BymBym9HS7PgOJi1
	 fZSeAGhk4oopRCNmteobPLXGVDipGJHoGhxmcn1im09ogvB4b9Q+CyiU4j6dUdmlDdFdK
	 Bx6tCL/dzbb1x23Wa/nyKGgyU+0wMJHO7XKg8TRJvfA/53DXcTzu4iH7JqBruIvm5cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbnALwWQni6QwZzrT13h6XvdU083PfOU1t4S0GjBaUw=;
	b=NmAlv42eQZf+PJ31Y61YByebHSsTyEa5EtFxvL2XbivHnbOGRhXXOqMhYz7ERrOJirU8
	 pVTyWOwL1JG1zz6ibXbS3bbFOwc2jWZcn7TbN2Y/OwRz5ZrqzLH9W9jxD8QAN5QTj115j
	 lFBEww2fQTlVDgl3k8WtJKsVkrGRAvoj8W9VJ6CErpqaw6fC957VuSYFvY/LjVhFUMJA8
	 jtw3+IkiYBYaZfucFC7wxrFpqpdIoWnKbsOFTSjLx5zJJPRmbzrrENt869pgVcWkCsAw6
	 VQUZm/JMhLwsydFcee5PzjeUzvLk+RqSNUeVPnHcWpF6gDUHcehVANhS3gtyjCibHZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nvn5o3t4;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F51606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 21:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F51606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nvn5o3t4
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso54172045e9.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729548; x=1796334348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbnALwWQni6QwZzrT13h6XvdU083PfOU1t4S0GjBaUw=;
        b=Nvn5o3t4utjFHwq8P8C6aVYApdvQi/eP6pXDMwbDBFNn+Zgs+Spze6FEolyTC2A32Z
         w46FB8WOcZWJVaNrPLBu66odoBKakmSn6VG+/uO+VsppyYJU8O9cyQ8jmcSIp+bm7piE
         URb3Is1TN7AbvHT04OMQVQnQ5gV430WRjcampM7+J7jQdNV7Ufq4+jUDbR4ztiYtABZk
         S2gT+BLg97r0yPg6jKQNXzJyItAtSz3UxeyZ5CxFmA9EHnJAlsr2plu3Q4HqT5HN3HFf
         Cz/FI32hxPt106VQserQpFlOmXee2KupSO1NBxKW17hz4yt0f+BRX68pg91EWjnNhkDd
         l3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729548; x=1796334348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbnALwWQni6QwZzrT13h6XvdU083PfOU1t4S0GjBaUw=;
        b=Nxe0yeGip+MZJo4dri2t3rPpjNFI4SlwePm9w7mh9zSytoT72opuVSSrx8iidQ6BIq
         vlZ/smWbZJpbpwfoW4yG+eJPpyYfQQT1SpYgIxWwbtHw8ddMaJux+9lLQrzTgI3pAkaw
         FjnvcLG6mqadsB8LnMYmGnGRm0JH0P85Q21QB1vSgslbCXrre3V54vZMIYmAdzg4G+F6
         QfubSfHe0pZrYjUJLRUhPjjfeqiUDVMp0OFowgScKv+50yQ7u6YxUqCv2U3yCy9V4CnL
         DUMh/aeaqozhR0kNVjcxXc+11ULYIBi9kcxg+aedTnwTby0gRGWzTPOn0xI4ZcaGSiAO
         eTMA==
X-Forwarded-Encrypted: i=1; AL+hErHn1K9v2BwKenXmSl56foJn1i3+U705Od4Nlon0vKbMGPyXhoi0zeNI1rrmL96l5sjGzIbX0cE=@vger.kernel.org
X-Gm-Message-State: APuU4Z91A68ajX8LC5CkdHIdl8aoMx+JCM2P0zg0ifxCCm5fmi+2U+H+
	ZM2vp9WouAN/ODeIsEXtgXCwjur6rosTNbCumFx97tvIxYMXzEcmrFGO
X-Gm-Gg: AZFdTZcgK+gENgcRUS6vl5lZPHBFJ4bt0+vA1vzEZDIVGwpkJNrPCQZKTk9bHn0nNYG
	ckugrxDjGBoS6bJohBbRFqQtSSqlxkNexYPUjEI8FkArzLYliAGfcfVS2S0DTsVckr0MJYlWTiD
	tzrn22sjtxswIcXeppps3SUEJ7PhJwu8FTd6mYLydoERDQicqW/Qs+sUPcXebxG9Q2deueTPVzP
	Wzs8F88mfMZIT4aBBTv+soU5eK8yrfwYXp04zkoPR2ZibwmH3c1bC53NMTEjdfvvdWZFwCreQYz
	K33BAFavVpJKYTVU5BmpKjQifd3mSJDNaKYt4BOOgdmR1PJ3vBjATzWyVUUWFORyHlXl9FENv2V
	S2J5vcalNQdfcUJY+d2wM3obEehZTGj4rspMi+BpbX5L0SQytt/CczfFhDn3QACpaZ6jecD5zjM
	JZoiGiv62rxuDt05sAgrWwx+koOUxc1gsXIFYwTOQchzuNaY6YgLZs/RjCvVacHOUFsXobVe9sR
	VyEqfp80isoEjCxTIFzkZAIFSA1NASpS2mUqg1WFcHdrbNoUqBa0o2ivD1MUSjS9FEc2C0ku9GG
	Cfuncink+wnp8XFYcHKyYSguMfgGlSW/fpJaCyNPa65McufBaPPjEMtHJILLp2nrSa9AxTOoc54
	3LJeO6pqOd4YfTQ==
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr472705935e9.34.1795729547788;
        Thu, 26 Nov 2026 13:45:47 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm623698185e9.10.2026.11.26.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:45:47 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix trace_event_file leak on read-only instances
Date: Thu, 26 Nov 2026 21:45:44 +0000
Message-ID: <20261126214544.1202386-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

event_create_dir() takes a reference on the trace_event_file that is
dropped by the release callback of the "enable" eventfs entry. A
read-only (backup) instance only registers the first
NR_RO_EVENT_ENTRIES entries, so release_ei() never reaches that
callback and every trace_event_file of the instance is leaked when it
is removed.

Move the release callback to the "format" entry, which all instances
have.

Fixes: 2c79da099aac ("tracing: Make the backup instance non-reusable")
Cc: stable@vger.kernel.org # 7.1+
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7f89160aeff3..b3f63b1f86e0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3276,7 +3276,7 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
-/* The file is incremented on creation and freeing the enable file decrements it */
+/* The file is incremented on creation and freeing the event directory decrements it */
 static void event_release(const char *name, void *data)
 {
 	struct trace_event_file *file = data;
@@ -3298,6 +3298,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "format",
 			.callback	= event_callback,
+			.release	= event_release,
 		},
 #ifdef CONFIG_PERF_EVENTS
 		{
@@ -3317,7 +3318,6 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "enable",
 			.callback	= event_callback,
-			.release	= event_release,
 		},
 		{
 			.name		= "filter",
@@ -3380,7 +3380,7 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 
 	file->ei = ei;
 
-	/* Gets decremented on freeing of the "enable" file */
+	/* Gets decremented by event_release() when the ei is freed */
 	event_file_get(file);
 
 	return 0;
-- 
2.55.0

