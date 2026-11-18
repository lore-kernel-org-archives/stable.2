Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007994;
	b=VH02UtYt44/GT/QSpbh7LplS/G5mvwCCtXW9+wuAgyFuyBVh0FskBAu37LM84N45UjhU
	 Uck5UCWVtBNXA/DAMZyU7jcUGELok2RY0EnVIJbOAMgG/NdtPBUNorPM61lnaGXsZneJ4
	 +PvwzC0zMTu1VXz8qBSPmUspaaFtPTb0RNSlh4hMJF0E4HVifyaPFDVflb9fl6TD5sL9t
	 zUrdFK+/Xl29bG6R+NbutQSR5uGBI88r1lhgpCnuB9L8qB31XF4OoxeNXUglPacvKFmC/
	 8Osgs1EBd5Fr9wzYQ0nNHuCEiGLp/3mQ+RGKwyKi14Jqmcx8+UKjmqi1LY7+du/5iTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jewcBXyAjPJVV3XNKZQtYMrq6DypFvpPXn3B2o2g9R8=;
	b=AaWb3GYNb4B+5nM8cT/JOL7iwUwG6+VdJ464j/v2XCna3qM4DjRYcJRE4Lf8NCUxdd5d
	 vrCENJc11ufeEsk3BiJusTCBDCTcVph/bYPevSgd9oO/g/w+QCEY3HgwG0Ipcakx8Uufd
	 QP8GFKwpDJC72wJzl7PySK1atblTnwvn5onEQckPf/6zy44w56JiDGaIjgAnw04O7rzbI
	 ShxUGX/+/0SfeiCYXh6McyyLc1E6Xg4PvCcjoUiNaXcclhQXtSMKS7TQSNfVo2WwNlBYC
	 4+EXQ5BY89l71OuqY57upsNTxib8zlr1UibB0ELNFkDWl/RqVE3zPGq9INPq+gPevdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgXzjSfW;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40F606A333
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE40F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FgXzjSfW
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so14068045e9.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795007992; x=1795612792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jewcBXyAjPJVV3XNKZQtYMrq6DypFvpPXn3B2o2g9R8=;
        b=FgXzjSfW6stuhYECHvHEyTMOLp4MpLCFM5gIkQeaR/WgkMdrzPZ5SnxIDY9MvGdNoi
         WzVf2dd17jlr9mpNrbnKHBGG9aPD6bZAxgaM2/ZbTu0UGg9Wd7bFqWESfkjIC5AqMpaA
         SL15oHh+/gu8DglLuXN7aE77t3b4H3g1Ps/peRDOGdWQS72NSdxvgBod7scQPGVX1Jwe
         qvpG8VmYnPTUoY8OkLDCmgCI4Qa3WWQQOOZIoLlKPQfkgmDVoSyAEY5FiIziwRDofONR
         QS4GGecAtAJ6I/i+9S+zKtTT0nf/12qxBe0MqmvIWr5Rr8MLhXf6+gaPVcfyCRJb0LK8
         7oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795007992; x=1795612792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jewcBXyAjPJVV3XNKZQtYMrq6DypFvpPXn3B2o2g9R8=;
        b=yJ8qTEdAcVel7lfmaibR+cZwRcMiPOm6sJIxqa6CMCclXBXMuGfec1i8MF2DMtLvnC
         KfIzx40YO/jEWY7ICKxuysRoaRb3VIQ75yfo/TWY1TymIikZSYX6NEEyevxcw78t7eze
         CpalkPEuD/E3ClBXJrMqgszTeNgZ3aBs1t8/MG+Ppl+1M1slhJCrgDJTYcwqQfKPDjkF
         6nDaPrvIbAkHwh3AM9LHVQEBEyQ7J/GoEYEwbdpo1XlWbOChLxzrtQt0A/qVsE2cThOL
         am4bQyE3fzYatwhIyh4PwM1twZBkq64U/vFE6cNmnf9M1Iyk7XYI4B+Q+zM+uqhZML3X
         n+Nw==
X-Forwarded-Encrypted: i=1; AL+hErF4hD4bmlfJYMeLcRYPtW2mGGhoPSjk7I4wSbvvQNFk4yNKlITOjPM1BA9iOY34KuJZg+4y0wg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3H5Os0M5ChKMD/9kJzk20BVscz8vOjDtwIDoOllEQ4BjVOIq9
	QMCtfsV+LDue11ofRW1mVYfFaMX09tEfX1CeuG7XYg3bu5oR1sDdBVec
X-Gm-Gg: AYBFou2v5mvuNQwPy3O08rTgjeMQKDbHFh1kjyqSCsm35icI0xZKPe5kyUiex56UFrn
	nWgXdV2os3Qm7RDn1v2KpwHE/vziy4YvMUsXZUFzN5FW5zIbaDMz5zeoE73+S/Sy/V0P5dxsyAh
	CZHKCl8rY1gPFmRIkpIFmfugzdZkJtbT6Bn+HHbeK4aFJxUmnjDddKwfLEKyToH+s7ounOlZSGk
	5JNe5B6l7vZ1DZ/QB6enjMsC0eHYlVnNls7JfrVjN2ZWVBpVzZmRdReuuEXJ+i7/sz/88j7lq6Y
	nfwS29W9Ad94lVP2Fh7vWZzERnYFDs68aty6vOkua5x0Szg11BHh5uSLzBPcNqw5na18uwvqdaU
	Ge4vZCj/RgDSK7maFTjWMSc+MlOHB9wuIq+7fKmbrC5Q3U/sQe6VeL7vtw6fFGGtydYepy5+kGG
	jzSfdjCvHJaYZ+anLeNL5Tt0eOP6yzX1SFnLWLK25xnxsnkvRSes7C/xrqh6ectZrPmcCysG8Eo
	IKVqJrltApUhOvrLSfyhWGKL4pWhtXLIASdYoVm2mgtNJfpBwoFG34YEwPgiZwzrsfArkj3t5Lb
	xVBv1COtio5zZLUxAI7WY16F0FK9V3tx02u3/8O5g10QFfEOSG5aZ7r0g9UZA3UJ2YP9EEFEqT9
	Ux+p+a24XpDTONlxm/n3tpTWA1g==
X-Received: by 2002:a05:600c:a013:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4bb7d57749dmr47878945e9.0.1795007992279;
        Wed, 18 Nov 2026 05:19:52 -0800 (PST)
Received: from SurHub.localdomain ([196.188.113.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e513c28sm24342875e9.0.2026.11.18.05.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:19:51 -0800 (PST)
From: Abdifatah Suruur <suruurism@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: linux-rdma@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Abdifatah Suruur <suruurism@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] IB/hfi1: clear VM_MAYWRITE on read-only STATUS mmap
Date: Wed, 18 Nov 2026 16:19:46 +0300
Message-ID: <20261118131948.28748-1-suruurism@gmail.com>
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

hfi1_file_mmap() rejects a writable mapping of the device status page,
but leaves VM_MAYWRITE set in the VMA flags. Userspace can map the page
read-only and then upgrade it to writable with mprotect(), bypassing
the check and writing to a device-owned status page.

Clear VM_MAYWRITE on this path, as the RTAIL and SUBCTXT_EGRBUF cases in
the same function already do.

Fixes: 12220267645c ("IB/hfi: Protect against writable mmap")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 680364fda856f..779dbe32c69da 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -492,6 +492,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 			ret = -EPERM;
 			goto done;
 		}
+		flags &= ~VM_MAYWRITE;
 		memaddr = kvirt_to_phys((void *)dd->status);
 		memlen = PAGE_SIZE;
 		break;
