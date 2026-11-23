Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448234;
	b=w2vM/MUWwmTrjBtGMkPaEaZCwjqJSkhJTN+rFXdNf26jxpaVkgje0gYizkLleyVUErcd
	 RuL3qHIBDgu4vQcYbb94s5eYTqReolpoHoiq5Ivz9K0FUgjNtsR358Xv1CyP8m93Dn20v
	 J/gymu26ZSTvTJp5WrCcSum0tbuJg9GNfvpNiZ2iOjT2HJ9GgQ/bkwCqct/Q4wD0VvZL7
	 S9i8cAjuM94lrW+qDuE/9yXJKAZ5Uaw64K8mueu3RV+BV9AGgBnWenwGf6shhn9QKQOQL
	 MR/Xp8ce78+BtwLt4CGdeotSgFkW1nZkounipmkO3Ri6B3SoPqt3eaAIZlDuQ5gA8Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rF0mx83XmYPM2qNwRzWvVTGOMjzCPdNgkj+Hi/DwTQk=;
	b=McO3b79HA1TWU8egnVYXcdUfM5BCGakbkIPbCm/NlqizM1J+8xH5j0YeWBRPdXYrTiQ8
	 kGPmh87ocTUAotwqUsDiBxCdFocQNTDi9m7YKQviyKgwlJJooPFOh8TT2HLLrKGVIQu4d
	 W81ET6D8JNS7FXfH54zMp8qYOkGxECrR/74hi5jLwgqLRZQ+yNtYOFfZ6Z7RV9SS34hdy
	 pT1SCQKVCRzmP0QZ5dTN3A38nhpQb7UiY7DJ7CDd5Yp5U8gtR7KS4BDJLDOZr4joOz8yV
	 SP8AQgXHdFOS0sWW8cLd/OXeKzL7KbE5iQIScrkjSrsRWchGvhI3Q7rF24s74k1t8kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttCI1wx0;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC72B606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC72B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ttCI1wx0
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b083afebe4so390868a91.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795448233; x=1796053033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rF0mx83XmYPM2qNwRzWvVTGOMjzCPdNgkj+Hi/DwTQk=;
        b=ttCI1wx0aaqMSTE1b4pbgAQXeBS6wuUkYvonNVSXOfd9WYHb5ef37UrQePoPZA6FPK
         drl15Pk9fYg5nM9vcpFPJlthr0SS7aqklu9XFZxuCvYjVoroZA9rBN9tkgo34DfWsjVm
         QDNF2SDfIbrPBnZmxSXSDm54wCfigwB2rkOoVIjzpBlnqmXLn0DnGxLCNWMpL3VhnYtO
         DFHOy6y0cV9jQ69o0jcZtQ2qeChfhsmhoigNsPMbIx1fh1icwwtkWGcRXTAa3S8zmCBy
         spJU1JSA+OTmgk87oDL4Up5uika/3Ke7F59rYaH+FvWnmCdLTwJ2GR8Zt7N5x3ex+l7N
         khBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448233; x=1796053033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rF0mx83XmYPM2qNwRzWvVTGOMjzCPdNgkj+Hi/DwTQk=;
        b=Mqb0207EkktQTj2gbw+pWKqpJkn04TPGk2jp4qjTGRbeDKiZvjPDVOJHeRDSDlEBie
         NyKqBLBGzthG4RpM+4O35A7eK/XHs+Zx1gjhivEJb6sc6EGarRTaZLaJp6qReVEW2WEh
         9eWvYmx9X3sSXUPCUzcNXBOe71Z5oTxHWErR7e0dDYEED1ShLt1Yddz6CFtZFMs+po7Q
         tCC5mNs9jKmCZz5azzE0zvok07IlJxbq8OevEMh2BGp7ElhyLApqCjK1fLjT1MbnzZCi
         OK3WMjK/A3LIt7Ijy/Nt4AgsEGLppDbqqN1FZEm2HKRhCTIWQLo9jcBIoyU+sSUxAcfZ
         0xOg==
X-Forwarded-Encrypted: i=1; AL+hErFnrtu/Qb8TjLRtVKbCeLIY1JyQyiCNegEtWRZfbJ+kWKWyT7uUNX+oRooialaMMKy9ringBb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NqvNeuK8LjD2Js22j5tEIecGyqyPbx0BL5nwgv2Wn1GQqCgyT
	yacAAfeYMKMcxhwtiBJn7KTc8IPl4s4S65dJdgo66sKKjw9igjKNZgoB
