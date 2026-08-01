Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73529BD9A
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785591415; cv=none; b=aXB+9cERFXPwaM7e9UVgaPUQRO6ojKn9UD0sti6aLy/r8hiMWMi6yL/J5JhaZHB+P8+9MZdEJ610uQRMgpPzmzSulGTQnv5Q8N6KcF4hz3WLN5SXVUCZfI0Ew5ljRTMn9kPsH/Vj3dpmsh3Fub/buI84oUjPRNiCWwErpz0YogY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785591415; c=relaxed/simple;
	bh=eB58HO5QK1YXyRAqhrYWSTOZcsExz4TPhNofK2YkZlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6YxVPiovDhnfelHYBfqsGt/o2u8yinu4jtpKTvfLFLSKA3cgZ7QcV6F++LNroTVlLAaxdu9OYcfYrNSxA/l7gJNYGpNjdbN84KgI3agaZDvZ27cZNU70Dfz8w4FTIutujtiPd+SrRDh/C8Ad8uLo0irTllnfchWwnvi459Zp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=wMxxRSrU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="wMxxRSrU"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso1391072a12.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785591412; x=1786196212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=upVI1OEGifNaxUYsdgzmCaYduKWqMNtXXmGmafq6qHQ=;
        b=wMxxRSrUV7i7niuhtw9GVWWaeqf5XQ8zbkIc2ivrl4RbUVa671eIaZyHSaO40vxlAx
         N5SMJo0jRYishPWAyA7oj1VFys0Q8DNTO4dIJAK0yyDRTIhehVMqx6nRI+RIiA8gZfL3
         4TMm5BOwRQlir45Hy/XbEQFHYRvUus5ciYZHHd4sedFO7P3J6oLmnjDENEk32Krucdgd
         n9TW9RMnc+VYSAaP9ozKlEnG4e1aZXpO6rMNxciphRQ3JPBT6fqjv7IAgpiVGBwm+N4v
         A5OvWwGspOOpinWCguBgsSwJcLf095tss6w1kb4rsxqGiYoZQQwypsEQgVdtdJDfBCdN
         Y4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785591412; x=1786196212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=upVI1OEGifNaxUYsdgzmCaYduKWqMNtXXmGmafq6qHQ=;
        b=e+DcFhdZfHEEEGHc/jznVWYyitHVdZY/H9lEfkKiNcgPkSL3Pi7ILPUuDmJ/uY9JQq
         xA+Wh2b3iIrzEX8pq+7D4HSb3OkAmwjRBg+TK3dE5QQfrTL5XuAyHYi7lWPzsl9NJPwe
         GiGHVO/QnvVdqX4bpmO8oQry9cEiSu2ZCzMavYgoCsnhgq1zcwKBPeIgKerrzoCOCvaW
         Vi66GK//VJHEsjDCjUHoEP1flqxwLOKh8z1jDgEfhJWPG8vqgfCVp+eG8yjhwbjj2tzr
         ULVSyotN7WtEDNRFX0liXWfq7sU27D1q9tlVpPQ9fThaIvdPHiY1neX8s3Qw6NH9dWJp
         wwvA==
X-Forwarded-Encrypted: i=1; AHgh+Rpa7R1kIQkh1Gq+6zC9she1WxWGRtnVEpoZp0FAUOsb4E7psfT/zg2Vu6sxiW3/2C3G2VZPXKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYx5S0VX2O3WEJV4CcV9CMHHBMxpQrN6twX+pkvXlgwEkAQ9FW
	1RAocR2bv0ml21+NHk4QvtYN/Y6hA6TGq4dq4a4IUzHBYYWoLHOeKdONPedIIB/9Z6ZRJhmJLmt
	TtNXO2cg=
X-Gm-Gg: AR+sD13nt00m8UJRnrunMSTAWwapNEyNe5QUlVVWIa9UlpCCCJSdzTJ3sZiaeYU0uNR
	YsIq3jKZlk+icoMwrNb60KTu+o8CsUPUxxp0zVfvrN2XOy72qCDpO36Jtzw8NFXDyYVQw9alQ1F
	fI5YMvTmZcuWwEftowZK0ZPc+GmZ2LmkBcdj/jBZ6R3CIK2KL5tV0UZZUW7XCe87rbleycf4m2I
	7CY3CdQY3/RkikETItUg7gqMx5VaS6IA1/9NaPWVyrIFYrcKzgV/jA+btosKXsU8pec7TPQTBmS
	iy8d2a1SoQfu4CjxkNcVIPG6k6l66WcUaimuQi1dAP2ONZIuFVwBSf48WPsvaqYCQdJZZ51RTxh
	fNA9CCQvGBa4dw0T/S393hicht1lp5YGhCQxXmh1gM1at080c0FXmyqDafQucVTb6/ObVp9NrYH
	5N41+niL6xv1tsmxMfswSp2gmX9bmxkaMvnRNXkW4XxpdPgg2/ye2HITMPCDhp2Sg1jcu7AQ1hR
	2x4/vUK7CaTn3uzYsstMw==
