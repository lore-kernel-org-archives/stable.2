Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D74CE668
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361726; cv=pass; b=hvaMx0u/3/J5lbyjYfs2/OQkvxUIwps3gqeIXeJTFAmDL608RibwwsIk8YhmPyrMNbpWGAsbbIzKMnWEBrzkIR0jcnLHbMuixUttXdkHlPjD5R+g3Ayu67CvmAcGYKgYazgJdYzezVePKoNu2aoxW52sPs1KjCrUbt+3g+Oc11o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361726; c=relaxed/simple;
	bh=HS7UjO0jQ6s+qLOgaF7cYDk1QhzxkXFUd4jz+Y1RB18=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/dg9wD/9Q9Z32C/0n7zwwqWUWfsrWzlwwysd8m/79iA+5f+67RTPjL3by/H7VgHHBXzjH8hWmZN+mKdLYLpjFUw4q7NY+b5MNi3z7+ruud51A/9evOzLZS3QI5D6W+zFcqpbrCK0WfrdhBkKDoLQMOFM5lgfyXnujEkRtPGjQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4mPYDLL; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4mPYDLL"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2c570f6f36so15708266b.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361723; cv=none;
        d=google.com; s=arc-20260327;
        b=J3pyMD/IfKX1L3DBS8BllUiwX2q9vGwdEXIOsmMuFSJoQRp+pZef04ph1FKUYJ3FcG
         gr6ixYZiscG8vXnw1tx51lycVmZAUhFn7TO9/DRUPTrs0XzyhuCQMGWZrvf4ZW0X+ZfV
         JCBuHtqyxFf/XDneaquGp+dNlXYEitsWSvZb+o2oRaGXm7SGRTM5vO/V9EKjymVL0gku
         0AptVOgi/K00stPcBc+Hy7uDiMhBcV+cJ7dEsnlXFe6A07zUGQbYcyZ0J5+YCkWM3rCV
         vtkaIdLdrEpjV+GO5DITT0nhF6Bx/bDzqVPcLsIyYVjMmo2MXPxUvzD+pmHyepxYcmKj
         nQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=1PCN/eJ30EXDvqgIEVywdLTEtL09HO8pRJxVwe8r1Ec=;
        fh=pbf8ikERzmLEwjED2PjouhiF3wpV69rNIJWcIweaHPQ=;
        b=qXxj5ATxp07JVd+jSkAq7Ayx5HhChooVaH9rtCnaLF81nh4vKezvWsVIUU1sG456rD
         yo5t7btfIGqL2A/khqik1Mt1FZqxsVBehG0LT9S1K9MHadvZwPhJE6YgbTlibQKp9f2N
         gct8yewur0kKGLwK9GsKc4GOZtPQrfFyCsEpVCs8D7dlzaf0QlIpqSVDxhZThA4/twl6
         9y7OQEFj+MalTz5BMIuk+nsZ1rjYlCF6GgygzbWy+f9D+9UYt4jMyiH+tzAv5CryQ4dg
         0D0jD4SZYXr+0at5vIg9RHrxNV9PCu+lAz/2DHl3T98ODZcxReM2bzkQPSchvgP6Y2Xh
         3VtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361723; x=1790966523; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1PCN/eJ30EXDvqgIEVywdLTEtL09HO8pRJxVwe8r1Ec=;
        b=J4mPYDLLGnE9uQ0T9aObl44DmPjEjQcZ9j2RUOBjM2WRi6zwG0xI+JoDLIooAOqCGV
         evkU7ggPB5r0Bpndf4xqvyFVj9E6omxgLhZZPkW2slooTX4j0okmdZD9C2F2NgC1vCl6
         k86ys1Vl3Uxu8L7us1MbwsGNoyS6J87JdOGsfSek3Kh55j2iZdrdWno3igUO5MiX8O8p
         dR2WU38Cvx11QMsxg5hG8q1aBZqzTEJt5tBtGOgUGjhrXSCvTxhwFRBVCDZofhfRbZNF
         RxsSsK14g4kjEqRr85WWpRT0EUIiycESqWfFlXU5JXsjoZkj4QGtN6ErwBKI8vI0H5mQ
         FRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361723; x=1790966523;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1PCN/eJ30EXDvqgIEVywdLTEtL09HO8pRJxVwe8r1Ec=;
        b=wgjslNxoGvW9cuZ4L9WRY5sb7I8uUGtExvNs9nwAqbFIUEvSfXNdAbabfZhug8RQyS
         ozjECS1n9Qi939kyfNUQsF9gUQiw0uIbbgy26Ncx4xm0dfpbcNce+LIi8OY+fcHXFJOc
         IsttnErePwuFtRUsdd1ueELNOZPZgWBjk7EMj+laignuSZQaOk+IyrC0OASrDkpHYbnP
         CotFG86FBEixnzRziOxr1N5ljixLdC935ThVBAr304LEPdkbcUbEo9CiOqEsWrhWsHEI
         SuxPV9PJdneyCPNKu8yTp7Tmhr0YtYYRBBmuAwG37A9KLxEIW/7pPpn27npuFAP0h3Fj
         AzTA==
