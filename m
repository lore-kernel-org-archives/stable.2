Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025884;
	b=uWFEiJMx47Avz7nb9gM26c/oIusvhVgUqoEl/zFYjo4RxrYAxQDujp+oZrfx58yqaT8F
	 qx0YamX1hWocDnHujR3Bw94mScbjP5j/s44S74LKG3f3nOymc/QHtcgDTDZfflrBMG1Zl
	 kNcNWc+g4BGvbJlZqk2gp3I4cZgt4As9w04vYlntjmCUNUz7be1CFXZOtHFfX7gK72Gyb
	 X06ejY0qPtuPvJXgbcbNsLzw23RxCitB7akQ6nVBCpBixUgMSfv0TDNdx+yAF9etn81wq
	 QTg0eIws7gYP0Troisxx69jgMaVSglcBXb0uv8ySEFhxWn74o8uBfPhtFhJrYENzYqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0h921tV9Ds9KKioXJ9IFecI2/WeMjRPzZktFXa2aBNY=;
	b=TEi7+Ovq6wDAQTdo5q3/sCRUiVQZqu8mClPi2WETxTvEHr0+AAko2sfz748n+lthXvLM
	 C8aHZeuI4+/vV+ZkevZ55/IynOxqMRZqTS4oK8aRDvdkkMcMjPIQszR4basgr/7LaDFV9
	 d1CYh0M5cVUGjFyDh1iPB34SGHmkHpT10D9bROr+0DauTW+wA8mL5YTeecAtXSvxtuPBW
	 kG3PWPxnDI4Yc2yoMWT2skzvc6LrUUriExlGTUYYCEOipeKSJQMJM3aLAs9+40uBCRCHS
	 jHXgT3WMzOvZXom8iEYp6r802eIOsRkF35VJ1wfrWtnkbY0X+HSWvH8bQ4voj3RipTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afgtQFQ8;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819F606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 04:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6819F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=afgtQFQ8
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6f74f6b46abso604190eaf.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 20:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794025883; x=1794630683; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0h921tV9Ds9KKioXJ9IFecI2/WeMjRPzZktFXa2aBNY=;
        b=afgtQFQ8CqFm8A9ZkN2qARev23JoQK54oZ97jcMr1Uo78QBBJkeN0xAnkJ92JagxK5
         RtnuGRdwzBqzElwbLaWQcq/vj6rIICR9SjgCclhKHjZyckSODQLOCt09A6lfyeaNzqlE
         zY0lkk3fls7krEPREDmIlO9yAqzBOCgmdLZiGy6BKoc3EM+TdOTA1KkCvxbVUNMEWgFa
         r8LRl/CcXVR+ZpCuPU8qnJwdktkx2ksZQ72kgpalWIjgKKrQ6lqVqaKK33WToUAc4fYc
         9Wc6u2F8P3k/q4aP5dWKh6wFONKSINVX0Vdr6pwFuft0M6twwoN9NSCjUSCYcgG7qpfy
         mptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025883; x=1794630683;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0h921tV9Ds9KKioXJ9IFecI2/WeMjRPzZktFXa2aBNY=;
        b=uVDMMWWfB0WcYcqMHP7FmIR1q4jBnk896OIWhQyVrweIY9p1exbmGvYTW4pxrokn3H
         t0i0c8XN/3bkbAqHhNmSvIOmgzmiT09R+8m+TU96lUDGLOAVzzTtD12m2OCIHh5cnqhi
         lXJlpRJI5TSZB3mOBhfXG7KBXXPBZ/aouzXQtwl42dTyqn59KFG39sGTDdTCv456cUFs
         tFcwU8ejOa0YnFW6qSIvEHOFJuCE8EemjundbW6ImX7TVoazKrEyAjyPr/hAtB/qOYL3
         GD7VtaWdXDEY0w9nx2YYoD9t4fBQH5MlvptDDiJaViX4kZKJmsNz9vSkqd5lrPCjJokS
         yo5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxdI2Bskeij84aNicYGTyeF+F3vniA/KgbL+eikdelj3rdvQkDVETIPrfXMWkSELw82WlbbuzE=@vger.kernel.org
