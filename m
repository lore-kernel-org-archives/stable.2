Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187771;
	b=ydukeNlAG3B3rAQA2Q6QfYw8YbgMeuPsGaQS9eUWGl+Zv+XIKqXQy/2gVrsFQoz/5XQt
	 4IgY9K5nsHmDG4j9D+bb/MHx6FxCXD2o+wc4EAFvaX7aSUN7BfVE1QlcyuSWzuMwJ7zD4
	 z31a36ZQp1ykw8dqK8PBZIXe1jl6nOx0jOwaPy2P8/ho9sVFGSaX57zWAWICiqY5Gvkkf
	 gfnueGs78QLcDUnNYn2nXQJEtwbfi/w00OGNZKbysS3N35VYlisfT5lVR4qlejy6k613b
	 pWhFUf5FgA3vxFkN0GStmcipUE84WtJxx2Pjk1NsYrEg7XA9J6bBs9xxWE9WUWPyIHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vwaqv0RwpQdofsLvckQnMd1MHOnW+8febEpuFJFq6Z0=;
	b=YAA0RmyE80ODBzvDb9Byt6dKs8NB279O1tSPJuQ7GRGP3RuES5rv0IbryzU6rJxf5Hno
	 0qVz4U2ohSH9JW3I1/ZpM7ptmb2Z8Qx+dJujvrqCniECjY9Pl9id9EQ4cY976Bxz6OmJo
	 pFXYF8tz5b4KxhrsJeocb4ubUctkTvmGLy549ptCLNHJ7XK0MgEClTHSsHslxg3Wphico
	 j6G3ndCFjUTQM8Nt7SIidZRQMVmVKOsCBIkH5Y15D7XG+wWJdYZXoOEl39MyqiDxp507U
	 A7tpbBnSLLtZfzWpbkpu+W8A1h+U9sZPosF+D95LXgblqlXv3Ou3NuzTs13TvInZ1xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xrOgFll0;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58443606CCFC
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58443606CCFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xrOgFll0
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b190cdc9feso201710b6e.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 17:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794187770; x=1794792570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwaqv0RwpQdofsLvckQnMd1MHOnW+8febEpuFJFq6Z0=;
        b=xrOgFll0qEqVePCZJdJngiYJHQMhBeUhj/zyRfNtgWtx1QaTzb0tUCo978ZZORSWDw
         qjOIsad0WHYh1iVH53CXWvNObodiQUidTSeL7BHEWwyybYK+fktaxGO3fMwdXIrX89sg
         26EUNF30nH5yJwvvBqLFy/xe9OdK3wpRvT5sgxkXTMbODDZl0vt6uqQ+a/l2d9bwGMlW
         AeKcBAWyG7yzLIAhrYWHAw6UC5EzLk+8lA0F5te9L0zFLbzk0wNXk45M179Af+6i5lxw
         9fVmYmPMvpUJatJb1WXMOSJkqTeFldNU/Sl027w1R7Xr1rFFNJvlrQwEPhfKckjou3Gi
         yJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187770; x=1794792570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwaqv0RwpQdofsLvckQnMd1MHOnW+8febEpuFJFq6Z0=;
        b=AXDgcLkNjmpoqxGPWdigaqvdy0tFbI03c0yVIVX6AFB7PTt9HF8mogCjZPsdWLcAsP
         W03Bo7OTEh34XeVSb2WEU2PiugaU2SQef/YAHHjcdGQ5Y5JSlaO8rcjC9H96nYsO80vJ
         3m6BomYt1hyrS79d0xi0+TuGy2UX0AKBD82b6E1yi01ClXWit57G0wIBMdkKzuRXSsPB
         eQ1KBH5JiFUYB2vejF65frgsz/WPvVPTXTGgGieyrtMWnLOMZ9vccvjdLNxqBFZlMfxt
         a8a0QkWh8qHto4nE5uaFnH3yVzV1iKJoMKQUD3P8zvOe0V5o1ADMXZZdZelnbhquyw7X
         W28g==
