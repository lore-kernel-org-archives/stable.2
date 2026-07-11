Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C62E1F06
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782464; cv=none; b=muIXC9SHR5uQ7XWLuwsga5BjkagO5lEl/r3FRIgeMfD2YX7wjOKYSzMNrHljHXEIhjAStAZ55n+cl5pVAwY8FOLm+47ocr7MfwL9IY6G2InC7G9s3H16771vctcedgS/HSLj6EuwTK+r8ckyro4/9flsu7Y3iPqdMCPTbDyE7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782464; c=relaxed/simple;
	bh=C6OXZLDcXKYzr72BNOQU/VVln5KF7AQKUiA2CLDJY7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgebKoQ7N3IIOicZyebMr23YoYDn8p6Dc9eodz1AFZyjgQJq8qFZFvFcS5U6KSuURO5YIO5d2oaR6wKsu+VN/msxP9TCNJJQk1C9sDRu0sKeDznb0fCvKs8coh3obhdC5oBxzZozJpVFT9SAM9z0Bl5rP1gG/EVa2qQ2ay28Stk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxjhPGvs; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxjhPGvs"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e65e18969so137417385a.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782462; x=1784387262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3aoCw1gmDBSrdw433SXik9FK3EyXMsmdMSQruhZZCAY=;
        b=mxjhPGvspjA62p1syhQ0H33CzSrwuYMO4LmOjf5ksm6wYubyIQzVcRbyVzvlSgnGqW
         7Q4sHHG85U4kL1rDx8auZnDKwRXEfpS12ZcKSGKjnTCv07HGPgoXJ8Py2VnC8wo46zGW
         cunVeCKg3Qyl0spUAYbe3En8GU69bxe7/4zwryrt2dJI7pH/2lAL1rruMsaaT+Sfa58y
         6rRdrjg5zIqqGPf1Rz3YgpDkOx2t8azJA+HFd4HG+Qfdp58AQ+brW2UsagnZyGQV/zNr
         DycMef54+p4+0Uj/54v9RUN5Hs4rkWfaHrrHFrnf/21B7d6Jn+bbIK4EElb2Gahv/m+5
         XZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782462; x=1784387262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aoCw1gmDBSrdw433SXik9FK3EyXMsmdMSQruhZZCAY=;
        b=USDcu97jivU0jJqskYrd89VJsnhxTsw57VvYCXPehUtMoN5Zu7u7+UuRjQV/fyuW1a
         /cfWvkyUsiaSjg/1JnmdJ7TXcGV1V+M8Bwj+EDYS913KRJJ5eS0+qk9eLI/Sx7+HCtKS
         NEKt7YbXpiz0FHEjHQnZ7pBjbJjvEKsk7VAzxZJiSC/WJDfgfOIw+psZ2ljzqeHAj7vd
         zN+SLHavCCW7Oet6R3rvxxbXhEx4eukeJZrfkE1N/hwaFn5LBTqPZrquWVuUXNDCJgUV
         2105FWjeVdlJJEyvfAXYfcTFuTUsCliFh1f6xE7qE07IHtSoAK6cUT8OCDKFsv5zg9bc
         m1Ow==
X-Forwarded-Encrypted: i=1; AHgh+RrR/dzMbjLoj6FuTWYSZ4mzhlTO5jDQDbtdHh4eq4q63ccTNiAQllqhA8r/wFJI0vRyVnJZpyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09DNr3BuBHZpiqyLovAisQfZkQ468W5iZOqboC2BRBCbGPRfS
	Wvp0d7q0bOk0nPpjaqrJCzMIQaP+dRx2D0rQo+4G9+HuiAj833OsuntF
X-Gm-Gg: AfdE7cmQABNDvtPg7ScpgW+SsPgkwyX1MmexNwtFeUdCY+nBUVzeCgKOHojpHnsd+P0
	l8d2zu8NktgMRLi+yRBTXIJtIykxjEj9ff9w3izSq0Aj/0qnurJNG0tLw+rtb8Oqy6tidcm7pPU
	uSavdzKFpsrbgQpV+c2z5WByeVd7rypXsDe8n5pFnIz1isn65QG39Ke6/Ap4pJG1OkNCgx6G1NI
	IA6fqAlNrpnXhHreem/66wnHmGLNitpWD80I/RC5qAmyY1+FiNq9OWOPv5AnjP2w5XaWXkkPQKC
	OkGAahvmDrrIvHBJ0vQsKE8h8IjyQ0oxWRHdjFSRiQCXXarLg/dfYUQv/mOCBLdXwpZA1RCEqSA
	iBCA1rHPc7zMihS5ZdG1TrtFWGYVtE9Jt0Ur2qN+981t9JPPrR8xRks3n5DDMJNAzqABQdb5ADq
	fbytC4jP6V2NUX2f795pWIDN6TZT3cNF+QHq31DF+njCOzZRzrvX47TRhSEhTp4a5TH1ahVnBLq
	t6PvB0VIg==
X-Received: by 2002:a05:620a:4398:b0:92e:56ea:ec69 with SMTP id af79cd13be357-92ef3ed554dmr283777685a.31.1783782460256;
        Sat, 11 Jul 2026 08:07:40 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d69a78sm472464485a.44.2026.07.11.08.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:07:39 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: sd: bound the IO hints descriptor walk to the buffer
Date: Sat, 11 Jul 2026 11:07:36 -0400
Message-ID: <20260711150736.2917641-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

sd_read_io_hints() computes the end of the IO group descriptor list from
the mode-sense reply as buffer + (data.header_length + data.length),
where data.length is the device-reported mode data length. A device (or a
compromised virtio/hypervisor block backend) that reports a length larger
than the SD_BUF_SIZE buffer scsi_mode_sense() actually filled makes the
subsequent "for (desc = start; desc < end; desc++)" loop read past the
buffer.

Impact: a malicious or malfunctioning SCSI/SATA device, or a compromised
hypervisor block backend, drives an out-of-bounds read of the mode-sense
buffer (KASAN) while parsing permanent-stream IO hints at attach time.

Clamp the descriptor region to SD_BUF_SIZE before deriving the end
pointer.

Fixes: 4f53138fffc2 ("scsi: sd: Translate data lifetime information")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/scsi/sd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 599e75f333343..eec383cbc39f1 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3304,6 +3304,7 @@ static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
 	struct scsi_sense_hdr sshdr;
 	struct scsi_mode_data data;
 	int res;
+	u32 len;
 
 	if (sdp->sdev_bflags & BLIST_SKIP_IO_HINTS)
 		return;
@@ -3313,9 +3314,17 @@ static void sd_read_io_hints(struct scsi_disk *sdkp, unsigned char *buffer)
 			      sdkp->max_retries, &data, &sshdr);
 	if (res < 0)
 		return;
+	/*
+	 * The device-reported mode data length can exceed the buffer that
+	 * was actually transferred; clamp it so the descriptor walk stays
+	 * within buffer[SD_BUF_SIZE].
+	 */
+	if (data.length > SD_BUF_SIZE - data.header_length)
+		len = SD_BUF_SIZE;
+	else
+		len = data.header_length + data.length;
 	start = (void *)buffer + data.header_length + 16;
-	end = (void *)buffer + ALIGN_DOWN(data.header_length + data.length,
-					  sizeof(*end));
+	end = (void *)buffer + ALIGN_DOWN(len, sizeof(*end));
 	/*
 	 * From "SBC-5 Constrained Streams with Data Lifetimes": Device severs
 	 * should assign the lowest numbered stream identifiers to permanent
-- 
2.53.0

