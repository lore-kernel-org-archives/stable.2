Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413922;
	b=aM64dEn10kup/+pPP5k3CFEyhZALQJajI1zCLjZ3S7Y8C0OXWAeUskKlZIvQ/3zaXkS8
	 dC10K/DdFQ/tZFkKLjBvuy948Lb+faBOd4lcPT1U8GXv6qmxwiuvuwYNbiF11CUB7pExi
	 Ub0aQEfC8/FJuqN24ht1SdrZx5p8+fx2RBLsnlUtX0pVUsCKPVwh/A7Ur1JU3sd1uj0jv
	 41i5TXTAeCVV9W/nPd4xQo58aSi59qObQ8aC4TyFAqi6K5naqEFwwbgLa469Q5xBKEHil
	 BHhQXLRH5OrTBmt1qSFEc9ypVnt59uVXoNuw3HTdcT+/lBoz6u6L8j/rfSmQ4cQ8P2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=izt2/XobLLqiqgA/+J+pbNOAtloWX7VwrLq7qFAm7og=;
	b=nPW/cPqlUQYzBXt6w9D3zZAz8Lu7AUVHjFPAEXWVxwddsuIT6PZZRnFXSqlizbo6EOxm
	 d+mERWQRz5vnOSyYv4hb6nZNFVg6yPQ+JaRU13jUuTPrXJK2uNSQmxIEz+UHK3wUrpoc8
	 LvgxwiaojdBqkrBY65QCvdCiop9h2IooT33lLaPqb+isW9l8N9y8p4jiEsGKp6m4D8TjN
	 a6Yll88mYOPbmh6NqONVi0FwmEekwQDZ12uDi24C4nly/cunytSIk0vhZrwBFYQLIrUYe
	 MvpSRA9M88/rxb6FbP4NtSQbZeWshzJ0fGZKiqgljkraOWPfMiqu5oq/wogbWWgcc7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=h6ew7d3v;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A0460A2638
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A0460A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=h6ew7d3v
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so41822575e9.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413920; x=1795018720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=izt2/XobLLqiqgA/+J+pbNOAtloWX7VwrLq7qFAm7og=;
        b=h6ew7d3v9vf+Kt4CULQmOkrk+4e7JAubTLtfJ7E/tSjtsBGHL9SF6ngarbtIfGRi7h
         rbsDjhgtddpXtFjcd+ySROzj/rbNWdonvsfTizLLb6dxcLjM9g8F5ouUxNL4tqzr2QYs
         GxbdA1+axsxLjLiS8/RT7IhwkPVQR9S1LKgbiaIeE4pchX7GWlYu/XGnhl6ZZ0BPf0EI
         yb+6CIhhZuspDWtoCpycFnQ8v2aYnTIKQvzuWY58Sn9avpw87EMnDUUXYRauoRgQEdIh
         jNL93vujq4WplSxed1q7pIkgDzIkQvjIvCjEhF062CPfzj/rwNwiSc1hA45Q22s7oWYI
         a5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413920; x=1795018720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=izt2/XobLLqiqgA/+J+pbNOAtloWX7VwrLq7qFAm7og=;
        b=dDapCOiftHvla1fmSgcn9EKt0TdLw1Grw+w0bDBpfZVOYEA1yjMfAoR7zKRVXBC/PE
         gerWcA3S6DRgMscxWuhfPZumEU1KCQoy7vACzZjpuOxQZ3ETAl3TZ8wUKsvrgTVFiB14
         0JHpp9GMRZsgxuLYHzNAnosA/89Sb78ZQ85ZJZUFSnbLUlPv/hXGL14fRNZEobIVciMV
         XkvJ74d+QARwxyjrBp8opkitFY+328Go0ry0w8mICWig5Ren4kHAXOPQG6mrbLArm+Fy
         USpf7c8QaJW7hDaeeWJdISl8EyzlGiGQjElvbBhhWG5PcyonXZ9Qt7xUx2NuAZL1yr5p
         JRwg==
