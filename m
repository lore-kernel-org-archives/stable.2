Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186818;
	b=GoEwwiJWnUhWUvwiReHDqpTYAETvMzYNzu8sj3ceFVjBQoBCKG5ts+OgjiweYGDfsWAQ
	 2cC9STDXUgSA6pmNhkqqaLe2qW0EvRKMREZCGfrwGSxkWPE4nC3KzBA1O98vgQ908RQRI
	 sAWHtCyJTruuGi4xXpGPp+U09o7GnGV3ysFCHlt9RWGiOITw5M2IH5PdvE0sko/6rSec3
	 1hANJJZXMV/GXGcoip5f+hCrwQpzhC1VqofBVZlMBOx5Y9TUJNgHGHW6aZNilTxg1Zvr6
	 4pzzdsPuOgFS0g/PI49Ta/o8nOXgolr4YAriV+At1WTVANVIevkQxkhDZCNP0J7zYNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MXzkIorMiPWbDKQso2cn/JUFxw2wDbcQUfodK2nAGqk=;
	b=zH/Ca0eZuhhSs9UPPeORT9ONgKUm6IWf+ChqWuwEwVrSHiEUa3wbLAp3BJSDrHPTw7s6
	 g0u8c2AKoXGCpheL0PwyATzfUpBn00yy1n7rMA9BMiJFxFIn4eEuiJbJ6ogk+8W9jOTk5
	 aOvsW0qWcr/IWUOyT98MJXHUoTaMhsMlxwE4iOLUL9fR+eWLwJi/013PCFpZz7bdtaAe/
	 F171R0yWpVG2OAvtpdsFuHyRZzWjcI/hpPmm17YXkq1m/bY+KHGD0U1FRGiLA9mMgfSDb
	 nsC9cwevD7J5ABm/p/Op4qRIQ6BdAcGWGm2ochrgfB+ZqZaY5nvvIoRmqK9d+u3VeOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvPDQYGO;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE660A6F52
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9AE660A6F52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bvPDQYGO
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso505062a12.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795186817; x=1795791617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXzkIorMiPWbDKQso2cn/JUFxw2wDbcQUfodK2nAGqk=;
        b=bvPDQYGO3m7LOi3EHO7lZOuAMbjv3fBu3Mq67vegX6wMPcjWbCKUkjrg+8Tj6uYcPo
         0U69a/ZNmY9xRIoeXzQrv7qTD0XN3KAVKKIOUrYcua0bt+cx0YszCzUQsAp29sfQZWWq
         KRKR6po1cVd1x/jk+/Qpy/b+AeYVZDub5szMb+KPAwT1rYhG8fACjP3Fwkz6zM5ahSAP
         SUV8U1JA8PR3YZwFLjoVxUG0PJONxOqZxdlvyEzi3s0v+i1zaTxDqz/M+AMShCkOOULY
         V5tuMGj0qcYctUnQsyc6N2iH/fBdOsrD/+LDGoFeVo3re/yMlsEWTUN3OLTgMaiwQEgX
         QfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795186817; x=1795791617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MXzkIorMiPWbDKQso2cn/JUFxw2wDbcQUfodK2nAGqk=;
        b=QnQFwcKlRh9vdy79/pphBMyPRfHUmQ7v06fhHSWiwwi6WEWSA0areEmlOlaksxpxBT
         V8PjGeFb/1/qIvDC52oekUMgg5hlcUgXy5+kG41uTLVPy/snhlkvRe3vKz7OVx4+42Km
         o4vasg6SL4ZaCIRI5tgIioy0f3kdYZ+WlNfTCGx9XOiCbbx8vTtoY3gUNKc45/DXDBmz
         zLRXaCceTMPX99AB7V/AQp4HSbv1uJOrQt9GDFucTVvlc7DeiGFAV32MLc1nCKmwUXrc
         auAKBFkXocfhuPhUpmqTJa4TrEsB2fe24h4VzN0go2cUlSq/GeiZZwUrguCrQ67dpRKv
         TSQA==