X-Forwarded-Encrypted: i=1; AKwUvBxK5sbVr3dF0vlZqeE14mk3VnEeVewVKiY0qhZr+IsCYqz1vQEUHSwbZaZmb0D9fo3hZzFiLQ0=@vger.kernel.org
X-Gm-Message-State: AFuF++m0E5c+s83Pm5j89XQcTYyDSAJfIQAoE7EEE3K14W9k9W1ab9ae
	jSoQEv/u0q/VNx/z2owcevrhgIgGiupRwvJH0KcNiK88RWnQn/LbggxRiogXSl7QjCLoZNb/Ay4
	B2und6g5ToUwxUjBNR0SKVX24iHBAaU3N
X-Gm-Gg: AYBFou32p5wYZ7/bVElX0L6tIqR0xUIeZybfroP2q49lOfk7UTFdV872jciRuC54bnb
	FqBvfEB9ra2DA9zxz/GBzQu/xM0eplKohm0+6fxKsOMTucuwcoKzcFS0OokodfdVGzTY0Itmoix
	FMdcQ0ZTja273z6pXzt8I4Qeng7Ik3En3QD+j0gH9P9K04/OUXSC4vZmxBV5w2bEz6F5ahR0153
	Vq/rZqBowJfBbXIO9PeXhauI2sZ5aKTrTb5GqXoAy0WhThmlbcDhDbr1OqEjEao4lP1n0QVA+Sz
	LD1xthzONhBCycrwfxKeiSkYDh3KRmtnZjos4rY52waNsEs0Zbw4wB2yfyzxj0KaQZUfVfXnSfG
	W+JqcniRTMh1z49PkKc8vElw0yGNzBSH76KnsSwS7+34+SRaYMkUrmesLKSsD72+2
X-Received: by 2002:a17:907:c609:10b0:c2a:f5c2:5cfb with SMTP id
 a640c23a62f3a-c2af5c26112mr141173866b.7.1790361723550; Fri, 25 Sep 2026
 11:42:03 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 18:42:02 +0000
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 13:41:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 25 Sep 2026 11:41:11 -0700
In-Reply-To: <CAGEsz8Hurq=5MJXLD5uA-+uPJdMp55auATafawac1_3mpv65PA@mail.gmail.com>
References: <CAGEsz8Hurq=5MJXLD5uA-+uPJdMp55auATafawac1_3mpv65PA@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 25 Sep 2026 18:42:02 +0000
X-Gm-Features: AclHuK93WCMThwzB62NGGPUhReh2HvWzHdMO2hPiVwHYNnR5LFZOQOgclwYoXI0
Message-ID: <CAGEsz8HdRUS+fiSq=Yp-ivN6_SiruegFc+V_AsmOxr=V+5rJpw@mail.gmail.com>
Subject: [PATCH v3 1/2] media: amphion: drain message work before releasing
 core state
To: Ming Qian <ming.qian@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>, 
	Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

vpu_core_unregister() frees core->msg_buffer before cancelling the message
workers, although core->msg_fifo still uses the buffer as its backing
storage. A queued worker can read it after it has been freed.

Drain the core and instance message work first, then release core->vpu
and the FIFO buffer. This follows the ordering in vpu_core_suspend().

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/amphion/vpu_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c
b/drivers/media/platform/amphion/vpu_core.c
index 85cc4a14f8ed..a0c58ec97a42 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -299,22 +299,23 @@ static void vpu_core_put_vpu(struct vpu_core *core)
 	core->vpu->put_vpu(core->vpu);
 }

+static void vpu_core_cancel_work(struct vpu_core *core);
+
 static int vpu_core_unregister(struct device *dev, struct vpu_core *core)
 {
 	list_del_init(&core->list);

-	vpu_core_put_vpu(core);
-	core->vpu = NULL;
-	kfree(core->msg_buffer);
-	core->msg_buffer = NULL;
-
 	if (core->workqueue) {
-		cancel_work_sync(&core->msg_work);
-		cancel_delayed_work_sync(&core->msg_delayed_work);
+		vpu_core_cancel_work(core);
 		destroy_workqueue(core->workqueue);
 		core->workqueue = NULL;
 	}

+	vpu_core_put_vpu(core);
+	core->vpu = NULL;
+	kfree(core->msg_buffer);
+	core->msg_buffer = NULL;
+
 	return 0;
 }

-- 
2.53.0