X-Forwarded-Encrypted: i=1; AL+hErEi8DhqE/3ycQmyVFY2bIKqk5xX77cV0+JkmszAjIhsfMcTMpWqFCSRMPR2EC1vLVh6gS27AwY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9usio23EQ5A4iv+F36hGY5cEZzoObOfuH5UqRnqFTxjKAvKaxU
	0SW6w5Kty+JvEo/F8KMuArqKUw6RJNGxKJIHxGGuzr3z8FaDjujAQXKbJdaqkRdE8dw=
X-Gm-Gg: AYBFou0TIQlqlLEPJwE4q/6sPI07ZWV7C4pm2zSlbJmZgaR9CxlG/+wZGrn0M5YcWIs
	4MgXJ4OQl0ol4vAR1RT2YyXYts/cm4upE6cW2qW6hCbMOebD3FuEBZwteOC13G4vQ1N2U/jb7rO
	3DZ4zIvSfGoEWtNGtkz07BAA2Emjqzyb7AeeZ/ElJVffDUmffqa7Jzm/YssJb4eEYH4TqQNr7aI
	pJf6BgSi1KWGs+GdxlQt+ua6wAamThXNVVLEKJeIfQlMy6GEFPmk9A2QeMVJUtydiovRwHN8XPz
	N2JTZhp+2P5lKgwPZk1cNk+VZqg+MsZUtH2MwtXz5slQwknkQLEgHbToahJ1WvOKZ9oMhwHdBFO
	XphGJUZHU3CTF8TqKDLyb8Y3W/bLSbt5taG3CEiZgIVGvsTS1qlb2QovXSl/pkALM5MrCFkIjFe
	OZS1tLa7FILMRZd1lT1xYVn59ZbCZPPPZ8+pATftjnzRFCXNXGB3iTxKpYlklVgFYkrw2xNff7V
	TWEiwLiK9YJMekknt6L7e/S+8usbkIO6cPk1tDGEWEIcSITKaErVrZRvsgDysBxFP/aktx0qk2q
	ZG+LBmuftz26vpwtAjKQTH9PyMGiDui2jRR/K/1eZskJ7xEulf92D7MspdXeCdWkRzHynwFwcQC
	n1dLvgbSjlyOnAaIh57u3TB8SNdGUbg==
X-Received: by 2002:a05:6000:268a:b0:48d:ee35:b3fe with SMTP id ffacd0b85a97d-499c57838f3mr4997398f8f.8.1794413919771;
        Wed, 11 Nov 2026 08:18:39 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:39 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/9] ceph: fix mdsmap use-after-free in mds_peer_reset()
Date: Wed, 11 Nov 2026 17:18:26 +0100
Message-ID: <20261111161830.1336485-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

mds_peer_reset() reads the MDS state from mdsc->mdsmap without holding
mdsc->mutex, but ceph_mdsc_handle_mdsmap() replaces the mdsmap and
frees the old one under that mutex.  A peer reset often coincides with
an MDS failover, which is exactly when a new mdsmap arrives, so this
can read freed memory.

Read the state while holding mdsc->mutex.  The messenger drops
con->mutex before calling ->peer_reset(), so no lock is held here.

Fixes: cbcb358b744b ("ceph: skip reconnecting if MDS is not ready")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a43ce23d48f4..aa4406fd65b9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -7300,13 +7300,19 @@ static void mds_peer_reset(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
+	int mds_state;
 	int rc;
 
 	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
 		       s->s_mds);
 
+	/* ceph_mdsc_handle_mdsmap() replaces and frees the mdsmap */
+	mutex_lock(&mdsc->mutex);
+	mds_state = ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds);
+	mutex_unlock(&mdsc->mutex);
+
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_FENCE_IO ||
-	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) < CEPH_MDS_STATE_RECONNECT)
+	    mds_state < CEPH_MDS_STATE_RECONNECT)
 		return;
 
 	/*
-- 
2.53.0

