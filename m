Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994C3D0BED
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900161; cv=none; b=hBYBBTE3hgQI0A0YE1VXt/ccytiK0gC+MOgRN9j2Q0W1l5R0lqaNZH12JvyzyBZVmF/7RXxzDRm2/YJjnxukbltuFULVaUg+UM54Vnw3VEeUUjzxktpoLH2Fr8Rw1q3hbTGZKcw3UiJx3rw8t2Yg7uL0RtUr5zYnoNxOyHiLs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900161; c=relaxed/simple;
	bh=/mEYgtD7sPEZVYSTwXebZ4dJNlAF4fUdeIQAKaL7y9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVGU0rjk2yweWH6o0XLCz7MG3FLQD/b2HYfbKz/52ockGNuou8OeotiMRhhaJqgY10Q8dpMf8BBSc3vvBeiyZN9MbkxADCC+2uZ3Ke6U+e3KlBthr2JqSsltRMsjT2rsOBFy8uwBzgGSSGk2pfdLmtgF+U+3PrBCue/fKDI4uUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=dhRNGbCW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="dhRNGbCW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8662d5e95so16859605ad.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791900160; x=1792504960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIwhV2UA408K2f7C4cB3y92uRUokSrDJADAS6XPBFwc=;
        b=dhRNGbCWtvIjfi6nLMnnC928Ij6k0Or5BOPiijpgLfyHtksIcEvISwo78VBEQSh8iF
         CTqlbyTSUNTlatgdo1lQqxo9Rlm7ZO+MCW3q7KvcNlEY2SM2iyJ79ftBIaxhXk+fJA2X
         OvCrVkONMFOK1xk3dnUbPXGn2vZWOmXPoewFzX93lLBfNj7SAj2jRaBUIdHHHOrGLJIn
         SDEc7PZE6s4t9NPOdXbDPjx0tj50fTq9SLTMGY+4u3GwATPbMSZXv6wHuCkYkHXB07Ms
         g6Ktz9VJ69eambLRpWmkdoH/FtdIzDjhZyhc6+yxYeFmJi3oPlplg3LUWl7Y0lXC5ztb
         Z6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900160; x=1792504960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JIwhV2UA408K2f7C4cB3y92uRUokSrDJADAS6XPBFwc=;
        b=Nwwpg5aJgFMzU/SVajxh77wEy6iaw6+kRbvvghpxspZnf2RpHTZf63FrawGpcPkTJo
         Q5i12ITRb2GFSUfIq5XatOyvcLqYZIdmr+vBNv59VxP1EmLwvKFFHRuqRK+DFBuBB6DJ
         8oCZckCy+XsFUjZPlWzyYLJaUe3X3Q3+b0ZlqYey6oC4kY0zvGgdBIUIBRsgDVBqmhJh
         SKkzTRi0XdImn8ifFy6ccMq7uC1+ujEh23VRQYTxdFOtt5jH02X5y2KebJ8y7w7thE8v
         TjpOzqyzJXuYs8TQHCd9VO54hMqnBYuIKuY3USxIDXzXRNm2dyMRF5JOus1ug9g51+Eb
         +Pgg==
X-Forwarded-Encrypted: i=1; AKwUvBxVY94YGCjZ1Rnaqa0Yokr5YFRt97GXXtHwysYLlIlBVUMAlWtEFfmi5OXsIKc60EQg9mmwhhA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqg6lyUARLZzR5p0+9QgD/glYH0nKjJqdeOpC48G9qPhDxcw42
	oVMBKt9CSebdJfs+MqA8F2vWSpe7J8lR6qB1LOUxq6Kdu9Xu5cFHxD4EsxCPbb8GlCk=
X-Gm-Gg: AYBFou3wavrvznxHi37vnAuX79NH+NyXWfbWXSimUGcds03vDTKAsed00mblPpvoIDc
	pVsfst3EdKYXahX/TVvUQsBuTcbI+KElS1CyLtwOvQxTv2IYYFrD6iGLd8STc37XrAjuvsgaQ3m
	ayKBjnhtdH7wzj2OLAXfcEh2MzCRkEBjo2QYYwH0JZOSowCWafCkQBo3/JmcbhrTd0XbBK2Rlt5
	NqXDBQ1IDtd8Q/qetPS/A10dX29Ok4OVTxsr9j3/WpghEot8HY+4f9xE3zm2LNyyV40hXVDgHAy
	f8+ZBtJkkxwBUvehSjUbt9jFkRDlKPBG8foWs3mJ+5LPCGhsaztCbxaMXTWinbhwnC5/StD/WqT
	UsZEjj9H8sgYPQbOIWX8zyl/Tg7bS/PjqK7KszixiGWFaLyrA2haEMIHMM8G0AV8HC75SXggIYo
	vL6Sfc4ibFhHJttH96gIHmuEW2p7PQfaiG1fLpo3INlhmBjLuIwbhH0QV0qu1xMZxsvdeMRoM7O
	8b2jea/aAZ+uFFoaQXr
X-Received: by 2002:a17:902:d2c8:b0:2e6:646:8ee5 with SMTP id d9443c01a7336-2e842cd3e90mr106695435ad.39.1791900158216;
        Tue, 13 Oct 2026 07:02:38 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a02f85sm56433065ad.10.2026.10.13.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:02:37 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 2/2] scsi: aacraid: bound the HBA sense response copy to the source buffer
Date: Tue, 13 Oct 2026 23:02:14 +0900
Message-ID: <20261013140214.3156938-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013140214.3156938-1-yhlee@isslab.korea.ac.kr>
References: <20261013140214.3156938-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hba_resp_task_complete() copies the sense data from a native HBA
response into the command's sense buffer, using a length that is only
capped at SCSI_SENSE_BUFFERSIZE (96 bytes).  The source,
err->sense_response_buf, is HBA_SENSE_DATA_LEN_MAX (32 bytes), so an
adapter that reports a larger sense_response_data_len makes the copy
read up to 64 bytes past the array and hand that memory to user space
in the sense buffer.

Cap the copy at the size of the source array.

Fixes: ab5d129f93c9 ("scsi: aacraid: Add task management functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/aacraid/aachba.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 89d8e33517584..23512648e389e 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -3579,7 +3579,7 @@ static void hba_resp_task_complete(struct aac_dev *dev,
 		int len;
 
 		len = min_t(u8, err->sense_response_data_len,
-			SCSI_SENSE_BUFFERSIZE);
+			sizeof(err->sense_response_buf));
 		if (len)
 			memcpy(scsicmd->sense_buffer,
 				err->sense_response_buf, len);
-- 
2.43.0