X-Gm-Message-State: APuU4Z94HLLy7bMOOuqdcz+jl3ACoqSUPg8QLjhF+ZuWwnUS6f5itp8C
	WBLaPFkZqO6EGaiVIJDkaIzI8ABasYQtsYAL2lbvrdqD4DXrvOQ9jPwA
X-Gm-Gg: AYBFou1Pt2yflLrY9LX9zSbbhxPyvlbTaYrB2Gd6Y9uaQN6pZI8BjYH1pmNRQR/M58h
	7j9qnceMzpdnVjLdMMY1kzERBajEWkQqczcm5W8LHcApa7CyxIXvox0gs60ywm2xxjV+lDdqbCg
	D4F2uTdRPHRC+ZnR8aBRO6T9d/m+BkqOUWmOD3IiW870G5a0z4M+8wV/0V+tPDlyutmiPIsXSBG
	EWn6ibd0P5fBBlMQycU0AQvZSctTjb+PgAnHjV5qrzpYXMXe0MvwgZVmymhsN4aI5isk8hqqKE4
	RhGNQvJNnpqifLJazZuhhS9gwaZvbyNkvGXUXPsqpDSONsDuSY3RUN62juvF+W2WNrjeqs1Vtj7
	xc80lZmggjEMOOoHdf1uDph2+YrtQKayZRPnKAwSD1tznGMfcFh68PqoY0RL5/nqQ4g9OoCcELd
	dleH1wpddtjNgo7ZWpN7PyKkPYj1aun8fqUru1iQUgQVN5KQtk0bZ7u/78doAuM722fBufqHY4j
	EZFxxAZO3XChTNXrwAlPAMh67dHYWNKtx95xQMwCf9UlzQkRWZMpu88J3HRwbHASuiJ5zWdh5Se
	36MBoMMcVaUscE0cDVShzmHnAQOyI49DXKbFOayVpzNiS1iOhFNk4JQ0iDY7/fKKxRaXO8Ruduh
	1hzhYCLZRO1dWDsDtQso1BZwMypWACemBkDqzKkcnrtb0JtEs9NG1pVDbcMsv+2/6PQ1uBJFvdM
	hJDxEmRfoa2GrXZ5OCWuhO9ZwKuf381fUeBhj+JE2p7ADK5rniuDA=
X-Received: by 2002:a05:6820:3417:10b0:713:da3b:9127 with SMTP id 006d021491bc7-716e7912499mr1864653eaf.46.1794025883255;
        Fri, 06 Nov 2026 20:31:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ad979ebbd1sm3579607fac.9.2026.11.06.20.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 20:31:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 06 Nov 2026 21:31:18 -0700
Subject: [PATCH] mtdchar: initialize MEMREAD statistics before each read
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
Message-Id: <20261106-submit-mtdchar-read-stats-v1-v1-1-173ac5c3ceb0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2X02eBaoWz+iviQtpmrsCpJHcLYv
 5u6h/twbnLPZoQ4k5hrtxmmNUt+FQV76kycsTwIclI2rnfe2t6DfMKSKyw16Z2BCRNIxSqwWsD
 pQujG0bthMKp4M035+9ff7gfr/kmxNmf7CCgEgbHEuVWqPbccq33/AejgRP2gAAAA
X-Change-ID: 20261106-submit-mtdchar-read-stats-v1-af3ea2996288
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 =?utf-8?q?Micha=C5=82_K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

mtd_read_oob() can reject an invalid OOB range before initializing
ops->stats. mtdchar_read_ioctl() nevertheless accumulates the per-read
statistics before checking the return code and copies the accumulated
values back to userspace, even when the ioctl returns an error.

Initialize the local statistics on every loop iteration so a rejected
read contributes zero counters and preserves statistics from any earlier
completed reads.

Fixes: 095bb6e44eb1 ("mtdchar: add MEMREAD ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdchar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index bf01e6ac7293..cbc7114686b9 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -750,7 +750,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 	}
 
 	while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
-		struct mtd_req_stats stats;
+		struct mtd_req_stats stats = {};
 		struct mtd_oob_ops ops = {
 			.mode = req.mode,
 			.len = min_t(size_t, req.len, datbuf_len),

---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261106-submit-mtdchar-read-stats-v1-af3ea2996288

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

