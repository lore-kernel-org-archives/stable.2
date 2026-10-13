Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7751A722
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908199; cv=none; b=lmGg+QiCBVFnDgVh860ymEyrQyQpzK4wrOgzhwMlacX9sxh0k9I9J0l7O4kvlRBIzB7nqgGgXsA28O4M4hMn0Eb7wS/k1nNqLJdFAIVpX5zcjuEzJO5dSPB/nlbkl7oaYb4i0UKa7Q3uTDUOKYmQxYyQuAbf4vRZuQ9fUq+238M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908199; c=relaxed/simple;
	bh=6BMwdsi3ofoz+bipxdz7wykMCA0g4jyIQITHzdnkJnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbvMIBzzfZp0PuwoNxiUU15gs62Cbhnz8KKdDVaW0i4ALLbq3PbubbdawvNXb28fPeOzoLQKJZT484BdquxtH/JlxQQga9n2UFogkdrhqYFEUy946asR3aim9C3UUk+V2jTd88x0/y4xizOq6HgVtbOvd1/a9+9/UR+NWTs2L5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=0sRYIJZa; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="0sRYIJZa"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so2533973a91.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791908197; x=1792512997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9zJQoLv8Tql7NoNqNEI0i7VSFA1eBmo00WB94NShbc=;
        b=0sRYIJZatomYPwE/grE+dLyVKAxYVoaUDKB99Xu146rYXicczXjFNmuX6PHlTkYiFj
         e76t29qmsuxGqoht8KVk1tl8DoW8JN5lzqSQ/hyySH2V2dFN+XTa/uxgvt/zOfFRbbli
         Y+c9GDB4j0h4Ew+5/4ot/Wf6tB2R0A25Xy5AFjQ1RnVDH31wt0YDuAuH4O5+jFrYndra
         XWjjWDFJp6FRwihmBOtIUTX0anWoxssB4aVaMOKDFbiXL2q30M67KbGgScQk+a9ZkBl5
         duL0f8Ba3n54ZZ5zt/tEPubzCtYJ02MRwjpRIRGw3BoRkuuZ3cRtwVWpdU1PfU8RGWsn
         HyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908197; x=1792512997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K9zJQoLv8Tql7NoNqNEI0i7VSFA1eBmo00WB94NShbc=;
        b=Dsg5GDCE4D9nOq02bvh3VU/rwPU+Zm5dda0qEcBlHSNR/A+j/dvjmI/8L5/j9yxPyw
         FEcrxigo00ro5DWn4XfvpTsczQXMfAvfxsUA+9ICpY1w3Ylc9lKnTMs/6QeKMtgN3Cd+
         DJC6AVCTpKrK3hDjkYxR0X+F1gSAbC2nmpA3TTiB2KflosRpnT3/l3V6Diz/ZYGzpFS0
         io+5ePjNnU+Yy3eaS9NAD+IPYwED0qoqvXrMfUxsiuBWmRxUuXgdKEiin8Y7UV1l+CSA
         l72D0DjMlQk++at9xQ28dPTMQ9BXNfbOXpI4bT2mRgedGVxNNxoCsWB3EWCUAIP1ILNf
         8qYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlp4S5AV6ZpnQFVuKzQrlUxNOB8QzWG+MmSCmkPlExLrHbobdjInjQp5jpfMPmnpYxzWZS5EA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTXDu9J/DrO7Wbq3ALLE9YS+JNC69Q/msbeM8X2t4fsCZALYny
	GdZWYvdfvOqLJNoWKHO6rl6Rxkrw+RTKPCj2ruBI1ZbHPER40OAemsx8ackQmJaaswds3e4wBzZ
	mQvlU
X-Gm-Gg: AYBFou0eiQf+ZVmXQ9G0LfaNJZXqtj8IdBEsFYJ9+Ozp01QF1Vof+r9ffle4w1ZXlnq
	qtVbKV2QSBu/AA0OZwvU1e676+BG3hfWc9kPOU480phLRFvXQeB9lgrWnBQSE3grRW7CKVjLRrh
	YPNb/1dOI5mke+tuYHI935V0A0u/g4h+fNZDSTHPpgIVA3/L469UT7mu0xEjjzTJXOssPfwb8xm
	9R6Q+ixucyWE/zLLVb1fDFHm8OzzJz/vAV8BE8pqjr7/siRJ/iTRVtTRGwzHwZOXqiLluUHkc3e
	67Qnt8ZsZSK1IkRborwDylBpLYETakGDcmaBcoXOy2tbO6J66x0hogzAwPEMidrVA6+ZHxYfvXz
	Co/UsEyB3Jma2ZafaaSI8zCZw/ZxAThLcmJJ+d/9/y+xywPPN+excbUHzrMAN3gJH6ajEojDqbk
	40y/JT74U0jIOifW+YQpPX9sZn0misYljV14wCmPp0+7L+0G7L7mBIv7tcIHC/eHfL+kn9XdfyV
	JAlGvi+7JU9GUhuFDK2wesa4BAD7wM=
X-Received: by 2002:a17:90a:d446:b0:3a0:5413:49b4 with SMTP id 98e67ed59e1d1-3ab3a9fa33fmr9197790a91.39.1791908197099;
        Tue, 13 Oct 2026 09:16:37 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac600642c5sm202607a91.5.2026.10.13.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:16:36 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 2/2] scsi: mvumi: reject an out-of-range handshake frame length
Date: Wed, 14 Oct 2026 01:16:20 +0900
Message-ID: <20261013161620.3210533-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013161620.3210533-1-yhlee@isslab.korea.ac.kr>
References: <20261013161620.3210533-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_hs_process_page() checksums and parses a handshake page using
frame_length from the page header, a u16 the firmware fills in, without
checking it against the HSP_MAX_SIZE buffer the page lives in.
mvumi_calculate_checksum() then walks frame_length bytes of frame_content
with an unsigned char loop counter, so a frame_length of 256 or more never
terminates and the probe path hangs; values between the buffer size and
255 read past the page.

Reject a frame_length that does not fit the handshake buffer before using
it.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 38a92f8c25f5b..e85400291a141 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -1040,6 +1040,13 @@ static int mvumi_hs_process_page(struct mvumi_hba *mhba,
 	struct mvumi_hs_page1 *hs_page1;
 	unsigned char page_checksum;
 
+	if (hs_header->frame_length >
+	    HSP_MAX_SIZE - sizeof(struct mvumi_hs_header)) {
+		dev_err(&mhba->pdev->dev, "invalid handshake frame length %d\n",
+			hs_header->frame_length);
+		return -1;
+	}
+
 	page_checksum = mvumi_calculate_checksum(hs_header,
 						hs_header->frame_length);
 	if (page_checksum != hs_header->checksum) {
-- 
2.43.0

