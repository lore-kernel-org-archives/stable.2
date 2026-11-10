Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285008;
	b=ciAuTBNXHBcoeO2FKlWQOFj1hh8HYoipvolA61SeKcoL5mu/0XuWlAzDkGwzKAImtfCz
	 UQAHSbcaWPuJTElJlxjipR4wgadw00+BOnPTWKZKhe6fYLmNroDAvnYHDRYykx5CN/QzR
	 SbCew+7QI54aXy1xog64kKLDSB9lH+98shEQLOWKDJQxXwZ5/V77TfO9HG/Dk5txVLQYa
	 cbPxwv6xqjPZ01J5cWCt/jbht9B/HhdEL21j2EDH8wBdvXJfVvbb5J0Nken3jySX4hecn
	 nMLyfeQlwVQrraVlS/zFIe9RhctRuGToAMpApISwXqm5XIMcOlklZDkBf2Gwng9xTYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Q+FU7s/IaJwwuXx/A4tn6m950pvjid5cEZuWPY05gI=;
	b=m7bNqfSPl7H4GfypOy9HMuSMqkkxYiDeFK9wMhpYt/Z8CG1gbs09mh8BaU3XhwkCauPD
	 ERRhFY7OMNjV8wHrYFXWHXvFQ18miWGG82lF9SpY4nn6rac3P8MpOSI0vADz4HND6+pjs
	 RuxgmdI3U/U+NupTFNAT7b8fiq1ip291yWQV1w0WeoSZ1hsQUg3890HwgQgy65vJAZTT7
	 jLp5pzyBw+uKZPXHTc7UqK66YgQ32WJ2//XhIuBGJo4kymwx5qACRckWDnyBDtrB7r5Aj
	 eoOGNW0tixhSXgJgR4vpFBpf1z89UBOv/N1dB1EFZNd244BAT0RlsRD33zrihV5GFZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkIVBLFq;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A8606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 212A8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jkIVBLFq
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9440304604aso169040885a.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285006; x=1794889806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Q+FU7s/IaJwwuXx/A4tn6m950pvjid5cEZuWPY05gI=;
        b=jkIVBLFqe5Sc3FAZ9m+7h4t+IofeIHaG07XpOaNxAqdjuLCAnUA4RqoMBjyh3OXhET
         yE/sfvbgZ+psllN1gD0q+FuE4RFp+70aXrvIaEjTNnLwCyyWWrYj75z/95ZUJ3KlvuB8
         +6Zj1pz+FqjsmbvFrVCpMmCJBJyShREnZgGNoLscI9uyBUPmPlET12QXoXogifr9GXOJ
         7xUVHLv8Nd8swOP9U18GiXhEyqkrD9p0924q1ysJQEO7OevgnZbHRNFA/FqYRFuTFMlC
         zD3qFgGIO0ve1+d2twoUYgM4T6mt/NdA9yYgCywBjft/T6ZUeWTApPY8/0eFF5fAss/P
         572Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285006; x=1794889806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Q+FU7s/IaJwwuXx/A4tn6m950pvjid5cEZuWPY05gI=;
        b=CG592GXPczfW6sKZAt6/y8kWRLgYMEnVhhIheQqrzb/0Z80YAFkG5zSjIa4NMN3DMd
         pu2B1A/dWr0lh1kZ5os6w/UH15pt94kGqbb8X/j257xvuQa9EN0bHZaGV4E9k2Bn1zJ4
         fQUSr8MqoDptZneCuPpOU6O1+U8KeXliun+HqiaCo41pEzTcgERxo8NksbNp+wqQuLuw
         9VrHtocMZ8w/08QpFkLEP8VUrQ6ORbeMN8sl/lLUZIrbHrZa6o9anSGuLwLzUHOWiEfZ
         EHsHb0cMPh3JLa9FgSQ7pRivo2kgFdZmR4ffuju2Ef7fuy4D+5BOb0DKXO6vHCzR8sMv
         Cx6g==
X-Forwarded-Encrypted: i=1; AL+hErEWAG3pcwgUGIkQy8Nttgb1dkeTp8yKifv4iwSLWpbVnDxUpfizj6kzQyiCQpQ2B+ZUUnWL6F0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AqpnXtTJK4uRjRlaZ9HLWLo1lYRYEQZGw/KTGlC6ySsjzHNBo
	e59AGcpf2zG9Y7jp+fys0o1fktfsN3+kAFZdHgwuos1O7vVWXJeHnbI=
X-Gm-Gg: AYBFou02wfue55HJmB8D4xmQb5E8+/UjLKG91XyXT46TC8GMadvgm48wVLtXX2khz1L
	QgiCnXuKukSg4VF9B3Y6iRpdlCLbwmP5baW8DvRAmNyXcYeDGgBERuBJ09Z5C+hjg5f+YKRDbz3
	Bvmq13RYP3mufBLJKhbNgc5XYHV/e8u4PGpNZhuBb2kLxuV4zCjxxsZ5ZfbRw8U5xfOz+YiVnbN
	Z3Y+gL7jrHOWWrjpTPz58qAmQvUuTsbrJWlkJVJxGJIuyIHswW+J+ivXeUXB7jQb9mS1stVFlUI
	duM05ffzhc0IvXQ3evjB9Wsj/+j1Tv2M7jcUIi2ZGmFOEotNrAcFPcev+wzFSaicaKN8xvMHEZ5
	OteTUStCIRvhpxGxAaeBp+O8j3wBZcSQU4c7JlGdmovzdEZBMHX9juQa80BBrme/WXzLRkHjAmu
	lDy1T5ZRYbXmAwJ3UQdXeM5MHDCz0jFrzQrXYEev9Q1JUcsol7OUjz3xfdYpHyb+qn0aeWTeQx+
	t75sZlh/K7zORMf5zvkgv0wY75CZ39ybxM2CMCSyZJkBEehEjUAZKCtH4I79Si1nQl9qDpDNnky
	OjZ669bvGVkYmvsz3vFJog37Mgx8uF4i3fFXqZBHbxdnprID2i50Lm3baApMcBvZR8OStZe+ssC
	z3vrzWtpdSxdLejbRNsySrU+ju5adEwWTGLDtGlOjit7XAuDG3SGym0kaOGjozlBQpGZ6sCaGzm
	Sq9U3Fj5F8GQ==
X-Received: by 2002:a05:620a:4015:b0:943:fe60:3748 with SMTP id af79cd13be357-9479f4ada94mr265600785a.25.1794285005889;
        Mon, 09 Nov 2026 20:30:05 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e734698sm136705185a.13.2026.11.09.20.30.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:05 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/lima: disable the recover work before tearing down the scheduler
Date: Mon,  9 Nov 2026 23:30:03 -0500
Message-ID: <20261110043003.56648-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

GP and GP MMU interrupt handlers queue pipe->recover_work to grow a
faulting task's heap and resume it. lima_device_fini() tears down the
pipes before freeing these interrupts, without cancelling the work.
It can therefore run during or after drm_sched_fini(), access hardware
after clocks are disabled, or use the freed lima_device.

Disable the work before drm_sched_fini(). Use disable_work_sync()
because interrupts can still queue it until lima_fini_ip() frees them.
Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: 2081e8dcf1ee ("drm/lima: recover task by enlarging heap buffer")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 9a1e6b9ecbe5..7a9ccca1291a 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -539,6 +539,7 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
 
 void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
 {
+	disable_work_sync(&pipe->recover_work);
 	drm_sched_fini(&pipe->base);
 }
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

