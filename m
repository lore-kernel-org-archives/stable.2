Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467839;
	b=L+dcOSQO4NIcpObm57PMgwBpAV/8yEvWwCH5S+M4gPyU4ycQpu9/nX7Qyn0c/ZISLtsC
	 vY3OjSvCZCU+pAnmxdpFGyzM7sotap+RnOODKGQ6nadMoY+j6kFZ/zRxxYugTA6DtMq/c
	 MfEVozk1oEtcDa2EjGFbe/QX5RUWARX15Uzykg5qSAYsldFd3d9nhNYQ1gcHwGZPTSRpj
	 Aid0PMCNus7+dto1EqJyf7n7nOc3lYfKp3yHNoJu8XjaKsVL/hIy844XCmxFe6UH9vp/F
	 J1ObVsg+DhXX4C71CPFq7A3wXVKLDbj/PJ4qLhbm5Dn319BO1Yxl4KLO9QmLr/xmTHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6AmciestcwpfVwikDIiE2zDRFZ72F9LqkNUf023WPXQ=;
	b=gqot/uCPGo0fypd9WpuB0+4kaC3pdo8TFEuNnoPxIWRH0DbnEWcdqsLLRhWjp82TdgcE
	 yRoBj6yPO3BxNIY4vHfh07tJEFxroyWI2EQ3Cxje6CzSrsPpuY/tBQ3Qqoy16rFYSglc2
	 pw7OXsbIL/gfMeF57EjuyrzUeOebY0BJbaBfETKBV1kkAqaUFd1moHwBoyswVsxXqg1ST
	 Uy/XNxRMx/XlUEtQslQpoqdvm0qV1Uoii8q0I5up6GgmgYi4ztH0ZgBOUMJJEbRUp7AKP
	 /hhjUwTzwjRm1FalLx7AH4GiYj7G6PieF1jXF2OMNRYTgso7n36z+mhtG4ysaz720Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sZHAOxAN;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5C606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF5C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sZHAOxAN
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d7791b00so8404045ad.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792467839; x=1793072639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6AmciestcwpfVwikDIiE2zDRFZ72F9LqkNUf023WPXQ=;
        b=sZHAOxAN1BuO0JlG7HTk7N+KXqwMFWOOiamBIhDs4927cLmxQDltvUisQmDK8bGlsR
         PyDSd5/G0th5kYOUdxya5QEWtHgAL436ziufvB3tYwCm5bwDM28yxk4qn4v81QEY2OgH
         w8KZzK8n3hyDxFX0dSu3H8IygRgA5IjhnOfIvtGJnDIQsRDMsm44LTIaz6oGRFeH1P3H
         dtBOoP3TBnGiJG9c3q/2SkjHqC6I4advxQVn8UezKs83HTYlzy3gmvROoZi6b9mQtZSv
         YHQ64Pc1hFwXQFn5o9D30y1RpsHF9Qg99oAmxCpDjc3zw9kyJcFSRKbIK4r9FUhluhuk
         j5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792467839; x=1793072639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6AmciestcwpfVwikDIiE2zDRFZ72F9LqkNUf023WPXQ=;
        b=BOXn/B0Y0U+ibAkWzksWfBJVXXX54N8eDugXKJagmMnxihqLvqf9wgh0V5iUUG81Yn
         CWWitYBMct7xeqEwddByTN3Ljh4wIeVTeniUacTGTQGBZl27AxPb2f44uKCagpE2E2AP
         VsCzltJtw1/YX0O7EDWfNBoR+u8HAnXoBomDaBl0vIxz/t0+6u1oaD311H/soJOtjmb1
         zcSLkBsMuNIli5rAvWT87+9VEmP2J79v5eMaVPbnePdfTeVhbTIfHNgdf+tGiTqYvteb
         LHcV/NfEAK+iR9T8oPM+fMgsz9EbYqduEtPM3S6LFX4sJhDcm5naETFT6rhR4bt3fJjZ
         Fk6A==
X-Forwarded-Encrypted: i=1; AKwUvByXoVw+R0qV/Q4YC4FoIi88g5ZphSztd7KmM8lSbIpAlEo9w7AzYDbQ47SmD6re+vXyuai0bL0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZmINvP0mec8r6tpeGNJZiTlSl5KuduWZLmD2PvBoaUyYxNay3
	NSH22Cj6cb2yQyh1XifeqmBp/sg1rG7cLdwIvmQlgVKKNJ6b9D6Fw73H
X-Gm-Gg: AYBFou0+6sKh5eXZ3gdTRaZV8SsDxs4nVWAzdIuDGonI+/5BhWlRSU2idGG778tZA+g
	XG3YaWpUdVIb4jpvPQjAMF4h6bY+seHMpWy5991nJk8d9tHD4eFLdyYSnVHG+IM/kMjBwq/a/70
	wqqM1Ugj9ayKaSukoNq2b5sku4YENIsRgjJ96+2wzVpJGnHkx2GZjkZg5HnwCjl8E0gbYm5dGi5
	dDPBdOHs1qX+eDUtwnRHY4Ps91//+U0+CWRRz5g5n1DPg/XRVKvX+2blFr3xnlq8yXTt3VQl4NZ
	VPqmrB2wx/YkNaGeFv/2/XsuzVEVASh8OtLYQYPRgoCHFtVZ5O/4ZKUqetsZ9nuT1PNpJVswY14
	97MW7Buhy1TPm6Kg736RYUgbzy6HoD4inMT/377igwX5dx0XbpWN0gn7Tp0B3Z+j9BA4ofGxM7r
	K3ftHXhnX9CNYTLEl0QQBODWjIDQgtUwLcXE7jwqGuAw8N0EPmsBDDkXeFdRmIcfCknQ==
X-Received: by 2002:a17:902:e844:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2e9a6e558admr80578225ad.47.1792467838712;
        Mon, 19 Oct 2026 20:43:58 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea14caa857sm8143885ad.12.2026.10.19.20.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:43:58 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3 0/2] ocfs2: stabilize dentry names in file-operation trace events
Date: Tue, 20 Oct 2026 11:43:50 +0800
Message-Id: <pm-ocfs2-objects-candidate-0088-v6-d3056754af7e660155d9-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

All six users of ocfs2__file_ops pass a dentry name to its shared
__string field. A file reference keeps the dentry alive while rename
can still change the name being recorded.

Use name snapshots at all six call sites, as Joseph requested. The
first patch handles the five callers that take no inode spinlock
around their trace call. The second handles file release separately
to preserve its locked open-count sample while taking and releasing
the snapshot outside that critical section.

The patches are independent and leave the event class and trace format
unchanged.

Cen Zhang (2):
  ocfs2: snapshot dentry names in file-operation traces
  ocfs2: snapshot the dentry name while tracing file release

 fs/ocfs2/file.c | 97 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 29 deletions(-)

---
Changes in v3:
- Cover all six ocfs2__file_ops call sites with two patches, grouping open,
  fsync, read, write and splice-read and handling release separately.
- For release, keep the trace and open-count sample under oi->ip_lock while
  taking and releasing the snapshot outside that lock; cache the
  event-enabled check.

Changes in v2:
- Replace d_lock around the tracepoint with a dentry name snapshot so trace
  callbacks run without the caller holding the dentry lock.
- Pass both the name and its length from the snapshot; keep the event
  enabled check and release the snapshot after the trace call.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0088-v3-d628f98bfcb6784a0bfb@gmail.com
Link to v2: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0088-v4-a9a0df898afb4fc65fa0@gmail.com