X-Forwarded-Encrypted: i=1; AL+hErH+atsHYEYAL8zUwg2GiH2HRQgx5AmaknZ1NomZs0OwScdx54E1WFbncgV9BsgNTDWKHU5yhfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Q2FOVUQpBdPAaQQ3qk/SFt/BGwSKqbXBlK7CB7ANWo9roOYZP
	Yf+Dc0xDhzqSsMA7jj3wE39VoPF0+CMhWBFX+FN8iC58LkvNa8XX1NC/
X-Gm-Gg: AZFdTZd+nYfUho6W7ME1N16cI/W09ssYR44sM/II3VpO+FXLFwV/nr+PQymZaSPcPe5
	TPFktuA/aKq0IQUEYzfRq7ZqVYIBB21Ut7bxGFjA2v+/e30GaKKhFv7Umr/XYT0JjQC8AKXgk80
	owUgPuhDd1EMap9S/ll0EUklBzODrLlalYhCAZNFLckbokvJ+AreGFGiagkIhYvAPKP9+XfkYlI
	DWDOcQHn8+8ztYgC4gL1B5Yz4fI9ZrwklwRpOHL6B6Oz3705J4eJPhaZ6df1/o12V0BpOh0Ae48
	TLdFHi1uSjWPMv6XQLgwb7l+AMklRpdYWo4muPxsFSw7Q6AAEVWBSnXEjgiHB1krUty+ji9WQvN
	NpopllGaDPK10OUsIvYPRAAdiOexyJ/+HQZwBfLmfvbLpFZiLObmVy2xmfXBpA90ei2l3oP67MK
	696gM+PZA0vikXpXRKv7KXkH+/pKK0i7SLVk8DgecFfMdVJJwZTUUz3lMmaONqRxtqeoy29TiCY
	SiLwKOAi/Mm2ZWWuCObX0koiTs+Xw/E88EV+oAf8AqiUhRp/dZPipiq02ojxE9yl5ylZl4g1v+v
	bd1jPkk9sp/MYTytK6dLyAuKGdHJ8i0Ch+0bi9fly3336hmSnczF
X-Received: by 2002:a17:902:f544:b0:2e9:4f49:111c with SMTP id d9443c01a7336-2f031fbdaddmr40856255ad.27.1795186817118;
        Fri, 20 Nov 2026 07:00:17 -0800 (PST)
Received: from ubuntu ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120282sm15213005ad.59.2026.11.20.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:00:16 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] fuse: do not schedule dentry_tree_work after fuse_dentry_tree_cleanup()
Date: Sat, 21 Nov 2026 00:00:06 +0900
Message-ID: <20261120150008.1144420-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120150008.1144420-1-ekffu200098@gmail.com>
References: <20261120150008.1144420-1-ekffu200098@gmail.com>
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

fuse_dentry_tree_cleanup() cancels dentry_tree_work at module unload.

But a sysfs write can call inval_wq_set() after that and schedule the
work again, leading to use-after-free.

So do not schedule the work in inval_wq_set() after
fuse_dentry_tree_cleanup() cancels it. Also hold kernel_param_lock()
in fuse_dentry_tree_cleanup(), because a sysfs write can call
inval_wq_set() at the same time.

Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate expired dentries")
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 fs/fuse/dir.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0d5d04df477b..04ca6c9be2bf 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -63,7 +63,10 @@ static int inval_wq_set(const char *val, const struct kernel_param *kp)
 
 	*((unsigned int *)kp->arg) = num;
 
-	/* Defer the work until fuse_dentry_tree_init() sets it up. */
+	/*
+	 * Do not touch the work before fuse_dentry_tree_init() or after
+	 * fuse_dentry_tree_cleanup().
+	 */
 	if (!inval_wq_ready)
 		return 0;
 
@@ -243,8 +246,11 @@ void fuse_dentry_tree_cleanup(void)
 {
 	int i;
 
+	kernel_param_lock(THIS_MODULE);
+	inval_wq_ready = false;
 	inval_wq = 0;
 	cancel_delayed_work_sync(&dentry_tree_work);
+	kernel_param_unlock(THIS_MODULE);
 
 	for (i = 0; i < FUSE_HASH_SIZE; i++)
 		WARN_ON_ONCE(!RB_EMPTY_ROOT(&dentry_hash[i].tree));
-- 
2.53.0