X-Gm-Gg: AZFdTZff4KMRtUIwfF8PklkM5pk4CHp/18yVqtcRfAgrRGGGCGD1H1A2pMp7dF0PxiO
	p7MdS6EYHxiBQxDEJK0UwShFw6TMlBhkvQ3Qsdp3pfX/btr0mBGSY7bMC7KB5dfE1NMaxOI4Rzn
	K0M1jkAZP8r3swiwdgSKQUCbKBFKadlxWYM4eB9U2E+UsaDSfoZUuYSzR9D4RrZVAM68iWG63M5
	/Thgzwf5Q2Lz/FPEK9i4B6e7pBHbWpBxJEHY4BMR4YLxzOlabzia9ZzGkUNe8gtxiFihWd9BE+0
	b+V34qQ9dxmNqmCC+3ZQK7Mh4bypv1d+U5gGg3WoKvjlgAfEbYtAh7GVkmMJSNie9uY9/ifu97p
	Os6wQ7sJqZHgewbSe9tI+tOKLCiUpcqP0v7MPFFbTs2Fn/Q+iUjhalq+mkFe7HqlzJZHXqD5kw7
	DQSMWfegWRlS26SmUxmBQa3wUBSlSY8IfVtlODCPTOPBQBAR/pCnP+ejQvmqFZ9NwXJXNbPFMGe
	JjEFZ4q78AdsZLEin9chtMBpvgKZ1O1Ck68A7nnYl68KbgWNzUjbR3idAUFw3UMSuNLeEC2XgGH
	C+knlXICb0G9WzmhotExHR7PxhwFixZtwtGKAP6Y
X-Received: by 2002:a17:90b:3d8d:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3b41c80b970mr17701792a91.2.1795448233074;
        Mon, 23 Nov 2026 07:37:13 -0800 (PST)
Received: from gmail.com ([36.112.205.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde797af60dsm4050341a12.29.2026.11.23.07.37.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 07:37:12 -0800 (PST)
From: Ziyu Zhang <ziyuzhang201@gmail.com>
To: ian.ray@gehealthcare.com,
	david@ixit.cz
Cc: clement.perrochaud@nxp.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ziyuzhang201@gmail.com,
	baijiaju1990@gmail.com
Subject: Re: [PATCH v2] NFC: nxp-nci: fix deadlock between firmware download and IRQ handler
Date: Mon, 23 Nov 2026 23:36:34 +0800
Message-Id: <20261123153634.66973-1-ziyuzhang201@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <b707c629-97a7-4766-955b-64a2a7626004@ixit.cz>
References: <b707c629-97a7-4766-955b-64a2a7626004@ixit.cz>
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

Hi Ian and David,

Thanks for the patch and review.

For the timeout/late-response race David pointed out, I suggest checking
info->mode at the start of nxp_nci_fw_work(), after taking info_lock.

On timeout, nxp_nci_fw_work_complete() sets the mode to NXP_NCI_MODE_COLD
and releases the firmware while the worker holds info_lock. When the
work queued by a late response runs after this cleanup, the mode check
makes it exit before accessing the released firmware data.

The diff below combines Ian's unlock/wait/relock fix with this additional
check and applies to the original code before v2.

I have not fixed the other two issues yet. I think these would be best addressed in separate
patches.

Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
---
 drivers/nfc/nxp-nci/firmware.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nfc/nxp-nci/firmware.c b/drivers/nfc/nxp-nci/firmware.c
index a953397..33193fe 100644
--- a/drivers/nfc/nxp-nci/firmware.c
+++ b/drivers/nfc/nxp-nci/firmware.c
@@ -154,8 +154,10 @@ static int nxp_nci_fw_send(struct nxp_nci_info *info)
 		if (fw_info->fw)
 			schedule_work(&fw_info->work);
 	} else {
+		mutex_unlock(&info->info_lock);
 		completion_rc = wait_for_completion_interruptible_timeout(
 			&fw_info->cmd_completion, NXP_NCI_FW_ANSWER_TIMEOUT);
+		mutex_lock(&info->info_lock);
 		if (completion_rc == 0)
 			return -ETIMEDOUT;
 	}
@@ -174,6 +176,9 @@ void nxp_nci_fw_work(struct work_struct *work)
 
 	mutex_lock(&info->info_lock);
 
+	if (info->mode != NXP_NCI_MODE_FW)
+		goto out_unlock;
+
 	r = fw_info->cmd_result;
 	if (r < 0)
 		goto exit_work;
@@ -190,6 +195,7 @@ void nxp_nci_fw_work(struct work_struct *work)
 exit_work:
 	if (r < 0 || fw_info->size == 0)
 		nxp_nci_fw_work_complete(info, r);
+out_unlock:
 	mutex_unlock(&info->info_lock);
 }
 
-- 
2.34.1

