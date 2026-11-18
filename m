Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795001076;
	b=PyMvup60yLSHtICz7cmvMLr6t6OjUrFNyzH9tnaw8xSWUqzzpONaZbVDvt7oakXe5Fgs
	 BmmZfJzoDDRotJboTRtrwM/LsK+dmrScawiM/AjHkz2nyAcVVw1Ga0fOKFT7b4QrA0ZYg
	 nU4glb68Rc6wjgzIXgYyVsCX7W9njF+Yj2gBvcByP4p1U7oE+hUiq9uhCOu/3ZsK4ShXf
	 OKwfbQqQPEcUUorV7bU6sysvraN2oIELSEo9bW2NeuOQ+wN/36EfDfet50MKXwLgQCm3w
	 OWh5EUhLQmxjB6HjG2Mrsle/IKLp1vs6U0E7G4AYqKG12/7z6Kls20JuXhliaS7+7+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795001076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
	b=0IovDonb9uqzseLGNaOabDXfZayrKNZshsBEcNmLgkmtgNiDHCLxDygJ39OKYuIn9SUX
	 hAzOzaehnzFudpo/cf+nscJlYLm7sLTUYxKb/4YXob37Ek2TfpHZGsj0duol8FvLSzFNj
	 5KLmZ0tBWila3ujccO6U5wEmzGZb3OR8cY9PtKLcdF9InQk1rj9mE/PEzaxQ9QOi3VNZi
	 kxCEFaVw+Eh1HmiO1/uBreHgcOEumZr9dKaLnTe5I0cHVODk56m+gYaFtX8BKUvA2Nt88
	 cJoM+bTXYwh12jEUuYevV3D+KTUhwM7p/kY/NCB21IfaG25zYPvTTjlP5EbMKzyrEWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twWyIZ55;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ABB606A339
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61ABB606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twWyIZ55
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso437793a91.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795001076; x=1795605876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
        b=twWyIZ559njProg2yWQj/3Vnd7aqnM2sEXWgZyP1xXIqbTU31t8H7KzEvl28llhVKc
         ZFa7PVyLz1MXv5/5aGiqXyGo4cRMUZWeNXl/0rbfp06StiW2GeeNOLz2visK6L3oFktZ
         y5nGEPhOWPDIosfB1XftFmA+9BGwMwQOxh9p9jUfb6D6esytjhvblQx1Z4Q4L2huomFn
         bf5kfH0bb8rwnnRn192bXYWHfwwoXX7OnlQkui+GxuThTd9Ph4NnmcUhjN5kIcWs3yKQ
         Q5BokV3DTjDsk1XVrA4LcbNI5jzmrAsgsaz06u0XONnfABazZhKRXRstyoGrJn58XhIp
         MsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795001076; x=1795605876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTu2kT6vY540i2vTNL/lOCMqwCzR7YfsabNtoI8JhQ4=;
        b=YqlE/vmKhREkhq1p283WIz38ZDmXydKb5m1mfz7ksmU13pGMxbwn2P23fa/IbrtV0r
         Uw64zq60+pJBYw0wc2rmdFf7oA1AOpkc/Th8i18dLDKAWX0kYBIm9eqcnFYdGU6mPErG
         0plUqS4UvZon5keTE9ITarEbsykPoNEkO1LhXlyNJBi0PSe/aNAJI8ITDOFLZfZp1I5Z
         1d5/xlQAwQcSBlINTNBfWOkOIYBvURhy6GBguwEDKx7GAXXko8iXfQqQNVLqhpWhtPOe
         4mJWFZHOdmQ3F7I+CI9I79bQ0rJPCnagFIcxE7y1AwiixAD9P0XbxNn9pYrT3e8gXw72
         GQRQ==
X-Forwarded-Encrypted: i=1; AL+hErE3F04rmP9HDn1MSNeKcXzWaoe98xU4Lgh26dFGkYhurey1jTVzzN3j+TUZf08ivbow5tx6cC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Tyatqd4G1Jrrm3uUKO3vEMaipaaBvqq5ONj59PwOgUgyfOfgb
	GLsfYul+ufgfDJkROr8iMTMfWbZ3t7VMCeK5y7SWGlKYVXGS1btNPE2b
X-Gm-Gg: AZFdTZfAqKgClCKPDfZzruQORPlxSJzf6bW4GKzc8j636ZNvrLTXAiftVSpjT6Fv2c/
	yhwhjverZAqB3/cstpzpQ76/3lyZ/XBW2Fy0p68N0w5gimVbWwZZhg9Cu7qKUuW+MMF8MBDB3Wg
	84EnQWBCzBunPC50q2gz1Lyfprr+iN2eEIYUZWngiBHdsF+ju19eUcYF3HEx48piZ3D3rlk0kF2
	OvAwFvQunocXQhMi2re/dqqlDX4slO7+gNi/gzYYAJZ+gDiVBY7ZlLHxVjyY6+6WqcS/JDOFUNC
	5wxgM4pHciu/s9Cci6g2DOaLe38b+RUsHbVMHObd18IEndgt4pGZ++X9fSUP0i4c1KPvt/PvfEN
	4PFlV8+VQojU+Zts1vq0VcBgzIDhOvVz6Z62evtvOedye+ATvqv0zvgbjKK4XnYVdnqjvVzak83
	+J2vms8dVpH/fXIF9KKLWjmU7Lz02BmxH4eyrHpr7s2xRWS+Ltbf2REuyRxvk5ArRXhsNlhM0Vx
	fav4C66Z33HWKVnMhuPDfTLGsOnGMll7EsS5/oM6MH+zfs/bH/4DtSkLe2ISy0MEGcVhRjtulsd
	qKGHND3laM+Dfndtv/e6kdgSQjSxq3FhZjkmzVsLhGl+6pb/KQ==
X-Received: by 2002:a17:90b:4d04:b0:3ac:8af9:4a77 with SMTP id 98e67ed59e1d1-3b3d07597a9mr1914378a91.10.1795001075580;
        Wed, 18 Nov 2026 03:24:35 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62842b6sm11510395ad.60.2026.11.18.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:24:35 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] tpm: ibmvtpm: don't call tpm_ibmvtpm_resume() under rtce_lock
Date: Wed, 18 Nov 2026 20:24:18 +0900
Message-ID: <20261118112418.1009785-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

tpm_ibmvtpm_send() holds rtce_lock (a spinlock) and, when the hypervisor
call returns H_CLOSED after a Live Partition Migration, calls
tpm_ibmvtpm_resume() to re-enable the CRQ before retrying.
tpm_ibmvtpm_resume() sleeps (msleep()), so calling it under the spinlock
sleeps in atomic context.

The in-flight command is already serialized by tpm_processing_cmd (other
senders wait on ibmvtpm->wq), so the rtce buffer stays valid without the
lock. Drop rtce_lock around the resume and retry.

Fixes: eba5cf3dcb84 ("tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..e06c4db2e138 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -247,7 +247,14 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
 		 * ibmvtpm_send_crq() once before failing.
 		 */
 		if (rc == H_CLOSED && retry) {
+			/*
+			 * tpm_ibmvtpm_resume() re-enables the CRQ and sleeps,
+			 * so it must not run under rtce_lock. The in-flight
+			 * command is already protected by tpm_processing_cmd.
+			 */
+			spin_unlock(&ibmvtpm->rtce_lock);
 			tpm_ibmvtpm_resume(ibmvtpm->dev);
+			spin_lock(&ibmvtpm->rtce_lock);
 			retry = false;
 			goto again;
 		}
-- 
2.43.0

