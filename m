Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006376;
	b=S9T/df/kB3uJm8TtmG/nyAGEgm3wC/iPlvC4sFZMz9pmtrgyu54Vvh5t6lUcSy/DxmU6
	 8UYDN9Nn4H9o7rMuTmnqHTTzoDqIk3yL22c7S1RgeSkW4wEG3uOxW7eeBMxJiALoNYLQk
	 zhiBR4jNRpB2NemsB5ng3CTiDcXdfihQ/GHWBMRL5holxkfP48yk7xJU1MPoD0CfAh4mg
	 JpO/iZMqjjq0QhzMiCtqA1rPxrwcD1Ci51gmOWediPwC3EQEdf4pFXaFKJbfZjWvZ0lrM
	 XdJ1Z7p5lPieDjdghHW7NsrkAc/R3Ls+zLiSI+6aXvd8H0cb2NIi66Z8IxZpOrbidgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CLZdxgBTnelpDBBhYsMIenWk14F6T4PyOHqt8YvN4Vc=;
	b=V0yFilJZYNPHIuoyhVWHnHN+Na1bBQzF5iufZ1tzLmqX9O+2X8I/zIIXinKKrD2Phvh5
	 SVwyoM/QbaBpSLb+M827V6k7Nz8K9ocqYA4VY7rRziX4FkkRyhbKbS5G87M6dPbsGI6SB
	 XTatRuw8mExfyDPPDfjk6vKooOveitoQvtnvBvrsKpC0xh4KREIhFv21lMDglgTFbbCjt
	 5qzwKKe9R2DWici0AaKfWSUToid4koVunDZBI0lenIcOO7Fh8hlunEmd79o/c1JbuGPk4
	 ohEXPu8Ibk1+/RLqDpiZyp/bKBW8wOxXQFuwFxgKiTGra033oFOIJgQxMwyDc0zbPww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U6ww/R9e";
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8414606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8414606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6ww/R9e
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e46e449e8so576209f8f.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795006374; x=1795611174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CLZdxgBTnelpDBBhYsMIenWk14F6T4PyOHqt8YvN4Vc=;
        b=U6ww/R9e6dQQb/iD/muo1eBqrsB0GLByuVbcxMV2Y4Be7aAScvjZm2leuJudLrP6id
         52EIEtQD32nkMsYhonOtRI+GpGfbjCnNDaAOFKFej9Wt9ljDv26zX45TxdVQwZ+RRf11
         vufuB9JPuOUX5X+4DR41Arrg3LjOopLFZPqDDE+XFm4gL+9qmRASEE6NBdTc9ZLS6AOh
         bOxGdhGYzqUPL/41uYrpC9bcfJHQKctxASU1lUYSowt2xYiZGNO/egMqz0VNOAbGtS9z
         puRs+DyZwKeEhNyx10TIMALNPz4dtX2bge0Lqfxa01wI6s2xu9UuB4RtPAHt2OcBmQ3z
         5VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006374; x=1795611174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CLZdxgBTnelpDBBhYsMIenWk14F6T4PyOHqt8YvN4Vc=;
        b=wQ5RV/JtE6nlygbz6oMvAZ1WdQyVmC8/pQ9ihGKznMeccROGJ9qy8fFWDYgV+cy57h
         5C4Viixz/8l1znwnq69XVlxkFUWi150plfn6pcMiyOUMICQdpLGw6EXYEYA2bREP65R/
         5FJ/aG881UGrSI85BphkbM6dj7qpS9JPFx3/i0jDNySYFvogWrIDtStnkFZcDaV57dE6
         77LY8XStLPTksmNoZoU2MJcqP1egVZiZOl3k7b0sEJW0Ad8vpZqwPWasp6RoJdjNFr8i
         8JzX8v9Prti0mPMoevy28ykH7n9L9eIay4sidheguVo8ckCtDBKwzNkVvZraV7lgm4hG
         ghtQ==
X-Forwarded-Encrypted: i=1; AL+hErGCb4jvUu1ACOIMYE0VcbFq4MoD/wuQkVxOcu7x2M0oUJLAVppDM/1glPcH98F3omvH+wyVo2E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+c/AvP5flNucEcuN71mA6xeFBdQ/LySKLEgBQeuWdeKkhwPZQ
	fOGh104tupyvoKHo9Hq4H0IbQPwLeYz5Mp4hvtjecFpFprHp0O4VIDCC