X-Forwarded-Encrypted: i=1; AL+hErHnKuP5FXFZAa+Ead7rcfGg1SKT5NGAPE4sP2K/PKsRD6cTcireJAJnQOn7uSB2cU4nSmg+MHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xpPAaEJFxoEagzWABwdFnkxvm8smE7iuRpkNBpTZlnVt1rwE5
	WHh9KiuQAvn2BkMiThbAIR+Di2cS0Co2z4+Z0uS+LYjd/PxQ7Y/jShwrun69zA==
X-Gm-Gg: AYBFou3aKT+8LRmxW9ZeNpGKrhesMbW1Iyg5oZgnK343SChGaBr6GgdXQXhEscSBbWx
	2eS5hsTQ/aajM5lywiKmfO4ZgrA/7/hFhi3gvKZ9U2pABYZ7LgDWa4HrhMYxBBx18p+vpAlthGj
	Gq4LuhHIWiHRnI3s9MiVJQu9SWWZ+NKyeA56SyKypRSGbseoNAtUwlskhxFGXkF1qT/7wqhLv/d
	dpTWFhDdwP2COg1dwQkOzIHDklbKLIO2XGhPMTskGlXIS9FnirxxtJ9WVi4XAZPHi+l2Z5WEBTP
	FbH+5tUYGHnm6XAe6EhN1yjx407WfC/wDogD35B+tstJTGhW+ZknTDZnhbONP0KeRhXCZqsYq73
	MtK9i17IQ9hUj8RcX0RH0z8KlU3+5tkbV1xMqKpeeMJZuxvDj7lsgchLYVybG5KEw8NWx9RWjRl
	SxSA8Q7tKgjE9o8zZEnEYfLxb3vfozI3Ux+L2jB3ARuvd+jvAwNH0YSKHI6gNtGNl1HnySw1TRM
	eyeGnIp0ljop/ziI4KbvMUmZq4w2zhyNQ6TPFQSSHrfvW+aKmXSa6W2yE0e5secu52SdgvSeiGb
	1VTossl0W4E2EiuiyRDO54pKmy2XxTRxzutZ6xI5hBSKy25jYwbZBxzydXn8mvYYdTvp1p/vD7j
	Xqnf62Of8vDYLlcr7KTuzTcVhpMYuBmd40eoD7dK8z+s5k1HIFUtffSHpYp6JGT8M0nMT3XcfVG
	QcOd8Mj7pdgLTHMLLBFiunmX3fvdqBAIHiEBjs3+qg4znBHJNBFe7q
X-Received: by 2002:a05:6808:191f:b0:561:fa43:1b17 with SMTP id 5614622812f47-5681460726amr2343413b6e.42.1794187770252;
        Sun, 08 Nov 2026 17:29:30 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade695a5a6sm4225818fac.10.2026.11.08.17.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:29:29 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 18:29:22 -0700
Subject: [PATCH 3/4] mtd: rawnand: r852: use the standard OOB write
 operation
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-r852-smartmedia-attach-v1-v1-3-56d08c0571a2@gmail.com>
References: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
In-Reply-To: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

r852 uses interleaved ECC placement to transfer a complete 512-byte sector
and its 16-byte spare area through the hardware ECC engine. It supplies a
custom OOB reader but leaves the OOB writer unset, so the NAND core selects
nand_write_oob_syndrome().

With one ECC step and no prepad or postpad, that writer starts programming
at steps * (size + bytes), or byte 528. The subsequent 16-byte transfer
starts beyond the spare area instead of writing bytes 512-527. Raw OOB
writes inherit the same callback.

Set write_oob to nand_write_oob_std(), which writes the spare area starting
at the page's data size. Keep the interleaved page callbacks for full-page
ECC transfers.

Fixes: 67e054e91924 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/r852.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..e78606b97b42 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -833,6 +833,7 @@ static int r852_attach_chip(struct nand_chip *chip)
 
 	/* TODO: hack */
 	chip->ecc.read_oob = r852_read_oob;
+	chip->ecc.write_oob = nand_write_oob_std;
 
 	return 0;
 }

-- 
2.53.0