X-Received: by 2002:a05:6a21:6e92:b0:3c0:f772:8128 with SMTP id adf61e73a8af0-3c92a889548mr3898837637.54.1785591411530;
        Sat, 01 Aug 2026 06:36:51 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea9c50sm1697375a12.27.2026.08.01.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 06:36:51 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: lduncan@suse.com,
	cleech@redhat.com,
	michael.christie@oracle.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: libiscsi_tcp: check the data direction of a Data-In PDU
Date: Sat,  1 Aug 2026 22:36:35 +0900
Message-ID: <20260801133635.1986706-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Data-In branch of iscsi_tcp_hdr_dissect() resolves the ITT to a task
and copies the PDU's data segment into that command's scatterlist without
asking whether the command was reading. iscsi_tcp_r2t_rsp() in the same
file does ask, and rejects an R2T for a command that is not DMA_TO_DEVICE.

A target that answers a WRITE command's ITT with a Data-In therefore has
the initiator write target-supplied bytes into the pages that write was
about to send. Those are the caller's own pinned pages for an O_DIRECT
write, and page cache pages for a buffered one.

Observed against a test target that emits one 512-byte Data-In naming a
128 KB write's ITT, after the R2T for that write. With O_DIRECT the
caller's buffer ends up holding 512 bytes of the target's data while
pwrite() returns 131072. Buffered is quieter: pwrite() and fsync() both
succeed, nothing is logged, and reading those blocks back returns the
target's bytes out of the page cache without a command going on the wire.

Check the direction before using the scatterlist, the way the R2T path
already does.

Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Reproduced on v7.2-rc5 with the in-tree initiator over TCP against tgt 1.0.97
on loopback, HeaderDigest and DataDigest both None, InitialR2T=Yes,
ImmediateData=Yes, FirstBurstLength=65536, MaxXmitDataSegmentLength=8192.

A 128 KB O_DIRECT write goes out as 8192 bytes of immediate data, one R2T for
the remaining 122880 at offset 8192, and 15 Data-Out PDUs.  The test target
inserts one Data-In after that R2T: ITT of the write, DataSN 1, buffer offset
8192, 512 bytes, no S bit.  Its payload is a repeating 16-byte marker so the
extent can be measured exactly.

  arm                 caller's buffer after pwrite()      target backing store
  no injection        marker 0, non-0x5a 0 of 131072      0x5a 8192 of 8192
  injection           marker 32 at offset 8192,           marker 32,
                      non-0x5a 512 of 131072              0x5a 7680 of 8192
  injection, patched  marker 0, non-0x5a 0 of 131072      marker 0

pwrite() returns 131072 in the first two rows.  With the patch the PDU is
rejected with ISCSI_ERR_PROTO, the same return the R2T path uses for the same
kind of violation, and the write fails.  Two runs per arm; a 4 KB write and
the 128 KB write both still complete normally on the patched kernel.

The same injection against a buffered write of the same size:

  arm                 read back after fsync()          target backing store
  no injection        marker 0, non-0x5a 0 of 131072   0x5a 131072 of 131072
  injection           marker 32 at offset 8192,        marker 32, 0x5a 130560
                      non-0x5a 512 of 131072
  injection, patched  marker 0                         nothing written

pwrite() and fsync() both return success in the first two rows and nothing is
logged.  The read back uses a descriptor opened before the write and puts no
command on the wire -- bracketing it with a 512-byte O_DIRECT read at a fixed
LBA shows nothing in between on the target side -- so those bytes come out of
the page cache.  With the patch fsync() fails with EIO and the write does not
land.  Injecting at offset 126976 instead of 8192 behaves the same.

Eight runs of the injected arm at offset 8192 and six at 126976.  The read
back was corrupt in every one.

 drivers/scsi/libiscsi_tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index e90805ba868f..0283c4444cd0 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -480,6 +480,9 @@ static int iscsi_tcp_data_in(struct iscsi_conn *conn, struct iscsi_task *task)
 	int datasn = be32_to_cpu(rhdr->datasn);
 	unsigned total_in_length = task->sc->sdb.length;
 
+	if (task->sc->sc_data_direction != DMA_FROM_DEVICE)
+		return ISCSI_ERR_PROTO;
+
 	/*
 	 * lib iscsi will update this in the completion handling if there
 	 * is status.
-- 
2.43.0