X-Gm-Gg: AZFdTZedSGE+IEzzTruzldVvQ8GlCedCrot9y/6fuct2WJn2T/Ql1aLSTnYwMTusnG8
	NDaXhVO2csgCDKpGSr1FFBdhZFI9vfGxjKJCf4e8QYvqw1osRLqJ7pTp2t0gKtx8vZNmnWITsLR
	jYBql9TLKv+zakQAbg9u6PxZZ6pcoGUZ3xqbDGFzmksNiQSCi6LYd0A78GEZO8wTbMbxTdbFQ3E
	rmvIdQJysXB6Y9RR+yXcOf6GVEPABLUxb0Aaif+54UKtVUt6ovlBzjogvOOSeUg1OBNjkNnjCkI
	4yaOZQLzA8YIMzWc+OKbkeaXOBbQFEMQ8nVxziVPrmOTZHYwb82t69zQq1owPuldMgJiNWy3Gmh
	7b7J9vM9NXd+sgAUmeeBYIovPGRoPGeOSa/F423lSuvqH5uUgrw8dEljQHH7VymQnPZhYrkx6hB
	QhSYdzI5BNyEiVbCyZJcBJDZFHlhz5PWban/pjNA2bwa0D/Xu99Mm8tIMPbtSJaVyIMr3eiDawU
	2+SSJxHNU7Ied9fIK68w5ccs4bBvRAoP+4z+BrVazGTaRxfBBrkdvp08XaQHslCQShAljvBRxhS
	7x5kei5QN1eacC23Qur1gs0W3r5HdSal5V+/JdzALVL2n99xoL1VlyPsOqI/7a2M+9GmuXTkXB/
	rSwrK
X-Received: by 2002:a5d:4522:0:b0:492:7efe:3fc4 with SMTP id ffacd0b85a97d-4a6389ee17fmr3826148f8f.21.1795006374181;
        Wed, 18 Nov 2026 04:52:54 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a650d2e26csm4599043f8f.4.2026.11.18.04.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:52:53 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Steve French <smfrench@gmail.com>
Cc: linux-cifs@vger.kernel.org,
	Abdifatah Suruur <suruurism@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: reject oversized SMB1 SET_SECURITY_DESC data
Date: Wed, 18 Nov 2026 15:52:49 +0300
Message-ID: <20261118125249.25375-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
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

CIFSSMBSetCIFSACL() copies acllen bytes into the single cifs_buf_get()
request buffer at data_offset without checking that the data fits.  The
buffer is CIFSMaxBufSize + MAX_SMB2_HDR_SIZE bytes, while acllen comes
from the rewritten security descriptor produced by id_mode_to_cifs_acl().
A malicious server can return a descriptor whose rewritten ACL is larger
than the buffer, so a chmod()/chown() on a cifsacl mount over SMB1 writes
past the cifs_request object.

Reject data that cannot fit before the memcpy(), as the SMB2 path now does.

This is the legacy SMB1 counterpart of the SMB2_set_info_init() bound
check: both paths copy a rewritten security descriptor into a
cifs_buf_get() request object without a size limit.

Fixes: f5065508897a ("cifs: Retain old ACEs when converting between mode bits and ACL.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 2936b38de98f9..a5d02ed85877f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3961,6 +3961,12 @@ CIFSSMBSetCIFSACL(const unsigned int xid, struct cifs_tcon *tcon, __u16 fid,
 	data_offset = param_offset + param_count;
 	byte_count = 3 /* pad */  + param_count;
 
+	/* The single request buffer must hold the ACL after data_offset. */
+	if (acllen > CIFSMaxBufSize + MAX_SMB2_HDR_SIZE - data_offset) {
+		cifs_buf_release(pSMB);
+		return -EINVAL;
+	}
+
 	pSMB->DataCount = cpu_to_le32(data_count);
 	pSMB->TotalDataCount = pSMB->DataCount;
 	pSMB->MaxParameterCount = cpu_to_le32(4);
